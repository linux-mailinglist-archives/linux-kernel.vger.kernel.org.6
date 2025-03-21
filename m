Return-Path: <linux-kernel+bounces-571691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA80A6C0C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA59481C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFCA1F09B7;
	Fri, 21 Mar 2025 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHzMAc1l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79E1D5ADC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576592; cv=none; b=gciUVAd5tQ6IkE8W0Jh6grIU0ZYib+8pMbApfXyJSwreRrXE5hgDZORyeNcpuLn9yuma7hjm/R+pq1Oss0RxgFQKAQv3u/cL1c/DOPXS8Gf01YzdHlSiwY9WYg37t9rWi0gQUam1BleTVKz+KQggYVasoOKT5N6YHGywqLf6OjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576592; c=relaxed/simple;
	bh=bLmGQSNUiveDUwe1jowYa8l4SkKEk2hTmHl60bzZcvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8Q6Nh41X1AAv6sEEXKUS+n1fCHeJ9HNidt/nQULIqPFxq4kPIpwuYJqrxhcw8qNAJDdf/V36KOBwe9t7K3ALkco22efJFOAx3mgbq8PzoLzXdhHvY5i7uMIIeNXUjoZlQxu28Z5/wDx7DCRwFI/ncgxyMQn63IN2deU2K0nINg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHzMAc1l; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742576591; x=1774112591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bLmGQSNUiveDUwe1jowYa8l4SkKEk2hTmHl60bzZcvw=;
  b=CHzMAc1ltc633rt77keoUTxypgqfDWofaCHZCedj8+D52ykxMnCY+AJf
   35fUYR2Y2WVsG5k5/Kb3EMbh6rFPwF2xGolRxAJhq8pUZW8CeXWbIpB4k
   LzAc12IQb9LgmG0zF+YQgDOUATzCUOHpmhREYL+QgLqPLMWXqNVQ3u2cD
   wmj9HUk97BHBpkymAqMhkiSN+AdMvGNlGFVtT7GN1sPRdslwZ1iAUko8M
   I2C4Z20mOJygfRTIKvKAiDYrh5qnE8MdxKQeeDxyOyhsQR5vQshwHOh4G
   aesYxTM2q/G2F3wVBxUkIFth5EzmmkRYRWr86DGRF23oqz3KXgkibXNxp
   g==;
X-CSE-ConnectionGUID: 4/V/aYz0S0K41OL/tkPGXw==
X-CSE-MsgGUID: 0CAyKZxlRHqOIKp7bOZq4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43731631"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43731631"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:03:10 -0700
X-CSE-ConnectionGUID: DfDmTPDaRsCsNR0VOUGbsQ==
X-CSE-MsgGUID: t5CDdeNsQQen3IjglfPKDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="128565421"
Received: from lbuck-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.194])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:03:11 -0700
Date: Fri, 21 Mar 2025 10:03:04 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH] x86/speculation: Remove the extra ifdef around
 CALL_NOSPEC
Message-ID: <20250321170304.2b6qswvhqyv4jpvy@desk>
References: <20250320-call-nospec-extra-ifdef-v1-1-d9b084d24820@linux.intel.com>
 <cujhiug3ojp2z7hh66kipue5wcugbrcogo7yofse7sfxphgqfg@6iqg3rghixfi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cujhiug3ojp2z7hh66kipue5wcugbrcogo7yofse7sfxphgqfg@6iqg3rghixfi>

On Fri, Mar 21, 2025 at 12:15:59AM -0700, Josh Poimboeuf wrote:
> On Thu, Mar 20, 2025 at 11:13:15AM -0700, Pawan Gupta wrote:
> > Commit 010c4a461c1d ("x86/speculation: Simplify and make CALL_NOSPEC
> > consistent") added an ifdef CONFIG_MITIGATION_RETPOLINE around the
> > CALL_NOSPEC definition. This is not required as this code is already under
> > a larger ifdef.
> > 
> > Remove the extra ifdef, no functional change.
> > 
> > vmlinux size remains same before and after this change.
> > 
> > CONFIG_MITIGATION_RETPOLINE=y:
> >     text	   data	    bss	    dec		hex	filename
> > 25434752	7342290	2301212	35078254	217406e	vmlinux.before
> > 25434752	7342290	2301212	35078254	217406e	vmlinux.after
> > 
> >  # CONFIG_MITIGATION_RETPOLINE is not set:
> >     text	   data	    bss	    dec		hex	filename
> > 22943094	6214994	1550152	30708240	1d49210	vmlinux.before
> > 22943094	6214994	1550152	30708240	1d49210	vmlinux.after
> > 
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>

Thanks!

