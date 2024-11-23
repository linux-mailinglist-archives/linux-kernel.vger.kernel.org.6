Return-Path: <linux-kernel+bounces-419064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC4F9D6910
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BCB161655
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5722219D088;
	Sat, 23 Nov 2024 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="dROvrBaH"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D3175D39;
	Sat, 23 Nov 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732365800; cv=none; b=bAlUr8Kknlpn2mf+VwMUjlPVnvI2kZPo4UPVcy6GS4XHJcMJF2lmTYdFYaPGcJ1xr/wesA8YjpFDScnwTCii6jhdxxGt8uzgHhOyt7GdPUntAgViykFmdsL2PCNarIaq1ZmSXJkJaPLveISXj7YM0TvMwX1jhwdTEGVBrQS7LDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732365800; c=relaxed/simple;
	bh=o8uExKqB5qYo54a2nVBhqm5tJs6jO0jYNm2MbZM9eVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJySb+sF4RcJp1y+6UVAF+Kjjqkw5qst0+MGa6FboJj+8c1zuQIInD3ja/wJvXXTKT++pk+Cdb81ssjBZ1LdCUkZaUjxNAbQi5AOnGMFO0nsLIMid4vpWTxNJmEtxSEj6c3TUwCb2Wjz6yAOoNcRFgfTgTJg6d1BN3ohYVcraoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=dROvrBaH; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id AF4C7A0365;
	Sat, 23 Nov 2024 13:43:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ZZCQu8PNGzbUydOutitt
	bytVy0ecwKj8suiZ8x5X5G4=; b=dROvrBaHTGGG4MgsvrJAMJu1R4x5bs43t4uK
	JzMegSkUE8dpqLmVV6m4qFjRxBEOyU2qMdGA92gHytO0Ts/Pfq/el7jzTRXW3n8v
	7E6S+XJ8In98RN4FW8mcA1nojHNZqeqh9BtqTvzWe0oONkNL/Aomtf8HUBiuLnrz
	+9GVEodm/s3IKRsPPdvIq/tYPv8bH+FMQWhBizcligiBOEoHWYg2vHvz8/esxSkv
	LK0MKNci95AZsg/s82hf9kVbFj1KYbMwy7Ded7RrOnC/BriUo+3M3RLEHXJNO5kq
	lwS3y4lCPJ3R+2nN2C0qg45qMtyyPUD6X/NSX7Dxz5heIFa+cERtSWP4eCRPw1Xx
	AecrxG/b6Hg3volmGKpWDQImKJ1szml3gdyttkjibf66nnDlVbhnYJ9C6YzRJjaj
	rv0rG++imr1V3dHbEmm/w5lIkQXQ8PUFyR5fqmczhCHsM8XG7DySqHQ6zcfduOvB
	j4I7V1v6rnftGQ/nukkkcLJkWAibEpAqX9ViNb5lvR7onceoskoEvRAIglQP7ziz
	B1VooIFWE57OU1PFs93oHyRG5iEntuZPb1ZLTdk4EOm7KfH1JJ+JEFhHtR87/WVr
	altyh++C3uL1Zi+EyaAEdejbqF2J6bZMdrZf0brfZBFjIeKWhcqhzIgUR1WsR2tZ
	0xw8e0g=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v6 5/5] ARM: dts: suniv: f1c100s: Activate Audio Codec for Lichee Pi Nano
Date: Sat, 23 Nov 2024 13:39:05 +0100
Message-ID: <20241123123900.2656837-6-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241123123900.2656837-1-csokas.bence@prolan.hu>
References: <20241123123900.2656837-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732365796;VERSION=7980;MC=2302033481;ID=80957;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485560726B

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



