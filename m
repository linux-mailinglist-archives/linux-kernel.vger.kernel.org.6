Return-Path: <linux-kernel+bounces-331950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA8797B361
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299821C231BD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D52817BEB4;
	Tue, 17 Sep 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkX4isUh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1817836B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726592663; cv=none; b=VUNdZbJK6/P41TPemgKe+jvFXTib2QI2ykLFmZk/h0elU9O4+SbNxPu4jrWDmomcRre5jwfFznBJRxdrDWK35QB66Y0lzyLQqIqDY8bvV1FEj5q/wOUbrFzZksXWAD65Q5f1SwNHS1gDpw/b1oeO9ZyLc9qq8E6fH2vAdFiEoZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726592663; c=relaxed/simple;
	bh=77xdZMMNeD10kG0sUoHarDYtAaPCWc55oywuC/41nX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpG4An1ysBFQqNLltLoMz8cFJNQe7DADp/OfgmbopMPmK6p2VZOcbElpSrjeWwPCRzV4PKWJVIOggymsS+qPbutM6JlZd50HRBzgJjrwi6yempcfml2xCkg78Vo0Y7csoQcPWQz12ntpem69KBheLbzq9g6bojWHQjQ4M+mpWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkX4isUh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726592662; x=1758128662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=77xdZMMNeD10kG0sUoHarDYtAaPCWc55oywuC/41nX8=;
  b=JkX4isUhTnnxrCkwja9KPfK4x3jK5PO04gXJafMYOJA0ve9e4G5mQqfo
   Kyu/GMowE5jAKG7/4iKk5VRXjJP3ASPskBsk4bhK1Y9fv+hwnMuUfLZJf
   QM8ENTflDyfzw3wG6NK3lsl8CBGITV3xDEYlVNv6X6ijYMtD9V8GtI/VG
   XTfsLboRuvfg8X0at8cZOhwvfDGiHO7OBM78LTEgbwD7vLFjDPosiMaxz
   bTKPlvyK37r/35zCqnAsrf2UTc5R5kH/9xEs/70B4kgi/JABAYlbS1CG8
   7E64/sK/AFtrAoXjRiJsxFE961KH2GHukuuUhHWlEDmcXxqRs9NslzHuh
   g==;
X-CSE-ConnectionGUID: NoBASW5DQ9KlhpajuMni8A==
X-CSE-MsgGUID: zsCPXaFJRZeRUGKK+C1+PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="29360125"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="29360125"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 10:04:21 -0700
X-CSE-ConnectionGUID: hwwG5ihNSQacVD0WkDzOgQ==
X-CSE-MsgGUID: T1kXxPWvQuq4/U2BVdeELg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="73612593"
Received: from paragpar-mobl1.amr.corp.intel.com (HELO desk) ([10.125.147.172])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 10:04:20 -0700
Date: Tue, 17 Sep 2024 10:04:07 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/34] x86/bugs: Attack vector controls
Message-ID: <20240917170407.jxtpb75iru3qg74c@desk>
References: <20240912190857.235849-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912190857.235849-1-david.kaplan@amd.com>

On Thu, Sep 12, 2024 at 02:08:23PM -0500, David Kaplan wrote:
> The rest of the patches define new "attack vector" command line options
> to make it easier to select appropriate mitigations based on the usage
> of the system.  While many users may not be intimately familiar with the
> details of these CPU vulnerabilities, they are likely better able to
> understand the intended usage of their system.  As a result, unneeded
> mitigations may be disabled, allowing users to recoup more performance.

How much performance improvement are you seeing with each of the attack
vector?

There aren't many vulnerabilities that only affect a single attack vector.
So, selecting to mitigate single attack vector mitigates a lot more than
that.

We may be able to get better performance improvement by adding vector-based
switches at the mitigation points. And only enable them if user asked for it.

