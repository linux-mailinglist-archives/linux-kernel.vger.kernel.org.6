Return-Path: <linux-kernel+bounces-570628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09590A6B2CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 03:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F2818937F5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D13E1DF27C;
	Fri, 21 Mar 2025 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pzu4x2FC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B82AE86
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522435; cv=none; b=mUmxyj9/vBFzZW8ZAommRh09gCPhLXtu2BjES67UT1NwkKmmo7N3cDp/jA0VuhQ9AwDqyjOmN5nQLbO/uc2GflitA0/q9PdR4zkUHhf7wHqEPsY3LI0ZlmBhmLpLlpulgqQsL0USXbZ99KzyuthRaTimfoqcnF9cECEbshSJ6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522435; c=relaxed/simple;
	bh=rlCVkw5ZX43bC/gzLxhNDt0NhIkin2kMDfC7zFKIdAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDpWNt0PVsnQoAPNS2nfD8ucpz9MQg3CyoYFVFwhYwM+gZW8jCTPxwQIAUReWW2DcK0n55Bp0SyUlV0BWWEmUH1xz27EO1Bu6mdjArWQr+q/k8Bdfwx4N37INHjDdQ5M0PdYUGu8afipZcEuH+IAB2tNmwaJeHW9CA6gieeGZm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pzu4x2FC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742522432; x=1774058432;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rlCVkw5ZX43bC/gzLxhNDt0NhIkin2kMDfC7zFKIdAw=;
  b=Pzu4x2FCvBipERr/6cE8+R8f2NQbI156KrOziE/qyYKisY4t5E0nF6YC
   VP3IXwWrVhMEOVI120KWlNg8IRG5mI5etjd8hpiDJh5zA0urcmLKR8lOg
   NmbRwcX/Bj1q8oZ1SDJvdsXDuWvyK9sllDH1nm23Xs1dNOp4X2NisdKQc
   2axBY0Vd0JTUTstZZnHx+lMhCU55TXReaXTzjtI37DNty0J3lUNemsiph
   K02DAzo6Rvjo7SyOiJdHXWX3m9tWG6w1SCcNZK2oT9tFx9Od6ME7bcODM
   VERIM3mdqDoutGfzni/rKjHoxJsepU7fDn2OY+Y8yzoEeBtx6bzL8u0bD
   g==;
X-CSE-ConnectionGUID: oCneNThjT1m46CAYEkexwg==
X-CSE-MsgGUID: fG/Iuju6TGORWOZT+iBs5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="42943932"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="42943932"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:00:31 -0700
X-CSE-ConnectionGUID: CrlfnmdeSZm15opnXITadw==
X-CSE-MsgGUID: FyQtCgQHQ7Opihis+Ybv4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="124216025"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:00:30 -0700
Message-ID: <fcb6a265-8b87-43df-83d5-1b10adee3911@linux.intel.com>
Date: Fri, 21 Mar 2025 09:56:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] iommu: remove duplicate selection of DMAR_TABLE
To: Rolf Eike Beer <eb@emlix.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Bert Karwatzki <spasswolf@web.de>
References: <12652899.O9o76ZdvQC@devpool47.emlix.com>
 <2797918.mvXUDI8C0e@devpool47.emlix.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2797918.mvXUDI8C0e@devpool47.emlix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 17:05, Rolf Eike Beer wrote:
> This is already done in intel/Kconfig.
> 
> Fixes: 70bad345e622 ("iommu: Fix compilation without CONFIG_IOMMU_INTEL")
> Signed-off-by: Rolf Eike Beer<eb@emlix.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

