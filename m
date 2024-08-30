Return-Path: <linux-kernel+bounces-308367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E98965C11
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 972B6B226C3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE616DC3C;
	Fri, 30 Aug 2024 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="v1iz961p"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501B1D12F7
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007783; cv=none; b=X579o6Ps6Tf3rlP2YrZ0OlXAVOcRfv3Bra0mtRNn3WUPA240kIQTlF5mDrjsmvfbQAwCEuJlQNlyqyJZ2VjuXlpNw+4oM8Y9EqL50jZo0icNLLdVAthixftzlo3ukTDLQizv7yk0sWAAlC5p6jvugjvdSSIBo4Ga0hlL1rRd8Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007783; c=relaxed/simple;
	bh=zdZadlnNzaElfHsWoPjHWe3tI8fON1fsmp9007cBvCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W573qB8cvwHPZgc9RENpSU3T9NfVYcWiVteqGhRosAA2XOGEgENbhYnIdKPyR9fB0JYjEmbgBbir/+mMxBWdW0+XkHoXWzbb02lr29nISxFAbqml2wp5XnsSoniMivtXi3wy0Gynwwxiv6uU7K5v4hgjR0pIqoKNSVJJI3actgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=v1iz961p; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37186c2278bso1419529f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725007779; x=1725612579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iGJL7OIFuIkfLAFkoMGwwROnKpnDuEMTd89ued1Cebg=;
        b=v1iz961psUvb3EpB4e5PHwGfOO1Fm/oE7iVsx7Khu34fR+TkgoDg9h2UL+3bSNctOJ
         NBpiKA4nQeVwvYexAFiTzpjfktsazJKabm7gCfRhhOJcVjt4j0PUrzn3WNfQGFFo8uBO
         NwJhMvUvEvy5qTU3YtM3fStQkvC6eXWbV0b7hRbwn24JvSVC0ZFrBxAUf1uo7BSgDZuV
         VhndyfHXnVKvzWtvMzVK2nvtG2zwmBZTfiWrpfHM6ajd2AftNV2FC2Lq27lhUFuaRNSg
         5Vkipka+Y6hpccifhUYidryTGhaK73aNgxgj343yl22XG61HivOIzYEvjJy8SzvmD5gz
         h9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725007779; x=1725612579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGJL7OIFuIkfLAFkoMGwwROnKpnDuEMTd89ued1Cebg=;
        b=TEjqVLhe/xkSz46TXBd8ioJqetor8oGYX6GBc9+DxoBjwn/XuHJxgB+YL6PBDHbg8i
         5AeCBRjnlM4XeZttN3yQstJom6K3iFmljdRtsbKHkxem/5STNTkE2jlqRRDQIMwfirhO
         Re/aYbvpfwr6u0NPCbNg8u9Tppxnc9574/T2BclhJcuPJNwEMMze2yKU2dizC5csBsYy
         3IkzY8g8K8mi/31FvWDMBp/LP5v1SOgwbtu6RcedTKC4FI5ZqIjMhgxfHV2gJlf2Av9g
         gcNDihgOicffg2I2MxxzTaQzknjmWSFqJUY1rdgQ67a1bPn7NzURC4OGXYb5fTQMyG4+
         6OpA==
X-Forwarded-Encrypted: i=1; AJvYcCW7zmIdGg/nGsbIo7nE32ews1rV/V6LeD8e9up7b5z/4jdSaBWbnjuHSlumiKS4U51RaIwThgcZH0kw0nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR3HUE/Ps4sZ/VFjfA1UW0OJbuZgyspS9Chu350sxzRMjKXb1e
	MJkfrKgrpcJz7GJYTHvdggiVhZlIsm7XhMRjYl4RGsfu8J9wQSNyIup/e34iHHw=
X-Google-Smtp-Source: AGHT+IE35PnHcXWnBWcAufXm2itAOGM3bjIxxoVO2EORI0hpbo/KkZo9FhT5TSGQ+S/KMoIRwGKHwg==
X-Received: by 2002:a05:6000:1e90:b0:36b:b174:5256 with SMTP id ffacd0b85a97d-3749c1a9d0bmr2933640f8f.6.1725007778972;
        Fri, 30 Aug 2024 01:49:38 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee73fa0sm3373144f8f.43.2024.08.30.01.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:49:38 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: remove useless pc check in stacktrace handling
Date: Fri, 30 Aug 2024 10:49:32 +0200
Message-ID: <20240830084934.3690037-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Checking for pc to be a kernel text address at this location is useless
since pc == handle_exception. Remove this check.

Signed-off-by: Clément Léger <cleger@rivosinc.com>

---
 arch/riscv/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index c6d5de22463f..f934c573c087 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -72,7 +72,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			pc = ftrace_graph_ret_addr(current, &graph_idx, frame->ra,
 						   &frame->ra);
 			if (pc == (unsigned long)handle_exception) {
-				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
+				if (unlikely(!fn(arg, pc)))
 					break;
 
 				pc = ((struct pt_regs *)sp)->epc;
-- 
2.45.2


