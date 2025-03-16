Return-Path: <linux-kernel+bounces-563186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E10A637FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630AA7A59FD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E9D1A255C;
	Sun, 16 Mar 2025 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="V8tH/nGS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZQXr5bYJ"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CE31F4621;
	Sun, 16 Mar 2025 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742166476; cv=none; b=IG1t3bUq5dZUPcNVhSYNKOzRf4PVDFURlgsBFOqITnTMOhp7itnfJVifvBhpifqeS1ySYN2rA/wi0fGuf5j3UGrKdgOqmhS0Jb90N7t3SNbjLOyJQ+G0eSOd+88yGlLIuxt9HWhQrHBhueY7MmAGG72KMWqJ2Ukebrqcr7KMRTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742166476; c=relaxed/simple;
	bh=RZbuMwNPemWgWEk7xeCCXafogpmib0Txw2MfA3xh3ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKp8cVVH9gxOaEfQuLIc200e3VhldvBBvOMr4XjyPMdFz/5vrqkdD95xzhpxOa2HoVqpAAjvsGhC2kS4LxO9xX4M0ahoD9/P6ZRfhKkHo5tYVJtra2/4VDJ0EF1qxyPuJRhjOjJ+UZNciIxwZyFa9rvCSlvVaTXVZ8Xaeu17AAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=V8tH/nGS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZQXr5bYJ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id C77D21140126;
	Sun, 16 Mar 2025 19:07:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 16 Mar 2025 19:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1742166473; x=
	1742252873; bh=6NZlVAHceIzSgE+BAy+U7CGc4XuOgGtS2nNPgvQuhAA=; b=V
	8tH/nGSGkx5tlYdH9W7Uqjp147r9mp0ej0LOOgU5znO3dHZnCeU6Fan+pjweOELU
	a1vBKxbh6O+97JKvUTD6bOpcsyXjYJQWv8JgnAeiOqK7BtjIGvQYYRGhXGOropue
	1HXp8cXTZuPgC4nyE5zc5MjvFrfUM+uZrL/ycHkX4hxBNWtC4YlX7/AU5s2KYX18
	o3u5Wy/Qb+GQQD9aODWc1GSQfWt7YbKVa/5ExaaUfl5eL+PK+P3k3LFkZjmKv9Ti
	e8Jn2VVqermSMpbcZ6xrh3TKzZL960+YODVQh1DJput7Sr+b4zOzKzpODrA+v1kj
	+vVuaKWA9eafN3+1lQQ4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742166473; x=1742252873; bh=6
	NZlVAHceIzSgE+BAy+U7CGc4XuOgGtS2nNPgvQuhAA=; b=ZQXr5bYJ+2I1VfdZZ
	pC8tqdlBD4inuEx4X5ggv8g089NIri42buMReHGxm0cTB++sBi7HocZtmzC1XZtr
	rtC07eOSu8FKJbcYnmwoX2pnr6fA+WSKc35o2AiUdhAUrdXB5r6QaLssmrSC1ovh
	xpB/DsVpcdP7/4wLcgVIKPrVCNw1gzsxS3sRo1P8agbQKXADEdgf/wnU9eEipw2J
	E6hJAx7PhsUxTNxA6eL4+nqBO6QefFjOI91p58tJgOj1ldZ/0u/idz0SBUgkTSK7
	l9/PS6pTymlb/TZ7FLpFW9RuxLt1fiF3/K4vqtB8NJgqZvNhr5cVKGKHZa0xMHNt
	qTdhA==
X-ME-Sender: <xms:yVnXZ4kwZWiPoirmKLMVEcW3ZQpRSennlallxUDUtDnFmWNHf6ze5w>
    <xme:yVnXZ33c8jBTgKKIvikVIoOHZSqIc4g1TO_sXMbzawi5w7YAVPiT9LpwOolE4KChJ
    08MRk54bqFycY3LUDM>
X-ME-Received: <xmr:yVnXZ2qHHKpHCjoMXUouagIHD6uMkfirpcjgF1ztKfblbAtHDOsuZ8Hc4dUPaW8XG548WufUm_I5RNPouw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefnuhhkvgculfhonhgvshcu
    oehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeeuueelfeefie
    fhlefhhfehleefffegteeuhfehveekteeuudfgteefteelhfeijeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrd
    guvghvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepihhlphhordhj
    rghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehplhgrth
    hfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtth
    hopehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:yVnXZ0lQahYhs5KT1I1s1cYhW-jaBcanUmnOrt4U_hGX5jCtu6MCKg>
    <xmx:yVnXZ22J9ZzkRZl4gSc_pUpGn_GW3J-l7mnu0GkGhKk7LyTkcEqT6A>
    <xmx:yVnXZ7sNZiUpgyMR6obhlZ08WvDumYet99XdD9Vssohszs79Rfr92A>
    <xmx:yVnXZyVsy-G6G4W53tQAuVVv4QLn9VbkgZ5GKtJzqFqhYrDdNDrVyw>
    <xmx:yVnXZy8fJC2Jy-kjcoEHvi7Y3N6CDzp8vAngp6M6DUYUpRgHQBLZYV6L>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 19:07:51 -0400 (EDT)
From: Luke Jones <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	Luke Jones <luke@ljones.dev>
Subject: [PATCH v7 6/8] platform/x86: asus-armoury: add screen auto-brightness toggle
Date: Mon, 17 Mar 2025 12:07:22 +1300
Message-ID: <20250316230724.100165-7-luke@ljones.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316230724.100165-1-luke@ljones.dev>
References: <20250316230724.100165-1-luke@ljones.dev>
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
index 6f0686fd5a4b..591805f46725 100644
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
2.48.1


