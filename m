Return-Path: <linux-kernel+bounces-538875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A75A49E29
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B4A7A5311
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5952F26F444;
	Fri, 28 Feb 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAu/AAcq"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655ED1EF395
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758281; cv=none; b=Fzio1QlFFtH1RmE4OK/63C87WRQbr8ZYOGc9RyjDwUIYRJTnY3Maim6s7Ap8lpApiLggesQqSHlcFuhUMyIQ/TS+OwzekWkEIJmCOMK1KwQN8+afx1abGYd/mzKrvAxU+lI696ptkrEPtIK/K9yLb3lqgOG/rP7STFZZuUhgRUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758281; c=relaxed/simple;
	bh=46QJyNf/h0jl6IQM2AffUp4t4PIW65RyPpRbFPSJ8mY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SKxIDZWIcYBJiLssZ8TBXkJVz/FfdDk/1uXYh3YUGvvpcoejA82nLshrPDSdqWKIRkaZMTtQ/sP+K5mx0LC93mFQWGfwFXyxyycWC6uUHRKikYDuS74P7ZMNoyk0VLof4RU1WDpjIFZHbyHuSf2sYf48u6XblmqDW+F6tsaaG7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAu/AAcq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-223725aa321so13515495ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740758279; x=1741363079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=grn6WoNOcZTWapnWRBhweFsDMgoAQip6WUiv20kXU6M=;
        b=oAu/AAcqJ06apVSGMu+gJKI8nbxyAAGOgQhrfXM5ES7hGKfpYHxGxyxvVTdrkPv6da
         Yy0XsRRmVlMMRzJhqXBhEsUKiS/AOD0JlozBuEjex9bIa7ueO779iKoiHxL1tZfbhg4S
         zgF77DdESi/PIaPtRLxUBl2OPWveTQ9rxzGZgaFSWr+jh5xXIfm07wDaLVjKLFqSIi1b
         bBI9rxW9xIil2v/4fwHY2KHOQOnf52svDeakDqchILFFV/WYdKZc2L/hq9ZbTo64J4mh
         giDrLQO5dwH9jKoPyxHqW9iICw1eEgHo4WnHgN4PlG+QVgsqTyWt+ownxgiQl7fo5HL0
         4X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740758279; x=1741363079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grn6WoNOcZTWapnWRBhweFsDMgoAQip6WUiv20kXU6M=;
        b=UgabkBpRDlhTb1/Sfz2lXBdWVOKaU1V6yzDKNADtkcMJPmvjm+gVWac6nbXcwjzk9R
         ATJw/CUCxw2yBgoGRH8S5CGTdroQDuirkZotlJLPyR0VoL/cwtx73s/RVDIpYVIQE3fj
         ziX8uPCotN/+O3EdnSkL15iIyg1yIEZvIZVfPMyosnwplsAi4RQ5b2UlnUsB2T60ZpOi
         x6/VLUH8NsalDLnDc78g5SA+FAvF0597vy1LZiU9/yv1b3vqwS97dgaILLNrCjQGiMHA
         HjjpKietou651yypKrV8qvY3IW7X5QTbWnW8SOeomVz8em+RAW4HZZhLe0Yz05xGBncT
         jBBA==
X-Forwarded-Encrypted: i=1; AJvYcCX5S0Cy6J7z/yiHuh2fy8wPWS+xZFOo5i3CRGjT6bYUl935dzKujVt+tr4bHUVdYMQG2N64lkAlsoWJXkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywda+3yCYY5s/vcK8ZaDNa/kGRpncOcOl/k2vgrKUbEdG8+YYCO
	ttJeV0ZrH7iHw7zsMG0fWOT1kl0ZIXrUh8bvvjdTtEWYMFhLpTJ/vEbiEUVQHeyTdZMf7aPclfx
	4Qw==
X-Google-Smtp-Source: AGHT+IFyoMK9paeAoZ8a0nmluti4gJF76RjUZ7PnqmrfBEpGEPqj01dwn+FBrEpsx2F/fil7939ghTgm6nE=
X-Received: from pfmv7.prod.google.com ([2002:a62:a507:0:b0:736:2d84:1570])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e11:b0:730:8768:76d1
 with SMTP id d2e1a72fcca58-734ac3d443emr7245342b3a.19.1740758279615; Fri, 28
 Feb 2025 07:57:59 -0800 (PST)
Date: Fri, 28 Feb 2025 07:57:58 -0800
In-Reply-To: <75e45ec0-25da-45c5-827c-ee048c0ebd86@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <7c2baf33265444089ab780848de29a1336a9a4cc.camel@surriel.com>
 <20250225203803.GGZ74qK1oZWk8u69O4@fat_crate.local> <20250225210300.GHZ74wBP2ogmM5P5lP@fat_crate.local>
 <680053d3-4cf9-534a-1c52-c6e259b85452@amd.com> <297b28e9ef9f4cd983ae2e3dd4cf1fce8b74d0f1.camel@surriel.com>
 <059ba03a-a892-6a68-6000-c7db3dd6cf9c@amd.com> <9086371cfe69760780d67ec279f69e91f65086a7.camel@surriel.com>
 <2731f073-d529-7870-6d25-ebd2e44cd10c@amd.com> <c6a38a1b6f27ae787dbfd99df225f464c274590e.camel@surriel.com>
 <75e45ec0-25da-45c5-827c-ee048c0ebd86@amd.com>
Message-ID: <Z8HdBg3wj8M7a4ts@google.com>
Subject: Re: [PATCH v13 06/14] x86/mm: use broadcast TLB flushing for page
 reclaim TLB flushing
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, 
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com, nadav.amit@gmail.com, 
	kernel-team@meta.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	jackmanb@google.com, jannh@google.com, mhklinux@outlook.com, 
	andrew.cooper3@citrix.com, Manali.Shukla@amd.com, mingo@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 28, 2025, Tom Lendacky wrote:
> On 2/27/25 19:13, Rik van Riel wrote:
> > On Wed, 2025-02-26 at 12:12 -0600, Tom Lendacky wrote:
> >>
> >> As long as you keep the ASID value in EDX[15:0] as 0, then you won't
> >> #GP. ASID 0 is the host/hypervisor. An ASID > 0 belongs to a guest.
> >>
> > I've been spending some time reading the KVM code,
> > and I don't think invlpgb would be currently useful
> > with KVM.
> > 
> > From reading pre_svm_run(), new_asid(), and svm_vcpu_run(),
> > it looks like the ASID number used might be different for
> > each VCPU, assigned on a per (physical host) CPU basis.
> > 
> > It would take some surgery to change that around.
> > 
> > Some googling around also suggests that the ASID address
> > space is even more limited than the PCID address space :(

KVM's mess of ASID handling isn't due to space limitations, it's because early
AMD hardware didn't support a targeted ASID flush.  To avoid flushing the entire
TLB, KVM fudged around lack of precise flushing by using a new ASID.  Under the
hood, hardware uses the new ASID so the previous entries are effectively"flushed",
and will eventually be flushed for real once their evicted due to TLB pressure.

Irrespective of INVLPGB support, I am all in favor of ripping out the ASID
shenanigans in favor of static, per-VM ASIDs for all VM types.  For CPUs that
don't support FLUSHBYASID, KVM can simply blast TLB_CONTROL_FLUSH_ALL_ASID.

FLUSHBYASID was added ~15 years ago.  If someone is still running hardware that's
that old, they can't possibly care about performance.

That would meaningfuly simplify KVM code, likely be a performance win on modern
hardware, and gives us direct line of sight to using INVLPGB (assuming it's a
performance win).
 
> Right, to support using INVLPGB in guests you need a global ASID, 

I'm pretty sure Rik is talking about using INVLPGB in the _host_, e.g. by doing
INVLPGB in kvm_arch_flush_remote_tlbs() instead of blasing an IPI to all vCPUs.

