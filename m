Return-Path: <linux-kernel+bounces-439267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B6B9EACED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F5E188D783
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A422178F52;
	Tue, 10 Dec 2024 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOnANEQT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6D23A599;
	Tue, 10 Dec 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823847; cv=none; b=J1jgUDaUiboSBG7grJCIQ+7kDrFdiJ/ZrBBkqY6ggoNc14Js+uQxH1OV8Q/N09QPmKfZqpuAlKYAJf87LAe/zPs2HHZKFHHVMrPTodktfCTRwuUmvPzhQicapfYYEei+nQZ3ncLxOLTjdwKt2uygNV5rrpg8yIUwPsjhZFgtvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823847; c=relaxed/simple;
	bh=vuEmmwVjJRFYSChDQkPZUyRxA/CC+H/HrJ4ih0N4Us8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqNjKFSYA7zzjLnek8ArFxym6NIJUPi0vXjOjAzZDFnQFo6Nrf54VB/0byu3lrB2cbwVK9wVZWbgo30hNdtcAAW9joy5OOt6ABCyk2tUKDQFg/rZ5Ck4EeVXfTy6jHQCrIbBe8+iOYqSElD/EeXVBMnIPQK3DsPP0zWZBGZaOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOnANEQT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733823846; x=1765359846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vuEmmwVjJRFYSChDQkPZUyRxA/CC+H/HrJ4ih0N4Us8=;
  b=SOnANEQTgkEMgDSylr7JXEY7PMAcSWDV3zSxJ/+bQF+xnrRPI6mMTZsO
   lQom1iTKtEyw01GsQTMgGkna7PQ7SzDlBJPlFT6JcxVKp9BUJpgwQWWvQ
   7J92gMFTDJYU3Lf0ruAgXLV9jmdb31b9qjd0dFuStGBtNQNm9gr3g5Jx+
   l6crBQ8kEeLVGBnOFrbYhaNwIfbifSnCX43SNJ/XYf7Vo1S/z7n9YoXDw
   c7DxFFztajoGN+HMB0KWOxGipNcrLfqEvpVARYp4LvCI8ZW7xW0Utpm34
   EzzOGT+JalvJUMyim4H2r9hor4+1jeoIoeFkdeH93+3PLjHj/YQP/F7ts
   Q==;
X-CSE-ConnectionGUID: Vn+KTwGCTmezYenssh6Waw==
X-CSE-MsgGUID: Aq7ofonYQEehfQCWl4ORsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44762567"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="44762567"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 01:44:04 -0800
X-CSE-ConnectionGUID: qMB/gtfERZ6bFBXFj4djJA==
X-CSE-MsgGUID: x92KKZSRQd+XTTpw9Mj40Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95228417"
Received: from unknown (HELO [10.238.9.154]) ([10.238.9.154])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 01:44:01 -0800
Message-ID: <eaaaa2ce-bddd-4286-b86e-eace2ad1e5ea@linux.intel.com>
Date: Tue, 10 Dec 2024 17:43:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] KVM: TDX: Handle TDG.VP.VMCALL<ReportFatalError>
To: Chao Gao <chao.gao@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org,
 rick.p.edgecombe@intel.com, kai.huang@intel.com, adrian.hunter@intel.com,
 reinette.chatre@intel.com, xiaoyao.li@intel.com,
 tony.lindgren@linux.intel.com, isaku.yamahata@intel.com,
 yan.y.zhao@intel.com, michael.roth@amd.com, linux-kernel@vger.kernel.org
References: <20241201035358.2193078-1-binbin.wu@linux.intel.com>
 <20241201035358.2193078-6-binbin.wu@linux.intel.com>
 <Z1gEQF8LkIjON8wa@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <Z1gEQF8LkIjON8wa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 12/10/2024 5:05 PM, Chao Gao wrote:
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index edc070c6e19b..bb39da72c647 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -6815,6 +6815,7 @@ should put the acknowledged interrupt vector into the 'epr' field.
>>    #define KVM_SYSTEM_EVENT_WAKEUP         4
>>    #define KVM_SYSTEM_EVENT_SUSPEND        5
>>    #define KVM_SYSTEM_EVENT_SEV_TERM       6
>> +  #define KVM_SYSTEM_EVENT_TDX_FATAL      7
>> 			__u32 type;
>>                          __u32 ndata;
>>                          __u64 data[16];
>> @@ -6841,6 +6842,13 @@ Valid values for 'type' are:
>>     reset/shutdown of the VM.
>>   - KVM_SYSTEM_EVENT_SEV_TERM -- an AMD SEV guest requested termination.
>>     The guest physical address of the guest's GHCB is stored in `data[0]`.
>> + - KVM_SYSTEM_EVENT_TDX_FATAL -- an TDX guest requested termination.
> Not sure termination is an accurate interpretation of fatal errors. Maybe
> just say: a fatal error reported by a TDX guest.
OK, will update it as:
"a TDX guest reported a fatal error state."

>
>> +   The error codes of the guest's GHCI is stored in `data[0]`.
> what do you mean by "guest's GHCI"?
I don't know what I was thinking about.

Will update it as:
    The error code reported by the TDX guest is stored in `data[0]`, the error
    code format is defined in TDX GHCI specification.

>
>> +   If the bit 63 of `data[0]` is set, it indicates there is TD specified
>> +   additional information provided in a page, which is shared memory. The
>> +   guest physical address of the information page is stored in `data[1]`.
>> +   An optional error message is provided by `data[2]` ~ `data[9]`, which is
>> +   byte sequence, LSB filled first. Typically, ASCII code(0x20-0x7e) is filled.
>>   - KVM_SYSTEM_EVENT_WAKEUP -- the exiting vCPU is in a suspended state and
>>     KVM has recognized a wakeup event. Userspace may honor this event by
>>     marking the exiting vCPU as runnable, or deny it and call KVM_RUN again.


