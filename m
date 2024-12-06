Return-Path: <linux-kernel+bounces-434952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46069E6D60
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FC7285EBA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA0C200B88;
	Fri,  6 Dec 2024 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZI8kySF1"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653FE1FF7C8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484307; cv=none; b=Hzcnj/27sJsUU3mSdJ/uIZTD+CvovG2rbtb/m6U66BTlB9JZ60iaXgBDh7MmKlyAUfZGnbqucjnv3S+HTjilV3aIdZMDTyudLD++F7CXnr1QSKQDHWadMuXLHQuRC+M7RvmVL2aSK2XTA1c0lvpDtl5pcfxsPRSK/zsgoShG1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484307; c=relaxed/simple;
	bh=TTFZ4CXBOgQ4q5MIsYN3yZmsm/oTlNtD8vDI9zrrcOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QniwALSiNN5oIEJmPmZXyTBgi3be6rkrbyVoT3gMgExUIBRK+oAxM+J4B5VChnSPzUqMIG6HKAr1LBtJlF6HIYXll8lWlj4CDLx1j2tndDOW0lsmWaQKmJ4KMLG/xZ/xcyOwPt9SNlXj6Gi51Uspw+85m9wBhmo0FgT6e/h7puE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZI8kySF1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725b93a59feso541814b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 03:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733484304; x=1734089104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axS0mpcWAsMj7lGkmb/FIxmxAQmAcm2tqBZhm+ItLoE=;
        b=ZI8kySF13g97WxMTCV2CajFGlhxM6H9RdKM9omCcLWkU4wnFxQWWUlBVo6fmcDhnWJ
         Qw35mdNhBOgV4/3vQtKY2y9rK2TVL+KpTGFW5JRckkkN5aEzL20BiLenH5ICO70fr4RC
         0jCEcLz7ohErFJ5FKmSKFvzuDnnGe1C8gF4CNgxQmvohK6rIYNChfmqW0R+aK9aRXTQx
         3V2FElS3kHHgKONEeXISEdk6u0bb5x1c8JHlG1aRhhTXAQhwLCp48jFitSuMJZ7uWfql
         pRozh52pwpyvAqwr/nnOl7UKsa7CA4hKLce34szjqDFP1wT1m+TdyJRaZ7TPJkM+ep65
         LcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733484304; x=1734089104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axS0mpcWAsMj7lGkmb/FIxmxAQmAcm2tqBZhm+ItLoE=;
        b=aDqhyi8LWixVmprprOCvMd88L7s/oneV7F4tsEqgxWfhaQH2a1nJGCv73LTQqxcdNe
         g+qENM4+jvAc8DS5TAUDCAowGdg5LMZ1lEPR33QevBfb4LQR1HhwlfM7aXK9+nyKwBcd
         FVxIGSotHTF5Uh196oc6c6QVUcAr6ytz/WtHQyz7qz1XG7F7cYEJtGsf+OvDLYMO2fql
         LB/ckkFeNmyZREdd2IKrc2gH01xn0iBU7C8esFErtdK0ggQK555FKPujjZC1D8UpZaZz
         vFOS06maSIgCctx6uJ62n/tjH8Q1iEQaRKWzAL6axZSFo1l5fxXHjOINJbfnql4Ohx2X
         6Ulg==
X-Forwarded-Encrypted: i=1; AJvYcCVo3CvVdHVjtd9zob7o5KfYvmy35ntgsLzMbHGgoTQQJ4vsTCe+H81yk7Fq9YY2DDWoxJoWltx5jBdjFUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx2bNPlTClfR5n8aHfCIQiqtUifbNJAJRUufThnKc7ih9P0jNq
	MJ3SYz/x0i6ejyiXkeLhkufvSj3gHXkL1zvJANNQ6Nk5ZuoeHKCT7xpTb6RBbys=
X-Gm-Gg: ASbGncs/bo4oe5opNLgchNBz2apATQPOHa7NQCo1Ig30qA33Q6/Rn4Gf0J/daAJ/weL
	Ow4krNIa5HAZiYj1kYIpT3lG4bayqDBVo5eliJL9aHMYz5/dhTbG/r3ZMtKO0LVl4SLh5ZyFKTA
	LH9odcAsNXa/Rs2dkQ1xyMzeOuFQ5nB1GTYS8e/Xm5mIiL3D6Akiai+GYYHpF3GeDfcfYa+Mw4n
	G0oNVjD21MMY6It6mnx1/MUK/vPDJQFjkW7+qiKeayjzrVI3hJv+9fV0iaSQ4j204oJOpHyXwa8
	5msJadG+Ovcs6A==
X-Google-Smtp-Source: AGHT+IHzXCqK7Nq67xvQiiO8Mynf+aHH7g6jxp0vKtZyuMSGX/7uZxLiIx7gwmRGPwhfZ7cakjLiMw==
X-Received: by 2002:a05:6a00:92a6:b0:71e:6c3f:2fb6 with SMTP id d2e1a72fcca58-725b80ff2f7mr4574374b3a.8.1733484304628;
        Fri, 06 Dec 2024 03:25:04 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a90345sm2822911b3a.109.2024.12.06.03.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:25:04 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: akpm@linux-foundation.org,
	dan.carpenter@linaro.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 09/11 fix] fix: mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)
Date: Fri,  6 Dec 2024 19:23:48 +0800
Message-Id: <20241206112348.51570-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <92aba2b319a734913f18ba41e7d86a265f0b84e2.1733305182.git.zhengqi.arch@bytedance.com>
References: <92aba2b319a734913f18ba41e7d86a265f0b84e2.1733305182.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dan Carpenter reported the following warning:

Commit e3aafd2d3551 ("mm: pgtable: reclaim empty PTE page in
madvise(MADV_DONTNEED)") from Dec 4, 2024 (linux-next), leads to the
following Smatch static checker warning:

	mm/pt_reclaim.c:69 try_to_free_pte()
	error: uninitialized symbol 'ptl'.

To fix it, assign an initial value of NULL to the ptl.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-mm/224e6a4e-43b5-4080-bdd8-b0a6fb2f0853@stanley.mountain/
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/pt_reclaim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
index 6540a3115dde8..7e9455a18aae7 100644
--- a/mm/pt_reclaim.c
+++ b/mm/pt_reclaim.c
@@ -36,7 +36,7 @@ void try_to_free_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
 		     struct mmu_gather *tlb)
 {
 	pmd_t pmdval;
-	spinlock_t *pml, *ptl;
+	spinlock_t *pml, *ptl = NULL;
 	pte_t *start_pte, *pte;
 	int i;
 
-- 
2.20.1


