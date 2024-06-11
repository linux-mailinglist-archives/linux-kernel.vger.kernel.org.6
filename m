Return-Path: <linux-kernel+bounces-210253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5205904161
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F81B268BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955FB3F9F9;
	Tue, 11 Jun 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLd0phHN"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81338FA0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123576; cv=none; b=NbQcTcmDihoG8EYFvstEJw2MD/WemNhzPmpdMyvDDxVmvgbYDxSs5mjwPIhNmmnQS0YC8fcIjnR9WLeke4afWuTGwC58rAkMkAweYNm/mik1efRNFJJmaX8CbqtO5DTHsrCitAhp782USlQ+W/7MGn/PBS3eMGs5bg0jmiR//YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123576; c=relaxed/simple;
	bh=PfL/6AgJasVkbCS8dVXqo5yRf1/3Wobmr0iuiQOC/Dg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IbIqyjiLKqWbTTYGecWM1AuB0Ittb2Te0CF6qf//fZP510L4wsFJ+0ZSPde4qXdLW46P9sygzq6b3P+rMD3oxsk8UxDZ0w8KKs9zsLdSHsZiQASYpQ0EmuT1nxzqWihKb+hA7al/lyn28gnUNA9xz8EoOVQ83LezOTc2J++hr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLd0phHN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c380e03048so868784a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718123575; x=1718728375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c4xBvCLscNy4YUa29ei3FsIjxDWpzTmRoOerBpLD1P4=;
        b=qLd0phHNv1lZYJU+KCPtfLnW27S9VcZvh31IhDtCElrYfr19En09w3FgB1w6szsVH+
         uIFNIXIlrNpoVVQgI+L7PueLBrF3EcECmsqY+VM6qTL4N9N0aq//FFRndn/bD+fJ2Wx3
         aq5M6Ba1kmyaU3jRg5hVsx3CqEbJKYPY/2QRmaxMHqeml1PIkBh8s3IGb/oDBxgDRkSv
         Nr0Jx8FgDopvRVSBvjDRSp7L0yk5Y6NXlWJEN534WZB9G09JVCe8DtiHbz+XmrXxt4Us
         fU44963FMEBV0Zv4ZqD6nEzkgLZs11NxL05lj9+bxaXwEvz3CWGqwPDdsKRru7sUB9fZ
         /+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718123575; x=1718728375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4xBvCLscNy4YUa29ei3FsIjxDWpzTmRoOerBpLD1P4=;
        b=JfWug30N3QXl1JL67z9w5IxNUlUwfPkkR7K38z9A9GCzHCg4nPMWbzOVYc0g1E4tao
         U+QxG9Y1SXrwGl31Y6vXpKrtNYs+x9LoZyJGRPtlTRNEGcsd9iv30JaVfAD421uteyf5
         H6w31gL65744xboCnwus1PI/o/l2KYjTijUW8fOdxv1hrcuM2IngxwYUS/vMuzKN80tb
         UfkUG5wTYry1Wa+BVLEtBKHymvph9ig6GcA1BH2Cao+H+ELKnXLd/V2JJ69IePqA7+7l
         TYvohRqWk9ZkFjKLy9VXw4oU0GV0vmuuJ8Fko+0omqA5crKZSMQcyTndS6Blcw6qJ5c9
         rHSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/p45mtXFM9pdVEfblB54VpOLqf8CWEJvgMbPkm/foS2k5DdxSLmgUsA7mYhz2DoVkDGIl50QWtld7Tx7nCHudE2DE2lpnWYUveW4o
X-Gm-Message-State: AOJu0YyHcdH/nH1l75Dr6gfoySUgtWij43P30FQshh8z6ouePrXrOaQp
	8ls0YdKucRVEfP4p+dNJrEUsvnrBtgV0tY/Y1iVuHGg7ka9rN1zZG91e7bNKXOx1qVyGOxRAYrZ
	+5w==
X-Google-Smtp-Source: AGHT+IE50t/ZHsq1AIZB33K6XZDZtywKxE9M5cylfsZLOz1Oan4m5rBZ+Vk8rt4fL4gs+UygXTLU7vZVMGE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3342:0:b0:6f8:2594:7ca6 with SMTP id
 41be03b00d2f7-6f825947dbdmr3071a12.2.1718123574775; Tue, 11 Jun 2024 09:32:54
 -0700 (PDT)
Date: Tue, 11 Jun 2024 09:32:53 -0700
In-Reply-To: <ZmhaRr5Lr4pOHcm7@chao-email>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410143446.797262-1-chao.gao@intel.com> <20240410143446.797262-10-chao.gao@intel.com>
 <ZmepkZfLIvj_st5W@google.com> <ZmgrkMLuComwPl1X@chao-email>
 <ZmhSeZpyoYxACs-n@google.com> <ZmhaRr5Lr4pOHcm7@chao-email>
Message-ID: <Zmh8NSzd5xK-6urr@google.com>
Subject: Re: [RFC PATCH v3 09/10] KVM: VMX: Advertise MITI_CTRL_BHB_CLEAR_SEQ_S_SUPPORT
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daniel.sneddon@linux.intel.com, pawan.kumar.gupta@linux.intel.com, 
	Zhang Chen <chen.zhang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 11, 2024, Chao Gao wrote:
> On Tue, Jun 11, 2024 at 06:34:49AM -0700, Sean Christopherson wrote:
> >> As said, this requires some tweaks to KVM_CAP_FORCE_SPEC_CTRL, such as making
> >> the mask and shadow values adjustable and applicable on a per-vCPU basis. The
> >> tweaks are not necessarily for Intel-defined virtual MSRs; if there were other
> >> preferable interfaces, they could also benefit from these changes.
> >> 
> >> Any objections to these tweaks to KVM_CAP_FORCE_SPEC_CTRL?
> >
> >Why does KVM_CAP_FORCE_SPEC_CTRL need to be per-vCPU?  Won't the CPU bugs and
> >mitigations be system-wide / VM-wide?
> 
> Because spec_ctrl is per-vCPU and Intel-defined virtual MSRs are also per-vCPU.

I figured that was the answer, but part of me was hopeful :-)

> i.e., a guest __can__ configure different values to virtual MSRs on different
> vCPUs even though a sane guest won't do this. If KVM doesn't want to rule out
> the possibility of supporting Intel-defined virtual MSRs in userspace or any
> other per-vCPU interfaces, KVM_CAP_FORCE_SPEC_CTRL needs to be per-vCPU.
> 
> implementation-wise, being per-vCPU is simpler because, otherwise, once userspace
> adjusts the hardware mitigations to enforce, KVM needs to kick all vCPUs. This
> will add more complexity.

+1, I even typed up as much before reading this paragraph.

> And IMO, requiring guests to deploy same mitigations on vCPUs is an unnecessary
> limitation.

Yeah, I can see how it would make things weird for no good reason.
 
So yeah, if the only thing stopping us from letting userspace deal with the virtual
MSRs is converting to a vCPU-scoped ioctl(), then by all means, lets do that.

