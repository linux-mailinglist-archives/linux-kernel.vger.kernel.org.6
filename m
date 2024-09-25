Return-Path: <linux-kernel+bounces-338068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80E3985303
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB031F24A19
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7006F1553BB;
	Wed, 25 Sep 2024 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mq28uiF5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B53155385
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727246333; cv=none; b=XWv2jSY0P+KY3oN4bE2ut4Yus6FESLLKA2hE6xE1HPvFokyg4ivKZfGVSrzmxFE0LRFNdkYeq079JezE0TCv/k8dcHPIepEfp8Ou9L1z6w31SOIwbqMxrXsX/U5kEaPqgeiPnPOVT6PGrQvO9aJBuRuw7dqayfSYgZkma5+PW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727246333; c=relaxed/simple;
	bh=6wHn1ZNBI3zflu9447QZxVNpa2XP00kGb6kIjvg9OHc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WkkgSlm7zUJ8BYomqC8C+UyR7F6fB5DvVSPnfm+cwmORC1Ulwtab9Ds6SKpKss3drR/gT41Tdg3wqKFEjkrXQzydQTD5bJcBPU9QGuT+L3qMTzqQ/xDkbnIZvi6X0ihTRpqjdAJbShji0jsizuwF5VNvQNix7FEl9KbQlxGXIu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mq28uiF5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727246332; x=1758782332;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=6wHn1ZNBI3zflu9447QZxVNpa2XP00kGb6kIjvg9OHc=;
  b=mq28uiF5rTfKEbKOBckqLKyCzfUvA9ehB3J1zXzyo3khbXQ275BG2j2M
   lOAoz47bP2K4u/LOY3htAKuqtzAm+51rvf390SngN+jmlJ2/Hrvu5oFKc
   zESzVMbJWxe4gNXgkPUTCQZAefRECA3NkRhyrktUQ6NVdym0X9aWt/AoK
   ywuIOXOH3pnlNw0ujAVJmRtiMOYGthQfH46itH3Sh1KdUnN+kgTmtANhi
   rffPNivBAsCf41KMfeJGkO9wt7z5olhda2lm2Wk/LeeVZdXkfiZQv+E0J
   fkOGT33Z8UdMlNP2sC7mYP/D691W+FtQTgEZXY0sLwXQIC1rDjQdbvEKw
   g==;
X-CSE-ConnectionGUID: SAwW+IJdQUa1xVG1h5yX2A==
X-CSE-MsgGUID: FLcK54uAR+2rEdlLDYPfiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="36940834"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="36940834"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 23:38:51 -0700
X-CSE-ConnectionGUID: Z0w/Ygh3QESI6yjFVM6kuQ==
X-CSE-MsgGUID: iK+2YeupSDaBoFONzkeRjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71543955"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 23:38:47 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <hannes@cmpxchg.org>,  <yosryahmed@google.com>,  <nphamcs@gmail.com>,
  <chengming.zhou@linux.dev>,  <usamaarif642@gmail.com>,
  <shakeel.butt@linux.dev>,  <ryan.roberts@arm.com>,  <21cnbao@gmail.com>,
  <akpm@linux-foundation.org>,  <nanhai.zou@intel.com>,
  <wajdi.k.feghali@intel.com>,  <vinodh.gopal@intel.com>
Subject: Re: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
In-Reply-To: <20240924011709.7037-1-kanchana.p.sridhar@intel.com> (Kanchana
	P. Sridhar's message of "Mon, 23 Sep 2024 18:17:01 -0700")
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
Date: Wed, 25 Sep 2024 14:35:14 +0800
Message-ID: <87v7yks0kd.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kanchana P Sridhar <kanchana.p.sridhar@intel.com> writes:

[snip]

>
> Case 1: Comparing zswap 4K vs. zswap mTHP
> =========================================
>
> In this scenario, the "before" is CONFIG_THP_SWAP set to off, that results in
> 64K/2M (m)THP to be split into 4K folios that get processed by zswap.
>
> The "after" is CONFIG_THP_SWAP set to on, and this patch-series, that results
> in 64K/2M (m)THP to not be split, and processed by zswap.
>
>  64KB mTHP (cgroup memory.high set to 40G):
>  ==========================================
>
>  -------------------------------------------------------------------------------
>                     mm-unstable 9-23-2024              zswap-mTHP     Change wrt
>                         CONFIG_THP_SWAP=N       CONFIG_THP_SWAP=Y       Baseline
>                                  Baseline
>  -------------------------------------------------------------------------------
>  ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd deflate-
>                                       iaa                     iaa            iaa
>  -------------------------------------------------------------------------------
>  Throughput (KB/s)   143,323      125,485     153,550     129,609    7%       3%
>  elapsed time (sec)    24.97        25.42       23.90       25.19    4%       1%
>  sys time (sec)       822.72       750.96      757.70      731.13    8%       3%
>  memcg_high          132,743      169,825     148,075     192,744
>  memcg_swap_fail     639,067      841,553       2,204       2,215
>  pswpin                    0            0           0           0
>  pswpout                   0            0           0           0
>  zswpin                  795          873         760         902
>  zswpout          10,011,266   13,195,137  10,010,017  13,193,554
>  thp_swpout                0            0           0           0
>  thp_swpout_               0            0           0           0
>   fallback
>  64kB-mthp_          639,065      841,553       2,204       2,215
>   swpout_fallback
>  pgmajfault            2,861        2,924       3,054       3,259
>  ZSWPOUT-64kB            n/a          n/a     623,451     822,268
>  SWPOUT-64kB               0            0           0           0
>  -------------------------------------------------------------------------------
>

IIUC, the throughput is the sum of throughput of all usemem processes?

One possible issue of usemem test case is the "imbalance" issue.  That
is, some usemem processes may swap-out/swap-in less, so the score is
very high; while some other processes may swap-out/swap-in more, so the
score is very low.  Sometimes, the total score decreases, but the scores
of usemem processes are more balanced, so that the performance should be
considered better.  And, in general, we should make usemem score
balanced among processes via say longer test time.  Can you check this
in your test results?

[snip]

--
Best Regards,
Huang, Ying

