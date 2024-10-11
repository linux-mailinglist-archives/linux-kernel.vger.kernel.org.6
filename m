Return-Path: <linux-kernel+bounces-361870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B76E99AE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196AC1F2553A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49C01D1728;
	Fri, 11 Oct 2024 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zxy8cGtW"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2871CF7BC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683048; cv=none; b=quL5Ya0b4Mqs0xO/JuVxGtp9hrTMaV45akUDNN0INrOKix1baZcMI1802He8zxtqRSdcxKRrsIT9XloG7jDzmGJXcpeEP8VMnchXKTTWpty1T65nArpO91XSgfSb2oZb7gkLz0U5PMWoAwcix7y/BrMG80zv9tNYTV5GTQFgrgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683048; c=relaxed/simple;
	bh=GkG6HA/ztoTmh8RNk8cfGt8sBATI27MLHUFNbQ1Xric=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=s8JMDAz25Jgj6F+6KwDJOCNakU0F0IeYcjfR91unoWdwYB+WTFq8/SFl/x71xzLeUA+nEoGBVwCw0TDV/ivEhLgEBm5figP3j/d7YUcR+O/vsAtn2d5C5A9XjEkexOvibxkqqXcUl2UWrDX3FwVy2eAjSGlY3EU3nDHJtba1u08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zxy8cGtW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e2de6496easo1702643a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728683046; x=1729287846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p/VK3ZfgElYZvlSjzEmYwYu25ZvAhjSSKI8JYiiP+Nw=;
        b=zxy8cGtWr3uWbG+UmK325GnkwYAa1QTodfKP+aYlpsKuXMiYPck4NXuU/7KNxgFPFq
         XZUsamD44HscLim8wyj6ODuR4Yb07D/2ugFQBY7cQ5SJ7FVjiCZw8aQB8V5GBcwZ5Nzs
         wDmQ18Atl8hlbEiiGUfEZFTPh+q3P/eI8HEv0xFy0qhrRCMLAzYnr+UTUwmyV4tRIhpF
         CElFhB0muLhVJUXH+X+wr7iZ42TN21NZR7zvl6QCPF/4jBgjWi0PnyXtZt7ksfrFiPyb
         jMSuou3koMdAMLPx6xWzbSWMmgfYNHZznh00qV9LWH4dZ5Mw9ydxBOBS6MMbOPMHQMjG
         KyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728683046; x=1729287846;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/VK3ZfgElYZvlSjzEmYwYu25ZvAhjSSKI8JYiiP+Nw=;
        b=PE5XhOSdOxWB39QKSWcCy7rCcTZPZlic3C3T6aiixNHC86nE24G/cBXK/ceaxWSJGW
         TsH3jyD/fN8KTpPDOhaO6ZC42DRP8k/pjnjXR/Su1/na8zMIBXLQBdAgdQf+KDTQSLSx
         jY4PJU1wZixKA9ElrBMcXhsNqxuirYGlAtYELxTKGwNH1baJf2OACqOkYkaxCaqju8uc
         REmol9VMP+V4YyBMwBryT8WZLEMQxJ/4Yq6kTiykUTX0voG3b7ueE2YHzoSxG+gcEOjS
         OXz5YXsr7PNj3KP1F3Vd00tQzn7Qg1waCVGlRNZNecgLfW5JUqI8Ip0lE+Au9nHVpqsw
         vTbA==
X-Forwarded-Encrypted: i=1; AJvYcCWJDXdEsOFb6psVeHVviuqDdZ9LRiojwWZzF9OX0+0WCnxm01ioFYkbg+Pxxe2pa4tH50d+aqx8Jx553Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmcS6T3gdS+q5XdFFED3BsxAlchyRMvIpiqvlIJfMMrR08QQgd
	Nw7Vhy++zRDOvVaKlvwffUr1VsriOLS80moqNxptu4mBQTwNmrb/kaHCbBc+f6eooVM6H3AWVsD
	wXGU2zlkjyQ==
X-Google-Smtp-Source: AGHT+IGJsPr4hCQb4coiPXkuMY9sZ3MF8ZOV10AcmHOfAQjQx8qT1FpU0cYNsudkCc+q1mrwx7cCJDN2XjCsIQ==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:f3:525d:ac13:60e1])
 (user=jmattson job=sendgmr) by 2002:a17:90b:3109:b0:2e2:9984:802b with SMTP
 id 98e67ed59e1d1-2e2c81bd68cmr13436a91.3.1728683045747; Fri, 11 Oct 2024
 14:44:05 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:43:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011214353.1625057-1-jmattson@google.com>
Subject: [PATCH v5 0/4] Distinguish between variants of IBPB
From: Jim Mattson <jmattson@google.com>
To: kvm@vger.kernel.org
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	jpoimboe@kernel.org, kai.huang@intel.com, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com, 
	sandipan.das@amd.com, seanjc@google.com, tglx@linutronix.de, x86@kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Prior to Zen4, AMD's IBPB did not flush the RAS (or, in Intel
terminology, the RSB). Hence, the older version of AMD's IBPB was not
equivalent to Intel's IBPB. However, KVM has been treating them as
equivalent, synthesizing Intel's CPUID.(EAX=7,ECX=0):EDX[bit 26] on any
platform that supports the synthetic features X86_FEATURE_IBPB and
X86_FEATURE_IBRS.

Equivalence also requires a previously ignored feature on the AMD side,
CPUID Fn8000_0008_EBX[IBPB_RET], which is enumerated on Zen4.

v5: Restored the first commit, which was unintentionally dropped in v4.
    Added Tom Lendacky's and Thomas Gleixner's Reviewed-by to the two
    commits that have not changed since v3.

v4: Added "guaranteed" to X86_FEATURE_IBPB comment [Pawan]
    Changed logic for deducing AMD IBPB features from Intel IBPB features
    in kvm_set_cpu_caps [Tom]
    Intel CPUs that suffer from PBRSB can't claim AMD_IBPB_RET [myself]

v3: Pass through IBPB_RET from hardware to userspace. [Tom]
    Derive AMD_IBPB from X86_FEATURE_SPEC_CTRL rather than
    X86_FEATURE_IBPB. [Tom]
    Clarify semantics of X86_FEATURE_IBPB.

v2: Use IBPB_RET to identify semantic equality. [Venkatesh]


Jim Mattson (4):
  x86/cpufeatures: Clarify semantics of X86_FEATURE_IBPB
  x86/cpufeatures: Define X86_FEATURE_AMD_IBPB_RET
  KVM: x86: Advertise AMD_IBPB_RET to userspace
  KVM: x86: AMD's IBPB is not equivalent to Intel's IBPB

 arch/x86/include/asm/cpufeatures.h |  3 ++-
 arch/x86/kvm/cpuid.c               | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog


