Return-Path: <linux-kernel+bounces-338162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635C0985427
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278CD289B60
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75780156220;
	Wed, 25 Sep 2024 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTFYtNGB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A47155C9E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249290; cv=none; b=Q8gHGUz5a3l5vUHR3mWyhf8xisSMT47ELd7wtf0I2oOJTUFVY9qW3X0imwPYVCJk7s27oRjrowqCt6cA7cD12HV0MTuxN3Dmyj8UJkCwCX7Ap+I3N38ec28AlK6NF0YZc5eFS0JmyQ99EAXvpm4+bznH0UCg/Z4t9CE5ZFuDShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249290; c=relaxed/simple;
	bh=Kkewmrev2iH5H4ElHOFzJ6CsI/+RVBocoBilT8N5lr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UL3YH/zDRFQpYv80V3BVMViPspELPoCAmOaTPV4LlBf/fjnpOmVHeqvPywgstGUSJgtOoges0O9TSY+8/4YBF/LavtUednKteZO2vBHLZW2Z1w9IPRyys20v4JMZ2sTa6JrHWnq8HkYLicqwGHiCRKUYq2FEMbcdkPM+2cWJVa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTFYtNGB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727249290; x=1758785290;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Kkewmrev2iH5H4ElHOFzJ6CsI/+RVBocoBilT8N5lr8=;
  b=GTFYtNGBZVIKQBXgCG0DP9Glo504in3SqdvXvOu2IHidMe8hKyXLXKQC
   IeZiWcnGuPVMtj4iu2RDR0EaMOaVNUnfOvQc4UPrM70Sq5crpvnQzANbp
   z06px5/5kN/D5AOq/9vs7u8Gwlj8BVMX/aoZ/Tnqyu/JVULIDg/w+L/tP
   4b4HsXZcPORGNvvu2Q+zOw60YZEXZLTL2GY/ex20sQ+h9/z7AzfBpqa6b
   MN0ZwYYKuJt62zrEiPMqFzMAgdN5gAHrKKNP5oHkp8BvUqExSnv5xIHj3
   NwwMtbNZtQVIjbBlSB9EWiNlaMLpxVvRP5i2FPhFuKxhzgs+L5wM/wgew
   g==;
X-CSE-ConnectionGUID: 32pUBVB3TdWKG1xyKtwyXg==
X-CSE-MsgGUID: ORUSZUnWTreIzxeOFYPYaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="43757473"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="43757473"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 00:28:06 -0700
X-CSE-ConnectionGUID: 25X4d6wmQ8+am0iBPv+ulA==
X-CSE-MsgGUID: iWb0+dgCR8G5fmf2SYwYJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="102502028"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 00:28:01 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>,  Nhat Pham <nphamcs@gmail.com>,
  Baolin Wang <baolin.wang@linux.alibaba.com>,  akpm@linux-foundation.org,
  hannes@cmpxchg.org,  hughd@google.com,  shakeel.butt@linux.dev,
  ryan.roberts@arm.com,  chrisl@kernel.org,  david@redhat.com,
  kasong@tencent.com,  willy@infradead.org,  viro@zeniv.linux.org.uk,
  chengming.zhou@linux.dev,  linux-mm@kvack.org,  kernel-team@meta.com,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
In-Reply-To: <CAGsJ_4yMxNsmPJn0W9puKWcQD3T7RDyQ=QmPhAtoq=3_u=m+TQ@mail.gmail.com>
	(Barry Song's message of "Wed, 25 Sep 2024 14:26:52 +0800")
References: <20240923231142.4155415-1-nphamcs@gmail.com>
	<4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
	<CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
	<9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com>
	<CAKEwX=PiOdrR7Ad5XoT8pRZDLB=q6B_fmwQ3ScgWFPNptBuHPw@mail.gmail.com>
	<CAJD7tkZFu3DbovTwyRdQmEG=7nQtmzrjQVgyhE4mNzbCtZxFZA@mail.gmail.com>
	<CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
	<CAJD7tkaZwkBbMPaL0mUNyftOUxOgMsAk1KDupZqPq0SO-zeZcg@mail.gmail.com>
	<CAGsJ_4yMxNsmPJn0W9puKWcQD3T7RDyQ=QmPhAtoq=3_u=m+TQ@mail.gmail.com>
Date: Wed, 25 Sep 2024 15:24:28 +0800
Message-ID: <87jzf0ryab.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Barry Song <21cnbao@gmail.com> writes:

[snip]

> I am perfectly fine with the approach, in the first loop, if we find all entries
> don't need CONTINUED, we can run the 2nd loop even for usage==1
> and nr > 1. this is almost always true for a real product where anon folios
> are unlikely to be fork-shared by so many processes.

One possible use case is ksm.  Where the map count could be large.

--
Best Regards,
Huang, Ying

