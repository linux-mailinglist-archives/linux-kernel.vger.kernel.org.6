Return-Path: <linux-kernel+bounces-566740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016A1A67BED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441A5189EF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A6F2135B2;
	Tue, 18 Mar 2025 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4HiO9rb"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7459154BF0;
	Tue, 18 Mar 2025 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322636; cv=none; b=BlZ6cIDC3q+9Pmd1/XTh6mW/gOWkDz1Y4UTs3LWNGClKkmdA1iefkqlCt+YOUaFDa6eqEnpF5iSONbVx7bj2vWuEs4VmaG1jIBLEk3F8vSKeT6pwPyY6fjEEjG31iquE4GY1uJ/d655q548S2FNKf4SN0CDYiKaOGiVFqKGRYoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322636; c=relaxed/simple;
	bh=8UmMrEbwosQ3I7rVgmJ3k1gmLZhsQSeAtpCKw7acIy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcCchQkunXTsSSRPRjAS4Fp2qnedNm386Fjxv3NT+RRSOpY1VOjLHOTcrhK68/rmEx1Xk/tJ3axjFKkXnrcZm5r7RVVZepL1YGbzLPpMg50f1A9DWoEcfeB5Wi00etuCu6k8QSWGLnQj8+3llaunSIU2OxUe+Vz9w6fZvArHA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4HiO9rb; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fead317874so49240087b3.0;
        Tue, 18 Mar 2025 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742322631; x=1742927431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bz8uuhNno3q6sJ6pl27PZsjnFKz8/XRS+VHqCZ7l+k4=;
        b=R4HiO9rbnDKG6npK1MwCxerP9BIagRiTZSct5xZNgN6KyikA5weicMqODtyWHCWFIY
         nh9PmU+NimvlOSa2zxzCXNJjQIrI63JneNoCRD5nObuP1UOcp6zjv0LKxfeAJLPr+nbA
         O+RnTMLGhEG9ng2jLkUSn2S+PXCkAE8ovufm41ekVPPfZSUWwaHR4uiGN3WujqHfsUrJ
         Acn1JoM+B/nB2WOTv3oYhizV7S3mX7ePHla1Pev1TdgAOXNlkLHi776TPHa+Odt4VQ1M
         WUT3NYeNCxttvNLrnosISD5P2q3Qh07GzUBoMrIZI+kYxcWfizbF2m0v7uHLGX/Ycr7X
         imGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742322631; x=1742927431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bz8uuhNno3q6sJ6pl27PZsjnFKz8/XRS+VHqCZ7l+k4=;
        b=sVyWrWU8ZfRKLY37g+623OTVvuZuRxcDKTLtoCZ6BKTixl/eGvrDbuALLA+SWapIIC
         P9RnGBn7x91TIt79ukAcjZm36XKChMTQ/ag/OKKuUfM60hc0p1KoyeCdTn6cvQfnqwdR
         aaofDcF6Ywm9cuJ+bgjkkjiZAlLA66RQj5hewLLSyB4KyQDCs97OQAWWc7r6RCqQbAFH
         vQyXNrY62V8BQPqakr1D4T7b629N14AKJ/VhQCXsaXHGpQh7PgjiDr1ySx0R6LK+weVB
         LJVFBEe6ACy4j9CJ4fK4ry9nhcLzR6dLtzDPKT77sBm844QW1oKb3icLyIyLTsr8PHCm
         m2oA==
X-Forwarded-Encrypted: i=1; AJvYcCVlLeT/2okY/uYpQfoIKTpEWw+j6kuPQgMqVsspVCheNwj5e4jC5PPt28gQfhydydyYmJEDSbdlPfU=@vger.kernel.org, AJvYcCXUBKAwRfvnsDKZ/+H/HAApQ4syUUCYC1FNmtuBmbNSceWuj0cMkOKliZ2Tj/BI6OrexUSqXi3wkxVbtZxa@vger.kernel.org
X-Gm-Message-State: AOJu0YxjgW8SdNOp7+1qfqZeMZ1itpY1FKl/Trf8Wdz8loCJ2CoCB6vN
	9LBtzDPjAdveWGz0Ruh06HzghcCReb/fmvPxcY+EttOcpJmsIqbU
X-Gm-Gg: ASbGncu4Bj8suC3yWSj9zVGw07xUPdKSIUxOHR8TwYWsjwlpSkIDl6T2m4Uj4atTZX8
	WwEWeCPgmIz0/FBE3naRQqxJ7jDFofGcWQCLgKvDA5mMpJPzDM28kp73546mJx5WEExGZXErBlQ
	Chqga6cxqbMRcs91SyooI5BGtR/MR1X3Ip+nwPIwrbGACs3fJkrfapP46WWcn1cKwIvgg1Dcc59
	vYlVXkNwBlp9LdZXkzzUXHZPlXnM512jD1sDvka0Gba8MyNoy+TOA0//5z0cThSijbBxLDjNURb
	tF2QwvHPW0P0Wa7iOXXE6kF28rU0VbQUajhGlRnTDOX72w==
X-Google-Smtp-Source: AGHT+IGYgBrUer7kW3bh3Q7uDDRkpmEW94MY1wds50m2vry9jn+b2LRjGPiGem3A0ZsXjlrEpDiQ7Q==
X-Received: by 2002:a05:690c:6f04:b0:6fd:4521:f9d7 with SMTP id 00721157ae682-6ff45ff5be5mr220687117b3.24.1742322630662;
        Tue, 18 Mar 2025 11:30:30 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32894c7csm27161417b3.65.2025.03.18.11.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:30:30 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: sj@kernel.org,
	corbet@lwn.net,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	damon@lists.linux.dev
Subject: [PATCH 1/2] mm/damon: implement a new DAMOS filter type for active pages
Date: Tue, 18 Mar 2025 11:30:28 -0700
Message-ID: <20250318183029.2062917-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250318183029.2062917-1-nphamcs@gmail.com>
References: <20250318183029.2062917-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a DAMOS filter type for active pages on DAMON kernel API,
and add support of it from the physical address space DAMON operations
set (paddr).

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/damon.h    | 2 ++
 mm/damon/paddr.c         | 3 +++
 mm/damon/sysfs-schemes.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3db4f77261f5..47e36e6ea203 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -334,6 +334,7 @@ struct damos_stat {
 /**
  * enum damos_filter_type - Type of memory for &struct damos_filter
  * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
+ * @DAMOS_FILTER_TYPE_ACTIVE:	Active pages.
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
  * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
  * @DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:	Page is part of a hugepage.
@@ -355,6 +356,7 @@ struct damos_stat {
  */
 enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
+	DAMOS_FILTER_TYPE_ACTIVE,
 	DAMOS_FILTER_TYPE_MEMCG,
 	DAMOS_FILTER_TYPE_YOUNG,
 	DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b08847ef9b81..1b70d3f36046 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -217,6 +217,9 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
 	case DAMOS_FILTER_TYPE_ANON:
 		matched = folio_test_anon(folio);
 		break;
+	case DAMOS_FILTER_TYPE_ACTIVE:
+		matched = folio_test_active(folio);
+		break;
 	case DAMOS_FILTER_TYPE_MEMCG:
 		rcu_read_lock();
 		memcg = folio_memcg_check(folio);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5023f2b690d6..23b562df0839 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -344,6 +344,7 @@ static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(
 /* Should match with enum damos_filter_type */
 static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
+	"active",
 	"memcg",
 	"young",
 	"hugepage_size",
-- 
2.47.1


