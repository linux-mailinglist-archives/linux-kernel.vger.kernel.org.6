Return-Path: <linux-kernel+bounces-436499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B97329E86CC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69081164230
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A573189B83;
	Sun,  8 Dec 2024 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Htw7HIZd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73220323
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677146; cv=none; b=U3XykvhAFJiX///oXWuLairaomTU5NlGIgCUsXO1sUlWbPVESJNXmJ++6PL/17UzfrN7povyY5UCzz7URDFWeYL8p7WA9IDIFYDYtDAMJoh1UhfcSK/N3cRp3QCdG1WkPDkQI2+OftWRJWM3rum725z09NRYjtPIeHVygiXNM7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677146; c=relaxed/simple;
	bh=csE7uy0VuBahmgf5oPd1u9Pm9Uuc0fog2i/ia7R4hUU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iNPrFDL5x/JLLWNOIK1dWq65n6P0qXxwnPHb18s1H2NoMKwzJWCjnpHredrqXwzfTvq04C/9s3UQ0eJGcXfdEWoEK+zwWkP3sal13viyAAGRCg+pkvqm5dVsK0EoEv0QvCX9NnsTeEhl60aXO6To1E/SkYBzUKFJza7YcTa5FVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Htw7HIZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92D3C4CED2;
	Sun,  8 Dec 2024 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733677146;
	bh=csE7uy0VuBahmgf5oPd1u9Pm9Uuc0fog2i/ia7R4hUU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Htw7HIZdEhe2LScDIEdOM+f1t+IatbxgCkTl9b3LP718mi7na7alIiOpLSxG+JICo
	 umt8rYK0wr+amLvDz8KOXr7b7jOe3uiCD37W7IAQSUDBdYQ9sa3q+otw9UelCNoAsu
	 xYuX2h9qNRv77t3X3GHauTM1+BW4C+IvD3Gg1yoYlVriNAoVtBrCBwXbjSHTPNX+wh
	 L+oSYYouNXI/08BOwkm/zqExYNCBz03HM1gqceE1BocBGzjqb6y3YYOdIFe5XOERJ8
	 T3QC5YX75OTcz8d9hAQYJkk6UWTPD0ZHsfNOKxDckN8TkDMDuwxTFrOgpclIYdO3NJ
	 B8d8lrUdUiaqQ==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20241023-phy-sam-hdptx-rpm-fix-v1-1-87f4c994e346@collabora.com>
References: <20241023-phy-sam-hdptx-rpm-fix-v1-1-87f4c994e346@collabora.com>
Subject: Re: [PATCH] phy: rockchip: samsung-hdptx: Set drvdata before
 enabling runtime PM
Message-Id: <173367714219.1031947.13630149874442977785.b4-ty@kernel.org>
Date: Sun, 08 Dec 2024 22:29:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 23 Oct 2024 20:29:54 +0300, Cristian Ciocaltea wrote:
> In some cases, rk_hdptx_phy_runtime_resume() may be invoked before
> platform_set_drvdata() is executed in ->probe(), leading to a NULL
> pointer dereference when using the return of dev_get_drvdata().
> 
> Ensure platform_set_drvdata() is called before devm_pm_runtime_enable().
> 
> 
> [...]

Applied, thanks!

[1/1] phy: rockchip: samsung-hdptx: Set drvdata before enabling runtime PM
      commit: 9d23e48654620fdccfcc74cc2cef04eaf7353d07

Best regards,
-- 
~Vinod



