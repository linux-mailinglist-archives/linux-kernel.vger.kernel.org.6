Return-Path: <linux-kernel+bounces-576087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D8DA70ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E50418990F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F211FF609;
	Tue, 25 Mar 2025 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqBwOIul"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4959D1FF612
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932335; cv=none; b=F6J1f89KCBSq9QbwhrxaLg7sJmYiawMmJoMT/t/hhIK2wFrhjPF0S0qhBa3lP96+hSYzvLl6A37U1MLweG0tcnB2HG9D/MRG77C3iu3mNMuiwvoCHJ36vvJ94pNA/M89pUYE4u5fgxK8upldVr0wwPpVFd2AX2zjeWhA4qimLIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932335; c=relaxed/simple;
	bh=ep2UhyH9ZpTXbjLPiDIiLhTNOLyLamK3DKQh+PlcnDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xn6cwhUc1txaNE/6whLW5j2TaTN8n74pg2UiPvJWdJc8Z/DFXO8j+5Ky9GzfzadnkcfbH+W+QoO1+j69p/dpdHmVEwn9zcCr1N+NPiHQgVLkIvaReQd4VZJ/ChneWRW1qjw7eQJfO9cKP2BO0/AxHJf+fmBbbQ/A8ggqEw4ULrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EqBwOIul; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742932331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeGlPWnHaDeM/prZ2XLHvdOPSI3NsSge/Kw4R1fl9sA=;
	b=EqBwOIulpY7p1DWGJRJZsx7eHKndgQ7q/cKWiPSree2grNyZb7TXNsMwydmnM2mUPe17/A
	frtFqQ7pMiEjDBd6jGGUq1Qosc2q557wLInnp9nJXriPBTL6YsFROYSyuysg3+Wgx8S/Iw
	W1Ayu0pXE7092EnWEFy+Isam9gSvAC0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-0eW4VSkBPmyptagoFpJyiQ-1; Tue,
 25 Mar 2025 15:52:07 -0400
X-MC-Unique: 0eW4VSkBPmyptagoFpJyiQ-1
X-Mimecast-MFC-AGG-ID: 0eW4VSkBPmyptagoFpJyiQ_1742932326
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B137F1933B41;
	Tue, 25 Mar 2025 19:52:05 +0000 (UTC)
Received: from puchatek.local (unknown [10.44.33.225])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D6E4B19560AD;
	Tue, 25 Mar 2025 19:52:01 +0000 (UTC)
From: Marcin Juszkiewicz <mjuszkiewicz@redhat.com>
Date: Tue, 25 Mar 2025 20:51:47 +0100
Subject: [PATCH 2/2] arm64: dts: rockchip: enable HDMI sound on
 FriendlyElec NanoPC-T6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-nanopc-t6-hdmi-v1-2-299a2ed45878@redhat.com>
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

We have both video outputs showing pixels, time to play some noise.

Signed-off-by: Marcin Juszkiewicz <mjuszkiewicz@redhat.com>
Message-ID: <98484da08d8d9b7e1af63551facf141a64dbc556.1742931830.git.mjuszkiewicz@redhat.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
index 8542d9ebb6c0ddcf90cbe6ac8c231e7fdc5b4bcd..cecfb788bf9e2734d8ca3bb7bc99df866895b9aa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
@@ -371,6 +371,9 @@ hdmi0_out_con: endpoint {
 	};
 };
 
+&hdmi0_sound {
+	status = "okay";
+};
 
 &hdmi1 {
 	status = "okay";
@@ -388,6 +391,10 @@ hdmi1_out_con: endpoint {
 	};
 };
 
+&hdmi1_sound {
+	status = "okay";
+};
+
 &hdptxphy0 {
 	status = "okay";
 };
@@ -563,6 +570,14 @@ i2s0_8ch_p0_0: endpoint {
 	};
 };
 
+&i2s5_8ch {
+	status = "okay";
+};
+
+&i2s6_8ch {
+	status = "okay";
+};
+
 &pcie2x1l0 {
 	reset-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc_3v3_pcie20>;

-- 
2.49.0


