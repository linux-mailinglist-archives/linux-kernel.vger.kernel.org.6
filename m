Return-Path: <linux-kernel+bounces-556140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C1EA5C171
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F03188A70A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4963B2580CA;
	Tue, 11 Mar 2025 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BqeD8fBG"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD605256C95
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696620; cv=none; b=WnXmfzDeSAv+9SGRMjc4qi/7GZpmknMFB+MDz/EZXLQ+kqgbgKpuIWgSS6vWmHu3/sFWhCiM62NSe7TecGbJtXis1n4LkS9K9Yt+u+6dbsbfj+oDzC8jd51tZAeRz0QYUsTxfZDkGnJbugxfMtrD9RUPqJ4yl16Iyd7pBcgZOtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696620; c=relaxed/simple;
	bh=3fO27bZgRSLX+ZjJteSn+272IeY/0JUe6KT6vJpgZF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksCGBD6ojG6PiT8wV6x4ABkwd23Xd5nx9bcHiFSPW58e4RjjmpFTzLyG0CtGffBEfgFLYUkk+TDqabmxNVtCxH3EHNTSj1WfHInyA+pE5KVR0JDF6abbOD4mFl2IMUKbsrBWuHVELHWuurT7BJSy3rCU5ktKjWLl0mDARtX/nEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BqeD8fBG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf257158fso14791145e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696617; x=1742301417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeNwiCAXtv8YYTGNB6COQ1c83CjJXd/IUXH7xE+l9C0=;
        b=BqeD8fBGYb1N+2ZDPxv3fuEKAJAbnrhqj5BWeyODaWECtWw8uiaNIdYzfJuBv/J2LB
         qU4is8T0u/FhQAiwteu9Q67uW3iOwo0Qc1POzeV2mxzundKw27KMuqhmoNDnImApMWNM
         MPa74CnVj4s7EbLTdurkNzitpcQiagnrtviu5vB0LxkEpC5ejENwdmCDbuUw1rkPBgYO
         W69f6+tYWr2zAQkshkkRYqz0z7w4C1NiGiiYKcDOAD5VVo17bujgBoYpWgQORstw5sw9
         5siLzL5867/f25Qnr0CX7iM6NHV/dzXdrR7ENmNP2fy+mcgFDVxXDXoKOoxgYisGcksH
         kelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696617; x=1742301417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeNwiCAXtv8YYTGNB6COQ1c83CjJXd/IUXH7xE+l9C0=;
        b=VNcS7ejuTVTEghRp0c1GwDui0L5nKbz/fG0fdKCR1OGfDyaPehS2qsNL8PwCVgU1Jz
         vQcxvhiNIy6RySLvNCT8YGOWKI6CxykipNTOj2OxroQTTqSJju+QE8c5YPPXk9jdWKly
         g0PCGOkZPalinXCq260hUqDjq8tkH3+dKjXr9HsM1mH0/VoUiSzZman65wzS+yxMj2Qe
         QDFHVaNwlBvWrEFpN+7S22zRwBgRIbZEthEyJplpYsA8yDYNU/HWYOywv1lro+l6iddy
         hl+BwW3e5H+dJkV9zJmDIPI5TfZ83nq/daQbLr0rQ0ZOhY0sYfcgddNzMVoUsAoPZco7
         HYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHaesoZk5lrBw8pqSlEL1LrPDx77WCTFtuKLJqCR36oJoWvJSy1EMzbv9rdG4TvoxoJ1kNR3uPx152Psc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmzKLOcskRK8J2TuDsUhm0F3DXIKoP5V8s8ezprqf6bZP0hOVO
	5MN/Hr9NEK9cD+m6Z8LPoEfaAQ/tRfNviGXkKgEdzu8nw5w1eMYItmyFWABkFlY=
X-Gm-Gg: ASbGncvQiRtiBcILWJ9QWjJ46EHW/Xjqd7cZh1INg4CraNs6c1OsfNOogmR/LxGXC4q
	3QylrayA1+9d7681IR79D0YB2P9iepBg95X2iCic/betJQeVI6uq9BVzwCiTe9fpDDjMyZ3Vw7M
	wKozJBPTLqwlOb+j8/0kqizOODompGj20TQfnfL9oaOAlUiEF8XsbX9X1BxYlNSNpzraHRZFztj
	sDzTo4Yk5ZByaQ3w5UhJF1Zq3QQKcCDaix3MePKWllMnrmFjZLbdhFwvSTXntyWOfMe1VOTN4fZ
	TYRs8kgZU9hyJUbmBGt+q/2MNE56/QCQM5TVVOZLGZYcYkA=
X-Google-Smtp-Source: AGHT+IHn6PvkpQKJBbjtpTZtl/brCs+22CGDxaMUBRMoRp7lTvofXIIlLNevzeSErD/52v0LpfOABA==
X-Received: by 2002:a05:600c:4f8b:b0:43d:649:4e50 with SMTP id 5b1f17b1804b1-43d064952fbmr18361755e9.13.1741696617111;
        Tue, 11 Mar 2025 05:36:57 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:36:56 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 03/11] cgroup/blkio: Add deprecation messages to reset_stats
Date: Tue, 11 Mar 2025 13:36:20 +0100
Message-ID: <20250311123640.530377-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
References: <20250311123640.530377-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is difficult to sync with stat updaters, stats are (should be)
monotonic so users can calculate differences from a reference.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9ed93d91d754a..1464c968eeb0c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -659,6 +659,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	struct blkcg_gq *blkg;
 	int i;
 
+	pr_info_once("blkio.%s is deprecated\n", cftype->name);
 	mutex_lock(&blkcg_pol_mutex);
 	spin_lock_irq(&blkcg->lock);
 
-- 
2.48.1


