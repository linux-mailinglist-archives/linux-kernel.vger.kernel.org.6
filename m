Return-Path: <linux-kernel+bounces-379294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1B79ADC97
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 542ACB22DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F92F189BB1;
	Thu, 24 Oct 2024 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="dRBOhPkQ"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC4D18BB87;
	Thu, 24 Oct 2024 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729752666; cv=none; b=jMtYZl80Iit9ylG79KE8NsAXeghv1DcT7GPp2t8624ithvl2J9Fr/ru9CcrYHtA79bD8ngHz4kjxdyEnDpaLcX38FpHmSXqr6CrG+sdQdZDU7tcoc3TxqSL+wD1neM5sNyqozJ75irq5xQDFsE/iJdust6yKumLmLZyviaPepR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729752666; c=relaxed/simple;
	bh=o8uExKqB5qYo54a2nVBhqm5tJs6jO0jYNm2MbZM9eVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqtiXHRnIJfdYOSsIrVe3GPtYYQTnp41EoIdEyEALg/x/Kr4T31IsykdRjSvo5gzo4/w4SyD/0jdx/YZ88yFVL9u9Y9urf6eep6Nxb2zi7TE9klNqJsQRDGCGt1Lvj7SOxaSjPRaSULKu4QMz5IpM1ebG1h+7mH091xRYbbee54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=dRBOhPkQ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 8934BA0788;
	Thu, 24 Oct 2024 08:50:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ZZCQu8PNGzbUydOutitt
	bytVy0ecwKj8suiZ8x5X5G4=; b=dRBOhPkQTu1djvy/yrhNzLQWBqV/jd5h2LG2
	dzm0A23jLLM11u1Ra1N0AI06GeV+6Wp5b+E9wlyH+nhlIKyFJdZDw/exhGfWI6+7
	/F0MJfAuXnjSM/piKkoZH4SJn42SSxAv7p6mRssukclPN7VCUihMgYRPeFieTeVY
	+7/Ng4bEHffUsulHWIa4ZkMO8SgdMr4Wr/PaHIAMGWeFHFz7W331Z8PMR7TzY9mJ
	s1H5/QN8m06a5swK4/CsT67VyaSwcFy4YUMH9hDBXcViHWkqo/V3fGZvLSMG055V
	PNlbnxluHqRdFDrYhd9jQVwUluTIL5CyMSRDQX2xUwyp5eVZUH9OUTIHlwCv/r2q
	1Lt25ENnZh7qzMmqIfSa79UYcy6DJ84yPHGeBRHfRhKAAsVoBvCTAtcr78y/df0d
	DiN4a7jJ6b5hAs67g7Ux1eGOjMFOYc3gawiWjzBoeazKMnBL4PprJn8xZwt8KK6S
	krSAsQb13C9Rv/o9fzWaYx7A3xGsh2LnDWVgEBwuPEo88f6pRhtO2H9cr2WKCfVp
	oBy45SBmfrJmsGxvXK9Kj3EwXm1K78EII+gwqcBmPYnAXe012UbuYjLiTZsLvG/b
	anlvkt4hVvvNrfR7zaDvhBk1FtJH8Ukmh4WEPdN+JMQTIx6RY/cG1MSxY0LbGAkY
	xCu+LfE=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 10/10] ARM: dts: suniv: f1c100s: Activate Audio Codec for Lichee Pi Nano
Date: Thu, 24 Oct 2024 08:49:31 +0200
Message-ID: <20241024064931.1144605-11-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <13ab5cec-25e5-4e82-b956-5c154641d7ab@prolan.hu>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1729752656;VERSION=7978;MC=3474792951;ID=153598;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855677065

From: Mesih Kilinc <mesihkilinc@gmail.com>

Allwinner suniv F1C100s now has basic audio codec support. Activate it
for Lichee Pi Nano board.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
[ csokas.bence: Moved and fixed conflict ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 .../boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts b/arch/arm/boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts
index 43896723a994..472ded0aafcf 100644
--- a/arch/arm/boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts
+++ b/arch/arm/boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts
@@ -62,6 +62,14 @@ &uart0 {
 	status = "okay";
 };
 
+&codec {
+	allwinner,audio-routing =
+		"Headphone", "HP",
+		"Headphone", "HPCOM",
+		"MIC", "Mic";
+	status = "okay";
+};
+
 &usb_otg {
 	dr_mode = "otg";
 	status = "okay";
-- 
2.34.1



