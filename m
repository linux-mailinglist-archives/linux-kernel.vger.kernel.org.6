Return-Path: <linux-kernel+bounces-414887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498299D2EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F845281583
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC241D14F3;
	Tue, 19 Nov 2024 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZpobUdB+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43CE1D0E21
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044691; cv=none; b=q4ki9jnyV/Wokwhm94bA96Y6hvoZ4xYQyY1eoG4M5oLrhB2xdwFp2vGuHEVpFhOt2TcBr2nMTA9tIAYXim3+2DXUnjiRC7OO/8BnZmlpd2ueLCsITGCMUpV1WmWv5rs69w/QDEJTW/AINF9LrGPIaOKwxea1lEiXqWiqfXysLg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044691; c=relaxed/simple;
	bh=WBS2O8Q6av9n5o1Pp7jsziIsBeDANGMFx55FHl18OBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwecJp3N6YiZjt8AqCYc4+3uHoqCRTJAZXQ95PLNtzKW37nnv94HQKGd9HKOE8USG71ZN4FJrdlhkuUgKyOFrkRY+5Q/I1/57FL5QVfNOo333X0aTyMaTeKIfD/ln1vFsDpPaEC0kw44hpp25pfYjBDscfvzLPdZLHxk10cxzA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZpobUdB+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732044689; x=1763580689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WBS2O8Q6av9n5o1Pp7jsziIsBeDANGMFx55FHl18OBc=;
  b=ZpobUdB+Pz0A4s5j2UvlR4OaC6aMnnVLvgee4/iWaz589sJyRp8xDFeO
   9Za/Gfn7CX9px6yJlQfv9GwQsXJo6mb2XCwrSgobhbXhQCrrL1UhTKrDK
   I8Q/Jeg0KY6mokkAgaQI33l3/+Pr4MHbr5oLsr7J0dUESysYbolnBLNBT
   4srwEI9hclKW+9hjCCBffYCmqWYquqiCRYRlaeQb/zo3nx/VzG4FIra5Y
   oYEwZJMblJkMczxG6IxLw+d/PvV/f9uD2m3YFPIofMeXdSqBh4SjdkDbx
   K/uaPqVJc4zcg7Zk7g+/rl0r6p321C9bs7sxPz3FDjqc5Kf57DOiWVXc/
   A==;
X-CSE-ConnectionGUID: ccQ0jO0EROKUU+XuzByKvg==
X-CSE-MsgGUID: y9c9nXWFRIWVxkxxqhtyhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="35976727"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="35976727"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 11:31:28 -0800
X-CSE-ConnectionGUID: vL44U8lSRJiQZ/+K0iYA0A==
X-CSE-MsgGUID: SbT9nolWQKexhek2WBKTnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89831831"
Received: from myoakum-mobl.amr.corp.intel.com (HELO desk) ([10.125.150.235])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 11:31:28 -0800
Date: Tue, 19 Nov 2024 11:31:20 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, tglx@linutronix.de, bp@alien8.de
Subject: Re: [RFC][PATCH] x86/cpu/bugs: Consider having old Intel microcode
 to be a vulnerability
Message-ID: <20241119193120.zgcbyyoeiiehn6mw@desk>
References: <20241107170630.2A92B8D3@davehans-spike.ostc.intel.com>
 <20241119174546.5ehj6yjiqk3baxhh@desk>
 <8909243c-3e11-4ce1-a067-710402badbea@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8909243c-3e11-4ce1-a067-710402badbea@intel.com>

On Tue, Nov 19, 2024 at 10:49:21AM -0800, Dave Hansen wrote:
> On 11/19/24 09:45, Pawan Gupta wrote:
> > Sorry for playing the devil's advocate. I am wondering who is the prime
> > beneficiary of this change?
> 
> At a very high level, it's for folks with new kernels and old microcode.
> 
> It's _very_ normal for someone to report a bug and for us upstream folks
> to ask them to reproduce on the latest mainline. The moment they do
> that, they get the latest microcode list. Folks don't randomly upgrade
> to a new kernel for fun in production. But it's hopefully a very normal
> activity for folks having problems and launching into debug.

Ah, that makes sense.

> In other words, "new kernel / old microcode" might be relatively rare,
> but it still gets used at a *very* critical choke point.

Right.

