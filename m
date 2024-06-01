Return-Path: <linux-kernel+bounces-197781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D388D6F13
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 11:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA10C1C23BBC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 09:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887E114E2D2;
	Sat,  1 Jun 2024 09:06:02 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641BD1CFBE
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717232762; cv=none; b=ubMZXW9f2UgUVGAiMp2iM9QdAwC0EKhSYLN9DBO4WERFzQ+5YIbVL77xIV0dEQPCQ5QbF/j4cDUATtMpmavgqOmD/0tlURM0IeV4Gm7YRbivOHERwIxHYTJMpJobqfouFOQ2GSkJlZxBJcJq+2/7MoEPaEokDQ6cn7a5K0iaEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717232762; c=relaxed/simple;
	bh=9df8tlYjtbKNycEC0+fNQzndkSpkBsQuFoY4R/MMtrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HHvTw+1kjS/XlY7Z3jyXQgHXfGdDnBDOf5VYoxCVQuajPycR4UtOD7eq6RfSY3F7qvd7TtGOqm5pXs7g7uL1W7dThPKlC6q72qIjQ66vc/FDsU8pn8YuBTbjoUiR9U9i/7l0veLAQAJHnKak1psjyQ0+oQZ5ChUzYaNpFvh1xK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VrvGd10N5z4f3lfX
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 17:05:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1834A1A0185
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 17:05:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5y5Fpms9QNOQ--.189S4;
	Sat, 01 Jun 2024 17:05:55 +0800 (CST)
From: linan666@huaweicloud.com
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com,
	xni@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] md/dm-raid: don't clear MD_RECOVERY_FROZEN after setting frozen
Date: Sat,  1 Jun 2024 17:06:08 +0800
Message-Id: <20240601090608.2847814-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5y5Fpms9QNOQ--.189S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GF4UXry7Wr1xXFy8Xw4kXrb_yoWDKwc_u3
	yxWa47Gr17GFy3uwn0ywsI9r9Iya4rW3s7WF1Iq3y5ZFWkAw1SyrZYgFn8uw1UZrWkur1j
	kw1UCrW3urWv9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBSoJUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

MD_RECOVERY_FROZEN should always remain set after array is frozen. But
in raid_message(), this flag is cleared soon after frozen. Fix it. This
flag will be cleared in md_idle_sync_thread(), there is no need to clear
it again for idle.

Fixes: cd32b27a66db ("md/dm-raid: don't call md_reap_sync_thread() directly")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/dm-raid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index abe88d1e6735..466740a3a522 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3744,9 +3744,10 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 
 		md_idle_sync_thread(mddev);
 		mddev_unlock(mddev);
+	} else {
+		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	}
 
-	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	if (decipher_sync_action(mddev, mddev->recovery) != st_idle)
 		return -EBUSY;
 	else if (!strcasecmp(argv[0], "resync"))
-- 
2.39.2


