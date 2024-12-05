Return-Path: <linux-kernel+bounces-433287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015FD9E560C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA391884C3F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92702218E95;
	Thu,  5 Dec 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0Rv4roz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30731218AAD
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403463; cv=none; b=A5qddNjTPAXSzmwxt7pQoFL1PcztI07xOIotBzQkVN6ydTqU0pZibKPVIvG5CvicENPdIUsfgo1DXKYsJ2/84me8tQbvqlFtoQCb81VN9fvDfMYOzMgXhUpZm6aNbbPPIMbVWdHm3u8jMudVrqnCsF6d7+rCGy+dRDaL6IEuNOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403463; c=relaxed/simple;
	bh=1xpVZNikkLxPIpkkXLq0rqIATBlPYhijyahqDJFmbTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OARCX2V3oIeKYrWcJHNVVoDxxzaIV1Dy9C23Syc8sTAyDzSUJAm08JprECoiDBPIvlofDT262f26d51Sf7UvV0ha8WuTUuqeHPnFj2pIbZJ/SwmZQ39SLxruhdA5fNQXcWJW8i6InFH3pDiWraypbcndcupyBzAw8OSf6EOS7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0Rv4roz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733403461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ot7XcBFSegxFnsEWFIWT5T/J3rPFJxtVYqEbfcPpFpk=;
	b=U0Rv4rozEeeOIZW1zqfFbC4LuZ84UV7gp49+fhmj2eTIzl98OKOIVuNHIJhPmPSKriro7q
	2nUC9miXRuNexkgctRnyGvzBju5tX6IvtSoLEcIYI4i3zpagtYREpR3XK+ixUNPytqB6Wt
	ytkbbFqx0+fZUQGMXzLGChoudgHBOfI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-CTkrQaCHOQCtT-_86OMK3Q-1; Thu, 05 Dec 2024 07:57:38 -0500
X-MC-Unique: CTkrQaCHOQCtT-_86OMK3Q-1
X-Mimecast-MFC-AGG-ID: CTkrQaCHOQCtT-_86OMK3Q
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa62023adcaso69255566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:57:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733403457; x=1734008257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ot7XcBFSegxFnsEWFIWT5T/J3rPFJxtVYqEbfcPpFpk=;
        b=iGtHBpk4TM1jPCGbr1GXuRiVoEPyUtg96t3j+2ieZU2s3PiCvNWHjKOW7/0IDK0saz
         PvKJqCMB/OIFpavgVAsQMw4VwG+YDLFMHEg1ObfCcZ3YAnaQK51NzP8Pj+IiLuxvhUMr
         0Gzw02FXkp4tp3SFZLXRGLkEozjnmnO7dxViZRXRg97QlbV+q0d6JJC40+WvqKhC5gOj
         cGBxDQk3Zo64wWXRH/SUdSf6RNLNh11nDh9LkoWdPt6fz+GaFTLusqtkJFFNu1R9c4uf
         1rLgAOJ7i0+zbpDUYXvlE+FX2z2ZHt0lL8Ikzfp2dALaWgQ6hmoBgHeRBAceMVfitdHj
         DMQg==
X-Forwarded-Encrypted: i=1; AJvYcCX1/liZtdMm51yqrpinGGwzJ2wVLiJcqX12EHG9oiTc1aziR63uYWdjbxxLawsKsCLQNbrJlrgY/+0ird4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+o0dZD5ebbXXGLKWlufl2Qydy4Efjih/iKyDvVjOAAzBoM6cX
	8XcvxU1ooZjFvCnNz8hxWAJjXA9EMkvqvblB3xeIz/MdMm5EhNT501jYvGdFKr1terdRh8XVjEx
	5KI4UUeJxPaN0mcuCzVpZu+7uH2CoE26+BpRLIIutxAftMzTfnkrefX9l3N6jFcBhmSb2gYSL29
	gRJwMUCCK1OBV5NZcNZot+WAHxhgeTytmqwCnl
X-Gm-Gg: ASbGncskaEbMpWGAvBgqjyJhbmHzMXpfxBxSbhacee2chPHK88WO8KXPTwt4KhxT627
	M5WUuXfhgiojQHH224sHZwwhcjFg2UIzBlQoQtJ/mNOFPD6A=
X-Received: by 2002:a05:6402:e0e:b0:5d0:d3eb:a78f with SMTP id 4fb4d7f45d1cf-5d10caa018amr17290134a12.0.1733403456803;
        Thu, 05 Dec 2024 04:57:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFgV8uME1/aUFGWwOlbZd9Dn/4rzI946nZtSCbX2ZqN9RTqCIfBOcwmQbs2px7IIYr9m09QSNstPqU6DEOlOM=
X-Received: by 2002:a05:6402:e0e:b0:5d0:d3eb:a78f with SMTP id
 4fb4d7f45d1cf-5d10caa018amr17290075a12.0.1733403456496; Thu, 05 Dec 2024
 04:57:36 -0800 (PST)
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
 <CAO8a2SiTOJkNs2y5C7fEkkGyYRmqjzUKMcnTEYXGU350U2fPzQ@mail.gmail.com>
 <CAKPOu+98G8YSBP8Nsj9WG3f5+HhVFE4Z5bTcgKrtTjrEwYtWRw@mail.gmail.com> <CAKPOu+9K314xvSn0TbY-L0oJ3CviVo=K2-=yxGPTUNEcBh3mbQ@mail.gmail.com>
In-Reply-To: <CAKPOu+9K314xvSn0TbY-L0oJ3CviVo=K2-=yxGPTUNEcBh3mbQ@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 5 Dec 2024 14:57:25 +0200
Message-ID: <CAO8a2Sgjw4AuhEDT8_0w--gFOqTLT2ajTLwozwC+b5_Hm=478w@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will explain the process for ceph client patches. It's important to
note: The process itself and part of the automation is still evolving
and so many things have to be done manually.

1. A patch is created and pushed into a local testing branch and
tested with xfstests on a kernel compiled with KASAN, several  static
analysis tools are run as well.
2. The local testing branch is merged with the `testing` branch which
implies that all sepia labs teutology tests run on this new kernel --
so care must be taken before pushing.
3. The patch is reviewed on the mailing list by the community, when
acked Ilya takes it to the main branch and eventually to the upstream
kernel.

I will break it up into three separate patches, as it addresses three
different issues. So that's a good comment. Any other constructive
comments will be appreciated, both regarding the patch and the
process.
I didn't send an RFC yet; I need to understand how the other two
issues were fixed as well, I will send an RFC when I'm done, as I need
to make sure all root causes are fixed. I prefer fixing things once.

On Thu, Dec 5, 2024 at 2:22=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
>
> On Thu, Dec 5, 2024 at 1:02=E2=80=AFPM Max Kellermann <max.kellermann@ion=
os.com> wrote:
> > - What "other thread"? I can't find anything on LKML and ceph-devel.
>
> Just in case you mean this patch authored by you:
> https://github.com/ceph/ceph-client/commit/2a802a906f9c89f8ae492dbfcd82ff=
41272abab1
>
> I don't think that's a good patch, and if I had the power, I would
> certainly reject it, because:
>
> - it's big and confusing; hard to review
> - it's badly documented; the commit message is just "fixing a race
> condition when a file shrinks" but other than that, doesn't explain
> anything; a proper explanation is necessary for such a complicated
> diff
> - the patch changes many distinct things in one patch, but it should
> really be split
> - this patch is about the buffer overflow for which my patch is much
> simpler: https://lore.kernel.org/lkml/20241127212130.2704804-1-max.keller=
mann@ionos.com/
> which I suggested merging instead of all the other candicate patches
> https://lore.kernel.org/lkml/CAKPOu+9kdcjMf36bF3HAW4K8v0mHxXQX3_oQfGSshmX=
BKtS43A@mail.gmail.com/
> but you did not reply (as usual, sigh!)
> - deeply hidden in this patch is also a fix for the memory leak, but
> instead of making one large patch which fixes everything, you should
> first merge my trivial leak bug fix and then the fix for the buffer
> overflow on top
>


