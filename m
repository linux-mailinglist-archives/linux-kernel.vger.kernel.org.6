Return-Path: <linux-kernel+bounces-534809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E0BA46B67
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2225D16B99B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22404256C6F;
	Wed, 26 Feb 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="A779wLZy"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBC2566F1;
	Wed, 26 Feb 2025 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599395; cv=none; b=Uw4XDWuL5oRjBC1wm8QNHnNB+rcb5OLSnYQk/IdEiu3fnBwtkhNZFfReEcxJIGknXOaHW+bj+8H/z01ou9ZGSO1PSt8ulSxRZibrCrX6SU7drlZjcKu65AQbbssVYpR5p091lTDKx5erbtWflaAkzfFM2QG2t5CQAxXusP5mPm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599395; c=relaxed/simple;
	bh=cOMlW63+5CnwhxOr0kc+QC1juYLuKHzeXf2Fqlx9y9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNKJCTtvdaS/MHYyAPHoGsjy8FxG25MzRFMMwwMgKIt8W5G2A1mkok30szs/5a4ej+iJYkkUqTAe1z/ME9EjPUey+ptBMkUCe3qqsdGizgUw0GPHo7xDCarPrxmuBGh6+pLXmzV1XbH6bERhACEWNVri1ouYUdHzh/sNNdgxMJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=A779wLZy; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=faGGqfXQbOiJ+9VytmDh1BHEK7Aeu0aHAnqiXKSPnZU=; b=A779wLZyYQY2f+RtjvixBeiva2
	o46CY6HrYmI66hHc+uKJZYwu/ISBz5MLGEKWgAocrQIAzOckCcGI+XCsinPF78Bm4UCjG59IvmQPa
	MbYcssrk+GHDBrFXUlyGdSCOwsu/jKhXutCNAzBZIE6wUuOhUSzHcdHfsQ21bQW6+W/WDyPEl/+nf
	VCwNpuhg6s8riPCnGzdt428Dn6owWifW8vLi5pAG5qXFG4AVJNIJg425ye7Aj2DqlIswMLBHS/NOm
	3kiQfQ9KbrfnG4CVqnMkrIVqD/6I1xwrYjWr2wNIFXzCiWqBPm2MVIy5n5DjQhPGPRwUld/WkdutA
	2GqBnwFA==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnNPL-0002zz-Im; Wed, 26 Feb 2025 20:49:27 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Peter Geis <pgwipeout@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	zyw@rock-chips.com,
	kever.yang@rock-chips.com,
	frank.wang@rock-chips.com,
	william.wu@rock-chips.com,
	wulf@rock-chips.com,
	linux-rockchip@lists.infradead.org,
	Alex Bee <knaerzche@gmail.com>,
	Algea Cao <algea.cao@rock-chips.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Johan Jonker <jbx6244@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Trevor Woerner <twoerner@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Zhang Yubing <yubing.zhang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: (subset) [RFC PATCH v1 0/6] rockchip: add a functional usb3 phy driver for rk3328
Date: Wed, 26 Feb 2025 20:49:14 +0100
Message-ID: <174059933844.4008853.12666956119860907768.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250115012628.1035928-1-pgwipeout@gmail.com>
References: <20250115012628.1035928-1-pgwipeout@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 15 Jan 2025 01:26:21 +0000, Peter Geis wrote:
> This is my newly reworked phy driver for the rk3328 usb3 phy. It is
> based loosely on my original version, but as of now almost nothing of
> the original driver remains. The main fix here is the discovery of
> BIT(6) in the interrupt enable grf register fixes the usb3 disconnection
> detection (mostly). On occasion an unpopulated usb3 hub will take
> several seconds to disconnect. However this means all of the hack around
> work to reset the usb core manually is no longer required.
> 
> [...]

Applied, thanks!

[1/6] clk: rockchip: fix wrong clk_ref_usb3otg parent for rk3328
      commit: a9e60f1ffe1ca57d6af6a2573e2f950e76efbf5b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

