Return-Path: <linux-kernel+bounces-308514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968AD965DF4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB361C23171
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B111F18A959;
	Fri, 30 Aug 2024 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqQVoxM1"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE77186618;
	Fri, 30 Aug 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012293; cv=none; b=dqA5eaHBoyVXBdIuWFC5N2gEFztBFhvgQ/7hvKv2LYU4w9FHot37sfs3sDa27mg/0edIUrbjCJ4UE/EaoijSfaPVdx+mjrxijxgwzvIt+bRwEKvNFtqgmpJpbpITIgsgNIoGZKUf2T7CRS4ks5uZjNXd5xo7uk3PMrgKUb6XHJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012293; c=relaxed/simple;
	bh=I4j6m2ue+2oFeLC3LpeXOA7UHaZhu5FNAIPV7H15v4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpCZIsnYXi7tPM3z+pV6eGfNvpKo8boim8VjvzJmvst6kg+uRUIi/mPjEVX/MmYouauh4EXX04RkKKSmpvuNIyEocnTrhw08LlsSKwSnmamiUW44WDFuTs+KAysCwKIJnuagGI0/wkqoLVyY6VsHwPZLsU26QMp+Jp9uyaxqyk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqQVoxM1; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-709340f1cb1so595982a34.3;
        Fri, 30 Aug 2024 03:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725012291; x=1725617091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9HM33kRGSHCEaJuDM+XKG3QBl4KNlRa8+XSdjB42Js=;
        b=HqQVoxM1iGnK8tB1zhxSB4cpQUocIPw2Q8c8qOZxCRsw2ZcZSBYVXe8RwxvKtpKCWp
         7I/VOGU5UFs2DJfyIVF8EmYuYYiDFLp0dnErSYi3cwXipyGGadf2AoXKi8JaaGiAOVkL
         rxOzKZvETbU4xWHOus27H6og33c/umyKo5WrliMLJ8DHlntEuV8tlLER4PAVNsdaf+aX
         bCY1JNaQRxIgN7r5xUaM/mSffnOrzxkKyPpHn6ihaS+CQ3BzWlk97GazS92E9iFSNGXF
         V4JIfCwVgPt3nS6ZBjAF9OJvsELHsPARkf5f582i5g6tMoTWemGNbxEbkYhWZB1AKAyM
         kNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012291; x=1725617091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9HM33kRGSHCEaJuDM+XKG3QBl4KNlRa8+XSdjB42Js=;
        b=tUpDltv41EHl0Cje/m+Mfkghfma649wltoBIIL5EnDwQA/xVuV1eSgavJpvUE+rPrF
         ZXoxDkskWgPcPrNxT+OeHq7N+/PEX44m2QAGPMIOw6LQkCqQIs7MHy6AbrQelvObY5Oy
         fH7vQwu2Wukky8gfz1M3Hml2e0iOqoQMjTV4WDj6m4UsJnHSWUQAQrfQiRwZV3IygTN0
         eQV0zGjJC6AxSrnL6OFq+zS8hzC8q5J8sPeU5m9hLrZCh4EhPcy0rqEP7/goylzSsWLK
         DVtMo0DOuF7FU5Nxyk0ricLuGhehCsv/tCAdTb7mHYgTqac9enpRi17SMzf+qTtQfJWH
         QhhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhC7RmxpclTDOHZMhqd66oQ+szGv3vRlnB3ZC4JVKHdrNsyR4af3uPL4x7nFJ/cgz7RPIiWD0A8o7TkX3E@vger.kernel.org, AJvYcCX1hT1l234bvXppNc3W+FpfAp3+j2V8MgzPndh7JmSKjjGuf9N6ru1OpqZsiMsy3ZQbTB80tnvtt34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy9CrqMVwYLAZ55iiZOurRgsI8DWHXjp2DS8Ac7kTi3L6mvCOs
	0op6vzFVAE69HvxFN6nGdry1/m/XAcefmTv4dRaztQkOjyuYSPnU
X-Google-Smtp-Source: AGHT+IFnFxgDYehxBOjERbSY3E6IQRb/Eo5/olia1KlgsAQYx6fH7Gfn02t5h6FRR0dUftMkedAUyg==
X-Received: by 2002:a05:6830:2682:b0:704:45b7:8ffc with SMTP id 46e09a7af769-70f5c49e963mr5658027a34.32.1725012290746;
        Fri, 30 Aug 2024 03:04:50 -0700 (PDT)
Received: from localhost (fwdproxy-ash-013.fbsv.net. [2a03:2880:20ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c0020esm13219306d6.50.2024.08.30.03.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:04:49 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	npache@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	ryncsn@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v5 6/6] mm: add sysfs entry to disable splitting underused THPs
Date: Fri, 30 Aug 2024 11:03:40 +0100
Message-ID: <20240830100438.3623486-7-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240830100438.3623486-1-usamaarif642@gmail.com>
References: <20240830100438.3623486-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If disabled, THPs faulted in or collapsed will not be added to
_deferred_list, and therefore won't be considered for splitting under
memory pressure if underused.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 10 +++++++++
 mm/huge_memory.c                           | 26 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index aca0cff852b8..cfdd16a52e39 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -202,6 +202,16 @@ PMD-mappable transparent hugepage::
 
 	cat /sys/kernel/mm/transparent_hugepage/hpage_pmd_size
 
+All THPs at fault and collapse time will be added to _deferred_list,
+and will therefore be split under memory presure if they are considered
+"underused". A THP is underused if the number of zero-filled pages in
+the THP is above max_ptes_none (see below). It is possible to disable
+this behaviour by writing 0 to shrink_underused, and enable it by writing
+1 to it::
+
+	echo 0 > /sys/kernel/mm/transparent_hugepage/shrink_underused
+	echo 1 > /sys/kernel/mm/transparent_hugepage/shrink_underused
+
 khugepaged will be automatically started when PMD-sized THP is enabled
 (either of the per-size anon control or the top-level control are set
 to "always" or "madvise"), and it'll be automatically shutdown when
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a97aeffc55d6..0993dfe9ae94 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -74,6 +74,7 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
 					  struct shrink_control *sc);
 static unsigned long deferred_split_scan(struct shrinker *shrink,
 					 struct shrink_control *sc);
+static bool split_underused_thp = true;
 
 static atomic_t huge_zero_refcount;
 struct folio *huge_zero_folio __read_mostly;
@@ -440,6 +441,27 @@ static ssize_t hpage_pmd_size_show(struct kobject *kobj,
 static struct kobj_attribute hpage_pmd_size_attr =
 	__ATTR_RO(hpage_pmd_size);
 
+static ssize_t split_underused_thp_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", split_underused_thp);
+}
+
+static ssize_t split_underused_thp_store(struct kobject *kobj,
+			     struct kobj_attribute *attr,
+			     const char *buf, size_t count)
+{
+	int err = kstrtobool(buf, &split_underused_thp);
+
+	if (err < 0)
+		return err;
+
+	return count;
+}
+
+static struct kobj_attribute split_underused_thp_attr = __ATTR(
+	shrink_underused, 0644, split_underused_thp_show, split_underused_thp_store);
+
 static struct attribute *hugepage_attr[] = {
 	&enabled_attr.attr,
 	&defrag_attr.attr,
@@ -448,6 +470,7 @@ static struct attribute *hugepage_attr[] = {
 #ifdef CONFIG_SHMEM
 	&shmem_enabled_attr.attr,
 #endif
+	&split_underused_thp_attr.attr,
 	NULL,
 };
 
@@ -3601,6 +3624,9 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 	if (folio_order(folio) <= 1)
 		return;
 
+	if (!partially_mapped && !split_underused_thp)
+		return;
+
 	/*
 	 * The try_to_unmap() in page reclaim path might reach here too,
 	 * this may cause a race condition to corrupt deferred split queue.
-- 
2.43.5


