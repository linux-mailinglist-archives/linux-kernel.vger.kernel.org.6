Return-Path: <linux-kernel+bounces-339089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9526A98603C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE5BB261B3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D78615E5CC;
	Wed, 25 Sep 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekoMzXkH"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2B919AD56
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268318; cv=none; b=LveWl+DqqZo/zpXmE2VjRQxPFgRJd3L4TaF5S/IqK+/so+lcmDbfU78SvYeQobun3yfklMdPuPSFOGyTLm6NDGg0NudRjHyPUrqxUhIWjZ/cITmVGgce4S6FioGbVQtPWDmIkGNCsuJbN0c6VLI4SqgUlCwnRy7qgD3nnWcCjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268318; c=relaxed/simple;
	bh=k0AiF50bnpiOAmQ9urTN24ot5e7VXx10pnsgOKAZjk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bytRsWjrPogZvJYi12I7Yg8ykGQyf45QO/2DZmETXLnPXnUv4AqLtRU1QqkKMOuEMsfGAg0cBrpuhiG8bpWBg08Dika2FwvDmwRO86rdMmt3rBQtxqLl93lC0HysOuPgP9SACmNd7XjlsQiXWd2ed+kuXNZk34GCuLrmxA56i2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekoMzXkH; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53659867cbdso9921274e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727268315; x=1727873115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2tgPDBQtwpuL9sTe+oKDRUiGqf+yu/MenDRJEbtBXI=;
        b=ekoMzXkHU1DAD0DkTzw6tv74yJV6H30Ze7AZ3T7xQJF5viYw8sweR6MfAhU2J5YUav
         5IGYpLO90/1kK1qFqJwFqM+YBNo/lVxE3TBd5ogsYGs6TBkuG6hq/F66ipPlkInGH1uB
         OofHx+36P3sZdnUS0kqde+V7OQkoxhSz2N3Ta5GK5gvG1IpAZ05rjb5Hl7n3lZbZ91fd
         Qe5wIPOz44ydeFjBEP6bldrUQlyX7ZjOMGP4mMQmKiXaavbJT4QenzOx3AIiRuIl7kAI
         Fx+qPomrUnkAjAbFh2Qyq+VJ0L+Wy7NF6njVgrnIczUcVaJTQKbvdB3qnKmPxrr8Iy7E
         YBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727268315; x=1727873115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2tgPDBQtwpuL9sTe+oKDRUiGqf+yu/MenDRJEbtBXI=;
        b=Xzwtbfulc5kBTf0z8V11rtejpyzgEBDfBkGYEASoGmkBRigCQUsv4kzk8jdeIMMFXr
         5aiC87ugaGyok00LF0ziw4NwBxuUBL4dRXYvt8Q1zbd8hFrs2YQzsmMMrsDfQ7JETyp4
         YoPe8RxEWsj3SHjp+ASVIQ7U7fZMF4/SYt1QX8/Xkme8hGGi3tQc3X4r1SX9qwC1rpwL
         zHwLAGSRIivL1QilX9W3B1xcGquqk2T5fI8L9fVSsg3dEqaXmaBTvmqSOnIT/5XyPWN2
         8X8Kq8ZC91scS4RIB/5B7fCIxNQuGfMpUoZXiqgV0dltaI/5eT6VsDE8Fdx4sCBoNuAl
         9M7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSspPx7Lx/8LDDl4+k9qw2sNJK3euPBdv27l366gbPdPlJn6bhaLD/hQL+nKN0pCuj67S4jyd+auBmdFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM2644b8N+80RVnMjjSxy1swUrWJ9N6WLnqoHwei8MmP7faXii
	XrDG6tZOuX7pNYES9ftLdol8oqTNjbZzJYqLfZ5AewZssqaturrQQPkUpmVPGNII1QNcm9n77+5
	YzDELojHWnGSN0wDKL3vm3jB7ig==
X-Google-Smtp-Source: AGHT+IH7a6nP9rsmNCN8hfTCn3WWXnvbe8FqfI9D9j9sNWREXdO42zbQo7WAZXlSCchyttADHxAF2OG7kLidI6chDBg=
X-Received: by 2002:a05:6512:3d0d:b0:536:796b:4d6c with SMTP id
 2adb3069b0e04-53877530b57mr2157507e87.27.1727268314891; Wed, 25 Sep 2024
 05:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925032256.1782-1-fangzheng.zhang@unisoc.com>
 <20240925032256.1782-2-fangzheng.zhang@unisoc.com> <2024092556-tribunal-next-84ce@gregkh>
In-Reply-To: <2024092556-tribunal-next-84ce@gregkh>
From: zhang fangzheng <fangzheng.zhang1003@gmail.com>
Date: Wed, 25 Sep 2024 20:45:03 +0800
Message-ID: <CA+kNDJ+WKR=5zDhwpqf_yr+Z1HRtMPnACRyDGmDhZo45eKagVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/slub: Add panic function when slub leaks
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Fangzheng Zhang <fangzheng.zhang@unisoc.com>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	tkjos@google.com, Yuming Han <yuming.han@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 4:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Sep 25, 2024 at 11:22:55AM +0800, Fangzheng Zhang wrote:
> > Perform real-time memory usage monitoring on the slub page
> > allocation paths, ie, kmalloc_large_alloced and alloc_slab_page.
> > When the usage exceeds the set threshole value, the panic function
> > will be triggered.
> >
> > Signed-off-by: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
> > ---
> >  mm/Kconfig | 11 ++++++++
> >  mm/slub.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 87 insertions(+)
> >
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 09aebca1cae3..60cf72d4f0da 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -255,6 +255,17 @@ config SLUB_TINY
> >
> >          If unsure, say N.
> >
> > +config SLUB_LEAK_PANIC
> > +     bool "Trigger panic when slub leaks"
> > +     default y
>
> "default y" is only there if the feature is required to boot the machine
> properly.  That's not the case here, sorry.
>
> thanks,
>
> greg k-h

Hi Greg,

The reason why the "default y" is set here is that config is only valid for
the functional code that works. To truly implement slub_leak_panic, the
parameters must be set effectively. And, the current parameters are all
in the default n.

Thanks.

