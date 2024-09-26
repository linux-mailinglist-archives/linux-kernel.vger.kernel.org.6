Return-Path: <linux-kernel+bounces-340850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F15B987877
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2401F21B91
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F1E15D5D8;
	Thu, 26 Sep 2024 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgDAA4pT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ED31494AC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372229; cv=none; b=G099hCSoWhhd5h4BcRBMjC6YEE7o332pBWrCDjfZ84fdOOhDRUwkkkgVJCYRX9peF3HV6XdrsJ5KKwUI5KXxcOXoXOKU7DS1j3aG7MCuVRQpGc1qF2KxBgKngIIrsLKnpYfvuWHZRU7/GkyIciftzCW3cXZ4DwPPRov3Ye/ONzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372229; c=relaxed/simple;
	bh=skEFNNIPc0eTzIDP7gYtmFITHdxbV8SjNb8BVSpjCeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRAxjQmzGCYe2HgLHidTu3q7KAJAV6ng76eFrnhNjCA7JNuVGE2x7TyUF3XmHxhfIaAU94pygx8F1JNU7ocmq6afbwLvms2N/jen7+xcvl5KQIqqO/HSICgveVb6qp0yfF00jEOaQFKmoWTd2eyXM8uvNX332o4HgorVqgyGRMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgDAA4pT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727372228; x=1758908228;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=skEFNNIPc0eTzIDP7gYtmFITHdxbV8SjNb8BVSpjCeY=;
  b=FgDAA4pTuzqNWsZio8Lo362qAb+g1D19PF4G3/UhZ8zKagvkvJXBPvKy
   fBWLkGmndnG6jH+QGFWjmrDYQqzxf+vpuvpRGC0ZoWiyyh+Ax1Ek3lF9Y
   wTX2BIjRdJxNsk4BxLRe8HQpCptim35uH7DfJQEj3kI/XumiNt3hRErjI
   CC6hEIO6PTVoTQWW0/KOxU98nQUmtmqPaqsd/Tgzd9MAJwIEhwl5fSnME
   2p3Xza5xjwFh33ywdZF/la/BxlSXyKp+pWu7uipRYJ9m6UAeoInuI+HGz
   cVTekuXSQkNRsmaGmD3YCL2o4+ZBf9MaEfP4fEkNAr+dJh9E37ItgK3te
   w==;
X-CSE-ConnectionGUID: KYGMa7stSyiuQ5BedNEXRg==
X-CSE-MsgGUID: Snkw+1WaR+27ZGFds5QCJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26000563"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="26000563"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 10:37:07 -0700
X-CSE-ConnectionGUID: yAJJ9VIjSMWCqMak/rafGQ==
X-CSE-MsgGUID: SSEFupPwR7axz82SHDgMRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="72681203"
Received: from bmurrell-mobl.amr.corp.intel.com (HELO [10.124.222.36]) ([10.124.222.36])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 10:37:07 -0700
Message-ID: <1a0fd968-15a0-401f-a683-e8989c2df669@intel.com>
Date: Thu, 26 Sep 2024 10:37:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] x86/mm: Don't disable PCID if the kernel is
 running on a hypervisor
To: Xi Ruoyao <xry111@xry111.site>, Dave Hansen
 <dave.hansen@linux.intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>
References: <20240522020625.69418-1-xry111@xry111.site>
 <20240522020625.69418-2-xry111@xry111.site>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240522020625.69418-2-xry111@xry111.site>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/24 19:06, Xi Ruoyao wrote:
> -	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
> +	/* Only bare-metal is affected.  PCIDs in guests are OK.  */
> +	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +		invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);

So, surely, the common case is hypervisors that set
X86_FEATURE_HYPERVISOR are running the guest under VMX.  But it doesn't
cover everything, either.

The guest could be running under regular old QEMU without KVM.  Or it
could be one of the hypervisors that has a sense of humor and runs guest
ring0 in hardware ring3.  But those setups aren't vulnerable in the
first place because they don't actually execute INVLPG directly on the
hardware.

That said, if this check goes wrong (like seeing a
X86_FEATURE_HYPERVISOR==0 under VMX) the worst that can happen is that
PCIDs get disabled without a good reason.

So I think the patch is correct, but I don't like the idea that
X86_FEATURE_HYPERVISOR has any kind of strict connection to VMX.

I'd rather just say:

	Hypervisors lie about CPUID making model and microcode version
	checks worthless. Just assume all guests are immune either
	because they can't use INVLPG directly or are running under VMX
	and are unaffected.

