Return-Path: <linux-kernel+bounces-404168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A099C4021
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A391C2083B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB69419D881;
	Mon, 11 Nov 2024 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAthVMoF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFC615A85A;
	Mon, 11 Nov 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333730; cv=none; b=GAQLWgrx/1upZ3XI5CZl+sS1Uwy2qdZOQtWlEnVTt5a/vprTZI1+I9Ys2VJNF+TAh5XiZlCk4IbP7XVpt/wWo1Lw1Bgi0wY7Py/LRq9GG2MWwANf3syLEdnYbd8iSyAhJuisXbzaCEJAFXRcvtxPsdzsFMFbQtMGwnsu8YLX1rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333730; c=relaxed/simple;
	bh=sdI2GoFfHjss+k6nPzpItWxYvNsdy9CTWpBrfpUgQb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QySuZthGuiqKtMjv3ViBu3+yaF3DH+yGUPIyGJiphiz5/iy34U3kzOB8kDosepV9a4nYE+651Odm/LABfsYOJwp2HpCWfYTUf7VB5VjS2woN3/NbtDuNA71zeveUVo0ug1sHLAg2v1LHjvqk9vqVLPMJ2BCqISBNkkV+OruECAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAthVMoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8616C4CECF;
	Mon, 11 Nov 2024 14:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731333729;
	bh=sdI2GoFfHjss+k6nPzpItWxYvNsdy9CTWpBrfpUgQb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YAthVMoFwipRt1rboQjLhlCNM0aWs9pTsKn0Rtgb+B3XZEpehyMV/ye50x2cRmTeM
	 EtKdAP99NBLxdBnIVBWFme2H8txgWVx4zKFLNHYxaV7qss4Z+T/UozSYqK7PaPXkj4
	 EbzwqW8w6t/CXyzTjY5F7pjkm+idiV9yYC4LFv3Zus7RsmlouZB7ziniWm2md88kbP
	 ZHUB8PQIM0BNBM8AygnNu0scWi+dekyROVDJUkttIeryRos55Ff6x5KthqCJxqVAI+
	 llDLrlGweSp/ZeGnBfyJxNoqnU+6QA+cgRwHSUikl4w4Mxrhq2e0b1dETqc4uAQWyi
	 uLI8YcKR/zOeQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: peng.fan@oss.nxp.com,  m.felsch@pengutronix.de,  pratyush@kernel.org,
  mwalle@kernel.org,  miquel.raynal@bootlin.com,  richard@nod.at,
  vigneshr@ti.com,  robh@kernel.org,  krzk+dt@kernel.org,
  conor+dt@kernel.org,  shawnguo@kernel.org,  s.hauer@pengutronix.de,
  kernel@pengutronix.de,  festevam@gmail.com,
  linux-mtd@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  imx@lists.linux.dev,
  linux-arm-kernel@lists.infradead.org,  Peng Fan <peng.fan@nxp.com>
Subject: Re: [RESEND PATCH v4 2/2] mtd: spi-nor: support vcc-supply regulator
In-Reply-To: <20241029102238.44673-2-tudor.ambarus@linaro.org> (Tudor
	Ambarus's message of "Tue, 29 Oct 2024 10:22:38 +0000")
References: <20241029102238.44673-1-tudor.ambarus@linaro.org>
	<20241029102238.44673-2-tudor.ambarus@linaro.org>
Date: Mon, 11 Nov 2024 14:02:05 +0000
Message-ID: <mafs0zfm57tsy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 29 2024, Tudor Ambarus wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> SPI NOR flashes needs power supply to work properly. The power supply
> maybe software controllable per board design. So add the support
> for an vcc-supply regulator.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> [ta: move devm_regulator_get_enable() to spi_nor_probe(). Add local dev
> variable to avoid dereferences.]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

