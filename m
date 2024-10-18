Return-Path: <linux-kernel+bounces-371413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFEF9A3ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06EE6B225AB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4DC200CB2;
	Fri, 18 Oct 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH2EWPAE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D45417D378
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245721; cv=none; b=cUKSRTDqzjy35qMOFy8hL4Xyihepnd7IInW13EE1oF3E+OaFjpp8D2U9Zw2/gG9cTT6+iM7MCJQ3X2u3U5TwlOS5ycPn8foboXt3BusCHYLPq0EyV0mWKl+bywyX9jDy1bLdxjTIqg89/0SHk1DOhidLEz6AFQ0QHISBX0DqP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245721; c=relaxed/simple;
	bh=c95i7yQ7yvMxmF9U7mJUoxODymNVPbilqum2Qcc3rII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W1gUfHFLaY2YtGoHEgTiDo5v7BZzFW+zvkzqdN9knLz98scPg6jMBxSiQyRmAhmI7Ft730SUNMZYncd3gHHCzui+SJ7YZayQ1piSzlxPXTPM8wli4KO914wqzEaMCvd5jPQpmOPqaOEwzG0tr3dEg9mC430rtcRd4N+/EsM/vnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH2EWPAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1E6C4CEC3;
	Fri, 18 Oct 2024 10:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729245721;
	bh=c95i7yQ7yvMxmF9U7mJUoxODymNVPbilqum2Qcc3rII=;
	h=From:To:Cc:Subject:Date:From;
	b=RH2EWPAE9cL7/kwE7/Kfm6Y/IhDxlxqTorp7dqmS937GwQmXH5DkJWB8wI/FTlShx
	 PsMCDYFG+xMAbSUmUh/97FmXycbi3V3fYf2T60Apsclk+f+catDhbxyoijKtGoFib2
	 FhFglyLy+xrGhVHssLWKhC2H4IuWhLFAUNTNoOF1TYibJD7CU29hyIFJRDLXLa7gMX
	 yD1Epk4CKUHh4Em4PhH3dKXgkCabk9SYhrEgpQLZU3cgURPRKO06Tt1XmfNgKMmRLy
	 q4LyLmrn3lpL0QPbyQui9QE6FB+GriciKX63cW3N3VZW3JCh6uSFNr8w6ZOVwPLXVH
	 g1+MwAnJXpqfA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daniel Rosenberg <drosen@google.com>,
	Qi Han <hanqi@vivo.com>
Subject: [PATCH RFC] f2fs: revalidate empty segment when checkpoint is disabled
Date: Fri, 18 Oct 2024 18:01:50 +0800
Message-Id: <20241018100150.2852132-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If checkpoint is off, let's set segment as free once all newly
written datas were removed, it fixes below case:

dd if=/dev/zero of=f2fs.img bs=1M count=64
mkfs.f2fs -f f2fs.img
mount -o checkpoint=disable:10% f2fs.img mnt
dd if=/dev/zero of=mnt/file bs=1M count=19
sync
rm mnt/file
dd if=/dev/zero of=mnt/file bs=1M count=9
dd: error writing 'mnt/file': No space left on device

Cc: Daniel Rosenberg <drosen@google.com>
Reported-by: Qi Han <hanqi@vivo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e172b3d0aec3..4f480bfc9618 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -849,6 +849,17 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 	valid_blocks = get_valid_blocks(sbi, segno, false);
 	ckpt_valid_blocks = get_ckpt_valid_blocks(sbi, segno, false);
 
+	/*
+	 * If checkpoint is off, let's set segment as free once all newly
+	 * written datas were removed.
+	 */
+	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
+		valid_blocks == 0 && ckpt_valid_blocks == 0) {
+		__remove_dirty_segment(sbi, segno, DIRTY);
+		__set_test_and_free(sbi, segno, false);
+		goto out_lock;
+	}
+
 	if (valid_blocks == 0 && (!is_sbi_flag_set(sbi, SBI_CP_DISABLED) ||
 		ckpt_valid_blocks == usable_blocks)) {
 		__locate_dirty_segment(sbi, segno, PRE);
@@ -859,7 +870,7 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 		/* Recovery routine with SSR needs this */
 		__remove_dirty_segment(sbi, segno, DIRTY);
 	}
-
+out_lock:
 	mutex_unlock(&dirty_i->seglist_lock);
 }
 
-- 
2.40.1


