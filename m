Return-Path: <linux-kernel+bounces-518389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A47A38E52
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E5F189008A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B921A5B99;
	Mon, 17 Feb 2025 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTq7zdQy"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196E81A2398;
	Mon, 17 Feb 2025 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739829320; cv=none; b=ZGEJaxQChMyXe5DcatSAonP0+O8Mdiy8T4I5eWBLlF71qe7k/AEDX+cl3rO5hABlNGIL/Y6Lnd9VKovN1iBgzO+OCpsLershbP5w9oj0/EWLYOuCdRydG3DdOANFl5mb1GuDHUmgMbkb5noJOcuPyQngB5pipjkiRFAqPomQzPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739829320; c=relaxed/simple;
	bh=Klq5PffbptHsOJVEB2b5DtQvJLo5pgHVICeP/mMF60Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C4KbRIMEl2xFM0/qGYdOjNIDShCFZx0dwZT5QXtlVjB2P36uHAe5YoF9/ZIZNQNkSVKVzBjGopG2bKtRAj3aRx+A88pvG4qXlb1+Dc/2EZpxGZUFXSqwpX1fAT0ObrtfscmlmXjPvb31EoR0IiHMj/Ru5DndrjsxCXW1Rh8hYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTq7zdQy; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7272f9d216dso93631a34.3;
        Mon, 17 Feb 2025 13:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739829318; x=1740434118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYbyfH/z3kCWKfyK+UZYlz7QdA/EN+W4bn8ufKQeJxw=;
        b=WTq7zdQylRgn3tJgmpeXRHhAACfRvR5SBsrsmuPbQ0qiK9Ah7N3SKrNjG1wIGCLuFx
         xKD6ZPZhzzWVWOehyzlFYQ24qRDw+gg9GcSbrid+imuc0XcJDL86P0jyMTJimmLArKe5
         tAs6X0WO7u+Xv5HSSgPsqyImJ1N4lA82/r2iXQjJ9w7ToZ/UovWFs4ciC7tP8RTxrry3
         jroYAX8uSgd7boMlCJPAhSqSKwNsyY1/ClHS2ll4ZX4UuA5n06a1T5TiUHQagHgXZV+6
         BovqhMnixiw90gNq/HjZsZCy+QWSril6C5o0OnOKlGlco4Vw72qIXmBVWF9Ag0j1Bzib
         kw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739829318; x=1740434118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYbyfH/z3kCWKfyK+UZYlz7QdA/EN+W4bn8ufKQeJxw=;
        b=QUC5DWbUqwYtpayBxpjleA5qGvv0XxIkRJkY9U4jQc6jJy0GBcx+oQqQuaZB8frJLZ
         hglAjwmm93vHAFwwI4YlpI60tL3UbkqbfB+/DyCV/S0tbmvUDKy6vJhCOHOj2DxId0PC
         etAR9MuQCQWcCytDsGaIwSDTIT9DHEbt1ReFn9fvT8vXBwaASA33x8hXUZe9/NfccF5E
         nNjLl0JddnokBm4Tdlu/+CqbvmJ8yyfb4TyEF3nKVLghKn0aBxBOlTAh7k6itEZGu6Qa
         B7kJb2sg1wqAM6YSnhzibRLBwLOfh4umrPlowuuL/VndwIVM1xCw9hMJBXNr5FHf2vn9
         bziw==
X-Forwarded-Encrypted: i=1; AJvYcCXEs5FeaBeUa4gD/+1TcpB4LzPqFCpz2fsXNYkK07Lc9BchnRY3ppSLcojf0kzJ+xrky7wFTE1Pn6fTdTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+0efVQsG1s48fGwKrQfd4ybhJie7q7hK8xc4hvPfI+it6/lU
	sD4MK/cR4FsDbgMWBeo7JbMhOpmFO3ECOuMxM1EbvBHsEqSbsr43dUgyEJ+D
X-Gm-Gg: ASbGncuXAART/OF2dO1mGE43qIOaxE3YU2o6qiFXD1eXKxl3IMP9EafYvgcITvPYQ+1
	Q5lvBxhMoGew2Wn2Zw1AcoB7MmOxRzF9B6ZOcJSgTPfNLTrX+mCYqzDQWFTqiCBv/NgfzM51krT
	n8zPOzWTZ+GQdZyt6XJzn/j5iVUyUUz82hXiLQsm5UzUX0oLiYV9RN5Tub+lVQf1PyVgbYEjMSZ
	ZLzxfV1754fX/cUx18Cq65hcP0D6yyxL6Ye4n+koU3+OpgizA72O/pjbYkOZMJRQyoxtb/9dNGD
	U5z/
X-Google-Smtp-Source: AGHT+IE/Z8qDavaEeJ7asNwxo7RVPa/QkzcDHNrjSkiIXGWHCNus7ijcxp/G6T/9w64ZpoGE6m7fbA==
X-Received: by 2002:a05:6830:25d3:b0:727:10dd:ca2c with SMTP id 46e09a7af769-7271203f2a9mr8475106a34.10.1739829317811;
        Mon, 17 Feb 2025 13:55:17 -0800 (PST)
Received: from fedora.. ([2804:14c:64:af90::1000])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72728549a33sm518922a34.2.2025.02.17.13.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 13:55:17 -0800 (PST)
From: Marcelo Moreira <marcelomoreira1905@gmail.com>
To: linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] Docs/mm/damon: Fix spelling and grammar in monitoring_intervals_tuning_example.rst
Date: Mon, 17 Feb 2025 18:54:31 -0300
Message-ID: <20250217215512.12833-1-marcelomoreira1905@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch fixes some spelling and grammar mistakes in the documentation,
improving the readability.

- multipled  -> multiplied
- idential   -> identical
- minuts     -> minutes
- efficieny  -> efficiency

Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>
---
 .../mm/damon/monitoring_intervals_tuning_example.rst      | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/mm/damon/monitoring_intervals_tuning_example.rst b/Documentation/mm/damon/monitoring_intervals_tuning_example.rst
index 334a854efb40..7207cbed591f 100644
--- a/Documentation/mm/damon/monitoring_intervals_tuning_example.rst
+++ b/Documentation/mm/damon/monitoring_intervals_tuning_example.rst
@@ -36,7 +36,7 @@ Then, list the DAMON-found regions of different access patterns, sorted by the
 "access temperature".  "Access temperature" is a metric representing the
 access-hotness of a region.  It is calculated as a weighted sum of the access
 frequency and the age of the region.  If the access frequency is 0 %, the
-temperature is multipled by minus one.  That is, if a region is not accessed,
+temperature is multiplied by minus one.  That is, if a region is not accessed,
 it gets minus temperature and it gets lower as not accessed for longer time.
 The sorting is in temperature-ascendint order, so the region at the top of the
 list is the coldest, and the one at the bottom is the hottest one. ::
@@ -58,11 +58,11 @@ list is the coldest, and the one at the bottom is the hottest one. ::
 The list shows not seemingly hot regions, and only minimum access pattern
 diversity.  Every region has zero access frequency.  The number of region is
 10, which is the default ``min_nr_regions value``.  Size of each region is also
-nearly idential.  We can suspect this is because “adaptive regions adjustment”
+nearly identical.  We can suspect this is because “adaptive regions adjustment”
 mechanism was not well working.  As the guide suggested, we can get relative
 hotness of regions using ``age`` as the recency information.  That would be
 better than nothing, but given the fact that the longest age is only about 6
-seconds while we waited about ten minuts, it is unclear how useful this will
+seconds while we waited about ten minutes, it is unclear how useful this will
 be.
 
 The temperature ranges to total size of regions of each range histogram
@@ -190,7 +190,7 @@ for sampling and aggregation intervals, respectively). ::
 The number of regions having different access patterns has significantly
 increased.  Size of each region is also more varied. Total size of non-zero
 access frequency regions is also significantly increased. Maybe this is already
-good enough to make some meaningful memory management efficieny changes.
+good enough to make some meaningful memory management efficiency changes.
 
 800ms/16s intervals: Another bias
 =================================
-- 
2.48.1


