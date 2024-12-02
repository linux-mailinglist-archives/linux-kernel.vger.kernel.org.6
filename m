Return-Path: <linux-kernel+bounces-428135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F539E0A8B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870A4163AE2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DDA1DDC19;
	Mon,  2 Dec 2024 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRgcjh1s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53A01DE3C8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162321; cv=none; b=buGQ99ZXj7I7UjICLHDZqtUcwkFtmTJgrfuh7JVmqOrqEOV/8xSkMatkCpG0HSLqI9AFwU+ZLTSNoGhyKBihLo6P9Zf7+er6FvIcbvBdooXycW+07AdXE37c2NDZS+uB1io3TxMCvLLGwJTbIr6PEqeZxSRj4Sgn31lf3D7G72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162321; c=relaxed/simple;
	bh=KAQmNGIcYmeP6enNHLfOl2z+OwwM0Hl+Xchaz0Ai14Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pv4LeUIwQAVuayzzJdO8O2qNUS0EmTuSRLcpH7Elusql/nKcPaQNZgthmL0jTNqRZjO+Aw+KT+vmmX6uPyRKuyVVvl0TAdKPICjEMIDhimbYIowrizE/9GTNKDec8kg1EewkCOHHMT5VmW7mwuROknam0agMcJDTy6bYEOLuFrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRgcjh1s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733162318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ysVE/b7VFhQ7J1MKW1ticjZrirLqozxpmCZg7yZDelQ=;
	b=bRgcjh1sGyz1KfmcmHBzRk3S8FPpv3TCbX2XyfhAAAPQD0CZk/l80hwI8o8J3UsRYZWdhP
	mMfW8tWfomB5j/eYNoePxszvxpfYjix5jwOdZubRHooaEAaC8WlT4BMb1UQPQzKGe8dDYl
	tNg9fI9sUoSEUQevsaRazgYnYYuptXI=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-V597KecWNCO1tMsS_qpHvQ-1; Mon, 02 Dec 2024 12:58:37 -0500
X-MC-Unique: V597KecWNCO1tMsS_qpHvQ-1
X-Mimecast-MFC-AGG-ID: V597KecWNCO1tMsS_qpHvQ
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-71d53a3e872so140090a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733162315; x=1733767115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysVE/b7VFhQ7J1MKW1ticjZrirLqozxpmCZg7yZDelQ=;
        b=ZnkjlfkIlW5ebxQX1X9m+Adzn3xoZDNGyYazhbf7ZufXODmQ+MgwazYamZXyKI9w/1
         LjQq49F1vkpmprWKKIu6lmS68XwZLn9KsmLYyfba981wsKrJ04RelbVLJEKHSBVVJEqt
         OR6jnQeSfE8Hfn5cb8dzUbH5TpCCFbWa6ad/IrHEMF07B/2vr55XxTWMQkRXl4Lcipk5
         qpwdObT6qhMEeIPj0/YKNsxAKkI1g5qgpsGeEufvsgkCDPRdu181cyEBegDW8nlWs6OU
         ZQW0H9jx8mV/OpR5wMOPHWHyq1Z9rtU9rEiwjC/fm8YHzuA/ioZFF5efcCnUr/ETwMy8
         LOow==
X-Forwarded-Encrypted: i=1; AJvYcCUm0L/oZt1/qTgYEUMbxf5K8PIBH67U8Cl+agdiSy4y5kSNRNlANAMyILQbFSsKK1OwqbdKLkAexNiUR3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBIa3oq/X3Y8X0Piaoclns2kRwj7/6eQENOSP1aZm2DYJagjWQ
	oxUE0cRLggG+jbnsfUwfMy+0+5hWn9Ig6fBa6WBWR7zv5ZwCGDLaRrC6rQf74vdh/lCE6+EGOiH
	LvjzO7Jl5yD/mMnNj9aLl+M74s5wM8v/M/Myg8kbzyJE6beGAoyAHBLXULmBmGhtI3t0LaTycUn
	U5fYXBnBd5d1mKYucs1s3/fyWPU3jIJzguR4MB
X-Gm-Gg: ASbGncvmLGfbDcVFGY2kSh0kMKRE/S1YsQK7x7HDEEgN/3T2nzvGv5MPI1AJsnLyYHv
	8FGz2EDelznQ3PS1/7dF2EL9mQe4SJBg=
X-Received: by 2002:a05:6820:54f:b0:5f1:e1a8:ff4c with SMTP id 006d021491bc7-5f20a11ffd6mr4647967eaf.1.1733162315154;
        Mon, 02 Dec 2024 09:58:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRrEUCQzc2sF56HtwRIiUFHExQx5HfGmbzXQum4Beo8EaJSN4MsPzVCoTxvOLVH0pHaAF/mnt8hMSNbjEbRmA=
X-Received: by 2002:a05:6820:54f:b0:5f1:e1a8:ff4c with SMTP id
 006d021491bc7-5f20a11ffd6mr4647957eaf.1.1733162314851; Mon, 02 Dec 2024
 09:58:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202163451.1442566-1-mschmidt@redhat.com> <Z03mzf2R925FVEQm@mozart.vkv.me>
In-Reply-To: <Z03mzf2R925FVEQm@mozart.vkv.me>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon, 2 Dec 2024 18:58:23 +0100
Message-ID: <CADEbmW3pO25mCqzzrfXdZrWg0XDaBsp_RpiWhT1hmC3GKkZYUw@mail.gmail.com>
Subject: Re: [PATCH 0/6] pps: fix a UAF and clean up code
To: Calvin Owens <calvin@wbinvd.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Ma Ke <make24@iscas.ac.cn>, 
	Andrew Morton <akpm@linux-foundation.org>, George Spelvin <linux@horizon.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 5:56=E2=80=AFPM Calvin Owens <calvin@wbinvd.org> wro=
te:
>
> On Monday 12/02 at 17:34 +0100, Michal Schmidt wrote:
> > The 1st patch fixes a UAF bug. The fix is quite minimal, although a bit
> > ugly. The rest of the series are cleanups in the area.
>
> Hi Michal,
>
> I've also been poking at this, I've sent some patches recently:
>
>     https://lore.kernel.org/all/a17975fd5ae99385791929e563f72564edbcf28f.=
1731383727.git.calvin@wbinvd.org/
>
> The major difference is that I used __register_chrdev() and removed the
> embedded cdev too. I think that is cleaner, what do you think?
>
> Thanks,
> Calvin

I agree. Let's go with yours.
Michal

> > Michal Schmidt (6):
> >   pps: fix cdev use-after-free
> >   pps: simplify pps_idr_lock locking
> >   pps: use scoped_guard for pps_idr_lock
> >   pps: print error in both cdev and dev error paths in
> >     pps_register_cdev()
> >   pps: embed "dev" in the pps_device
> >   pps: use cdev_device_add()
> >
> >  drivers/pps/clients/pps-gpio.c    |  2 +-
> >  drivers/pps/clients/pps-ldisc.c   |  6 +-
> >  drivers/pps/clients/pps_parport.c |  4 +-
> >  drivers/pps/kapi.c                | 10 ++--
> >  drivers/pps/pps.c                 | 94 +++++++++++++------------------
> >  include/linux/pps_kernel.h        |  2 +-
> >  6 files changed, 50 insertions(+), 68 deletions(-)
> >
> >
> > base-commit: 7af08b57bcb9ebf78675c50069c54125c0a8b795
> > --
> > 2.47.0
> >
>


