Return-Path: <linux-kernel+bounces-228211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EEB915C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA6C1C2160E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5BF37169;
	Tue, 25 Jun 2024 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfUa6iSz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11CA23BB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719283524; cv=none; b=VsMl+wdoEMe35wBZayltR5FQkBUV9RBdNcy34Q6vi3OUG2eKiYDSGEYMeQpQ3RKRBEFcu/LsB+d//8HPIkxWXcHTflUiaeWMXfF3ohI4p0uUjWNI8GzvTBfu23Q5LrMscpxvOo+UkUSgQmLQwcOW0Nn5qwfTNwpCWRUlOzsg2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719283524; c=relaxed/simple;
	bh=SBo3zsvA+hf3anXcpG/BxWV2BmU3g1Cm3e/BqUs8Hdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dbnzr03H8GRnVWC9Lngi7pMe2/gXhZJrzBor21ZgNEgiz3sFow5hp4V5MW+sxore6uizJGaEodpFNOTVyqyr/yJvW/+CRy0Kiu3xxmViEtTUq4zcjOQJGLgqkkeVt3lNJ9gfr/3C49zTmfFTC750JE0MoKtvaAH347Xw0xBRBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfUa6iSz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719283523; x=1750819523;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SBo3zsvA+hf3anXcpG/BxWV2BmU3g1Cm3e/BqUs8Hdw=;
  b=CfUa6iSzIUxe0m5tr6M2Fk+VB3h5srRYS2Dwk+vlSCZyDkLmIV2cRnjY
   q3zr3unJUyugkUiMN3Vuztz15HiyXJQSreOqfddAJ5Onr2+7jTdrVuCvD
   Z5izIOeX8MRBceJDpqOcjkSqZWsAyy9ArU8fhM07U7irSIFh3sJnFECfB
   /MnZiglOHJITDoFi4jINd85/hfUnSlW7Yx7T8XUxMvacJ9tTfevbH3ydv
   pTraz8KuQu+8aVCny4PJiqH45XC6MJz0oNSo2CEGrhcgVMVnz1VRq+cmb
   pylWUI0N1I1F9N9yPWTOjQUZlwHwYgVi1ZeL7J5IECg7lUEOs04Wb3JNT
   g==;
X-CSE-ConnectionGUID: GTuEwLarQ4yp9PCQUE/nEg==
X-CSE-MsgGUID: XPpqJLYuRS60PQRWBhfITg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="26967932"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="26967932"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 19:45:22 -0700
X-CSE-ConnectionGUID: 2rZ+Wad2QN+2B/8anrqfQQ==
X-CSE-MsgGUID: G5+r7RjlQdqlmmrhtSBNQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43926544"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 19:45:20 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Kalesh Singh
 <kaleshsingh@google.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v3 0/2] mm: swap: mTHP swap allocator base on swap
 cluster order
In-Reply-To: <20240619-swap-allocator-v3-0-e973a3102444@kernel.org> (Chris
	Li's message of "Wed, 19 Jun 2024 02:20:28 -0700")
References: <20240619-swap-allocator-v3-0-e973a3102444@kernel.org>
Date: Tue, 25 Jun 2024 10:43:28 +0800
Message-ID: <874j9hzqr3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Chris Li <chrisl@kernel.org> writes:

> This is the short term solutiolns "swap cluster order" listed
> in my "Swap Abstraction" discussion slice 8 in the recent
> LSF/MM conference.
>
> When commit 845982eb264bc "mm: swap: allow storage of all mTHP
> orders" is introduced, it only allocates the mTHP swap entries
> from new empty cluster list.  It has a fragmentation issue
> reported by Barry.
>
> https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah+NSgNQ@mail.gmail.com/
>
> The reason is that all the empty cluster has been exhausted while
> there are planty of free swap entries to in the cluster that is
> not 100% free.
>
> Remember the swap allocation order in the cluster.
> Keep track of the per order non full cluster list for later allocation.

The "non full" is a kind of negative naming, can we use "partial" as
that used in "slub"?

[snip]

--
Best Regards,
Huang, Ying

