Return-Path: <linux-kernel+bounces-405821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4B79C5932
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E218B33CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ED01F77A9;
	Tue, 12 Nov 2024 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fRkhHYqO"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E51CD21C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414008; cv=none; b=KDEYQxIkNIZjym4MUZHf3NbpV7qR3uHFtyNMgnLTolhIY3BncDLSHQXJKnUTT35asiGcZ9DMeUGaSclQckRBiZYkxU7fspLGv715RDybqy9fOL2X16dAx7egO4Hvwbpn97SagbvE90Rm09lb8b2JbXUs4IgRcxoMQGF7mpZkj+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414008; c=relaxed/simple;
	bh=ietY/lc7pHJehIxNjb/cHHmxBkc9G1x+uH0fJMdVt0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/C0sF6HSxuo+n0GXOAh8VoV610EOCuV1MiHhshkV3SsA7+e21eosIeSHvs9uLQmAB/11UXNB+278zuSDm06cXNUAhk4BPljQzV3NjRrNMd8uLyDW/q8/gjfp0xxBcC4fm5B1Bq6tIa7pHt6rRBRPwNcVAWFDrWLJTZ2gberivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=fRkhHYqO; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost (82-65-169-98.subs.proxad.net [82.65.169.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CE3154091E;
	Tue, 12 Nov 2024 12:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731414003;
	bh=PgWyUcFT7aNUzUoaPKDygEVO+qbiVM6Rumh+NKkKa6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=fRkhHYqOgJ2Y+CALRHc5CFXbGS+HC5cfgB0W0HpgV95/ItJsaGsyiDC0lzTlAp+c0
	 56qxqEmiFdatQmA3vJARHruCGsSZsrYVHm89EDs6KiL1g0Gc5jBIRXht8x3pYzaGFu
	 xWtcyJUa+ToYpZiqznHA6vQce43iWX3MyFTNRmaXGAsIzJWTOvBRPFLRqPgxWwDIdU
	 SwyEnK6H7xAqYYqfVH3jkMANaGGuaJRVdnGC0BzsxvHY/c2DD5UqVQmkEbAgfBEuBd
	 Wsz1sfOPtbITVkcBCI/hwjBETi0eTE8eAczXXV5+HOSV42l+Zf0ZjrWhT5/RNnW76h
	 dpoyGBbgJULPw==
From: Agathe Porte <agathe.porte@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Agathe Porte <agathe.porte@canonical.com>
Subject: [PATCH v3 1/1] ufs: ufs_sb_private_info: remove unused s_{2,3}apb fields
Date: Tue, 12 Nov 2024 13:18:25 +0100
Message-ID: <20241112122000.35610-2-agathe.porte@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112122000.35610-1-agathe.porte@canonical.com>
References: <20241112122000.35610-1-agathe.porte@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two fields are populated and stored as a "frequently used value"
in ufs_fill_super, but are not used afterwards in the driver.

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


