Return-Path: <linux-kernel+bounces-573615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFEAA6D9D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD5E1655D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BA225E81A;
	Mon, 24 Mar 2025 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7uiS0r/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E525E808
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818091; cv=none; b=kRZUCOQ8R86Az/mG7ocydkmSzW+1HUYP9mxazvqznqOQ3IoVoOuewKNCPredxiKVF05x8Ug386CqLF2/M/tckbrSSqTxR5jl4hlMr56ibpGK8rF3moeEYiGuVG3f2u6L4SNePbsOThlkjagnmseKZA7gkmF/C36vAlXZJkiEAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818091; c=relaxed/simple;
	bh=MN4jerD6vCbfxLMpurlATwpB3u4sbGBPrL6S0ay1MPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0HrhHJbn0U76IRcy2aN9DZRP1yh5qkGm2pjRk+HoKcbBHoCQW4VHspZ3O/gl76AyVSkVXjckVOAfdoeSjI21DTzDGKRXiXXfjnbeLypxpbnilYNldWcqUYbw7IaRegs4ylgGeG13x3QYXVdLeiI1y6kD6ne0QdqucGmWVoPeug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7uiS0r/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D81C4CEE9;
	Mon, 24 Mar 2025 12:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742818090;
	bh=MN4jerD6vCbfxLMpurlATwpB3u4sbGBPrL6S0ay1MPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D7uiS0r/ql6VYylNLycK0St8J0Pi8ApnBeggQlE3SbNMgbbAe0G6Cw+HRK3m66+si
	 dpPkH6BF8spn/9IdDsaYXjQJzhN7qt3L2xtUnpZQOmuCrv76Gkqzw+T8tbg0gnBqwO
	 pvB4Hm92iBUJyAGGXkgy7Hk+Fn/n4ule7n+pfhBLRx8lrquVWbtbZ3qHvAzOyFpVci
	 vW6FlqoaHZP2cW+NPlNnpiAg/pme9GjcuD7ukm4I7pt3VBDYnCrSUbYkvyLfHJlnnF
	 6N35ThM2i7rJD3HxaWym0ixHzhwpOXxiXYw4cOmtdSeBj9qQFrD0ZaMSVrX0xUw5iD
	 JDCC08PAmzP4g==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 24 Mar 2025 13:07:56 +0100
Subject: [PATCH RFC 1/3] nvmet: add command quiesce time
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-tp4129-v1-1-95a747b4c33b@kernel.org>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
In-Reply-To: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com, 
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

TP4129 introduces Command Quiesce Time (CQT) for coordinating the
shutdown sequence when for example KATO expires.

Add support to nvmet but only report CQT is available but the controller
doesn't need any additional time when shutting down. In this case the
spec says nvmet should report a value of 1.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 6 ++++++
 drivers/nvme/target/nvmet.h     | 1 +
 include/linux/nvme.h            | 4 +++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e670dc185a967dc69c9b7d23930bb52bdcc3271a..09ac5a43f70dbe3889c1b404d6b59c0053337192 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -733,6 +733,12 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	/* We support keep-alive timeout in granularity of seconds */
 	id->kas = cpu_to_le16(NVMET_KAS);
 
+	/*
+	 * Command Quiesce Time in milliseconds. If the controller is not
+	 * need any quiencse time, the controller should set it to 1.
+	 */
+	id->cqt = cpu_to_le16(NVMET_CQT);
+
 	id->sqes = (0x6 << 4) | 0x6;
 	id->cqes = (0x4 << 4) | 0x4;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b540216c0c9a9138f0913f8df28fa5ae13c6397f..47ae8be6200054eaaad2dbacf23db080bf0c56c2 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -671,6 +671,7 @@ bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid);
 
 #define NVMET_KAS		10
 #define NVMET_DISC_KATO_MS		120000
+#define NVMET_CQT		1
 
 int __init nvmet_init_configfs(void);
 void __exit nvmet_exit_configfs(void);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index fe3b60818fdcfbb4baabce59f7499bc1fa07e855..983b047e7158dcb33da66a25c67684b8f1ef5a7e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -335,7 +335,9 @@ struct nvme_id_ctrl {
 	__u8			anacap;
 	__le32			anagrpmax;
 	__le32			nanagrpid;
-	__u8			rsvd352[160];
+	__u8			rsvd352[34];
+	__u16			cqt;
+	__u8			rsvd388[124];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;

-- 
2.48.1


