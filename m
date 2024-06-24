Return-Path: <linux-kernel+bounces-227574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00310915360
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2EE281D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243F719DF65;
	Mon, 24 Jun 2024 16:20:38 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D19919E82B;
	Mon, 24 Jun 2024 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246037; cv=none; b=MKfk0BYjXqvviEhgZnfT9/1L+UNJaYc+XnJXdUy/S/ol3iEUcEBYiuOMkXlws+/jG1mCWVxpbb7h4t4z4iLuYutUukptOM6V6lVrN4f1mX5h6Adkpa2vQLDyz+Op0mdYurFIHqarG1x0DRITO1ELjCrwTXkKnbCjlYKAJPfHphk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246037; c=relaxed/simple;
	bh=zKykZVfJeRZm/1OlnyR9SxuuckkGsRlGDFIGd1fz4fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ha8q/HANeKUOuxQOm6jwTLaBFlH5xuY+9kqWr7TlcBugdehd81VlQChKbE4MiW/QufOR0yATjW9oHjhlaoHKNym3+RKBl0PK6UEFrjLWsTIa1NuD1SYTxxDu+3H/wFfoe5SaJYqjCt2KxBGgGP9uG/aKVmu8yRo9RSXXecOQKK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sLmQZ-0001wn-CQ; Mon, 24 Jun 2024 18:20:23 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	didi.debian@cknow.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	dsimic@manjaro.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi 4B
Date: Mon, 24 Jun 2024 18:20:13 +0200
Message-Id: <171924573796.612064.8146729525708691271.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240623115526.2154645-1-andyshrk@163.com>
References: <20240623115526.2154645-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 23 Jun 2024 19:55:26 +0800, Andy Yan wrote:
> According to the hardware design, the i2c address of audio codec es8316
> on Cool Pi 4B is 0x10.
> 
> This fix the read/write error like bellow:
> es8316 7-0011: ASoC: error at soc_component_write_no_lock on es8316.7-0011 for register: [0x0000000c] -6
> es8316 7-0011: ASoC: error at soc_component_write_no_lock on es8316.7-0011 for register: [0x00000003] -6
> es8316 7-0011: ASoC: error at soc_component_read_no_lock on es8316.7-0011 for register: [0x00000016] -6
> es8316 7-0011: ASoC: error at soc_component_read_no_lock on es8316.7-0011 for register: [0x00000016] -6
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi 4B
      commit: 5d101df8fc3261607bd946a222248dd193956a0a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

