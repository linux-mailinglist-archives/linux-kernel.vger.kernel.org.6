Return-Path: <linux-kernel+bounces-284716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79137950463
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D9B288236
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A59199384;
	Tue, 13 Aug 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh526LHw"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CED19AD5C;
	Tue, 13 Aug 2024 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550633; cv=none; b=B9LuEFYe00YARzU8YdS3QlwN4S3k6EBF5IWTPU1aKvMpxetrLx/dPI9cdTn3qzS9UbNym7qqfVyNotgh8tGAWIeXqymJmATOi7qXnyxFRzEa7zYpR1+Fll62IyF6LahoD05EpMWj5qy/I1ZBnlaFFG3SNJW4CDoS0kjBSZ04iK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550633; c=relaxed/simple;
	bh=J8iCl8NFugwQEvqBetgBik9A5B1qMEYPkoEZhRroEr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9Bpj0gzvPUlTvi7E/m7Eq/D/MZWfqbvV3B6apkRJbJEvJpsQT37gBvXeYrYGvPraltCNxrUlSCWh3gOP5zEbXCF47vmRETvZrETFLsm2uyMtElTDMqRmbePBC3TQp4+f9NDuY1FiPFjLR7hcODAT+4yHLIQ1Rpp3GsFH4+Ep+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eh526LHw; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b79fc76d03so30950326d6.1;
        Tue, 13 Aug 2024 05:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723550630; x=1724155430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpDDmqOnJijcRyZ/zRVr0dfh/EUV8mM0nwD7hiV/Er4=;
        b=Eh526LHwFRietxpi0Yr2Qp+4lWG2PCwUeOb3l5q8sAcOy/AIgIyXLRAyqONFd9/eir
         CLa2NoqdvA6LFcjJ9Qwlj2apGGAbzbGxuCFBuf8uZgrdbgf5Io6xUDoh1PWXIobwY9Tx
         7tJYrKqBdYvrmqwmyIXqfpvCy2mljWdMZPBv01yAm8jE8U21RknRKhipjM2SadF6o3kn
         Nkn0ARK8Sz3k7nYDf+C3V3CGT8VTl+IF3XBtiohKEA/ub+nFujpvmdie4KipHWJ0aZOn
         JkZi48aN5+um0QRGtaWeEKahRMgRCoX7Vaz+lMQCS5Vf42D6dKhcANz9XVNZPIumeitc
         uQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550630; x=1724155430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpDDmqOnJijcRyZ/zRVr0dfh/EUV8mM0nwD7hiV/Er4=;
        b=Hi0wWKoYUwLkL1vy21DaZ5nGFbhKVS7wNPhg/U+nLI5rRYPjja2QTklI/Uq02J5F38
         u3SIfKSb1YlqvFktyhONifMDgzmzC9DDXAE5NUlGQRItsyOTJg0jXIhhR+G2B1K8FxW7
         Wsw+rUlo0bGoCo6Qmbk0ZWMl9b50fpUWHX0i2UFk0DRoXRUMzKlmWa41aTcmNWpt/1+u
         2Azt7NCcJ/q+T9y5jH1EEhJfEYXWt3WoDDhjYe33fZJjQbP9x93E2BWImOHBWPC7Mmjz
         vpz/SfhNHbGRJon4bEv0El41BeSS4kRsl5HY2lxnnsBidAIDW11Kqt6cvB5aGkP8GPbm
         Qh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOwEiNhwxFk6X9MkWJ4dAKGTLw/i92dKVga3nPmQnK0nK2A8/xukAwEuD781531/6mJtfF8WzfFwAF2moMWLyEtCteM85CG5tSP3s9iHu0DBp6AK4fhlwkOh3TOjYRZ3esjqsIqXum
X-Gm-Message-State: AOJu0YyevFJofaxCJ1m8xnRfGBBML2LeW8bmGuU/CzGyhUncbsHjSCCi
	6/lZZ709T9mSWmop/OKKi1NrUQ7sLH1HQvTqENKLb5vyaM76F39o
X-Google-Smtp-Source: AGHT+IG/p4KHdjtbRHl8jrRDtZpiTzA00oY1agex2KO6TAfMpoEbk5fNk2V++Y8FeIZ5s4O/KzF07g==
X-Received: by 2002:a05:6214:5f0b:b0:6b7:980b:e0ac with SMTP id 6a1803df08f44-6bf4f7e2315mr29329476d6.32.1723550630417;
        Tue, 13 Aug 2024 05:03:50 -0700 (PDT)
Received: from localhost (fwdproxy-ash-011.fbsv.net. [2a03:2880:20ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c81cd0sm33464656d6.53.2024.08.13.05.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:03:50 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v3 6/6] mm: add sysfs entry to disable splitting underutilized THPs
Date: Tue, 13 Aug 2024 13:02:49 +0100
Message-ID: <20240813120328.1275952-7-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813120328.1275952-1-usamaarif642@gmail.com>
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If disabled, THPs faulted in or collapsed will not be added to
_deferred_list, and therefore won't be considered for splitting under
memory pressure if underutilized.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/huge_memory.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6b32b2d4ab1e..b4d72479330d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -74,6 +74,7 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
 					  struct shrink_control *sc);
 static unsigned long deferred_split_scan(struct shrinker *shrink,
 					 struct shrink_control *sc);
+static bool split_underutilized_thp = true;
 
 static atomic_t huge_zero_refcount;
 struct folio *huge_zero_folio __read_mostly;
@@ -439,6 +440,27 @@ static ssize_t hpage_pmd_size_show(struct kobject *kobj,
 static struct kobj_attribute hpage_pmd_size_attr =
 	__ATTR_RO(hpage_pmd_size);
 
+static ssize_t split_underutilized_thp_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", split_underutilized_thp);
+}
+
+static ssize_t split_underutilized_thp_store(struct kobject *kobj,
+			     struct kobj_attribute *attr,
+			     const char *buf, size_t count)
+{
+	int err = kstrtobool(buf, &split_underutilized_thp);
+
+	if (err < 0)
+		return err;
+
+	return count;
+}
+
+static struct kobj_attribute split_underutilized_thp_attr = __ATTR(
+	thp_low_util_shrinker, 0644, split_underutilized_thp_show, split_underutilized_thp_store);
+
 static struct attribute *hugepage_attr[] = {
 	&enabled_attr.attr,
 	&defrag_attr.attr,
@@ -447,6 +469,7 @@ static struct attribute *hugepage_attr[] = {
 #ifdef CONFIG_SHMEM
 	&shmem_enabled_attr.attr,
 #endif
+	&split_underutilized_thp_attr.attr,
 	NULL,
 };
 
@@ -3475,6 +3498,9 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 	if (folio_order(folio) <= 1)
 		return;
 
+	if (!partially_mapped && !split_underutilized_thp)
+		return;
+
 	/*
 	 * The try_to_unmap() in page reclaim path might reach here too,
 	 * this may cause a race condition to corrupt deferred split queue.
-- 
2.43.5


