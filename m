Return-Path: <linux-kernel+bounces-340275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115319870C5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3C0286F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BF31AC8AD;
	Thu, 26 Sep 2024 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="k9atz48s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YUtnaVyJ"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29FB2745C;
	Thu, 26 Sep 2024 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344452; cv=none; b=aeWzATW7xcKRGHHy66PFuTcgAONWjx60xTNxv5FFeieqkc8jE0fbmInl6ya9UkwC4TBefVhN0d0JbWWiRA4wKfvwCimlh5hYyr3MRqkGrEmkNEX03KOd7BTGjQXpJJKfUtVWFkCGrahALWkxEQnEZ3yY7sBKP++0fCQN3txgAmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344452; c=relaxed/simple;
	bh=h60hLbOhYvhPPbw6fRiesv3vxzyV/S4kIi/JDhH/Uxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwldyxbCZkfPblBu1P3e0ebsxhKCPaUHLUVL5x9ViuXHvLlLclyKkBt8N/PnbNKdPQ2sSu3jrllqJP2ufvPCKwbkIxMWbqI4QBfb10eVZVyG16wnqjV1NshhCB5mMVOVjsBsxPmP3vVv2eSMA6rSlL4H3jsVX7cqZpLexbG7FU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=k9atz48s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YUtnaVyJ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CAED913805F5;
	Thu, 26 Sep 2024 05:54:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 26 Sep 2024 05:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1727344449; x=
	1727430849; bh=dpsn5bzp75GqLyhrAX6/Nz5GBf6o93F6imCWKpwhsUk=; b=k
	9atz48s5EH/5d4lTTt3q/Th9DaNXNNS+zCBooFpxlRK8GhVdxWqZoGnTaj2Nq+u9
	80NmbkBds86KHHp14kEAHGsr6h8GcPHP52DpO8+lM04AepgoDGWdXbON2s3sqHg/
	IKB+XGsm0bPdRkOv6Wb1vmKcfWBbng+dtf/EPzmyBuQFS0TrFscht2zh3OqsMicm
	x4ffNrksfmXv/4V9xNwD9vRnYNf6+GW9ZuutTeBhCESdkBmXXSEnKnpK0xNBjxrx
	OFJ70em4Gg0anz1WoPoLmrKDmw1FltwZr9JHn+iAGCt3zDcBuZOjQmErlMJhXVFt
	EAYd/urIv1JqRwKT2/RXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727344449; x=
	1727430849; bh=dpsn5bzp75GqLyhrAX6/Nz5GBf6o93F6imCWKpwhsUk=; b=Y
	UtnaVyJRYvq8dNi/MlTUR/slQiU7WXSO3pWIKOpXEeUax+vBlm6lbTJw8kdSBCkq
	0T1kh9t3IMMOB7FAUnIn4/S2Jlbn4KUJtFgMWP0fh8vVg01h9pZ9VhGjPPKUD21A
	zktzFP4SZv/ZyLQVCQohsbrG8gOk8ltSAesul2Jtu9HZEOxigdpb8RCKoy2nyuOy
	N4qyEoSsHNScVXGAH31w9TJwuptmlG8hLb5S+GAm7JmTI/pz0PGL45gMqssQJbLd
	KOtpUPBxqW1Vs0bQsJIIQ9+mnAsR6ux4FLj9hpLzN7t4EYU/6qDJ0Fl8IAzl28rk
	tlohpFK6i5vZqHeXFiafA==
X-ME-Sender: <xms:QS_1Zklzy-WbipGZ_EEH25QO7gTokHJF1rqu0-MMBx2_rl7EehrijQ>
    <xme:QS_1Zj3IdX5Zr2upA09ERp5pJYxvVPKJUm8lV1vELMB8xwjmUVbsbfUDk68dD6Qgp
    Wf4tmd2uSuZskONi64>
X-ME-Received: <xmr:QS_1ZipoqR9UuyMtysigO46Eoxinoh8_x5-fJTPYjf4SYUHaFR8i0T3Y9ulRpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgv
    shdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfe
    dugfetudeuheetjefhuefggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonh
    gvshdruggvvhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinh
    htvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegtohhrvghnthhinhdrtghhrghrhiesghhmrghilhdrtghomhdprhgtph
    htthhopehsuhhpvghrmhdusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkvges
    lhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:QS_1ZgmCUmY9n5RPuZ8M6Awsz6iIPDJuZo0Pahpz3qm_xUXPptmFQA>
    <xmx:QS_1Zi04hZyacNKuSMJeqC7DIg2bXgkWVXQuMtPHtHCq4HL3uXK1Ww>
    <xmx:QS_1Znv1k6UGd6n9Cq5HSPiCuqkcNaq4qiedK-55-fZSTlr66XXRCA>
    <xmx:QS_1ZuWYjdi-lzLdSMWJknEh1PjtWRGnugODpP3jBtFwN7nLcUUS1w>
    <xmx:QS_1Zso8EDjbKuBGjfx_0xHAlnLTB4Un3wTMT-R0YnsXZFETU3nYK_4H>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 05:54:05 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	corentin.chary@gmail.com,
	superm1@kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/3] Revert "platform/x86: asus-wmi: ROG Ally increase wait time, allow MCU powersave"
Date: Thu, 26 Sep 2024 21:53:42 +1200
Message-ID: <20240926095344.1291013-2-luke@ljones.dev>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240926095344.1291013-1-luke@ljones.dev>
References: <20240926095344.1291013-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 7e7a5dee49732ed01a3a17c9a3edf027fb9457fe.

This is part of some hacks that are no-longer required when users have
updated their MCU firmware to the latest version:
- Ally 1: v319
- Ally X: v313

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 08861792bddd..8daefd9a0d94 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -146,7 +146,7 @@ module_param(fnlock_default, bool, 0444);
 /* Controls the power state of the USB0 hub on ROG Ally which input is on */
 #define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
 /* 300ms so far seems to produce a reliable result on AC and battery */
-#define ASUS_USB0_PWR_EC0_CSEE_WAIT 1500
+#define ASUS_USB0_PWR_EC0_CSEE_WAIT 300
 
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
@@ -4971,7 +4971,6 @@ static int asus_hotk_resume_early(struct device *device)
 	struct asus_wmi *asus = dev_get_drvdata(device);
 
 	if (asus->ally_mcu_usb_switch) {
-		/* sleep required to prevent USB0 being yanked then reappearing rapidly */
 		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB8)))
 			dev_err(device, "ROG Ally MCU failed to connect USB dev\n");
 		else
@@ -4983,8 +4982,17 @@ static int asus_hotk_resume_early(struct device *device)
 static int asus_hotk_prepare(struct device *device)
 {
 	struct asus_wmi *asus = dev_get_drvdata(device);
+	int result, err;
 
 	if (asus->ally_mcu_usb_switch) {
+		/* When powersave is enabled it causes many issues with resume of USB hub */
+		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MCU_POWERSAVE);
+		if (result == 1) {
+			dev_warn(device, "MCU powersave enabled, disabling to prevent resume issues");
+			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MCU_POWERSAVE, 0, &result);
+			if (err || result != 1)
+				dev_err(device, "Failed to set MCU powersave mode: %d\n", err);
+		}
 		/* sleep required to ensure USB0 is disabled before sleep continues */
 		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB7)))
 			dev_err(device, "ROG Ally MCU failed to disconnect USB dev\n");
-- 
2.46.1


