Return-Path: <linux-kernel+bounces-522338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C981A3C8E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BCE3B8DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B7D22AE75;
	Wed, 19 Feb 2025 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJT6a+Za"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E2222ACE7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993587; cv=none; b=tNL/W8M8Jv6ylCvqwg3UerluAS29kmUc6CRMqrv3sMd4yWhhYuyFO2m/SW8hc2+nWncy5J2bKdRIZi0pFjKvmsWJyD8yXzeSoGCiHmpvc1FrwDUFyVoDxjomYU7IY76Ek2PzjAIr4vQVbmRqNeE/PV0jVvBJSxl5cOLNuvnn4Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993587; c=relaxed/simple;
	bh=alXYuPS0FINh9Nm9P5MiVyVk+9+fDhZvqgT5JAY4svw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DimeiZgJxFatiOKRtBOg0fObzYBhoERFfDVOKNJlAGSn1Fyvx/i+fGRJmakpoRpUNETTmFDUn2C9/RmizCnIss7OKWSv58DVI7NUaOxeS0gDXAwUelODD6W1F9PjPA8WLDGiNuZYknuRSVtqtb0EzFrGF0AYSmE5ZuTt7A30mtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJT6a+Za; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993586; x=1771529586;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=alXYuPS0FINh9Nm9P5MiVyVk+9+fDhZvqgT5JAY4svw=;
  b=NJT6a+Zaw3vAEt5SSKbq4tUXRvpZwuiVR2jKdz2ZixFcBHAQmwYcrN1e
   7yG53esN6x2Jc4WK4SX7lCoWsCa+lO1ZSTeVHJZflVXstvF6WNAzRllO1
   eXWiQ1jcAZrHJ93T+SNp52/cbgqHYcYitwjnLhh9y5nxn5bOAS4FXyg8V
   mCxImvsP/2WHwtDwH8cY604k6zQ5lkG4Gn7UdI8oT5y8hwUs7rpbCreW9
   ACA/kNzoHrXEy0UQp5e2ifw9w1Ycekzq7KoGz+U/ycIfQ4Zw6tHJyVi8J
   IgreRaPnWgqsByAbRI1f7W/k7HMqtlX7Zc5+VqSHHDJNzEk42DUOblpZd
   A==;
X-CSE-ConnectionGUID: LSOsnJRoS5Wh3L93FDvB1w==
X-CSE-MsgGUID: hip2Cg1oScyftFhe4Vmp8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44665137"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="44665137"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:33:05 -0800
X-CSE-ConnectionGUID: qmAl5OaIR7aoFqIIOv6vDA==
X-CSE-MsgGUID: s4N8mZO9TfuSeGmxmFrj6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120021039"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO [10.125.109.250]) ([10.125.109.250])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:26:09 -0800
Message-ID: <0ebdfab1-09c6-475f-bcf8-366a321359a0@intel.com>
Date: Wed, 19 Feb 2025 11:26:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/12] x86/mm: get INVLPGB count max from CPUID
To: Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali Shukla <Manali.Shukla@amd.com>
References: <20250213161423.449435-1-riel@surriel.com>
 <20250213161423.449435-5-riel@surriel.com>
 <20250219115626.GMZ7XG6s-5ftg1XLoZ@fat_crate.local>
 <b749384b7dea020880057359d06d4e9172c7aaec.camel@surriel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <b749384b7dea020880057359d06d4e9172c7aaec.camel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/25 09:52, Rik van Riel wrote:
>> CPU_SUP_AMD selects X86_BROADCAST_TLB_FLUSH which depends on
>> CPU_SUP_AMD which
>> selects X86_BROADCAST_TLB_FLUSH which depends on CPU_SUP_AMD...
>>
>> Why do you really need yet another Kconfig symbol? Just whack
>> X86_BROADCAST_TLB_FLUSH - it'll be enabled by default on everything
>> anyway.
> Dave specifically asked me to do things that way.

Yeah, I'm in camp "moar Kconfig!" and Boris is in camp "too many Kconfigs!".

I'm OK getting rid of the Kconfig as long as we have _some_ other way to
nicely identify the INVLPGB code (which I think the X86_FEATURE gives
us) _and_ that the overhead isn't too bad from leaving it compiled in
all the time.

The mmu_context is the one place that's kinda nasty without a Kconfig
option. I guess it's only a few bytes but it's a super silly waste of a
few bytes on i386, for example.

I also really like the _logical_ clarity that comes from something like:

+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+	u16 global_asid;
+	bool asid_transition;
+#endif

as opposed to:

+#ifdef CONFIG_64BIT
+ 	/* Only used with X86_FEATURE_INVLPGB */
+	u16 global_asid;
+	bool asid_transition;
+#endif

So, while I respect Boris's concern about Kconfig proliferation, I see
the user-invisible ones (the ones without a prompt) as pretty harmless.

Sorry for the maintainer crossfire, btw. I definitely don't want to be
thrashing you around too much.

