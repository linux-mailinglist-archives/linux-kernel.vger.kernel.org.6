Return-Path: <linux-kernel+bounces-275481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA765948653
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B1E2845C4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8376616CD11;
	Mon,  5 Aug 2024 23:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="rWdltSbw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MhakXm17"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70E14F9F1;
	Mon,  5 Aug 2024 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722901575; cv=none; b=stpa5fruC9BeNXn2UcZxznU2n7WqDyr4o+ey6a3TamB6MtfTyM0MvoUX2kqQw6yZYYlgy8KKu+7i064PzaMddWZwu3J4zuUH4rIhmXIdkYo8gnMtjW6TbBBPPV6nMNI5VTEMAA4chb567PXup6aWLgIYUrGabFke/GYqWuRonqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722901575; c=relaxed/simple;
	bh=7GogOe5n9F2zHkC/WirTp89rqrdd3akHu64WR1KTE1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbhHZ8w23H0f2adAGVOMpkCRZ6m4rCW2kcbCCHm9znwuVAoMUu1LEbFxlBQDuCaBpFqzJ7M+pWoqRrg1Z/4g2Kyh1h4d8oS/OjA4Vq6z5WI1R159oPZIV6KaN+JoPCqdD28HMS2Ob8La3xBUPGZUNtl35NQ78rhhhRlRG5pMozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=rWdltSbw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MhakXm17; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 51123138DD0D;
	Mon,  5 Aug 2024 19:46:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 05 Aug 2024 19:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1722901572; x=1722987972; bh=gIvWdDLxWY22hhOBPE6JY
	Foqhl5WH6m9QN6kQjoDgMY=; b=rWdltSbw651QVVznuH6ziMaxUGCHYY2+tbCTw
	mVi7J00RuotjdYX4//SK7FZCunfkNm3b8cgyScTJ4t1ZAzXG3g6M4LKCJDUOPYOo
	bmk5UTaJsv9Fel0gVAFeB+fmdAzR7cvBjvo/MHXB9UQea2sD+hNP2lf136KwS4dQ
	V1vSXL5NM9Pw6QSR6rDCrZYMv88E5xaIdJQhlyh8x0708BPAsD/88pX55EjRgWUe
	OzkTI4wFx9DpdUM2SbH+rA8ClXHMSFRMOpAziTGl9VeRIhMr/k2m/t+d1UlpjA9Z
	QB4J0O924me8OtvLmfq6DksxflXPCWl7SxK7xAe9wRWz8J0YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722901572; x=1722987972; bh=gIvWdDLxWY22hhOBPE6JYFoqhl5W
	H6m9QN6kQjoDgMY=; b=MhakXm17+uOomLrF8G3Nl+GisPyFjo4E7A7yu8Uy3bKv
	crapWM5p6CgifwKyMB2/OJV7HoXfkdtwvfU0WR1gq4j6DzSaFRdzZCcSPaS2mdUS
	MKuYTDtdpYVlX3IozZfhBFLD434fIF3cXOzZfmKLx/pfTdzB9n7+32f1L1cPgS5R
	tq9ntmXUFDM+BDRnusZtsukB3jyJ5y0SC1hggt17Ax/RvF05pFCdkueNgwiIhtHh
	OolRloPFAP6ccHASqA8EJuVaiu1etFyGLkhs4Ftw6+a2NOqwSlejy4uq/5SwJ6M1
	T08zokWxAOqBvLV/dCP+S8hqJx/0tA7t/2u04rkcyw==
X-ME-Sender: <xms:Q2SxZhFoeFYqOEykw2xxWFtJem87lZAP_xVeVknBBUA5RHaH1o_CfQ>
    <xme:Q2SxZmWxZfTPnb_uzCjfnv3hM1EQM07JzyrsAk2PljDrr5fV_wIgtlaWMxEbqYMG8
    9Bon7cR5ueVC70XSUo>
X-ME-Received: <xmr:Q2SxZjKeKYMmBiOAI5rdq7AWnXysZfRqxgNpavrTpWEzQdW-tc9toJBMh8Hh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprhgtph
    htthhopedt
X-ME-Proxy: <xmx:Q2SxZnGz1LOoMdqDKT_OyAJB8nKadG38x3NrTWbcum8-8oRbWXIn6g>
    <xmx:Q2SxZnWxN1GOjJIoInE24K6BQv3I2JfxzGCmZzY_9aLuVisj_VGr5Q>
    <xmx:Q2SxZiNJ6CyYt3l7rwtk1vR_GFj65CyMpWMdvjvUS-1_U4e3R1uRIw>
    <xmx:Q2SxZm0nfgl83WfFiDfC443LQHjSefc3aistL_mWIDtKverAqQtITw>
    <xmx:RGSxZteZ0S8Aiiv6TUolNSKYSyViNCrG1M5Ax8YjIa-9veBAlnZFFcLI>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 19:46:08 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2] platform/x86: asus-wmi: Add quirk for ROG Ally X
Date: Tue,  6 Aug 2024 11:46:03 +1200
Message-ID: <20240805234603.38736-1-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new ROG Ally X functions the same as the previus model so we can use
the same method to ensure the MCU USB devices wake and reconnect
correctly.

Given that two devices marks the start of a trend, this patch also adds
a quirk table to make future additions easier if the MCU is the same.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f15fcb45e1aa..0c80c6b0399b 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -152,6 +152,20 @@ static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
 static int throttle_thermal_policy_write(struct asus_wmi *);
 
+static const struct dmi_system_id asus_ally_mcu_quirk[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
+		},
+	},
+	{ },
+};
+
 static bool ashs_present(void)
 {
 	int i = 0;
@@ -4751,7 +4765,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
-						&& dmi_match(DMI_BOARD_NAME, "RC71L");
+						&& dmi_check_system(asus_ally_mcu_quirk);
 
 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
 		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
-- 
2.45.2


