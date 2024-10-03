Return-Path: <linux-kernel+bounces-348930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C79A98EDFA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28B02844C9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B8015574F;
	Thu,  3 Oct 2024 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8b/4FUc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B515443D;
	Thu,  3 Oct 2024 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954238; cv=none; b=ZuTQ06LeUshgMV/2qSgcjWiZdIDC/UgOxDyHTGsuQlCe6IFHnqX26hLISnvBqh4sPno2rhHy9txoVBfiPni0jpO6o7B9a+8HHv90PrAWZuWW7gljlxEurxnzm9xqs7tI04n4L78flzmNB44/O3jees4Ogz0BZkHrH9xOF3oTuY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954238; c=relaxed/simple;
	bh=cg7Mvh6oFTofq2z+Niw3rn5LUdRz6GpP7Az25WZ0k+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kCpG+G9oF0YGaA0YEfCZoRsdKezOH5fCteiUDbLNQXifw582uUlDIirZU+rhB1GEQTqfzB8i5Slw7g3Z1xMF80sF2jJhv6ke92KD1sNyMzDu1JeGGUagi8huOT7infukDk8ZBjx95JmZx9sKAS2I6lfwqALi1vyXRLT4ZFJZrzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8b/4FUc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727954238; x=1759490238;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=cg7Mvh6oFTofq2z+Niw3rn5LUdRz6GpP7Az25WZ0k+M=;
  b=c8b/4FUc2inQYLpWzV9DYZ/ryOGfhBpW0HYV0D9Eh6BbqeBpENIwy6H+
   WPvrNLDaLaIG5xgwwn17RaduGfFalg5HGasOrRUG6xvJqGcXwXRhY3mHF
   qi5LU6FpDWBKvM/mf46RYAyCnrJtdD35L3bGWB0DKiB1bMOFJ3yw5lbBm
   qBGzIijBdIRK7IJRXxwpZXGZYAVCkQEOv5xHbuyil0Hc7dFGX8DsXMutr
   sBP6yORUqPyJnnGKnS6/jwMzKQzsJwzwJ5kO1Uw4hqW/kSblDcDZyWSGD
   rYBC4ZC6Ht33bCL0/p9Zz6Ry1J08w99aMAOCJKHI15cZZU1hYI2iS1q40
   Q==;
X-CSE-ConnectionGUID: XZWL0IvuTISr5GM6RutFPw==
X-CSE-MsgGUID: nXNfXxfzSt+TKHiBAfsRXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26614082"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="26614082"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 04:17:00 -0700
X-CSE-ConnectionGUID: orY1OEsMRc+q63EeLhwdxA==
X-CSE-MsgGUID: WLIuvMyCSKSCwVJco2LV6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="74309699"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.198])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 04:16:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: david.e.box@linux.intel.com, hdegoede@redhat.com, 
 WangYuli <wangyuli@uniontech.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tzimmermann@suse.de, lee@kernel.org, guanwentao@uniontech.com, 
 zhanjun@uniontech.com, Lee Jones <lee@kernel.org>
In-Reply-To: <4F742FFF72DFD84F+20240920141704.34373-1-wangyuli@uniontech.com>
References: <4F742FFF72DFD84F+20240920141704.34373-1-wangyuli@uniontech.com>
Subject: Re: [PATCH v3] platform/x86/intel/pmt: Correct the typo
 'ACCCESS_LOCAL'
Message-Id: <172795421238.1755.12222578182729917985.b4-ty@linux.intel.com>
Date: Thu, 03 Oct 2024 14:16:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 20 Sep 2024 22:17:04 +0800, WangYuli wrote:

> There is a spelling mistake of 'ACCCESS_LOCAL' which should be
> 'ACCESS_LOCAL'.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel/pmt: Correct the typo 'ACCCESS_LOCAL'
      commit: 31440fe70167a1014f2433eb64b9888a24b30fd3

--
 i.


