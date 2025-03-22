Return-Path: <linux-kernel+bounces-572131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE9A6C6F2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 02:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08075464336
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 01:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C7B1BF37;
	Sat, 22 Mar 2025 01:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kN61HcqU"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE3B4C6C
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 01:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742608015; cv=none; b=un+7MaxZ0RpyKgo941+/bzRPtbf27kQZdU0ljse6xUrMnKX7ehbVjOeWKjt2ID+LFklrOi/N2bcHDWTRy9GN+RRhoHpF5m0RyeXZv9OY0sdD/gIcIs5exTMSy2H1dqemA57tAu3GiAMDx4c2NlVLjjn05kjKgM4Bw1NBtwdsAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742608015; c=relaxed/simple;
	bh=/5psgy0rCLw4CT+nCNS3iW5/pvkqFDYd47LPvQHNTU0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HYVrir2f5/bk4+l0rMg4hQ0PJMKm3jcipAO8zfJEWpQTbnOi5mzQuYXhoPFSgHq50y61gIgjeMBmfUwTlHMDI5luoNpdxAeaptCzok1nDqfqTPJc5/52OzmckezFG18mWmNgWpJqiHnOMg0Zds/DQnDVusHNjkteR1j2Bw/U+IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kN61HcqU; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742608001; bh=C44m/BUfxEtb4vgFulHVWGq13NMf+AJYwIZ2/k54gqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kN61HcqU2p+1WKpcJUqoqXoP3vg5Y8jf/DVKQn5b2UUSjw6vXmHwi7fKG8ZPPmPN3
	 qHaQanrg4pFGZVJbAwvQBvPIEv36K3R8n7PYjFI8SLBl4gRyuiumhLdwYSWZ6GTDUo
	 cR2/4NHI0ibBKEdN6/XaQ3vz4OvYccM/6PeugihM=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id A1F252FE; Sat, 22 Mar 2025 09:40:31 +0800
X-QQ-mid: xmsmtpt1742607631tpmd13a43
Message-ID: <tencent_688C7427774F66123C313646971437C04A09@qq.com>
X-QQ-XMAILINFO: MbMMSJ8sGwqs6PERxS64Z5WO42ISphgLpWXKoL9S/9frHgCoQhiMrD/ApS2Jco
	 u8il7vRQFSVmN7+u+Vd0msw34/+J5MmQ8+qou2bKn710mA4Jj6w/MSSu89eon0ztgLIN9TQhILsd
	 QcqUN7dLBN6ZVYPgd7bkesb7YW8c5m6qoYqCEVXFhogw6OlAWAtGqq8xjCRi7tXc1NodD/OMN+p4
	 +4B0Pvrm/MuQdaH/3DuWvFp1Z3I+vk0KNQZsJTDgI6IqT5INaSsubzBh3LD1MaBu7EKlXbAvOyLf
	 0j6LHWIymUwS8e3Db3cV2lgRLW3mL0Hkwq8nodiNaiIpmU0wcsU30b7y/B6/9dCH4a7chn2YzF5t
	 8g3CX8yUsBkl/uEJZqbzaE56+7mogA78M7v59xKm1L+TgtN8NF/4pDIGK9tK7bnvb1JNfr2V4PBF
	 4azzfIsRrySOoa9nbly/Wq7sBzrIVDGQRYJeO8FUZGSvL7zPaFgfeWzilev1qLfzDedadUNAV8fw
	 464GuLW7IIvc6BS/rOoRDwT4CRZgZWIn7R931UVoy6G0fDnuDQ+Nb7YAvjZhRJs6CMcwZ/2sA5X3
	 gIsbyGluh+jyfz8XAEdtIgXG7gc199dilIoXWC8WyXBOKCk8LNSyFaZ89095IqWtdFGlrdfw8FyV
	 OAokIYkyD0QEqXtrjQPJ2mNCiFyqwfLTSFCLXjbaa+MpipzZyA5lg16XocFfyBwr6dfArWfA7Og0
	 jUQ4HWgBYl0asPMy10WmIcCUCSuatymEnx2+wGIo58xHYq1iFGl4YskgBpDbNglSW/SNBwB1AXmj
	 vWX5xvY3eRN2bRYzh2jL1qNpTyqX1T0kdvpEPeJfzVfyPgzMRLb6z5B0LqEYfrCO20wcbCk3lrEX
	 gw3wSyvO5szLkwKME/SWT87CEZ+Ap0bw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
Date: Sat, 22 Mar 2025 09:40:31 +0800
X-OQ-MSGID: <20250322014030.29324-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <67ddd191.050a0220.25ae54.006a.GAE@google.com>
References: <67ddd191.050a0220.25ae54.006a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 2956d888c131..c1c52571b0ed 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -485,7 +485,7 @@ static int ocfs2_recover_local_quota_file(struct inode *lqinode,
 			break;
 		}
 		dchunk = (struct ocfs2_local_disk_chunk *)hbh->b_data;
-		for_each_set_bit(bit, rchunk->rc_bitmap, ol_chunk_entries(sb)) {
+		for_each_set_bit(bit, rchunk->rc_bitmap, (ol_chunk_entries(sb) + 7) >> 3) {
 			qbh = NULL;
 			status = ocfs2_read_quota_block(lqinode,
 						ol_dqblk_block(sb, chunk, bit),


