Return-Path: <linux-kernel+bounces-190645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D208D00DC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8280B1C23754
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF27315F3EE;
	Mon, 27 May 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20230601.gappssmtp.com header.i=@benyossef-com.20230601.gappssmtp.com header.b="Y8p3eWYK"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C715F32D
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814702; cv=none; b=monVchV+Dwd5sihXSK1BRfwmzWDDr/Lmx/xsINWibV2Oe1LHtbcPffbfbdKqJU7tpbogAdMm9PG70wtgpUHQFXs8B1EBnNE7X6nfK0U8YCaiLXvFaR+9+1Y1IhApdLAJOrmTug+zn+Rs03MwX3estRBEcAhe7/8fEkNgi8FQxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814702; c=relaxed/simple;
	bh=bmcvhdZmrh6MM9mLmNF5LoiL7grdt8YdrHMavfQCy6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EaTPOQzxgq60NuOmerZXeIl12tBpXbirGlcabVE9qojcwTRFJ4ud+iU/Ed0UcvhY3ou8Gr3y5XhflH9Odoal7rKfssVFk+Uryu3bWSHn3drYgu88WgCBE8wUUhXsBaqhbD3KE/nZ4xCXMtI/s67hTzIETcmOxlBkuzb9Y/h7das=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com; spf=none smtp.mailfrom=benyossef.com; dkim=pass (2048-bit key) header.d=benyossef-com.20230601.gappssmtp.com header.i=@benyossef-com.20230601.gappssmtp.com header.b=Y8p3eWYK; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=benyossef.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-68194ee2174so2406388a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20230601.gappssmtp.com; s=20230601; t=1716814700; x=1717419500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvZlf59fa//TZ0XsXvjA+byhSo5nv4PsjI3fiaMAaLI=;
        b=Y8p3eWYKEJmljk5COSiuAZvkvorZeAUf2+Ny7bS3Z0ok+UjGxmGqonx9PJ5CQjoHhw
         GEd1ssy31/p4rh272GyRHfdZa0pwosPZF7l3drvKi6RzGtPI9A/CNbuakXPk3f38X2oP
         xsPAMov2TNGKUb2af+eEKQYPNrGtGFeQfHNleci5VcGiVrxdNJGaGSLMHz02VBI1uT8k
         hvRfS5g+GwonDUiJjvzkU0PwF4+DwsQEa/7hdJPR+4jiPNGFhJbhtBGsUNQgWbKbhWhK
         2PZqkF9ADuDxmBt9LMFSeQNYUqkLkDVR6AcLxMnrFWC1A/T/ql52uFaj1+8WfJ9tQIIy
         wdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716814700; x=1717419500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvZlf59fa//TZ0XsXvjA+byhSo5nv4PsjI3fiaMAaLI=;
        b=cfSRr1QN4pJiAjjB95bPAqk3Y2bmi42b/GbMrjuGT/iN/kvRgrPSElAImdJsbEX8ew
         DFimWkOiwnE0cWSz8ZfltEbit3hzhCyl3GgmtGeTeOFfFFnh8ZMegRvX/SmxxInv9EI1
         I7y8hVa9U3PDBiG+bOeKTofZ9HUWd7HxCYimVJ+oAGbJamxQriVf5zgduPc1qfKNRA/7
         GS/fqUFkUy+z4UGbjdOqq00mwGe6R+AOqhy7f+1j7ey3DQIlfLMqfjAdQjyXLH2ZDLhp
         cSoIuQOrG4ap54GYYaBzKTPCrbJt5I10UXyaoIQ2FilxB1BI6tIEGFOLxA6ljYGCab3m
         fKsg==
X-Forwarded-Encrypted: i=1; AJvYcCUVBArtVhThQdXFuX4QjsK+oK9GDsjhuRoLXYMxY+u56Jn5nAf26rAodsJ2tl/vVFe1bbC7cWu+lPhnS8IgSxY16XrkL7siXO2PbFMK
X-Gm-Message-State: AOJu0YxVmf+/ongVsiNWxBwNKfUKSNBaa2YWVjQm/HKIQSCtVxpraCHx
	Aq9pyzwCZ9ehxtLg7JvleQNdrNn21cWNCgQZCB0J+QGwbA+B0Ky8Ao01NqCbOPy3m2Si9wUQyn2
	/7p0UGJcpg50mm5PFr6lapFkbymdf1s36Lti3TCJeQVTTV+4X1wfzeg==
X-Google-Smtp-Source: AGHT+IHHyXhyOmyn8cD3PRL1zxRgm+vpW39GdI4a6ARMcYXrO5Tarx7P0yZjgP8sagG7trFpkjvT6O1DxX7Ia+kJMYM=
X-Received: by 2002:a05:6a21:7895:b0:1b1:ebf3:7a4e with SMTP id
 adf61e73a8af0-1b212d0f9f4mr11200573637.25.1716814700097; Mon, 27 May 2024
 05:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511145200.226295-1-linux@treblig.org>
In-Reply-To: <20240511145200.226295-1-linux@treblig.org>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Mon, 27 May 2024 15:58:09 +0300
Message-ID: <CAOtvUMfYbNZ2G7-qkO8PFX5shdZmYvAQa6Uy4XbdvxsmKnDttQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree: Remove unused struct 'tdes_keys'
To: linux@treblig.org
Cc: herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Sat, May 11, 2024 at 5:52=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> 'tdes_keys' appears unused.
> Remove it.
>

Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>

Thank you for the patch and your patience.

> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/crypto/ccree/cc_cipher.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_c=
ipher.c
> index cd66a580e8b64..3fb667a17bbb1 100644
> --- a/drivers/crypto/ccree/cc_cipher.c
> +++ b/drivers/crypto/ccree/cc_cipher.c
> @@ -261,12 +261,6 @@ static void cc_cipher_exit(struct crypto_tfm *tfm)
>         kfree_sensitive(ctx_p->user.key);
>  }
>
> -struct tdes_keys {
> -       u8      key1[DES_KEY_SIZE];
> -       u8      key2[DES_KEY_SIZE];
> -       u8      key3[DES_KEY_SIZE];
> -};
> -
>  static enum cc_hw_crypto_key cc_slot_to_hw_key(u8 slot_num)
>  {
>         switch (slot_num) {
> --
> 2.45.0
>


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!

