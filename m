Return-Path: <linux-kernel+bounces-375631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E512C9A986B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC2A1F23B82
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AD11311A7;
	Tue, 22 Oct 2024 05:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2IyjgqM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292361E4BE;
	Tue, 22 Oct 2024 05:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575115; cv=none; b=csGAplfLpvQHjzGZ28dJvVWgp4yFCqlvY8LeV4pa5mMHWmCHUZA0nfcCLEOt9k44pV306QaTwsAmOy681xr5/OpeHjrHjQCMCwPrFvx3Xxqar2s6rD4/SbRZu5dCZbuVKPLWQgBvVjRaGVakoqkxQPAyAH+94Yqm9t2WSIv70us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575115; c=relaxed/simple;
	bh=WpzUCD5oMsbsOUreT838w9WGsW4pfnJSXOpKPCHuzLo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qHxovsCdoTsykqPS5pPCUT/bgSt73MT457HsIu7vnnPDY8O2/vtnVNqqOfRbYF8IVEpOsth2LSgIorEYSzB0aZCQK3i625tSKQfJWdIL1bSCMwQG4K7n2ywJ59REI8DhZ7avN61duLlwPIhp1z0iOXmOZS5bTzHI4Dxozu4xG4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2IyjgqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC3CC4CEC3;
	Tue, 22 Oct 2024 05:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729575115;
	bh=WpzUCD5oMsbsOUreT838w9WGsW4pfnJSXOpKPCHuzLo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S2IyjgqM5W0v7zmpWqqYUZn0H6eP7jFPoFQUgwNuo5OYXfxGUrg0FgfL0pXQyyfYX
	 m8mXRW3oYdAHAHLWsTjQo8qR6r4zj2hwGp8Xx98VG3XB2/GcpS4cKiMcaYd2ntG/vo
	 AvB5d66unhA7iMHLXdXEyLoT4pVCnRZSYZ6Gy4knKkxgJ3MVckGv5+LsPiVhE+EdXZ
	 GRXcTr/S4kVWq0VdUGZAuVpRN9N7t3MdTzDl1TobRCPyp+dxvwfTprtF8yLv+Cp94O
	 K1oqFa9bwuN5cSaWGmq+4UNp/dGpDI3ptQNKOpgnCa8OL9TYigIW3ShnwoGyf0SXxi
	 znWN5LEy0nLOA==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 festevam@gmail.com, Frank.Li@nxp.com, marcel.ziswiler@toradex.com, 
 Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 kernel@pengutronix.de, stable@vger.kernel.org
In-Reply-To: <1728444303-32416-1-git-send-email-hongxing.zhu@nxp.com>
References: <1728444303-32416-1-git-send-email-hongxing.zhu@nxp.com>
Subject: Re: [PATCH] phy: freescale: imx8m-pcie: Do CMN_RST just before PHY
 PLL lock check
Message-Id: <172957511146.488725.17746215467139693428.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 11:01:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 09 Oct 2024 11:25:03 +0800, Richard Zhu wrote:
> When enable initcall_debug together with higher debug level below.
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=9
> CONFIG_CONSOLE_LOGLEVEL_QUIET=9
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7
> 
> The initialization of i.MX8MP PCIe PHY might be timeout failed randomly.
> To fix this issue, adjust the sequence of the resets refer to the power
> up sequence listed below.
> 
> [...]

Applied, thanks!

[1/1] phy: freescale: imx8m-pcie: Do CMN_RST just before PHY PLL lock check
      commit: f89263b69731e0144d275fff777ee0dd92069200

Best regards,
-- 
~Vinod



