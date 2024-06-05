Return-Path: <linux-kernel+bounces-202754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C87CB8FD06B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F03428C4FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBDE1D6A5;
	Wed,  5 Jun 2024 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jR5JlSHx"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B7417BBF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596410; cv=none; b=AcSWyeZFWYqOwINTki33NTTfrU2lL/ghRO20hXbo1YdU0NrSVAXZaZcESMcDja3hH5rYP+TfDBRn8EnUA+V7aqjx+TceDUFgCMGhRlfjTjfiIcy/og3GiBPBDOqtYNbdOba3cRZNWuanxaQpaxD0h3cKfbrCD8dhDIvuWXCMdSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596410; c=relaxed/simple;
	bh=RLigTN6QlgfnN8MmaEOoLfcZ90fDVBpjgvMkiBaFCMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ev/0BDtBKjYDtbPKlaTDww53TBuZwJiZXH57blAUGScsOpBqFQImfXA162vPRvizEysNR/HU1w006BzJth6KtcApAhzCjliPy9ULEwNFYG9oeDxp7TAsWCf9Nb/Lps5EgfcSFGIL9Xa45fv77bcdhh/2kwEQlD4okBxzzXeotu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jR5JlSHx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627f20cff42so114353587b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717596407; x=1718201207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BL138jN66e7d4oRS9LVO/0u1phYBQ+x8xQzsbL5QTlo=;
        b=jR5JlSHxwJBVnwKlYd2q3dAIa5VvoPsvGkmI7dq5336WqvGRPa64jtwoiKusLudxNJ
         wRo6BlVYYk/5rzubjsIrmZXk9ewEG5JJ8BCTLVgJyzNQVlxLFVx/Akc4vA8p8Scjkqje
         puvdvN1viiVX/5foJxJ/sxvUZJJBJfd0JjxM0U77CePNn9PXsNeYLXejZdc6FQWJXThA
         84V7lPg0nLvtcwdAv7S1eSLnmZgdT+BP/cKPuKUfXA4IbPibkh+ajfitxR1t0Mk9KKBb
         Oty/o87QsZbZiWrjRlx/5FMzvMkOP3s1ZAOVenNUNnCYIK+pDB1DRFHCMXxiIyTPrsca
         Nj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717596407; x=1718201207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BL138jN66e7d4oRS9LVO/0u1phYBQ+x8xQzsbL5QTlo=;
        b=G6hzd1bzazVnXDJsStv59DyeVw9EEOy3xkkAy+Tvs1ZOhcW2HtBnc4r2vXWyfOEJoy
         7j/+CYvJhrxgCTs4IaOVVj6DdByEAH29FU2GoFS9NuAIXpYg5B9OVB+LLVf/ZGiKXgam
         xUMUkyAeZbswlgupdUHeSm+yY+9yYGjZX8vX/T5/roS1omkkSHVNXuRegBhEHyPOwFCW
         wl1mpP0cS9rYB5viHicZI6wKZL0bBY0lLHN3nUVeW/vBqQwwitx+chkVQWsjIxqLMda7
         cg5SgzIe/cjKzyd8Nxc7/I6QXhqoueI6fBCLwDztie16weeIIRpe7Y964ny1AdvXSfI9
         bWXA==
X-Forwarded-Encrypted: i=1; AJvYcCU+/dXhbsWu+XBBh7ylb6amTSqDoXvR3IF2H+teF391BNcQyTGWFgIJxGMMDxH0lMJAzTihWmR/4j1vpTb56LQ24Fuo6Tw7w/6OhzbL
X-Gm-Message-State: AOJu0YwOt2Uwroy4ZhHdL27QwyzCJb+Y/rN7cZm3ytkGJQSw3By0IbpX
	+x4fHSLXV0fFIbt/a8l15LPGi4c7c5qmt9iFayD0twd5WCMsCX4COg+f3kw487hc3B11Vj3/gpu
	ROw==
X-Google-Smtp-Source: AGHT+IG1hc4iMUkWuc2pTjAvNhhnxyv7afMIRBSIBUolkARKLQQrvnWjgIFzBdhrmfAcjl+qpvy1b4ZNUi0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2991:b0:dfa:4b20:bdaf with SMTP id
 3f1490d57ef6-dfacad0f465mr254997276.13.1717596407332; Wed, 05 Jun 2024
 07:06:47 -0700 (PDT)
Date: Wed, 5 Jun 2024 07:06:45 -0700
In-Reply-To: <171754361450.2780320.9936421038178572773.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1714081725.git.reinette.chatre@intel.com> <171754361450.2780320.9936421038178572773.b4-ty@google.com>
Message-ID: <ZmBw9R_jkNLYXkJh@google.com>
Subject: Re: [PATCH V5 0/4] KVM: x86: Make bus clock frequency for vAPIC timer configurable
From: Sean Christopherson <seanjc@google.com>
To: isaku.yamahata@intel.com, pbonzini@redhat.com, erdemaktas@google.com, 
	vkuznets@redhat.com, vannapurve@google.com, jmattson@google.com, 
	mlevitsk@redhat.com, xiaoyao.li@intel.com, chao.gao@intel.com, 
	rick.p.edgecombe@intel.com, Reinette Chatre <reinette.chatre@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 04, 2024, Sean Christopherson wrote:
> On Thu, 25 Apr 2024 15:06:58 -0700, Reinette Chatre wrote:
> > Changes from v4:
> > - v4: https://lore.kernel.org/lkml/cover.1711035400.git.reinette.chatre@intel.com/
> > - Rename capability from KVM_CAP_X86_APIC_BUS_FREQUENCY to
> >   KVM_CAP_X86_APIC_BUS_CYCLES_NS. (Xiaoyao Li).
> > - Include "Testing" section in cover letter.
> > - Add Rick's Reviewed-by tags.
> > - Rebased on latest of "next" branch of https://github.com/kvm-x86/linux.git
> > 
> > [...]
> 
> Applied the KVM changes to kvm-x86 misc (I'm feeling lucky).  Please prioritize
> refreshing the selftests patch, I'd like to get it applied sooner than later
> for obvious reasons (I'm not feeling _that_ lucky).
> 
> [1/4] KVM: x86: hyper-v: Calculate APIC bus frequency for Hyper-V
>       https://github.com/kvm-x86/linux/commit/41c7b1bb656c
> [2/4] KVM: x86: Make nsec per APIC bus cycle a VM variable
>       https://github.com/kvm-x86/linux/commit/01de6ce03b1e
> [3/4] KVM: x86: Add a capability to configure bus frequency for APIC timer
>       https://github.com/kvm-x86/linux/commit/937296fd3deb
> [4/4] KVM: selftests: Add test for configure of x86 APIC bus frequency
>       (not applied)

FYI, the hashes changed as I had to drop an unrelated commit.

[1/3] KVM: x86: hyper-v: Calculate APIC bus frequency for Hyper-V
      https://github.com/kvm-x86/linux/commit/f9e1cbf1805e
[2/3] KVM: x86: Make nanoseconds per APIC bus cycle a VM variable
      https://github.com/kvm-x86/linux/commit/b460256b162d
[3/3] KVM: x86: Add a capability to configure bus frequency for APIC timer
      https://github.com/kvm-x86/linux/commit/6fef518594bc

