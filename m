Return-Path: <linux-kernel+bounces-276032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81635948D80
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8C22864C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB311BE860;
	Tue,  6 Aug 2024 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9ap+3vL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6B13B2AC;
	Tue,  6 Aug 2024 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942948; cv=none; b=q787YMAevJF4ety1vOKrlzI9Cx6kiJ6n63MnxzyqO+s0kO5F0c8qMhiEqkJgVK9pq+oqCdLGdxa5kZxDmQga3yYJTCEUs19pkx8eC+MjjYvh159KS6UsAzzzqD8dFr8DZys8lHJSlBdSjY98pqtRkq2iDkog3X/Cdx9yz3isItc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942948; c=relaxed/simple;
	bh=s+G81tyZqovaJUdQz429NtvzwlU8vfixIJ0gMH7ho3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cy34773lXutD5VJTkUFJQXtNxX2dgXy070iZOG8dr4NAvIQVrTiL+zCU+bPaeLm3KyplrFULXl7LFgXowkRpSMnC2O/SSocU9KswTYCfmNGSA4quZFDYJHXIyweYUajfQV2ipDTbatyJt6OWnnvGRcBHWUPkHz8677G3APMOxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9ap+3vL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722942947; x=1754478947;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s+G81tyZqovaJUdQz429NtvzwlU8vfixIJ0gMH7ho3o=;
  b=j9ap+3vLl/VTqW7OEwwUr7jzcu6IfEcoZeunXRqKLJM65wVKe609Fn1M
   rdUdvctx3yo8bhTv00mzilZtQ5oR7xrykAvKp1lWn5obsMCGRJyrfzh5R
   s2OdjyiZqR7r5Px1wvVzdDft2qsCRjuUMrkBBj7H/my+V6xbVMWjraUgi
   3ddwVICOPwvlC2BJae0ydi0I4hyWu7z5mbW+Rw2xLJerp4wdVrg3VfJHP
   eyET9e0qyaRkamTHzRApQSn4jHw1oewgWUQcbIPyU3rhHVHZk18V3lKds
   8nRI1RKBBKax7DNSBdj82/7/rii7J7Pc2olWlJttNUpIYfYDlFLpBOmq4
   w==;
X-CSE-ConnectionGUID: HHfj4hb6Rxe3bDoKdMqHKg==
X-CSE-MsgGUID: kvzsfU51T6qJhTbunwi93g==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20803413"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="20803413"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 04:15:46 -0700
X-CSE-ConnectionGUID: T257Zig2SNq3OKcuDMykJA==
X-CSE-MsgGUID: BVaCOA+aRqGlFKUlOXdTRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="79737483"
Received: from nneronin-mobl1.ger.corp.intel.com (HELO [10.246.33.105]) ([10.246.33.105])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 04:15:43 -0700
Message-ID: <010cb430-b0bd-40f9-897e-b48e326a9caa@linux.intel.com>
Date: Tue, 6 Aug 2024 14:15:23 +0300
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
Content-Language: en-US
From: "Neronin, Niklas" <niklas.neronin@linux.intel.com>
In-Reply-To: <9409f3d3-02d1-1e31-a6da-056b44a9523f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2024 12.25, Jinjiang Tu wrote:
> Hi, Niklas
> 
> The commit 66cb618bf0bb ("usb: xhci: prevent potential failure in handle_tx_event() for Transfer events without TRB")
> has been assigned with CVE-2024-42226, but the commit has been reverted in 6.1.99 and 6.6.39 due to
> performance regression. Do you have a plan to address this issue, or if this CVE should be rejected?
> 
> Thanks!
> 

Hi,

Currently, I have no plan to address this issue.

The commit in question, was not intended for any previous Linux versions.
It was created as part of my handle_tx_event() rework series. Future changes
in said series could potentially trigger the issue, so preemptively preventing
it was both simpler and more secure.

Thanks,
Niklas

