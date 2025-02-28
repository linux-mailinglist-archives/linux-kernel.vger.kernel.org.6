Return-Path: <linux-kernel+bounces-538571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4885A49A57
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DFC0173EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B12326D5BE;
	Fri, 28 Feb 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="kPe4pB8Q"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFD817A2F4;
	Fri, 28 Feb 2025 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748549; cv=none; b=aZ2CxMCpXPWCB5LofhoxVMMR5+GvcjTZMrUlSbih1TOcBgNOPEAxDNjTEL9AhtgnF7XFA8f8eXKhAkiGve5b4v+XsGoN+kq0x4rpFSd9CCBghe/V8TZcMeTFp5FHJ7sbQ+bEU7gehVWm4ds83qAAwbWfsTcGuQjUSM8b1hjLWq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748549; c=relaxed/simple;
	bh=edfNWr4M6iN6tPiH6cF+Whz98Hw2cym+i635p6mPMHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n7KdjDIVI0BgeTYYOS5kj6q7Nx3ISKvleNNwgcqGWmcNY9GzcmpLiv/gMAhUV9m7XQrXaiHsaEsy4FOacoiSFyuFWEL3bMWhoi95tB/Lv9Z77l7VOQURsrshMlemDc94pU8NP8mkS9JZIZsJodVoh//H9400sQQcUQnOvvd0V7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=kPe4pB8Q; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1740748539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/KPza773U4ZAtfv2ADrHNglgC1639YAh+ulMqKIYV8=;
	b=kPe4pB8QfH0t26AvlrjftXluSDJSZEY18CXtmvJdWvvaAlXUIWSeN0xE1fVGTEXsoCDWez
	Bn0jjcpDlZvgrd3vZMgICUmwQpNci26Gcb7biW7CTYnYq8n2bgypBnsTY69KCqHI2JiwYI
	rvyGhXKePJGo0kMoONZLCfFBoVEYlFaXvPLvwg9GLNYdAlkbfs1RnSD2v5/TlcsH1llioU
	NgTOU0yE9gDi73Egcwe3KEal2s3GEJUJ49lPUvP+XhqKfYhbMOB33maFNTgyKXN3HDicYu
	TEgwZi2zPYn8QCcBG25SKdqS6YLZwWS4Z1doDilP5pOJ8n6SU7H97bD2fIvuGw==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH 1/2] arm64: dts: rockchip: Add avdd HDMI supplies to RockPro64 board dtsi
Date: Fri, 28 Feb 2025 14:15:28 +0100
Message-Id: <3deb832a4c6266d1820eaea02db8805c1d952938.1740748439.git.dsimic@manjaro.org>
In-Reply-To: <cover.1740748439.git.dsimic@manjaro.org>
References: <cover.1740748439.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add missing "avdd-0v9-supply" and "avdd-1v8-supply" properties to the "hdmi"
node in the Pine64 RockPro64 board dtsi file.  To achieve this, also add the
associated "vcca_0v9" regulator that produces the 0.9 V supply, [1][2] which
hasn't been defined previously in the board dtsi file.

This also eliminates the following warnings from the kernel log:

  dwhdmi-rockchip ff940000.hdmi: supply avdd-0v9 not found, using dummy regulator
  dwhdmi-rockchip ff940000.hdmi: supply avdd-1v8 not found, using dummy regulator

There are no functional changes to the way board works with these additions,
because the "vcc1v8_dvp" and "vcca_0v9" regulators are always enabled, [1][2]
but these additions improve the accuracy of hardware description.

These changes apply to the both supported hardware revisions of the Pine64
RockPro64, i.e. to the production-run revisions 2.0 and 2.1. [1][2]

[1] https://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
[2] https://files.pine64.org/doc/rockpro64/rockpro64_v20-SCH.pdf

Suggested-by: Diederik de Haas <didi.debian@cknow.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 69a9d6170649..47dc198706c8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -227,6 +227,16 @@ vcc5v0_usb: regulator-vcc5v0-usb {
 		vin-supply = <&vcc12v_dcin>;
 	};
 
+	vcca_0v9: regulator-vcca-0v9 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcca_0v9";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
 	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
@@ -312,6 +322,8 @@ &gmac {
 };
 
 &hdmi {
+	avdd-0v9-supply = <&vcca_0v9>;
+	avdd-1v8-supply = <&vcc1v8_dvp>;
 	ddc-i2c-bus = <&i2c3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_cec>;

