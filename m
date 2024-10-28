Return-Path: <linux-kernel+bounces-386065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC75A9B3EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36731F2334B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E581F9ABE;
	Mon, 28 Oct 2024 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7XjgYjM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E681EF92F;
	Mon, 28 Oct 2024 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159592; cv=none; b=RpLdEUjQ9wUvJ4dscvjS0K8hK+75WNu10iQKXURgn22eezOXet7UcDdzWB7YqTh5L1gXhonyFKOC3aTVM8d4tefXbHEtO6QJfXRJScMOg3mKPeSuMHY9vch/Jj500F5XITA0Yavew6Ik8LzJ82it1AAiMLVaixUQ/IxdXIJYi9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159592; c=relaxed/simple;
	bh=lWRCW+I7hWCkqI1/Qywg1Mar1bIibz0LJvPC/YB25Ts=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hauGQpnbhsjiOWviQSASyDvu/jQzEodZpD/eUM4S1/MIUK4M4lWBzqHs8LIjN/rUIQqTjIGn4OeXVgQ3MNP875KXI2QYGFQVhhfzfpj1RIrmKDIhEyet/ANXG+C+84dPWEV723Fda/sdv3d6dMllP0FxWvcvaSqZO4Uj816XYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7XjgYjM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730159591; x=1761695591;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=lWRCW+I7hWCkqI1/Qywg1Mar1bIibz0LJvPC/YB25Ts=;
  b=V7XjgYjMp5ss5363AZ5UbrsCuAHjVkO4S+6npce6q6IpVdPzX5g9S6+f
   eixxWSPtP4+McKXfIZMAYvxnMKh6R1CWyr0iLwi8qS2MPwd8aOTYCv2QW
   Yk16LOZA4HIjebkwpsd7SABkX3CGCOTL3ObgaDZ0C2TEPa2yw3yKDslTO
   Za5h/Z3FDm5yaYX5LUU2COi3WA2KCXiR3kFTgLUR8UCdIp43yDtaV6Fih
   67H94yZF/fRZWN0UJFDYgep650e9Kley6BGprPohjQ4FkyhRwKzGZV+LG
   Gem2Zlqdz5Addfmdesg7RKGghPEW2/gRNZz4N5oQo5WcA/Qvz1q2vkRmh
   w==;
X-CSE-ConnectionGUID: E4NOKMwWT6SB9lbSO/qACg==
X-CSE-MsgGUID: ajMMbTZ/RCyp7al/SgO99g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29920772"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29920772"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 16:53:08 -0700
X-CSE-ConnectionGUID: Sl41N38STqmnbF/wNKCgVg==
X-CSE-MsgGUID: Rw5lo38OTR+htm7wc4P2nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="81396685"
Received: from salmansi-mobl.amr.corp.intel.com (HELO [10.125.80.18]) ([10.125.80.18])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 16:53:06 -0700
Message-ID: <963f9a3e-71f2-41ba-ba46-e27aa8fe991a@linux.intel.com>
Date: Mon, 28 Oct 2024 16:53:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] VERW based clean-up
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: hpa@zytor.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 pawan.kumar.gupta@linux.intel.com
References: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
Content-Language: en-US
In-Reply-To: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Of course it isn't until after I hit send to realize I missed the "-v2" flag
when I generated these patches! Sorry for the confusion!

On 10/28/24 16:50, Daniel Sneddon wrote:
> There are several mitigations that use the VERW instruction to clean
> up internal CPU buffers.  Currently, each of these mitigations is
> treated independently, but if VERW is needed for one of the
> mitigations, it's on for all of them. This can lead to some confusion
> if a user tries to disable one of the mitigations, but it is left
> enabled for one of the others. The user needs to disable all 4 VERW-
> based mitigations. Warn the user when one or more VERW mitigations are
> disabled but not all of them. While we're messing with VERW
> mitigations, might as well simplify them and remove the need to call
> each of them twice.
> 
> V2:
> Dropped the new knob previously introduced in the first patch (Borislav)
> Add warning if not all 4 mitigations states match (Borislav)
> Removed extra comment (Josh)
> Code clean-up (Josh)
> 
> 
> Daniel Sneddon (2):
>   x86/bugs: Check VERW mitigations for consistency
>   x86/bugs: Clean-up verw mitigations
> 
>  arch/x86/include/asm/processor.h |   2 +-
>  arch/x86/kernel/cpu/bugs.c       | 206 +++++++++++++------------------
>  2 files changed, 90 insertions(+), 118 deletions(-)
> 


