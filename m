Return-Path: <linux-kernel+bounces-444363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6648F9F05A0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588E1169C40
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C61991CD;
	Fri, 13 Dec 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Swb949eS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D65188CC9
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075693; cv=none; b=pxYg0ImRw3sSj0aG15w1noou2eq4MBoCWL8pHhWZc+AERtxBhrpY/kodJ0A1Af/xrysoL6crSiv7XbeJm8STbj8Yn9++0WQNj5RdIiw58nKM0S3HSOF42nwQTP3BjPb8bV+QPz7NnrNU9XOa1imxVN693Gn6bbzNPvDsxKDKYtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075693; c=relaxed/simple;
	bh=qe/DRkZqurcuEiMRLcjhf4qFchIOWtU4Kj0uAbt85Uk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WouT0RuSC6tJHHNCFyFO7Ta7moxtnROxJKSSkVzXQeaS0ZwJD+2y4brCzYkjtBpla0e4x5jsNXoVx2w7fPjYQXxmgdhce84vrVeF1/xoKUrk98hI+dRuWvJa5mEirHsfPwORba6Q4bs4qX7UUSndrOl45STeLA5BSP+myo8Ljp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Swb949eS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734075691; x=1765611691;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=qe/DRkZqurcuEiMRLcjhf4qFchIOWtU4Kj0uAbt85Uk=;
  b=Swb949eSiW0W1c9+usHHQhni+o09HkClap801iUCRUO0JWp/Zg2//r0/
   gHYjUtDHgqj2iV4nMNoAyRCKYKUrA/m1diTaUc67I1WZkJgmP0fYIWpru
   QHZzCvDirazer3ZAh2p8susf1R2AGHeGnS5lsr//fb28ArlETgNx+RqVy
   +WM4W2RNCPx/yAfqTGjCbqz8F+cf6cI+Ti5I0KKTm2z/TWGa4R0JW4SgT
   h49Tlo/5vfbYXUb8Si9hMsLJ46rvGBrqY8yomKFJLx9NV1F1tqybn3hxz
   v3kBmmlg36QErL00ct+kJozNh/j+L/I8r31A+2WGWy+NewTA5eVp2/eOe
   w==;
X-CSE-ConnectionGUID: M9g5ZQyCTbChfw7tt2ilLA==
X-CSE-MsgGUID: Kg9X+YovQiGwBUk2G5Tb/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="59916754"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="59916754"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 23:41:30 -0800
X-CSE-ConnectionGUID: KwcmarQeTGKFseYtnaVssQ==
X-CSE-MsgGUID: cfzBmJPnRUO8J/8tfieSog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="101489393"
Received: from hongyuni-mobl.ccr.corp.intel.com (HELO [10.124.244.96]) ([10.124.244.96])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 23:41:26 -0800
Message-ID: <44ddaae9-fde0-4bd9-8662-ee88141ff0a3@linux.intel.com>
Date: Fri, 13 Dec 2024 15:41:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/20] x86/kexec: Mark relocate_kernel page as ROX
 instead of RWX
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
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
 <56fdfffc-9a5e-4f9e-ae5b-57dd27d647cc@linux.intel.com>
Content-Language: en-US
In-Reply-To: <56fdfffc-9a5e-4f9e-ae5b-57dd27d647cc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/13 14:45, Ning, Hongyu wrote:
> 
> 
> On 2024/12/12 18:13, David Woodhouse wrote:
>> On Thu, 2024-12-12 at 11:03 +0800, Ning, Hongyu wrote:
>>>
>>> Hi David,
>>>
>>> I've hit some kdump/kexec regression issue for guest kernel in KVM/QEMU
>>> based VM and reported in https://bugzilla.kernel.org/show_bug.cgi? 
>>> id=219592.
>>>
>>> based on further git bisect, it seems to be related with this commit,
>>> would you help to take a look?
>>
>> Thanks for the report; I'll take a look. Please could you share your
>> kernel .config?
>>
> 
> kernel config updated in the bugzilla https://bugzilla.kernel.org/ 
> show_bug.cgi?id=219592
> 
>> Also, you say that this is in QEMU running on an IA64 host. Is that
>> true, or did you mean x86_64 host? Are you using OVMF or SeaBIOS as the
>> QEMU firmware?
>>
> 
> You're right, it's x86_64 host, I miss-selected it in bugzilla.
> I'm using OVMF as the QEMU firmware.
> 
>> In the short term, I think that just reverting the 'offending' commit
>> should be OK. I'd *prefer* not to leave the page RWX for the whole time
>> period that the image is loaded, but that's how it's been on i386 for
>> ever anyway.
> 
> And your latest patch https://lore.kernel.org/ 
> kexec/9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org/ 
> could fix this issue now.

my local email app went wrong, didn't receive latest patch in email thread.

later version patch 
https://lore.kernel.org/kexec/ed7dd45f89e8f286478791137447a21d53735dbd.camel@infradead.org/ 
could fix this issue too.

