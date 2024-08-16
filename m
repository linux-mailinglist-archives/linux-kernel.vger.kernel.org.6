Return-Path: <linux-kernel+bounces-289447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DC1954659
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE1B1C20CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B6A1714AE;
	Fri, 16 Aug 2024 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="adjnjQ68"
Received: from out0-206.mail.aliyun.com (out0-206.mail.aliyun.com [140.205.0.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F9416F27C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802410; cv=none; b=Lq5kG8saiP6oVK7F8tQ9zKlK2N9321joPWkU8bDpxJl+CTHE06N74q3JGOo/gEP4Xx4pL4MHj3lZe3CkhwoHtIlMBeqcwckWsjhfPqtDaAloQr5G3IkdlwyAU0DVlb3IfWsBNmDLnw00R8MRzicGmarp0nIZ/oqkK5F9F7buNrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802410; c=relaxed/simple;
	bh=xUHAMMt5CPV43RQEHQURLk5SuPKB5Ii2393sz9l5A1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/0Gw19iF9vlHLhU92OSlKhxiyJLh6zpx7b+vPUxhKUwBdYuTfNNw7+1TaGpYSvSq/HATn6HIBrOeels5EPY80P/OvJx+PxQxtrkmdVmCCdTXmWX9E0Uut9EnvJS6uuBVj6dggyGXovbtWz7+IxBj5C6Rt24nYHbKHXGAjShRQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=adjnjQ68; arc=none smtp.client-ip=140.205.0.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723802404; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Z/OyflIhDj1OPlK2j8cfY/ptojYdSEITrCVMmB0cw4o=;
	b=adjnjQ68S4z7BtDLveJKwG0T6BpaEDnpobmx9AqsYXfBJLfpUO6/Kf8BHfuyPXCpqPWbtjEa7DPy/bVEogp9KaKFnHVcBFCO3O4FpYTcMr+pW9/I5xYo+EIaJ2JNdC5CeablQNmjAo1CouoagD+SYbuFO7NO9t5S1Tlbjyjk2bY=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtmFE3v_1723802403)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 18:00:03 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 1/6] um: Remove unused kpte_clear_flush macro
Date: Fri, 16 Aug 2024 17:59:48 +0800
Message-Id: <20240816095953.638401-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816095953.638401-1-tiwei.btw@antgroup.com>
References: <20240816095953.638401-1-tiwei.btw@antgroup.com>
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


