Return-Path: <linux-kernel+bounces-567392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E08A68566
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21D6426A36
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824CA250BF7;
	Wed, 19 Mar 2025 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="ESO/GiM5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bpDd4aCB"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F80A250BEB;
	Wed, 19 Mar 2025 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742367549; cv=none; b=SorQd59+MZrr/E1ihpUB5XFg4/VhRKjvShCARhVc54oPWSuhezLATLlmj+6+FxSinY3bX69SYl3pjcHON/KQqHXp+2dzK4UIq0sfVV6fzHyVCDUdAFG2RZIbi3dKJUaV241b4nLSruuWg6egglVxbCx9PVFMAiVAOsdsdNcThWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742367549; c=relaxed/simple;
	bh=s8YNt/uM92w7ztsyRuM22a3MZbSWMWpZHqIjc62PKxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a58NEpofhCNcUT1naaDcBWqQ4T85cyCFtJ4hemXalih4lvnr70wpKynIbFNJ17CMY4Jp3g3N7Y7oM/4FbPS+xyDrTrBV96QcrBgbCoWHuVNRJin+OUFOXXqf4tvi12FSWLHOqkiIuutG7iP+C41TkGM9a7X/SqtcL2+ct1kstHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=ESO/GiM5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bpDd4aCB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B4961140166;
	Wed, 19 Mar 2025 02:59:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 19 Mar 2025 02:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742367547; x=
	1742453947; bh=/T14vhOQlH5zlFbu6zf4VWhcOMvbsDRWh9ey2oS9IxE=; b=E
	SO/GiM5pZBfxZWKydZforNLPL+nJe5UzOZ+5Ww4n6vJNphVGsyvLTrydnIXDUgM0
	FKFLvzXrJ5Q6hvctE2rW4UoWexCt6Lmr5FLgrTNiG0u60ol3sB6agThUNV0NKzpO
	ww8mUBIPseN+FyFCVHja3lrR8UN82Jzvlsk7vjL+QOx5c2n8Q7PQvsOvDkqOHE6G
	Cc1y8PdfDTbaaC/9WLWGFfye82+CHJckuB3jIVRENlKxObRCt1wTvPegpMiRdakd
	YxXJKShfwtifxLX+B6N6duIKkN+rsY5gl3IqqsoB4Vk3z2xbrihsQuJ3FOxB4N4p
	EwYGx5nQ3SdVcYKnH+c6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742367547; x=1742453947; bh=/
	T14vhOQlH5zlFbu6zf4VWhcOMvbsDRWh9ey2oS9IxE=; b=bpDd4aCBIpuZebHbn
	res7v4JRhdsakfVm+jHLwrhKq5+OpshYTYxHegdKVDPV4sfJQMNsT8YgLEN4ULbE
	Ozof+agzRpj71XUKWZC5zgTtxA4I8YlLT/IKtlUeQfx+HEFeTQ+d55XvdBpWnmFV
	JVwiBBDvea17iihgWgqhPzMsltoSCiX6bK76x8baj2cWiIL8zZVCjHSx7LcoQfxW
	/dmMRMRT1ZVRD5MM4341NHYjbfaA/2HWIzjqSCSMhFQMhaYuG5G0ElsHiNRuoovW
	4XBXOMPz0zEKTg3SvR3j0JFNlco/VHMR+g/95G7W31uUkfSStISVK0E4b/8dRBUY
	c+Qhg==
X-ME-Sender: <xms:OmvaZ_Mi18hT3i_w1ISW_ZEtYwMgljz49peihyFtML5KyAFEhaFVog>
    <xme:OmvaZ59P-garkSqlEN4oBWpvTRpt8MqX2AlJrWqtZx1w9lmk9EU7ODneqvOhtDuIX
    3NaBXuqVUMLDGDfiwo>
X-ME-Received: <xmr:OmvaZ-QYERxAAmubx7xjTCpBI0Vy4W1_X89dyC3-KL7-kwTKfH_erYqAGvRvXPZSNAl5yCvBfSQcUrlBGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefnuhhkvgculfhonhgvshcu
    oehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeeuueelfeefie
    fhlefhhfehleefffegteeuhfehveekteeuudfgteefteelhfeijeenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrd
    guvghvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepihhlphhordhj
    rghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehplhgrth
    hfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtth
    hopehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:OmvaZzvdtz6fHGxOKjwd4NqXu3U-1mxnLreuq3e_bOw1xcw_nbNFog>
    <xmx:OmvaZ3f4sz1kFOzZ-ZBk-ENQgAK1qHb8dl5YeapOAYH20VcMr28fxw>
    <xmx:OmvaZ_1QdrfLoIkDV8xUgtm84ARkfqg0H6B0ZMz1cfLrSTK5zuynxA>
    <xmx:OmvaZz9b_evLAZozr8cqwVpYRby-bhQLrA3Tt4P-y9lHsLd6_XUgOg>
    <xmx:O2vaZ4G5cKsQb70uEQ6z8yoagtkLDHJWTq1mqsog4OFYdCuilmYdhdfD>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 02:59:03 -0400 (EDT)
From: Luke Jones <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	Luke Jones <luke@ljones.dev>
Subject: [PATCH v8 6/8] platform/x86: asus-armoury: add screen auto-brightness toggle
Date: Wed, 19 Mar 2025 19:58:25 +1300
Message-ID: <20250319065827.53478-7-luke@ljones.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319065827.53478-1-luke@ljones.dev>
References: <20250319065827.53478-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add screen_auto_brightness toggle supported on some laptops.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-armoury.c        | 3 +++
 include/linux/platform_data/x86/asus-wmi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index b36e19b9d2bf..802c304e2ebc 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -752,6 +752,9 @@ ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
 		   "Set the panel refresh overdrive");
 ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_PANEL_HD,
 		   "Set the panel HD mode to UHD<0> or FHD<1>");
+ATTR_GROUP_BOOL_RW(screen_auto_brightness, "screen_auto_brightness",
+		   ASUS_WMI_DEVID_SCREEN_AUTO_BRIGHTNESS,
+		   "Set the panel brightness to Off<0> or On<1>");
 ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU_CONNECTED,
 		   "Show the eGPU connection status");
 
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index e735f35b423c..92fea0710ada 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -83,6 +83,7 @@
 #define ASUS_WMI_DEVID_LID_FLIP_ROG	0x00060077
 #define ASUS_WMI_DEVID_MINI_LED_MODE	0x0005001E
 #define ASUS_WMI_DEVID_MINI_LED_MODE2	0x0005002E
+#define ASUS_WMI_DEVID_SCREEN_AUTO_BRIGHTNESS	0x0005002A
 
 /* Storage */
 #define ASUS_WMI_DEVID_CARDREADER	0x00080013
-- 
2.49.0


