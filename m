Return-Path: <linux-kernel+bounces-537573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE75A48D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2261716E18B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB071805A;
	Fri, 28 Feb 2025 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBtou5Eu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8538B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740704774; cv=none; b=DQ8KsI9iqrZEHYmPN2h4W1bwjvZpIelhwliivZkzCca941Db0CzfgHaAbDwISJY4AcKJnwfIqV7hpOOOa9WHwe99od8/zaMW4SOPsuOsYoekAHh+GLV/bK2BVnfERzbl8ZFvPjrUNYImXtgQzKvwX8Vz/4/pvstjSjLg48MoOO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740704774; c=relaxed/simple;
	bh=icvrXAOQAlAZ4tj2bbyx4S68q4feNaSIgIZsSDcdTsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgRYgCItGxPkW8Zb2srmMolBTViDEytJaHpy90RMQYSyDVv9whUbpXl0uFpto4ZuiwX6tJ36uyAKxG/T029Ii1M5hoGkX7Bx4FVGZNbR7YCRGrooJLH+XKBexzQw/eV8bhX6gnsJXMOAIqKJQXcpE497g9e+IrOHyDwEwmvfbDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBtou5Eu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740704773; x=1772240773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=icvrXAOQAlAZ4tj2bbyx4S68q4feNaSIgIZsSDcdTsI=;
  b=KBtou5Eu5p3/+9YG92svV3GtENbv3MztXoh3TdWr3XUk2+YZ7x0M+pA4
   0RElxjM7XcThci5GXpgjr89PRAG3BsTohfFs7v2T+93wMWDR7BhvJ7uo9
   dVdggo91RQaqplvHcU/atCqL0Yr8uAppA8gGrNMyxCSJYAiqdvsYKCsLK
   bXff57FeWiclWUkFSsgsNl2WpebWXmWWlE5Ot+OmowG04Coxci1TFJgpB
   C9lLZ39PZGlmE0M/NvbT4cvKXkn88af4R2XDTJyAcBX4yclV5HAFcIeFa
   eM5Ujf4PcdilmczrzUi5DO81zC+CbPD15+Ku79mvxqHj/mSsiLCd4VEZx
   w==;
X-CSE-ConnectionGUID: KcDTuK4uRWugxSLuy5Z4hA==
X-CSE-MsgGUID: zSg0cHMMRoWfyoCyMoazgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41748071"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41748071"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 17:06:12 -0800
X-CSE-ConnectionGUID: kPRAsJtfQUSjp91jjOgaBg==
X-CSE-MsgGUID: O9oQxmPjTPOtW8HHif55Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="122135251"
Received: from jgarnacx-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.170])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 17:06:12 -0800
Date: Thu, 27 Feb 2025 17:06:05 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/speculation: Simplify and make CALL_NOSPEC consistent
Message-ID: <20250228010605.tjgho3cfr5oawdqd@desk>
References: <20250226-call-nospec-v1-1-4dde04a5c7a7@linux.intel.com>
 <497a3694-cb0d-4678-9622-d9443bf8a40d@citrix.com>
 <20250227184133.lxm43awa2jgdpl4q@desk>
 <15253834-fb89-408f-8269-65413ad29f7a@citrix.com>
 <20250227231342.jh67quujcd3tgmft@desk>
 <20250228003117.q6f2f5a7ndt2o226@desk>
 <bf053035-6ead-4f3f-b53e-d265824199c3@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf053035-6ead-4f3f-b53e-d265824199c3@citrix.com>

On Fri, Feb 28, 2025 at 12:36:40AM +0000, Andrew Cooper wrote:
> > Getting rid of one layer of macro makes it less magical:
> >
> > #define __CS_PREFIX(reg)				\
> >             ".irp rs,r8,r9,r10,r11,r12,r13,r14,r15\n"	\
> >             ".ifc \\rs," reg "\n"                       \
> >             ".byte 0x2e\n"                              \
> >             ".endif\n"                                  \
> >             ".endr\n"
> >
> > #define CALL_NOSPEC    __CS_PREFIX("%V[thunk_target]")  \
> >                         "call __x86_indirect_thunk_%V[thunk_target]\n"
> > #else
> > #define CALL_NOSPEC    "call *%[thunk_target]\n"
> > #endif
[...]
> Yeah, I think that's a lot better.

Ok, I will go with this approach for now.

