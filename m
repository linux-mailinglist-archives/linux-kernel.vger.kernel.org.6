Return-Path: <linux-kernel+bounces-310572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6DA967E8A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C901C21896
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64431153837;
	Mon,  2 Sep 2024 04:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ObbJEsFl"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6025C14BF9B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 04:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725252097; cv=none; b=rK6499S6N4cCEWT9+mgXh0uQC836HYY7ZGkGGe/pwjcI0MGBode+p4iK4xRg80d/3GTzLzLRqxNlVgkmB79yYF59SIcX9pv0hR+Qttoh9N206/jJkxMW8zutaBeFZ83Ga+7dlueO5oOK9YYBERBfnAYOnlNLj1Rmwprbk2qiFqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725252097; c=relaxed/simple;
	bh=knnBZu7kPS2XiZHCOoomuagEtSw2A+8o8O+N0AJpu1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nghw0gSuzGzfRiPpIh41iDGA6WTp+IfpaT1EqFAT3lEFSYPm4QDCf7z9CzESBJQ7UWoUmU9zn9cayzFzJ1YV6H33G7XfJXtaejd8PFkvfR7Ys59Fmi/ER5rWy1ojmljMBwDIUNyEyw377lQTwNMLcyxvdLWO/ID2cCNpGpsxlZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ObbJEsFl; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so6351082276.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 21:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725252094; x=1725856894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLpU39ux3x2TTO/xeONsOF6qZRhVUZNcpjltFBicrmM=;
        b=ObbJEsFlLJj8q/uKPICo68h7XtFK06WRs42lj1wo+168rApzvRYv51HHAlJitWtqhe
         /uNRbCQ8Zmt/9Igg0ogICyUA3lZO9IfvX3pUV25vgVQz+ys9AdH++a+hDTIkc6e1tqHt
         fdybiZ7BtsHMX4zid+OMrBrn90A1oPdVW3rHcZvmkOTSkO/tI7piYo0ajYi78Al6IAmJ
         qaG8Rwy/6Ebw8cZtQyzfQPIAW2G++DWwCYOn5Kbh9ugsFMlCLN1O0xkdSKpS/DTZQ0H5
         1Zmd/csCJnyNXSm8miBpMWZa+P6PIF4PupFNY1iySiwyLlidYQfNw5OZbl/ZqaiqSyp8
         BXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725252094; x=1725856894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLpU39ux3x2TTO/xeONsOF6qZRhVUZNcpjltFBicrmM=;
        b=RFBWsGFpqkHJLGEuURJIKPJ0b+EblKWfL98vpNzK43fP1Dopizf0a7G8qX/PSv1AVc
         DAouFDkPtGd4ObESxRNm35nmDR88rdhSLuOAElRkZDN9N0Q4i8m3u2QZzWBBaz+i7aXI
         Di7prukNgUdJqB0kkUJ3FxEJC2tSeDtAo/GOF9h4UWWSWuyBG/lS8iEHtatutZEKgboP
         1cvbRmvHsXkQPLRvLxwYZ+8rKjbnAyOtmRUR5XFUCDh8x6DwO3JN9rXodJY8SpUakffU
         YTiIV5o/iOnt4vZWC9FJiG60ku5GNSJVsbB+vFmI8GTSu5NznKVU2Vs6GVa4nl3qG3UM
         GCGA==
X-Forwarded-Encrypted: i=1; AJvYcCUiyJPOUPEnOOW1eRvIfTesPLTcnxvBpS31nZLrxYnT9nj4APpRL9fAamMbr88xNM5hCsv1KVCCH7EqyVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6OQvif666rW4TpvdfVmQML85FGSBhXlrAFZNRJoB2wWqTuU97
	zaLYxI3MYas182artmDV4VF7YPHxFRLXPB/2yVLwFtLAN43A7i9H9hPPb88E4Wp1sAXUj5o7TKp
	ihA==
X-Google-Smtp-Source: AGHT+IE+2G0xxDfv2kbdFSiqwhGjdz1DeNRKuCcVpqvSyerK6sADotCLCA7OoS3t5ommCEFjIJVLeySgq3I=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:7343:ecd2:aed:5b8f])
 (user=surenb job=sendgmr) by 2002:a25:83c4:0:b0:e03:3683:e67f with SMTP id
 3f1490d57ef6-e1a79fed1aamr15821276.5.1725252094100; Sun, 01 Sep 2024 21:41:34
 -0700 (PDT)
Date: Sun,  1 Sep 2024 21:41:23 -0700
In-Reply-To: <20240902044128.664075-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240902044128.664075-1-surenb@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240902044128.664075-2-surenb@google.com>
Subject: [PATCH v2 1/6] maple_tree: add mas_for_each_rev() helper
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com, surenb@google.com, 
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset="UTF-8"

Add mas_for_each_rev() function to iterate maple tree nodes in reverse
order.

Suggested-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/maple_tree.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 8e1504a81cd2..45e633806da2 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -592,6 +592,20 @@ static __always_inline void mas_reset(struct ma_state *mas)
 #define mas_for_each(__mas, __entry, __max) \
 	while (((__entry) = mas_find((__mas), (__max))) != NULL)
 
+/**
+ * mas_for_each_rev() - Iterate over a range of the maple tree in reverse order.
+ * @__mas: Maple Tree operation state (maple_state)
+ * @__entry: Entry retrieved from the tree
+ * @__min: minimum index to retrieve from the tree
+ *
+ * When returned, mas->index and mas->last will hold the entire range for the
+ * entry.
+ *
+ * Note: may return the zero entry.
+ */
+#define mas_for_each_rev(__mas, __entry, __min) \
+	while (((__entry) = mas_find_rev((__mas), (__min))) != NULL)
+
 #ifdef CONFIG_DEBUG_MAPLE_TREE
 enum mt_dump_format {
 	mt_dump_dec,
-- 
2.46.0.469.g59c65b2a67-goog


