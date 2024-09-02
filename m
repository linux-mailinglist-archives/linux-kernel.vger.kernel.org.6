Return-Path: <linux-kernel+bounces-311345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003239687D5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DBD1F214C2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8762219C562;
	Mon,  2 Sep 2024 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0wEkx/x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7459D181B80
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281248; cv=none; b=k+lyiCgF1dDYgUMrSS7IVtwFVyAc3XVGs1cZ2vF9Eer7kDMXi7wLHUe3f/bWqU7jS3kDxPqM+BI7nHth3OlvYkuwameLGIajsGD74/k3VkKJPCJvwieLyvL/RqSGdGipPx8JURip8ZV5RAIeOfeRfnJSZe4IKluM53ddHf/4LFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281248; c=relaxed/simple;
	bh=lFavu3CC6Rh3qmR4Z+C+cO+FvccjBfVCb05rWtrYbyU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=anevWfI7mQo0gZci5owd+wITc0d4saSP/JD8/DxnyaWq0meQDNy270EeC8YIpPT0/LpkJMARAZ9meq/aS49R0fQJs6AszGktijUow+JqkcvlWmOG/A+IqhUPWqCz2uroi/P3cZGcyLKkeogtUOKzYCL+6pcUQLFUBlhropArf9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0wEkx/x; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725281247; x=1756817247;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lFavu3CC6Rh3qmR4Z+C+cO+FvccjBfVCb05rWtrYbyU=;
  b=Z0wEkx/xbpswsmALZHzMk1Uw0Lh8/WDU5bHCyoyXxGqIlN/ralzPkRqI
   et58o5jiB8xGszUwXtsNn/nHzv5d15iC9O8QJaWYQLz/8H2X17Dr9JW3q
   tSy3t3Jv4iyp1kNQonm1DFzItN2TgI3TtNOLgQnvxRQiA3CBkxmMQwvo1
   7EGdcJv4ufNgJi7aQ7ff26d0EZfCg721RYmeZKEgcjV1tviLk+J7rodgf
   s6zRYVtUD5as8Hh28u7VIN7NtiiPMfMApSpIkquXUsVLFdgLxxflMk9ZW
   Qv07MppgS9pNhAwO5eo+y8AhZGLCeXLDxBtuP9rBarOixpjt3+khkFfCr
   w==;
X-CSE-ConnectionGUID: cXRv8nyGRHWt6xTWYOMG9w==
X-CSE-MsgGUID: F9J1X64wQwKdh6BfGPjO4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="23727787"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23727787"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 05:47:27 -0700
X-CSE-ConnectionGUID: lHayZhNBSvWnXRm9wQ25gw==
X-CSE-MsgGUID: /BsTX2i2Tdqw2sbr6OVFvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64232653"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 05:47:25 -0700
Message-ID: <d1e1370a-0714-4da8-b645-f56d83ab0159@linux.intel.com>
Date: Mon, 2 Sep 2024 20:47:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Klaus Jensen <its@irrelevant.dk>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Minwoo Im <minwoo.im@samsung.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 0/6] iommu: enable user space iopfs in
 non-nested and non-svm cases
To: Joel Granados <j.granados@samsung.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
 <CGME20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97@eucas1p2.samsung.com>
 <20240826135955.GI3468552@ziepe.ca>
 <20240902104819.a2jto6l3tv2h5wvq@joelS2.panther.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240902104819.a2jto6l3tv2h5wvq@joelS2.panther.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/2 18:48, Joel Granados wrote:
>> I definitely expect PRI to work outside PASID and SVA cases, so this
>> is going in a good direction
> This touches on a detail (at least in Intel's vtd-io spec) that is not
> 100% clear to me. Second paragraph of section "3.4.3 Scalable Mode
> Address Translation" reads:
> "
>    ... Scalable-mode context-entries support both requests-without-PASID
>    and requests-with-PASID. However unlike legacy mode, in scalable-mode,
>    requests-without-PASID obtain a PASID value from the RID_PASID field of
>    the scalable-mode context- entry and are processed similarly to
>    requests-with-PASID.Implementations not supporting RID_PASID capability
>    (ECAP_REG.RPS is 0b), use a PASID value of 0 to perform address
>    translation for requests without PASID.
> "
> This basically means that a default PASID is used even though the
> request is without PASID. Right? Therefore "outside PASID" means with
> the default PASID (at least in Intels case). Right?

Kind of yes.

The PCI specification defines the concept of PASID and its role in
transaction routing. We refer to PCI transactions with a PASID prefix as
"request-with-PASID" and those without a PASID prefix as "request-
without-PASID." Consequently, I understand 'outside PASID' to mean
transactions that do not have a PASID prefix.

The VT-d specification describes how the IOMMU hardware handles request-
without-PASID. It uses a reserved PASID for its internal routing and
handling purposes. If RID_PASID is supported (ECAP_REG.RPS=1), software
can select its own reserved PASID. Otherwise, the IOMMU hardware will
use a default value of 0.

Thanks,
baolu

