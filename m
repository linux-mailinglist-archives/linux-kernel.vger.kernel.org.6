Return-Path: <linux-kernel+bounces-235852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0657791DA71
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369361C21065
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3360012BF2B;
	Mon,  1 Jul 2024 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UUQtGgoB"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B818129A74
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823695; cv=none; b=kEL9XZ8y9y+FzR7zFGpZjfwkNtRQ9g5yfWFceTRLi+/pb+SRy2Utu7XowyK4jQnnO9NeFSAf6NDd8m9PJYNnLilDxpqw9cbP0K9WIZFexK1OjGkUQGft5hPD+ERxIJiQ+lkyHf9IdegIb6M2Sy9ig9fEzWQHI3UeMTIKaqZeAQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823695; c=relaxed/simple;
	bh=QvFNcVsXTduY8ppifiB2ogsTym+Y10v0+psU6b4cCE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMahWMqU8L5TLK4F2QGG+hz+3gVgvdhxEL/cgmPIV5z/QeaFBxF4OCWknZQ+rlcM8n420uGBLieJSs9KWQC8HWW11nNNyUNoNZIDIwUA1Our+LtC1CCap+e2DWhNd3ifkUlszOtosIMQN5mmBiXdVXVuTWpj2ldObgjGr6kTkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UUQtGgoB; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25ce35c52e7so325952fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719823693; x=1720428493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTUbQcnas0bLANV3VeS/cF6tFOZwLY6gcsxQegoCBbA=;
        b=UUQtGgoBiOfZdd267M+d4Pi8gMyNxXe1khQMQ+QYXvhTJ5rXdKzRIwT/Lm3nQFxXOI
         ik7kArbsNKWKRHp0G5jr212CZfQppC93H8qvEF7bjBuUo8Yj4QmZ6/uINEpEBL4nLlrH
         drndC1E1uzLrHoGQchRmkaLUICD4MXHO6Q2hnNhh1n02jkG5WSnKbpF755Mv8SGKrl2o
         9qGBk+8ZkKCs5Hg3EQU/TPg7FqALW5i6QzpwL+Wz1nTt1CL0/0UL+cWQysw7/9IqL2Gk
         9FgpwREC3SfeVwQ42AOSUF8FKvsN0CKLy6ItcSSr925NZWXos1dToVU3a/Q5fdjj1TRc
         wMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823693; x=1720428493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTUbQcnas0bLANV3VeS/cF6tFOZwLY6gcsxQegoCBbA=;
        b=UdhNm5m5Kqk2G3NAPO2adUPkKDPTktLqhb1rANYiVTOdTDzzvcsKIs0yttg4pn6hCR
         +rBZr/iw2r6QkEQHct1zmJ0xwbcV3HDF280QXMZnLf0qn2vmCkebrk68pI+X1BN9WPiW
         k1DZcO8yVQ+MOsw6MJ80xOjCiw9ftC5Oyj65Ak3oR9b5X8Gcgu3nI5oBArGi6dk/sTpR
         kNvUbSp4gFJs9s4Jbo96XKqmPTxSMYt5BTGTcg5E99DjLAKtDzqsIWR3N2WEH1x8Tre0
         I0L1lFTLFr/eeUZEhY7yZ5u9N08xmyk6akbVBfta11RIBYjM4ZPWMDPZ5o34vLQAUjzL
         5+Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUj7vKHhngngeSyOOcGbYbcFfgrWYLHIiKRyjG1YQciW7UyWc0D61LbN83WNlUcflZ7DckSrA+Pcil+wXrlU0JET5Ecc4OpWX03wVom
X-Gm-Message-State: AOJu0YwTzWwtpfqGH/a27HtKqRqtYc1g+bYfLtqYdP8HhzLsfRJyMHcK
	20k0lduImOXDERjkHMcHpeM3ayLjsQoXKHGeYKWDvY7Lx9/HSPyv6u+JnY+4Pnw=
X-Google-Smtp-Source: AGHT+IEOYbpAWZ9+Meh4EfekAHEexcqmS8rjkaDrl5TI+CElE2CSv6vBFMWBxumSSWmDWCJBhTLlmA==
X-Received: by 2002:a05:6870:a511:b0:259:f03c:4e90 with SMTP id 586e51a60fabf-25db36a52edmr5197533fac.4.1719823693115;
        Mon, 01 Jul 2024 01:48:13 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a7e7e0sm5932374b3a.204.2024.07.01.01.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:48:12 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 2/7] mm: introduce CONFIG_PT_RECLAIM
Date: Mon,  1 Jul 2024 16:46:43 +0800
Message-Id: <58942ecf91fea0a62307e5ab848228142a1270ac.1719570849.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1719570849.git.zhengqi.arch@bytedance.com>
References: <cover.1719570849.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This configuration variable will be used to build the code needed
to free empty user page table pages.

This feature is not available on all architectures yet, so
ARCH_SUPPORTS_PT_RECLAIM is needed. We can remove it once all
architectures support this feature.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 991fa9cf6137..7e2c87784d86 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1256,6 +1256,20 @@ config IOMMU_MM_DATA
 config EXECMEM
 	bool
 
+config ARCH_SUPPORTS_PT_RECLAIM
+	def_bool n
+
+config PT_RECLAIM
+	bool "reclaim empty user page table pages"
+	default y
+	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
+	select MMU_GATHER_RCU_TABLE_FREE
+	help
+	  Try to reclaim empty user page table pages in paths other that munmap
+	  and exit_mmap path.
+
+	  Note: now only empty user PTE page table pages will be reclaimed.
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.20.1


