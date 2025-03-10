Return-Path: <linux-kernel+bounces-555017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07926A5A483
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C12170ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814881DE4C6;
	Mon, 10 Mar 2025 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ8vKHZm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC3C1DF26E;
	Mon, 10 Mar 2025 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637594; cv=none; b=kwDldLV3tHPOH2u5NutdFTpAmmlTcPxKYXi8ESlmHIylVFtRu8PvpIWPBJ9u7po57tG8ojYI6vSN7RUPTiJtv97cdJQnL+kWBFqrRhoGtPm8aG3FLvEas/0CYZsyJCI33vyk7VBmcSU0RuMaVw7FuEbO+ozEFhSAdLpAqeeQiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637594; c=relaxed/simple;
	bh=7GLoRHKS9iYVNYJfuUKGRjevJBrW0r+lm+WU7ZOcQPs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FELEMt4DH2jn/1XijJRptxAHoX/4sI0UdLASGmypKZIOQ8l07AJbaPoTIZjjFcWOyaqDS3GxWVSrO6hU5TFaTrFh/DTYyX74+/Y0c5c1aC236otU53gjEZ+sHVmciaebOGOal1EdXNbW9F8nNOlKxUNAL01/Lm8C6474UGTVV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJ8vKHZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E66C4CEEA;
	Mon, 10 Mar 2025 20:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741637594;
	bh=7GLoRHKS9iYVNYJfuUKGRjevJBrW0r+lm+WU7ZOcQPs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZJ8vKHZmcKY8F5ftOjLbHpIXfL9vJcLwlK2jN5GDj+OeY/AK3WwpEIRr24pnwB4hK
	 HAd8v5xsV0YYi1iL2UwB3WLehnN3pXe15rTiCAOb9+fDbbajK8X3VF1GYOibsdsEJZ
	 C74Z1gvOhH/ql1VsMfxQdaOyHiOZsd1Lpz/OIviw7N6Tcl2YjxZ01NQHC+Sb+twY/B
	 lisznoqjirHaV8D5BFzFWkcjKR7pzinDRljOndnDCOGIGTGkKmQYJrWLPA9tbYAJVO
	 w7AMVcp1CKUIKgt47flRN4OOj0Z9VY+yxeZ3qdvLtntfPjE/KGADGkVQ72cLRxdCJZ
	 nHS7Bk86rRUUA==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, p.zabel@pengutronix.de, 
 tharvey@gateworks.com, hongxing.zhu@nxp.com, francesco.dolcini@toradex.com, 
 Stefan Eichenberger <eichest@gmail.com>
Cc: linux-phy@lists.infradead.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250305144355.20364-1-eichest@gmail.com>
References: <20250305144355.20364-1-eichest@gmail.com>
Subject: Re: [PATCH v2 0/2] phy: freescale: imx8m-pcie: fix and cleanup phy
Message-Id: <174163758978.467704.1139455752621643908.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 01:43:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 05 Mar 2025 15:43:14 +0100, Stefan Eichenberger wrote:
> The imx8m-pcie PHY PLL fails to lock under certain conditions when
> returning from suspend. This is resolved by asserting the PHY reset when
> powering off the PHY during suspend. This ensures that the PHY is
> properly reset when powering on again in resume.
> 
> Changes in v2:
> - Remove unnecessary check if perst is not null (Philipp)
> 
> [...]

Applied, thanks!

[1/2] phy: freescale: imx8m-pcie: cleanup reset logic
      commit: 97e8a2ff28a3dc36ca3cdc94f37359852d7e1c8b
[2/2] phy: freescale: imx8m-pcie: assert phy reset and perst in power off
      commit: aecb63e88c5e5fb9afb782a1577264c76f179af9

Best regards,
-- 
~Vinod



