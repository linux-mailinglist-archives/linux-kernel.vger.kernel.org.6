Return-Path: <linux-kernel+bounces-517942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C42A387DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9710918995B0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0DC226184;
	Mon, 17 Feb 2025 15:39:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B95225A4F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806779; cv=none; b=pLL7g62mEzNxB/9rNZveGiDQbRDnRxZ4zOMgjvGc9rW2A/kSBd4sMfvqjgrw1h56s4/2rez3kdFbJuM0k1nLofJoMTmlaLFhW9iuU4HsnH+oHOyVO/PUxEvEabsvQ8BCXnpFRCk349Oq3+fdWEmVdmhrcI2rquFKZSDdueL0dMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806779; c=relaxed/simple;
	bh=zb/wqtoceP7rQokuw62BwnrJfaGX30KLx6uKJCNJ5iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=oYuUxs1hUkcw5zzdJcYQ4yOxZYGT7ZujgzZ/Db1OeSzxdxzzh394mMojOZCf7xdpIt8pRXPvvytgyljWLjCWC/N696eaIkAtgdrloqfntFsBR6FTB/Dy4Lr8LGYJuejncPCPTvfTgXdy0f4QhSwzgKS5i3W2bPw6x0E9U+A4VkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41AE7152B;
	Mon, 17 Feb 2025 07:39:57 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D1893F6A8;
	Mon, 17 Feb 2025 07:39:37 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:50 +0000
Subject: [PATCH v3 09/19] firmware: arm_ffa: Helper to check if a partition
 can receive REQUEST2 messages
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-9-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=zb/wqtoceP7rQokuw62BwnrJfaGX30KLx6uKJCNJ5iw=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1guSUwasvblxx/05UyIRKxy/I2B9unSMhxyG
 raJkTYz1OSJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLgAKCRAAQbq8MX7i
 mMp8D/4/tj2RDchJ64EabNb246U+JEB/pRicqivUqcuoWmC3Tsy4/aSFlfVEXIZmuhg/ilgVQ4e
 2kTvf/7GSfe6YiSvES3quVM0Wf/LUD0KrRdlFBroWG0iHKc7e/VE3lwjaZEYanb8iKy5mqzJn6i
 8HpvWx1N3ginxjHPAJHmmJ8hrPsU7C68YUOF7yl4byyqBn7csqg/W3dt3cjuIuhC2IRG309CiQI
 kf3N50b2GxkNe0z/Pire1vXcgzpVGsdmuVBJAAQdRMo+RNi9URFSje7Ka69uGoiv1UBGWE71cYr
 0wPKPVLZv7C1yiYmPzrOL7lrvn7adANkfT7cp3mmgdkyb4s6jEuCGdLPZzctEzqzyDj0KbMXYWh
 /8OaoRlbcQfaPVYO3ldgrQ7GlcIgcfiI+O0VwYQD7BkaSbbbfrUmr4Ml5OY2S+BAHoaMFDxzZB8
 42c9ro5qWFg4X/zoztQN7561Bj+ndVzjcKuKq+FT0OJs13AUTv5pBgZ9y4qiYyCTl7OjvBvkjFY
 xLPB2Go2S5os3L2NcIIbW63S2BrMTKIdinK2VwfR7DkU4TABTJyU942nB19dzE50sjHKhEhSn9M
 S5GXOLQDumOIsx++hDCMhUyOUxyeWZlysx4AcGZ0kjc1VeqkDL0MEFBpom57pvkKScjJ5JJvRcy
 QTijAplkgLHANMA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

Add a helper that allows FF-A drivers to check if the partition can
receive the direct requests via the FFA_MSG_SEND_DIRECT_REQ2 ABI.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/arm_ffa.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index ca2ad5b0ac4309052d55dcf546d29423bbd40a67..761ea8fe3bb6080c893a5eb365358b62d6a4f3ff 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -240,6 +240,10 @@ struct ffa_partition_info {
 #define FFA_PARTITION_NOTIFICATION_RECV	BIT(3)
 /* partition runs in the AArch64 execution state. */
 #define FFA_PARTITION_AARCH64_EXEC	BIT(8)
+/* partition supports receipt of direct request2 */
+#define FFA_PARTITION_DIRECT_REQ2_RECV	BIT(9)
+/* partition can send direct request2. */
+#define FFA_PARTITION_DIRECT_REQ2_SEND	BIT(10)
 	u32 properties;
 	uuid_t uuid;
 };
@@ -259,6 +263,10 @@ bool ffa_partition_check_property(struct ffa_device *dev, u32 property)
 #define ffa_partition_supports_direct_recv(dev)	\
 	ffa_partition_check_property(dev, FFA_PARTITION_DIRECT_RECV)
 
+#define ffa_partition_supports_direct_req2_recv(dev)	\
+	(ffa_partition_check_property(dev, FFA_PARTITION_DIRECT_REQ2_RECV) && \
+	 !dev->mode_32bit)
+
 /* For use with FFA_MSG_SEND_DIRECT_{REQ,RESP} which pass data via registers */
 struct ffa_send_direct_data {
 	unsigned long data0; /* w3/x3 */

-- 
2.34.1


