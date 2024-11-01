Return-Path: <linux-kernel+bounces-392819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F499B987E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B65F4B216EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77641D0425;
	Fri,  1 Nov 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3C6c/Wg"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C581D0421
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489203; cv=none; b=tWjujZ8jRcWWPP73ILxbjCDnMgDyAdPgq/fJvlGleQgITdFRyfVCR5S+nWhhBpb63UuHkcxWY4TvfNy4fc91HURjhBGYzVb6LUrnTU1ppx4yrBZ5SjSyl+rafazlIJbKw0sd6ksM+aYF/nED2tscJeLqSvN93RW9m7IS7Pt62EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489203; c=relaxed/simple;
	bh=y9gMRmSgRhR2ZzgRFa1iVD1DWemELrWiDT0kiGYVqFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tuALVzc9eru2oJF3RDI/4VOPR/f1vn9soEPXaIXY7zHxB0tZxZDqKcpQ1xXOg1TMMdnDM44RhqMvCEp5cfBCfXKWVqEBML+sxz6KjV8MWPIh0aheaAztc1Aj06IzWURHZUHk40dKsYqsPVjGfErSbqV8e1A94OMMtOY4lBRR7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3C6c/Wg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e58e838d5so2854290b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730489201; x=1731094001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l6/SBlVL29Guf7OgbzpBZ87muPd4kGOblg4NhLF75g8=;
        b=Q3C6c/WgNh3t5T9LzHw29pJdc/AyHgJBeb0CKoQijvZi5YS1gyienTzLOonqLCCU4e
         PirkoOjUcKU42RV/XbySH2HkuhIcot7+y9vojPUCKwGs1E3MaLMNCe2z46Nb0fsRdeOC
         lAvLtDhNBnCLweUuCQFn305csdvtjkuQsZxh3YU7tsWzEw4Nb/OAsg9nvOZglAWs2ZKy
         MbZhduf3VszsOwJaAJit2Sm3NVdIs1cywBgr82thhWoUNIP/99Vp5A0k6J+Cr87YhEPq
         SLlQP0ZLMRPpcEMHooX2vcFqjtG9g5rYL1Uzq595gYTwkW7TBh4iqR03sVMKou1ft5KC
         HNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730489201; x=1731094001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l6/SBlVL29Guf7OgbzpBZ87muPd4kGOblg4NhLF75g8=;
        b=uBmLOnjbCdtOeWi+34ABcAmr5br4ixlp/wnAYbJmGiw4aXgwFO+Y0kECQLSqMjI9cs
         F5j0QcCf20Z5qU8E9veiYB37SZMSsOdz56oOkUsl4lmp5OGJ3XuDTMwu5qQXGizxyX2D
         OWFxWOTXZb6oPjeF4PCUm813QEnOiJ6VkN3ole2V0lmY9X2R3iH1wIrafLIISYGN1I5f
         KeKlA3UkwIcQNieYS76NVeXy4nwMJcYqJHi4YcOg4eFqJVV8YySxri1Al/T1Yr/vIcIw
         7EE+Sjd5tF0TPHuWtlWLGIW+SMt6Qe8C1io2ksHmuAKNOVWL/fWaRvkaO4Q1F5tv/2il
         E9Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUQR00hUkqdTWf0dH5x/3ESIBSrhiiVwEo1fMG+VB2p0QT8TFl0tHefavR67bI1W0qwvflSyj3VeTgva18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQO1rt+YfY3y4LnSx4fOS/vrS+jj7qw5i/V/U7U/qsK3DpFHj
	y9IbfvSB678zPFVxCYnRNy+F2AgqLfD12uXDXpDKsBTSvjthPMjJZyysXa0pSMpI9q6/I694750
	Ldw==
X-Google-Smtp-Source: AGHT+IFkhgtKHE81DUnfzmtMTNF6Rg9WpI+qnz+2pkM4Gl68lwQnDeSODf98f2ouigJe4+3xU4RiVhh5za0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a62:f20f:0:b0:71e:5dff:32dd with SMTP id
 d2e1a72fcca58-72062f04347mr39339b3a.2.1730489201065; Fri, 01 Nov 2024
 12:26:41 -0700 (PDT)
Date: Fri, 1 Nov 2024 12:26:39 -0700
In-Reply-To: <173039505425.1508775.86255062373291663.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240828232013.768446-1-seanjc@google.com> <173039505425.1508775.86255062373291663.b4-ty@google.com>
Message-ID: <ZyUrbykshu2YcrfR@google.com>
Subject: Re: [PATCH] KVM: x86: Ensure vcpu->mode is loaded from memory in kvm_vcpu_exit_request()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 31, 2024, Sean Christopherson wrote:
> On Wed, 28 Aug 2024 16:20:13 -0700, Sean Christopherson wrote:
> > Wrap kvm_vcpu_exit_request()'s load of vcpu->mode with READ_ONCE() to
> > ensure the variable is re-loaded from memory, as there is no guarantee the
> > caller provides the necessary annotations to ensure KVM sees a fresh value,
> > e.g. the VM-Exit fastpath could theoretically reuse the pre-VM-Enter value.
> 
> Applied to kvm-x86 misc, thanks!
> 
> [1/1] KVM: x86: Ensure vcpu->mode is loaded from memory in kvm_vcpu_exit_request()
>       https://github.com/kvm-x86/linux/commit/ba50bb4a9fb5

FYI, I rebased misc to v6.12-rc5, as patches in another series had already been
taken through the tip tree.  New hash:

[1/1] KVM: x86: Ensure vcpu->mode is loaded from memory in kvm_vcpu_exit_request()
      https://github.com/kvm-x86/linux/commit/3ffe874ea3eb

