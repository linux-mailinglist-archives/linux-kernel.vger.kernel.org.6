Return-Path: <linux-kernel+bounces-444339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2099F0501
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4B3282CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C4D18CBEC;
	Fri, 13 Dec 2024 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAdF6Zle"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A3155398
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734072337; cv=none; b=MI05gAPxdPyrTs4346nLbbxCPZu7u868v98VnlpuuZYVMuXQZ5jVRfkYyODbUcgKrF4QCb3AQnZHM9qITLc1dN9XiScN1jrmkc74V6VxMQMrCssgISuOfT6IgbsG9QDQO27DEMf2b+Jz4Aeacy7J6ZV2LiAuk8390dTb5XxLwj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734072337; c=relaxed/simple;
	bh=Y3V3QXxnk6ioz2X6g8iJlmn+yyJNHa0oVjvimRPuvw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgehxlS2r985al3Fy/Jthr+3v+EFwcLY57/rKL0pwJVY4o6cx5jjs18CKxLvnsKxZ+6submjJerXCWugaPVK4QZYcs8ASTf8EzcSA2rD1pTU0Kly5T+wWMHY/7EDiKlIZnvQKV5wGj7W5KUYGUCUr4wG1YLGqSWObY8EE3lJyzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAdF6Zle; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734072335; x=1765608335;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y3V3QXxnk6ioz2X6g8iJlmn+yyJNHa0oVjvimRPuvw0=;
  b=VAdF6ZlemyXj2RmOYOXDTiztvuqkmiO823hb6mOdgkzSeGXtSPMmpl0c
   WxaisET8GHmIfh4agNJ/SOqLqAlgZxCfzwoZI6fGM3eP0Z9e9xeZjwTwG
   MTQ0F7UADj8h1TUvmNzccpF+7tD3UUfE1EF5C2Q0jn2/iIAai/MaW7PoA
   ceG6GJCrJ0cVXDyapdxfenLNystV/rLoZ0VXJC3Vmtau2YPb0mTfnOxOH
   AhR69QcVfHQegB1gfAA5LNiwREz4BJMh871R84OSTIISBwfQU5zbx4tV6
   ZrNXv1INuL9P4b8Q5igryNRiSOEeBdt+CipH9I9CFc0/Es9+qt7OCdhFf
   w==;
X-CSE-ConnectionGUID: 3C7bmxVCQ62celQnBD9kQw==
X-CSE-MsgGUID: 62MOimwYSZ+17ERGHe5Xaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34649493"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="34649493"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 22:45:34 -0800
X-CSE-ConnectionGUID: fURkU1yZRrW+hvR2JNT3GQ==
X-CSE-MsgGUID: 1kFj6ZH7RpeklJ9CO0RjLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="96529879"
Received: from hongyuni-mobl.ccr.corp.intel.com (HELO [10.124.244.96]) ([10.124.244.96])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 22:45:29 -0800
Message-ID: <56fdfffc-9a5e-4f9e-ae5b-57dd27d647cc@linux.intel.com>
Date: Fri, 13 Dec 2024 14:45:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/20] x86/kexec: Mark relocate_kernel page as ROX
 instead of RWX
To: David Woodhouse <dwmw2@infradead.org>, kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-14-dwmw2@infradead.org>
 <5bb26488-f5fb-4186-92c3-de6a07631f91@linux.intel.com>
 <b4104c271b461dc1958ffac299d6741746a0728a.camel@infradead.org>
Content-Language: en-US
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
In-Reply-To: <b4104c271b461dc1958ffac299d6741746a0728a.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/12 18:13, David Woodhouse wrote:
> On Thu, 2024-12-12 at 11:03 +0800, Ning, Hongyu wrote:
>>
>> Hi David,
>>
>> I've hit some kdump/kexec regression issue for guest kernel in KVM/QEMU
>> based VM and reported in https://bugzilla.kernel.org/show_bug.cgi?id=219592.
>>
>> based on further git bisect, it seems to be related with this commit,
>> would you help to take a look?
> 
> Thanks for the report; I'll take a look. Please could you share your
> kernel .config?
> 

kernel config updated in the bugzilla 
https://bugzilla.kernel.org/show_bug.cgi?id=219592

> Also, you say that this is in QEMU running on an IA64 host. Is that
> true, or did you mean x86_64 host? Are you using OVMF or SeaBIOS as the
> QEMU firmware?
> 

You're right, it's x86_64 host, I miss-selected it in bugzilla.
I'm using OVMF as the QEMU firmware.

> In the short term, I think that just reverting the 'offending' commit
> should be OK. I'd *prefer* not to leave the page RWX for the whole time
> period that the image is loaded, but that's how it's been on i386 for
> ever anyway.

And your latest patch 
https://lore.kernel.org/kexec/9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org/ 
could fix this issue now.

