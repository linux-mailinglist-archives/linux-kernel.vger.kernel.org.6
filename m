Return-Path: <linux-kernel+bounces-296759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E530395AEC0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391F0B20E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF60815749E;
	Thu, 22 Aug 2024 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JkkonRDO"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DDF1836D5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310848; cv=none; b=tVfs4tvHRI2d/a4AMQaymBRFI4xwn5/YmmOPHDZOVko7qQBjODek1KGJBc/bFvAETA4q4/2FMX5tAVNP5hCyKMr+aqgcMCg6KrVSW0cVvrv5xQSusZxQHeyKINIO7okyfqZTpyIERiLen7FIXGRyW+ihnxcMJrkIMYe3P2QoZ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310848; c=relaxed/simple;
	bh=cK3nAL5Tb7kKM1XsbrxCIrMB0FYSIjXtYlj4OZV8d1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S01R++ZHWbd95amm5twoXBeI5S2xVClfpfEU1uZdFrWILrOir87nh0gCBi2hUpT6Hrh//e+wV27rGMifEnCt5PRhsgNlGwaTqMTqAULYmgGtE5q9kQU0Z4LAWz0Avj7uRqtBqXR3Iye9n0cxsqVOeERu3KumqKUw81ve0FikapQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JkkonRDO; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db1d4dab7fso291887b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724310846; x=1724915646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1mpKMHwwZ1CFkcRRT4IxjhKZ5nh5A3TknIoqewquLI=;
        b=JkkonRDOJRPG1hnBRvVEB17gladcW4Xb2VYD73s050s4okefohY1qXqvul1tQ94/zT
         1qjzDhquVlN4M4AW4gd0o9AMHHslxwCNpw2un2OSdaeBzzYq77Cc1jxCV0XHws1rj29/
         E2DEON9xo92KdenJtMZ2KWvHvXu/6Qq724YT0f8KZ9KYvBb4q+QxtzAcMSncXoPPfw40
         FLl9+UrUgWa7IkJ7XALI/E2QL5LSqq5FFzr7rmbXAXUohe95exeOR0aUwhWneSWI2CSc
         SKVC+LIYvnmHU6bMqnnNifD3yWEHL0DHQRPd7T6xakneGLwJ9Y3C16KhVAnwiwIKxPMI
         oTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310846; x=1724915646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1mpKMHwwZ1CFkcRRT4IxjhKZ5nh5A3TknIoqewquLI=;
        b=uB6/jCqREFnj72zdYtW1HV9ia7Y9dnLlZf5jty2L7wj2p8nv4a5pCjjJ36MNFTi5YS
         jQRA1CMyOzq0I4u5wfUcJmloQJCNPyPRh01nlUD6GCdgDvRXD+6PQFLjBJRRJaysS8/K
         livgAMrdH3pLrd43ozAonGbcmwBCdaR2T9sNXw1kBtZnsGnGb6xhDoROMR7qX6QZvU3E
         LncEy6HVASxbv2/rgvMuovYqXkvzOMApnATJGU2/6ofdUk0TorZcMwDITUzD/JJOxGn8
         vPZPdpEm913i2KmhRIcTdmQeyNfwEhKeokJ5hRuVQ8Rytk443PB1lY1dSIxMemYAnJia
         0H1g==
X-Gm-Message-State: AOJu0YzNPPCTgJ1lhI51YXZd5fSfkgGcbDURwSOJVO3i57y/LA6t3SQJ
	YfdaezCjj6IvUcRrOnByaWHCDzxIIvoXPPfFzsIghCZ+xf5n8SV+cT5w5bLIqGM=
X-Google-Smtp-Source: AGHT+IFDX2PqWoIoI6wCA8pFxmw/BmBf/PDUvtd9hijDBvTgLhn0KCKCIBnod1yVuIa/+/M4c6qbig==
X-Received: by 2002:a05:6808:1a08:b0:3da:a16e:1764 with SMTP id 5614622812f47-3de194e0e97mr6243309b6e.4.1724310845744;
        Thu, 22 Aug 2024 00:14:05 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([240e:473:c90:f96:d029:ea8a:4e6d:d272])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm695095a12.16.2024.08.22.00.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:14:05 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 03/14] powerpc: assert_pte_locked() use pte_offset_map_ro_nolock()
Date: Thu, 22 Aug 2024 15:13:18 +0800
Message-Id: <89ae94f722996b4ee7ef20d44cd7f5e2f0495c47.1724310149.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724310149.git.zhengqi.arch@bytedance.com>
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In assert_pte_locked(), we just get the ptl and assert if it was already
held, so convert it to using pte_offset_map_ro_nolock().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/powerpc/mm/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 7316396e452d8..61df5aed79894 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -398,7 +398,7 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	 */
 	if (pmd_none(*pmd))
 		return;
-	pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
+	pte = pte_offset_map_ro_nolock(mm, pmd, addr, &ptl);
 	BUG_ON(!pte);
 	assert_spin_locked(ptl);
 	pte_unmap(pte);
-- 
2.20.1


