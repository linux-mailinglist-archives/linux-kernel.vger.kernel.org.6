Return-Path: <linux-kernel+bounces-367704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8039A059E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF26A28A1B5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B976205E18;
	Wed, 16 Oct 2024 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D9YOwz9A"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27131FDF87
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071327; cv=none; b=maSSXAeVNFCt9C0douBtgu6tQStk857G+2sE4qNCGEbKpQuOgf1h+dBlulhC6dQH8FC3JUaw+fCv0Ak9XdXJc0hFg6xtpSbxBFmK9MzoD9YRHHP/6ltnwblXMITjzhBu/cPo7zMbSpBI4oSoCMn0D20c0aRLQa/f6/rRCEM+Eqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071327; c=relaxed/simple;
	bh=Sv9GOdoP5tZ8KQ/1mrOY0QDCQ+2v3F4j9yqLbFtUipQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKS3MLQaLzCEw5TygYOgrSPwbrLkCQnU3jrK1PgISczd4DpKadVrCev114CLhaVZ7Ebt9rYTj8/HFUKfXg0Q6REnm1wv/tJGCv/BWIJ6RqEYc0JYmF0poIS/lvoiVNhBZzMQy0CHfB9+/54jXefmZGRU51vppPtoHrFQuzvUQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D9YOwz9A; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb51f39394so31015111fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729071324; x=1729676124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=icikz+noVT+A1IghOr2dEkNmSwULz+YkGpQA6euzKVk=;
        b=D9YOwz9AzBrahnVwCRdF2fe32upaeSibFlbuV84wzfWaPH9cr4W8RT231bxiGJZgii
         d4OJKeJzoyhACnyvNTkOkDMQqp5FfxWK1fM4kMlxLvZsiGTbivR0LVKf/ViVvzWoWwfL
         drSFdpwtvSmNBMWMbHB0d6JCQGNr6aY0UoadEKB2ewcNtddNJeL1vae7DcQd5JuYzUWF
         I6r36L3sCoqAl8kzTOxkGEwrXpq2w/1NVwcpwT09O1Dnfd/NEVrUry6h0T+GybMnBxaP
         9mPhhVwRPoKP3bOdGgHyhxY8GOSiYcqfIQByCpXOdwEhLNza2u8GwJGgdzXZHWqWrWph
         Jiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729071324; x=1729676124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icikz+noVT+A1IghOr2dEkNmSwULz+YkGpQA6euzKVk=;
        b=QNR+QLVdt7pKr2A6gL0zt3iuJhALxLvR27Ve2Oy8lAYd0szEqMfmD6zrNsTT5IJ8Lz
         fXT1a+xogL6Cfc2YXtbmCgw9OJ5Z+/pFVwFzB7Motmybq+fxSMtuByKmd5z7koskMr7g
         aSgbqBIezbhnDwosoQbXPtlUzILxhPanE3VYXX7+VgKCKTb59UVd4sJlH6bD4R+62Sq6
         mWvf4EegyxVGDRo3vtag2SVYZmcrSuCMeaDO44bQXBnPkJtWYxfvwfIFvZ8qbHOzF7Bt
         w+Z8x2cx8PXg6lSjvUKjBm+ZTEDklDJVZETSGKEKT9rX1bUMxK9YmoE+ZLMcEH49Js9U
         0YNw==
X-Forwarded-Encrypted: i=1; AJvYcCVmLAtqUkcyIzzzjnMH7/2MGmbFRF6/7UKHl98dNdlNCYk4zqYexZoElKEt4iu2QWBCBykgdbhGKiE5ZUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIsiXJhtMXVGFMnBt0UUwlGngv7qGfTkCtXbMKAJqFkM4/5fjK
	pCkZA+nIKTjCca7K2MF/LTmT6EaABE2F+wop+1uKK+Sf/iczdxE5mHGSMOCvxnc=
X-Google-Smtp-Source: AGHT+IGdsTFBiZLsx7xeTyOWkTfBtsndYobtBU/I5Fi4D8Vk3Mbkp1GQJDuJHZgpcIfqpPb22hA7XQ==
X-Received: by 2002:a05:6512:3d23:b0:52c:dd3d:85af with SMTP id 2adb3069b0e04-53a03f2f1ccmr2175646e87.25.1729071323803;
        Wed, 16 Oct 2024 02:35:23 -0700 (PDT)
Received: from localhost (p200300f65f19e3002f38cf427133ca7b.dip0.t-ipconnect.de. [2003:f6:5f19:e300:2f38:cf42:7133:ca7b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314bf60fc4sm26528075e9.38.2024.10.16.02.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:35:23 -0700 (PDT)
Date: Wed, 16 Oct 2024 11:35:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v9 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
Message-ID: <lagj6ljulmfjogrzhfd3jrf5fnngev63q2g3bmvftwfzc3s6mb@gw6oz4yriyjf>
References: <cover.1728579958.git.tjeznach@rivosinc.com>
 <b8da2b00aec3f7b4b2e3a7cc194f7961bf656f24.1728579958.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3vc2emncsrj4cjb2"
Content-Disposition: inline
In-Reply-To: <b8da2b00aec3f7b4b2e3a7cc194f7961bf656f24.1728579958.git.tjeznach@rivosinc.com>


--3vc2emncsrj4cjb2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v9 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
MIME-Version: 1.0

Hello,

On Thu, Oct 10, 2024 at 12:48:05PM -0700, Tomasz Jeznach wrote:
> +static const struct of_device_id riscv_iommu_of_match[] = {
> +	{.compatible = "riscv,iommu",},

nitpick: Unusual indention:

uwe@taurus:~/gsrc/linux$ git grep -l '{.compatible =' | wc -l
192
uwe@taurus:~/gsrc/linux$ git grep -l '{ .compatible =' | wc -l
4197

(Hu, I expected the difference to be bigger than a factor of ~20.)

I'd go for a space before ".compatible" and one after the trailing
comma.

> +	{},
> +};
> +
> +static struct platform_driver riscv_iommu_platform_driver = {
> +	.probe = riscv_iommu_platform_probe,
> +	.remove_new = riscv_iommu_platform_remove,
> +	.driver = {
> +		.name = "riscv,iommu",
> +		.of_match_table = riscv_iommu_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers. Please just drop "_new".

Best regards
Uwe

--3vc2emncsrj4cjb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcPiNcACgkQj4D7WH0S
/k7leggAlsgDNwa3KOwBku5V/0eQ57YS6VqfeJom1rXbWx9kfuKXyA1X2FD5V6eH
DEc2IdXEIy1pM/AxZbbt5gNqs2UR6L9VfWToyK+unN62it0PTXxp21dUmdjRXH6e
1nb0PRAAknig82wzfc7EedPJZgp6E46w229pZbiIwOpDbgQOko+r7X3qBB/g9qUh
EHzEVCZ61ySvWWlo5n6mglBmMAiAOB1K/j13oLIp5Em2ym2r+J5/Tq4FmLhe3Evb
auslSx2a/QBlMF2jpdrxRBiCYjlDXbcU27NkVEimEgu/56llOuhZisOYCTlmnMYR
Cr+0vmUBG3jSXmSBeNr4sS9tAy0J6g==
=+mcI
-----END PGP SIGNATURE-----

--3vc2emncsrj4cjb2--

