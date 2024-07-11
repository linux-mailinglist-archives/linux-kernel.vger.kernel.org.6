Return-Path: <linux-kernel+bounces-248478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 196E992DDCE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2671F21BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A126412E61;
	Thu, 11 Jul 2024 01:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivZe4S59"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F9846D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720660481; cv=none; b=rYgCGzRLo8QT3696q+yB3h9ZFR30p9raGOZw0vvo2/4vclDK3i2+2mSFS9JqzN4vWVdoDRXpjln+ZG/8ugpLDRvNtZGHrX9f8wLDdo24yaRO1Z4ffGNXoZJyoOTYr+tQVoLi7hFeHNEfc2f0Xo3iIgTIXcE/MW3cNkjjPRQNtv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720660481; c=relaxed/simple;
	bh=aCcU8D/HA3AOmmq30NjBaRtOrQM/E5cSKRcSUR0nrq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAsn4FjbSdckY24EV6/LEjVO5qAgIyWO4FEsABlX2ibYGpsadE3IY/xSKtVkp3Qdw5du9I+gNiPP+FKvVg36rEIqwjhaR9ncLz8DQmeuWsG32z67kWYMXc5DBlCsns7ufQydFFf3FS0PAOoDhxY3KKxXIdASqom6+ui+ifo+QcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivZe4S59; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7044c085338so157468a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720660478; x=1721265278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLpFF2QtJTz3xHG8P1oE2tfsRpQQKY0Ug0MJ6FC4Y9Y=;
        b=ivZe4S5967D0qt1RzlwZqVwyRsFvW9KWQsBAetG7xIxaq3G6gcCCvxjAiEkbCGnWgc
         OhSkIJaHvt8JvhNtNah9mZ3qQ+gT7HtYuRDT6dbT6L8QV8sUyi5ARsSAaA/10DzLeD+K
         YnBoZtZyMBx66L6zNI0/wHci+MyeWLLmkAYMUURsZJnDvoYS7Tbmm3LKzZHxytf+l1yX
         FmMh4BP8piCE0u+bIAy0IMKbA4C9wr8LxXdHGVpTZth79aDqgA5TtgZUG8vZ8uUle+dw
         3/au3BK83+Dv8vsm6uGIsNeInD4g6/kgxOTAHvXFhlW8mBN4HvBeNoL0PJARSaMPS+Qp
         Y66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720660478; x=1721265278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FLpFF2QtJTz3xHG8P1oE2tfsRpQQKY0Ug0MJ6FC4Y9Y=;
        b=cG4f9qS/hSV/ni4nKys8Cjgx4MhNFrpZiDUG5zeLpO8QlaCEUGGQSG5ZQ2vGo4BUdb
         tLllGnIIgtdfJXRDWGrHbNQztBdS/sNwwVWCLqjg61riVD4QeTZVAgkY7JgjJ7qBFEth
         cckppn9CdPa6n6LWUuwtKpIpejZjCq0fzBdiuWqRDP61sw6z+DhaurJGXqhcMNsGNoE9
         xdSeKFRfuwLKC4GCQn0C1dOm9yQ7QG54K63vAoupmsRTOBPgrDB/DTJs5XrNu5Wg4hst
         e0K/a8DxFpH18n6cntX+qKxoF/lnQ1baa8MdufDxRX027Y2dZ0XCfh29BQvPgsUJn85T
         OYkg==
X-Gm-Message-State: AOJu0YzABV/CwAL4eSwWoT2+21ymJcWhlYVLXBGuQRzxxmswdr3AR0C6
	BVi/F4iXDL6Lnq5otvF72ro/aN/G6jBk9fX6Row+W1C3oTl+X8kG
X-Google-Smtp-Source: AGHT+IEmQipIrMiFs6XZ1me8GFGgIUTqpoQtNJfVloVulyTUEB6cWxyYjHSwPviKBJiam9EH0rLCAw==
X-Received: by 2002:a05:6870:d626:b0:25c:c42b:5349 with SMTP id 586e51a60fabf-25eaec582efmr5611260fac.59.1720660478370;
        Wed, 10 Jul 2024 18:14:38 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4389c372sm4590376b3a.14.2024.07.10.18.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 18:14:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	schatzberg.dan@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	changwoo@igalia.com,
	righi.andrea@gmail.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] sched: Move struct balance_callback definition upward
Date: Wed, 10 Jul 2024 15:13:58 -1000
Message-ID: <20240711011434.1421572-2-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711011434.1421572-1-tj@kernel.org>
References: <20240711011434.1421572-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move struct balance_callback definition upward so that it's visible to
class-specific rq struct definitions. This will be used to embed a struct
balance_callback in struct scx_rq.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: David Vernet <void@manifault.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/sched.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 04184e87ba7c..86314a17f1c7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -615,6 +615,11 @@ do {									\
 # define u64_u32_load(var)		u64_u32_load_copy(var, var##_copy)
 # define u64_u32_store(var, val)	u64_u32_store_copy(var, var##_copy, val)
 
+struct balance_callback {
+	struct balance_callback *next;
+	void (*func)(struct rq *rq);
+};
+
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
@@ -1054,11 +1059,6 @@ struct uclamp_rq {
 DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
 #endif /* CONFIG_UCLAMP_TASK */
 
-struct balance_callback {
-	struct balance_callback *next;
-	void (*func)(struct rq *rq);
-};
-
 /*
  * This is the main, per-CPU runqueue data structure.
  *
-- 
2.45.2


