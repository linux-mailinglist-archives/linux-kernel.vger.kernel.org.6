Return-Path: <linux-kernel+bounces-361871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7794799AE2D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD131F256BD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BB31D173A;
	Fri, 11 Oct 2024 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kxsPETSC"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66181D0B97
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683056; cv=none; b=riJUodUKr5s9anxsm2Mrq8nm0T40b4pQBvNfprRJq2DlCXVANxUuzvZxIHWtVOu7Z0j/VLJsqQiS+WHP20EurJnh6ED4NONP+xdUMJVQ0Fwri61YVKO1pomHOp05rv8BnseSS9rO4m9W3y93xQ6fESPXE6cgF2X55HFhZSR8A3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683056; c=relaxed/simple;
	bh=Alfb43ggy1morVAhVCl9j9Qs+u6QkOqSpSocYaViI8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bPuBAExI3AeXy3cTLZqKtcDTRJxNeIN8qgGRjSpJ8O31BNUPm9mT5awwy94fzXiKgdEyVDo08C6vK05B9qwOQWQm9/eK9ls/gg+/60FR7/gqxJSQB9yHAYT1RfTrsBCM12TkVnEi6nsZ/C7tz4Ngw3h4GDVlG/2VxJcGpGKGVPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kxsPETSC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e368933adso2134386b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728683054; x=1729287854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8FDOlqwvEsdAJAf8IdqafehVhAI8JwdIbxbRDiLpiY=;
        b=kxsPETSCMazyrqlUZ+G7O95fuiPcGSkrzp9eB56qC2iRtLKxU7CrNCYH1K0PT5uWWE
         rIu/HqgfJuP81HV4nMwvt3Lk9dPpZNAQ1O+a65GuMgt7V5R+PeJs4oW3jTN53xFkakkL
         54le5HOUTrFuFwj8l0MCRM2V2C24tOVm6LaXKRIFYeugRL2twulrMl/NpiOYJLRROUUD
         PuFjDfnAonfYij0r9N3+j75DhTafkLfSEXMaC/7p2gtG2Za8vOV9YebrrgQDimTAllrY
         L68RJGiNEpkW4KfFVCOqTNSGcZeuj6iTDNGVyOkpCQJvcQ2uYp3fVXtE4ac6NDx6cSqk
         HsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728683054; x=1729287854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8FDOlqwvEsdAJAf8IdqafehVhAI8JwdIbxbRDiLpiY=;
        b=jFhpG0t3Levcbk07eyxZq+v3ifTf4XjERHMJu3KVQ/EKv3YqMtOQ7vxMOmT9I1Iojt
         Hntp2KRqr2HzKxgmuKCucinmiiBIuuU7vNBJ8eI9z3d4xvj+CybmW7r0JAzvVnJwcrQb
         AcI5q3uEwyxPJnarIOmai3vwEj8nFjCH3oqIOHXPGUSp/fk0+77N9DIyYZyJkLAcefKF
         vLKKrEGq/Rkd+l02Mr6OHX+zvkm70EyD4QJZzQ8T0ElSCzS8T5gNX3ZnBy4it+QhVOVh
         mrvAQOAgaGkUiWxMvBbYDIWlatoJr/Mj78t3dsGeE/bJz0RZe+603id+8MvufxfkuFfi
         jN7w==
X-Forwarded-Encrypted: i=1; AJvYcCVI96pBbFCrVxwFA5aksvFG48CoU/ebdoUhRdmREvGB9NSyfPLf/WnHJfDNb6PDKg2GORS+r5zrgq6WOfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCI8Z1Le2/4tplvX1bDzShOmGC1Qit2ZleDvvRgQGmBtPB1H+A
	s7kf9Xe862FAcZOrVPUhwvMBmR99NLxzCV36TVhIfdqkNzI/JM6ImHDo3T1CydXXDXHraBgnuZ2
	OQGKRNIL+nA==
X-Google-Smtp-Source: AGHT+IG+CTYjXiI2WYVmaCbmdgx8aJmNp5eEhEtp42YdvInIMKciu2bPG9BFE/JQsrplK7JkLlS0PX/QLI0I4A==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:f3:525d:ac13:60e1])
 (user=jmattson job=sendgmr) by 2002:a05:6a00:6f66:b0:71e:268d:19a6 with SMTP
 id d2e1a72fcca58-71e37e28a35mr18995b3a.1.1728683053750; Fri, 11 Oct 2024
 14:44:13 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:43:50 -0700
In-Reply-To: <20241011214353.1625057-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011214353.1625057-1-jmattson@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011214353.1625057-2-jmattson@google.com>
Subject: [PATCH v5 1/4] x86/cpufeatures: Clarify semantics of X86_FEATURE_IBPB
From: Jim Mattson <jmattson@google.com>
To: kvm@vger.kernel.org
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	jpoimboe@kernel.org, kai.huang@intel.com, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com, 
	sandipan.das@amd.com, seanjc@google.com, tglx@linutronix.de, x86@kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Since this synthetic feature bit is set on AMD CPUs that don't flush
the RSB on an IBPB, indicate as much in the comment, to avoid
potential confusion with the Intel IBPB semantics.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dd4682857c12..644b3e1e1ab6 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -215,7 +215,7 @@
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* Disable Speculative Store Bypass. */
 #define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /* AMD SSBD implementation via LS_CFG MSR */
 #define X86_FEATURE_IBRS		( 7*32+25) /* "ibrs" Indirect Branch Restricted Speculation */
-#define X86_FEATURE_IBPB		( 7*32+26) /* "ibpb" Indirect Branch Prediction Barrier */
+#define X86_FEATURE_IBPB		( 7*32+26) /* "ibpb" Indirect Branch Prediction Barrier without a guaranteed RSB flush */
 #define X86_FEATURE_STIBP		( 7*32+27) /* "stibp" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ZEN			( 7*32+28) /* Generic flag for all Zen and newer */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* L1TF workaround PTE inversion */
-- 
2.47.0.rc1.288.g06298d1525-goog


