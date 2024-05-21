Return-Path: <linux-kernel+bounces-185456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD328CB527
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2561C21250
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9516414A638;
	Tue, 21 May 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Lste9Qc3"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32714A605
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325863; cv=none; b=h/gqRgSsMvDs4/dc8ile4Ihs5kRK8Y63UOgTCPfWh9nmsur/RRMosWaNsNyV2TEiy7ZFCQCZ2PB89LnjrUZrwfbTETmyM12vCrIwPs4fESTD/YsbFPRqlAU89pel3vPIXAwOo7R+DhdE03XJoMaSAA011PVahHFqHEZxr7w9vLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325863; c=relaxed/simple;
	bh=kOgT/JZfwWUHx+y7UmBZSvwjEG6AF27WnqS5AMiFIoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0QECd7jftVNJs+ZDl+wOK8cLvSZbHfa4haOay7Rr17l5gamoav3JHiEU8SjkYJ9nTnFYB5n5sICVAqOGQ38lmcZZEPiaoMI2+pgcu6jQDm8+ma4PJi1Kc6K38BvQNHfYv7Y+6hHeaQnYJdZIdYKzd3VahetIwrXKf5RBoYgJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=Lste9Qc3; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1716325856; bh=Ev0NHWSBX5JjUj4uBw/N7Wq5Lc5EXlpKnAR2GucfNhc=;
 b=Lste9Qc3EY7FG4DKDXZcuohKo8Wcb0qof/BJUNvEngVNmW+pnoLaLNzcW0Y+39M305PdK8VNP
 W7MB8xEg3cFR4wgaxLTvniYATMeLXmxjQ83RdaXjk7tVI5zy8b6jTnUNENzfkTiIkV0IxWQJ/Xc
 eBqGp1ZI0vC0QzOY/11/0RyCzXz3s+w33tmkvVHqKW6MPjEOv5FQuI+101wzIc81p/+lwsySa1P
 iI7iKxj5ZwzjetkAVeIQcEaDtNGcYT2bTlpk0ZA4FXVd3sKS/NgCEdV+U+Nwz6GjlvzGae15LBe
 yJM7ZUuLe2ubOqg5CsINXNTdhNJFk08Ayq3OPxgdhvlg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sjoerd Simons <sjoerd@collabora.com>, Akash Gajjar
 <akash@openedev.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 04/13] arm64: dts: rockchip: rk3308-rock-pi-s: Add sdmmc related properties
Date: Tue, 21 May 2024 21:10:07 +0000
Message-ID: <20240521211029.1236094-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240521211029.1236094-1-jonas@kwiboo.se>
References: <20240521211029.1236094-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 664d0ddc8b6b0c828344aedc

Add cap-mmc-highspeed to allow use of high speed MMC mode using an eMMC
to uSD board. Use disable-wp to signal that no physical write-protect
line is present. Also add vcc_io used for card and IO line power as
vmmc-supply.

Fixes: 2e04c25b1320 ("arm64: dts: rockchip: add ROCK Pi S DTS support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
index 84f4b4a44644..a2ec62a377e1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
@@ -266,7 +266,10 @@ &sdio {
 };
 
 &sdmmc {
+	cap-mmc-highspeed;
 	cap-sd-highspeed;
+	disable-wp;
+	vmmc-supply = <&vcc_io>;
 	status = "okay";
 };
 
-- 
2.43.2


