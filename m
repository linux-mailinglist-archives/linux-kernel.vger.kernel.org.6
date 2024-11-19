Return-Path: <linux-kernel+bounces-414984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661BF9D3013
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 22:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8248EB228A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCABF1D3584;
	Tue, 19 Nov 2024 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vrzZRZs0"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BCF195F28
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732052131; cv=none; b=NnU50cR3HR6aLtpOypyWBHOO3205o+8bDZJVS6Acy/6NwhDtUiYisF415ZZsFElOwPtmI0PCfHTbNAw8rxwkcISmRNnEwz5hS/l9WtAf5fjE2X4L7rNtjgomWow+Yo+VZgEWra04XOq/ZHxXc/S8GtIZKu9hfoZJub9g1CFyJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732052131; c=relaxed/simple;
	bh=iTE59sMKehdeOyAF9A2SZ+XvVSs3LcZxIciJ4n0Ptt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I72f67X4X9F67nw5ObPYg+/WIwcivzCI+oiO1/J+kksnl5p2BDk1NeFha/WBkWZwMRVrLob3/nJVkoZw1Wrwk1hMOq4J8mLfn1kI/MS3JQr5IP4H6n8HKuob5R9REZUNHY1573SS1v/Wsngic5Hmt7HDbI0LRrXZIWDHw8pW3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vrzZRZs0; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Nov 2024 13:35:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732052122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msslIht/iC0IbFIqTr4umsTJ8qtKXXVBD4kyKHKb3yA=;
	b=vrzZRZs09+uGcg4Qbq52l5KbuKrQjgo/QIvW6pK2oZ8B4GL5xmD1sRQ/qG1Cv2xe9NcDla
	25S7ZBxSpPEjkOuYVqpiV6m5xlvT3aF4zbfPG/YJYSX2t4lwMo25q5MBzrQiNasVE5FXIC
	eyc4/0kq/uTazmKRbIA5nxZpM55GWDg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Ignore PMCNTENSET_EL0 while checking for
 overflow status
Message-ID: <Zz0EjiFMTiHWeq8h@linux.dev>
References: <20241119205841.268247-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119205841.268247-1-rananta@google.com>
X-Migadu-Flow: FLOW_OUT

Hi Raghu,

Thanks for finding this!

On Tue, Nov 19, 2024 at 08:58:41PM +0000, Raghavendra Rao Ananta wrote:
> kvm_pmu_overflow_status() currently checks if the PMCs are enabled for
> evaluating the PMU overflow condition. However, ARM ARM D13.1.1 states
> that a global enable control (PMCR.E), PMOVSSET<n>, and PMINTENSET<n>
> are sufficent to consider that the overflow condition is met. Hence,
> ignore the check for PMCNTENSET<n>.

It's more than sufficient, evaluating E, PMOVSSET<n>, and PMINTENSET<n>
is the *only* correct implementation of the architecture.

Also, ARM ARM section numbering is subject to change between revisions,
so it's always best to use a fully-qualified citation, like 'DDI0487K
D13.1.1'.

So I may rewrite this as:

  DDI0487K D13.1.1 describes the PMU overflow condition, which evaluates
  to true if any counter's global enable (PMCR_EL0.E), overflow flag
  (PMOVSSET_EL0[n]), and interrupt enable (PMINTENSET_EL1[n]) are all 1.
  Of note, this does not require a counter to be enabled (i.e.
  PMCNTENSET_EL0[n] = 1) to generate an overflow.

  Align kvm_pmu_overflow_status() with the reality of the architecture
  and stop using PMCNTENSET_EL0 as part of the overflow condition.

We've got yet another bug lurking here as of 6.13, since the hypervisor
range of counters isn't observing the correct global enable
(MDCR_EL2.HPME).

Let me fiddle with this and send out a combined set of fixes.

> The bug was discovered while running the SBSA PMU test, which only sets
> PMCR.E, PMOVSSET<0>, PMINTENSET<0>, and expects an overflow interrupt.
> 

We should be sending this to stable too.

Cc: stable@vger.kernel.org
Fixes: 76d883c4e640 ("arm64: KVM: Add access handler for PMOVSSET and PMOVSCLR register")

-- 
Thanks,
Oliver

