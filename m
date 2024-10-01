Return-Path: <linux-kernel+bounces-344947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D634298B071
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149611C2287F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C07B188CC6;
	Mon, 30 Sep 2024 22:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3Hxchp/"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009041836FA
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736509; cv=none; b=hxFhAp3dsr8TiPXxUvUhu38qniWv5X2Fdes7Maqk8IMMy0LSNjyggV8IPISTJOpVm4Myybuawmr8Fit/sU6iw5JAYnHBXrSXxsv35OqAIVm2ly14DtFecF1vAVespl2jG0YNsrC6vaJF8j3KBeB9LBzUFsp1Ub/udb/Xp1raeE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736509; c=relaxed/simple;
	bh=S2Z1JwX1MU6DLUEoEGwV8nRjiTHOC576ZcrLMcIfVj0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TtXR1T34HM5oU3ztoXnoowD7azjdVJnTPQa571O0svHBIOaZbnuKXfVrB7BraowD+v+1Hhb8aqc9omvaP0eu6Nm0NH8FL1LRcOAY/NM6GJDEAQC5GecB+l/CTfM9vBXwwCWWzD/Sg7/hUm7tqzS2Of9O8aGmJs2EGbCQ80Anxb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3Hxchp/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-718e2da2e33so5291134b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727736507; x=1728341307; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XEKROrbsF+Qc32qai9a0qLWUFdx11pYvvS7Yvup4cZY=;
        b=q3Hxchp/yabyxR8sxLQ1wvjZw517OcZbIWReUFnDvyUcy7BUyUG4zzkDmY+F+3dxpB
         7x0yn0O1947629aF5TokYUSfDHSgUApASANI8eJ03DGVVeDL2LIcfHK/IpCcEEfS8O5W
         s++R3uCDarrmtxA3QNH3rIVQ7k1nmFmsvIsKvzWotM0L6LDCT0YR5+C1/ib8eygDygDv
         Sst//R5WZniDZ/Dcw0PZOsxpavQLlomIUwmMsKMm68pxecAzIlzZ6YsSOwZpW+Wugy+5
         Gt/jBFB4RWvXzUXgYrYAU5MTHR4zDr9wt1XoT9CjcyASrj9gtMp6B5cLmF5hISVPywy4
         eoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736507; x=1728341307;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEKROrbsF+Qc32qai9a0qLWUFdx11pYvvS7Yvup4cZY=;
        b=aux+ApL6d3xCtfwxGGYld4WMLyHUE4sJhsu6fzVkz3+S8WCHjoSZ6VX9blprQLItUr
         U/wXjFF0jrRD7lUVbsV45tKDx3oY7OFJ4owJMgrU7+VrqMyw9vPVLGC1Pbqcj2ZFvRh4
         WiPYZKay0hovEK2QVhiCThtY7amSYCDugXfsDY9ychrP5IX4doOCSMtkGL/mbzCQ/tLM
         7ZKudtuE/+wASuZWviHwYCJC+s9irX+dlHZjU2XyJjTj/E1wN3DVZ6srDQ3tdiGlI0Gi
         EhWYToq0PlF9IvnJKpX5ciSrEZ5K4CbpRgH3vesq4OZdEpxs6fbzFrTLCgblc4eQVlhL
         UMLw==
X-Forwarded-Encrypted: i=1; AJvYcCXrcHulZZLTMdFtMd64rNSG92znvyVazRjdy9bvnaikOApF/+GtexqcmbLyes0uOi7bJkc90dVJdXvIIiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUOT7w8rfCye6QwR3TGZ8gwd3nsmJEDAr+ndVET50Rl8BDDvVb
	hiIrBSEnh4KTziFAuWGaVQ7GEa71K/vZY6TIrcsWmCA4WPsl/7yZmuhgU0zEknCgwPUzgZCo3hJ
	3PQ==
X-Google-Smtp-Source: AGHT+IFBqE4b3ETKHUb3GkTpAmeIZlaPPTKak751rxnBHWeoFOgyWmnqPX8beCCGnb8n0RirfB1L8PS0CMc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:83ca:0:b0:718:d8af:4551 with SMTP id
 d2e1a72fcca58-71b25f2ca30mr23827b3a.1.1727736507148; Mon, 30 Sep 2024
 15:48:27 -0700 (PDT)
Date: Mon, 30 Sep 2024 15:48:25 -0700
In-Reply-To: <ZvseoZLzmaS4MEbc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911204158.2034295-1-seanjc@google.com> <20240911204158.2034295-4-seanjc@google.com>
 <ZvseoZLzmaS4MEbc@google.com>
Message-ID: <Zvsquaq-Lo4umoTI@google.com>
Subject: Re: [PATCH v2 03/13] KVM: selftests: Fudge around an apparent gcc bug
 in arm64's PMU test
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 30, 2024, Sean Christopherson wrote:
> On Wed, Sep 11, 2024, Sean Christopherson wrote:
> > Use u64_replace_bits() instead of u64p_replace_bits() to set PMCR.N in
> > arm64's vPMU counter access test to fudge around what appears to be a gcc
> > bug.  With the recent change to have vcpu_get_reg() return a value in lieu
> > of an out-param, some versions of gcc completely ignore the operation
> > performed by set_pmcr_n(), i.e. ignore the output param.
> 
> Filed a gcc bug: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=116912
> 
> I'll report back if anything interesting comes out of that bug.

Well, there goes several hours that I'll never get back.  Selftests are compiled
with -O2, which enables strict-aliasing optimizations, and "unsigned long" and
"unsigned long long" technically don't alias despite being the same size on 64-bit
builds, so the compiler is allowed to optimize away the load.  *sigh*

I'll replace this with a patch to disable strict-aliasing, which the kernel has
done since forever (literally predates git).  Grr.

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 48d32c5aa3eb..a6f92129bb02 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -235,10 +235,10 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
        -Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT \
        -fno-builtin-memcmp -fno-builtin-memcpy \
        -fno-builtin-memset -fno-builtin-strnlen \
-       -fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
-       -I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
-       -I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. $(EXTRA_CFLAGS) \
-       $(KHDR_INCLUDES)
+       -fno-stack-protector -fno-PIE -fno-strict-aliasing \
+       -I$(LINUX_TOOL_INCLUDE) -I$(LINUX_TOOL_ARCH_INCLUDE) \
+       -I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(ARCH_DIR) \
+       -I ../rseq -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)

