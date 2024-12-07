Return-Path: <linux-kernel+bounces-435855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 059E89E7DE8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 03:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F43C16D849
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F4713FD83;
	Sat,  7 Dec 2024 01:59:34 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA8413C836
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 01:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536774; cv=none; b=kn/PWjdcZsi8yCv795kEHSSA4UCdfCh3k7eC4tGiGEeJBOusAg/4Beqv7iUYdWs8H+0cJJOMlMP2gvZ3Omjz4AsH/VaUrflzb2t+0z8KhDm5M8RemUoVEueL/S4DWaL6W3WbmT2Rh1/Zss0j0712ZRbZNsraLrri2fixCiGZqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536774; c=relaxed/simple;
	bh=MhDtD1hnbhebvcmqXJ5exN8uWQg9/37rRWH+w7S3d+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhRaivRm0ngnM7CK/SumpWSB+7gltoT7jwsOYtN47EJ4GaEKKIi1N0Pbhj+RBslUkuZFyLkmB+mbTMoiFbD4EeWYpNM5/3m7AcKu91fm5wVe3bOvFygsOp694dEoQF3F1O87vc4y7LKjuKUh/3eVAbD3aietwIjrZNxIJv1e+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxIK8BrFNnS61SAA--.5753S3;
	Sat, 07 Dec 2024 09:59:29 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMBx_uD1q1Nn3Wd5AA--.42544S12;
	Sat, 07 Dec 2024 09:59:28 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/10] drm/amd/display: Mark dc_fixpt_from_fraction() noinline
Date: Sat,  7 Dec 2024 09:59:15 +0800
Message-ID: <20241207015915.1159-11-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241207015915.1159-1-yangtiezhu@loongson.cn>
References: <20241207015915.1159-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx_uD1q1Nn3Wd5AA--.42544S12
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF17KFWruF4DAw1DtrWDGFX_yoW8Gr1DpF
	43JFy5Wa1kJF1xKa98Ja43uFW3Ca95XrW8Wr1UArs5Aa4UZ3WvgFZxKw1DGFWakF4Yyr4S
	vFWDKay7KFn2yrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY
	6Fy7McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU0E38UUUUUU==

When compiling with Clang on LoongArch, there exists the following objtool
warning in drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.o:

  dc_fixpt_recip() falls through to next function dc_fixpt_sinc()

This is because dc_fixpt_from_fraction() is inlined in dc_fixpt_recip()
by Clang, given dc_fixpt_from_fraction() is not a simple function, just
mark it noinline to avoid the above issue.

Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
index 88d3f9d7dd55..b40c6a21460d 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
@@ -68,7 +68,7 @@ static inline unsigned long long complete_integer_division_u64(
 #define GET_FRACTIONAL_PART(x) \
 	(FRACTIONAL_PART_MASK & (x))
 
-struct fixed31_32 dc_fixpt_from_fraction(long long numerator, long long denominator)
+noinline struct fixed31_32 dc_fixpt_from_fraction(long long numerator, long long denominator)
 {
 	struct fixed31_32 res;
 
-- 
2.42.0


