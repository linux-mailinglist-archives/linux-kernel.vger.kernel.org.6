Return-Path: <linux-kernel+bounces-402971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FA49C2F1E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22956282418
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBFF1A9B5A;
	Sat,  9 Nov 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="drIzVRww"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E661A2C04;
	Sat,  9 Nov 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731176860; cv=none; b=bWzlgvhkTVch4VAgqOzqW9EkJMOQJaV1EzHhm36M85lW/mNLpDcAYU9G9pyVgIE4763Ht1fZvz/88RLGopQ48s4ae4SQgvbKkOR6mbij/FQeKUO8vvAo+mep3gar+73ZagsNip051zKkZWsvXS2GXXrwdGG31PSzjriMTXEjols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731176860; c=relaxed/simple;
	bh=yCIgyTij/CDbrG3iQAdQ1Lda3GiK6dtBUYmzSm8hi0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cK1f5XKJxSYyIenei/Z1KIYJ6dtA5f/He84Q4PRbEqqhmQtnXPQ85Xr6yz8dYagcZ1nnmquT4+hd6MEfDTvqbNmoARc0o6bqkomN/d8wVBvErkFid3vQTetaHM1hbqaj27rl/NYarOoC0fdf70WiJ8+CcHM3iqO/Fw21G+Pg8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=drIzVRww; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gPWEWQwKy1T/x6ugN2mPNFT/qPZ0Ya980gZlamX26Vc=; b=drIzVRww9gD2qaqcSIZBI3+4fv
	R43MRG5G/ar0InbcUwyQbmm95DcH81Ii6lLgyqyPnoViJMK9CKRhAxrHvUL4jwYj81ZBle/NfloFE
	WcitD7ztGuRtDpzCFiFXTH3sbD5iOgmIanohhxxN1/t0Sqkpov4bK04Y7AK+jqXKiPJKIv4Iiz2hA
	TP9boUUyyjRpRDRh695PzbwESpJVMSfAox/d7sPsqS29zlv14HNbifs2PbpY9zWhWl17tFev9LEan
	WHwy0sPZ+J22hif7hDr3b7yR6KxlKq0LDkEmqMH1lk3j7nclxnruE20X7l9Udr0VU3I5gQ4LS/8Z2
	PKQhwrOA==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9qBJ-0007Km-D0; Sat, 09 Nov 2024 19:27:33 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Enable HDMI on Hardkernel ODROID-M2
Date: Sat,  9 Nov 2024 19:27:16 +0100
Message-ID: <173117675954.1131306.14874061306696804810.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107211345.1318046-1-jonas@kwiboo.se>
References: <20241107211345.1318046-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 7 Nov 2024 21:13:43 +0000, Jonas Karlman wrote:
> Add the necessary DT changes to enable HDMI on Hardkernel ODROID-M2.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable HDMI on Hardkernel ODROID-M2
      commit: 64a098acf119d2a599c744dbce531668fbdabab1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

