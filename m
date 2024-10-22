Return-Path: <linux-kernel+bounces-375362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7099A9500
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A858B229D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E781649652;
	Tue, 22 Oct 2024 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdEZDvW9"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BD84A35;
	Tue, 22 Oct 2024 00:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729557160; cv=none; b=R629rCbvsVrdOBBzDy6o31CBZT/70W9JjvZGPBEEXmMUKE+lvwquYLHgBKb5q6OC9M1ZfwmvnvIZq+E2YxJ9kBaYWf67ua6mtrw9/9JZ8c8Th6OmN7x1PCB1Spo2fNaCj9s1FU+Dej8fQyZtwFfePUcv/M4LtZxL+sw7j60joDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729557160; c=relaxed/simple;
	bh=Ubo42J5xKuWevhXM6XuKUJW1NcslPFK+IsNwa6C5B4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJRFCEVUIDTOZRMKh1pu0wg3xlwmXqgJoLkSwc/8P4uCUBs2zs56c2aT+h3zQZpDFQdM9wAQL4rFKkTaz9bnHYvuXpRQS5rvxm9+MjbmIbaRjXseCPo/7bTKU9tOC52qsa8EacHOBva3APCO20OiNvPhejHVThFdTNXP8dCjY04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdEZDvW9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e579abb99so3614845b3a.2;
        Mon, 21 Oct 2024 17:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729557158; x=1730161958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WE4OCeGrEarxaIJLsEWYczNlBhDxq64y4K7wEYrbCx8=;
        b=mdEZDvW9nTyN1dw+JYjF4rK7DBcVEl1v/HVuUX2cswl1EjvxSXsCJt/fV5+Fi6BW1N
         bifZP9n/bKaj+bZNIrY09ai5/IykPQ+I8mtD3rVRr7uc5J8yni5GQMMnfc1BHEbXoYWJ
         VHkA/arunQHrV6lhS0n7upPJhcl7/joRPQ7tqZ2PhbrFZWv/VJ4B3TJWzdu1wEGkO9rN
         gOMc2GdIpLTh4YwUZON5ByqEdwd+6bFs/2g7g1dFz4EKQpAKgaCUrxl1qAGS8h0cinV4
         BQ34/iJp8u/H6tFqb4VDG0ghy7g18fArpC0JBy+UvGJSB9fgLOaZd3/5RlLGXrLoc50I
         YKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729557158; x=1730161958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WE4OCeGrEarxaIJLsEWYczNlBhDxq64y4K7wEYrbCx8=;
        b=gHG0Kab/fJNzIYRBScj2ULUZIPouRyLWYm6xpzwr3ESSpK4/TE6lYrWQZoS8pmGvfA
         001G/FoFTGWn6sN29p5tCpAmftBvv9c6KmYENeN11BLOUCHfb16X9FE8mWkOTr3OQMhy
         /NeldPxE7w4uSjSj44fdafFghG/Dhi2M7nsQxpQYvXQ36qCV1tDeRHgW/w44sBuiYjTk
         5IK7SWVUMpBnQiA3lAvAkOibetiBAmOZM1pr8uKBHQ7/QkmL/kDHpzOapPnVMtkCz7St
         zHpPppWb22FOQ7TmO/w9IPn0IlsYTYG5rOCom4k1ANTcldqjaSoy6vT44uk3uthvWxkB
         Lj7A==
X-Forwarded-Encrypted: i=1; AJvYcCVU4TRt8YJFYg/WzoOhcRDCvHYERu1nWMus3AoFp7aJNqIsjrInxk6Qyg+RXRMco2dT/NXldkzb0o7qesl7@vger.kernel.org, AJvYcCVc3pQDDOd/zH500nM2/mX2JFztMTwKs2UY7HJ18M4BgpeK+mVkM/xH1+oGNGuc9V/YvsTi6RqbP20h@vger.kernel.org
X-Gm-Message-State: AOJu0YwrEqd0x++i12AlYXEA+0EvS5yyy2jfbhb7rYh2KMI1o0w4j0U+
	CAnh3wsl48xYGMdFoGshz5QacdP0bDCaP11f8A5EnTle5aRc3HCveaXVMw==
X-Google-Smtp-Source: AGHT+IGRvtwT49FWz7kNEaS3v8Wbc/KWtCjRiHMEU5H4U/gU9VJLLNUgtlNoDFiUyPMBYSalal22xQ==
X-Received: by 2002:a05:6a00:3d15:b0:71e:76ac:4fc4 with SMTP id d2e1a72fcca58-71ea332ab76mr19694997b3a.21.1729557158051;
        Mon, 21 Oct 2024 17:32:38 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab58aadsm3747124a12.53.2024.10.21.17.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 17:32:37 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:32:19 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Chao Wei <chao.wei@sophgo.com>, Conor Dooley <conor@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 0/2] Add board support for Sipeed LicheeRV Nano
Message-ID: <luq5c3nkj6mcnmfah5gethcud5iikaayyt4e4tiw7fh7e67zou@bkuzbt7kiztp>
References: <20241010-sg2002-v5-0-a0f2e582b932@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010-sg2002-v5-0-a0f2e582b932@bootlin.com>

On Thu, Oct 10, 2024 at 05:07:05PM +0200, Thomas Bonnefille wrote:
> The LicheeRV Nano is a RISC-V SBC based on the Sophgo SG2002 chip. Adds
> minimal device tree files for this board to make it boot to a basic
> shell.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
> Changes in v5:
> - Add support for pinctrl
> - Remove nodes for i2c0 and uart1
> - Drop dt-bindings patch that are already applied
> - Link to v4: https://lore.kernel.org/r/20240711-sg2002-v4-0-d97ec2367095@bootlin.com
> 
> Changes in v4:
> - Add correct bindings configuration for SG2002 sdhci
> - Drop commit "dt-bindings: timer: Add SOPHGO SG2002 clint" because it
>   has already been merged in Daniel Lezcano git tree.
> - Link to v3: https://lore.kernel.org/r/20240709-sg2002-v3-0-af779c3d139d@bootlin.com
> 
> Changes in v3:
> - Remove /dts-v1/ directive from sg2002.dtsi file
> - Add disable-wp property to sdhci node to avoid having a write
>   protected SD card
> - Drop changes in cv18xx.dtsi and cv1800b.dtsi
> - Add fallback compatible to cv1800b in SDHCI node of sg2002.dtsi
> - Link to v2: https://lore.kernel.org/r/20240612-sg2002-v2-0-19a585af6846@bootlin.com
> 
> Changes in v2:
> - Add SDHCI support
> - Change device tree name to match the Makefile
> - Add oscillator frequency
> - Add aliases to other UARTs
> - Add aliases to GPIOs
> - Move compatible for SDHCI from common DT to specific DT 
> - Link to v1: https://lore.kernel.org/r/20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com
> 
> ---
> Thomas Bonnefille (2):
>       riscv: dts: sophgo: Add initial SG2002 SoC device tree
>       riscv: dts: sophgo: Add LicheeRV Nano board device tree
> 
>  arch/riscv/boot/dts/sophgo/Makefile                |  1 +
>  .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts     | 95 ++++++++++++++++++++++
>  arch/riscv/boot/dts/sophgo/sg2002.dtsi             | 42 ++++++++++
>  3 files changed, 138 insertions(+)
> ---
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> change-id: 20240515-sg2002-93dce1d263be
> 
> Best regards,
> -- 
> Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> 

LGTM.

Reviewed-by: Inochi Amaoto <inochiama@gmail.com>

