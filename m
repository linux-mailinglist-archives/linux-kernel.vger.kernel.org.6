Return-Path: <linux-kernel+bounces-433216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55A29E5539
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7822B1881415
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531A1217F41;
	Thu,  5 Dec 2024 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeLkaPvp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59021C3C03
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401048; cv=none; b=okU4msmdrw+yBnsOgIaNmgTnvfM+Ym1bm71Wj+DSMUDCIqOwJCJ8dv/N9i4W1NcqYv3XZhdkuP2ovpQDVSAa4JOjgXshHrQ+werLcHLycn3SpGd1UKrhlBKeq7UtgRvjKeq35W03IY01bxEwmLD2O/qOWu1tUEzCsVVpsab5JRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401048; c=relaxed/simple;
	bh=78ORj5MT7/pCML0JdAvmPGsZjpcS39rBDcRK9aTcAp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjexOZzhjBOJWgfwQ42jalDjmODIHtUOIxsx3/Ur6apwPMETc9ONgsoiupTX0XIW+vwb1tVnxm0WHnw9uJhTUse9glQZmcdEnAerdMckWHAhQgB5DTGZJOlfEO8KxA4gKZCYBepjAWvAfLHK8zXqGp0ZqL7yN/SzsuqvQScYxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QeLkaPvp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733401044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78ORj5MT7/pCML0JdAvmPGsZjpcS39rBDcRK9aTcAp0=;
	b=QeLkaPvpPMCRRHOJr292N0j6riHah7a4EeAcdSfU1AX40rnbXwuw+ZJ1vN80AK1wctBI88
	xE4RHpyUsyqBBCjzZ2PXjehuARXny38+2KFGkWUzoPcK2tx5jaZ5oxjfCQQF0eZtw4mbdj
	Cxy47XQvHGkAXWDDfzPrcwAR0fw1a00=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-xMsrTvZPM9Gitl_nA2LFWA-1; Thu, 05 Dec 2024 07:17:23 -0500
X-MC-Unique: xMsrTvZPM9Gitl_nA2LFWA-1
X-Mimecast-MFC-AGG-ID: xMsrTvZPM9Gitl_nA2LFWA
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa62db80985so20032266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733401042; x=1734005842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78ORj5MT7/pCML0JdAvmPGsZjpcS39rBDcRK9aTcAp0=;
        b=h/D2gCOrXKE4tu+5ZrH5r4lLPDgsVTsi856dHscQXBchdPTjRV+6a4qG9H59bsfK5u
         iN5FEeJRaUJpSyBa+I34U3jjYzlZjh6prgczbh3B6AijEC2oE0847mij6CvZe+h8VxAu
         2zUP3qrq2CqQR/ByN/VkeMTeYtrQDq7doS7JGCYAOftvQCwIYxi5BcCSL5Y21Tj0sCeh
         vS3cqwP90crz924d42rFZbEtV2l92FzHd8a2cvtM5mFgvLmjb6NoF2kd9RzEHEfSpndx
         1+CTwZCX8L9d6SsXY0mP6T5fvvLeNdOdFtMGoyV/H/ru6J/mVVRAQWDruP2MBmiVEgQc
         Wksg==
X-Forwarded-Encrypted: i=1; AJvYcCWKpddYAuo4kzsG4c7WVksyCvbfhR6gP4EcogF9Lh0pXKcHeal2C6+aSLv1TJ5+ZwhJEFA9u6f+jqrLugM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7QfRzSXr5EbHTARNEtSyiiUYAZY99rzWLZhJq3S1DhMifOG+f
	V5SHwR/H7W9yakqrEC0SLNHgpZotQbc3z5wv5xy+Uf479qJCuKEiByl+1sipoolcd8QGD4E9WJv
	QpA/0b2Dxpd3VNhh+vqXqlVKIC4YswnZ5rBcadrSNlXMEGapdMv8KmQ5hjPKzq4tVE2n1YVtz4v
	nSvYEeCwzHla9Zo1M2RwTiXLzT0U812ULedVzX
X-Gm-Gg: ASbGncuePNokVgb+f9h/uNBn5/fn+pfnN811XT/YugDV4xgp8Z9aPPWZFtt+ASLsIE5
	4ZncrLaVKCFy0E+otGK5e0/i86uUHcpcGFmfBFJ9ts0Cvc37A0A==
X-Received: by 2002:a05:6402:1e91:b0:5d0:a80d:bce9 with SMTP id 4fb4d7f45d1cf-5d10cb5bf71mr6852857a12.20.1733401042226;
        Thu, 05 Dec 2024 04:17:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3iXCeT32h33RCPB/Nuod7nzqqUOSinEmle6v0DZwf71ur+JzfVPYQboWjeRhNIDMCipSgjS8it6mvXG5oPag=
X-Received: by 2002:a05:6402:1e91:b0:5d0:a80d:bce9 with SMTP id
 4fb4d7f45d1cf-5d10cb5bf71mr6852840a12.20.1733401041869; Thu, 05 Dec 2024
 04:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
 <CAKPOu+8qjHsPFFkVGu+V-ew7jQFNVz8G83Vj-11iB_Q9Z+YB5Q@mail.gmail.com>
 <CAKPOu+-rrmGWGzTKZ9i671tHuu0GgaCQTJjP5WPc7LOFhDSNZg@mail.gmail.com>
 <CAOi1vP-SSyTtLJ1_YVCxQeesY35TPxud8T=Wiw8Fk7QWEpu7jw@mail.gmail.com>
 <CAO8a2SiTOJkNs2y5C7fEkkGyYRmqjzUKMcnTEYXGU350U2fPzQ@mail.gmail.com> <CAKPOu+98G8YSBP8Nsj9WG3f5+HhVFE4Z5bTcgKrtTjrEwYtWRw@mail.gmail.com>
In-Reply-To: <CAKPOu+98G8YSBP8Nsj9WG3f5+HhVFE4Z5bTcgKrtTjrEwYtWRw@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 5 Dec 2024 14:17:10 +0200
Message-ID: <CAO8a2Sio-30s=x-By8QuxA7xoMQekPVrQbGHZ92qgresCDM+HA@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The full fix is now in the testing branch.

Max, please follow the mailing list, I posted the patch last week on
the initial thread regarding this issue. Please, comment on the
correct thread, having two threads regarding the same issue introduces
unnecessary confusion.

The fix resolves the following tracker.

https://tracker.ceph.com/issues/67524

Additionally, these issues are no longer recreated after the fix.
https://tracker.ceph.com/issues/68981
https://tracker.ceph.com/issues/68980

I will make a couple runs with KASAN and its peers, as it's not
immediately clear why these two issues are affected.

On Thu, Dec 5, 2024 at 2:02=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
>
> On Thu, Dec 5, 2024 at 12:31=E2=80=AFPM Alex Markuze <amarkuze@redhat.com=
> wrote:
> > This is a bad patch, I don't appreciate partial fixes that introduce
> > unnecessary complications to the code, and it conflicts with the
> > complete fix in the other thread.
>
> Alex, and I don't appreciate the unnecessary complications you
> introduce to the Ceph contribution process!
>
> The mistake you made in your first review ("will end badly") is not a
> big deal; happens to everybody - but you still don't admit the mistake
> and you ghosted me for a week. But then saying you don't appreciate
> the work of somebody who found a bug and posted a simple fix is not
> good communication. You can say you prefer a different patch and
> explain the technical reasons; but saying you don't appreciate it is
> quite condescending.
>
> Now back to the technical facts:
>
> - What exactly about my patch is "bad"?
> - Do you believe my patch is not strictly an improvement?
> - Why do you believe my fix is only "partial"?
> - What unnecessary complications are introduced by my two-line patch
> in your opinion?
> - What "other thread"? I can't find anything on LKML and ceph-devel.
>
> Max
>


