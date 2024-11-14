Return-Path: <linux-kernel+bounces-408489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E529C7F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A211F22C98
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7761172A;
	Thu, 14 Nov 2024 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5RcN9zs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59BF4FA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731544654; cv=none; b=kuLDu2IZ8kJpA6B7vZ9pNmInaqK+5bTngCkVF/CJN21MEkI0RFy9JUfQW/iZhMcOx4iWy31fA4c7TPWUwgEs1cf34R+2I9lCko4G+qq727zsRrlSWCF/omUJz9m6hPawGjFKOWZA3BpsVz59RUbRsNWbnZwp4IdJi4Nv0mV/3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731544654; c=relaxed/simple;
	bh=ul/p5tGhzdXXOd8O/DNHNnOAm6m7djyj9W0rJLaMb+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYQP6z4LL4vkuo3DT+Hde9VAc05Pb/RRZp18Gy4IFnqhqE9gySmCjkIExGdMYs9LXR+5AbvW00d6oGluXBIJPCHf8JRXmBpWupC7PVyQioKpeaqvb4+x/Sgnk2fa4xQanus11dF2C9lC2wm7lPmqaYJc+Re6vyIzQm70QlyrTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5RcN9zs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731544653; x=1763080653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ul/p5tGhzdXXOd8O/DNHNnOAm6m7djyj9W0rJLaMb+8=;
  b=T5RcN9zsCvIB8MVs9lMvqFu6PQE52kjTQ8CyZcKYBOKBDzupGJuFdXx5
   FM4AzXb9uVq0GgZFRfQ+FHxT+eHoY00X14wXVPa3+JY/CzY18bEBfe1aL
   T4G6c7uZoeWpgryuarT34vMF6jFWLTjWgj/4mMZw7xNRDK585NQKYo6Pu
   fn6pwx6FOJZG6q+AnMsZPDDcNLaEe2EbwCmh6u8QZrJjMRi1nxWudlENu
   8K1XuxKi0YOFi0CsJ/qSVZaWeYXrDJpyO/Oc0GVs7lauooW33g3nxvqn5
   kYeS10kUaTqUmmbEYPcdnRyjsKOjKDtTDTBwoHVI7QopxG1gNRbu9xzTm
   A==;
X-CSE-ConnectionGUID: j1PpNbF0QqGW9kgBuFmaEg==
X-CSE-MsgGUID: d7kkw154T1mdotpm5R5jHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="42580518"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="42580518"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 16:37:33 -0800
X-CSE-ConnectionGUID: gx43qFLGTImbVMUWiSmgLw==
X-CSE-MsgGUID: KCXu9t2MSjeLW+GrtKVMVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="92953371"
Received: from kkkuntal-desk3 (HELO [10.124.220.196]) ([10.124.220.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 16:37:32 -0800
Message-ID: <844f58da-638f-4a91-88e7-f66f7fcefe51@intel.com>
Date: Wed, 13 Nov 2024 16:37:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] x86/cpu/bugs: Consider having old Intel microcode to
 be a vulnerability
To: Alex Murray <alex.murray@canonical.com>, dave.hansen@linux.intel.com
Cc: bp@alien8.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 x86@kernel.org
References: <87v7wtvty0.fsf@canonical.com>
 <1c1015f8-1a47-4e5b-b088-f83054d2f613@intel.com>
 <87iksrhkv8.fsf@canonical.com>
 <7fc07eff-b4a1-4f8d-a9de-dba057d5c9c6@intel.com>
 <87h68avg81.fsf@canonical.com>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <87h68avg81.fsf@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 15:58, Alex Murray wrote:
...
> The only other data point then to mention is that all the major distros
> (Debian[1], Ubuntu[2] and Fedora[3]) are still only shipping the previous
> security update release (20240910) in their stable releases - *not* the
> more recent release with the functional updates in 20241029 - in which
> case anyone running a current stable release would then show as being
> "vulnerable". I can't speak for the other distros, but for Ubuntu we
> generally only ship things which are called out as specific security
> fixes in our security updates *and* we generally prioritise security
> updates over bug fixes (which these 'functional' updates appear be
> rather than fixing actual exploitable security issues).

That's a very important data point. Thanks for that.

Like I said in the original changelog, I'm open to relaxing things to
define old to allow folks to be a release or two behind. But I'd want to
hear a lot more about _why_ the distros lag. I'd probably also have some
chats to see what other folks at Intel think about it.

So what would you propose the rules be?  Are you suggesting that we go
through the microcode changelogs for each CPU for each release and only
update the "old" revisions for security issues?  If there were only
functional issues fixed for, say, 2 years, on a CPU would the "old"
version get updated?

>> So I'm leaning toward setting:
>>
>> 	TAINT_CPU_OUT_OF_SPEC
>> plus
>> 	X86_BUG_OLD_MICROCODE
>>
>> and calling it a day.
> 
> Does this mean you are thinking of dropping the userspace entry in the
> cpu vulnerablities sysfs tree? 

No, I plan to keep X86_BUG_OLD_MICROCODE and the corresponding sysfs entry.

> If so then I am not so concerned, since my primary concern is having
> something which looks scary to users/sysadmins ("your CPU has an
> unpatched vulnerablity") which they can't do anything about since
> their distribution has a different definition of what counts as a
> security update compared to the upstream kernel maintainers. If the
> sysfs entry is dropped then this is not so visible to end-users and
> hence there is less panic.

Right, we don't want to unnecessarily scare anyone.

But if a distro is being too slow in getting microcode out, then it
would be good to inform users about known functional or security gaps
they're exposed to.

That's the thing we need to focus on.  Not: "Can users do anything about
it?" Rather: "What's best for the users?"

