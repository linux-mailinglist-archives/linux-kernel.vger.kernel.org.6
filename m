Return-Path: <linux-kernel+bounces-339967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B48986CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88911F245A3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D1718C357;
	Thu, 26 Sep 2024 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LBOn9E4E"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02718786B
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333233; cv=none; b=lHbX/6NgX4MlAG2ynZWOADgQ2eXC6nOJw1nSjdENHkE5BGvYo3oLmaKVZ+FZVBtwP+Rovx8r2Ehvt6ri5p6wc6Ee3Anv4mC8xfZ5SNPW+I490VbbgD6+Czped4di6tVh0YAgaaLxzOoEDl1zO0w1ZSR5YwfcbjNRaqgmf81+trA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333233; c=relaxed/simple;
	bh=CYi+EZMylLlMSCqw/uJB5X9IiL/Hx4QgVrtaCgCZ208=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W3pTBEKNfgMJVVaV5NSOy9shIzb6iHSmnvWwzwLTThH6eWhnjPmW3ZZZ9wdH/MJ18LeXKdIrqqFPxO9Ve20XklSGesHqkJGq6cXtEyY4cxfBpJm+SN92zOXf4UrY8ofXW5u0FtflObwbOMlltqtsYeQxv61q5pMTZheAv+7cpps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LBOn9E4E; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a99eee4a5bso52392585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727333231; x=1727938031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmENsM1LVZMrc0W501TyzYIERT8c75Mhan1AJ9vs73Q=;
        b=LBOn9E4EJdvphOHdtKRRdaxL3J8x3ZkXBrQT9wK0oPsWM2/bBHwWpBgGemTXH+iE+u
         2EYftdyOgDODyl8YZS5t3Nlr45b7W+mbAcBZyry5B+1NmULZSKV2EbNTRXCQTTxw9IQ3
         2q5bWuX1DNGv3x0XIrlI1yizowsjfl7Mso95qjnZakdtv/MSanKHjij718OjfP3f/P7y
         2Q9jI+VeOABoEosklEjAxcvPQizzfIayhk99ighYb7qfb+Th+8DTcNwMHLOnYR2GYH2M
         qpmq3bf4fHc/aKibsAR2DkZfnlTa5n91N4TcXHmqxll+fEfW4P4ST/pIYArZBaytfo9q
         YR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333231; x=1727938031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmENsM1LVZMrc0W501TyzYIERT8c75Mhan1AJ9vs73Q=;
        b=aYlrqfQ3XRsEMzb600YmK3RDLrioQzptC2Mu4z9K0Vng5leB4ZCthSEPZfZpbffNbO
         1HK4X1YVoMTKk65gKkUkdpiw9JLYhZIGDfsHe0m+J+mNfl2bK7q2DBQH6bKV4STF7bAd
         /RLllLHzXAJcZzMrsr8bZ+lnxJkgd7VgCwBxEyoez6yCscoxHylnGFDdjqEL0+daTovb
         0ccPBnkB2odYKvTJNlPoUGD/opooEp6VoGvm4bbs8fkIkhBuRlMGJ98/Ys9SgZbbRxwH
         AKisSUj2eFEYFBWahmmx63o5MEGYE62Qx7NuXQ+SPdWoD8OWtA6/krhpYMpCZRn1Ihwd
         DQaA==
X-Gm-Message-State: AOJu0YwNjwsqOvvf8Q1ykkEYJfYjvEY4Hh/pn0V9mekcZ7g4cO4GoE6v
	oWF4/uK8mx6LSQ85WcSPSaIh0XHYrIG9v5oOi/69LrJlEYLdoufCF2tyjQ1iWEQ=
X-Google-Smtp-Source: AGHT+IF3jq8XAx4d8MvdG//ydygdKBfb8RG21eWCHGRQrOC65QRa0E/gKmvca15+75cy4x5ki2/uwA==
X-Received: by 2002:ac8:5914:0:b0:458:fb8:9dc3 with SMTP id d75a77b69052e-45b5def1dadmr61649591cf.25.1727333230912;
        Wed, 25 Sep 2024 23:47:10 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257ff1esm23024611cf.38.2024.09.25.23.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:47:10 -0700 (PDT)
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
Subject: [PATCH v5 03/13] mm: filemap: filemap_fault_recheck_pte_none() use pte_offset_map_ro_nolock()
Date: Thu, 26 Sep 2024 14:46:16 +0800
Message-Id: <9f7cbbaa772385ced1b8931b67a8b9d246c9b82d.1727332572.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727332572.git.zhengqi.arch@bytedance.com>
References: <cover.1727332572.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In filemap_fault_recheck_pte_none(), we just do pte_none() check, so
convert it to using pte_offset_map_ro_nolock().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 3e46ca45e13dc..6c6ff8722550f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3271,8 +3271,8 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
 		return 0;
 
-	ptep = pte_offset_map_nolock(vma->vm_mm, vmf->pmd, vmf->address,
-				     &vmf->ptl);
+	ptep = pte_offset_map_ro_nolock(vma->vm_mm, vmf->pmd, vmf->address,
+					&vmf->ptl);
 	if (unlikely(!ptep))
 		return VM_FAULT_NOPAGE;
 
-- 
2.20.1


