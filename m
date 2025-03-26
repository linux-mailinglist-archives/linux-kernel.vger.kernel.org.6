Return-Path: <linux-kernel+bounces-576857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F686A71541
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBD1189461E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E856BA50;
	Wed, 26 Mar 2025 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTfzV32p"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC71C8626
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742986899; cv=none; b=pKJXyViJDrRWNw3nH5O+ZWQUAOQ9glAnXTSQw9xsxA+qf21nFVXn5xhP5zsSWV2t1lcXQnDJOI3ZUFTeT58EBGWpKEa5PAE1KVRpGqwWSPOv85NU6jGfcRvq34DFjF0z3OOUfjAd7t2sDYueCc49gbQT9+mz4wgvElZ0HqH6yr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742986899; c=relaxed/simple;
	bh=BzkNRZWNuEiabasgiSZ/Ec4yahGJSxfYCNxx10zT7gA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dzoT+BMij5xXALqtByolUYWNXFKtcMTIiZNyT9SsI3HYvmbSuDSaPR2XM3BTvE2inopLf9QYj9vTn0E8qdU8aMBVWXeEG/YQLYf/z/kGJSTsEvdS3AYAQaxfwJouY0i+QoSaQ6szmiE3dIuOzxanATImto9PaRIUTXmfqEy0tfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keirf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTfzV32p; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keirf.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso48220765e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742986896; x=1743591696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m8s0QIY71zWKro6xSXQRXZSeXe5WAyMtXk+LtoR8l9A=;
        b=oTfzV32pUynTSAxo6xfOT2X4fOFrupk7j/dkEVAwkPViz4XkQjkpdn9G2rAD8veM3G
         BdXZ3sxmSUjQHf+9zzANGkeVei8mlIdg32VHve7jq4EAPu+/QQTwP5TSs9aI5BgroeeJ
         BhYlK04m9s824yPt5LoMEFa6EuRKJLE44xIczl3/Kx2NLvGILUZvyg/YCPuHPEUvy0dK
         5/uvj0iVFo0lKrayMzTy73RwVK6coOpS2qLpyR5m58T1RzFMCWXaNp6gjZO4dro9CGR1
         D8gAwkYKp3By3XKB70cY1W+kaMauJjOU31xdktsVYQp1LYpeFt1gfMOc4RnHqab1BFZr
         sUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742986896; x=1743591696;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8s0QIY71zWKro6xSXQRXZSeXe5WAyMtXk+LtoR8l9A=;
        b=K/QzORwTi7picw3XERma5kYHT9zmJa48poZqjfjYlyeDaad0eSLV+VJlhmhi6aBG7V
         2T3qIrMDJsIQp/wUdKOWinh2m155SNuyGj5VRXObJSYPIkCjbMTmfFnYngDXxXO/pQBi
         cK7Cj18MPXbqpl5OKttMuy1hstd0q1IDPAgO+TzG0byxp/c4mL7+V2GNJVk1LUf+VUrh
         g9IN2l3UDz2ZcscnSGmm+iS8om5m6xO5bnPyg78OztkTnZciEkP6sm31Dw3OqGd5PB5/
         QfjhsoHgumlxDYDLImF2L1TDhjp9zBuQEma3wh9CckxBcp881FvHoQKxOBpMTtu8pu/9
         FK5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOWY9rH5foF9/6bMxh5HmJn1vDT9ch5dJcHeKCkjuM5+LTlPIHXVLQeYEP3wWet8peF+kKZOwfSzfHkZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVrIyqfgYxy4ruQ8xVlwl2FyFpCNetujBxsRBOAnCQef2P/G4
	xvck9N3w9Z+78VTstKxrqELMylAwS0V7jTQ/RL+y/hXVo5ZpcHtQWMF5vgnJOI+lhqqhhK35KA=
	=
X-Google-Smtp-Source: AGHT+IGBA2oNDwoX3vAaJuxLHM6l0qsvxKSEmFmpM5Wmf4mD/taDlkLFT9vj4nHDL4Q52ah1LmKUKhke0w==
X-Received: from wrqb8.prod.google.com ([2002:a5d:40c8:0:b0:391:3d79:3021])
 (user=keirf job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5885:0:b0:390:f4f9:8396
 with SMTP id ffacd0b85a97d-3997f912d09mr21778026f8f.28.1742986895818; Wed, 26
 Mar 2025 04:01:35 -0700 (PDT)
Date: Wed, 26 Mar 2025 11:00:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326110059.3773318-1-keirf@google.com>
Subject: [PATCH] arm64: mops: Do not dereference src reg for a set operation
From: Keir Fraser <keirf@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Keir Fraser <keirf@google.com>, Kristina Martsenko <kristina.martsenko@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The source register is not used for SET* and reading it can result in
a UBSAN out-of-bounds array access error, specifically when the MOPS
exception is taken from a SET* sequence with XZR (reg 31) as the
source. Architecturally this is the only case where a src/dst/size
field in the ESR can be reported as 31.

Prior to 2de451a329cf662b the code in do_el0_mops() was benign as the
use of pt_regs_read_reg() prevented the out-of-bounds access.

Fixes: 2de451a329cf662b ("KVM: arm64: Add handler for MOPS exceptions")
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org
Reviewed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Keir Fraser <keirf@google.com>
---
 arch/arm64/include/asm/traps.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index d780d1bd2eac..82cf1f879c61 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -109,10 +109,9 @@ static inline void arm64_mops_reset_regs(struct user_pt_regs *regs, unsigned lon
 	int dstreg = ESR_ELx_MOPS_ISS_DESTREG(esr);
 	int srcreg = ESR_ELx_MOPS_ISS_SRCREG(esr);
 	int sizereg = ESR_ELx_MOPS_ISS_SIZEREG(esr);
-	unsigned long dst, src, size;
+	unsigned long dst, size;
 
 	dst = regs->regs[dstreg];
-	src = regs->regs[srcreg];
 	size = regs->regs[sizereg];
 
 	/*
@@ -129,6 +128,7 @@ static inline void arm64_mops_reset_regs(struct user_pt_regs *regs, unsigned lon
 		}
 	} else {
 		/* CPY* instruction */
+		unsigned long src = regs->regs[srcreg];
 		if (!(option_a ^ wrong_option)) {
 			/* Format is from Option B */
 			if (regs->pstate & PSR_N_BIT) {
-- 
2.49.0.395.g12beb8f557-goog


