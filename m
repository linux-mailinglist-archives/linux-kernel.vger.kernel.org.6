Return-Path: <linux-kernel+bounces-270508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC259440CA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9016D1C23011
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0871E1B9953;
	Thu,  1 Aug 2024 01:41:02 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC451A76C3;
	Thu,  1 Aug 2024 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476461; cv=none; b=mF9U2lnVj/DYAn4bg5f402M5pgueNoRRQEsfzme9PB50OKFLMNrOyBl7MQzvoI7tYbXzLEX0ChSfpMViyxON04lOe1jqlEf6gGA+hXN6XIrVWhRyfKywkhWEI9BFriD63D2QzzY3rPTcghW33xyjW31pyvFFcuGjXzYrNiX3PLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476461; c=relaxed/simple;
	bh=3ZTrYGpYaA8fVeo+GRnubP0MdYrxDUa6oy6fo5D5VFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sbLwCL3q+2eKWddBrc61TXXsZXNXKqTGkNSHATIhGqg5qtNUqcCKjiTwFsfZ3p8yjHuOZHCkVjzIW50G4hfRm/UlvqTUWyZWGOIfqHH1VFi+h6CBVgZ7SfEfaslhxSzIYdGd9Z3DxRMpCI1DDtyKN7o3TxCQJ0h+fE8dxxao0dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WZBVz0dnzz4f3js0;
	Thu,  1 Aug 2024 09:40:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0F3FD1A0359;
	Thu,  1 Aug 2024 09:40:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgBnnr2l56pmr3OyAQ--.24249S7;
	Thu, 01 Aug 2024 09:40:55 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] jbd2: remove unneeded done_copy_out variable in jbd2_journal_write_metadata_buffer
Date: Thu,  1 Aug 2024 09:38:12 +0800
Message-Id: <20240801013815.2393869-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240801013815.2393869-1-shikemeng@huaweicloud.com>
References: <20240801013815.2393869-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnnr2l56pmr3OyAQ--.24249S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZryfJr1kZF4xGFWkWw13twb_yoW5GrW7pF
	WfKrWvqryvqry2yr4kWw4DZrWUKrWDWr1jkFZrCa4ayay3u3sF9F1jyw18K34jyrZ7J3W8
	XryUZFWxWwnIyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjxU2CJmUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

It's more intuitive to use jh_in->b_frozen_data directly instead of
done_copy_out variable. Simply remove unneeded done_copy_out variable
and use b_frozen_data instead.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 9c1ffb0dc740..f17d05bc61df 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -318,7 +318,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 				  struct buffer_head **bh_out,
 				  sector_t blocknr)
 {
-	int done_copy_out = 0;
 	int do_escape = 0;
 	char *mapped_data;
 	struct buffer_head *new_bh;
@@ -349,7 +348,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	 * we use that version of the data for the commit.
 	 */
 	if (jh_in->b_frozen_data) {
-		done_copy_out = 1;
 		new_folio = virt_to_folio(jh_in->b_frozen_data);
 		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
 		mapped_data = jh_in->b_frozen_data;
@@ -357,17 +355,15 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		new_folio = bh_in->b_folio;
 		new_offset = offset_in_folio(new_folio, bh_in->b_data);
 		mapped_data = kmap_local_folio(new_folio, new_offset);
-	}
-
-	/*
-	 * Fire data frozen trigger if data already wasn't frozen.  Do this
-	 * before checking for escaping, as the trigger may modify the magic
-	 * offset.  If a copy-out happens afterwards, it will have the correct
-	 * data in the buffer.
-	 */
-	if (!done_copy_out)
+		/*
+		 * Fire data frozen trigger if data already wasn't frozen. Do
+		 * this before checking for escaping, as the trigger may modify
+		 * the magic offset.  If a copy-out happens afterwards, it will
+		 * have the correct data in the buffer.
+		 */
 		jbd2_buffer_frozen_trigger(jh_in, mapped_data,
 					   jh_in->b_triggers);
+	}
 
 	/*
 	 * Check for escaping
@@ -380,7 +376,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	/*
 	 * Do we need to do a data copy?
 	 */
-	if (do_escape && !done_copy_out) {
+	if (do_escape && !jh_in->b_frozen_data) {
 		char *tmp;
 
 		spin_unlock(&jh_in->b_state_lock);
@@ -408,7 +404,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 copy_done:
 		new_folio = virt_to_folio(jh_in->b_frozen_data);
 		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
-		done_copy_out = 1;
 	}
 
 	/*
-- 
2.30.0


