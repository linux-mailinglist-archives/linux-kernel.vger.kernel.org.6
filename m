Return-Path: <linux-kernel+bounces-372171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D719A4541
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AA01C2374E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0266F2040B3;
	Fri, 18 Oct 2024 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="ylO1u3gr"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097DB14900E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273535; cv=none; b=Mp6nXpGgQDf1q4XOdGMkEUhFtzhdSUqUbgUWyq4A6JvQEu+SDdXTuVD+QMp6fIxwoM3lVAHeWZkDzw4dkBltsoyVn6NnPuEZvDR2ktXKNl410je2rVA2ByxfND/Rm7PDByPdGT3oFv5XI8KT36nFPI8fmhAYd2P+O32QENCbmkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273535; c=relaxed/simple;
	bh=zVgV68zqNAMBgHC5ih+l7Dr7bZTc2ehLIDArvss9PQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+Q7cPGtD7r+57Dt/Ms1ZCzRpYMn0rgDlOGYU43/g01pmIiMytq5+ZEF5RAryK+xza8kvODT9AMd2KeKH+DVCLt7nc+44qysFEtMYhBcvWrPcDCvRt6CxCfHmjXk0YMVUw++RcUc1mq0pTDFoGiRpls0dCJ2z2zVWLG3zBpzUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=ylO1u3gr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso3693196a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729273530; x=1729878330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UycLbInY8XVHUJwgb8SlAwx2dkW5WqLLmbDPCUL9SDo=;
        b=ylO1u3grZs58v9a9Aqfq0j23XiHtyoPUHoSE1w0ZzB97+LwNmagFhLlQfKOQDdQZ0e
         mARfo1QlUpIH+ycJJGmoJi/t39xv/UWaEFgnK9DOFvWneDptwiDJEWBz4b27/YxFzL4T
         SCZWqN4tK4nN85uyHB18aWFfB3ATcNmbK3lLAr1DqXf8J85IqIDIG8yhH2/mM50Db+Ui
         ZfT0TN49TfMiyfhCq9F+nzNYyri9G9lkW/Z3TU4unM2lmM2Rw839gwUNdFiW4dlWgnda
         y3Uxjg/81wa2NdYWjT6/9qI7+G9mmD5pEP0ubcf287WOWlcwujUc8ZhCM2FW5v0Yh6/+
         F3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729273530; x=1729878330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UycLbInY8XVHUJwgb8SlAwx2dkW5WqLLmbDPCUL9SDo=;
        b=knyvofN5hI93pAoufUlfNbH/honI5rIVQcTHEVtSencqP5b2O1YfGMH0x+EqrdamOM
         xv+kAuwDdXr3Rz2ahpEgm+UHi+qfrFtGYPpssiDsyqz9LhHXNAgZifT8aHxCJPE+qW9P
         akROM7BaJL4yvH40wybadUtEUmkQq51jWtOKDV9/AAiWWDYf9XkNcS2mQu62SGxSvrqM
         7ROpNjy93oMFTgDu2j4O9I7OBzXdP5k8qhOjj7kHeTZloipE/XL3/8O3GrhTVvJijPHq
         5X//STXLfVByeFEhpxZnxwzPZDwXMSih8pvDu0BPyx+0ssAwRdeZ9DMr9B1h5u3SqGEA
         KJrg==
X-Forwarded-Encrypted: i=1; AJvYcCUSxmvksYqm06v/wsQyKUpuFaL8JVLemeEBTkH6uSqdo5zaB0wZnS0ToN5syBd/1gAwsu5Jf2BnC+YN0+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDCRB0ftqvwvtUkhU0tpWJ/1LAlJbQm/rB97QerpAcbAQ+DnF
	1a4HvlVj26yjOvOQOXt0i8FRm0zVfvyer/FmPq5ndN7kNW401bkmdbGzjakh0oABwz9gdPTiD12
	RAIgOKTCrMjbQSsMKVpg8mrHIJgIsY2dOcVnySQ==
X-Google-Smtp-Source: AGHT+IGgOLmBCaLEk5MbTwop088cWLaCaOhDIQBysmyf4jbJoRHxnK3RSV90rMVLknbfLkVQBZIn+mpkyNWMXfcFom8=
X-Received: by 2002:a05:6402:370a:b0:5c9:1cdf:bbae with SMTP id
 4fb4d7f45d1cf-5ca0b0d01demr3123694a12.11.1729273530034; Fri, 18 Oct 2024
 10:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018170347.647896-1-colin.i.king@gmail.com>
In-Reply-To: <20241018170347.647896-1-colin.i.king@gmail.com>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Fri, 18 Oct 2024 11:45:18 -0600
Message-ID: <CAEO-vhE3RLGnp3667V30-rk5zFef=VL9ACruO47wskS9R_JtfA@mail.gmail.com>
Subject: Re: [PATCH][next] crypto: cavium: Fix inverted logic on timeout end check
To: Colin Ian King <colin.i.king@gmail.com>
Cc: George Cherian <gcherian@marvell.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, David Daney <david.daney@cavium.com>, 
	linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 11:04=E2=80=AFAM Colin Ian King <colin.i.king@gmail=
.com> wrote:
>
> Currently the timeout check will immediately break out of the
> while loop because timeout-- is always true on the first
> iteration because timeout was initialized to 100. The check
> is inverted, it should exit when timeout is zero. Fix this
> by adding the missing ! operator.
>
> Fixes: 9e2c7d99941d ("crypto: cavium - Add Support for Octeon-tx CPT Engi=
ne")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/crypto/cavium/cpt/cptpf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/cavium/cpt/cptpf_main.c b/drivers/crypto/cavi=
um/cpt/cptpf_main.c
> index 6872ac344001..48f878460f41 100644
> --- a/drivers/crypto/cavium/cpt/cptpf_main.c
> +++ b/drivers/crypto/cavium/cpt/cptpf_main.c
> @@ -44,7 +44,7 @@ static void cpt_disable_cores(struct cpt_device *cpt, u=
64 coremask,
>                 dev_err(dev, "Cores still busy %llx", coremask);
>                 grp =3D cpt_read_csr64(cpt->reg_base,
>                                      CPTX_PF_EXEC_BUSY(0));
> -               if (timeout--)
> +               if (!timeout--)
>                         break;
>
>                 udelay(CSR_DELAY);
> --
> 2.39.5
>
>
This bug was recently fixed by my patch:
https://lore.kernel.org/all/20241018162311.4770-1-everestkc@everestkc.com.n=
p/

Thanks,
Everest K.C.

