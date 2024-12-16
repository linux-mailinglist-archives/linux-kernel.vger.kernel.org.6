Return-Path: <linux-kernel+bounces-446737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1559F2895
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E78A07A130A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9CA145A11;
	Mon, 16 Dec 2024 03:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMjMyE7L"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08909847B;
	Mon, 16 Dec 2024 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734318564; cv=none; b=eI+BtLk4LmZTFpXYut9f3Bxw6UMcEXmlwNr3xONM3HcMXg53GLDU7GUiTxw37LJFCyKXHtB+nMGtol2OmugxhoYNLfWn7yvj43Q1qZeikUhnc8shGRZmV1l5Hox+tBXBZ0d9OdWC4Pf8/TjpfJ12sR1HK4vn/3I9migtZtP2yfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734318564; c=relaxed/simple;
	bh=90Yq0ezbP6aU41Tu2LzBdtyN0per/xFIcBX3HCJvChI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4CQ/GO/8JcnFnQND3glKHnN1Mgt5pEcv0nasdZsf2KBkTUHBhWtYgJBB6J4PZt3rq6Gjds/lD9uFC0lK18WKwFk3ewgLo++tJwmBBRMnM7CKtOt4wvevF3gwWBcSp1cOZ6+yKrM9bX/gtz3I/zfr3xLlQGJe7VmQk48c878/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMjMyE7L; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844e9b7e50dso240772339f.3;
        Sun, 15 Dec 2024 19:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734318562; x=1734923362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmPTNauQR2skEMTkQtOSMc9lLkJ/wje1XPgQga+fxqc=;
        b=GMjMyE7LZqoPQv9pm3141d77Do8B7mvQ/4I5iMbT3ufveUqK1PaIVFEoTBUSol4qqL
         8EQxQ4ZXDrVpE40esqb2/VBzaAWG1RUKBNMb6O+LLzMyWSwDsuz3eFTLvOtd3MHux0Lf
         /g3ybQeSDDdK2LGheYQh8eOeQt4Mz8DQShSvqz0mphvvcW6WZK07H4Jk+9P24+AIHd9O
         z3PtEKdjCMTfBWXXbGlI0Oueu/XS0mhBbQ+i67tgAq24sZXOA+L9IO2DitkoMS9VTnNg
         cP2QAQNsxBmfe0N+vU72yD5zgjm/Cs/E/KKJItWJ3BbU0PPBLJwmxo5kijrL4mJOk6lc
         3QnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734318562; x=1734923362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmPTNauQR2skEMTkQtOSMc9lLkJ/wje1XPgQga+fxqc=;
        b=AYpbgZdCOsHtAolOwjAsNnh/2hKmiV34dyKij5lcs24/QOJPV9iUucHJrKn1onKv9V
         S1c8Mhuu/GHQmuyNOmCWwpQNRj0Z7AWapajrjg0efntP5BojVGAMWIQYlImze8lHxEXj
         3h6xJ3BziUni9CgznruHfXtoUJSXqyGm26Zmz0SES8XL5HIPBAZv5YMo9eGxyANGNQGQ
         rLCthhya73pn3O8V8fkkCUDpB7i8OuyR7mn2nxFoYpap56tUIcDt3BwI9WhwblMjzH36
         un5XzG2EabeAP3NA86NL98QSxV9FsEDz3gbxRJBgnqDatsTUEaLwu1Hd7aqZVLtqUpCM
         HX3A==
X-Forwarded-Encrypted: i=1; AJvYcCVz0+00RsAkWLCRfrJldJiAqv2xFdZHbxFxrKvDywBOuTT++Q7pjaWj8AuZQc5rPw138+LRH9ryYdZwmSI=@vger.kernel.org, AJvYcCWGWwbtP0qq3shcq1ojHX/W847fmOuOYH3GFaqlJEZHjoDMIeGUyeuKlTESPzgNS5vGOwd8pMcCC9Yviic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEkHC5E83JqDeAVYtxo/dGwjVghPARjIElZ5OO8M5gQD4jzPjj
	+SbIjK5v/qRHtGZg9S6fonueMsW9HOizUVKRB0TEk2fX0UCOO298VAQ2zLDcZZyh/XSArqpF0Xk
	OSaBLrQrsnGJBBqvHREkkUNW46kg=
X-Gm-Gg: ASbGncscMphqU5RcyBnfWyNi6v+n9+dA7BHY67CGng75pbSXddL6LIedbL19+JcDvc/
	lCBFjVatdIM3G6iIEgzIWSkSFctU5g1P2JXDkxQ==
X-Google-Smtp-Source: AGHT+IHTwGDh5cuU4B9/pqS5+rEt7tfeACGODQwuVmTbz40MQwXMEJ9Qep9Dr/7oW+HoBefaLhxkLkKOb953bL48Avo=
X-Received: by 2002:a92:cdab:0:b0:3a7:96f3:bb3c with SMTP id
 e9e14a558f8ab-3aff461464fmr100275505ab.2.1734318561915; Sun, 15 Dec 2024
 19:09:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216023124.3817798-1-shengjiu.wang@nxp.com>
In-Reply-To: <20241216023124.3817798-1-shengjiu.wang@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 16 Dec 2024 11:09:08 +0800
Message-ID: <CAA+D8AO09ER29upoNfv4uUw_D6vPcQ-XBkzTjv2QqxpK52oHdA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: compress_offload: Fix get_user usage
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: vkoul@kernel.org, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, 
	lgirdwood@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 10:32=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.c=
om> wrote:
>
> ERROR: modpost: "__get_user_bad" [sound/core/snd-compress.ko] undefined!
>
> Fixes: 04177158cf98 ("ALSA: compress_offload: introduce accel operation m=
ode")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412141955.FBjr5T5q-lkp@i=
ntel.com/
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/core/compress_offload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.=
c
> index 6f2d389abd04..dadf074359ec 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -1182,7 +1182,7 @@ static int snd_compr_task_seq(struct snd_compr_stre=
am *stream, unsigned long arg
>
>         if (stream->runtime->state !=3D SNDRV_PCM_STATE_SETUP)
>                 return -EPERM;
> -       retval =3D get_user(seqno, (__u64 __user *)arg);
> +       retval =3D get_user(seqno, (__u32 __user *)arg);

This change may not be accurate. Do we have get_user() for 64bit?

Best regards
Shengjiu Wang

>         if (retval < 0)
>                 return retval;
>         retval =3D 0;
> --
> 2.37.1
>
>

