Return-Path: <linux-kernel+bounces-443157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8219EE813
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45924164128
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9392135B8;
	Thu, 12 Dec 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b="ag2Pyp9P"
Received: from 7.mo575.mail-out.ovh.net (7.mo575.mail-out.ovh.net [46.105.63.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A6748D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.63.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734011646; cv=none; b=ITE23RkAtKp7jXG6+SmNIv+0oP80QZ9RTgJ021MLpgv2uWlPXF9GUXv5RS35gANVDt8nfAHhrs2J0UZEFrgtJY++40idCzD/IpV0BtWbgLHozg5uvxhEDNtzFSgfeGzGGEyw22Dm+H3PcTUg/pTLppyV7pudTWHc9ZcrkTzQS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734011646; c=relaxed/simple;
	bh=PK4uDMeUtjyDKQEHgX3VjN5qq6kQ1DuYxUT0J4QLxuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0ZFMy8pKNNGocmHUpVwUgxaClFbodfUxqzqfjBZTPWpJwq2JLaAm5pd16xaqQ0P1+XXJ1vSifSI9fX0UUHNYugXRx4+qlZ4B2/lg2QWK5oegmqzaHmi2BwdHGz2QDojyiJGy1xQjRGWX0j/jTsKFvWFCHFvJphXPJ/s/CSFDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com; spf=pass smtp.mailfrom=3mdeb.com; dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b=ag2Pyp9P; arc=none smtp.client-ip=46.105.63.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3mdeb.com
Received: from director10.ghost.mail-out.ovh.net (unknown [10.108.2.141])
	by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4Y8D462kMvz1v29
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:35:18 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-dnwnk (unknown [10.110.188.223])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id DFA641FEC1;
	Thu, 12 Dec 2024 13:35:17 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.95])
	by ghost-submission-5b5ff79f4f-dnwnk with ESMTPSA
	id X/QAI5XmWmcVLAAAAOnywA
	(envelope-from <sergii.dmytruk@3mdeb.com>); Thu, 12 Dec 2024 13:35:17 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-95G001388ab145-59bb-4be7-bb70-a3363cdea82e,
                    B639BF7A6EC39DD0505FDBB1524E94DB3A46F08D) smtp.auth=sergii.dmytruk@3mdeb.com
X-OVh-ClientIp:176.111.183.174
From: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
To: linux-kernel@vger.kernel.org
Cc: trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 2/9] x86: AMD changes for Secure Launch Resource Table header file
Date: Thu, 12 Dec 2024 15:35:00 +0200
Message-ID: <67137dbc5553058373d867a86a394f0671979958.1734008878.git.sergii.dmytruk@3mdeb.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734008878.git.sergii.dmytruk@3mdeb.com>
References: <cover.1734008878.git.sergii.dmytruk@3mdeb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16615467878300169372
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgvrhhgihhiucffmhihthhruhhkuceoshgvrhhgihhirdgumhihthhruhhkseefmhguvggsrdgtohhmqeenucggtffrrghtthgvrhhnpefhheefheduieelieekfffgfffgfedutdevleevvdfhfffgledvgfdtuddtheefieenucfkphepuddvjedrtddrtddruddpudejiedrudduuddrudekfedrudejgedpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehsvghrghhiihdrughmhihtrhhukhesfehmuggvsgdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=GRrrmesIKI/5OdnWwOBExWzwx9mLiHUNdtAUW9oGn1U=;
 c=relaxed/relaxed; d=3mdeb.com; h=From; s=ovhmo3617313-selector1;
 t=1734010518; v=1;
 b=ag2Pyp9PyPW6nl7EbkgDbwvyULexJ589kF0L1FDfOgTATyGI5figRGhOKpA4NsXOnITAjc7t
 9SyFRU32vo7OXgWnn0SHwlbGzuXlZcJOJuDtWDnoqM+JgG3xLnFUlUg+KMMAbVwmLJ8LybdY0ek
 5lD+fi0+J3dMHmKm4QxAr5EtsDv6qbu5yuU3KyNd+XbPtrjzY7gNs1qNIgfVgYHlz3OeyECqBWL
 rpTrkzIYgbBb+a5MICsxmt4WpGytocLoCoicMGModHRsLLZySeUN1+v3Xqu5vbo+SUKQWbgFLfN
 9bEUQPxwTLncBMyH117zWM0Ld2s4dOGmzZdROhaSdM8oA==

From: Ross Philipson <ross.philipson@oracle.com>

Introduce the AMD info table that allows the SLRT to be linked in as a
setup_data entry. This allows the SLRT to be found and in addition all
the DLMR information needed by the SKL (Secure Kernel Loader).

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
---
 include/linux/slr_table.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
index a44fd6fbce23..5b9a4f5641a6 100644
--- a/include/linux/slr_table.h
+++ b/include/linux/slr_table.h
@@ -176,6 +176,21 @@ struct slr_entry_intel_info {
 	struct slr_txt_mtrr_state saved_bsp_mtrrs;
 } __packed;
 
+/*
+ * AMD SKINIT Info table
+ */
+struct slr_entry_amd_info {
+	struct slr_entry_hdr hdr;
+	u64 next;
+	u32 type;
+	u32 len;
+	u64 slrt_size;
+	u64 slrt_base;
+	u64 boot_params_base;
+	u16 psp_version;
+	u16 reserved[3];
+} __packed;
+
 /*
  * UEFI config measurement entry
  */
-- 
2.47.1


