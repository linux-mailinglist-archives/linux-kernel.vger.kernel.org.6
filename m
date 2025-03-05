Return-Path: <linux-kernel+bounces-546068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCA6A4F5F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CB2188B241
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E9B1A254E;
	Wed,  5 Mar 2025 04:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbNmZf2r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9C1A2387
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 04:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741147749; cv=none; b=TR1Npx593AJIjhOa6wnQeR2qHgCifH8u8mO1DsO1owNxiqtm5SieoJNEexJtNcAZyF8UjcdpQal13kbOoJMlWFRRuvfLgL2BepCCs4bZ8l3kU6xYt42tvKJ6gUP3JM5J2Y0e99z9+pd/9CE4od01MZEMFeBuMtfh6RZ8t0dNCH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741147749; c=relaxed/simple;
	bh=sl3kF2jIRgykOyy13qNEYv7/mlV05yVeWOFjVH+qAtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOYDAQtuUTkRaeubBP9Dr7IsmgcuTQTyO1HGR3akQ2J6FEKlKC7nRhC+2pQ3IlM39j+TYcz09LIT23Yx4LRpxQqDtwoj+Sz4a8qEhjR3HV2mugDzq3vweBJeVwV/MOlb4/6PV+8JDOg3bmx5vbFAbdrRVpzTsb5HiGvXuligzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbNmZf2r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741147746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sl3kF2jIRgykOyy13qNEYv7/mlV05yVeWOFjVH+qAtU=;
	b=NbNmZf2r921zbEZwyXv5e6IrB9J4OhSlKcZO34ynbPW3ruM/yXPnCv1TvIWA/tbkJn3ACW
	hoOiliesFY4wcinhSG2AerPctf/wtswbCw6SVALSyjr6HUXTZKjM+BzUC9bvpnvbyMLNzY
	thbJbkoPG+4C72VYAxpU4TEupt5lLHI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-lFKl9_WUOCmJovxYcQaykA-1; Tue, 04 Mar 2025 23:08:55 -0500
X-MC-Unique: lFKl9_WUOCmJovxYcQaykA-1
X-Mimecast-MFC-AGG-ID: lFKl9_WUOCmJovxYcQaykA_1741147714
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2feda472a4aso6861953a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 20:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741147714; x=1741752514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sl3kF2jIRgykOyy13qNEYv7/mlV05yVeWOFjVH+qAtU=;
        b=C5i1vcGg2e1r4Jkr3exXM1NukyozOUGgvWM4TUbj5i+EKqdeLtIGQHJaAvtYUzPV8o
         SVWsXkE69dDysAJ2Qsd7kK2Z5oGQD8Agejn50aR1tE+AvgFtXk19uTWad8lqFC9deca9
         PtZwyn83eEv0DkbRI684aFpm2SEClaQP4cDuFEJeZNxqWrTaK6wXKcaXoqUhJfp3qO8N
         SjFjOH/29K9jNHsldwXQ/88Ssp/t+NSO62Xiso7oyM/yF+66Q/j8a90mfOt5/a2qp7pZ
         MP5QNiQhxsAmkSZNA+86zArnB8ItdnMHRm1O1wGP6gLrYhF4s8ijgGghyeJ7KmJizbIU
         nRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0zP/kEhJBhJf95wE9LVKNaROsF0tEzH1h0gg7UBFVnVVusHa75p26hkl53j+RGraobOFO+yNN8KZSAFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6JsCLLSooAYgO+Y54lqCrMbN1N1hKF/AODOePTYkTjUq0YXL/
	6I8yIOE4tOEvevaa0oGfKrqLtTeSLYB99VHM3zxIprDC8QdH8jQOYpgvQGYykVKryhXhdK2xx3F
	grWe5nNEPy82G9yMCiiekePqb7OPBLty2GGiC/D2VP+lE9iK9ZOnM2jB+C34CK9xFwXjo2fDIEY
	iAzErNyVQQcrWzjji6RFPc4O/PtDllr9YHNjIb
X-Gm-Gg: ASbGncsH8FHxwdDuhr82Mp5nAWYjs3o7vbOLo4SSv77aPPybEt1U4VZmjROkWDmEiv0
	NDnPEkWHIEGYBLqt4yRSAS82aXbPFNyXB3d7heN3NFCLhtGSHYLTkX5Bf0IVdBD2IlkCroHizpg
	==
X-Received: by 2002:a17:90b:38c7:b0:2ea:3f34:f194 with SMTP id 98e67ed59e1d1-2ff497a94d1mr3253879a91.10.1741147714159;
        Tue, 04 Mar 2025 20:08:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRhAjiy6oJgdTVYVOYk9K5LcroQa6MmEtafp7KA+t5KO8Pe7O1jHU38xtYt3z4pO+pz1vuRaGm1QENB3uSDNs=
X-Received: by 2002:a17:90b:38c7:b0:2ea:3f34:f194 with SMTP id
 98e67ed59e1d1-2ff497a94d1mr3253847a91.10.1741147713755; Tue, 04 Mar 2025
 20:08:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303085237.19990-1-sgarzare@redhat.com> <CAJaqyWfNieVxJu0pGCcjRc++wRnRpyHqfkuYpAqnKCLUjbW6Xw@mail.gmail.com>
In-Reply-To: <CAJaqyWfNieVxJu0pGCcjRc++wRnRpyHqfkuYpAqnKCLUjbW6Xw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Mar 2025 12:08:22 +0800
X-Gm-Features: AQ5f1Jr9X3ymlwY6PrZDcvmZUstskG7PfMhNEYJbHpQgXjCqpakU8L3BFGy8d0g
Message-ID: <CACGkMEtycEX=8FrKntZ7DUDaXf61y6ZE4=49SmQu5Nkh_tf39g@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix VHOST_*_OWNER documentation
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:29=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Mon, Mar 3, 2025 at 9:52=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
> >
> > VHOST_OWNER_SET and VHOST_OWNER_RESET are used in the documentation
> > instead of VHOST_SET_OWNER and VHOST_RESET_OWNER respectively.
> >
> > To avoid confusion, let's use the right names in the documentation.
> > No change to the API, only the documentation is involved.
> >
>
> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


