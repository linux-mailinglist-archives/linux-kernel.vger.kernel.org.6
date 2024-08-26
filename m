Return-Path: <linux-kernel+bounces-302391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9595C95FDB1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 01:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96FA11C2206B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92E61991D0;
	Mon, 26 Aug 2024 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="dxjrqrgx"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7919DF49;
	Mon, 26 Aug 2024 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713669; cv=pass; b=LjMEw+KdvrgygZKaRr6czfg23y89C5zE/kcXnlh1M6+o6MN83t3XztPtlgELcn7TQB3KqlWMu2hLQrF56gmE1d8/0sxgKmeztanLbgOnM6pxztJnmoQQH7py2KSSq+zdrVSlghnNqCLG0FBfPbRekdyqBc+iAiR0RH4RFmYTsf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713669; c=relaxed/simple;
	bh=1UOqS2Dxo8iR9T9B1fLDBZrWdN8+C3Mh5hkvpGIoXa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PzRxgQRGfgiV9FmQqqm+9fo+uKGJCpr8/Kq5RimjUjsWl5gMszfq5Ob4asdc6zKVY7dRTrdkTvc31Yfnm94RKriBkannOttVwsqF87Nn2B5xVC0oYqGvNVU8dMNNAmCmypK1/kE01zgGlHzgVOnPEzfjkbHEmUyBxVih4WMEYGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=dxjrqrgx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724713656; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OfCkRUbsQEvxat4XQIRYlqToGp1J39wm44+qv757qhoqwcYbgRp/78pJDX8QmoKCuGvikH+2/vLFnwcuzOtJZDirIepIUUDGLHhuEqITmQNC9wFXduPvAV6Vz42BUyCvVdNeHd/hkb5U4EWeNhqZdiFJXSO9ld4AjepNrzdTPYo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724713656; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NHu1lK8y+binnoeFm6Jqz7QKNR4uii4rwsRkUGw9AYA=; 
	b=bnPqshmOmixHJEb8ZwFs6G26TG23cqtodWiR4t9xzfJ9/w9vc6zC5y0ErnzBmZyk4PfNBFNZ//YSpLr+PqNH3g+8zCMs9/Xw0aoXwVXGy1tcBm0hqhbjBkeuSYb4IfrHLnocg1kaVoKZAW8hDZHCbh9gspYPcUyWVCee7QKRahU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724713656;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=NHu1lK8y+binnoeFm6Jqz7QKNR4uii4rwsRkUGw9AYA=;
	b=dxjrqrgxfBkiwvtotSEIuDHcmhzBwlyMSZGtEqVWTCdCtlNGQ+uqQdqbjIB58mUe
	j5oFonSe++1fdsJ2JIYfkk5lBcWdrqoqt4uYtBVksIKwlvenQXIk1mCa70DxtFhSLJP
	XzjKV+/rptReYLZS8tFjgQq9jLDNNbeybvi18oDU=
Received: by mx.zohomail.com with SMTPS id 1724713654812611.7088986874687;
	Mon, 26 Aug 2024 16:07:34 -0700 (PDT)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 27 Aug 2024 02:06:51 +0300
Subject: [PATCH 2/2] arm64: dts: rockchip: Fix compatibles for RK3588
 VO{0,1}_GRF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-rk3588-vo-grf-compat-v1-2-d4a18acf951a@collabora.com>
References: <20240827-rk3588-vo-grf-compat-v1-0-d4a18acf951a@collabora.com>
In-Reply-To: <20240827-rk3588-vo-grf-compat-v1-0-d4a18acf951a@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
X-Mailer: b4 0.14.1
X-ZohoMailClient: External

RK3588 VO0 and VO1 GRFs are not identical (though quite similar in terms
of layout) and, therefore, incorrectly shared the compatible string.

Since the related binding document has been updated to use dedicated
strings, update the compatibles for vo{0,1}_grf DT nodes accordingly.

Additionally, for consistency, set the full region size (16KB) for
VO1_GRF.

Reported-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index b6e4df180f0b..ee99166ebd46 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -582,14 +582,14 @@ vop_grf: syscon@fd5a4000 {
 	};
 
 	vo0_grf: syscon@fd5a6000 {
-		compatible = "rockchip,rk3588-vo-grf", "syscon";
+		compatible = "rockchip,rk3588-vo0-grf", "syscon";
 		reg = <0x0 0xfd5a6000 0x0 0x2000>;
 		clocks = <&cru PCLK_VO0GRF>;
 	};
 
 	vo1_grf: syscon@fd5a8000 {
-		compatible = "rockchip,rk3588-vo-grf", "syscon";
-		reg = <0x0 0xfd5a8000 0x0 0x100>;
+		compatible = "rockchip,rk3588-vo1-grf", "syscon";
+		reg = <0x0 0xfd5a8000 0x0 0x4000>;
 		clocks = <&cru PCLK_VO1GRF>;
 	};
 

-- 
2.46.0


