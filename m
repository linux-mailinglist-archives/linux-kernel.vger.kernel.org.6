Return-Path: <linux-kernel+bounces-314567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFAE96B547
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 726C5B21B90
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE08D1CDA09;
	Wed,  4 Sep 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="V2hc6NaB"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F381CF5C3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439265; cv=none; b=sKxypGBIDJlg7co0VUjZnRIkEnwwocK5uJ900tH73rf7oa7jTTWRx5vQtahtJHBLTlazMiV+OyL7gwXA3+YKjk08iMHSpWP7UANyws5X4r2DiulAp+5Jlq180qJyCGVSPmDAHE3RfUo24wUy8Ws7qogz3/IZKWCpvYF+G+y5gyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439265; c=relaxed/simple;
	bh=Ks+ctZjoe6oexIKNJorWHsj/FHxBIY1SArqgBxdFKSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FDM76jLAm0IAsHtijjo/ocpXjuglqqNXLkCCVE9e6kn8ZJq8qw+qiFclQCGvtxzeBr+MRMmpq8Lux94yjTjY4S93WAH3ulfechSsl59wFl1q+Y/EWGirQ4vZVAXP3ToOpHx+JWpHiypglut+l14kwgGU3oAzCn3Ah1zjYZk4L0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=V2hc6NaB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20573eb852aso3452365ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725439263; x=1726044063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WBwKEY9MWquOlo01BPdpzLz4TZdRIsQgPATlcDwMyk=;
        b=V2hc6NaBrZkWeQ0WQyvpl2gJ76mcNH2gR+15KXmAYJb8WXMaw3FCdaJL45jSV5xX/I
         No/yREwGCzNI6qRIFgnANtmslsaBBNq4jx2COw2gC+edRn2c56mdZuZZmI2qAsrXeN20
         vtJfCNRAePt9G9d992zvuzNXdGyfW5DkTGRt56ARDuAUValARVZtDtGQ/CvnvK1Oanmk
         mTEHKML0CkmM2/y3PB/PARPHU9POC2D0mLuANdx3L4WwhzkxQbBNhbIyo9YnB0NgkKgA
         DTEu+L9+UHmeog9gUAGQYtbM0iXukANUj4Z3ThjqmjpUXZwDeUMFOCOstaHVW2xpFcU+
         GQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439263; x=1726044063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WBwKEY9MWquOlo01BPdpzLz4TZdRIsQgPATlcDwMyk=;
        b=F1QClwJIXCMFpf7YdroD29mOEmQV3u/qIR4QxBaSX6wUQPXKw7OtCBbD4oIJBOCOPl
         GCzOS2kyR1p6e4t+Ra/S9fQkFG2qNDKcunXoay9S+AFgc0psHDg9SF1ZmCgkgOoJG+VJ
         7MpHkGBd8fH1OndsblGM58PzZh8VNDbbTs85R+jaL7E6i+0ed3Y7q6l2KreC+o7WsLBd
         86dmYygY3JhNxDlaLmbBQhLzGnlau4k3xzDfwzwmTFNa0FFZpPDb3DcI3p0/S0lt+hoC
         TiL/6FLvfKmg3tJMIkNXeWLofGRLgIuxZsr/99QzzUGE1Br9+TGqm0eiJws4QPFj735M
         GI9Q==
X-Gm-Message-State: AOJu0YzdzB4rCppTHm804PbAY/V+9u96nhydL5V0xN5ml4uFRi5urNnG
	pLczLdPWbsCHN29LZWpw0KrMK83i9tSJQs/xeX6D1LbnPql4yQAvekdlMoMJVaw=
X-Google-Smtp-Source: AGHT+IFosxGKKraD23O7QyExDWz973MicB0gfFUEF3j/RrDnY2sLd35727GFsppJnEl62/xkyI7W0A==
X-Received: by 2002:a17:902:c412:b0:204:e471:8f06 with SMTP id d9443c01a7336-206b83566dcmr20294065ad.17.1725439263160;
        Wed, 04 Sep 2024 01:41:03 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a51csm9414045ad.117.2024.09.04.01.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:41:02 -0700 (PDT)
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
Subject: [PATCH v3 03/14] powerpc: assert_pte_locked() use pte_offset_map_ro_nolock()
Date: Wed,  4 Sep 2024 16:40:11 +0800
Message-Id: <20240904084022.32728-4-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
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
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
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


