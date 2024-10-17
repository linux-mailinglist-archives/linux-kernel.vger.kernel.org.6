Return-Path: <linux-kernel+bounces-369383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A58B9A1CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB8B1C2688B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B691CF7C7;
	Thu, 17 Oct 2024 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxMpo5Wu"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA76A1D27AF
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152464; cv=none; b=MVY0BrF5za8ps5C0rwmwJQl3OTuCGLCOGgzEZezm6FBBDSmL5TYKE9I/+D75tfFnq5qVQG3QO1aLlzEJLWEarf4R9qzLt0hM87uejnt8QpOoEAGRaHyJvIuNI6D3PrhGoHIlMcqhwzW0YeQrJPpnZbBTzPJDQ/SgY6slHteyfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152464; c=relaxed/simple;
	bh=ndpoMxpMVrIrSKlwdDD1oKAkH6pVJHzoMFXo1S1iBaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTolF+lUJzqi8bAZdIMLEZK6WR8WO2XCHlWDB4ZeAPusrtNBokPa+nJNGF05MKXg3xGxmLlPUkYNUagXi4bOddbLS8kAnmveelKXMNTsgBxEBAHoQKE6yZaOf+bk+tu3eV8VOCIQUHIDnG8VsAuCn5C0f37yTdC0cgIyAM5UZ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxMpo5Wu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d7351883aso26863f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729152461; x=1729757261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3ARNvMTDIwUa/OeE/2jT4z88IP0Xf8KXTuQ47EaPAA=;
        b=OxMpo5WuCcdPssfhP2Jc5or1SNUQJcFgAlF6r4V5L+YBEuy3s0WOMdNf68xoDZcVcS
         6tCupmFRqw+9NU0tBSwZvq00l7oci141j4Ujd+f4K6MI5sQuGh61ediPFLJyicMSN6CF
         cz+sg4LBGjd5FvDJnqME1omrfOeGVBsc9z1CYbh6xn9ySKpeYNMoFkdZs1tYSpnhlmNf
         D1uNClIBtjRGFvITVeaEzqhEMvtrkBCt3EBfNMbMMpPhTlYHzSKWR4eKGrNK649glIj7
         Wm2lTk576KbsZ/EjjqBWUZdGlCOyw1LKLYpdGKKATvVDcLeBxc6jhQx2rFNWhTqBmKGY
         02fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152461; x=1729757261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3ARNvMTDIwUa/OeE/2jT4z88IP0Xf8KXTuQ47EaPAA=;
        b=CWm7bww7e3MLLOgnmafExGnVrdVWwYH8P+WovfKfq8Rn23YckUuwoQmb2pNVQBh6Y0
         7HrrI+3WsYbDv56yIgYnkAFWj1Yp0P7ZdVAx2QkTPmfuYXTLQGsIZhHqHFNDtZnGLl/i
         Ur/HTAab4UNfPI/W9POQV81JPih7dcxAsx+77x17TOCxGMXpBafT92TDuJYkx+5HxkvH
         lHzl0rj23bLx1x4XsLbu89Xkgmowi3baerfAttbCNpknQBbapbgxRPI6krtqmRA1pvFU
         5AjdOFyD8YKtVEwxU3jB0FAE3VZNCJdHW294jdK/WrvtdVBSVw9iMKuo3VZgs16IIge2
         so0Q==
X-Gm-Message-State: AOJu0YzRnjmp6e5WQFsd6Ot7dHWWsdR/Sx6DMAKBqO2YeCxxRctQD0DY
	bvd52wAxgnwgbaxMQJVBUNU1zA5w6ER8Kq0GLoxZ5rB4HI+vs9Yx4mxFIe2PSDk3Pi21YeWvOie
	2ZL0hG360AEb7eaZiK+oNaclukK8=
X-Google-Smtp-Source: AGHT+IHoCiNIIhJpvNcCGrSEd8zUERi0mYbAqee8s1BYf5uwu/qt3wnTu2Z82Ymc1C7ehtXSEY8FCPa59AGUeys2RTc=
X-Received: by 2002:a5d:6daa:0:b0:37c:d122:33ce with SMTP id
 ffacd0b85a97d-37d937d7f3amr800502f8f.6.1729152460755; Thu, 17 Oct 2024
 01:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927160655.3594366-1-daeho43@gmail.com>
In-Reply-To: <20240927160655.3594366-1-daeho43@gmail.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 17 Oct 2024 16:07:29 +0800
Message-ID: <CAHJ8P3LT21jErAjPB055a0JkHrxtSG=t7kzNKy61Dex5XSzEiQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3 1/2] mkfs.f2fs: change -c option description
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Daeho Jeong <daeho43@gmail.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=8828=E6=97=A5=
=E5=91=A8=E5=85=AD 00:08=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Daeho Jeong <daehojeong@google.com>
>
> Current description confuses users like they can add addtional devices
> with one -c option using commas(,) at the same time.
>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> ---
>  mkfs/f2fs_format_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
> index d9cdd61..b6785cd 100644
> --- a/mkfs/f2fs_format_main.c
> +++ b/mkfs/f2fs_format_main.c
> @@ -50,7 +50,7 @@ static void mkfs_usage()
>         MSG(0, "\nUsage: mkfs.f2fs [options] device [sectors]\n");
>         MSG(0, "[options]:\n");
>         MSG(0, "  -b filesystem block size [default:4096]\n");
> -       MSG(0, "  -c device1[,device2,...] up to 7 additional devices, ex=
cept meta device\n");
> +       MSG(0, "  -c [device_name] up to 7 additional devices, except met=
a device\n");
Dears,
it seems that man should be updated too?
.BI \-c " device-list"
Build f2fs with these additional "comma separated devices", so that the use=
r can
see all the devices as one big volume.
Supports up to 7 devices except meta device.
thanks!

>         MSG(0, "  -d debug level [default:0]\n");
>         MSG(0, "  -e [cold file ext list] e.g. \"mp3,gif,mov\"\n");
>         MSG(0, "  -E [hot file ext list] e.g. \"db\"\n");
> --
> 2.46.1.824.gd892dcdcdd-goog
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

