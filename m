Return-Path: <linux-kernel+bounces-261568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FF193B923
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35B21F216EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E8E13D255;
	Wed, 24 Jul 2024 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="dZxZr51e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ty/KtDsX"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9913B7BC;
	Wed, 24 Jul 2024 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721860144; cv=none; b=uKq6ouXdMG82373vTUK6vFbdTuYcCwuKKG4PlvqeoNuOuSMS+I/H2VPqc4ZzOnDYjHsOBpuKzxDJsfc54yR9FtZ1fMQ6A2rVDUiJExZ7UGzo40W67Ud4iw/P/+B7K/6ww+hNGejhP27gmICkspL+eWZscU2me3c+V2ibbfwH5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721860144; c=relaxed/simple;
	bh=F06Gs9T8OWXm7tW344eZkX+dCY/ldQFGgyDn6fv3MZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CAh+EDpVCN14NInjzcei4cfVWiqbqTWkw3NshNeRk2BvzI0gAwGzLbFhUpZLrdMAxOrqqlP/mxhHSitcw91tIFIr5lfk7h5Y+Y6/lXz39DlvrXu8ZsADk5qvSZI2RtoylBWoIlmKRAgbfJxW6KCJTG7FkGMeQ1iUnRtBJBnJwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=dZxZr51e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ty/KtDsX; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B85FB114009B;
	Wed, 24 Jul 2024 18:29:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 24 Jul 2024 18:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1721860140; x=1721946540; bh=fP2milRMjQvGiHJdeSC30
	UHVMk1tf84makXy+6bVKzY=; b=dZxZr51exoUlZT1ro2MbGyeM9SIvECgaFvWHZ
	YlBeXNEUsexzfLhgS0ZNQ7CBUj7CFpba+SxFrhY1zkwNGCFDigWNfbsdh3n+nO7S
	P9sk+LgSo9Qltbsi3e0xjenIj6b4vlfVZgP7kTzH6g7JPDHAeh9b7e/0WBW9+XM+
	2WQRG3p0a81M8ByGzo2MJ5j+s5HtOYzdxhLPOf9xLaZP+NlNoZxqY0erXhE7cNqu
	GhZzi6zW8ovgWOeG47dg5/NNbwOzL6gEhNVg/LvoISnFRZRBH6AZb57OhqHt7cU0
	TxiBe4RWOYGX0E8KI9DrgT7g3XqOgXgChk1fMLhYd42lUn9uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721860140; x=1721946540; bh=fP2milRMjQvGiHJdeSC30UHVMk1t
	f84makXy+6bVKzY=; b=Ty/KtDsXwwH6CRB0KLO+uvo6yN/5EeOa6q9BcDHLyp8x
	NBEQXrgRtElOhIAH7JVuZP2ECIwZo8X7oUlFnAmwnoYo0XOWZjAv5lF8EaqgpQ4e
	SO/NDoauqCCwIa+E1g4+bbPDfNAiEHwLBaRsIbNKits4dgyVlR/Tj3mHlrkk6/nD
	OWSDDirnwOktJIJSu7CUqBQO9dCfWXsKoUUmjNLsCpQbgTkQoftqYVbqRk1Xy+kC
	BfIF4RKqvpNEA8jQCQtRXDC5QM1gis+Snl6TUokMvbGumfAC1PK2KpW5rQoZbTGg
	yn8yG3d3gyve0j/V9gCOUr870+mUUnUYDdEFbvk2zA==
X-ME-Sender: <xms:LIChZjsM1xmbxGunoUJ0AiwYKOfIS8FjQE9qPwEtiX-oUyM16I4GgA>
    <xme:LIChZkdT5-2N7h5UpOzgoeDeGn8CqQXC1WJftkIjV7nAzpbeY5mtw-qIsxg3j1fzC
    UQSJpUNVAAKlXBjnqs>
X-ME-Received: <xmr:LIChZmyXJG-E9ot8oW77zjUKZX2q4YMXeKPQicU-7FLXGv5gsxgrwKQuinTY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedvgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprhgtph
    htthhopedt
X-ME-Proxy: <xmx:LIChZiPtErc6pwkC2NfFVvC1G24JBedyEslRPQRjKZ5gWVEoz3sMMA>
    <xmx:LIChZj8upCZh1VUP8m_NXVszR0RQjKlXp3DPtTM6W2o2w-IcSROUag>
    <xmx:LIChZiXnbrp3cgRwSlmFyIoZQPzfWe7LyPcgffFuBgBLiuG9It_EpA>
    <xmx:LIChZkc6naNXnQMSilJnknmEV9p2LiNM8GAVopauYcF9Rzm93dnM3w>
    <xmx:LIChZulEi-wDv4iZlKadPiAmM5ntPANE5bwgAFAjUwgjO-TCQ-s2QOiT>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 18:28:57 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] platform/x86: asus-wmi: Add quirk for ROG Ally X
Date: Thu, 25 Jul 2024 10:28:52 +1200
Message-ID: <20240724222852.44378-1-luke@ljones.dev>
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
 drivers/platform/x86/asus-wmi.c            |  2 +-
 include/linux/platform_data/x86/asus-wmi.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 2b968003cb9b..bac2945b0e48 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -4694,7 +4694,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
-						&& dmi_match(DMI_BOARD_NAME, "RC71L");
+						&& dmi_check_system(asus_ally_mcu_quirk);
 
 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
 		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 74b32e1d6735..fba9751cda5b 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -196,4 +196,19 @@ static const struct dmi_system_id asus_use_hid_led_dmi_ids[] = {
 	{ },
 };
 
+/* To be used by both hid-asus and asus-wmi to determine which controls kbd_brightness */
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
 #endif	/* __PLATFORM_DATA_X86_ASUS_WMI_H */
-- 
2.45.2


