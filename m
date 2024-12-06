Return-Path: <linux-kernel+bounces-434801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 088AD9E6B81
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91742188117E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D75820011A;
	Fri,  6 Dec 2024 10:13:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6D31FBE8C;
	Fri,  6 Dec 2024 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480001; cv=none; b=OC3uKOuhH3y7SUv+L/jQfu8fr2vEUNI2B8bJZCMJjwLdBkNFNXqWeIM87A0O2NOA+7vYpnMzDV0L+iuL5TL2U0etFDdYRC/e9dtCp6tY7dP4nOeVtiaZcv/m6mUpcBSK+gvm7Y6x477Xzp5GDUsLUUDmg5u0YJYWt7jYfi9NVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480001; c=relaxed/simple;
	bh=4aDjkHibEaVadfQGPlSSmLSpJv3EcwnykRxixv3rl/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijr3e0HCuQlqlwqn5OjCTs3utVOmzVV+DUcK1eOEF4QkMGfmw+d1B3S+A2Np6sXfzUAH95O747K71GW5tJpCq06oCeZct4b7f8UJv2dv99Kf3Il8cWVMwZjgvTnRmR1V1YTLgrnZ16i4go9A4VUavbkU0YrxKoN8s+ywP785P8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12CBC12FC;
	Fri,  6 Dec 2024 02:13:47 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29AAC3F71E;
	Fri,  6 Dec 2024 02:13:16 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	aruna.ramakrishna@oracle.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	jannh@google.com,
	jeffxu@chromium.org,
	joey.gouly@arm.com,
	kees@kernel.org,
	maz@kernel.org,
	pierre.langlois@arm.com,
	qperret@google.com,
	ryan.roberts@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: [RFC PATCH 02/16] set_memory: Introduce set_memory_pkey() stub
Date: Fri,  6 Dec 2024 10:10:56 +0000
Message-ID: <20241206101110.1646108-3-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206101110.1646108-1-kevin.brodsky@arm.com>
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new function, set_memory_pkey(), which sets the
protection key (pkey) of pages in the specified linear mapping
range. Architectures implementing kernel pkeys (kpkeys) must
provide a suitable implementation; an empty stub is added as
fallback.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/set_memory.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 3030d9245f5a..7b3a8bfde3c6 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -84,4 +84,11 @@ static inline int set_memory_decrypted(unsigned long addr, int numpages)
 }
 #endif /* CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
+#ifndef CONFIG_ARCH_HAS_KPKEYS
+static inline int set_memory_pkey(unsigned long addr, int numpages, int pkey)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_SET_MEMORY_H_ */
-- 
2.47.0


