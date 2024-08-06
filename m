Return-Path: <linux-kernel+bounces-275567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C7694874E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30981F21C36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A60B647;
	Tue,  6 Aug 2024 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="FpcXUiVK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q3pCGfZi"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D0BBA34;
	Tue,  6 Aug 2024 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910082; cv=none; b=A3+NNTE4ho209qp4to6iAgXZ9BmHRiED0tQrw9Q406IkFl8mEpufRayiSRl92kgVr5O+hAhSm1KGczFQnPR9nCm/UQuE4StZ+idb16hgb/JRf8IhWK7lYAd3DMGQ8+NvgBR+bIZBpgoHMgvhvPLsl03FMLXUyyq88gMbEnkdPD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910082; c=relaxed/simple;
	bh=7GogOe5n9F2zHkC/WirTp89rqrdd3akHu64WR1KTE1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nF6+wX+MqsjeRJ9ZZEP8sOZaSOPK2vrb7+IWa5hRbXw11Y0D9Y3xwaXuMRYjD9pqU0Z/xiEkgpjKeiBxeWgJU7JB+v0K4gktPERlFc/TAX0wuhq+NEvy+0A9zBg6C88jZ2xV4qPKhCeVb0CTakcXFGJH4YDAjyAccjjpTRX/ctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=FpcXUiVK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q3pCGfZi; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A74ED1151A8A;
	Mon,  5 Aug 2024 22:07:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 05 Aug 2024 22:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1722910079; x=
	1722996479; bh=gIvWdDLxWY22hhOBPE6JYFoqhl5WH6m9QN6kQjoDgMY=; b=F
	pcXUiVKTqyZ9SmvDc1uk2RqM9o8BH4dw9md3VBfFxIY4v5corV+kmXtKilN+HGgP
	FvyYx3faLKiofqaGrqy4Encn+H1r4Nhgz2lGCd+iSeKROuyNyfh5wQkXfO3M/7mp
	bdH5IRzrXm5ozgxAQ9d2NpLhFxGM2bJt5if6sqzwHSGCQi+2Dlc6I5JUt56KjWVS
	08FrB2Diqvxl/F5nWojMzO6RCquU4p4AkbtDeaBvzBkUGoZdIWU9pcThaR+CFg/N
	Cr1MrLbJV7jhfrS2YXADN8x00aHmejYrovq8DvmZk/upfzic0awWWZugPfaQnOMl
	Vmsfo5TGR8sf0fffEP7Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722910079; x=
	1722996479; bh=gIvWdDLxWY22hhOBPE6JYFoqhl5WH6m9QN6kQjoDgMY=; b=q
	3pCGfZiXipAuBzRPJnIvkV6tgXQ5wqTDrJ45IUPrIH7gSGfsei9Tlb6DaAJ5RLOD
	swRnrWTyD8L/Fc4gBUI/gYRVqRuPhblQn/id5FmRLgHSrocWpjiA2h1aSglrZ2Gh
	N60YKhgVPmc0UZPwVYPxwPbhkukhC57oY7moY/ura9oj3Llk32xHcgg4MAQBiLoi
	d5r7pv+YLnt83/jvADP7TmRvjcu7Iqn1RlhdWZSCFk6GE8yuvVirOAAVpe4CuQXE
	wMBv0LDozXK0vq6exXVXNYecSB6S5Ip63hL8JbFpNvdiVPCNAic/+95tFMI4S0x0
	43iRfenv4p0yDBXPfHNAg==
X-ME-Sender: <xms:f4WxZhNxyvZ2NYF_CGllLtMGaznXHum8j45KsNPv4COxsqmkm9LdEw>
    <xme:f4WxZj9TQ_W1zGGZriiDoqBYRrUKEr6cLBBAAjSTKhwh3zuI8klYs4z___D-Wau_k
    NVcAtoTdUhzGQoZmXY>
X-ME-Received: <xmr:f4WxZgRk6UGDZ8OBPS0SsVFd44rzhfjR9-ekc6Z82MUas72fYC8J4oHRUVHn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprh
    gtphhtthhopedt
X-ME-Proxy: <xmx:f4WxZtuZzrAAUnA6l8KmE8JNbvrsnThilRw6TrILse2k8csqMCEfhA>
    <xmx:f4WxZpcIWuIhpvsStVHxKR99D44-4dQPX_g9QNz9p_wPTfW59suD6w>
    <xmx:f4WxZp3uJ6JEdSSBU8Yo81MKA7KwmNW-eMmT0dLlWDZQsrqAJhHNUg>
    <xmx:f4WxZl84u3x_Q-teSkiSJqnGqzkfR6SwYHYn5xW5CFmV0W2MPw3ewQ>
    <xmx:f4WxZiHUDD7NQiTWUt8gRoKBKE8A0DVjF-fdYdpV5hzb3Ga8udDjH9Dd>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 22:07:56 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 1/6] platform/x86: asus-wmi: Add quirk for ROG Ally X
Date: Tue,  6 Aug 2024 14:07:42 +1200
Message-ID: <20240806020747.365042-2-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806020747.365042-1-luke@ljones.dev>
References: <20240806020747.365042-1-luke@ljones.dev>
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


