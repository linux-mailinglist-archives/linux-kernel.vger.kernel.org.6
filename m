Return-Path: <linux-kernel+bounces-344903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D3098AF72
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE6F1C20C84
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3333F188A01;
	Mon, 30 Sep 2024 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="O+VtSKTS"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAEF185E53;
	Mon, 30 Sep 2024 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733010; cv=none; b=qK1o2bs5u6njxMxwLxahgxuUKtimzR++O7ySvOkAQWFhfV0si0T3DGYFpNrJ/98lrmKuAA8tZ5EJr9MPJLLi5rUIhRA9/4yjiA7HLMwnhsJHdVDu1+/1u3fC1tzFFaKViDh1W0YbfKajxX/XfCzf5YkhtfSzkxXv7jIu4X7l1oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733010; c=relaxed/simple;
	bh=Zu9ZmHEw/S+vCyax1A9aq5NUBI+b5jx6fxTuO5V9qXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNYKdf5jawVrcmrKltYG/FjVP4MU9YOmgMGUbbA+PrM9m38kdZkMGGJmV4UaEw5tdjkse9p2PVnzCiajB5hnDE3wiFfiXAykfVEuJSNOQUe4E6OGSTSYOlxPSWr66TcvdwG1MTTOs/VnZgJ69gmE+1HYNbTMAA9KbKTeLyiuwq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=O+VtSKTS; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ElLMyooxudaPtiR/14gSxdboOIxN05daRQRm6iObIyg=; b=O+VtSKTS8WLfEd/qBuxFlP+AsT
	AW6kXSY70SrIXDm9ErGYwXOj6GbPkt7nI3VSgxqF4ZwXFIUTHWfvGRYUk61422/BrqLUl1EY/7qGe
	MLRPB6L/QZa2SMRHYxNfVKD0tTOhx3DYcfCYVVQf82pjkUz+on2rMjL8gIQ/Xvseuxcbshf3V9TpM
	/nRhlXiv9l7E9OOeUQCqJOOG/VUA/hEaNVhAY5vXUQsLZ0Fl8dktuY05gBTIW1Y/nSrzShKSwccp3
	FB0g8GeotbjYCEJYZD0fae9FdoVQYMac5C38zJOMf80IIpE90IpYDjRwLY6nWxDIc8q4Rrhd6oXKF
	M+BhEdvg==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svOHM-0008So-Lk; Mon, 30 Sep 2024 23:50:04 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jbx6244@gmail.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: rockchip: add clocks property to cru node rk3328
Date: Mon, 30 Sep 2024 23:50:01 +0200
Message-ID: <20240930215001.1999212-4-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930215001.1999212-1-heiko@sntech.de>
References: <20240930215001.1999212-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Jonker <jbx6244@gmail.com>

Add clocks property to rk3328 cru node to fix warnings like:
'clocks' is a dependency of 'assigned-clocks'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index cf98f1af659e..b5cbe7cab10b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -815,6 +815,8 @@ hdmiphy: phy@ff430000 {
 	cru: clock-controller@ff440000 {
 		compatible = "rockchip,rk3328-cru";
 		reg = <0x0 0xff440000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.43.0


