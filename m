Return-Path: <linux-kernel+bounces-340337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA99871C7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37FE1F28834
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C0B1AE860;
	Thu, 26 Sep 2024 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNwe2MLg"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE761AE846
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347318; cv=none; b=Y8g0/DNHj/Jebbor9/M7AkxxHPlTU+dxLe2gZ7x3f//5pLjCr9LOsmKOW7AI8SrmcXA9V62LAGq0psYhobE1YVY+R2tmoXwQo9PzlHLhipiYvPDeG33ZzkwWyMl0fPl0FDaX08HYdq7P7J315BSg33kdb8tLDP+RVgnJv1OJpQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347318; c=relaxed/simple;
	bh=tW34OQN35HutnyCCgx6UGHb/nOO3+lpYGFU76sIkQMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fom0RgYk5mc/RzvGbeRFhSRC8G4kBnUk3kEKuKGAQsvghwqB5CN4pZ5CTif7EM1EcIXi9tj2zeRQGPAFr3bvhqkqus4Q/wiNuCiOGYL4nVCZj1TfG86SW3sAI3Jsv6D9JyaeKOAdK+Hqna7QGj8sCHEMtigGfVSF75Jfd0e5UMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNwe2MLg; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-374c90d24e3so462412f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727347314; x=1727952114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGUWykkQN0qvnmtiNNnHPsRB647HBGhIOvWdjI4gnIE=;
        b=SNwe2MLgH2PuIBVYtFS/TSXWr5wehfrVoY+k/Z6KMeiGMyM0m8EZ6WFKNOMv/MO/lT
         xqTcjoXzcJcuv1zqGWFtgx8tjiqnm9F8N5INQw6b9F8C9r2/97Q3PHSwVerEzYTwFijB
         CMG8qYRfD+F/yspIPpx7CdxMgZFwcjtINBU1LPRKEq5nRv7pLoqugU634FKmt32JgqAQ
         oasXT2XanKocG+vp3AV4RStkrrYvXwqNnZNMKWoeRBlwXK4rZPCalZUyTimmnAvdOkDl
         c2HQCoE1ukaWC+gq/pD+NaFW7J3BqUDUxYGnHQvGniPQNKAVQZ/RTvoga+v3dTWVd3x3
         kCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727347314; x=1727952114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGUWykkQN0qvnmtiNNnHPsRB647HBGhIOvWdjI4gnIE=;
        b=GbXIbi+8dNwY7BQCoNQhFTFssVBQuxpT+ftmgq+AiudO92KA9hrKqj3SwsbyxAWwZz
         BEszhxw2rqmu3kijzWt+ratPz4xgmi/l/mlJsu4+R62CdXy+cl8/OYGCy8E9aqH1GIeW
         NVz+2tiX3JQP6U+NpTeeGA2Hpc2nqkB7JUYManL6gi9Z+CDkyFm2H3OjbQdBBpCFirki
         FDha05D2STKV62MQUmnwXkk2CeTcU5EcIey+Fv3NNG9mfR73nuRJ+zPIIXom6CSQOCwM
         2xNB7hfEyrBZC6GeO6bRQ4UO37NG6ot0aXMfeiatewY7hRwneck2sMFpPNdDzDd96EV4
         XIQA==
X-Gm-Message-State: AOJu0YzaYdNM/CR6lGNE0K88bEyZV6lMTNsTGIj3nraplZM1ShgdBdYM
	0Up4XT7rSghn79tjArspGOrE+yBKRn17TJFmn5Ht0w7bTRHtC3aCSC57O1CjU2zvJsqX38hVX9a
	LlLDeh0u8jplJxp40dXzdmxq8HKa/c96gwnqoL1jwRQC0eV7aDocbqOnnsAVEr2f5R973uAKHcb
	puLrgEpWjLrzu4LWTcmz+7pVNn09vtRA==
X-Google-Smtp-Source: AGHT+IEW8daEir8doMTYKMTvqxc57QBSWijUw3aucG3twtEOjb20bOmmyd2zxDXhxhBNFQdIHerVpIzL
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:adf:f5cc:0:b0:374:ba5c:d59 with SMTP id
 ffacd0b85a97d-37cc22c28c9mr3799f8f.0.1727347313937; Thu, 26 Sep 2024 03:41:53
 -0700 (PDT)
Date: Thu, 26 Sep 2024 12:41:16 +0200
In-Reply-To: <20240926104113.80146-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926104113.80146-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=738; i=ardb@kernel.org;
 h=from:subject; bh=duJbwDYusVICSqLA5fZPaN2Y/gts1cbjl01DSFcZijg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2rle/zunAFTQ8uo0anZz3lB82OHO8LP3L+2lmd1bueh
 fjq+tl0lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIk8O8XwT5P3of6psH2Nt6wt
 14S9Tru+QX3jdqMNE9bvFVnYGfCEdT0jwxaP/S0RDQ9cdv5L82B1q3ql4Zzkajwh8LCzSIzBPTM mXgA=
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240926104113.80146-9-ardb+git@google.com>
Subject: [PATCH 2/5] x86/pvh: Use correct size value in GDT descriptor
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The size field in a GDT descriptor is offset by 1, so subtract 1 from
the calculated range.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/pvh/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 98ddd552885a..f09e0fb832e4 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -223,7 +223,7 @@ SYM_CODE_END(pvh_start_xen)
 	.section ".init.data","aw"
 	.balign 8
 SYM_DATA_START_LOCAL(gdt)
-	.word gdt_end - gdt_start
+	.word gdt_end - gdt_start - 1
 	.long _pa(gdt_start) /* x86-64 will overwrite if relocated. */
 	.word 0
 SYM_DATA_END(gdt)
-- 
2.46.0.792.g87dc391469-goog


