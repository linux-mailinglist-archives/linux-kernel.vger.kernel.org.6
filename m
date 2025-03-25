Return-Path: <linux-kernel+bounces-576086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D0AA70ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3B416C148
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE5C1FF5EA;
	Tue, 25 Mar 2025 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQuPkFuT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C9B1FF1DC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932330; cv=none; b=X2FX7puLc6i6cmdtiFKmQZoH+DSfBQWtrgD6ex5SPhV2Vtq2eMaeTAkQSlm1npUk13oprrwG9GCADPvXy7u+Qlx4tgBKppxwEoONsdW7EAF9WEsND+j98eH8L4Tpnm2flaQcZ/AbyydGEL3odwXkyA/ok8vgBWFwWwJRq3TPGDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932330; c=relaxed/simple;
	bh=3UdNS7KZ2benFsIbu7cR42jAkTSvO7ZnTWQO5gqMaKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6T6DLX4+J9rkzrfBu5rY/QxK6NxwSYXZJldufn6c0pSYKHUZ1dQfreW2DTQSg4KsoKCPJIvyHy5CXa7bb69OQb9ESZYjwzaXaSOMplcIg9/my7CCrH8BXe2l+PcW2B4WsaUBSO2MTkPL/21p5Ia24k7wisKTG4jhDf8tiSZQOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQuPkFuT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742932327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U9r8VTyF0pq8OtaSKqOmz9cveKZRgNXDILarZ2uNThw=;
	b=gQuPkFuT6jXs6Mrz7TzTaXyGWqx8RRMpfYqwQlXQtP8a/wnwqq5qymWwN2JfjgfZ0zMEpy
	tNL3MJSzFMBNH0l1CGSX65nvX777jR6WQKc4AcG0EdW27gmIE+8GpqHX/b07mCT3HApwMq
	95HektQ1i1EUlXpKbylUZ1e5k0KScpA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-Ogs_x_JTMc6fkChFwzNR-w-1; Tue,
 25 Mar 2025 15:52:03 -0400
X-MC-Unique: Ogs_x_JTMc6fkChFwzNR-w-1
X-Mimecast-MFC-AGG-ID: Ogs_x_JTMc6fkChFwzNR-w_1742932322
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A08F1956067;
	Tue, 25 Mar 2025 19:52:01 +0000 (UTC)
Received: from puchatek.local (unknown [10.44.33.225])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A2CCD19560AB;
	Tue, 25 Mar 2025 19:51:56 +0000 (UTC)
From: Marcin Juszkiewicz <mjuszkiewicz@redhat.com>
Date: Tue, 25 Mar 2025 20:51:46 +0100
Subject: [PATCH 1/2] arm64: dts: rockchip: enable HDMI1 on FriendlyElec
 NanoPC-T6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-nanopc-t6-hdmi-v1-1-299a2ed45878@redhat.com>
References: <20250325-nanopc-t6-hdmi-v1-0-299a2ed45878@redhat.com>
In-Reply-To: <20250325-nanopc-t6-hdmi-v1-0-299a2ed45878@redhat.com>
To: linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Rick Wertenbroek <rick.wertenbroek@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marcin Juszkiewicz <mjuszkiewicz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Time to get second video output working.

Signed-off-by: Marcin Juszkiewicz <mjuszkiewicz@redhat.com>
Message-ID: <d5a822856513bcb42cc02045d41e40e9dd79b7b8.1742931830.git.mjuszkiewicz@redhat.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
index bbe500cc924b4c4c1ddd833c32c39cf6c20b60e3..8542d9ebb6c0ddcf90cbe6ac8c231e7fdc5b4bcd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
@@ -52,6 +52,17 @@ hdmi0_con_in: endpoint {
 		};
 	};
 
+	hdmi1-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi1_con_in: endpoint {
+				remote-endpoint = <&hdmi1_out_con>;
+			};
+		};
+	};
+
 	ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_LOW>;
@@ -360,10 +371,31 @@ hdmi0_out_con: endpoint {
 	};
 };
 
+
+&hdmi1 {
+	status = "okay";
+};
+
+&hdmi1_in {
+	hdmi1_in_vp1: endpoint {
+		remote-endpoint = <&vp1_out_hdmi1>;
+	};
+};
+
+&hdmi1_out {
+	hdmi1_out_con: endpoint {
+		remote-endpoint = <&hdmi1_con_in>;
+	};
+};
+
 &hdptxphy0 {
 	status = "okay";
 };
 
+&hdptxphy1 {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0m2_xfer>;
@@ -1126,3 +1158,10 @@ vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi0_in_vp0>;
 	};
 };
+
+&vp1 {
+	vp1_out_hdmi1: endpoint@ROCKCHIP_VOP2_EP_HDMI1 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI1>;
+		remote-endpoint = <&hdmi1_in_vp1>;
+	};
+};

-- 
2.49.0


