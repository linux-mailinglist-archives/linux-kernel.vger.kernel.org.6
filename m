Return-Path: <linux-kernel+bounces-402974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0F69C2F25
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412D7B21954
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 18:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7D61A00F8;
	Sat,  9 Nov 2024 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="IjqO2O87"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5C519E96B;
	Sat,  9 Nov 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731176975; cv=none; b=EnQfW2LSoyXBJSY72hhyoO9PdawzEBdu32j88coLMdr8SLM/WaYmW8p4mhh2Og2VIEzLNJlWBWtBF31m/i0LfjSwW8pozTgPhiKLbOt8nn0YnQvgLMpc4Fi4YOlGM0iyk2rar81gI22ws+2eDSYCYqSjD5NcxN6UxWxTTibjUm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731176975; c=relaxed/simple;
	bh=msJJEkd7o3dp4be5DSGQK2rwe1g3p+MgmZvlvfGZuI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdSuIiorkynFcnySO7lqsfRei6ZFTnAQq0AQSs96o03hvTBDo46z1N76zs/C7RIUISUjLhp8tbtEEp/GFP/NFEx1/AmT3WaD0LucKTA1wDxU9Pr6pxDJR+s4uOp2yOtFKa4MLAJPkmKoyucOEe42GvMoJclpEIKwb3XpL1QAMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=IjqO2O87; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4G1FjBzeSEZRf8IgX5k3R4WKY6Al61s+kAOhnejUrYg=; b=IjqO2O87kJ7ViWtF/ZP+EajbGN
	lNpusQ15opEQcU+RKo7Z0OFSsB04XwN7kN/tw83vyefBtxeMkLGfMsWT+PKGaPw7/vk/d9Ttki3BW
	ylGuSp5OaOGbh2YR0DnKGpLvR3qdbYKNol3h98rdsGBN0EU2mHdOYpgQ9CP8zh8wThEAwnrvdTvxK
	apjuElOJiiZUZszMZ0EEffvsG5HhSPDukEd+QGV5gQDiEAV4PVdVwDwMqZDrTman5PvZaqpZWntpK
	sAEZ9pcxMC6KRgpeBC5IwIDNivy8taoWGnvBdbNNb7jwNCrW0Oxle39ncy9AoEprPqb49Uh5agG23
	LYxXjaNg==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9qBK-0007Km-K9; Sat, 09 Nov 2024 19:27:34 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Hugh Cole-Baker <sigmaris@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
	John Clark <inindev@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-rockchip@lists.infradead.org,
	rick.wertenbroek@heig-vd.ch
Subject: Re: [PATCH] arm64: dts: rockchip: enable USB3 on NanoPC-T6
Date: Sat,  9 Nov 2024 19:27:19 +0100
Message-ID: <173117675955.1131306.3275734524301023495.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241106130314.1289055-1-rick.wertenbroek@gmail.com>
References: <20241106130314.1289055-1-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 6 Nov 2024 14:03:13 +0100, Rick Wertenbroek wrote:
> Enable the USB3 port on FriendlyELEC NanoPC-T6.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: enable USB3 on NanoPC-T6
      commit: 2b47332134e4cd29078b3fb7d30b0a0555af01f3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

