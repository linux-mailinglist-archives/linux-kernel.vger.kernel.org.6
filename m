Return-Path: <linux-kernel+bounces-370065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 032109A26E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF10E1F275A4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1491DF74E;
	Thu, 17 Oct 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXkEfj7z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A791DEFCC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179350; cv=none; b=ZQhxZJhQAd4BHRZkwZa8qgVcElQIh3Zsh2cwBixN4zPoAFqaGOYtlyOBxv+bWoxa4+mxT9DkcmPYuLVTAbWmPV+5vFN1HDl5H8MDaGqqtWt5L7JaUHVLHBrtifKSS7NOgBjtuOHIWecsrCrapWyit10syygkHQF5wulj1rYHbsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179350; c=relaxed/simple;
	bh=EScb9nMi9NmY7UdMx3kpuBDC9dEcJvoI2pYk4X1rbrs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ld+tMTdzOd4sR9nGHgCvTmuVDWJg+RgENAnJcVa90jPRMUJHp4Juy0c0qZUUnzscMS33QPsBVAu3PqHcJ/CVMqP63UC7GIxDX8VL5BsS+57bZC1llDgNSZKiK0FOa3HIKqykFj7Al70XRFHd9ZGLvNrZAL8Gi2TkeInf0HysTzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXkEfj7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D084C4CED6;
	Thu, 17 Oct 2024 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179350;
	bh=EScb9nMi9NmY7UdMx3kpuBDC9dEcJvoI2pYk4X1rbrs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZXkEfj7zV6ujMqwZWkVWVzqj5mfbNf7uWDGPyKLsKPCE8u6nCu67A/oyNtA85lPC3
	 sdNS9RvRP4Mtg8302BsnIZpUfDmErmkbQznfJrp30W9clNdbj1sxZ2XVJhODJKMkq3
	 u8JlbQHCPJFBp+CNIl+nSnINQmmKc4Do1z+HbDWtFZGVxq5A/Fao+/4PVPTyWnboQV
	 9MT+ZM6XyNa3RjyqTG0YwSYC64yxvhnYfhTbXySLV/7xvbY5vF5mjhIs4+aMh3uzP+
	 Ny6AwaN+G2Dhk+hIMH7/n8RCFiQLhS1JctyP4PEySlx0+eDW6YXRn0Iwl+OnqZXeZb
	 Ru7/36FSP0PuA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-phy@lists.infradead.org, Adam Ford <aford173@gmail.com>
Cc: dominique.martinet@atmark-techno.com, linux-imx@nxp.com, 
 festevam@gmail.com, frieder.schrempf@kontron.de, aford@beaconembedded.com, 
 Sandor.yu@nxp.com, neil.armstrong@linaro.org, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Marco Felsch <m.felsch@pengutronix.de>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240914112816.520224-1-aford173@gmail.com>
References: <20240914112816.520224-1-aford173@gmail.com>
Subject: Re: [PATCH V8 0/5] phy: freescale: fsl-samsung-hdmi: Expand phy
 clock options
Message-Id: <172917934608.288841.3227929508460848302.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 21:05:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 14 Sep 2024 06:27:44 -0500, Adam Ford wrote:
> Currently, there is a look-up-table to describe all the clock options the HDMI PHY
> can use.  Some of these entries in the LUT are using a fractional divider which does
> not have a well documented algorithm for determinging values, but the the integer
> divider can use an algorithm to calculate the integer divder values dynamically
> beyond those listed in the LUT and also duplicates some of the entries.
> 
> The first two patches do not do anything functionally other than simplify
> some of the register accesses and de-duplicates some of the register look-ups.
> 
> [...]

Applied, thanks!

[1/5] phy: freescale: fsl-samsung-hdmi: Replace register defines with macro
      commit: 4a5a9e2577d61a4ee3e9788e0c2b0c1cbc5ba7b3
[2/5] phy: freescale: fsl-samsung-hdmi: Simplify REG21_PMS_S_MASK lookup
      commit: 375ee44adb3640099508c5c0c01d86f0bdb16e97
[3/5] phy: freescale: fsl-samsung-hdmi: Support dynamic integer
      commit: 1951dbb41d1dff7c135eed4fa1a6330df6971549
[4/5] phy: freescale: fsl-samsung-hdmi: Use closest divider
      commit: 058ea4a06704c6ad3032bdb3ead9ed3dc1f7fe6e
[5/5] phy: freescale: fsl-samsung-hdmi: Remove unnecessary LUT entries
      commit: 7588444551c65ddd37d6ee9e232bd944d2df2c8c

Best regards,
-- 
~Vinod



