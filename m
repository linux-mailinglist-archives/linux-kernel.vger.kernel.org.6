Return-Path: <linux-kernel+bounces-263328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E8793D45D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4241BB232FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED31A17C22A;
	Fri, 26 Jul 2024 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ibv/mVgL"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A717C21C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001237; cv=none; b=GULbr/4VLd+aCXPjZ48r4mTYSlnBgPk0YcgloIcsc1WH1jEMGNfWzGjcThmFeRdhKCZ4ZfBySgTetWDb/RRu8+rIcfUkJ2vBwhPu9Vam3OuVsvZt6+wtMN/DflDiIDr+FvlziAXV+pfM1VK0IPytsQeGq/BFjCCfo57AaSHklAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001237; c=relaxed/simple;
	bh=i2VwI/ItnEY4Smkcy/51knTi1QGpnddwYRamb6SUsY4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bkQXUDzJoMX+HU4ScuvtvGJ/LvU1BVWZrLEHTJcMCzh6OEb7DNVepZsrDJt7mFXPMh5Va5CkXdmybUaT0noU7ml+Ljuv2tOlCtjwh9ZdW9YuWcTdofSW1far5iG9lBv6m25fLNz12xaC6tQQcTX3ud8WB+gWh70neXfyWmbjoZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ibv/mVgL; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722001230; bh=GFr8RXHACSVOanuldZYi/bMbJE8OjdhO/msr6Qonqpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ibv/mVgLizanKcgWs7KBE/z3l8oemZOOY8jk/+TRUKkuxwr0Pd8ex83idjw7XAKcB
	 1szKRRIUZtdnPJNIm3ahtmegfZpnamGWEF8jQkXAF8VJLpxKO/Farq3PChmylB1nLq
	 unc/O2zr4AhG5lOrGY0jXnNeuPzvFxE7MFV7vzwI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id A1C3CCE1; Fri, 26 Jul 2024 21:40:28 +0800
X-QQ-mid: xmsmtpt1722001228tj0rhpbs0
Message-ID: <tencent_ED660A3CBD379296C036AA4A1A75D7771D09@qq.com>
X-QQ-XMAILINFO: NMmJpeSXIGQNVvOQWO+bTdplowi/Qjx/C3Bn+CbEOXjPcz4BN07XZrhylZawhV
	 X+mYhgtA3tEqgxK+efEW0YQQkgaxBJ8V1+N28R4WC46h9bsE2O6xSqReB9vMyk9KQAl7/+5tb2Ti
	 HwOwJUC/0WhhIX7a69ndf57zH61Cd17LZ/6Rq/QIDTAVlt/TtYO/Vv8PP88GpeuBovJzajb1OqJ2
	 afwZwP4F7E+fv9Zcz15e6HDIHfi91wnM3TKJ+53r4d2l1Uoqcjk+C7ZvK1s9QCKWuZ1EYNrdR2NR
	 weBtyMg080cmuNxhmd1BSrToYxxFzrVScuJv1nm5+ChOsSGlbv2nYU7PuKyJ8Pa9nHTVL3/HJjGZ
	 Ac0lT0TS6UC2WY0XvzidmXCRLjU1zqMA+tmpxZTmdXn/w/uVU0hGirHcXuluN/hrIPYEGPhdDRei
	 sB4166HfVHPhORYOZS1iCkNFNoWOUJCwafavIHKkgJVMpABAofI4i1vP5RcUt0mxuH5PglFc0Vjn
	 IXweJ3SHFOgp0fXAq6SQfuccyRcnZw7N6puueDygUmvlVD7q+lqwVuVFivWGyuVUeYdhY7eyBzv0
	 Va94JPPShWIY1rDNR6K3F38kUudJtc9w7L7xvSL8t8AUklM8wK9JYcQT2FTHRcWQcrstSLyzRLVN
	 ROloTjfyUD7IasUmwcaTvKv5iZgtJAMMYolUH5PcCR5TtmqmP8IKnvUpuudX98dNkp7Nbwe8w46w
	 862dwByRONNRGVNKcZHWYo84kv1Z2tzjh3S9vf8ZxEWHT6fKj5dHGOCBB/8+1VPuBLcUocucoUKB
	 JIh7lLvTUC9e5gzrms1ZlnC+Q2Q4EhFMzy9f0XeFKN+Xk3SJJuQOjjMxMFtrghKsM4IEJwJ9kdRi
	 cuiZwcaX10voBVbmmwdKMPGLL328cb/Q==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+dca05492eff41f604890@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dbSplit
Date: Fri, 26 Jul 2024 21:40:29 +0800
X-OQ-MSGID: <20240726134028.2249287-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000064c7a0061e2004d6@google.com>
References: <00000000000064c7a0061e2004d6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check dmt_leafidx < 0 

#syz test: upstream 7846b618e0a4

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cb3cda1390ad..c5b8883599e3 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1956,6 +1956,7 @@ dbAllocDmapLev(struct bmap * bmp,
 {
 	s64 blkno;
 	int leafidx, rc;
+	dmtree_t *tp = (dmtree_t *) &dp->tree;
 
 	/* can't be more than a dmaps worth of blocks */
 	assert(l2nb <= L2BPERDMAP);
@@ -1964,10 +1965,10 @@ dbAllocDmapLev(struct bmap * bmp,
 	 * free space.  if sufficient free space is found, dbFindLeaf()
 	 * returns the index of the leaf at which free space was found.
 	 */
-	if (dbFindLeaf((dmtree_t *) &dp->tree, l2nb, &leafidx, false))
+	if (dbFindLeaf(tp, l2nb, &leafidx, false))
 		return -ENOSPC;
 
-	if (leafidx < 0)
+	if (leafidx < 0 || le32_to_cpu(tp->dmt_leafidx) < 0)
 		return -EIO;
 
 	/* determine the block number within the file system corresponding


