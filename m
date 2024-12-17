Return-Path: <linux-kernel+bounces-448448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55DE9F403A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BFC188C16B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCED13D891;
	Tue, 17 Dec 2024 01:50:20 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E1F13C689
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734400220; cv=none; b=XKlBGjo+v3wiUdAakXY45Sgvr/MUA25CSjShuKqJIKF3sGvbOXlXqJnTs0wcS7b8KrFt1N/5iGPlviH2tjMCIlEzxlIFhIuNK7K/q3PKhuN0dLbasZaOFV437Zw+EZYTgQA0TJh8/9tC1Pw4jGsR29J8qk/V2sqZ90X8kqb7mQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734400220; c=relaxed/simple;
	bh=6zwDsHOUh1VbxgGD9EGwxbLyhq8N4xqmUgzklPxvcCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fnawou1Zkrqbu8p5pu/G1lclQ+XYWc4YXaC5ekiWi+AQHasOeJldyXvykcuHSOrYkkFo3o32+q+yAmrB308MkwkAEsU4f13m7YK68byEEkS6Cpj8kxYIj6mytPlLcxgM09e3lmT9jl8gU+FWuQS74qC9FTIpMd2vnat+/GBqjc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxGeDQ2GBnrpxXAA--.39627S3;
	Tue, 17 Dec 2024 09:50:08 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxbUfO2GBn8+KFAA--.16146S2;
	Tue, 17 Dec 2024 09:50:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 9/9] drm/amd/display: Mark dc_fixpt_from_fraction() noinline
Date: Tue, 17 Dec 2024 09:50:06 +0800
Message-ID: <20241217015006.30305-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241217010905.13054-1-yangtiezhu@loongson.cn>
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxbUfO2GBn8+KFAA--.16146S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF17KFWruF4DAw1DtrWDGFX_yoW8JFW3pF
	43JFy5Wa1kJF1xKFZxJa45uFW3Ca95XrW0gr1UAws5Aa47A3WvgFZxt3WDGFW2kF4Yyr4I
	vF4DKay7KFn2yrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8siSPUUUUU==

When compiling with Clang on LoongArch, there exists the following objtool
warning in drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.o:

  dc_fixpt_recip() falls through to next function dc_fixpt_sinc()

This is because dc_fixpt_from_fraction() is inlined in dc_fixpt_recip()
by Clang, given dc_fixpt_from_fraction() is not a simple function, just
mark it noinline to avoid the above issue.

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


