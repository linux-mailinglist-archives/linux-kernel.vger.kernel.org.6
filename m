Return-Path: <linux-kernel+bounces-518383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E83A38E34
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E813AF0B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265EF1A5BBC;
	Mon, 17 Feb 2025 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cr8T7LbF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175662A8C1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739828404; cv=none; b=O99LTdqn5VkKp/EU8sDxyTA3brAy29/jju3Gn8zz8B4G1hOQluPnkyR64nr7NTbdH4QU8maRRAJtQWQpw5Y0/aJ+5lo0eMYGS2SBzO+Rm94jYlkDI6T8cJLVJSRpWiuy31qM4ha5ZDS4d9xZ6lV48SYaF0BpopLGOxnSvj0dMEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739828404; c=relaxed/simple;
	bh=4RCmN6Pq0aiV1DxAu55NPxx/C4+FedmyURHnQ4wZhLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvqgEDkYHfESQD6N4aWgHUzxxAFpbAPIyXsWIDrnH8NFBzdPFChnqSgYaNiipQxuR+76TJBmfJX10FIY3+kvcLQslU1RrZhTC32RLa6qWRQr3MtLXBeKZnQpK9veYY7TxeHMb2B2IX4ZADXueGPVOrvXcTOjrstT+9uS1skKjhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cr8T7LbF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739828403; x=1771364403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4RCmN6Pq0aiV1DxAu55NPxx/C4+FedmyURHnQ4wZhLU=;
  b=Cr8T7LbFWnJdD0o6E5gHa3D+MvLc7O+bSfA4vvoOwse14ByE0knXzcLz
   oHjvl+2gzscbFnEpGdwpzu57mOsiOQd3QjFkNWAHx1VYvIIziryF/BbQ9
   qBpHxS4/ByJUdE5NRirXJ5CMiH8Ppg58kMyXac7uH2GA+5FUGT5sXbkHd
   P2+D6GMU4mvneKnLT+2khHwDH1FSmSf2Z0QH8xgI9ZCenK7gbjOotchjT
   /MqHnnfwZ+UblwYkpu1Zu5iH27SPueE7XQ6UI5VBlx9IC3OLoiW8rHD6m
   OsLdbKUFbuO1mVX27GpGSXCf5g7nR2j6MC99fNAuib0JEXJEgLhzgw/3I
   w==;
X-CSE-ConnectionGUID: DbnH++EeTIKzjsACms454g==
X-CSE-MsgGUID: 17xNIwU1SlK6KAF88hESuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44272964"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="44272964"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 13:40:03 -0800
X-CSE-ConnectionGUID: L9mncwALQVimDKEVc42PWw==
X-CSE-MsgGUID: 35j9OdfMQW668kYvZ083FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="145057255"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.124.220.114]) ([10.124.220.114])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 13:40:02 -0800
Message-ID: <307d7655-1857-4662-b77f-86f402b6d046@linux.intel.com>
Date: Mon, 17 Feb 2025 13:39:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] x86/tdx: Add tdx_mcall_rtmr_extend() interface
To: "Xing, Cedric" <cedric.xing@intel.com>, "Huang, Kai"
 <kai.huang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <20250212-tdx-rtmr-v1-3-9795dc49e132@intel.com>
 <5b6a06ac-b98e-4e15-9b19-913aec8bf4df@intel.com>
 <2306bc17-d1bd-44b0-b5a0-5ddb8c8d30f7@intel.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <2306bc17-d1bd-44b0-b5a0-5ddb8c8d30f7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/17/25 12:58 PM, Xing, Cedric wrote:
> On 2/16/2025 6:40 PM, Huang, Kai wrote:
>>
>>> @@ -135,6 +136,41 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 
>>> *tdreport)
>>>   }
>>>   EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
>>> +/**
>>> + * tdx_mcall_rtmr_extend() - Wrapper to extend RTMR registers using
>>> + *                 TDG.MR.RTMR.EXTEND TDCALL.
>>
>> Nit:  I would prefer to name it as tdx_mcall_extend_rtmr() since this 
>> matches the existing tdx_mcall_get_report0() (and 
>> tdx_hcall_get_quote()) better.  But no strong opinion.
>>
> This actually my preference too!
>
> Sathy, what do you think?

I have used rtmr_extend() to match with TDCALL name. But I am fine with 
tdx_mcall_extend_rtmr(). We can use it.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


