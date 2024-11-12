Return-Path: <linux-kernel+bounces-405778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BC29C5910
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578A7B3FD89
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FB11CD1E0;
	Tue, 12 Nov 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dqQpUpLO"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975791CD1E3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411909; cv=none; b=IN9juOvwlFEPYGOMTG6FUGUFQpH4YODi/aF9a652ZewKzVYWrvmQBjLq5+P+b3R1RBFG1oYE6sYQl5HCY/3IgdffMl+ogkpmyzOMDJIsbJbPZXkzw42kQII+sakl0RINKCh6jBTXcaSJl/R0Ytxt7pMDthbsYdI9aokn8vwnz8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411909; c=relaxed/simple;
	bh=VKLrr7QZMUUyev5rxkpJNFNvTI6/kHJjySn82sb3aMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDJ1DNflyJw5FW8bP3x1AoFL9b+ZnGHFLbv6Gsr7yi/IEIxR7b/vjhznFetP7CUJHO3DL8MDiuSJROV5OEUugneKpuEuzAYruOfdxJF6ZMUr/sob8QsRt09ZPVtC6DIRWFgzRdd2HbQizMf63W1gH8v/fW8gJwuV/zZ1Yg2M8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dqQpUpLO; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost (82-65-169-98.subs.proxad.net [82.65.169.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 89C9E3F20B;
	Tue, 12 Nov 2024 11:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731411898;
	bh=uLvSlyjeZYA1K6LbSikwavRk6+iCQPaleexLZEvm7Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=dqQpUpLO2zKBZJfC467c7ujvMOd6cpgSwEOCV/PYMoY0R2kQPDikjw9jZ32/UBaqx
	 pGH2RfPmFdx1s7CBz1krhh8pmiWLaiAPIGRsRW8WjSa1+XVmFqsc/8KtJUH+qyFAn0
	 nsql4J+B0/e5NiAwJHXjz8Tau53+EkzSthZZdRc219sekXA+2ZGVqB+LZg38nbDmzk
	 7d5vzf6b+JqZWMdJQr41sS5VO8EUl09fQnH0lB9RvzjLCOki/dkji+ZZFYI3Wv5U01
	 l/jodChV5dbxssb4q6FIXtSq1mwiE/p4swln425T4dqG/It5FKHy7hLQwkLPxpB8Eg
	 ea0KT8aFJtiog==
From: Agathe Porte <agathe.porte@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Agathe Porte <agathe.porte@canonical.com>
Subject: [PATCH] ufs: ufs_sb_private_info: remove unused s_{2,3}apb fields
Date: Tue, 12 Nov 2024 12:44:31 +0100
Message-ID: <20241112114445.28767-1-agathe.porte@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two fields are populated during and stored as a "frequently used
value" in ufs_fill_super, but are not used afterwards in the driver.

Moreover, one of the shifts triggers UBSAN: shift-out-of-bounds when
apbshift is 12 because 12 * 3 = 36 and 1 << 36 does not fit in the 32
bit integer used to store the value.

Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2087853
Signed-off-by: Agathe Porte <agathe.porte@canonical.com>
---
 fs/ufs/super.c  | 4 ----
 fs/ufs/ufs_fs.h | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index bc625788589c..7ea1a4c07ba2 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1240,11 +1240,7 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 	else
 		uspi->s_apbshift = uspi->s_bshift - 2;
 
-	uspi->s_2apbshift = uspi->s_apbshift * 2;
-	uspi->s_3apbshift = uspi->s_apbshift * 3;
 	uspi->s_apb = 1 << uspi->s_apbshift;
-	uspi->s_2apb = 1 << uspi->s_2apbshift;
-	uspi->s_3apb = 1 << uspi->s_3apbshift;
 	uspi->s_apbmask = uspi->s_apb - 1;
 	uspi->s_nspfshift = uspi->s_fshift - UFS_SECTOR_BITS;
 	uspi->s_nspb = uspi->s_nspf << uspi->s_fpbshift;
diff --git a/fs/ufs/ufs_fs.h b/fs/ufs/ufs_fs.h
index ef9ead44776a..0905f9a16b91 100644
--- a/fs/ufs/ufs_fs.h
+++ b/fs/ufs/ufs_fs.h
@@ -775,12 +775,8 @@ struct ufs_sb_private_info {
 
 	__u32	s_fpbmask;	/* fragments per block mask */
 	__u32	s_apb;		/* address per block */
-	__u32	s_2apb;		/* address per block^2 */
-	__u32	s_3apb;		/* address per block^3 */
 	__u32	s_apbmask;	/* address per block mask */
 	__u32	s_apbshift;	/* address per block shift */
-	__u32	s_2apbshift;	/* address per block shift * 2 */
-	__u32	s_3apbshift;	/* address per block shift * 3 */
 	__u32	s_nspfshift;	/* number of sector per fragment shift */
 	__u32	s_nspb;		/* number of sector per block */
 	__u32	s_inopf;	/* inodes per fragment */
-- 
2.43.0


