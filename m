Return-Path: <linux-kernel+bounces-301254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B9995EE3A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17699284CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB9614D2A7;
	Mon, 26 Aug 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="tjbWHA/S"
Received: from out0-218.mail.aliyun.com (out0-218.mail.aliyun.com [140.205.0.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6E11474B2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667233; cv=none; b=fCauLu83vV7lZE0NgihNHkNsJyr2B1EPuYhohyHElll0AQeaI2qdjrlBlz9aS1SAUdjBiQpK83JU+bc3Cedp4BkA62kHm/4t5NWWNsZ75VOUWd42d1JDiqWqxcdAyD0fkJ3gwKLSNOubHi1V2YnuB5saNqO3FzaiBIv5GA/S7Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667233; c=relaxed/simple;
	bh=xUHAMMt5CPV43RQEHQURLk5SuPKB5Ii2393sz9l5A1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ke7FZYS+26UwjmlUxlls8Do8deEJZ0m3EcFcBXqAeFGxT7BpWtKKl4DxPpTJWqgmmvtUQedget0KGRcHxGZAuYCeB/yUJesDHtuOm5sJCtpeAZ8s95+NXR/yGQSJCc36twyCo5b3HxbfVVBmcQ/maS8aAeK/Wb4TnbJ9KnMzHEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=tjbWHA/S; arc=none smtp.client-ip=140.205.0.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724667223; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Z/OyflIhDj1OPlK2j8cfY/ptojYdSEITrCVMmB0cw4o=;
	b=tjbWHA/Sr1FwuOSeSYEgWK6/nhGdTt3NMZ6tU9+NfEPnid6e4OKFBQHGUNE5ZyT7JRH95QtPQHrZDQu1KBN7q6H0qjMSYCcSSrQXiJ6XSmQKhfq9Ms2Q6B0X2ZDv4pGD2ZoEfXiu8rYlTWUf5+fFssg/99QdouL8MohpxyK87N8=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Z2YRsc-_1724666905)
          by smtp.aliyun-inc.com;
          Mon, 26 Aug 2024 18:08:26 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 1/7] um: Remove unused kpte_clear_flush macro
Date: Mon, 26 Aug 2024 18:08:09 +0800
Message-Id: <20240826100815.904430-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826100815.904430-1-tiwei.btw@antgroup.com>
References: <20240826100815.904430-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This macro has no users, and __flush_tlb_one doesn't exist either.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/pgtable.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 5bb397b65efb..83373c9963e7 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -359,11 +359,4 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return pte;
 }
 
-/* Clear a kernel PTE and flush it from the TLB */
-#define kpte_clear_flush(ptep, vaddr)		\
-do {						\
-	pte_clear(&init_mm, (vaddr), (ptep));	\
-	__flush_tlb_one((vaddr));		\
-} while (0)
-
 #endif
-- 
2.34.1


