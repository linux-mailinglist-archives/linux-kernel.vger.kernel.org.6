Return-Path: <linux-kernel+bounces-305923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927BA963670
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E703285C72
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE23D1AC439;
	Wed, 28 Aug 2024 23:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iroZrLvg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B4146A63
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889015; cv=none; b=QdaE0ZacU9M7+a9HnuiiLN05vYPX5C7KEkpXNeDjBRjIePC8j5dtTWyaTV4EDEU8W+xayAArlqWJzeLJcbl6LxKBUm4IGp8v9Id2zed0hOzYgu7TxCuJSE+TqbgXt4ZTllOB3I7KmKyuZGUL5T7E3TTT1XxH+IvGjvWC76dcjHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889015; c=relaxed/simple;
	bh=hf0NC6/Ti77SgAvzqinYfV65iamF/H8OBPDFYkr2WD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3tOwgExZZlFUTMi9noj2hLSY+IM0Sf1U93LMayAaKVYnKI3Q9eTHoGALE87nC4NqvjR/Db9ubAfBR+MwJf4+miwsuFebgyIGJ0mBCxNyaXcq8XaQ3zw2BoNY3etGovBBDRIdIegB+muwdw0371+VSkLKG9z5s12T3TzvmgEs4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iroZrLvg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724889013; x=1756425013;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hf0NC6/Ti77SgAvzqinYfV65iamF/H8OBPDFYkr2WD8=;
  b=iroZrLvgp/MzkJBoSASE19z6P6OGtEXkA5BrBKLXP9SaRk/hkmqyocHR
   ljG3MAaFYsflgHyp29hv+/4ZpyMRhWMPs0keCwXJR3XJqCiwOg79ViI68
   FDu6OKk6PRtTqodstg4Dhj7ZpJG8CaaFH64VXbIJ1lxMGik5OP5BKAYyK
   M6kuqtgSREQ03bT8t+KVqN4foYP6qc+EuWYzxwhnWttXKUMnsnwtjCeKJ
   WF3hV9khLjFvA1tJ6m8d7lEmUXpQlRcESSAd1YGYZOggT3A2KUbwjIDxi
   UWYEVumA7MOWNJTKLHIoBwSBq2By85ge7e618XxOb91AS20ULUAvsjMCf
   g==;
X-CSE-ConnectionGUID: yuQWRpVSQhS17QZ76eTJWQ==
X-CSE-MsgGUID: yK8AeCPhTv6dwzUyyMzEyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="40928322"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="40928322"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 16:50:13 -0700
X-CSE-ConnectionGUID: oLmlIFkFQpS3x2AYpS42HA==
X-CSE-MsgGUID: FtMEY2YgTSmSDuiqlahgyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68165861"
Received: from njkybert-mobl.amr.corp.intel.com (HELO [10.125.160.160]) ([10.125.160.160])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 16:50:12 -0700
Message-ID: <dc28f36b-87fa-4aac-8578-6468ae311b16@linux.intel.com>
Date: Wed, 28 Aug 2024 16:50:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/bugs: Add missing NO_SSB flag
To: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc: pawan.kumar.gupta@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
References: <20240828224011.4043872-1-daniel.sneddon@linux.intel.com>
 <9e510f2e-4b11-4001-b6c0-7a3766b8abb4@intel.com>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <9e510f2e-4b11-4001-b6c0-7a3766b8abb4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/24 16:36, Dave Hansen wrote:
> On 8/28/24 15:40, Daniel Sneddon wrote:
>> The Moorefield and Lightning Mountain Atom processors are
>> missing the NO_SSB flag in the vulnerabilities whitelist.
>> This will cause unaffected parts to incorrectly be reported
>> as vulnerable. Add the missing flag.
> 
> It'd be really cool to add two things to these changelogs: First, who
> figured this out and how?  Basically, who cares and why?  Second, what
> public Intel documentation supports this change?

The first thing I can do no problem. The second..... :(

