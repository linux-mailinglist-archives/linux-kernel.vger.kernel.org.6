Return-Path: <linux-kernel+bounces-536425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C5EA47F55
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A947A63DF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B1E22FF37;
	Thu, 27 Feb 2025 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2X6+AYCj"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528222FDF7;
	Thu, 27 Feb 2025 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663505; cv=none; b=ANGV+SJcqoUACT//hvv+w/hdbOpLAMWvGgllrjpnFTjjYSAvok1HR7ZXqhztYxU05i6lynmDIMLnHu9BQ8ebJQmMjNrgH0pSpfnECiZqmerWlGH2WRTwFrKCwGIeHaiEmrVQpgoXi1N0Jpn555ShG36I4F53jb4MWjF1caEe8ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663505; c=relaxed/simple;
	bh=KJSoT1s0avyboN3Xe3qdmFlE/wZurH+9YiSx+7VKphE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TY/+mqXTxp92xc3J8Z+hPzMennzlt4e0EXkTClMdwqVSjGEuEgLROYf2j58g+3W65NgE2EgLO4m+r+m4VgbFvdWGpHiZq3G7xAA5s3QN5oqF4ZVDaSelsQW8kmOam/l5RmjWBGZFp9bn1eGozIWyfQhJKBYpW78h+EmBkeRbUMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2X6+AYCj; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nOu+j+JKEXyX2pMqzzEYhOh3lseG192GhrOVf61bCqI=; b=2X6+AYCjWGmv8WbrZiVmeP3m99
	rIwRjrx2PTjOiGQ/Jwe1t6y8Lnye3e8QMfg9YRNhiNNC2FTEEwNuoaWs9fHjjL/gMFMeYXQYc7FEw
	Uq8NGml7FQRWUVZRJppVnSS0acR2Ji2QsjwHNLNiT2gc4bHHZViiMYEaqBTVysMl9odQc0r+rO/7j
	pHO9kLXLiIgq1aZ6rgDobu1+gXywa3SWqPN2TwWPo5EvE2GCcNjPVy909tVsnu1cmSEWocArkjPP9
	8e32h8QjAacf/XgHhufaK7DgPujBFffdOdNBhN9qsRPgvVQY3R0eCPxiEemdNq+Wc+Wl6/J0mbdQ0
	LAc57yuw==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tne5a-00018T-Tl; Thu, 27 Feb 2025 14:38:10 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add hdmi1 support to ROCK 5 ITX
Date: Thu, 27 Feb 2025 14:37:56 +0100
Message-ID: <174066344875.4164500.15325619572257309291.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250225030904.2813023-1-liujianfeng1994@gmail.com>
References: <20250225030904.2813023-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 25 Feb 2025 11:08:48 +0800, Jianfeng Liu wrote:
> Enable the HDMI port next to ethernet port.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: add hdmi1 support to ROCK 5 ITX
      commit: 3eac9319af62dbc56d1f06fcb240e4a092fa5b2f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

