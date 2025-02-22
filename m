Return-Path: <linux-kernel+bounces-526990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA43A405FC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A41426B56
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165812010F5;
	Sat, 22 Feb 2025 07:12:35 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A081FF7B9
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740208354; cv=none; b=awhPCaImw0AMnjjzhIRvlf8eNQo7l+Zv98RGV21JVonOkFDf3fKNV0stCofEY4e/q5UB2yMgWkX2iFj3HWVyXneCsQt3rfh0Nm1qa8Xz+BjZ8qe0UWi38dHiH3zSHERD2IWi4FplmrEUuRZlnCtGE5AKTHwI4jR6GmlAuWwPVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740208354; c=relaxed/simple;
	bh=jg317aKlXCO6290LQWr745p4eWjf3wdLEBJIkVNdggk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GPCT++NWq4mAApd/bHUtgLzzirJEY16m/2uz25rMvtuD+Vcr7vHEdZQz8Gkvtcw3MaI45Imb5fk5iMKJO3EWS9U+xmH+AyL9MCAM50Im8xQ00Xe6q4eNr8A+V8ca/MDzcMEgd2sHagEYTuP4ekBsRIunhE+0tO4K88y7loIqqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z0J8r0D9tz4f3jt3
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:12:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6861F1A06D7
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:12:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgBHBWjaeLlnrTsjEg--.26688S2;
	Sat, 22 Feb 2025 15:12:28 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	kasong@tencent.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Some random fixes and cleanups to mm/swapfile.c
Date: Sun, 23 Feb 2025 00:08:44 +0800
Message-Id: <20250222160850.505274-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHBWjaeLlnrTsjEg--.26688S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UCw4fZFW3GF1xGr1xKrg_yoW3ZFc_Ca
	y8Za4vyrWUGFyjk347Krn5Xr93C395uFy5Ary3tFW2y34xAFsrGw18X3yaqwn7Xw4DGwn5
	Jw4Dt34fAan7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq
	3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j-6pPUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

This series includes several random fixes and cleanups to the mm/swapfile.c
code. The issues were discovered during code review and can only manifest
under extremely rare and race-condition scenarios. Further details about
each fix can be found in the respective patches. Thanks for your
attention!

Kemeng Shi (6):
  mm: swap: avoid losting cluster in swap_reclaim_full_clusters()
  mm: swap: use correct step in loop to wait all clusters in
    wait_for_allocation()
  mm, swap: avoid BUG_ON in relocate_cluster()
  mm, swap: remove setting SWAP_MAP_BAD for discard cluster
  mm, swap: correct comment in swap_usage_sub()
  mm: swap: remove stale comment of swap_reclaim_full_clusters()

 mm/swapfile.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

-- 
2.30.0


