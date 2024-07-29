Return-Path: <linux-kernel+bounces-264992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D07493EAF3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5461C21593
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D455473E;
	Mon, 29 Jul 2024 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="fk+FIbhT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TAqBT7zU"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC42AF16;
	Mon, 29 Jul 2024 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218926; cv=none; b=QMEhU3MWIkq7tIDBbB9BB38j8byXN5wApiWhsp/gdSbgrOilD+n9W1ALwcRUoLxmhaEvcKe/UehqFBlaf7WPyt1a/ZgbPyraDoTLp0yiSQ7a7r3DoEF1ZKceSeYmoNzOmdOXBKy0zYgpPxHFosbVsstHy/HUzqJH79puo/eZajk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218926; c=relaxed/simple;
	bh=rA9ix1/z1sC9NvwCXqVMvF+MX4WaAadCCawjicxXea8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PvRTmQJCCJVCDb1o5t/Q2Rw448hCGTNpnPnPFY/+tWKMKCNIB33RkVG6gS65KmCw9D9GBUyKuPKWmsjVkctClZcVKpWWIoOgWWSvjAQwyuzpAZhft44p8HyCIx7ylug6u7nIfQSQzUhz44g45aEFzE/vCi3trlxgBDS0oF14kE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=fk+FIbhT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TAqBT7zU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id D34F1138065D;
	Sun, 28 Jul 2024 22:08:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 28 Jul 2024 22:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1722218922; x=1722305322; bh=MsWt7psNutZgyU33ohl0C
	VI9a0bjxWTkX6euaShp0CY=; b=fk+FIbhT+VOWd6F5nChJoya2F/Peet4m8OQX2
	dC1mqZnXXIASOkYaWhwMWFtDYYIkV4iCPmYIJadH7znjvl6DXodoJwJilfAa7lSk
	E75DGYnMF5X4VmpqBh9PVFDNNGulYtY/gpT+EjzdMvwZMreFUVBWlUR+RXf604lP
	74/ZKYycgqTbvr+dAu7p+fGRX1G6k+hMalHMcJHDXB/KJ6ex+tRllBXktJpEWPeq
	4UAEaKm5i27Z8Y07NFr3GcR/OtWDAdYKiddWGjEJAr0pJFSm+UBwPUfR3wEjvj4E
	Cf76QkpEGgHzKlVTU0ansmHTSohGx1XxqlCOFQvVk5PzGOmSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722218922; x=1722305322; bh=MsWt7psNutZgyU33ohl0CVI9a0bj
	xWTkX6euaShp0CY=; b=TAqBT7zUvhFzZo91mlp0MhY/vqBVdZBjCFF1D7ytXl/e
	7VdJHZ8fXhOh+vZgLMOxgWUUKP2wYsvHlJB2qhgEeTtEbW0oXAg4ozfHYzMDnHt8
	EKX+aq+MEQfBnLGCr0fLciMGn69LHS0e8WDqk9go8dtbS8Dscr3GH3wjGsIdZYaA
	5Fxnd1ucT0yKBXHTIoRZOu/VMe/3iY4JYHAqdXlOuQQ0PKRKxpoYQRRQ0eccGn6l
	Om0m2YzCJh0YohC1/Y6FEJk6EWE841wPK58+JFIoTSQVjqONdKNTuN4tLAktwMG+
	TudrdlvpqIshb72pGOoLOZKABPXnspZqaIvzPYXd8Q==
X-ME-Sender: <xms:qvmmZtWTCU8f70HKHXTcMuhBBQ0xTa0rUvjZvrztV7-CUF1iwM6A-g>
    <xme:qvmmZtlrN4gQ04arDP5dbMdO7gj7pMU1jD9yE1JeRH3qMM7sCyRbHhOb0xhKUkApA
    vmgKfqRQIQqDGP7rE8>
X-ME-Received: <xmr:qvmmZpY56lu48CLJmlzKvAFaSwReDu0JqRz8elW3y3-zL9C2MnMsFlXWx_ns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedugdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprhgtph
    htthhopedt
X-ME-Proxy: <xmx:qvmmZgW1ogE6S8Z3fYb5MlIJQdaeS0eoEFlyuNGovd_DfufOcAH9Bw>
    <xmx:qvmmZnlVyVNSwDPW3VTGVMTi-9ShUy_OqzoLW9F2RADtjb57gGNpqg>
    <xmx:qvmmZte29skJgXwp59xjC0LQ8u3rxxCxJyLgCk0OUJ09Pt_9QDMAUA>
    <xmx:qvmmZhGVIhm2miI0slWsbyXOODDJk1MuHU6iXVxBL-D13LlRQC9law>
    <xmx:qvmmZisn6C3qunjJV1zXFGPZcEEmKPNR1JTUuXOLDCIvG2frxt-WqF39>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jul 2024 22:08:39 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	Shyam-sundar.S-k@amd.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] platform/x86/amd: pmf: Add quirk for ROG Ally X
Date: Mon, 29 Jul 2024 14:08:31 +1200
Message-ID: <20240729020831.28117-1-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASUS ROG Ally X has the same issue as the G14 where it advertises
SPS support but doesn't use it.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/amd/pmf/pmf-quirks.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform/x86/amd/pmf/pmf-quirks.c
index 0b2eb0ae85fe..460444cda1b2 100644
--- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
+++ b/drivers/platform/x86/amd/pmf/pmf-quirks.c
@@ -29,6 +29,14 @@ static const struct dmi_system_id fwbug_list[] = {
 		},
 		.driver_data = &quirk_no_sps_bug,
 	},
+	{
+		.ident = "ROG Ally X",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "RC72LA"),
+		},
+		.driver_data = &quirk_no_sps_bug,
+	},
 	{}
 };
 
@@ -48,4 +56,3 @@ void amd_pmf_quirks_init(struct amd_pmf_dev *dev)
 			dmi_id->ident);
 	}
 }
-
-- 
2.45.2


