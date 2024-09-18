Return-Path: <linux-kernel+bounces-332531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 502C497BAE3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818851C213E6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02080188A26;
	Wed, 18 Sep 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="YMnPiPcx"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D2E17B4E5
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726655543; cv=none; b=GfsajzsqybKYQNoJ/lRq13YTqx55Sz3AZTcb6WMUI/hXRo24/WU++sBUDHSeChrpb00nTIct7pI+OCmv2iBcJmO7Ogq8ZN/G1L6qDDXit3vijoFf4QOndJY8633feebVxGbOTQoE+VsxcEbZnWCrPA4wwlBHW0mf4pv3ZRl5v2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726655543; c=relaxed/simple;
	bh=Dcb0Xwyt1891tjJcEz6VvHqKDQexcVogos3jECX9SGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvoyALXpwbfTWke3GUmKb79yRfVnYqU4DYdh1BGqTQw6ORvsQwCvUzgpBBLvstl74NAT7yaBMf0K+vd+ksHaNKLt08BF2G6CFS0Gi0bXLpTVXSozP9k4mlr9Ev+/4/839bikMTnWWtvZhLipZDdOS4etSrPTNVk+14/DP2oDXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=YMnPiPcx; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=bJcS7
	Q+dLAGzX1bKJJNMnF8F/vMu4jXD76SwJQFCW3E=; b=YMnPiPcx5EBwZrbKPJODN
	+ivfgE21f92OsmgxxSypF6pkbaj94mTcISlC/4ft4CVJ5B12iN1kGIXoykI513lZ
	/L88kVtq/8C5Hf7Jtrm7MKS24x8K2JQfHw1bf+zGkUGnYFGNm3RXxKdC2qNky+zp
	VRUWky9iT18FcYU3fiFQAM=
Received: from localhost.localdomain (unknown [1.198.30.207])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDnLyAsn+pm2TCHAA--.46011S2;
	Wed, 18 Sep 2024 17:36:44 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: jack@suse.com,
	zhaomengmeng@kylinos.cn
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] udf: refactor udf_current_aext()/udf_next_aext() to handle error
Date: Wed, 18 Sep 2024 17:36:31 +0800
Message-ID: <20240918093634.12906-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnLyAsn+pm2TCHAA--.46011S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWxJryrJw4kAFWxKr43trb_yoWDZFX_Ga
	4Igas5GFWkZFy3WFy3Jr45try0g39akF4rWFnFqa97XryfJr18GrZ8Zr4rur1xZayYyF98
	Jwn5J3s2qF129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiYiiPUUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbimh1ed2bqixWx0QACse

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

syzbot reports a udf slab-out-of-bounds at [1] and I proposed a fix patch,
after talking with Jan, a better way to fix this is to refactor 
udf_current_aext() and udf_next_aext() to differentiate between error and
"hit EOF".
This series refactor udf_current_aext(), udf_next_aext() and inode_bmap(),
they take pointer to etype to store the extent type and just return 0 on 
success, <0 on error. It has passed the syz repro test.



[1]. https://lore.kernel.org/all/0000000000005093590621340ecf@google.com/

Zhao Mengmeng (3):
  udf: refactor udf_current_aext() to handle error
  udf: refactor udf_next_aext() to handle error
  udf: refactor inode_bmap() to handle error

 fs/udf/balloc.c    |   6 +--
 fs/udf/directory.c |  20 +++++---
 fs/udf/inode.c     | 112 ++++++++++++++++++++++++++-------------------
 fs/udf/partition.c |   6 ++-
 fs/udf/super.c     |   3 +-
 fs/udf/truncate.c  |  16 +++----
 fs/udf/udfdecl.h   |  15 +++---
 7 files changed, 104 insertions(+), 74 deletions(-)

-- 
2.43.0


