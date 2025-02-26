Return-Path: <linux-kernel+bounces-532853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56E7A452F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2513AB275
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4892B218E85;
	Wed, 26 Feb 2025 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGw09wxK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7DC23CE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536193; cv=none; b=BshZeeiJUmpAwtZDvyTfRvz3eYPGagDb3twr4LPWDUbo3G1k6wI+DqUxOt8UmFOdxUJsghLDWdLZ8rhMHkF9dB2+YPEic9YiHiyhoGbLo6/LnPfDVMigD8hh4V+FEnDimrKXQ3tPA0DHYfBTAYVmjYjQD/HSW/4ygSC8DlW0EWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536193; c=relaxed/simple;
	bh=YlVpnj/gX66X00az1sfETkigSAYSYIzGfUGSuYMht7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9KKriwk9U12PRgvggAAI5j1+hoHOMzp+tv5tso49ViLmS7M3+PH45YiesGviYpIXTTcXZYw7Wzi/rxEnsgfCpNEE1CBh25wW/b5G85YslrlAWCyib1rZqLDXCYa1zqmM/xFWgiUm7RKkBOJmoRNooQfm2+XL5hnnAZB/ldtuHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGw09wxK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740536190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YlVpnj/gX66X00az1sfETkigSAYSYIzGfUGSuYMht7c=;
	b=iGw09wxKccKioqoIimFGFC/kS+iJCEnXxIE6QQPd9hX0U3AvT3YoaM2fWcnJDctAW66NCB
	dpY85CztCU0X4ANxr/ZicgYRca15aoifHeSjgEhQ0jU2Et+Hr5lmMfrcOgKxitpFgg+TsG
	BCGTaAhOq7xvbPfWqJvBURxj5CUzDi0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-8SwHFD7LP_yi-uRshAZfsA-1; Tue, 25 Feb 2025 21:16:29 -0500
X-MC-Unique: 8SwHFD7LP_yi-uRshAZfsA-1
X-Mimecast-MFC-AGG-ID: 8SwHFD7LP_yi-uRshAZfsA_1740536188
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e04de6583bso5941269a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740536188; x=1741140988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlVpnj/gX66X00az1sfETkigSAYSYIzGfUGSuYMht7c=;
        b=ZfjkUoL7oTTvXLVN7jiKh2569hQvQgY83+ULE2FmA0IGiNVBAl+7IjVZMkJmjdbf7c
         j5GpfK2GKpmbzSMNbimTt4A8H4H9HPGF7OobICj5/yr5r+vjZmWd74n7V47cilvRjPGW
         Od8Y4e8YhssmTIRRaGQ5nNAaHQZyYtJ2SrvbOS7HGcRZIVHLZ45RiYdEtl9JLpO2EKNW
         8YDe3YR9hE5wAkISfQv34vUH9lyD3mfBYgbMGIUnEKtODZLx1V7OqtfDTS6VquLJWp0o
         TiJrA+QaEn7Jy8VC6r0mJINF6r0wXFbpgsH2DH1VEALQ/zxYLFeF6201Z4KJFxzM3mb0
         VUiw==
X-Forwarded-Encrypted: i=1; AJvYcCVDiJ8W1PATlMzDWMioHKnME48qXdkqBdRpeqn1WQdhUFm0CrFCLZaka7fA1NvxnDa93lYBGTJ62DWfTbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCIbNGHGRufwZx0kELY9Woy0En/4h11byKb9fuR5yorggb90KL
	bzTXBuTcClCDRAqop4ZMEZJToG3UzqoZ9HMA3kbB43JYziC6CxtcE3MGCAHHcXjchGYYjWttlgm
	szsqwIFBokjCalgAugujfD1GXYMVyjvJhSQXCxgjYPquRFG1YEqGPIxdY7z28tk2yOnNy3pBSQA
	FT3BBBAqeQoSXutvt59RBQveGzfJHoPFhV10Px
X-Gm-Gg: ASbGncvMZnaKxS7dwOjZBj5myP9q+OA/1bSzMyp1aORyinG/O8QtAKfL2vrMti1cjzZ
	VhzW9J53uvtDbaqx7hXJbbnmS/KQHcuG/8jWd0Unh1jATcPgmcn9xNORe0ifIxVgUB23A7z+LSA
	==
X-Received: by 2002:a17:907:7814:b0:ab7:e3f4:51cc with SMTP id a640c23a62f3a-abed0dc9452mr553605266b.33.1740536188074;
        Tue, 25 Feb 2025 18:16:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhDcZYBxYTCIPyqQmJDzTI8escqv2G/xUepMmTfzT/MW2sRWZSvR7tUcN9f1IoR9eS9p/9t9NJQgWekG117/Y=
X-Received: by 2002:a17:907:7814:b0:ab7:e3f4:51cc with SMTP id
 a640c23a62f3a-abed0dc9452mr553604566b.33.1740536187769; Tue, 25 Feb 2025
 18:16:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-4-lulu@redhat.com>
 <CACGkMEt7bkpOXNff6Ve+3nR0xN=zzjm7qZNsZOV2HcnuGvVgig@mail.gmail.com>
In-Reply-To: <CACGkMEt7bkpOXNff6Ve+3nR0xN=zzjm7qZNsZOV2HcnuGvVgig@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 26 Feb 2025 10:15:50 +0800
X-Gm-Features: AQ5f1JpCVVTdAD7in4OYX8nBzFHVlW0XKfuEec4cZsngVbG26UwAUfOQRbaJMlI
Message-ID: <CACLfguUpbD2LMz+yn6zK16yto4X1UUjV_1dRa_VJDsx0fXmi2w@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] vhost: Add the cgroup related function
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:40=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > Add back the previously removed cgroup function to support the kthread
> > The biggest change for this part is in vhost_attach_cgroups() and
> > vhost_attach_task_to_cgroups().
> >
> > Reuse the function __vhost_worker_flush, but in this situation, the
> > attachment_cnt is 0. Therefore, add a boolean to disable this check.
> >
>
> How about just tweaking its value to INT_MAX so we can avoid this new par=
ameter?
>
> Thanks
>
sure, will change this
thanks
cindy


