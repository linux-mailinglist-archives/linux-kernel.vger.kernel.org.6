Return-Path: <linux-kernel+bounces-291569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BCF956426
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1B61F22A48
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F60156230;
	Mon, 19 Aug 2024 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqC+d0pt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D238DD2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051507; cv=none; b=rvCOsTe84bxv/SsIjM1qwa7daS0k0QRUhsnDI+g8dw7AhyJab3WzmTNQSY7gRhc7K7IUnNf5ZLyIxxw3ATbXsnLQLe8D6udHZ/NToJ4sU1FcmViCCmjFLEf3zQ8Z7OEzZOjTGCxofK2g8hIhxp7ZBZGpNK1RIoQz37UOzssGIww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051507; c=relaxed/simple;
	bh=QJBIeiuPxgHxdTDaJFO5DYv548lOaI7cX/Ias6zohmk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t7mgn/DsbaYwQNoy41Mc2EVBEAuHWaFuH7P2L+mka/jEXdDQJc93KF/Bm8h+kJ427QpEhJYDbdtFFFUEUBdDEPV+ipITVFEp17g3l+T7FQEV88TbSGzxr2UfDGdpxYCqMdcfbnoKuWxQq+SXLZwFW/hK/2vTXCzlWZa6o4IewYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqC+d0pt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724051506; x=1755587506;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QJBIeiuPxgHxdTDaJFO5DYv548lOaI7cX/Ias6zohmk=;
  b=BqC+d0pt+KYtOMftICybE3UX3/af/kAqYS/Kpr7LbE+wXOiQLzd1EGBV
   VqpY9+j/lK1EXZ5D1BL+YVzmQXdohdT+h3pNXBH0HzjWVMIkkZQlnW0wq
   pnCYUnGjLS7fSaMzwqN2H0uSatCETuwij+CpVyEJy+r/0GWb20Lvi24nC
   FxN6zeL56gZiIxhO6xGcT1pJzRFe7q6FlQFbL79U8Dn1ZvzdsGTPhLtiy
   cGo2KdbOYcVqUaEU0lJxTXPvbbC0iv2Pk9KByfSF8G2ZkCAhL077YCXit
   nVfWhdXyMbu2Z0bwwUKQI1eLuEOz9tCsZ+vYZz7NzUbMg8zx1+n5iawaB
   g==;
X-CSE-ConnectionGUID: Aif4HEPxRYCFU7cJDDRQdw==
X-CSE-MsgGUID: 2FzPNqLwR1qMFw9yJZ2LeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22441715"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22441715"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:11:45 -0700
X-CSE-ConnectionGUID: 7InyqULgSXmW9JMfejmPFg==
X-CSE-MsgGUID: Pf7n6xnfRLuMBqo97JOS/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60583675"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:11:42 -0700
Message-ID: <d3a8bba9-cd42-4034-9a3b-dc6c7bbe9448@linux.intel.com>
Date: Mon, 19 Aug 2024 15:11:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
To: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
 <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
 <635b24b7-632d-4046-b82e-6ac6976686c9@amd.com>
 <0e807eec-ce51-42e2-9290-dc90c4210888@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <0e807eec-ce51-42e2-9290-dc90c4210888@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/19 15:09, Baolu Lu wrote:
> Yeah, so the iommu driver should flip the PRI switch on the PF whenever
> someone wants to turn it on for its VF.
> 
> We could change things up so that when the first iopf-capable domain is 
> attached to any VF or PF, we turn on PRI for the whole device. Then, we
> turn it off when every VF and PF have such domains detached.

Please ignore this. I forgot to remove it when writing the words. Sorry
about it.

Thanks,
baolu

