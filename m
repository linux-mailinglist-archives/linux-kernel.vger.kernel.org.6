Return-Path: <linux-kernel+bounces-277658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B4A94A460
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D156B2B543
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2384D1D1F66;
	Wed,  7 Aug 2024 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlpNtaG+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFAB1D1F40;
	Wed,  7 Aug 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023142; cv=none; b=mKI25twEzhJrIbdhsGExexJ7QqjuuwI0z9Q4sQKP0tcCpdcQ/RzwQmNd9csbTYkLKGPHJFIx2XWK7FHPrlrmV4Ulcm3fmNft8FBPJg9YWHTywhxvcusqAYFGv3N/QROxOUyqhaJffEJIWAuNklW2VeAWft+oKfNfxad6eXQBdtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023142; c=relaxed/simple;
	bh=/Ru8BUhmCNT4AeubrZXOMakRpmWy1cl+GK9er0sMLSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTbuR8Rd3NurGQJr4JwIrVUG+aTvBmkaATVk3pJhELu+rOD1Gcn4P/dr7kzhXLkMKwCjgDbAvHpoec7Ea8CTPG3IjbwNY1XDsD2e/kYHJFD2C+/kwuBqaIQMtkuv9vZcRQOpePpkzxytsD8A62XItmMNgQo3nXLraBWub33BYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlpNtaG+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723023141; x=1754559141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Ru8BUhmCNT4AeubrZXOMakRpmWy1cl+GK9er0sMLSY=;
  b=nlpNtaG+gr+dvM6X2k+oBF8P3cUxAztmSrv/kMztI6n1/zZkPbr4dy/C
   bxwKLxtjh3tOMY3qIidz7c3CZk05C/X/8GntTCzXC0Ls3MNYoK3uAzQqc
   +kZ2+tw6QvREkUrkJgAzrQiWpilbFk+kkwzzyTp2yhALxTNtgmblbZOR3
   4yLWwpuJThq/qyj8KPvSOqO/NQxU9wLJg3xZMDEmG/unHezxcMldqXSbP
   z+zGk+mnRYmww7jNlIK2nCmg2b4KyotRXDZ0VsvwEDVu84EFy+IFeiQgA
   jQPtqeXgtvsKDGRNno3Hm3cIhqMEDbGr/mHCEwLxN41jbWjnRZXesLW5b
   A==;
X-CSE-ConnectionGUID: /ezMvcuYSb2nLCjg2MC3NA==
X-CSE-MsgGUID: hxzBF3NdR8KOBEsEOJJnkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="20938806"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="20938806"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 02:32:20 -0700
X-CSE-ConnectionGUID: FVyhgcLOQ866fQrvA+OQ7A==
X-CSE-MsgGUID: gIbOqJcwS0yyWhGncGRgkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="56670302"
Received: from nneronin-mobl1.ger.corp.intel.com (HELO [10.246.51.162]) ([10.246.51.162])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 02:32:18 -0700
Message-ID: <6327d2ed-f1de-406d-a713-97934dbb6c39@linux.intel.com>
Date: Wed, 7 Aug 2024 12:31:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-42226: usb: xhci: prevent potential failure in
 handle_tx_event() for Transfer events without TRB
To: Jinjiang Tu <tujinjiang@huawei.com>
Cc: cve@kernel.org, gregkh@linuxfoundation.org,
 linux-cve-announce@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mathias Nyman <mathias.nyman@linux.intel.com>
References: <d5691b1b-c7e6-ddea-bd58-10855fd36d40@huawei.com>
 <9409f3d3-02d1-1e31-a6da-056b44a9523f@huawei.com>
 <010cb430-b0bd-40f9-897e-b48e326a9caa@linux.intel.com>
 <d36feb2f-c1f2-90c2-bb33-e6d0ff41096d@huawei.com>
Content-Language: en-US
From: "Neronin, Niklas" <niklas.neronin@linux.intel.com>
In-Reply-To: <d36feb2f-c1f2-90c2-bb33-e6d0ff41096d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 06/08/2024 16.53, Jinjiang Tu wrote:
> 
> 在 2024/8/6 19:15, Neronin, Niklas 写道:
>> On 06/08/2024 12.25, Jinjiang Tu wrote:
>>> Hi, Niklas
>>>
>>> The commit 66cb618bf0bb ("usb: xhci: prevent potential failure in handle_tx_event() for Transfer events without TRB")
>>> has been assigned with CVE-2024-42226, but the commit has been reverted in 6.1.99 and 6.6.39 due to
>>> performance regression. Do you have a plan to address this issue, or if this CVE should be rejected?
>>>
>>> Thanks!
>>>
>> Hi,
>>
>> Currently, I have no plan to address this issue.
>>
>> The commit in question, was not intended for any previous Linux versions.
>> It was created as part of my handle_tx_event() rework series. Future changes
>> in said series could potentially trigger the issue, so preemptively preventing
>> it was both simpler and more secure.
> I don't know if I'm understanding this right, do you mean the issue mentioned in
> the commit will not be actually triggered in previous Linux versions? Now the commit
> is reverted in v6.1 and v6.6, but the issue can not be triggered in these versions,
> so no more fixes patch is needed for these LTS versions?

I'm not aware of any cases where this issue has been triggered. As it has been in the
Linux kernel for a long time, I assume it does not trigger.

Thanks,
Niklas



