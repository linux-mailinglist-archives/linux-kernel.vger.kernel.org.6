Return-Path: <linux-kernel+bounces-536047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9057AA47AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D937A4C46
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5425B22A4E1;
	Thu, 27 Feb 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="BtlIf09N"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B07422839A;
	Thu, 27 Feb 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653765; cv=none; b=KKFHiEpF+2Pm5wFGuVxVm6vQvvkMQfApFHMiA70untUxGnXNOIdCSuRSSTHrfqX2ZL1OerWtukO+Za7K55wWM+9MbAvSZTG1EC88IVp3Zxy4XxydjzNmKN+xXEYDi8vYGPqkY7L+Bt9+T4TQ1MPmFnyAcegMKVj301uFs7MmqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653765; c=relaxed/simple;
	bh=KXP3LNyE+h1xU8A2LUdGkzZ+U2wC1YiPrx45+zWhOs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDANAZFKS8Z5qa5FUJjVZzj6KLR56Y4hKp/IY2AJJIVtFV0B00n2UjA3XNDmD6NgYWB6BfmlZPB2MWv0vLamwp9gjyC090v2JnNqtpi23xLxOm75DpWclFB2lUEZ0Ib55maNAvlDHWIhGV5ZPB5m3Kfq0v77wCEUkvY8u837CwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=BtlIf09N; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WAw3zkvChaokZP/EIQV/XtYpCHOZ+jZa4e8VVZ5rP1E=; b=BtlIf09N8Z01zGJauVBo20e/ic
	lj9FcGghUcxKjgDzdvU9VqJ+tXybxXHe9L9WmuX9W+9h/mIhiOfrcygo4I/IFc9KtNEA7J+sTIYan
	mVfF5e6muJRdMsllk7UfHDdCE3TE2kXNIKcdifaGQC7b4LHHTXYwXH9oBl24944q4S/75vqTtswZu
	+gR6ZlHFHAEbhiLeL7mIZUMYLwfnS8GrbchupZFxERLhOgSvFTJ3Q4F2IGZQEjBXdy9dm0gp2Wn7T
	XuBabPUGxa443riihq9Oajkg8659gs3TwoGjf4tyCauVAkJAFmlOAxEQzUF3qNdlZCxjpx6p0IMqG
	DUWUHvmQ==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnbY7-00008f-5I; Thu, 27 Feb 2025 11:55:27 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	kernel@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/5] Improve Rockchip VOP2 display modes handling on RK3588 HDMI1
Date: Thu, 27 Feb 2025 11:55:14 +0100
Message-ID: <174065370896.4124124.16006853478934870173.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250223-vop2-hdmi1-disp-modes-v2-0-f4cec5e06fbe@collabora.com>
References: <20250223-vop2-hdmi1-disp-modes-v2-0-f4cec5e06fbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 23 Feb 2025 11:31:36 +0200, Cristian Ciocaltea wrote:
> As a followup to getting basic HDMI1 output support [1] merged upstream,
> make use of the HDMI1 PHY PLL to provide better VOP2 display modes
> handling for the second HDMI output port on RK3588 SoC, similarly to
> what has been achieved recently for HDMI0 [2].
> 
> Please note Heiko's fix [3] in of_clk_get_hw_from_clkspec() is also
> required for boards that do not provide HDMI0 output, that is to ensure
> devm_clk_get_optional() returns NULL instead of ERR_PTR(-EPROBE_DEFER),
> which otherwise would put rockchip-drm module in a permanent deferred
> probe mode.
> 
> [...]

Applied, thanks!

[1/5] drm/rockchip: vop2: Improve display modes handling on RK3588 HDMI1
      commit: f8dd7fc9ba88bc4a6ea85269287a51fb756440e2
[2/5] drm/rockchip: vop2: Consistently use dev_err_probe()
      commit: b06d1ef3355571383cdb463cf0195b7a02efdfbf

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

