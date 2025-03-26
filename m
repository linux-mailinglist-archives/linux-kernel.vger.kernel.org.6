Return-Path: <linux-kernel+bounces-576555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3F1A71102
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC393B96DE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F19519755B;
	Wed, 26 Mar 2025 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLdgg/0l"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A550A1917D0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742972609; cv=none; b=cK+OVfI/mZkN4ToLi9jATlqnelHazlDBQDKLxKsD9K8GgDr0omxTOta1RMB+lQKDMEFd8YWdnmRd6W9cVvp2/93iVneXzSq5fEH3xztGKwXnLEUv+lHJZdN7r4TKSAvXFgcDbHX82DfLs0oOUSSwgm9heBwkt0htyHXCFZ9+C2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742972609; c=relaxed/simple;
	bh=qTpgNy6zEDsUZhOgWml+A7fADV/itqrWvIqhBWECVzc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UeJjrnUCXrlTJK/Q0erOWNK+wAnVQbYjlMdRHcC9BeJ+eBYQ8ABOsAO+g7Q1L2Yxvs+lOmA5j489iDnIucQFJLmT6t6Yqbol3XvOmH3aGrOYZA5Q77aHumNAQQPJHysnBeXIELGuzDqsUcrqXYKGboBEx1ryM0aYklz31x4Fd0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keirf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLdgg/0l; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keirf.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-39130f02631so2498405f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742972605; x=1743577405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VjdDMxOJ8ypIsJr26T0ef7SswO7nHrS4JeKFOEHommw=;
        b=OLdgg/0lcUlFYDTUfmCHOW4+p6ZmeD+XTpQeAknHEolk8qBst5l4m+AxlxzJ6NNz6x
         CdTwrID5S3BIjG+SbCSIj7oNswm3DQpfyj01+4ol+SirAL5gKSetVzID+lcphx06n6ef
         SVew1+ekJfidbeWcm3It5+BXVOIqNnsewtjBJRR3HWaX9QPET5pX0V/YY1ZslrntnKjl
         tKGDJ4tfhhbotu25K3gntRPX7P+MKalv0VZrMouqDqV5kHpGrmbx8o/elplwHZV/k3QI
         r1y7n+Ssg/wqAomNabRi9mTsMj2gzHXVR9plyvJlmHSvTcfKUL0NuZIPoVOgZkn9MtQl
         Qp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742972605; x=1743577405;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjdDMxOJ8ypIsJr26T0ef7SswO7nHrS4JeKFOEHommw=;
        b=VcUEkNh2KB+8uzEjqev3f3WOdQqjwE2S1zcydYTIaDb07IFOoiuV9hyJdw0qpB99kP
         43x/+7NPA/EZlMWoCMI4+PXwv1jeISNbr9v7EqNvP01ZSlucNQlp3wsTkevj2Xip013i
         8s+e8aQFZnc0O4yTmpUH++QlHZPwxV34/am02DjbQ3YU89SEBbp4oO/WwoTgrfaH9CXd
         0pxtNUpzqf2PxBGf9/PogenF+GVV24XsjIf6tVBAlmiygq3FvyiwDqXecvhf5vrFf9yQ
         YFY9sZ+Mhkl/HB06ms5/nLit0mW1rGkvpE+HQlYNj86dBQaLB+JdfWOCT7ZbiybjoO1Y
         BBAw==
X-Forwarded-Encrypted: i=1; AJvYcCUFxl0YEw1o9mg37HgoduJNaz+OlNVEet0YYsPaARWKdtM3rgKbCIhuw5D/KWIhFOIz1i9hdsVmRb8z2Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YykHFK1Hc9rv6bybMOmozXIqRR2noolZyyb2eeG1s6k8FwPoJ4e
	eFiFi08DpHxmIu127AsZV5cvquwmbWt5baUSpwwLolDv5GW1/QqfsSKdEbOTv3BtqYDWgMaTYg=
	=
X-Google-Smtp-Source: AGHT+IH/xYSgXGEpnU/366BtleKSATBGgV7i3H8fDcMjsdSTbRVbQbDtBIxppx2fAgMCYggfEAQrcuBHoQ==
X-Received: from wmbgx13.prod.google.com ([2002:a05:600c:858d:b0:43d:8f:dd29])
 (user=keirf job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:186d:b0:390:ed04:a676
 with SMTP id ffacd0b85a97d-3997f8ff44fmr18138026f8f.22.1742972605097; Wed, 26
 Mar 2025 00:03:25 -0700 (PDT)
Date: Wed, 26 Mar 2025 07:02:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326070255.2567981-1-keirf@google.com>
Subject: [PATCH] arm64: mops: Do not dereference src reg for a set operation
From: Keir Fraser <keirf@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Keir Fraser <keirf@google.com>, Kristina Martsenko <kristina.martsenko@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The register is not defined and reading it can result in a UBSAN
out-of-bounds array access error, specifically when the srcreg field
value is 31.

Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
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


