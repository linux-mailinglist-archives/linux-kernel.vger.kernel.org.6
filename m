Return-Path: <linux-kernel+bounces-304999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC149627EB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03951F2533B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429E617335C;
	Wed, 28 Aug 2024 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="T5uwzijt"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD7117837D;
	Wed, 28 Aug 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849795; cv=none; b=FqBgoPlHRxneTCn1nRNvGIvk/HECKnoVVHRCXZdDU4m/G20jWr2UYM36VbmNd1TdsPskqO56tO07gLCIuv6cwyaC4PzcwwCOms+468uZF+uO7b661T8DdpuehRJnN3h6fm+wbKhv8+P0Iz5QkD7U8IFLlMtz1KxBreyz0L8xKhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849795; c=relaxed/simple;
	bh=ED0kEowP2YlQFoZ7nzO0GxZDG1JhBxAf91x1Vrr1+Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNmtC39N7EPPtTmzRCGo/M/Y+mOk5MM3KLcpdlBnQ7AJeGXxlvY412o/a2DY71B82pqaLlWJVXnhOKgnqixajv7MtgR3O/12m8sU4tJmzvYcxB3YGxLHiBj3OVqxyssmb7zzdU0uIzzN0p77FjLa2atqw1ZWTFukkPql4K3CiZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=T5uwzijt; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KRJdnybl7IHbrPfCbf0p/UNsAWFxCeqGC4Mko0BsWAE=; b=T5uwzijtI+WSiADmTXJavU0O8i
	OzLaxBL7vq06GDedNqm5TW6DL3QV0w9dHRbyUHe5MYOdfuWQWDUHdkdlk3NKwhQNY+Hxeal3A/amM
	+8/ubwZj8JgjCSO3o4up0YSMSXvradCm3Qy9g8A3JOXJkSUbXO/mx6tBxm7Xo2gZ6WM+Eu/e3ZFQ8
	dXPAR4Dkdru5Qqmm4E5jotLwNFq04AsvWlA01onOqY24MVNM4BH12fjfeR1JllM9BWUkic67yTSlq
	QoP4Pr3cX7uGTXOIn56uugOC7uwFeOg5trGgpZRvRJg4YfWFMhz2iOkzlXLlA1ZGyABZoQLWSnNDU
	izuq1Ysw==;
Received: from i5e8616cd.versanet.de ([94.134.22.205] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjIDr-0005MB-SI; Wed, 28 Aug 2024 14:56:27 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Liu <net147@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	FUKAUMI Naoki <naoki@radxa.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Enable RK809 audio codec for Radxa ROCK 4C+
Date: Wed, 28 Aug 2024 14:56:23 +0200
Message-ID: <172484978177.1499193.15230984745564646842.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828074755.1320692-1-net147@gmail.com>
References: <20240828074755.1320692-1-net147@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 28 Aug 2024 17:47:53 +1000, Jonathan Liu wrote:
> This adds the necessary device tree changes to enable analog audio
> output for the 3.5 mm TRS headphone jack on the Radxa ROCK 4C+ with
> its RK809 audio codec.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable RK809 audio codec for Radxa ROCK 4C+
      commit: 174c306321355d8a189b8f01fcc3f897ba13f227

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

