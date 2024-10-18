Return-Path: <linux-kernel+bounces-370955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3201D9A3442
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE091F221DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43817B50E;
	Fri, 18 Oct 2024 05:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oZ3ckdg6"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712A170A13
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229500; cv=none; b=PNBTzckI+PuU3YG5wMMnuNx78X3qCahcj3O0ESWjRCdLK0KU/JhsFRSVP0RdHyQnNssuJC7HMzWYNSjjH2wgLu4NQ7tNl/2E/eBqHpykUXqwAUJGimjOTLOOLJbM4EC86dZsu9LAEYJWaQR6vUNMmE/JMyJ35bXXpbczEReCJxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229500; c=relaxed/simple;
	bh=c6pJR17Cx+vhBdPlKGr1glBzn0/Huh2wZWajDJPJL9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPBHpX/Z2fobwZ9gAbAxmsPKxvG6ELazJeb6TrAvTPMIFpQriV8fjEablloCaifMqTom+TPhuTFKQyIW5zzRv29QT+4KvWzk2VMxhnDxeN2B0irB8kQorhPyKeu0CrP8CDF0uWOQhTi5iBCSkrcd3ba7HqOIWS+RCN+1MclP7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oZ3ckdg6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so1289971f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729229496; x=1729834296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6pJR17Cx+vhBdPlKGr1glBzn0/Huh2wZWajDJPJL9g=;
        b=oZ3ckdg6CoKMWMyrrquRg1bWUmPzVMnO7Pt1ZOEccAtmT0rF32QKcqzDwzKmiZJX7o
         2HggUPmruVvYMW2d/mwZHMBLp/FQn3o3Y5VoYusnjuNYR8Mb/tNPJNTGQJUwaY8ZE894
         UfGBFxDj1cExPA0Wo0Kvh0dclxzNcRHvTmjR6I8ePSEAJfJUs92asLL32+MmM9LWNMlg
         1AiKNIxgNFiLDTILU00J/7Wil01/hVZ9trh2cIlu3SlqNHZImMigfxu5Ho1Wsn47brFp
         oPfM+rp8wiybMRk1a0IU55Ed0EMCG58csykSXAfTVUKIs49LuKd2c01NXW5Y0FM1bkKD
         Ig4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729229496; x=1729834296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6pJR17Cx+vhBdPlKGr1glBzn0/Huh2wZWajDJPJL9g=;
        b=bDpRayNXjrJtHQHe9MK9C8zMWNzyBBWffjqp832v4FSmC8k4SQAKLtl6QxUn8v2H0M
         qEQh1kb18Dn8q47F02KW/qcbfwyg1QkCrE7bD79OhgJSVUum2+lwlkvBT446WLGjXerv
         DoHlv1SNVVVs6N/dcsSAadEGKmmNb+clGZapOAayFn6xbESy5qJUPS62pr8SrES9bL1B
         5jUfsWopWBPaD8eX14BgcsWE/6ilBqKM3N6qciCTfGTNtKnSA4wv+tzkJxK8/LVrh4Tz
         d03r91Q6PUu+Jonxx8zE1MJYa++LuaRuNC5BCE0WqRrf8A1o+nXsd8JoXtHhZr3bdK8l
         ZXNA==
X-Forwarded-Encrypted: i=1; AJvYcCU6StrPrdU0FxGynlDSybLmYNqj5J7nUZI8uLuNhbPAOzaRJ/wH0O+VVg/9SiWM8FdEzHiCcosb7BdX8ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYCdreji0wDzL8zbekkLGhnXjVC6dplDPtVa8jf1B0ohd3iNfS
	IkMTsg/xmPyW7xkGWdl4pzA3MvYHgV+zc8HyDlQh+FuZ6X4QkFVUh1Xy4E6KD1o=
X-Google-Smtp-Source: AGHT+IG8Ld3kpTB/rwLsIFn3KMclllCP6Lx/tf5/1/edc8B38j82iBjzH0rHnvWAB7r6efnRAWqU6A==
X-Received: by 2002:adf:e008:0:b0:37d:3735:8fe7 with SMTP id ffacd0b85a97d-37eab70bbf3mr720253f8f.32.1729229496469;
        Thu, 17 Oct 2024 22:31:36 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:c04e:758c:2eb5:eeda])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68c29ddasm44973866b.211.2024.10.17.22.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 22:31:35 -0700 (PDT)
Date: Fri, 18 Oct 2024 07:31:33 +0200
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
Message-ID: <5jxxlmvyyennvrg5w6l3ma5pg7ythzo6z65nhs3lhpscmcl5sc@w22emfmvf2rg>
References: <cover.1728579958.git.tjeznach@rivosinc.com>
 <b8da2b00aec3f7b4b2e3a7cc194f7961bf656f24.1728579958.git.tjeznach@rivosinc.com>
 <lagj6ljulmfjogrzhfd3jrf5fnngev63q2g3bmvftwfzc3s6mb@gw6oz4yriyjf>
 <CAH2o1u4BYyHhi3dVcBrB8T2JpXdxStsfYodmOT-6a8KMHAot8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fbh7gyoiozliysgu"
Content-Disposition: inline
In-Reply-To: <CAH2o1u4BYyHhi3dVcBrB8T2JpXdxStsfYodmOT-6a8KMHAot8w@mail.gmail.com>


--fbh7gyoiozliysgu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v9 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
MIME-Version: 1.0

Hello Tomasz,

On Thu, Oct 17, 2024 at 09:45:14AM -0700, Tomasz Jeznach wrote:
> Thank you for those comments, they look reasonable.
> Can we postpone those changes after v10 is merged into the iommu
> subsystem tree?

If the patch is already scheduled to go in, that's fine.

My motivation to reply is the .remove_new thing and just pointed the
indention as I noticed it while replying to your patch. So I don't care
about the indention. Do as you please.

drivers/iommu is still on my todo list to convert from .remove_new to
.remove, so you can just wait until I come around. I'll push it a bit to
the end to be sure to have your patch in next already so it will get
converted in a catch-all patch for drivers/iommu.

Thanks
Uwe

--fbh7gyoiozliysgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcR8rIACgkQj4D7WH0S
/k54eQf/YHC2YibpwUipmuB41HqAHsAljGTGCjGvubnogU3Jg8+TQNsVCfGqZXiu
si3jNg2XK8hVkXTPzdSH0nIRx+Be7vhMJWMyKr894iU5YDrDDV2n1Y+isdYzrUal
rzz5N1eG26FaxM4czeRU064oACyOKuyPIYY10yrkQiko3A3sWVa5SMHS4fm4IWIV
2KXXGUkx5ctFSaCtJCseENcFdV/yAmQ/Y83sQrle/sqrou8wkm7WIegZHMEe22cT
nG3GMref6aC4I4kLjFhQKdUKEkqJuqkhcYzqhuq+TGSUGet/ZkN6AR8N0+QA3RDr
6iM6q7fDc1d3XirP6chF+olWVozGxQ==
=jEvi
-----END PGP SIGNATURE-----

--fbh7gyoiozliysgu--

