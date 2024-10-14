Return-Path: <linux-kernel+bounces-364828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5E299D9EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 278E1B21619
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FC71D95B5;
	Mon, 14 Oct 2024 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYBcK0R0"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214C815575E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728946744; cv=none; b=HK3hQ3rmXvoUF0+NgMsLK290eLniVh7IFW9WgD5LLO3XZPtfzXUIIvOlagTmP9zY83nq+2zJY/VCvY5ZZXDELAc3zQpy2ynXXwjoeJwhcb9/b877kplhsUhp3IEHRCxkWE0vJNtflT8qwMP0VmSqIkGIxOxDPtuigBJVfD9JR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728946744; c=relaxed/simple;
	bh=IYIMs+Vb5pHawT/UbRBAdNS7wptXzhLpkWOqqdo427E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IsPXQ2wmjiN4sMgeWRwDKQzSI32sooIWdmDeU1ssR3KlCh6X3v/bBIQnmTzSXgWB/3AN2VvTIewFatoasL2o4Ip/SuKJWiYd4AV6VNvuGxxDYr3KOTQgxtEyxW48U8WNlfnmK/TcKraY7zf2YtkFLiZhbVANtNgiYPlZB/Vqb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYBcK0R0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3705b2883so28179597b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728946741; x=1729551541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v2ddKs4pr/oGDZNGpWz3RN/6TEGuqxNwNVJKN0VyWtY=;
        b=GYBcK0R0G6XzCwXYj5YPHptnmF6JQNP9UnqNevWxFft2kMxcznMakkHFRrsJekgzpa
         fISwzAcFvOevKrcTCYMY9eTV2iKljHeup/n/VDyGtHQS3liImjDRo6JNvQ3ap7zJIn9B
         zI+PPLQgEjfCJPXGBUomgzcnJ5B6guN+Sj+C4N6YSnetG3ha4vHZtL68+YTvK2oCCe/Y
         xSdkKxDB3M3XQhkGdMt/VXkJvZ7dL0d5LnoqQ6ClfHwfGugrryoeT95tnjHj0ILjizeK
         GWpF4BcB2HLEhCsuZmgeovughaMtcTJVw/ItVPl0E502TH9INbdm0sCQpjixwSnIOAqi
         D8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728946741; x=1729551541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2ddKs4pr/oGDZNGpWz3RN/6TEGuqxNwNVJKN0VyWtY=;
        b=HWGwBdqvh3L/IMT9K3jKYvMekNJJDjf14+dmz+OiH7plU65ZbCV4SRHvFaWfaiyUBp
         ClxRYOEez8/Px53GSa80HuOiZ6NnKYisBRhtp74SpuUM4kCSGJo/rfCQR/qGexsa+ZpM
         8jkpeDDQ4Irmf5UzMP48GarX6/w4SarOk5d6ncxdGa8YwbF07CmDRXZxIAojhlHip4Ju
         E1przS3N1y0mFmPS1n4ik9wY42LJtkZxgN7ns11sTeJtr9rqkz2Zp3quwKG9zegRUtEc
         fQ6LcJcBbLijWcPGTstOwHW4VxSGvCxZWND5cGKBVmJ/dJhgphV6jQQDBHli6nGPjqnk
         EDrA==
X-Forwarded-Encrypted: i=1; AJvYcCXxMdv9UT+MmB013Z5/t9LFRozTHuwswJhtt+qjBVzyuFjw03vl/78El3+Uzjn6Wcn6GZkYck5aL/14Cyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbEkAI84fCwvlrdXWbdMxzvocvq+m65Zw+AJXKn+Zlswqdsx8K
	lMhnYzopTvvvPaB0qtw947IMfapoh+MIAcYpuKMPKIdWOulU12L+7QWsLIW/4qy4Uf6G+lzNGp8
	81Q==
X-Google-Smtp-Source: AGHT+IGpLsSiK/rKJNShVTkYFCgu2dMnbIWSrYdXBymaWQf2b5qLxnWcy4A3vb9cmXQqHQtjEByeOIcpWAQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:5c07:b0:6e3:189a:ad66 with SMTP id
 00721157ae682-6e347c52ab6mr917617b3.5.1728946741156; Mon, 14 Oct 2024
 15:59:01 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:58:59 -0700
In-Reply-To: <20240905124107.6954-8-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com> <20240905124107.6954-8-pratikrajesh.sampat@amd.com>
Message-ID: <Zw2iM0tVmwy-8nPe@google.com>
Subject: Re: [PATCH v3 7/9] KVM: selftests: Add interface to manually flag
 protected/encrypted ranges
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, pgonda@google.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 05, 2024, Pratik R. Sampat wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> For SEV and SNP, currently __vm_phy_pages_alloc() handles setting the
> region->protected_phy_pages bitmap to mark that the region needs to be
> encrypted/measured into the initial guest state prior to

Nothing needs to be measured, no?  (because there's no attestation)

> finalizing/starting the guest. It also marks what GPAs need to be mapped
> as encrypted in the initial guest page table.

...

>  static inline void vm_mem_set_private(struct kvm_vm *vm, uint64_t gpa,
>  				      uint64_t size)
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index bbf90ad224da..d44a37aebcec 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1991,6 +1991,43 @@ const char *exit_reason_str(unsigned int exit_reason)
>  	return "Unknown";
>  }
>  
> +/*
> + * Set what guest GFNs need to be encrypted prior to finalizing a CoCo VM.
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   memslot - Memory region to allocate page from
> + *   paddr - Start of physical address to mark as encrypted
> + *   num - number of pages
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * Generally __vm_phy_pages_alloc() will handle this automatically, but
> + * for cases where the test handles managing the physical allocation and
> + * mapping directly this interface should be used to mark physical pages
> + * that are intended to be encrypted as part of the initial guest state.
> + * This will also affect whether virt_map()/virt_pg_map() will map the
> + * page as encrypted or not in the initial guest page table.
> + *
> + * If the initial guest state has already been finalized, then setting
> + * it as encrypted will essentially be a noop since nothing more can be
> + * encrypted into the initial guest state at that point.
> + */
> +void vm_mem_set_protected(struct kvm_vm *vm, uint32_t memslot,
> +			  vm_paddr_t paddr, size_t num)
> +{
> +	struct userspace_mem_region *region;
> +	sparsebit_idx_t pg, base;
> +
> +	base = paddr >> vm->page_shift;
> +	region = memslot2region(vm, memslot);

Please no, doing a memslot lookup in a helper like this is only going to encourage
proliferation of bad code.  vm_mem_add() really should be able to mark the region
as protected.

E.g. practically speaking, the only code that will be able to use this helper is
code that is marking the entire memslot as protection.  And ability to _clear_
the protected_phy_pages bit is conspicuously missing.

> +
> +	for (pg = base; pg < base + num; ++pg)
> +		sparsebit_set(region->protected_phy_pages, pg);
> +}

