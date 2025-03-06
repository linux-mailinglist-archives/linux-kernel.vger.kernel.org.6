Return-Path: <linux-kernel+bounces-548681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C98ADA547EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC623B0546
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5811C201034;
	Thu,  6 Mar 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IostFo92"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B46E204F70
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257424; cv=none; b=tb6lROibUfMQpqYtBBcVq03e7QtPytQ3mt2KiL3TtfnnEwL/Pgq7A9LxvU/5fXAsaQQy455mylkb2rjCac5myr/ZC7Wm5oesxlxCFhiJ5YNNcMwKz8dX5pIgKDHNuJe4Kv5QCN/lpUGws/KX/7nJ5QtZ4a4SD5VoJV1MMrfKc5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257424; c=relaxed/simple;
	bh=F/eABFsB8A16Jkk5cvabwi1EyYQr2HiW5XDGohamGfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QxbvkmWffVbmn9xCosfHXIYCXquLR3wfCgjEvDr8EG9ubiAKrocMeF/YOIYZqEBS2Sb5zDlv5mg5wzaToijMPhZpGAeFxWLdUjSAaIldzNfQhlQsHrOzuinpTJHqBAbQFTGH+R4q+bxFjGilZ4nsTN2qF+K/bIaFTbIvJoN6T9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IostFo92; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22374f56453so10257075ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741257421; x=1741862221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuWLJSv62skpc1Wwn8nY/tOTtWz04AGhvYSgH5RZe0Y=;
        b=IostFo92YugMGliC31U+f8r0nK+tCIy1V5HlK6+Cz4sevtUilFQb5yHFFcNxf7W6vx
         pvRwLWMaY13QFIKKqR0Rz2NWNUJMoIHRUOURzgd3+Wzr4hK7/qMHc4u8s0MJg8Zrz0mh
         jvKB7x8tjeN9WwlBjnrJFFKX5KGlHxLPeeT9UgyLyYSKXXVZa+P4fBsTqybFfk1tgPYQ
         TvPWDEFAVhPux998D/V2FlBfx5joRF/Cp0CnZUanGxNcPsbFWMM7JBqsXjuDZCUok5Bg
         h0Hqgcbhxl/+KxQoAmy5WRAoWCI+jMVsQ4ASW/2hjp6buZnVcZcMCca7CtOmoeJPsuSP
         Zfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257421; x=1741862221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuWLJSv62skpc1Wwn8nY/tOTtWz04AGhvYSgH5RZe0Y=;
        b=iToIoNWhIx3YiwDrFkLnwf+rTaqofS591eFQDw576fPspK3+YeDIwHi3oHC86h7zKM
         GdzF0uLyNFh4joTDgAKLgRNsJXRsjeHHvNDqVY7sxX6mGZ7CNt7+a3nA2nPn9Nqt1xL3
         f/JVZ9bmapVPwAqgks9LiqD2TE2un+RmEqiTbS4Tx2E7Pzs/tAEMPpIhf+2u3S0JSngB
         SFWnZwEWNSstOq/FvBZbcuv96bjqig1gznB2784BvXbmzSkaf9iyfvMXGfG3gToyQ76h
         52DKsVIOX78R++tElzR7wGZ/bYQ5qrRDhZ89uj34q4Hg4ZJzBsavnX3AibCBX1LggkQP
         TB9w==
X-Forwarded-Encrypted: i=1; AJvYcCXba5KpK3xDs45wD+bA/FLDf0s4wYmk00BUJBZILnOPFj9++oOB1IDyDhEOe2myLZvGVyc+Dpr/iuJSyyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoE8RnjpMP1HD9vT8CDJp9sk1HUe22UJRicFCRMrdjKitzfdpH
	Mx7U8TwZNfMW2jDWBWL7VufdwlwLsGS3tz+m1XTw8lPDF9K9VShrUqGkTh+cbow=
X-Gm-Gg: ASbGncvnqit6jqETyN2MlgNrok0tELu2IB8vlcv50SoCJQX6YgXiUFZvc/KplgKeIfK
	ujMuJTp7IOa8uiCPMwUyR/ksdVmwlh9UnN47EefwZxREro5z01obPg2r3doTGuaApotYxi+f8FL
	hgadb2VFc+G6ZcPOLS2HpeU+SypIxMy0Vcpbk7Jh8xAvdV2oKIf+3XaL8NgZiqe2G8jzHZCXPrL
	toJT9ue34ywhe2iG8rsmPJtm5ayKnC8UgRpKHm6smH/l6FdgbKa1UFW8OdihASp4PMhGc0etR7T
	9QD0yzrR1mlIQgnf4iHx+PZZrdcJKpCXjHq9Xn6TsNB4bQ==
X-Google-Smtp-Source: AGHT+IFPgxdOiU5BXTcoMAiIT5XYpl/2NZ43OC6SH6hvYbbhS9ypdpsFuLAL4GjK1dcm2DcaalTU5g==
X-Received: by 2002:a17:902:cec3:b0:224:76f:9e44 with SMTP id d9443c01a7336-224076fa042mr48401155ad.8.1741257421558;
        Thu, 06 Mar 2025 02:37:01 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff94fsm2797167a91.36.2025.03.06.02.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:37:01 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <yury.norov@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpumask: Fix kernel-doc formatting errors in cpumask.h
Date: Thu,  6 Mar 2025 16:06:50 +0530
Message-Id: <1489a042f329b1c1238756c68fd880e2966f242d.1741257214.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1741257214.git.viresh.kumar@linaro.org>
References: <cover.1741257214.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes various kernel-doc formatting errors in cpumask.h:

- WARNING: Inline literal start-string without end-string.
- ERROR: Unexpected indentation.
- ERROR: Unknown target name: "gfp".

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/cpumask.h | 65 +++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 36a890d0dd57..73ba808c559f 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -20,7 +20,7 @@
  * cpumask_pr_args - printf args to output a cpumask
  * @maskp: cpumask to be printed
  *
- * Can be used to provide arguments for '%*pb[l]' when printing a cpumask.
+ * Can be used to provide arguments for '\%*pb[l]' when printing a cpumask.
  */
 #define cpumask_pr_args(maskp)		nr_cpu_ids, cpumask_bits(maskp)
 
@@ -166,7 +166,7 @@ static __always_inline unsigned int cpumask_first_zero(const struct cpumask *src
 }
 
 /**
- * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
+ * cpumask_first_and - return the first cpu from \*srcp1 & \*srcp2
  * @srcp1: the first input
  * @srcp2: the second input
  *
@@ -179,7 +179,7 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
 }
 
 /**
- * cpumask_first_and_and - return the first cpu from *srcp1 & *srcp2 & *srcp3
+ * cpumask_first_and_and - return the first cpu from \*srcp1 & \*srcp2 & \*srcp3
  * @srcp1: the first input
  * @srcp2: the second input
  * @srcp3: the third input
@@ -266,7 +266,7 @@ unsigned int cpumask_any_distribute(const struct cpumask *srcp);
 #endif /* NR_CPUS */
 
 /**
- * cpumask_next_and - get the next cpu in *src1p & *src2p
+ * cpumask_next_and - get the next cpu in \*src1p & \*src2p
  * @n: the cpu prior to the place to search (i.e. return will be > @n)
  * @src1p: the first cpumask pointer
  * @src2p: the second cpumask pointer
@@ -335,6 +335,9 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
  * @mask2: the second cpumask pointer
  *
  * This saves a temporary CPU mask in many places.  It is equivalent to:
+ *
+ * .. code-block:: c
+ *
  *	struct cpumask tmp;
  *	cpumask_and(&tmp, &mask1, &mask2);
  *	for_each_cpu(cpu, &tmp)
@@ -353,6 +356,9 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
  * @mask2: the second cpumask pointer
  *
  * This saves a temporary CPU mask in many places.  It is equivalent to:
+ *
+ * .. code-block:: c
+ *
  *	struct cpumask tmp;
  *	cpumask_andnot(&tmp, &mask1, &mask2);
  *	for_each_cpu(cpu, &tmp)
@@ -370,6 +376,9 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
  * @mask2: the second cpumask pointer
  *
  * This saves a temporary CPU mask in many places.  It is equivalent to:
+ *
+ * .. code-block:: c
+ *
  *	struct cpumask tmp;
  *	cpumask_or(&tmp, &mask1, &mask2);
  *	for_each_cpu(cpu, &tmp)
@@ -411,7 +420,7 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
 }
 
 /**
- * cpumask_any_and_but - pick an arbitrary cpu from *mask1 & *mask2, but not this one.
+ * cpumask_any_and_but - pick an arbitrary cpu from \*mask1 & \*mask2, but not this one.
  * @mask1: the first input cpumask
  * @mask2: the second input cpumask
  * @cpu: the cpu to ignore
@@ -545,7 +554,7 @@ static __always_inline void __cpumask_clear_cpu(int cpu, struct cpumask *dstp)
  * cpumask_assign_cpu - assign a cpu in a cpumask
  * @cpu: cpu number (< nr_cpu_ids)
  * @dstp: the cpumask pointer
- * @bool: the value to assign
+ * @value: the value to assign
  */
 static __always_inline void cpumask_assign_cpu(int cpu, struct cpumask *dstp, bool value)
 {
@@ -623,7 +632,7 @@ static __always_inline void cpumask_clear(struct cpumask *dstp)
 }
 
 /**
- * cpumask_and - *dstp = *src1p & *src2p
+ * cpumask_and - \*dstp = \*src1p & \*src2p
  * @dstp: the cpumask result
  * @src1p: the first input
  * @src2p: the second input
@@ -639,7 +648,7 @@ bool cpumask_and(struct cpumask *dstp, const struct cpumask *src1p,
 }
 
 /**
- * cpumask_or - *dstp = *src1p | *src2p
+ * cpumask_or - \*dstp = \*src1p | \*src2p
  * @dstp: the cpumask result
  * @src1p: the first input
  * @src2p: the second input
@@ -653,7 +662,7 @@ void cpumask_or(struct cpumask *dstp, const struct cpumask *src1p,
 }
 
 /**
- * cpumask_xor - *dstp = *src1p ^ *src2p
+ * cpumask_xor - \*dstp = \*src1p ^ \*src2p
  * @dstp: the cpumask result
  * @src1p: the first input
  * @src2p: the second input
@@ -667,7 +676,7 @@ void cpumask_xor(struct cpumask *dstp, const struct cpumask *src1p,
 }
 
 /**
- * cpumask_andnot - *dstp = *src1p & ~*src2p
+ * cpumask_andnot - \*dstp = \*src1p & ~\*src2p
  * @dstp: the cpumask result
  * @src1p: the first input
  * @src2p: the second input
@@ -683,7 +692,7 @@ bool cpumask_andnot(struct cpumask *dstp, const struct cpumask *src1p,
 }
 
 /**
- * cpumask_equal - *src1p == *src2p
+ * cpumask_equal - \*src1p == \*src2p
  * @src1p: the first input
  * @src2p: the second input
  *
@@ -697,7 +706,7 @@ bool cpumask_equal(const struct cpumask *src1p, const struct cpumask *src2p)
 }
 
 /**
- * cpumask_or_equal - *src1p | *src2p == *src3p
+ * cpumask_or_equal - \*src1p | \*src2p == \*src3p
  * @src1p: the first input
  * @src2p: the second input
  * @src3p: the third input
@@ -714,7 +723,7 @@ bool cpumask_or_equal(const struct cpumask *src1p, const struct cpumask *src2p,
 }
 
 /**
- * cpumask_intersects - (*src1p & *src2p) != 0
+ * cpumask_intersects - (\*src1p & \*src2p) != 0
  * @src1p: the first input
  * @src2p: the second input
  *
@@ -729,7 +738,7 @@ bool cpumask_intersects(const struct cpumask *src1p, const struct cpumask *src2p
 }
 
 /**
- * cpumask_subset - (*src1p & ~*src2p) == 0
+ * cpumask_subset - (\*src1p & ~\*src2p) == 0
  * @src1p: the first input
  * @src2p: the second input
  *
@@ -743,7 +752,7 @@ bool cpumask_subset(const struct cpumask *src1p, const struct cpumask *src2p)
 }
 
 /**
- * cpumask_empty - *srcp == 0
+ * cpumask_empty - \*srcp == 0
  * @srcp: the cpumask to that all cpus < nr_cpu_ids are clear.
  *
  * Return: true if srcp is empty (has no bits set), else false
@@ -754,7 +763,7 @@ static __always_inline bool cpumask_empty(const struct cpumask *srcp)
 }
 
 /**
- * cpumask_full - *srcp == 0xFFFFFFFF...
+ * cpumask_full - \*srcp == 0xFFFFFFFF...
  * @srcp: the cpumask to that all cpus < nr_cpu_ids are set.
  *
  * Return: true if srcp is full (has all bits set), else false
@@ -765,10 +774,10 @@ static __always_inline bool cpumask_full(const struct cpumask *srcp)
 }
 
 /**
- * cpumask_weight - Count of bits in *srcp
+ * cpumask_weight - Count of bits in \*srcp
  * @srcp: the cpumask to count bits (< nr_cpu_ids) in.
  *
- * Return: count of bits set in *srcp
+ * Return: count of bits set in \*srcp
  */
 static __always_inline unsigned int cpumask_weight(const struct cpumask *srcp)
 {
@@ -776,11 +785,11 @@ static __always_inline unsigned int cpumask_weight(const struct cpumask *srcp)
 }
 
 /**
- * cpumask_weight_and - Count of bits in (*srcp1 & *srcp2)
+ * cpumask_weight_and - Count of bits in (\*srcp1 & \*srcp2)
  * @srcp1: the cpumask to count bits (< nr_cpu_ids) in.
  * @srcp2: the cpumask to count bits (< nr_cpu_ids) in.
  *
- * Return: count of bits set in both *srcp1 and *srcp2
+ * Return: count of bits set in both \*srcp1 and \*srcp2
  */
 static __always_inline
 unsigned int cpumask_weight_and(const struct cpumask *srcp1, const struct cpumask *srcp2)
@@ -789,11 +798,11 @@ unsigned int cpumask_weight_and(const struct cpumask *srcp1, const struct cpumas
 }
 
 /**
- * cpumask_weight_andnot - Count of bits in (*srcp1 & ~*srcp2)
+ * cpumask_weight_andnot - Count of bits in (\*srcp1 & ~\*srcp2)
  * @srcp1: the cpumask to count bits (< nr_cpu_ids) in.
  * @srcp2: the cpumask to count bits (< nr_cpu_ids) in.
  *
- * Return: count of bits set in both *srcp1 and *srcp2
+ * Return: count of bits set in both \*srcp1 and \*srcp2
  */
 static __always_inline
 unsigned int cpumask_weight_andnot(const struct cpumask *srcp1,
@@ -803,7 +812,7 @@ unsigned int cpumask_weight_andnot(const struct cpumask *srcp1,
 }
 
 /**
- * cpumask_shift_right - *dstp = *srcp >> n
+ * cpumask_shift_right - \*dstp = \*srcp >> n
  * @dstp: the cpumask result
  * @srcp: the input to shift
  * @n: the number of bits to shift by
@@ -816,7 +825,7 @@ void cpumask_shift_right(struct cpumask *dstp, const struct cpumask *srcp, int n
 }
 
 /**
- * cpumask_shift_left - *dstp = *srcp << n
+ * cpumask_shift_left - \*dstp = \*srcp << n
  * @dstp: the cpumask result
  * @srcp: the input to shift
  * @n: the number of bits to shift by
@@ -829,7 +838,7 @@ void cpumask_shift_left(struct cpumask *dstp, const struct cpumask *srcp, int n)
 }
 
 /**
- * cpumask_copy - *dstp = *srcp
+ * cpumask_copy - \*dstp = \*srcp
  * @dstp: the result
  * @srcp: the input cpumask
  */
@@ -840,7 +849,7 @@ void cpumask_copy(struct cpumask *dstp, const struct cpumask *srcp)
 }
 
 /**
- * cpumask_any - pick an arbitrary cpu from *srcp
+ * cpumask_any - pick an arbitrary cpu from \*srcp
  * @srcp: the input cpumask
  *
  * Return: >= nr_cpu_ids if no cpus set.
@@ -848,7 +857,7 @@ void cpumask_copy(struct cpumask *dstp, const struct cpumask *srcp)
 #define cpumask_any(srcp) cpumask_first(srcp)
 
 /**
- * cpumask_any_and - pick an arbitrary cpu from *mask1 & *mask2
+ * cpumask_any_and - pick an arbitrary cpu from \*mask1 & \*mask2
  * @mask1: the first input cpumask
  * @mask2: the second input cpumask
  *
@@ -941,7 +950,7 @@ bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
 /**
  * alloc_cpumask_var - allocate a struct cpumask
  * @mask: pointer to cpumask_var_t where the cpumask is returned
- * @flags: GFP_ flags
+ * @flags: GFP\_ flags
  *
  * Only defined when CONFIG_CPUMASK_OFFSTACK=y, otherwise is
  * a nop returning a constant 1 (in <linux/cpumask.h>).
-- 
2.31.1.272.g89b43f80a514


