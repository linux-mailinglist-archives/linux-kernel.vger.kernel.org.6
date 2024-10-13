Return-Path: <linux-kernel+bounces-362863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD3099BA47
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B13E1C20D62
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE21A1474C5;
	Sun, 13 Oct 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1LylkWo"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990C7231CB0;
	Sun, 13 Oct 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728835464; cv=none; b=Jd1aZAnr7yopHjGFFpdZJtuLMIyqeZPE4h3NmtpadmlmN7x+1h4TKax8cU+exayDCSyyl7a563ioPh01VTl7D/GOK6xMUrkEOuf9IDJjNoG/rt2w+XvV2mhg4MRCe1JiquuFjgtjKhqC5t0faYCI80H/8RPy04cverMyJe9LFBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728835464; c=relaxed/simple;
	bh=Rgqj9KqJRVNtDFthVWkXCI3CDWKP0NGV+HW4m8PVIOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rav5nwrQjPMgcmmDlFCXA/HfZBf/LN78p7/hnus5n2JvUwsLTGg2AEvdEV9uG14eY6WXSaTafdkClFJrmKHEM07U9z9s4Nzjovl8mMyXYdpX0mhngXIeGjGXWsNg3GaKlub3pVACHYk3Z4h+yvAHBsgm2N2ZvkxbHA6umiwW4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1LylkWo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-430558cddbeso22917205e9.1;
        Sun, 13 Oct 2024 09:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728835461; x=1729440261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gMpna/8AYXdCR0wRcOc/2xASvv+nmGVic53OMYWL0o=;
        b=l1LylkWotX3MdTgl+ASCcroe5/+PjPwSrS7zEplUA3lm3t0er/v82dIuWowHQhhsq/
         y3tfP3Frtw7EUJwopm7Wdj9MdMG/J3hCluUFpwZSqe3aTHtjzzrPqiWNXZri7OvSgz1G
         z1PnljrnsiSDouqrYfXtMS0gvtQPlnquUHQTn6nNRyLhN6tLlMJOvFsyq7MGXyrXk+UU
         9tskmH00AC5O4bjilTHBa54J1ZN5wsK/ODawit1+y6A7Xu3/i4WpS8hq+/LrzrLm3kAt
         doBo0chaDzHMPCAbuCCTjLJNFcdLnfv0fznMOnaEUii2BHJ7RNgv0Nrj6JbtXirlThIy
         YlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728835461; x=1729440261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gMpna/8AYXdCR0wRcOc/2xASvv+nmGVic53OMYWL0o=;
        b=wRC1SUcp410Ll/tjAZ0ZwzrYX1+hjSlNsWUrFBvcUNl6u5AE6bo1I7irhJfmPUHJA9
         AzRKlxZxWOYHV+Y8ebixEKSMr+mNiuRmj3vfMjesOdF9CIvMUrVA0fYiKOf9uuqZj8gN
         Boqaz/nhCCvp7kMGGL1HwYE2wKbhac1ZqTW18mDUJn3msi6XDcH9QSCEO3mKMram1blc
         FoZOppC63bnTb8aJEozNG3PAfz7n7//Fd1S2Iglrg9ZLcQZ4Evs7FDvBUFqWLcoYJZHe
         KZLiaeE2EQFlJsB1jxDhR3m2/ttxG9QU3iiSjBA1ckuwBkiN+mNuU5pL2/pMlGonlpdr
         mAOw==
X-Forwarded-Encrypted: i=1; AJvYcCVTvCCVBq3QGMkVxhCIEF9VbpVifbalfk5JNizp8TNVyuHVZoZDKgfrygVHOcuRg5T2Ehoz3ePNutMo@vger.kernel.org, AJvYcCWP0fZSufPICeeZ1nley3VrvdUH/XUmw1gdibte8oOLdikNriOwWYXTjCSlD7ppW2dwEPT9pAX1ts5EYb9K@vger.kernel.org, AJvYcCXQlcHxcTBaMq78I2+mAuLWfKWlPtGOV3llpsxj52wcQojabZiKg2uHmhUtDFYBtGg6A7H1bRV9YDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy/AHcnSROLGCwRVgBmFpH828hE4erYr2t/Uv/nqV+BW8L7AR5
	uLgHrfvFEFeeQnn/Id5+r1nxDrng6qnOxOPBJw8G6dUdIW63jNmgvHAwKs7BndvXFDEhlPtYKn1
	x4tZ+Ld5By/OVVpZAocn43nIMZww=
X-Google-Smtp-Source: AGHT+IFnhmlYgpEhWeyPYax2Xt7ebzE0H4KnqzeDfB8AqkfjBNX4rSLlp5VGE2NO4VU+LCR1OkSF/cZoTAfjMs9zl4E=
X-Received: by 2002:a05:600c:1c9f:b0:42c:ba81:117c with SMTP id
 5b1f17b1804b1-4311d8914ecmr69774385e9.6.1728835460697; Sun, 13 Oct 2024
 09:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZdeuNxTmGaYniiRMhS-TtNhiwj_MwW53K73a5Wiui+8RQ@mail.gmail.com>
 <20241013130211.3067196-1-snovitoll@gmail.com> <20241013130211.3067196-2-snovitoll@gmail.com>
In-Reply-To: <20241013130211.3067196-2-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 13 Oct 2024 18:04:10 +0200
Message-ID: <CA+fCnZd2pANBuapU4akh3a1+K2ytk+7t2B64Z_x2Xj4Wh_ELSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kasan: move checks to do_strncpy_from_user
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: akpm@linux-foundation.org, dvyukov@google.com, glider@google.com, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com, elver@google.com, 
	corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn, 
	2023002089@link.tyut.edu.cn, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 3:01=E2=80=AFPM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> Since in the commit 2865baf54077("x86: support user address masking inste=
ad
> of non-speculative conditional") do_strncpy_from_user() is called from
> multiple places, we should sanitize the kernel *dst memory and size
> which were done in strncpy_from_user() previously.
>
> Fixes: 2865baf54077 ("x86: support user address masking instead of non-sp=
eculative conditional")
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  lib/strncpy_from_user.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> index 989a12a6787..f36ad821176 100644
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c
> @@ -31,6 +31,9 @@ static __always_inline long do_strncpy_from_user(char *=
dst, const char __user *s
>         const struct word_at_a_time constants =3D WORD_AT_A_TIME_CONSTANT=
S;
>         unsigned long res =3D 0;
>
> +       kasan_check_write(dst, count);
> +       check_object_size(dst, count, false);
> +
>         if (IS_UNALIGNED(src, dst))
>                 goto byte_at_a_time;
>
> @@ -142,8 +145,6 @@ long strncpy_from_user(char *dst, const char __user *=
src, long count)
>                 if (max > count)
>                         max =3D count;
>
> -               kasan_check_write(dst, count);
> -               check_object_size(dst, count, false);
>                 if (user_read_access_begin(src, max)) {
>                         retval =3D do_strncpy_from_user(dst, src, count, =
max);
>                         user_read_access_end();
> --
> 2.34.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

