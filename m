Return-Path: <linux-kernel+bounces-171650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8A08BE6E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED111C215B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EB315FD1D;
	Tue,  7 May 2024 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5LbCcoZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72C614EC53
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094282; cv=none; b=hfNfObMC59D440QnOWzKLBwdRe4FJgt4k2XyLgYZ0BrN9gaQ1ZagtpJOq9TJ0XNX/tU+5cwBTWkieaZ+cpXfH9CiRllooWJIUhqZ3VAdBLTfQSPD3IXXam+kmZtWyxsqlgpVqt9X9xgqzEenvmuE7Tpb23YvK38kxep5fZYHk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094282; c=relaxed/simple;
	bh=xuhSa4S2CumADH8RDe6swsCKZyBY0qb/Lsid8hv6ASo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hpn4r1TIx5NZuonmNkHDWp4rRD18718v+u5gTPqydQ+xGynrwcmAk416oGYXPVxmnX8BNG/qSbkreVDMjBtLHrYVU4edv4aCI4qOGMoRIa/abFynt9tB6RQxVSDBlTSJ5F/N2kxFyXmT3IQUc3vTRDI8CWpc8F18AHJbvU7BuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5LbCcoZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715094281; x=1746630281;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xuhSa4S2CumADH8RDe6swsCKZyBY0qb/Lsid8hv6ASo=;
  b=F5LbCcoZm/B4sbL8qbASu+fIWOPvn/YlB7GJyWSpehHrvx7OLaLtg9u0
   qvZEyt8vemW0/4hpdFMoCntNLFP9hUBCEBKorDMcqKPYzS+29xVQp8LOv
   mVk1u288CO/EI6++PA8OL3bfYxUP3FoNdGBrJqA3iVrLt4p3JSDaHkL9Q
   9PRzLsrEQbj2FOUF9DautIpNtRFIvUOs3qbXIUp4kTycv90ILcr5pX9JU
   y9cjX04lLbjSm411DtDb/uqlpuNtsyZlJCaadW3khD5MN9EkdtO689JDv
   dEmr1JXE/HPxpAQ+HVxIwPWPMyR1sjQMKISvyvqTBkGSmWdVD/FDgwxNt
   Q==;
X-CSE-ConnectionGUID: XzzrZCzMQNK1KzwUyAfX+g==
X-CSE-MsgGUID: sbU+twhyQd23rFsTL2PdkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="33406047"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="33406047"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 08:04:40 -0700
X-CSE-ConnectionGUID: W5VeKp5XT4yf9IqjpLAuXA==
X-CSE-MsgGUID: vdg22hr0RXWVqFEx2/j2ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="33119493"
Received: from bwkammey-mobl2.amr.corp.intel.com (HELO [10.125.19.152]) ([10.125.19.152])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 08:04:38 -0700
Message-ID: <d0079f0c-3be8-484b-9c67-f08d6a1fb31e@linux.intel.com>
Date: Tue, 7 May 2024 08:04:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] x86/bugs: Remove duplicate Spectre cmdline option
 descriptions
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, KP Singh <kpsingh@kernel.org>,
 Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <cdfe36cf9c8b6cd98eb0f32b798d5af1af95cb2c.1715059256.git.jpoimboe@kernel.org>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <cdfe36cf9c8b6cd98eb0f32b798d5af1af95cb2c.1715059256.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I love the idea here, but

>  	nospectre_v2
> +	spectre_v2={option}
> +	spectre_v2_user={option}
> +	spectre_bhi={option}
>  

this comes out as just a single line when I run make htmldocs.


