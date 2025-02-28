Return-Path: <linux-kernel+bounces-538959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3F1A49F43
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB9016A615
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27921275616;
	Fri, 28 Feb 2025 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEwStXD6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1812755EF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761327; cv=none; b=qk7FHlB7s1xczGT4nyIDb+Z4+ow+QxQ7MBOqqDv+HD1GvJvXInApV6wMx8wzZGqnNtqitYYm0rRVCGGPJ1/vB2annspOkggsmwUnA3s6BTytwCXVVaNOTMNfEkJo/LOgZJCgp4vYZ1tXXbGh7HSGGSdSBS6Tp5q/alGi+TNzeIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761327; c=relaxed/simple;
	bh=Xtzw6yHydLCJxybQmwK2jajJsVc2iw4v5yoRV44avWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNG0xohga+HWAzM8JmU/yg2tBH96JxbwRWNO9SAuv3sg7D5gFuxr1oWgsTO8tmlItnf3tYr21bbkqAzO80HIFFCE6J4Ns9CYgIIx5gxg7mu85qAhZPIlWkyu53umfuWmUD3AjapXCOgECI7vPzkbin/+rFtMX0HJyhor39g5vLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEwStXD6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740761326; x=1772297326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xtzw6yHydLCJxybQmwK2jajJsVc2iw4v5yoRV44avWU=;
  b=JEwStXD6PnLuc95GQzMpC8l8BJWKC3G/t4DIJDcDKWyoUWYn4+bFK//C
   Yi3eZ1IPpHwaVLerYsqhq451QW9MInrcjaX21XR6zb4cy/F2VkFnYZTG/
   wPIyifhB8ngyVYmUj32iGSlm2f4k82mXbnsEdTqTw59xfeq1kdtOxuPH3
   7zDWw0b7aP1zlVVjA6UhaBsxRI+U0P5siX/s+dD9PDM/Klk2nTwlO2SLS
   VUwwsjVko263PaZzd8yHp+BH9cCVmJcomsjXdsH/fnEthRlU12gdkVm1O
   kilrEzBgZlHJRSzsNCnrCJVAzkPSwn2LmhL8Be5N2wvSTcqEhGILQH3Mf
   A==;
X-CSE-ConnectionGUID: qlE8gZW4SMmdGekYBQu82Q==
X-CSE-MsgGUID: JCLfRFt9QYy/dzVUm6Zfkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41397822"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="41397822"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 08:48:46 -0800
X-CSE-ConnectionGUID: Gt36qaJgRPGN5QDZkF6xIg==
X-CSE-MsgGUID: rB+anWikT6i0jwzCENXPHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117248602"
Received: from mderakhs-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.171])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 08:48:46 -0800
Date: Fri, 28 Feb 2025 08:48:39 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/speculation: Simplify and make CALL_NOSPEC
 consistent
Message-ID: <20250228164839.ftlvp7iywjenqhlw@desk>
References: <20250227-call-nospec-v2-1-895a30dceaac@linux.intel.com>
 <Z8GDqxTNN0rLBbrX@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8GDqxTNN0rLBbrX@gmail.com>

On Fri, Feb 28, 2025 at 10:36:43AM +0100, Ingo Molnar wrote:
> 
> * Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
> 
> > CALL_NOSPEC macro is used to generate Spectre-v2 mitigation friendly
> > indirect branches. At compile time the macro defaults to indirect branch,
> > and at runtime those can be patched to thunk based mitigations.
> >
> > This approach is opposite of what is done for the rest of the kernel, where
> > the compile time default is to replace indirect calls with retpoline thunk
> > calls.
> > 
> > Make CALL_NOSPEC consistent with the rest of the kernel, default to
> > retpoline thunk at compile time when CONFIG_MITIGATION_RETPOLINE is
> > enabled.
> > 
> > Also add the missing __CS_PREFIX to the CALL_NOSPEC macro to make it
> > compatible with -mindirect-branch-cs-prefix.
> 
> The __CS_PREFIX change should probably be a separate patch.

Yes, I will split it into a separate patch.

