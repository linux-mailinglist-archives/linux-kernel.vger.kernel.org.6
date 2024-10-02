Return-Path: <linux-kernel+bounces-347878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A2C98E000
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6CB7B2D212
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6612B1D0E1B;
	Wed,  2 Oct 2024 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M09Uzkdv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382BC1D0E02
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884258; cv=none; b=c4NLHOe786SYjk0BNMTCOP+OlOtglS+O+jjoGqnDLk+yl9VXO1oXoa9Nd2tdMMPeXRDcv5QMdbFpOgRWDuw2C9RDtTs0zG+4NMeBHle1vkBrODF77zDe3kGB9b8kKJmXq2WmI+F01n44KH444q2MTBxyrDzKxtxvdrHGcAXnft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884258; c=relaxed/simple;
	bh=qpdzzqRU03VH6WEBFIZWrIUDMNcKH1wnrx2r4ED50Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qbj6PYBeX9+FEULVxVpMHdIhqtKBKLbW1J5V49v+byLjlu4Yhjkftr6lHoPH4Oi8o5s5xljdEzOSq8Qh3V3z5XM9azvHnL6nRG/V5iSJIota2Qi3+wP9p8x50ky0VSTv/p1W6dtWXPkeTWsJcLWrieiLa/e4q5EETLmfyn9er1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M09Uzkdv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727884257; x=1759420257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qpdzzqRU03VH6WEBFIZWrIUDMNcKH1wnrx2r4ED50Pc=;
  b=M09UzkdvxiKTRerJlDUXG7IqGvEHmAtBdJ9VJnWtLz/jmhZiBoMWGsBC
   M/UkM4DYl9SIkJGq7K9ldRN2GD2pUtKxcpKsFHDI8YGjAWVYDmlMbtyWI
   JguDUfgeQGrC7XuijUkjba9uopMAHHkTxupnfOGAr/HkUxYv82UHIbEOU
   enNS0hXhRiERN5ipMobvdwSOaY2b1JJO8leiuRT2zwt8vfju1fTrNg45t
   s4yIw8WMEGpxGnob63ehFEmaMQMXbkMQ+IWfekW4bVtJq8LS9ZiqzYZAO
   XtTjVUMZsWY+gprHp9lWDI6OU601TilcZRnf+ocVY1V4hpxKOPiiMdOFr
   w==;
X-CSE-ConnectionGUID: gzvDT7xmRtazfXf/W73Ptg==
X-CSE-MsgGUID: Mu2/knirRY24eEQ0Pd5BqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="49578889"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="49578889"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 08:50:57 -0700
X-CSE-ConnectionGUID: gfj/A8q+SSm0Ji7adLLpSw==
X-CSE-MsgGUID: N2bgyGTFTm+RM93XZedB8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="74033614"
Received: from chihyuch-mobl1.amr.corp.intel.com (HELO desk) ([10.125.147.242])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 08:50:56 -0700
Date: Wed, 2 Oct 2024 08:50:49 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Manwaring, Derek" <derekmn@amazon.com>
Cc: david.kaplan@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
	x86@kernel.org
Subject: Re: [RFC PATCH 21/34] x86/bugs: Add attack vector controls for mds
Message-ID: <20241002155049.zblyafe4zmnghqtw@desk>
References: <LV3PR12MB9265292F9654D9FF76D6B63494772@LV3PR12MB9265.namprd12.prod.outlook.com>
 <1c27be68-8365-4ddb-9368-e8e740feaf13@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c27be68-8365-4ddb-9368-e8e740feaf13@amazon.com>

On Tue, Oct 01, 2024 at 03:37:13PM -0700, Manwaring, Derek wrote:
> On 2024-10-01 01:56+0000 David Kaplan wrote:
> > On 2024-09-30 17:50-0700 Derek Manwaring wrote:
> > > Maybe I'm missing something here - if you care about user/user, why would
> > > you not care about cross-thread? It seems to me SMT should be turned off
> > > for all of the vectors.
> >
> > I broke out cross-thread separately to maintain the existing kernel
> > defaults, which does not disable SMT by default even if full mitigation
> > requires it.
> 
> Ok that makes a lot of sense. My bias would be to use the vector
> parameters as an opportunity to make the SMT stance more obvious. So
> kernel's position becomes more of "I disabled SMT because you asked for
> protection with mitigate_user_user" (or any other vector). If no vector
> parameters are specified, SMT default would be maintained. What are your
> thoughts on disabling SMT if a vector parameter is explicitly supplied?

I think attack vector mitigation like user-user does not necessarily mean
SMT needs to be disabled. For example, for a system only affected by
Spectre-v2, selecting user-user mitigation should deploy STIBP and IBPB,
rather than disabling SMT.

IMO, unless explicitly asked by a user, the decision to disable SMT should
be left to individual mitigations.

