Return-Path: <linux-kernel+bounces-337721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9435F984DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C081C23737
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745161547C5;
	Tue, 24 Sep 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCiyql8A"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649213D8A3;
	Tue, 24 Sep 2024 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217683; cv=none; b=gu47usuNoqW7O0znsuTe8jMQ1v1VaQBP/ix02Kcuwob9ign5liddK44y9spSa7oRSpbz4AlE6DPQM5PvOqOYhaJ9NrdeIM43T6+B00JThvSQgM9OC+vsyQbi/iipOGMwYGqj0ptCcaGkYtHfZRInfCmHdrjRveK9P4J1FEINOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217683; c=relaxed/simple;
	bh=ujlBERwPC90XLYjqz0B3bnBgH+bgAU9j+B8GyDi3nFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGT+XyL82+mnAxGlEh5mUhbV54usWuMgj+54/rqWt4n6vjfsO0xmTFyj/tQCTr8T+VeWjA70rT6u7W6NwCWAuuSh7l1P5xm1rypwrAlLpAw5se9ANiqYJQrVctChA6rPvUDmv5O3D1nYhq/mLx1kJY4EPPRnh8HrtqO2l9GnbU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCiyql8A; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727217682; x=1758753682;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ujlBERwPC90XLYjqz0B3bnBgH+bgAU9j+B8GyDi3nFw=;
  b=OCiyql8A3blqkbtZjl3OS2xBXzPXJxiOfyzGn9NouTfhrurD4GN2Sn2y
   iEj80bzx2+xAUVJiffWZrte81/KVW6ADWrc2V5YsqwvfjoKDGmFD1XzwA
   DfsQbfBpYb9o7hsrby5deAB65UDz4NVz4VksVjG0VkJqEOyNyG48UkyR6
   efSAzMVQD6web9mKX4rKjWGLLznolDCvd11PlWCUQ7UCUzKCmsFzKocpp
   r4wHVjNPvVCojkeZqFioxZOxOieofO7smuoJHWiQ0qBai3iju6skAlV4u
   ZOJIQAALkbU9YYHfMmud968h1vB7WKZOA8qmVEHYwfZxLdB7KwZLjOHpF
   Q==;
X-CSE-ConnectionGUID: pbegxfY9Q+CNSB2Sfb8dFw==
X-CSE-MsgGUID: dhqC1bSYSvCPFcz5iv1fBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="36807638"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="36807638"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:41:21 -0700
X-CSE-ConnectionGUID: 2VGX9sdVTiiM6yJBptGeuQ==
X-CSE-MsgGUID: RqSK1/tYSG+lJVQcujF6uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="71572837"
Received: from laijusti-mobl.amr.corp.intel.com (HELO [10.125.17.198]) ([10.125.17.198])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:41:20 -0700
Message-ID: <d0a71676-f782-44ea-9c66-60658b9d9330@linux.intel.com>
Date: Tue, 24 Sep 2024 15:41:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] x86/bugs: Remove MDS command line
To: Dave Hansen <dave.hansen@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: hpa@zytor.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 pawan.kumar.gupta@linux.intel.com
References: <20240924223140.1054918-1-daniel.sneddon@linux.intel.com>
 <20240924223140.1054918-3-daniel.sneddon@linux.intel.com>
 <fa94df43-d2d7-478e-b74b-9afe6d624292@intel.com>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <fa94df43-d2d7-478e-b74b-9afe6d624292@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/24 15:34, Dave Hansen wrote:
> On 9/24/24 15:31, Daniel Sneddon wrote:
>> -	mds=		[X86,INTEL,EARLY]
>> -			Control mitigation for the Micro-architectural Data
>> -			Sampling (MDS) vulnerability.
> 
> As much as I'd love to remove old code, won't this surprise users if we
> just take this away?
> 
> I suspect the _least_ we can do is warn folks if they use something that
> we recently ripped out.  But the right thing is probably to keep the old
> one around for at least a while. <sigh>

True. I can leave the functionality but print a message basically saying "Don't
use this use the new one".

Thanks,
Dan

