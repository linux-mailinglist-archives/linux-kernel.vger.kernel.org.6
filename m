Return-Path: <linux-kernel+bounces-576858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280C8A71542
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0388516B7CA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2731D07BA;
	Wed, 26 Mar 2025 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1UKvcNzQ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE0619CCF5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742987096; cv=none; b=q+qB9uBsNuOQoLbWVFkHgaKkLPkto+zgMpgAIwRB4zdzU5YSFU/SOWh6POhDjlzJr7CTfsSeVc57JhZfkslQxeMkzBzZoHTEIfb3WhtX0pEkmUKYoUGLboZPbSRvlX1x6PNPyXsfj4rc99aRSCSZppbYoRDsWcNpxn8B0EPqV+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742987096; c=relaxed/simple;
	bh=BzkNRZWNuEiabasgiSZ/Ec4yahGJSxfYCNxx10zT7gA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M4vi/If+pTU7USUdjDNwEJ6w4S9EkYDGNz0/ITSgHGab5GRX6WkUTzIfzNrTSN23Ju6r1Ttx1tw4562S7VV7hjDqQ84MNr25IlHxfdRB81VBimpH2tRrSy0OIB33RglTzGZKGF/lfEngK2DsBlt4Hcpnic4B0qZBG98oPZ4pYPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keirf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1UKvcNzQ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keirf.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4394c489babso31123405e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742987093; x=1743591893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m8s0QIY71zWKro6xSXQRXZSeXe5WAyMtXk+LtoR8l9A=;
        b=1UKvcNzQ+Ywlq6Kqh+073r1lrhCkOEsQfNvUZ5LKS8j/J7JSYAE+aFiX+BvkubaQ8W
         Xd+N8DNv5ou6uIcpxOTkQ3Yz+IAvVGx0lp9c7bL10cSk8VQymUHfFeIg+l0iYdCpoL/E
         psoiaAPX4sX9zgsTJbKD8sLz4moNu/MJP5afvpBUY1w7YSRNtNR28ZczByoQFh1ZotvF
         BwIBiQK/4zkyR8Lh4vgeQ7tgs81P6GGeE5bwjb278d9Y9D2V8yQu/5BBZ9qgnd7RGq3a
         c841RKtQGrQrzPMSumHGXTOnD/Hty9AWGUc6d6SeRNMbF17BIjSCFaZwtYycJpleljEH
         SqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742987093; x=1743591893;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8s0QIY71zWKro6xSXQRXZSeXe5WAyMtXk+LtoR8l9A=;
        b=d6ZSJNBM4t1TA3lESWSFTGT6oXEk6IHvykwVs+N2Ukp3U/1GVw8dWDxoiBX/g3Cq6L
         Q+oTysvOehz6IinVx47tvJjl2jU9UNpb76P5u9nDJQ2pQhXkPgzeW8jbttUKvw4jG+Qt
         2g8PuchI8U0rKqBgxLY1SsqQzJM9kto50UyVcA+5swxPrEOGXejLqM7QQGMTLYwqp4oX
         bPADczOC8AV50v7Bg1KLjKXoA6X/eg2tN6/tk7RGMrWDH1Wr0BAfLSPKC+97VgYIXg3L
         oICCX0oDOfHRq86F+ivH6q7mSZipxCAYifnbIT1mXn9qCwkwMRBvaHCPt5cIwZauHOlT
         JM3A==
X-Forwarded-Encrypted: i=1; AJvYcCUUz5iMJmPY3yZuu3jRNObs2+JM4T7Hr9FBaie4GKXTQzj8HhxVvY1QC5rNUT33bh2Q1wSPNquZEiESFmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy62v13EHLpuktGV4L35ANUReKoiwJS5T5OTob70syOuKTZKEH
	epzkYf+qvcwgl4hhqDFHxtOuy/REaWBGkyT6p6DnB4gd+yyJSMB+G9ucXyv/6Z8+N9M5toxWLw=
	=
X-Google-Smtp-Source: AGHT+IFE7QB78vQyOL/wlLJW8RVd/ZNnGkr6KLJbVri+z1rNmymt2uSjxG1NGSBhHuOotLBvKBi8D1fjsw==
X-Received: from wmcq22.prod.google.com ([2002:a05:600c:c116:b0:43d:b30:d2df])
 (user=keirf job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:cc6:b0:43d:16a0:d82c
 with SMTP id 5b1f17b1804b1-43d509e6539mr206451605e9.2.1742987093272; Wed, 26
 Mar 2025 04:04:53 -0700 (PDT)
Date: Wed, 26 Mar 2025 11:04:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326110448.3792396-1-keirf@google.com>
Subject: [PATCH v2] arm64: mops: Do not dereference src reg for a set operation
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


