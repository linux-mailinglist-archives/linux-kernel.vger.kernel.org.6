Return-Path: <linux-kernel+bounces-268683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB689427D1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446E91F22D42
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7241A71F0;
	Wed, 31 Jul 2024 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="b5Gbn6IR"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2311A4F08
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410773; cv=none; b=HCJw73QwZakWtrK464baxHndDEn1SnJItoPtHHmpp8HRU+3qmPhaECaa/Hp/FrXEv6EU2EvrLigQEweZhpfKHu22zITq3bmlFbc463w2azB/ZOdKQ2yqpp6VGPQyhsr5g488Hg0lhxZ6G2KBKrTbAv9YIEIg2of3XoTKsrohinA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410773; c=relaxed/simple;
	bh=J67YKbYp1c1+dYtGt9ihjp1nazBSRKyY+Dh1Xv6jDrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GNc66IZ2qGWVeOuaopf2bEBCBcgQmTaOJTLm8/BGydcNfypgPN6mgxb/Wv3JzRHbaF9q5kqPtcAvlyQ0QnhYE+G1VmciY3KN4trlr9HMyPOxMAkvlHo2xXnpyRY5d8g7PgNAZRyHWA336WCQMvvTxdgL0RUADincEJwoiE7na7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=b5Gbn6IR; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efbc57456so5583655e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722410770; x=1723015570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5b/A6qU74AkfxdtYyxiBPFCfAn9Wby9ZSL7Rzcj1cY=;
        b=b5Gbn6IRAvY0tHkf/7Ai9odhhMKW2ZR1PwZk/hpn/QFX8afSXWRTbRRFejDQkRzcpz
         hIvPfOUBhPNSk5oQpwMQAvPfWoMvqIcIghXxVyut5fi2n9skxp4vcNAd2N1+4tiNCdhx
         qQiuKvRncHIN7rbh1e7mgLryENr9OLKIiHTuJameD/AseWb1vepFfMYmyohMdINw3Q/C
         B5R4r4O9wUtxSNoHQ6lAx2Du9EpDgvUqf0dor8OPcoc3SLCo2yjGpkwMmPv1HVzuuQI8
         GnpJphVjN0E8smQjioiIhltCn3vk2bdgpC7GLfkaAo1XOXVVpZq+Frd/aFPHYzWtO9KE
         ue/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722410770; x=1723015570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5b/A6qU74AkfxdtYyxiBPFCfAn9Wby9ZSL7Rzcj1cY=;
        b=C16bjv1YsDsiW6+BbtZGsLfpGXTtom/612kPYBv/EnAZ+nYZmF7wkiQ11j4fqVwzmK
         eMXBZ+OE5teYz26eXs9fuGGUP6uYWbHMyWP2gZZIrjZfhLMaRnH6B3r4xdz/wD7UZfzp
         RWkVW7pIHUlCqiM7wY3FQ0HRrQddN06ZRt7PMT5bpWRXqwADtr2SXL+SgirAPBGAo/2n
         d4kiOkJ/M1p0l9nEQAZgWtfx6ZxfKJvGiVc1Idp1vSVxu1zXv7Mocc7gnxT29a2hBf3a
         kpA7CqIkSE9ncMT/8uwpI1kCB6JCYbXyecyWgyL+QbkGBgRYEnDFmv8ExBcsY7vlH9yM
         B9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVURfnsb2JNhCRFM5aqk/rfegtAn5u98W9ChbeAiZlD3ssjbJyiZa7jzwLtlLAJewp0dscGEEF1crV0WcOEM87bpy0BZfYMYA5YPOex
X-Gm-Message-State: AOJu0Yw3HwSsq0tjGhw8zLod/Mbw7g+J0HADbXldJKDObjUyUiEVcn0g
	Ee4ZlFmrTMeeRbpKd9jWymFpWBCnfaVCEQ+XagPOt4pjDeE6IvviW0ZNVH0QgPE=
X-Google-Smtp-Source: AGHT+IElDfoIlakrFYsMBeeLlbntHhhP6Di7Erttb/4pd4dWg5QISN3W8tux4DC9SLwXgyAkaGYd7g==
X-Received: by 2002:a19:8c58:0:b0:52c:f12a:d0e0 with SMTP id 2adb3069b0e04-5309b27a656mr7792329e87.28.1722410770171;
        Wed, 31 Jul 2024 00:26:10 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bac7349sm10525575e9.27.2024.07.31.00.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:26:09 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 02/13] riscv: Do not fail to build on byte/halfword operations with Zawrs
Date: Wed, 31 Jul 2024 09:23:54 +0200
Message-Id: <20240731072405.197046-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731072405.197046-1-alexghiti@rivosinc.com>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

riscv does not have lr instructions on byte and halfword but the
qspinlock implementation actually uses such atomics provided by the
Zabha extension, so those sizes are legitimate.

Then instead of failing to build, just fallback to the !Zawrs path.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/cmpxchg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index ebbce134917c..9ba497ea18a5 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -268,7 +268,8 @@ static __always_inline void __cmpwait(volatile void *ptr,
 		break;
 #endif
 	default:
-		BUILD_BUG();
+		/* RISC-V doesn't have lr instructions on byte and half-word. */
+		goto no_zawrs;
 	}
 
 	return;
-- 
2.39.2


