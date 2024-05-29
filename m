Return-Path: <linux-kernel+bounces-193356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33E48D2AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 04:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DE81C22125
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D913C15ADB7;
	Wed, 29 May 2024 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgIP3xwK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48434DA08
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716949104; cv=none; b=cuPGE1EVQ+KwNjLDCqee6JaOnzHueAly2FzVyeoCLXurNX6jBzpPGgefibeMFBhkzPsrsSVK/aXZ42T4ZlfQEisL3F0NDOIqWVkkszQRpCEr9YAY0d6vtSvtTrtn/7o+kvKGcKH3bHlgO57COJpUhGMZzwqUjzf+pAyXsWJBPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716949104; c=relaxed/simple;
	bh=Dp0w0esPZHFbxFaEukOyeyuxS35gYViPUk4+1XQqDMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AgIKl/HakHwjaqzITo5KplT/Qkfe0ZGDdYoCcQRRXx4f/4Jtgq9OmNCzky5HIC/CczbFMdgTUBehV74pYmXJJTJw59MZ3GZXwMzuMQY7X5uRc5aTaSm2P0pGizlS70xbSAIYBN1ttiHG/A2WkjLdtdn/r4xJpYYBO4OrlHBcNzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgIP3xwK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716949103; x=1748485103;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Dp0w0esPZHFbxFaEukOyeyuxS35gYViPUk4+1XQqDMo=;
  b=FgIP3xwKPNbJN4JeatVXOXlBtdRkucFkHWKJDC1B5SQjn6wM+dc/WiM0
   FbWdR3IOAAlZF2QDKTHsDTSLaaOIK5Vpen3Fs2kPGFaKPhCIJjUhTXVje
   zCFyGZDEI67IsLO9pgynOrmTd63XHYplAtYwyJj0rMA+EAPgfPS2cks2r
   IGCdbyzvLpxMeEqbhRKCyClGPY4NY/T3tG5hQgJak80PI8LmieM8/Ktky
   XTFNnnfC4HBai/NBdWio/EGqI93CFUvoUQJC5lWAnAyvDIrAvNqYFq0qC
   ZaX981xAqpUov74kSD+4hC0iOoxjtQ4xJA7Eb7y+hTRn9MM6juIWJvlWA
   w==;
X-CSE-ConnectionGUID: ujVdAnwZT8mRHyeKtNYzFA==
X-CSE-MsgGUID: Aop9WeVvRg23rEuXFHBoBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30830777"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="30830777"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 19:18:22 -0700
X-CSE-ConnectionGUID: JIG75TKJSjer5iNdObqoqQ==
X-CSE-MsgGUID: HjV1AhmCTkWHJYrEayPf+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35740713"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 19:18:18 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: Dave Hansen <dave.hansen@intel.com>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <kernel_team@skhynix.com>,
  <akpm@linux-foundation.org>,  <vernhao@tencent.com>,
  <mgorman@techsingularity.net>,  <hughd@google.com>,
  <willy@infradead.org>,  <david@redhat.com>,  <peterz@infradead.org>,
  <luto@kernel.org>,  <tglx@linutronix.de>,  <mingo@redhat.com>,
  <bp@alien8.de>,  <dave.hansen@linux.intel.com>,  <rjgolo@gmail.com>
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
In-Reply-To: <20240527225843.GA50818@system.software.com> (Byungchul Park's
	message of "Tue, 28 May 2024 07:58:43 +0900")
References: <20240510065206.76078-1-byungchul@sk.com>
	<982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
	<20240527015732.GA61604@system.software.com>
	<a28df276-069c-4d4d-abaf-efc24983211e@intel.com>
	<20240527225843.GA50818@system.software.com>
Date: Wed, 29 May 2024 10:16:26 +0800
Message-ID: <87le3t5pmt.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Byungchul Park <byungchul@sk.com> writes:

> On Sun, May 26, 2024 at 07:43:10PM -0700, Dave Hansen wrote:
>> It has absolutely not been tested nor reviewed enough.  <fud>I hope the
>
> It has been tested enough on my side, and it should be reviewed enough
> for sure.

I believe that you have tested and reviewed the patchset by yourself.
But there are some other cases that you haven't thought about enough
before, as Dave pointed out.

So, I suggest you to try to find out more possible weakness of your
patchset.  Begin with what Dave and David pointed out.

> I will respin after rebasing the current mm-unstble and
> working on vfs shortly.
>
> 	Byungchul
>
>> performance gains stick around once more of the bugs are gone.</fud>

--
Best Regards,
Huang, Ying

