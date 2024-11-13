Return-Path: <linux-kernel+bounces-407004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CB19C6756
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDAF11F24541
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46B713AD1C;
	Wed, 13 Nov 2024 02:31:54 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD347E792
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731465114; cv=none; b=sCcETZ1rgVh17Evfjk6gtX/oBnG3JdWR+aC2vcQM/VZxwSYMlh7EZcDXwasSqQx1uOlN4fHFXeGr089HCT2KM32yHXYqyhcYEbDQb5A/4czhvXCZ4aCaTRqD8UtW3SY74oBylMQvsUp08+tZEM3nMGP508WnobiRAKsZvOHjndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731465114; c=relaxed/simple;
	bh=C7welgwMwcAFk+lPPtsbbdh5NcKOKudjxv2oci2YsaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QHx2BYY2qxD8AexcwP2Ijg3GsJnuFn9lz7U8pPO6SOaoeA9lI92BVD2GpoT6v4P+KSjqqefx5gjxK/mVa1xUmGJ5SvlFILolRHthcbwDv2hyLQ/FwUBYyl5LS6A205rkb5TL+e78cscqnWwiJEqjV1jXPRVMe1Hm0W2u12K6dUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee367340f8c3b8-e2bde;
	Wed, 13 Nov 2024 10:31:42 +0800 (CST)
X-RM-TRANSID:2ee367340f8c3b8-e2bde
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee567340f8e1b9-742cf;
	Wed, 13 Nov 2024 10:31:42 +0800 (CST)
X-RM-TRANSID:2ee567340f8e1b9-742cf
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: o-takashi@sakamocchi.jp
Cc: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] tools/firewire: Fix several incorrect format specifiers
Date: Wed, 13 Nov 2024 10:31:37 +0800
Message-Id: <20241113023137.291661-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make a minor change to eliminate static checker warnings. Fix several
incorrect format specifiers that misused signed and unsigned versions.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/firewire/decode-fcp.c | 2 +-
 tools/firewire/nosy-dump.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/firewire/decode-fcp.c b/tools/firewire/decode-fcp.c
index b67ebc884..f115a3be8 100644
--- a/tools/firewire/decode-fcp.c
+++ b/tools/firewire/decode-fcp.c
@@ -160,7 +160,7 @@ decode_avc(struct link_transaction *t)
 		name = info->name;
 	}
 
-	printf("av/c %s, subunit_type=%s, subunit_id=%d, opcode=%s",
+	printf("av/c %s, subunit_type=%s, subunit_id=%u, opcode=%s",
 	    ctype_names[frame->ctype], subunit_type_names[frame->subunit_type],
 	    frame->subunit_id, name);
 
diff --git a/tools/firewire/nosy-dump.c b/tools/firewire/nosy-dump.c
index 156e0356e..9a906de3a 100644
--- a/tools/firewire/nosy-dump.c
+++ b/tools/firewire/nosy-dump.c
@@ -771,7 +771,7 @@ print_packet(uint32_t *data, size_t length)
 				if (pp->phy_config.set_root)
 					printf(" set_root_id=%02x", pp->phy_config.root_id);
 				if (pp->phy_config.set_gap_count)
-					printf(" set_gap_count=%d", pp->phy_config.gap_count);
+					printf(" set_gap_count=%u", pp->phy_config.gap_count);
 			}
 			break;
 
@@ -781,13 +781,13 @@ print_packet(uint32_t *data, size_t length)
 
 		case PHY_PACKET_SELF_ID:
 			if (pp->self_id.extended) {
-				printf("extended self id: phy_id=%02x, seq=%d",
+				printf("extended self id: phy_id=%02x, seq=%u",
 				       pp->ext_self_id.phy_id, pp->ext_self_id.sequence);
 			} else {
 				static const char * const speed_names[] = {
 					"S100", "S200", "S400", "BETA"
 				};
-				printf("self id: phy_id=%02x, link %s, gap_count=%d, speed=%s%s%s",
+				printf("self id: phy_id=%02x, link %s, gap_count=%u speed=%s%s%s",
 				       pp->self_id.phy_id,
 				       (pp->self_id.link_active ? "active" : "not active"),
 				       pp->self_id.gap_count,
-- 
2.27.0




