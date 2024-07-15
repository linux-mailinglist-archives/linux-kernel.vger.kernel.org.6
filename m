Return-Path: <linux-kernel+bounces-252568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B2B931553
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0CD1F21BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF6018C34B;
	Mon, 15 Jul 2024 13:07:53 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D00172BA6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048872; cv=none; b=FPeFGrMa/nJc5GaAxm0xD9gjvvTcNJKc6YJ8npXnqN+BerjwRC86gGNiU95SsGVkUPLhwXWjCogXMxVOoEVGagR/IFmQos3v6a1QZn/0AamTJ/Pa5gO8VvdCu+dmY22OUqBCr4tbmgj6lXHzvV336dM2cBhTJ9VRNvJLccexg1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048872; c=relaxed/simple;
	bh=Rpi2uKJGEh2jtap9wfy0OTiptc9JmpOfQc2Ntp9cUxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fkU7kwz24r6CtoVvpfhCuVPGZZsgS9VZO94QZEYs7Q6j8ez9Mz4Jxx0dgXDUksw0gfQFvD6o7NcsVPWpuZHzm065nx0XwGC+iZyHXTIuryskFz0IgdVQNNpCPEWcpOLB3f+bbF3WywX52sTc1M04rE2kcuRbHJMn8l1H8+0Gcfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WN2YR5dWGz4f3kkB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 21:07:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ACC641A0170
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 21:07:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHKzkhH5VmjCPSAA--.61776S2;
	Mon, 15 Jul 2024 21:07:47 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: jack@suse.com
Cc: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	hughd@google.com,
	akpm@linux-foundation.org,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] Fix and cleanups to quota
Date: Mon, 15 Jul 2024 21:05:30 +0800
Message-Id: <20240715130534.2112678-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHKzkhH5VmjCPSAA--.61776S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFy3ZF4fZr4UCFWDZw1xAFb_yoWxAFc_Ga
	yxGayjvr1UXrZxuF1UKry5tFW5urWF9r15Kr1ktF45Jry2grn5Jw1vvrsavr17Xr4ftrZ8
	Zr1qyry8AF1fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

This series contains some random fix and cleanups to fs quota. Please
check respective patches for more detail. Thanks!

Kemeng Shi (4):
  quota: avoid missing put_quota_format when DQUOT_SUSPENDED is passed
  quota: remove unneeded return value of register_quota_format
  quota: remove redundant return at end of void function
  quota: remove unnecessary error code translation in dquot_quota_enable

 fs/ocfs2/super.c      |  6 ++----
 fs/quota/dquot.c      | 14 +++++---------
 fs/quota/quota_v1.c   |  3 ++-
 fs/quota/quota_v2.c   |  9 +++------
 include/linux/quota.h |  2 +-
 mm/shmem.c            |  7 +------
 6 files changed, 14 insertions(+), 27 deletions(-)

-- 
2.30.0


