Return-Path: <linux-kernel+bounces-560576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BADA606BB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D52460EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA02AD515;
	Fri, 14 Mar 2025 00:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGns6Rqq"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4C4C8F;
	Fri, 14 Mar 2025 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741913666; cv=none; b=ClATDKxUC3SdIEoMiZpuCvBW/rKvsvFVahdPq+oYhFFFxm/idYhMezVon1uITpUgF2cAUdu6N+Dh0iNZJgUVGvuN2U1nu/xUYqOVSlMvvBwfeEn6eCCxEnQPU281cEuXsY4FkJyIwheNezrNZsVg2cJaFS3Orw6icOBC89bc/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741913666; c=relaxed/simple;
	bh=lh6pHlP7Gdy+8Zq9852ntDG39AgnWyWeyktDzx6mXyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izJwfWiB8s2e7aHajnalS3wJRqEArN75u66talUj6SarCUKpnyAACbywEiabz90w7DNjM69IoetYreUOfy9A9IrFupai0Lkdw8tbifdMRXMB0vS6rRafIxe/8xk5oStf8MZKI/zWHhUd19oHYjxkW1w1rpSZDsHxhx/4ltXRWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGns6Rqq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223594b3c6dso31409255ad.2;
        Thu, 13 Mar 2025 17:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741913664; x=1742518464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UmlUQi/jXNfdANS2v7/yKDDCGx9y7VIZYSFeIy2bFvk=;
        b=hGns6RqqKW/hwq5tYA2W2VWSnnDRvblXpJy60UMtltfgPnaUz3jNsklUmLLeKxf0aU
         z67UoRrG0g1rJH4xm3i4GX+VM5TgicXoPrV8vO6SI10kpLg4I2YcV+LJg9p9ZB8MATJr
         5IRuJM4czBRMiqvDqj5N7g6xDWjNNEQmqNuAz3wLx5tSLH8pt4RNFlG+Xg2tzaQPAuN0
         i2VRa+Ff5bgQ8BNVFLz42bewRW3TcIfllpV6yIblQOdwG1K2DbMpYYDSFW2xZRuW3bX8
         i77i8hRHWXOnRsd7ERwEHl0I6jUC66dnoMcn+SVmgjqJ6Jhpcu3l2uWFBz2F8PGajqqh
         P6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741913664; x=1742518464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmlUQi/jXNfdANS2v7/yKDDCGx9y7VIZYSFeIy2bFvk=;
        b=ofrblXw7qh1EwP0EJFKeKsGgWa7tiJ2cU4XFfIpZpVleyo2yperxiA3Y55Ir8aPzEy
         WWAzzn57FEysouhTxvSpjVgmX8Z6KxdYmpiZJ4Nr+2v0EPO9ZV+OdO9KiFlzv5cR4Poj
         CVDSXK3DwAKiHraD0N40vUcwTtt26P9JcZNhfv48PSjap5yk+RwWIOs/GoiFYUbPGobb
         MHVU9nNVtNdarvMDzSgy9csoiwu8RAmaPw5D5ES/6BbnTFFNETBARboUUeg5AjchzFse
         XsJMgFTUsvnE+XLUIT4b7uxKLT4cskXzy2rIuIG04G2H0ir/W/piTIsTEShFBuJeXMiK
         0jvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHMeiD/SD/liUD9ZJRUnBbLv9jgYXCLlaP2IBHzAY1wU/DYOmZihXwT5YDr0ps2dpZ6L/qm98jk9FPaQJC@vger.kernel.org, AJvYcCXblQQsruTs+/z50n7Ir4jaMdcYjb7lhd7QMDjYNOd56+G4xq3OmpzD0+QN8rmgmag10Ip9csm4E+1G@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1PEDdAaGirB9T5Pd0B1K3NsQa07u9TTuDZHz1wQZgHQ/Uu2yn
	BntD5ZZkCx4flj1Rfz5xxJ0KzqPM8ksymsdxBohCqEMx4EI81O51z99bnMetDDaizOSg5xU=
X-Gm-Gg: ASbGncvXoH5CXED+gBn+GUmRp+2xqO62Wsg6fqwyKyDyuHOHuYiLOgOT8Wv3RbRjoJ8
	T7nvND8WvlA5TE7kOc6s9nw7E0UMBIB/2wzmffbCYhbA08IFt3j1dCFfXD2ZdRH0CyNb7dk8sgj
	Q2CEzaaCrj9hcxVA5EXg92Gk3yZavOc8ZobbbbjgBCL3MQibTMrwyetLFPtDMzpaW/z8Mrp9uQy
	EUIvXJf1rBiCsCDcx7HesNOo2WCif8SgWkCs7ozS9pyDa1NOuUot8MdyHShbbwXis5qU4GcF/kL
	bnPbfdaxZ+LcDi/Q5wtxTWgchbOGU7zx9bimftCljg==
X-Google-Smtp-Source: AGHT+IH0Swi1/WNTSoqeJPbcXP7ZXkJSO8ITb6Auxw31i7YlapXfDM5K9EjPsYO0yRUETWHGvbC6qQ==
X-Received: by 2002:a17:902:ebc8:b0:224:c46:d14b with SMTP id d9443c01a7336-225e0b2f418mr7120275ad.52.1741913663119;
        Thu, 13 Mar 2025 17:54:23 -0700 (PDT)
Received: from localhost ([2a0f:7803:fac4:6bd5::1])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bd4de5sm19856935ad.230.2025.03.13.17.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 17:54:22 -0700 (PDT)
Date: Fri, 14 Mar 2025 08:54:20 +0800
From: Zixian Zeng <sycamoremoon376@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Inochi Amaoto <inochiama@outlook.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, chao.wei@sophgo.com, 
	xiaoguang.xing@sophgo.com, dlan@gentoo.org
Subject: Re: [PATCH v3 0/2] (no cover subject)
Message-ID: <x4mmgsllwusayvrtoq2yhgkpo5wk2hqb3xex3dzqve2xwggouk@6se57braliw4>
References: <20250313-sfg-spi-v3-0-e686427314b2@gmail.com>
 <PN0PR01MB10393B82EB1038F184FD18894FED22@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN0PR01MB10393B82EB1038F184FD18894FED22@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>

On 25/03/14 08:11AM, Chen Wang wrote:
> Hi, Zixian,
> 
> First, it looks like you forgot to write a subject line for your email.
> 
> On 2025/3/13 21:11, Zixian Zeng wrote:
> > This is tested on milkv-pioneer board. Using driver/spi/spidev.c
> > for creating /dev/spidevX.Y and tools/spi/spidev_test for testing
> > functionality.
> Second, why is there no description of what was changed in the patch set?
> Maybe it was missed.
> 
I was intended to avoid duplication with commit msg, but it seems unnecessary.
I will try to write a better cover letter next time. Thanks for your review.
> Introduction to testing can be used as supplementary information, but it
> should not be the main body of this email.
> 
> > Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> > ---
> > Changes in v3:
> > - disable the spi status on sg2042-milkv-pioneer board
> Not "disable", should be "Remove", and please capitalize the first letter of
> the sentences.
> > - create dt-binding of compatible property
> > - replace the general compatible property with SoC-specific in dts
> Another relatively important change is about the clock, which you seem to
> have missed.
My mistake, I will add it in the next version.
> > - Link to v2: https://lore.kernel.org/r/20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com
> > 
> > Changes in v2:
> > - rebase v1 to sophgo/master(github.com/sophgo/linux.git).
> > - order properties in device node.
> > - remove unevaluated properties `clock-frequency`.
> > - set default status to disable.
> > - Link to v1: https://lore.kernel.org/r/20250228-sfg-spi-v1-1-b989aed94911@gmail.com
> > 
> > ---
> > Zixian Zeng (2):
> >        spi: dt-bindings: snps,dw-apb-ssi: Add compatible for SOPHGO SG2042 SoC
> >        riscv: sophgo: dts: Add spi controller for SG2042
> > 
> >   .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |  4 ++++
> >   arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 26 ++++++++++++++++++++++
> >   2 files changed, 30 insertions(+)
> > ---
> > base-commit: aa5ee7180ec41bb77c3e327e95d119f2294babea
> > change-id: 20250228-sfg-spi-e3f2aeca09ab
> > 
> > Best regards,
> 
> BTW, I suggest you wait until 6.15-rc1 comes out before submitting the next
> version, because I have already sent a PR to Arnd for Sophgo DTS.
> 
Sure, I will keep an eye on the release.
> Regards,
> 
> Chen
> 
Best regards,
Zixian Zeng

