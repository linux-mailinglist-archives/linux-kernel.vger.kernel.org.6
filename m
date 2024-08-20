Return-Path: <linux-kernel+bounces-293270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310D6957CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA04B21AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C4313C81B;
	Tue, 20 Aug 2024 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4u/DKi8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE4E52F88;
	Tue, 20 Aug 2024 05:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724132173; cv=none; b=RLrjzZNIfCI1nywGaWatEY+ptnSzqOg8RDImVSvvoDMRO+IMHSzDETqw/Z1TwAc5RX8ohVmjG03oGdHnwidtpz9NWdwwCzQC/gUIm3MUHVC5lLtVUOwnqppHQfW4TRVXsnxmwivw+ptiNyCZic89XF9zW5oXY/GaWY+cTN2p55Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724132173; c=relaxed/simple;
	bh=WWJIu4SLZXpCcJXpkqCGhAlsS6QGf/I+/O8Xg6F4Mpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ng7z717PDMP+7RVn47l6eVBTHIa1Rghl+HWot4MkEX/4qHA0+8SEHKgSy68/Ch+Iv3tT2SDkoWQIiLvJQ8PohKLPU72Z5fmgkVPAfwR4itLo8cRgLMfWCDO6HO8DjiVQlLB1VVIrluchQDY9lPvEYksaZ1gDhc4uyopvn9sVikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4u/DKi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C9BC4AF09;
	Tue, 20 Aug 2024 05:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724132172;
	bh=WWJIu4SLZXpCcJXpkqCGhAlsS6QGf/I+/O8Xg6F4Mpk=;
	h=From:To:Cc:Subject:Date:From;
	b=h4u/DKi8ff1X0MfOZlqwwKAVFs4oFB1Tf8pgdpAlHgKvS4gxoAWCISxe0TlXHhnNO
	 yNe8nFDLl9m//kveiGC1d+1ZJ+L3X+jTfCQFRPotsToD1XL7F2PMH55aJ7QQUBQ+jc
	 Ul/KXmcrKNxnYIu+yW6N8/i5PpQQnCHkRoX2EOh2T7Y6r1zJl1p9zNQz2sLI1aI09+
	 qTBZNFiPhOF/FbJdG9CBZxzXR4uQqPO+u5pw4fKSL2ZfUv/uKuu0hBj9DR8jyFVGeN
	 ik4iauLXFcoJchiHpNp0V3J0RtBJm/tjv0ssV6ep8sqcdpujHqN+5ojmE1Kdgh2vpJ
	 KAMQMTb6jZAcg==
From: Mario Limonciello <superm1@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] hwmon: (k10temp): Use cpu_feature_enabled() for detecting zen
Date: Tue, 20 Aug 2024 00:35:57 -0500
Message-ID: <20240820053558.1052853-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

This removes some boilerplate from the code and will allow adding
future CPUs by just device IDs.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hwmon/k10temp.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 543526bac0425..85a7632f3b50a 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -438,16 +438,21 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		data->disp_negative = true;
 	}
 
-	if (boot_cpu_data.x86 == 0x15 &&
+	data->is_zen = cpu_feature_enabled(X86_FEATURE_ZEN);
+	if (data->is_zen) {
+		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
+		data->read_tempreg = read_tempreg_nb_zen;
+	} else if (boot_cpu_data.x86 == 0x15 &&
 	    ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
 	     (boot_cpu_data.x86_model & 0xf0) == 0x70)) {
 		data->read_htcreg = read_htcreg_nb_f15;
 		data->read_tempreg = read_tempreg_nb_f15;
-	} else if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
-		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
-		data->read_tempreg = read_tempreg_nb_zen;
-		data->is_zen = true;
+	} else {
+		data->read_htcreg = read_htcreg_pci;
+		data->read_tempreg = read_tempreg_pci;
+	}
 
+	if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
 		switch (boot_cpu_data.x86_model) {
 		case 0x1:	/* Zen */
 		case 0x8:	/* Zen+ */
@@ -469,10 +474,6 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			break;
 		}
 	} else if (boot_cpu_data.x86 == 0x19) {
-		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
-		data->read_tempreg = read_tempreg_nb_zen;
-		data->is_zen = true;
-
 		switch (boot_cpu_data.x86_model) {
 		case 0x0 ... 0x1:	/* Zen3 SP3/TR */
 		case 0x8:		/* Zen3 TR Chagall */
@@ -496,13 +497,6 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			k10temp_get_ccd_support(data, 12);
 			break;
 		}
-	} else if (boot_cpu_data.x86 == 0x1a) {
-		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
-		data->read_tempreg = read_tempreg_nb_zen;
-		data->is_zen = true;
-	} else {
-		data->read_htcreg = read_htcreg_pci;
-		data->read_tempreg = read_tempreg_pci;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(tctl_offset_table); i++) {
-- 
2.43.0


