Return-Path: <linux-kernel+bounces-383517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 164819B1CBB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52127B217EB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 09:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136AA1547CA;
	Sun, 27 Oct 2024 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="pTzbvm66"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7213D52E;
	Sun, 27 Oct 2024 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730020868; cv=none; b=pbOF5qJg9x+4ZKZf5qixGq6om3iBKcvqq8ldCFKqr7oDtWxopTx+jeIb2keZv5pLVBKxR4CkDeMyV8QKyAmMnhGcjQdsHrQ4mW9PqY4mbDj7nFnS6ldhzePxxbwrJdcEZ/WuJc/dzyM+HmjAk7x/nAg4P9VRO4083aq1LX4Tqz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730020868; c=relaxed/simple;
	bh=o8uExKqB5qYo54a2nVBhqm5tJs6jO0jYNm2MbZM9eVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7N/xOs+X2xDGgTBuYPXrprfIVMyPWpwUHXEk9KkA01i7u3ZZnxETsxbAr/ZrnDmQpZLhGoQYcX0yv4Rn4yRf1W/5mMoRJUXbECVbDDDywRETfj1orVaf1JkUB3Ov5Spe0nWXN0WWD5dQFleFHpA1lj77itYo6eDLufDm1AQ4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=pTzbvm66; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id DF660A064A;
	Sun, 27 Oct 2024 10:21:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ZZCQu8PNGzbUydOutitt
	bytVy0ecwKj8suiZ8x5X5G4=; b=pTzbvm66ynymgrDhb5IeUDfKfrrFJeXacKhk
	He1xi1hVx8+QmcaybexD01sOUur9n3DKDwko39/PMgg48CyHNUf3r+IzXGB6f/NW
	rwdYtoROvxmBVtU1yqCjWJ2iHP6QsGdgGxDKxDAKPL0Gja7goG5rjY2dzX0iHDxj
	zXR2MT9w8RB8ov+w2vyNaYxXLUG33COW5Ms4u5Yb5ugZIPnNu3aOOQ2RriFmOy7P
	Xw2OavY7kGzLKSuqcFSvPzpG0MgKENp/qxkPbR26xGOb2HEVf5Udsd2f6A6a4qlR
	M119xCi1NhqEMswCpSyZZVaiFi+WhlnRtAea1zzdSzugBKbGYLSkH5u3uh92Zjhm
	EG1I6tZ/8SFfw+0lRBvSBixkQGuLn+iXxBNP/2dzeWMNA5b/M1gHwCxQ8A7wjobR
	j2XuHjaTCaBvBBRyXFw4YEAH/CUdplNzS8NtQ7T7MxXA9XvZN93M1+oqdsuKwxep
	GhUjInq3/CumHYpnzBdmsS1zLb+lAsEqgSGAquueIWh/r5ZJPBVIt+U+fQol8SjQ
	J4S6F6oZ9aD1yBMpxBlS5SBVCsLamUT0tDntvGKAd+h6K/oXSlgSHcZbDQyp5xF4
	J3+pwpvVwVRhMQznw12RE0A3r55kqpaMKQsHNpIRb6NOQP9Sm1X8mUhohet577iz
	DoJ8ezY=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 10/10] ARM: dts: suniv: f1c100s: Activate Audio Codec for Lichee Pi Nano
Date: Sun, 27 Oct 2024 10:14:41 +0100
Message-ID: <20241027091440.1913863-10-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241027091440.1913863-1-csokas.bence@prolan.hu>
References: <20241027091440.1913863-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730020864;VERSION=7978;MC=1006103771;ID=156046;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855677D65

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



