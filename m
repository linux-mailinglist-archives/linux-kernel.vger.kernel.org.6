Return-Path: <linux-kernel+bounces-386294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60289B419D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 05:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617DC1F236AC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DEF1F4FA8;
	Tue, 29 Oct 2024 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPfueiAd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A8F1DD543
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730176884; cv=none; b=ARLc+438KCEsCb0XMjxa2l1wfia437mmu39Gxsk5Ue1CHbKjyYGTexgF66yYxUqr2Xj5TdhgzPMbuox+nwmu7pedNOCygVffI3WCEdEfyrr7dKTYQtb8BRXiTBRR4wiaTrCZ+zbdadEssLVRXGX9I1Y1kaklIKe5m92mDsf3z3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730176884; c=relaxed/simple;
	bh=/lGgzYCuXKNlA3wX0mmt+/FRFK+05gsYDqzyxHNFDJw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CpwR4WjYYLBUFBjuGTPJ9zcffFjqFZQGI35osPZ7oNBsWdA40matgFmrDQ9/uijdvwo4aO5odRsfaWl09hYL0rxmxgz35BT8KYKPMvE+LP8Udn/Qj8SUZELU7dzdyc1aeX5y/3UqzVe001DPXhYxOeOEYJcdDPoRbsO5JClKR6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPfueiAd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730176882; x=1761712882;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/lGgzYCuXKNlA3wX0mmt+/FRFK+05gsYDqzyxHNFDJw=;
  b=HPfueiAdMg7E8NCaViwlS2lisrbqfwPaBYdiaKdk2i5NoNsxFLYWxEM9
   2Mah3S5fBptOANbUnjLC5xK3LWnjVKBXllggDJItyeqFiFKiD4qr3lwam
   VWxkR+5kR7HwqwcbCfiepgfOrf3MAsG/Pj+xpEpzEjOK1pdBn1BA56KZH
   jEXWZcSTsVtG6xtW9KLQGOOh1SMbSdooo5jd/iQksSMjQY0mw0TN0BEIz
   OvAmd+oNl2PsHMCRAAi9KilGX7ozu2m5XvtA18x+i8n9eWpv1/jyxUL/k
   N9yJZSaG74EaXNWlHIcprRs0bkLpWLcKzfCpKC598/3xrqdzCuiVPLluW
   Q==;
X-CSE-ConnectionGUID: mJyO3byHQVqC3X66XKgBFA==
X-CSE-MsgGUID: PaAaDIfIQvGf8rB1JIiPwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="32655997"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="32655997"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:41:22 -0700
X-CSE-ConnectionGUID: u2v94uqrSX2Z3iF/czjreA==
X-CSE-MsgGUID: m+idzGaDST2Kr16oLni5mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86966215"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.238.0.51]) ([10.238.0.51])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:41:13 -0700
Message-ID: <cd377b12-5982-4c41-9f82-ee35cd8a6433@linux.intel.com>
Date: Tue, 29 Oct 2024 12:41:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Remove unused dmar_msi_read
To: linux@treblig.org, dwmw2@infradead.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com
References: <20241022002702.302728-1-linux@treblig.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241022002702.302728-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/22 8:27, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert"<linux@treblig.org>
> 
> dmar_msi_read() has been unused since 2022 in
> commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> 
> Remove it.
> 
> (dmar_msi_write still exists and is used once).
> 
> Signed-off-by: Dr. David Alan Gilbert<linux@treblig.org>
> ---
>   drivers/iommu/intel/dmar.c | 13 -------------
>   include/linux/dmar.h       |  1 -
>   2 files changed, 14 deletions(-)

Queued for v6.13. Thank you!

--
baolu

