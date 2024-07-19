Return-Path: <linux-kernel+bounces-256876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEAF9371A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B3E1F21C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50258C07;
	Fri, 19 Jul 2024 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hyCQ+qo0"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8083C39
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350302; cv=none; b=m4S9m77RGMJZxj35AmFnyc7/vx6sQDMn0mMMKdYbLIDkm8eNvcVw1/bNwIJ7qqarHu1re7+a+kVOuEV9zHxoPtnyzI2PHsNTKPMk664xWc6r7kcX4bzlagBZ+w17mn/Vrez43yJbG30Rf+7x6oweCKrPeVcTzM45HkiFR28XLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350302; c=relaxed/simple;
	bh=qiZox51DGBS2qMiOoTjlhNjpZ4ULnupvB7GAExfwAAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xf9uXNuiEiCKBBiKtwKpdImkheXIG7/JhDflxkgOFDlyrhTBaVxC+iEbjVXHfQ5g7QGF3kzvtwuJEoUVImbVpTc2G85LScBMPokzZ9m/+ctF52i72KJAFuePgxdgFqA7782hb+EdgIOUN6VfS1Y7QD0XX3oL8E442o4aVerZDEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hyCQ+qo0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cb682fb0cdso661310a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721350300; x=1721955100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+il5TBCbKPADDYuyA31kaFvQuyqKF3Hw67HCUliJLk=;
        b=hyCQ+qo0v70b3hZeEoDEW9ul8SX42ENykw6NdS1gkbf04lmMSFnWpg1ToyjZ5PHXPK
         PvtYohP6hIkNU2l/X1VyhEjEJPaBkRiNf6M2YwT6GQPQX0tLRKiMGYYJ3bC0GP5LTCg+
         PQbtzrC2zlwnPzuFeclHVSR/1AJCA7C37d0cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721350300; x=1721955100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+il5TBCbKPADDYuyA31kaFvQuyqKF3Hw67HCUliJLk=;
        b=uWfRvst+JsZJZgTYSRUgolgiSqImLxQh7XmytsIw67azRIAod+mn75FIP2XVCnR0Lm
         wrVm1JryHoLJXG9l1GrHK3X8WOV6oHHA/7CP9Jr1/FdPsFuLdQidsp4+dWElYim6ua0g
         BWCLf3hdahx2Qa9npZxg4j7XdakTrCyf383L7wYe+AqC40L4T5pdsUDvusB/we4/haSa
         4JBVy+1Nadh4jIvT9D0fmaqpN2icxmqxF/1eHbGQtSKnA1wVVOZH1W/3YgFsA8ORhXf1
         Du3OFZJftC6LAPJLksMnAy2WhqqyYRhnj3NYFqGoo9Dri1amQchIeHma2Hpgn/pHdhUo
         kYeA==
X-Gm-Message-State: AOJu0YykPbp5l1Q6+pRkLzTkpKHQ0ILrPme8JOwzO2OOmjz2ST6Fpe7k
	MUg1FZjzDNWKLA/rzjysHjfc1x7cNq3V+sqYvu8zLC/z9sM2Hq3ndT5FARPULw==
X-Google-Smtp-Source: AGHT+IFN2viMYNu3ga063nvQxfoJJltCNTXu0gxArU22Q4+5wrgtOa9pod59jNBJ+wyjlm9V//fY3Q==
X-Received: by 2002:a17:90a:fa03:b0:2c9:7e6e:3578 with SMTP id 98e67ed59e1d1-2cb52431900mr4919172a91.7.1721350299799;
        Thu, 18 Jul 2024 17:51:39 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:35aa:f87d:7549:3938])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2cb77504fadsm1393633a91.45.2024.07.18.17.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 17:51:39 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	llvm@lists.linux.dev,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Brian Norris <briannorris@chromium.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v3 4/4] nodemask: Switch from inline to __always_inline
Date: Thu, 18 Jul 2024 17:50:40 -0700
Message-ID: <20240719005127.2449328-4-briannorris@chromium.org>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
In-Reply-To: <20240719005127.2449328-1-briannorris@chromium.org>
References: <20240719005127.2449328-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov <yury.norov@gmail.com>

'inline' keyword is only a recommendation for compiler. If it decides to
not inline nodemask functions, the whole small_const_nbits() machinery
doesn't work.

This is how a standard GCC 11.3.0 does for my x86_64 build now. This patch
replaces 'inline' directive with unconditional '__always_inline' to make
sure that there's always a chance for compile-time optimization. It doesn't
change size of kernel image, according to bloat-o-meter.

[[ Brian: split out from:
      Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
      https://lore.kernel.org/all/20221027043810.350460-2-yury.norov@gmail.com/
   But rewritten, as there were too many conflicts. ]]

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Co-developed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Kees Cook <kees@kernel.org>
---

Changes in v3:
 - newly split out in v3

 include/linux/nodemask.h | 86 ++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index b61438313a73..9fd7a0ce9c1a 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -107,11 +107,11 @@ extern nodemask_t _unused_nodemask_arg_;
  */
 #define nodemask_pr_args(maskp)	__nodemask_pr_numnodes(maskp), \
 				__nodemask_pr_bits(maskp)
-static inline unsigned int __nodemask_pr_numnodes(const nodemask_t *m)
+static __always_inline unsigned int __nodemask_pr_numnodes(const nodemask_t *m)
 {
 	return m ? MAX_NUMNODES : 0;
 }
-static inline const unsigned long *__nodemask_pr_bits(const nodemask_t *m)
+static __always_inline const unsigned long *__nodemask_pr_bits(const nodemask_t *m)
 {
 	return m ? m->bits : NULL;
 }
@@ -132,19 +132,19 @@ static __always_inline void __node_set(int node, volatile nodemask_t *dstp)
 }
 
 #define node_clear(node, dst) __node_clear((node), &(dst))
-static inline void __node_clear(int node, volatile nodemask_t *dstp)
+static __always_inline void __node_clear(int node, volatile nodemask_t *dstp)
 {
 	clear_bit(node, dstp->bits);
 }
 
 #define nodes_setall(dst) __nodes_setall(&(dst), MAX_NUMNODES)
-static inline void __nodes_setall(nodemask_t *dstp, unsigned int nbits)
+static __always_inline void __nodes_setall(nodemask_t *dstp, unsigned int nbits)
 {
 	bitmap_fill(dstp->bits, nbits);
 }
 
 #define nodes_clear(dst) __nodes_clear(&(dst), MAX_NUMNODES)
-static inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
+static __always_inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
 {
 	bitmap_zero(dstp->bits, nbits);
 }
@@ -154,14 +154,14 @@ static inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
 
 #define node_test_and_set(node, nodemask) \
 			__node_test_and_set((node), &(nodemask))
-static inline bool __node_test_and_set(int node, nodemask_t *addr)
+static __always_inline bool __node_test_and_set(int node, nodemask_t *addr)
 {
 	return test_and_set_bit(node, addr->bits);
 }
 
 #define nodes_and(dst, src1, src2) \
 			__nodes_and(&(dst), &(src1), &(src2), MAX_NUMNODES)
-static inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
+static __always_inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	bitmap_and(dstp->bits, src1p->bits, src2p->bits, nbits);
@@ -169,7 +169,7 @@ static inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
 
 #define nodes_or(dst, src1, src2) \
 			__nodes_or(&(dst), &(src1), &(src2), MAX_NUMNODES)
-static inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
+static __always_inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	bitmap_or(dstp->bits, src1p->bits, src2p->bits, nbits);
@@ -177,7 +177,7 @@ static inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
 
 #define nodes_xor(dst, src1, src2) \
 			__nodes_xor(&(dst), &(src1), &(src2), MAX_NUMNODES)
-static inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
+static __always_inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	bitmap_xor(dstp->bits, src1p->bits, src2p->bits, nbits);
@@ -185,7 +185,7 @@ static inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
 
 #define nodes_andnot(dst, src1, src2) \
 			__nodes_andnot(&(dst), &(src1), &(src2), MAX_NUMNODES)
-static inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
+static __always_inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	bitmap_andnot(dstp->bits, src1p->bits, src2p->bits, nbits);
@@ -193,7 +193,7 @@ static inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
 
 #define nodes_complement(dst, src) \
 			__nodes_complement(&(dst), &(src), MAX_NUMNODES)
-static inline void __nodes_complement(nodemask_t *dstp,
+static __always_inline void __nodes_complement(nodemask_t *dstp,
 					const nodemask_t *srcp, unsigned int nbits)
 {
 	bitmap_complement(dstp->bits, srcp->bits, nbits);
@@ -201,7 +201,7 @@ static inline void __nodes_complement(nodemask_t *dstp,
 
 #define nodes_equal(src1, src2) \
 			__nodes_equal(&(src1), &(src2), MAX_NUMNODES)
-static inline bool __nodes_equal(const nodemask_t *src1p,
+static __always_inline bool __nodes_equal(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_equal(src1p->bits, src2p->bits, nbits);
@@ -209,7 +209,7 @@ static inline bool __nodes_equal(const nodemask_t *src1p,
 
 #define nodes_intersects(src1, src2) \
 			__nodes_intersects(&(src1), &(src2), MAX_NUMNODES)
-static inline bool __nodes_intersects(const nodemask_t *src1p,
+static __always_inline bool __nodes_intersects(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_intersects(src1p->bits, src2p->bits, nbits);
@@ -217,33 +217,33 @@ static inline bool __nodes_intersects(const nodemask_t *src1p,
 
 #define nodes_subset(src1, src2) \
 			__nodes_subset(&(src1), &(src2), MAX_NUMNODES)
-static inline bool __nodes_subset(const nodemask_t *src1p,
+static __always_inline bool __nodes_subset(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_subset(src1p->bits, src2p->bits, nbits);
 }
 
 #define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
-static inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
+static __always_inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_empty(srcp->bits, nbits);
 }
 
 #define nodes_full(nodemask) __nodes_full(&(nodemask), MAX_NUMNODES)
-static inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
+static __always_inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_full(srcp->bits, nbits);
 }
 
 #define nodes_weight(nodemask) __nodes_weight(&(nodemask), MAX_NUMNODES)
-static inline int __nodes_weight(const nodemask_t *srcp, unsigned int nbits)
+static __always_inline int __nodes_weight(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_weight(srcp->bits, nbits);
 }
 
 #define nodes_shift_right(dst, src, n) \
 			__nodes_shift_right(&(dst), &(src), (n), MAX_NUMNODES)
-static inline void __nodes_shift_right(nodemask_t *dstp,
+static __always_inline void __nodes_shift_right(nodemask_t *dstp,
 					const nodemask_t *srcp, int n, int nbits)
 {
 	bitmap_shift_right(dstp->bits, srcp->bits, n, nbits);
@@ -251,7 +251,7 @@ static inline void __nodes_shift_right(nodemask_t *dstp,
 
 #define nodes_shift_left(dst, src, n) \
 			__nodes_shift_left(&(dst), &(src), (n), MAX_NUMNODES)
-static inline void __nodes_shift_left(nodemask_t *dstp,
+static __always_inline void __nodes_shift_left(nodemask_t *dstp,
 					const nodemask_t *srcp, int n, int nbits)
 {
 	bitmap_shift_left(dstp->bits, srcp->bits, n, nbits);
@@ -261,13 +261,13 @@ static inline void __nodes_shift_left(nodemask_t *dstp,
           > MAX_NUMNODES, then the silly min_ts could be dropped. */
 
 #define first_node(src) __first_node(&(src))
-static inline unsigned int __first_node(const nodemask_t *srcp)
+static __always_inline unsigned int __first_node(const nodemask_t *srcp)
 {
 	return min_t(unsigned int, MAX_NUMNODES, find_first_bit(srcp->bits, MAX_NUMNODES));
 }
 
 #define next_node(n, src) __next_node((n), &(src))
-static inline unsigned int __next_node(int n, const nodemask_t *srcp)
+static __always_inline unsigned int __next_node(int n, const nodemask_t *srcp)
 {
 	return min_t(unsigned int, MAX_NUMNODES, find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
 }
@@ -277,7 +277,7 @@ static inline unsigned int __next_node(int n, const nodemask_t *srcp)
  * the first node in src if needed.  Returns MAX_NUMNODES if src is empty.
  */
 #define next_node_in(n, src) __next_node_in((n), &(src))
-static inline unsigned int __next_node_in(int node, const nodemask_t *srcp)
+static __always_inline unsigned int __next_node_in(int node, const nodemask_t *srcp)
 {
 	unsigned int ret = __next_node(node, srcp);
 
@@ -286,7 +286,7 @@ static inline unsigned int __next_node_in(int node, const nodemask_t *srcp)
 	return ret;
 }
 
-static inline void init_nodemask_of_node(nodemask_t *mask, int node)
+static __always_inline void init_nodemask_of_node(nodemask_t *mask, int node)
 {
 	nodes_clear(*mask);
 	node_set(node, *mask);
@@ -304,7 +304,7 @@ static inline void init_nodemask_of_node(nodemask_t *mask, int node)
 })
 
 #define first_unset_node(mask) __first_unset_node(&(mask))
-static inline unsigned int __first_unset_node(const nodemask_t *maskp)
+static __always_inline unsigned int __first_unset_node(const nodemask_t *maskp)
 {
 	return min_t(unsigned int, MAX_NUMNODES,
 			find_first_zero_bit(maskp->bits, MAX_NUMNODES));
@@ -338,21 +338,21 @@ static inline unsigned int __first_unset_node(const nodemask_t *maskp)
 
 #define nodemask_parse_user(ubuf, ulen, dst) \
 		__nodemask_parse_user((ubuf), (ulen), &(dst), MAX_NUMNODES)
-static inline int __nodemask_parse_user(const char __user *buf, int len,
+static __always_inline int __nodemask_parse_user(const char __user *buf, int len,
 					nodemask_t *dstp, int nbits)
 {
 	return bitmap_parse_user(buf, len, dstp->bits, nbits);
 }
 
 #define nodelist_parse(buf, dst) __nodelist_parse((buf), &(dst), MAX_NUMNODES)
-static inline int __nodelist_parse(const char *buf, nodemask_t *dstp, int nbits)
+static __always_inline int __nodelist_parse(const char *buf, nodemask_t *dstp, int nbits)
 {
 	return bitmap_parselist(buf, dstp->bits, nbits);
 }
 
 #define node_remap(oldbit, old, new) \
 		__node_remap((oldbit), &(old), &(new), MAX_NUMNODES)
-static inline int __node_remap(int oldbit,
+static __always_inline int __node_remap(int oldbit,
 		const nodemask_t *oldp, const nodemask_t *newp, int nbits)
 {
 	return bitmap_bitremap(oldbit, oldp->bits, newp->bits, nbits);
@@ -360,7 +360,7 @@ static inline int __node_remap(int oldbit,
 
 #define nodes_remap(dst, src, old, new) \
 		__nodes_remap(&(dst), &(src), &(old), &(new), MAX_NUMNODES)
-static inline void __nodes_remap(nodemask_t *dstp, const nodemask_t *srcp,
+static __always_inline void __nodes_remap(nodemask_t *dstp, const nodemask_t *srcp,
 		const nodemask_t *oldp, const nodemask_t *newp, int nbits)
 {
 	bitmap_remap(dstp->bits, srcp->bits, oldp->bits, newp->bits, nbits);
@@ -368,7 +368,7 @@ static inline void __nodes_remap(nodemask_t *dstp, const nodemask_t *srcp,
 
 #define nodes_onto(dst, orig, relmap) \
 		__nodes_onto(&(dst), &(orig), &(relmap), MAX_NUMNODES)
-static inline void __nodes_onto(nodemask_t *dstp, const nodemask_t *origp,
+static __always_inline void __nodes_onto(nodemask_t *dstp, const nodemask_t *origp,
 		const nodemask_t *relmapp, int nbits)
 {
 	bitmap_onto(dstp->bits, origp->bits, relmapp->bits, nbits);
@@ -376,7 +376,7 @@ static inline void __nodes_onto(nodemask_t *dstp, const nodemask_t *origp,
 
 #define nodes_fold(dst, orig, sz) \
 		__nodes_fold(&(dst), &(orig), sz, MAX_NUMNODES)
-static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
+static __always_inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
 		int sz, int nbits)
 {
 	bitmap_fold(dstp->bits, origp->bits, sz, nbits);
@@ -418,22 +418,22 @@ enum node_states {
 extern nodemask_t node_states[NR_NODE_STATES];
 
 #if MAX_NUMNODES > 1
-static inline int node_state(int node, enum node_states state)
+static __always_inline int node_state(int node, enum node_states state)
 {
 	return node_isset(node, node_states[state]);
 }
 
-static inline void node_set_state(int node, enum node_states state)
+static __always_inline void node_set_state(int node, enum node_states state)
 {
 	__node_set(node, &node_states[state]);
 }
 
-static inline void node_clear_state(int node, enum node_states state)
+static __always_inline void node_clear_state(int node, enum node_states state)
 {
 	__node_clear(node, &node_states[state]);
 }
 
-static inline int num_node_state(enum node_states state)
+static __always_inline int num_node_state(enum node_states state)
 {
 	return nodes_weight(node_states[state]);
 }
@@ -443,11 +443,11 @@ static inline int num_node_state(enum node_states state)
 
 #define first_online_node	first_node(node_states[N_ONLINE])
 #define first_memory_node	first_node(node_states[N_MEMORY])
-static inline unsigned int next_online_node(int nid)
+static __always_inline unsigned int next_online_node(int nid)
 {
 	return next_node(nid, node_states[N_ONLINE]);
 }
-static inline unsigned int next_memory_node(int nid)
+static __always_inline unsigned int next_memory_node(int nid)
 {
 	return next_node(nid, node_states[N_MEMORY]);
 }
@@ -455,13 +455,13 @@ static inline unsigned int next_memory_node(int nid)
 extern unsigned int nr_node_ids;
 extern unsigned int nr_online_nodes;
 
-static inline void node_set_online(int nid)
+static __always_inline void node_set_online(int nid)
 {
 	node_set_state(nid, N_ONLINE);
 	nr_online_nodes = num_node_state(N_ONLINE);
 }
 
-static inline void node_set_offline(int nid)
+static __always_inline void node_set_offline(int nid)
 {
 	node_clear_state(nid, N_ONLINE);
 	nr_online_nodes = num_node_state(N_ONLINE);
@@ -469,20 +469,20 @@ static inline void node_set_offline(int nid)
 
 #else
 
-static inline int node_state(int node, enum node_states state)
+static __always_inline int node_state(int node, enum node_states state)
 {
 	return node == 0;
 }
 
-static inline void node_set_state(int node, enum node_states state)
+static __always_inline void node_set_state(int node, enum node_states state)
 {
 }
 
-static inline void node_clear_state(int node, enum node_states state)
+static __always_inline void node_clear_state(int node, enum node_states state)
 {
 }
 
-static inline int num_node_state(enum node_states state)
+static __always_inline int num_node_state(enum node_states state)
 {
 	return 1;
 }
@@ -502,7 +502,7 @@ static inline int num_node_state(enum node_states state)
 
 #endif
 
-static inline int node_random(const nodemask_t *maskp)
+static __always_inline int node_random(const nodemask_t *maskp)
 {
 #if defined(CONFIG_NUMA) && (MAX_NUMNODES > 1)
 	int w, bit;
-- 
2.45.2.1089.g2a221341d9-goog


