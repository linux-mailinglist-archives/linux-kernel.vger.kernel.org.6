Return-Path: <linux-kernel+bounces-329856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF1D9796BE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DCC1F21E4D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216CC1C6F76;
	Sun, 15 Sep 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQ+MWmVt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B06B1CF93
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726405106; cv=none; b=WaLsZL+EnzbWKkpTU2m4EmkfvSUqp8eM0a+kW7Yv4iS8YIcTe4WJSsW0PCcWWAY8aYhxKCZKUePzbkjboYIrMc9cf+PARtEW8R6EGAQkhak9UonLujEpf9FoqgG/Cv6GbYXl2/mjuF4UO/bCJeEcVbHyz5HBCK0/MlJElftI588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726405106; c=relaxed/simple;
	bh=gf0gOzd3EtvffqXRuCLoIYfWPpWzA6+4ip6arMkUhq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5/SRl3Uk76UOw/FGKzUeI5tvZyl/VtvleUMgXwz3PpBDqldzC0J2BLiFgAbLqpR2+ZUbDZ+x3mmqBJq3Ai4MvTmPKHCFYh563zWCrEFoQF6AWLGutUynubv9Rf+zxrgmXAHrnANpoXOn3Kbr+jdiOyQXlXZE9Rks2WIFCszEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQ+MWmVt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726405105; x=1757941105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gf0gOzd3EtvffqXRuCLoIYfWPpWzA6+4ip6arMkUhq4=;
  b=LQ+MWmVtR9hwte/EYoF/vZCsFYkx5W8XdIbjV7PuLWQHFg8P1EK/Sqm5
   wwFnI9+EvhxK3y2K8pq6tPD7m6dt1+wBROOn3mqaR0XKCv3lQHuRdqGOV
   herWx6IoSKqYMaW/WoiP+9gBh3CQKQulj94WRCXEBkXGSHSy6eWvHVOV0
   +fgxv0LrJ8M1ZGi2jUSdVr8AKSDMHwtgyU9FreQiOjykdYor8NF/TfADq
   8C1DjG7Hbp2q0h+4v1OxszU+O31GDTdQX0He80CZFMdB0xBry3/9Gjh3z
   1v0hTGaUyWWn8oEEHikMH2ibagSoV3i6JT1FQH/aiIS/kb9BdSTUokhIG
   Q==;
X-CSE-ConnectionGUID: htfrYmAqQKeMqbki/foKsw==
X-CSE-MsgGUID: bIIFu8WxSnmTmsY9JLma1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="25189028"
X-IronPort-AV: E=Sophos;i="6.10,231,1719903600"; 
   d="scan'208";a="25189028"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 05:58:24 -0700
X-CSE-ConnectionGUID: xxvV/HMZQomSBr91ncGFdw==
X-CSE-MsgGUID: GT9JKUL7S8GlHK1IMLKYzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,231,1719903600"; 
   d="scan'208";a="68934586"
Received: from dgramcko-desk.amr.corp.intel.com (HELO [10.124.221.130]) ([10.124.221.130])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 05:58:23 -0700
Message-ID: <4d172613-481b-4b45-aa59-165ef1c7dc9b@intel.com>
Date: Sun, 15 Sep 2024 05:58:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
To: John <therealgraysky@proton.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Unknown <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
References: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me>
 <e5081e3b-0f14-4e1e-975a-a4fd22944fc7@intel.com>
 <OCPUzm9NO5UcsvzQfzIazzMh7nymvY5oz3pBojDqEOlhVrYTdYZ35Il0oi8WkwFN7N-1HpCIPXFgQ3MGT7108YhjiBWWv7RqrC40mlW4ak4=@proton.me>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <OCPUzm9NO5UcsvzQfzIazzMh7nymvY5oz3pBojDqEOlhVrYTdYZ35Il0oi8WkwFN7N-1HpCIPXFgQ3MGT7108YhjiBWWv7RqrC40mlW4ak4=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/24 05:25, John wrote:
>> Why is this copied and pasted six times?
>> 
>> + depends on (CC_IS_GCC && GCC_VERSION > 110000)...
> I believe the version requirement is needed for each of these new
> options.  Please correct me if I am mistaken.

The requirement is fine.

But copying and pasting the same string without refactoring it is not.
You should refactor it:

bool SUPPORT_MARCH_CODEVERS
	depends on (CC_IS_GCC && GCC_VERSION > 110000)...
	depends on X86_64

and then have each site do this:

+config MINTEL_CPU_V4
+	bool "Intel x86-64-v4"
+	depends on SUPPORT_MARCH_CODEVERS
+	help
...

>> Why are there v4's for both AMD and Intel that do the exact same
>> thing?
> 
> I did it this way to selectively include the AMD-specific and
> Intel-specific membership in the config options below.  For example,
> the AMD options should be included in the X86_INTEL_USERCOPY config.

I think you mean "the AMD options should *not* be included..."

...
>> Alternatively, anyone wanting to do this could just hack their makefile
>> or (I assume) pass CFLAGS= into the build command-line. Why is
>> something like that insufficient.
> 
> I believe this would work:
> export KCFLAGS=' -march=x86-64-v3'
> export KCPPFLAGS=' -march=x86-64-v3'

So why not just have users do that?

>> So, taking a step back: Please convince us that this is something we
>> want to expose to end users in the first place, as opposed to having
>> them hack makefiles or just allowing users a string instead of using the
>> existing CONFIG_M* Kconfig options.
> 
> This was just the logical extension of the already included and now
> antiquated options, for example pentium-mmx, k6, etc.
It's probably best not to extend that beast.  It really is a relic of
the past and, practically, all of our 64-bit builds are GENERIC_CPU=y
and have been for a long time.  We've moved away from the old days where
you could easily compile a kernel that didn't boot.

We're basically handing our users a big long piece of rope with which to
hang themselves here.  This patch makes it easy and doesn't do a great
job of explaining why they'd take the risk or what the benefit is.

I don't think we should do this.

