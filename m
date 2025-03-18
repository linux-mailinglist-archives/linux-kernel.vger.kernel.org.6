Return-Path: <linux-kernel+bounces-565949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FA1A67177
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A4842204C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5F6209F3B;
	Tue, 18 Mar 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QX99pMPI"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D0E2080D6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294225; cv=none; b=XRbgpgs7EOqYnT55spDh4Y/D/zfGlT/CZDQbiNPrkFOd1qLYxU87ErhN+nydzur7ONrWCGMPZlgqK37w+g4mgrnrdKz9PKdR/UCoXhA3MEM+TT9Zecfq1lTnSBwSX0OmpcUmOJNYi82zbWCrzA+mFVapuwraea8lB2iQ8c+5GXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294225; c=relaxed/simple;
	bh=k6zmxnZkSudhQfYwlhUughY2ipiRJKQlyTzKL0wx9G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X/YCK+T3Llyy/4nL1huuO7wBtIlAdK03+0envxnMU3hGh3RgOBvgYzVxMtU12sOWTBKz+IPPa/vMdEAGnLG2j5ScZrUgysYKYFmjiof0Qeldn2Ew7/ygvjFTtnWXyIPBZ58nU5QjttrKP/8kh22Ehw5bejLwsYSK+ATpMOgQipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QX99pMPI; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3228344365;
	Tue, 18 Mar 2025 10:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742294221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2hWwAP5WcH49r9rVocCTP/cKLp4RPr/eci5Sdcf9qdA=;
	b=QX99pMPI01GIjvM/ogqDrTiAwi/oTdeuxTgmKQKnsVZc4S3b4GJvXWAPS7IS3IRI+vjXgU
	wI2USktvHqyGNySisIws3yKeKuwk/6gDeFc0wNA9rDUFE9AZEwLagL9sg2MUY1rHwOQuWP
	JtPOHDCit+IxL/lm/snuCqtEqs/Opn7H6hDrkhhZM75/Q+XvJ42OCj7I1VPrtrIXrH77Gw
	lmrD4R3FsFKEwIkl5RPm9uwwywyom1pBIieva2wBZYBUL/Dj00DlhPL4/C+C/neNc3lN3r
	M2gBdWAeUbtg+L4PTfzLxmgSkCXWw+8gHwXQ8pLkqYEttFBJ33uzbefY0e2e6w==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Tue, 18 Mar 2025 11:36:52 +0100
Subject: [PATCH] mfd: cgbc-core: Add support for conga-SA8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-cgbc-sa8-support-v1-1-6ae9ec443c05@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAMNM2WcC/x3MQQqAIBBA0avIrBswK7CuEi3MppqNilMRRHdPW
 r7F/w8IZSaBQT2Q6WLhGArqSoHfXdgIeSkGo02njbE4t+i32aM4i3KmFPOBtqG1b1rraPFQypR
 p5fu/jtP7fjR57tBlAAAA
To: Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 blake.vermeer@keysight.com, linux-kernel@vger.kernel.org, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepvfhhohhmrghsucftihgthhgrrhguuceothhhohhmrghsrdhrihgthhgrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgffgffejtdeivdeifeeltdffgfeludekudeiueffffejuedvgfejteeuffegtdenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmegutgekudemrggrugdtmehfuggtrgemtggtudgrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmegutgekudemrggrugdtmehfuggtrgemtggtudgrpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehthhhomhgrshdrrhhitghhrghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopegslhgrkhgvrdhvvghrmhgvvghrsehkvgihshhighhhthdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrrhhitghhrghrugessghoohhtlhhinhdrtghomh
X-GND-Sasl: thomas.richard@bootlin.com

Add Board Controller support for the conga-SA8 module.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/mfd/cgbc-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 85283c8dde253..1687a3b0289d1 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -384,6 +384,13 @@ static const struct dmi_system_id cgbc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_BOARD_NAME, "conga-SA7"),
 		},
 	},
+	{
+		.ident = "SA8",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "congatec"),
+			DMI_MATCH(DMI_BOARD_NAME, "conga-SA8"),
+		},
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(dmi, cgbc_dmi_table);

---
base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
change-id: 20250228-b4-cgbc-sa8-support-83ef9348aedc

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>


