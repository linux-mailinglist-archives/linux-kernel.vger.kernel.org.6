Return-Path: <linux-kernel+bounces-576309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F4A70DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7FD189F764
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BACC26A1AC;
	Tue, 25 Mar 2025 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDe3jjJQ"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0CF26A0F3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742946738; cv=none; b=K/eb707BC6JTwahC748KG0B1XKie/CIT4e+2PI07/io83i/D1qeim5d56dEvTve64mhs3iDFegrZJPGLOfFJE1fU6zqB8vo2wQMt0hwWEq2bQRQEMLiIRQBcyZT/O7vr9smwV2vrcIPbJqy64dBYWgWl8OyelPkipB10kyTVWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742946738; c=relaxed/simple;
	bh=IJHMfU0+bj5AibH3+6BRIECuj8qg4Ch5vf6J0tJsttQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYc6XIrYtaKXaR3LUbszAtCsNKLfaddjZ2ewYb+0cDUZrfcEyH6LC8LFM2dqVXf+pvfjqotNV6xAh8wOwtBM6lVse54s5Tf8WlI2VJaaZWVUYWGYEsrMGejXKIN/YTQNrnWALMydEtpFSjAfkBo68GK88AqPdTSLI1t3fyl/zJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDe3jjJQ; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d58908c43fso15168785ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742946733; x=1743551533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSHSr0u4As7sD1DIiD605hwGrKMgm3oDc7PmVTv7IgM=;
        b=VDe3jjJQeA3eCkz5CzCeZlfr2Xka4bGJ0YTv/6MaXTOuMzsijwCGFzz5ItKc2VkyQi
         TiW1owxVAL9T68MPiTwjJZDm50fGzJsrNHg5CjkMCCit9hOba1Oh4T6+QGVzQ8ZiIwvi
         SUvfFrpTew8KykXlObkqrwZjqVwpUJFthhj0Oqw2tX1ZxaLJic09MUrT0gnpToI/AS/M
         T6NdsjuUJDhU5HU1y6VdapfLZi8MOozTGXUf3X9Pqhi4kF57d7nuUFRCs+Xq33H6c4nY
         s8ejERG11pPMDuyiL1A4cTfMxfkyHuWJVe1wM1F9w5OMGCyL2uNwenQygyeCaFQ1VcHC
         ypZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742946733; x=1743551533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSHSr0u4As7sD1DIiD605hwGrKMgm3oDc7PmVTv7IgM=;
        b=iq5uQpeykmd2P2zxo6U4SaeZYkkuibRr1EQWxpJbAGzIBekaZltgaVhmsQyniiB9p/
         I8XIKnH44RBGFEivw5HDu1NtM30Nz/B5NBAHkpYSoVJecDbwXWUUyABMc7OnyflSCWVu
         yrMbcPuqOXPlhVfSJ+AySicqVOIeyG4w/V4cLYxlLahP1tTBbWhs4patEzzQ8wBnHIFc
         O/uqDMJIYgwgXTr7KapwO8uf6ppdrbBBFAqaa72tk8BP6ki5aFOO6GzUOlPm9F9eTy88
         Jl8iioQyTKGRdIZEerW+bX+EVWSSP6XHSV/uCQ5SftMqXBObUpvb5BPljYts9Ve2HxWl
         XZEA==
X-Gm-Message-State: AOJu0Ywx5tNhDBseX5l0f9O1QYcSZGnvllz/Xs77rHkizZt/iTEtp9MF
	5acVepgF1V4nGY6alX0Hyy6fczWmSC2PJUTAiG8N4CEbSMawPBOc/FDaLrLD
X-Gm-Gg: ASbGnctUM3rKw0FItjD460wPnoTqFymmdI0jCciV9WKGWV5WthSDT2bTlP6lOfcUpmX
	U8aGX7pzWXw0OqgHpsd6LeYNFESQkOuqSSv7YUHIG7poeXeJRT13K2NEMmW7i7nSv6SgmeuFq66
	6+PZe3lg6hhPrpSJbPd8kaZABTrQMhhgwF0bezGHuhNxMeVybP0JzPlm8ZjML/3Hl0HGhwSmB1g
	XwnE4ZIxGmTzAopi7AVzPdPo4RIm427Ng+Szhmbm8sGSpYCrtQguyIjBQtx0FwmG9gtWcwWypN7
	yVT5k2mIKR7YWPI/h5w6EWGsTmrVRhXtBeElVZX8nGDNBoqYjLpQqiyGusw+uksRAOPza2xwMDL
	PgA==
X-Google-Smtp-Source: AGHT+IEWcmVoDR5hy0HIKUuQ3tRpK1CPyfpUq6GeUKLrvaSnNV66+zs6I/lD783Hseg0FOQdhBHTBQ==
X-Received: by 2002:a05:6e02:3b46:b0:3d5:817d:6462 with SMTP id e9e14a558f8ab-3d5960d112cmr189774785ab.5.1742946733209;
        Tue, 25 Mar 2025 16:52:13 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3d5960cea10sm25191175ab.45.2025.03.25.16.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:52:12 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 3/3] powernow: use pr_info_once
Date: Tue, 25 Mar 2025 17:51:56 -0600
Message-ID: <20250325235156.663269-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325235156.663269-1-jim.cromie@gmail.com>
References: <20250325235156.663269-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reduces log-msgs during boot from many pages to ~10 occurrences.
I didn't investigate why it wasn't just 1, maybe its a low-level
service to other modules, re-probed by each of them ?

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/cpufreq/powernow-k8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index a01170f7d01c..0559be0d87a5 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -482,7 +482,7 @@ static void check_supported_cpu(void *_rc)
 		cpuid(CPUID_FREQ_VOLT_CAPABILITIES, &eax, &ebx, &ecx, &edx);
 		if ((edx & P_STATE_TRANSITION_CAPABLE)
 			!= P_STATE_TRANSITION_CAPABLE) {
-			pr_info("Power state transitions not supported\n");
+			pr_info_once("Power state transitions not supported\n");
 			return;
 		}
 		*rc = 0;
-- 
2.49.0


