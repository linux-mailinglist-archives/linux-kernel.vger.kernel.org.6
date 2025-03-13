Return-Path: <linux-kernel+bounces-558710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16A1A5E9E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845911899F39
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1E3143C5D;
	Thu, 13 Mar 2025 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu2CqXNV"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78513C81B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832407; cv=none; b=JnrqKJCdkkPj1ODfNHRvOulQ4/nqoBXmmPgW6AJkul9kde35UjAT1/xtuDlZrRbLHFMXXXJJH7NYK608ZQV9ZlUoHXVV7AXAEqqKdDUzjFLWmvnB3NLO+7attr/P/H+vBFSJ6zUV2A/+7s8wQzzqEYDqyuYCnHJVJ58krtHmYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832407; c=relaxed/simple;
	bh=YrooeLVFWs9fZicoPRhZ9aArw0E5gKkPFcEy+QVRPSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjVlx1mGaQ3LkKtR5qBwf+AC3QQGao5Jqu9v+Io85p6n6qHXSmWqIt6nWIgdrmXnJ27Z2hQrM+FdG4uK2B3JM5wCslXcqMp6D6Y+0rP6SdV4nbU2zP+URsr+zjk1UZ1UhL8lWPMF1wpsAawmgt483Ua8e/zCarkIcIeJ37Rmhro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu2CqXNV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3012a0c8496so826252a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741832405; x=1742437205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLw67BqWA0BIkPETmcHm1W/HkXtVEPs+aCbes5Kp6pw=;
        b=iu2CqXNVj/nuPpHG+v1rwUMVYBm2R3QWcprdF/J9R+sr+tWoaM5EjeqCRsrjCtYozG
         WME+DyU+V2TjnDpWnL/YhTqQXqsvipMhz9mdQ8sQmBTSAW9xpr7P8EZMLgATeqWg7NuN
         rI8rrI6/TBEI7Mci2l89dPL1gcwtkklH7dGAVxc2/YcEKmgQMYojgtY3WXW+ThT7kOBC
         EUbO40gHMY3/Zdx4RgynZ2119xbIZgT4pIaHiqQiUTxL5iKB6EdmQjtucYiFquNaqBbE
         harJJBfPWMOqqaP6twRm67r7sucfKQXgfywgRLg/MnHcJagNihxkrdpM1f9PG7fk09L2
         jS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741832405; x=1742437205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLw67BqWA0BIkPETmcHm1W/HkXtVEPs+aCbes5Kp6pw=;
        b=SIiIChUxSmjLeUulGGggLpvRP8tyBcQqAvZi+wxcjnLto5hwLNQ/B5tadmEcJovZlS
         jMbR0P7x2WhuC4qcGPS9IWWxltpXGYUCqwBvNmpjWhpt9Da/3GmcJPpfK5q/v31g5LGh
         3Ajj8Jp/CR96RWlGg8Go5eNdwNhagFf/RQa8WTHYRK8gSz7SEluKtW4B3EBoXUdQQdhQ
         9RWXwuGcib2SYaMW/L7Dwz6C2bfMxHhQ/pKoDkZY9Mfj1b22WcgR70Fc5dBjD11cXAIb
         3Xt/RmeAz4jy+nMcEUrbXDfrVkkaAQ9+Egyu8yAwzosVkIb/W2yaog3Hm/2G1cM6LrvM
         KXlw==
X-Gm-Message-State: AOJu0Yw3LgT+lt8zhTn0zuv9Yt5eql+98ac4LZyFwlnE33ibBtkEF02U
	rTRnxuLVq9+TtbUZKzdAn5DqFAM/eEutoe5W1hPwxIkcngHmP2tiN5My1z5v
X-Gm-Gg: ASbGncvnpZ5vTUMDEQCTCz9dfGZv+eCiNWVYskOUMPA3rzefwPzhN/fYubU+PhWTwlw
	+QBUt8lsJbW4vZvB6kU5k7a/HW1UoXnkY1r0SrYVbij5zGlDkJlhw5/HaL1YLAmOlpWwuKEWuJq
	qJ17V2XMAnYr+hg+Lsrthf3by/Xmrumf+jvk8xO1xvWFy99Bf0ndFi8HX5LyruJok5OsVmYSDkr
	3RSHyCuQPansAJDA9CsZ042gq5StkdQ+BeNL6Q3sb+O0Ux3f9QbLAQY33/2ldBlosJDD88lU+rO
	uY1K1RvdYDlTQMnkpVB2K3AsfeDr5YgpcjEIzbqK/7hY
X-Google-Smtp-Source: AGHT+IGd/HsBjLkc68NP6moc+1YM/RCLuYwV9ycuTAbmTeB62jDlEwfr3ThGTS9nnEwZw2LwUvK2WA==
X-Received: by 2002:a17:90a:d605:b0:2f9:cf97:56ac with SMTP id 98e67ed59e1d1-2ff7cd3ebcfmr41200798a91.0.1741832405575;
        Wed, 12 Mar 2025 19:20:05 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3011809f308sm2668096a91.0.2025.03.12.19.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 19:20:05 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH 3/4] riscv: switch set_icache_stale_mask() to using non-atomic assign_cpu()
Date: Wed, 12 Mar 2025 22:19:51 -0400
Message-ID: <20250313021953.86035-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313021953.86035-1-yury.norov@gmail.com>
References: <20250313021953.86035-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The atomic cpumask_assign_cpu() follows non-atomic cpumask_setall(),
which makes the whole operation non-atomic. Fix this by relaxing to
non-atomic __assign_cpu().

Fixes: 7c1e5b9690b0e14 ("riscv: Disable preemption while handling PR_RISCV_CTX_SW_FENCEI_OFF")
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/riscv/mm/cacheflush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index b81672729887..b8e96dfff19d 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -172,7 +172,7 @@ static void set_icache_stale_mask(void)
 	stale_cpu = cpumask_test_cpu(cpu, mask);
 
 	cpumask_setall(mask);
-	cpumask_assign_cpu(cpu, mask, stale_cpu);
+	__assign_cpu(cpu, mask, stale_cpu);
 	put_cpu();
 }
 #endif
-- 
2.43.0


