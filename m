Return-Path: <linux-kernel+bounces-361872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E2B99AE2F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC92287901
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498DF1D1E62;
	Fri, 11 Oct 2024 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ER9iwjo"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CBB1D174E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683061; cv=none; b=DAuOVsGtCpM4/srjkLYspjR/j7Rg9tl7thaKvyZL9WBh7mOoLZRxyYX2imPmhLLCwpxAItvfbTqvtpq6aPHJ9s0fzuEagM4QR+QDK77u25aZoffo3uKULzGzBp34d4Cdmq2oGnCljr1LGiYllJb27Tp0v/6ZhXcPtUA8p5wntVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683061; c=relaxed/simple;
	bh=/I8VUdkvAJLQEJj8WKw3N5lQy7af0guee/AI5dqcmnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PJO9XIk4LE+vI9OYxjUk/vdllW9s++kLtte24jtbKneFDyQ3XXtgc18TxUrY7Rbo41GmF91e/J/jAqI/EGevDezhc2yLqFGNfrgNW8QiVoXSxIq+YPnR1+EGASiBUAr1PUy8QfNI1nT0PbK75Zt+KNoInwG79IYN2yep9h2AJwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ER9iwjo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35199eb2bso16444387b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728683059; x=1729287859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ReiYQhELm2YErEhhfOQ8zhEV99f32bvRKL1jPZXBWs=;
        b=4ER9iwjoUn+yPgXUspunanZ7QEeA5blOKMGLA7S+CQtInMI4lFpjjrpPBvpBYZOhNF
         mRTzzbHGn++U0IBzJTxMUG8YAWtx9z+vJnHnGnrA+0Glrjwr95OMIwnQo4koZhIemNNS
         AOI6NhV6gB3n0xTT02kHTwjX1Vu4/KcXKa4yi5ytrM1rWg2U7paHYX53kmNwYXl9emIP
         WNEQDBkn9kokAfuNhN8DyvskuXRCb4hjdemeOnlGyXyBqoY1HVDtDMC8N0thGRVBqrjn
         fFApH8KsTaYpddjtQeY/RlW/Vrqc0yJLX5FqL8LMveufRjFEv503MK7GdJoRX4wtMg3g
         jvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728683059; x=1729287859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ReiYQhELm2YErEhhfOQ8zhEV99f32bvRKL1jPZXBWs=;
        b=a6Di/T2mVJsmd9m+pD5Xj7c7I7OEb83YLHPyhPIWyRdf4hbTEzbm+yZuWiQxgFJvUT
         NSW+9OpEc97nosW6Hywib3dRgQJnmFQ3ndWL0zGqt4s2p0RPp83WkAMVu5bbbyRFH8nn
         3lVAHsXn50Pc+eaaLACtSvwrI/kjZV+9dRaLcdLw5u9t4uTcZ7b3Mh1wkb+E1l4y4vDV
         gU+SF3thMiqqPhwzM/KrGhbZTUu/wEotOvLnE67DIqyNv5d+RhQTP8dLWW4O7uck/82j
         l81mkaoS4W3ipqf3lgdINPrVSQIG+B3GHx7vwhHm1F5ZEV5GY0D0QiJnXxiy4J1aqej1
         StoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIH9IZvs+SmBWuEpBB6USPTS4Mdf8dhmrWPDzV+Ve0DF0kJ+LzpsGudBq/Qqnc8rtS3v4zh7hSndYQ+U0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo4QUwH4o4yCn/awPcyyEmQxNU3ygcnSeWSC2AOtzzh4SLscOr
	f5DVvirrv3yYz7xVU+mGVRD6YXqC07z+u4KJfzHyvAC9o5zmuF7jYVeuhwiAXUucBX893IfzgLT
	1TuViLSvvCA==
X-Google-Smtp-Source: AGHT+IFNjTU5JA4y1ucXDSMX706MXDSEHDMsE+i5BoQ5Q0Kts10PVFaN7ZNX1L99lyAXtbkbDoxswNpwL0J9HQ==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:f3:525d:ac13:60e1])
 (user=jmattson job=sendgmr) by 2002:a25:86d0:0:b0:e25:5cb1:77cd with SMTP id
 3f1490d57ef6-e291a32d32cmr14230276.10.1728683059203; Fri, 11 Oct 2024
 14:44:19 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:43:51 -0700
In-Reply-To: <20241011214353.1625057-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011214353.1625057-1-jmattson@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011214353.1625057-3-jmattson@google.com>
Subject: [PATCH v5 2/4] x86/cpufeatures: Define X86_FEATURE_AMD_IBPB_RET
From: Jim Mattson <jmattson@google.com>
To: kvm@vger.kernel.org
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	jpoimboe@kernel.org, kai.huang@intel.com, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com, 
	sandipan.das@amd.com, seanjc@google.com, tglx@linutronix.de, x86@kernel.org, 
	Jim Mattson <jmattson@google.com>, Venkatesh Srinivas <venkateshs@chromium.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

AMD's initial implementation of IBPB did not clear the return address
predictor. Beginning with Zen4, AMD's IBPB *does* clear the return
address predictor. This behavior is enumerated by
CPUID.80000008H:EBX.IBPB_RET[bit 30].

Define X86_FEATURE_AMD_IBPB_RET for use in KVM_GET_SUPPORTED_CPUID,
when determining cross-vendor capabilities.

Suggested-by: Venkatesh Srinivas <venkateshs@chromium.org>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 644b3e1e1ab6..a222a24677d7 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -348,6 +348,7 @@
 #define X86_FEATURE_CPPC		(13*32+27) /* "cppc" Collaborative Processor Performance Control */
 #define X86_FEATURE_AMD_PSFD            (13*32+28) /* Predictive Store Forwarding Disable */
 #define X86_FEATURE_BTC_NO		(13*32+29) /* Not vulnerable to Branch Type Confusion */
+#define X86_FEATURE_AMD_IBPB_RET	(13*32+30) /* IBPB clears return address predictor */
 #define X86_FEATURE_BRS			(13*32+31) /* "brs" Branch Sampling available */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
-- 
2.47.0.rc1.288.g06298d1525-goog


