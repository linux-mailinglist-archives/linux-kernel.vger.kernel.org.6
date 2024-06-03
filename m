Return-Path: <linux-kernel+bounces-199284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD6C8D84E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3A928639C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C4B12EBCC;
	Mon,  3 Jun 2024 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXqGi0qA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D65512E1ED
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424798; cv=none; b=nzmc3lulMa32vxwUC/N+7hxVg+DZD928FmlTnJjb4+HW11aFUYtxGoVidYOL5xCaZUS7xiZ1lh+fHd1rZLGZmjs1WVZdYzgMiJU1Mej6BFAqJgHBbAWTXVagNA8wIhLDY63H+TS+TMkZ7iGD/e+Ew7dTFv8WZV0I7Hqt2fpbWjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424798; c=relaxed/simple;
	bh=babrRrnBNR9UN7pLa5drZXRQIepsXaNY6xfQSs4kKK8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oCAPBe4v4FWJ/lexW2JYugV9CfwmijFObSWzTFSfXDoFQRoUZdaGk618vrwaAl8FZwaGEKxgxL9FrLGxSa9qdjRtju088gPW30jZ/MnYYWdbR2HDj98ZnNagIIxpTmjzo4kbyFYgkbYV6hzHoTheg3/NbR4EBveeu6Inc/wTENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXqGi0qA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2890FC4AF0A;
	Mon,  3 Jun 2024 14:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717424797;
	bh=babrRrnBNR9UN7pLa5drZXRQIepsXaNY6xfQSs4kKK8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rXqGi0qAxy1y+n6UgcaNh82wOdtaKvO5c4fDiHnlB9XPdIYeHo3i4GB5skrbQpFXu
	 BQr74Cu0UQtLTX9dsUlZRWXDBjI0OyBF6yC3/w1K/SoDyfwazA13hTXYntj1T/obq/
	 iwiKfA5EgKL+dNCSJD7DycG/+whveUCEgBUAwtK46PtUecky91cOWS1nMCh12PLfyT
	 zX0knlj45uaqUda0p9tEIYY96b3Wb8exNcmp20lSd5lGP5f43MjCSGtjkLgY/wZGu5
	 vzeH8CICMgaswm1cfdS8yge47R40Sbs6byt9H0AgjOYa9zW29OpaxpUwLBfhuzr71n
	 CF/cdn+PtM9Rg==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Richard <thomas.richard@bootlin.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
 thomas.petazzoni@bootlin.com, u-kumar1@ti.com
In-Reply-To: <20240412-j7200-phy-s2r-v1-0-f15815833974@bootlin.com>
References: <20240412-j7200-phy-s2r-v1-0-f15815833974@bootlin.com>
Subject: Re: [PATCH 0/8] Add suspend and resume support for
 phy-cadence-torrent and phy-j721e-wiz
Message-Id: <171742479438.106728.15643482453047442146.b4-ty@kernel.org>
Date: Mon, 03 Jun 2024 19:56:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 16 Apr 2024 14:52:29 +0200, Thomas Richard wrote:
> The patches of this series were originally in the series "Add suspend to
> ram support for PCIe on J7200" [1].
> They were moved in a separate series as requested by the PHY maintainer.
> This series adds suspend and resume support for the phy-cadence-torrent and
> phy-j721e-wiz drivers.
> 
> Compared to the PCIe series v4 [1], these PHY patches were rebased on Linux
> v6.9-rc1.
> The only change is for the patch "phy: cadence-torrent: extract calls to
> clk_get from cdns_torrent_clk". Now the cadence-torrent driver supports
> dual reference clock, so the patch was updated consequently.
> 
> [...]

Applied, thanks!

[1/8] phy: ti: phy-j721e-wiz: use dev_err_probe() instead of dev_err()
      commit: 5aa4733b1b9324e224ebe59e3672887a57d51083
[2/8] phy: ti: phy-j721e-wiz: split wiz_clock_init() function
      commit: 3c4e13cf9ead79fac3b217e228c1c7d3db3e132f
[3/8] phy: ti: phy-j721e-wiz: add resume support
      commit: b5539abdd013fd3f77633413848c93f8ec84b51d
[4/8] phy: cadence-torrent: extract calls to clk_get from cdns_torrent_clk
      commit: c2286092424bf5f889f302669580fd6862967a49
[5/8] phy: cadence-torrent: register resets even if the phy is already configured
      commit: 8512b6873461c4d31f89c3260a2d5043b3f9dbb2
[6/8] phy: cadence-torrent: add already_configured to struct cdns_torrent_phy
      commit: d4f24d14f311b9a1af57c9726d5a3acbfa8282db
[7/8] phy: cadence-torrent: remove noop_ops phy operations
      commit: 81472a55edce473cfc22b340c1026c6d5219ccfe
[8/8] phy: cadence-torrent: add suspend and resume support
      commit: 0da27ed080b2c25680fb42105f3d85c0ebe38b0c

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


