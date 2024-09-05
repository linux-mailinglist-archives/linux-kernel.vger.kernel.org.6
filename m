Return-Path: <linux-kernel+bounces-316272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FA896CD5E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C122871C6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F046B148849;
	Thu,  5 Sep 2024 03:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpeibTcE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E451E13D291
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725507247; cv=none; b=kMrJ46GEgCtE0UlbJ2PCZhNKmGaNLBe7uE5L5EGwAIpprLf4kw8SbWqpcOnYuvfzHWqwMdRmueTHCErOwbXbn8kXOc17jQMVz4/Bzu3ZVpeZhIE09LgOIpc2bwXEC8ot7VMbLywsr0RHT1DcBbfNhPhP+jTix78+anNEdVmr/1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725507247; c=relaxed/simple;
	bh=Aol8sGaTwxobrlkDaS24ORRfHXM+S/kWtOiBEfAMRZY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bx/h3WCKeLS/3o7z/yz/AuZyrfV7jbIKJ6DUSZ5SZN2+RpvPZEzVSXA2mC0ubC7NXoB66zpgJV5+YK0TQ8I+TLsxkFJaVzzbRjn3oNE0f8IyHY+duBpXOo8wJBx+ODgNYlPIWeoK2v889iniTrHljNut8rWaMx27a150H54IaXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpeibTcE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725507246; x=1757043246;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Aol8sGaTwxobrlkDaS24ORRfHXM+S/kWtOiBEfAMRZY=;
  b=mpeibTcE2zkh/oelCrfGRpw/30EtaizlzaIRoUzdN+bXB7RpLdYyo0HM
   mF6byg/wLArcALttAN4oTAknCHXsWFTt6RCd8ly7LyZCA+Ej6FUlRnZqF
   ed/Q1aUs2zU6kSYL2KRy/i4m50Jpuw/2d5TfRSjZ5vmlHwtyzwIIEjxi2
   UUBAINu0EYy0H1cy0Ji39AfLfOAC83yrJE24Tvolf1ycflF5Jv/u65fVZ
   ObAb/GDkLMYe9LfZTLDW899tLnhtsNd63ZSQp6XxuBFgpbuqqZ7jXKHbR
   9lH7N0zbggHtNU9dSP76JUPji2TUQ/JsQAxCG9gVI6cKkbFBkw/eVqjts
   w==;
X-CSE-ConnectionGUID: AxvdsuphRWOeJNQHv3yHGQ==
X-CSE-MsgGUID: OB8l1RcOTOC2J61H5H8nvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24001374"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="24001374"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 20:34:05 -0700
X-CSE-ConnectionGUID: 82X4yBmtRei/wWg6CiHN3w==
X-CSE-MsgGUID: gNz3yjWdQ+OseRCbsMtI8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="65475690"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa009.jf.intel.com with ESMTP; 04 Sep 2024 20:34:02 -0700
Message-ID: <c2e765a8-d935-42db-bd22-c12e7960f2f0@linux.intel.com>
Date: Thu, 5 Sep 2024 11:30:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH 5/6] iommu: init pasid array while doing domain_replace
 and iopf is active
To: j.granados@samsung.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
 <20240904-jag-iopfv8-v1-5-e3549920adf3@samsung.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240904-jag-iopfv8-v1-5-e3549920adf3@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 9:17 PM, Joel Granados via B4 Relay wrote:
> From: Joel Granados<j.granados@samsung.com>
> 
> iommu_report_device_fault expects a pasid array to have an
> iommu_attach_handle when a fault is detected.

The iommu_attach_handle is expected only when an iopf-capable domain is
attached to the device or PASID. The iommu_report_device_fault() treats
it as a fault when a fault occurs, but no iopf-capable domain is
attached.

> Add this handle when the
> replacing hwpt has a valid iommufd fault object. Remove it when we
> release ownership of the group.

The iommu_attach_handle is managed by the caller (iommufd here for
example). Therefore, before iommu_attach_handle tries to attach a domain
to an iopf-capable device or pasid, it should allocate the handle and
pass it to the domain attachment interfaces. Conversely, the handle can
only be freed after the domain is detached.

Thanks,
baolu

