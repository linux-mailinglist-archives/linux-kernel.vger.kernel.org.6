Return-Path: <linux-kernel+bounces-389376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8823C9B6C44
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5171F213F3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9146A1CCB48;
	Wed, 30 Oct 2024 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTConJ/c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC071BD9E2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730313664; cv=none; b=aeA1QaErkGAK0alxnXz166S7Xpm3ZAVISk8ZVjcFy5jAs4RLkZi1CVefcMXSk+3a3dI0J94bVHvLssdLX3e1AmS6Zb16CtP2acVaC6J/94HurAAVxpEoGg3rSUYVcFFJ2QESVaBoqFV7ASi08Te2DByT3ciq1rOQp2BRoHwikQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730313664; c=relaxed/simple;
	bh=uuypzrJoUw+XjZ1mZsbq0ZjXB1sfeBzYFaWwDpqOhqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVuZl2krbo6t+JBfPX2Fg96kwMSq0Tc7qhMQW7aG5/ZuakENXmfC2WCuo+MfgjHWBLNl2YCHfvfM7mqlN9ZMkzZLXqALNp8WBYiYXHCyJwl3Aexg7WIE64KuChuSAQ0Exa4tA6xzrBqNeRMHXthE0jim6P7qNH2nySVP43RJceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTConJ/c; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730313662; x=1761849662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uuypzrJoUw+XjZ1mZsbq0ZjXB1sfeBzYFaWwDpqOhqg=;
  b=aTConJ/cLeik8z2kN0cQrXa411osU66U3fpxJrJStJq4t5tWyqV/e14n
   0eNgM6TGAz2j5noJf5ygOOzE6SsP5pe2v3HUkh8qZ8bqnxGT8tTzsFJtJ
   7/9/tjldbILcq11PD3BUndN3D/XspaYNGY3pJ3YmbknWWAksBod3VZ7T1
   3AOkOP+PWuoI3r40Yfr0sOaCk8z1AtTt09iZMD0SvUK7n94z7gFRHIZxq
   f2qUVbVnCmB2DoDfv7ESLowE7ywx7oVfBlg7W0p3zbaGrECR6hEOryTxA
   uZn7GglWiJGV/yglDeJ+QZ53MwFlH6nqVwbiA91obGTPJbFiRPesfzK+l
   Q==;
X-CSE-ConnectionGUID: wQL80oPJTcmZKhYus8YMkg==
X-CSE-MsgGUID: Ui7fVNj+R4mQzQx09Poavg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="47509883"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="47509883"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 11:41:01 -0700
X-CSE-ConnectionGUID: CQQqovwcTqW2z8hvQj1h1Q==
X-CSE-MsgGUID: nCjm4LyxQxycDjdyEnm6JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="87187497"
Received: from josephbr-mobl1.amr.corp.intel.com (HELO desk) ([10.125.147.91])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 11:41:00 -0700
Date: Wed, 30 Oct 2024 11:40:53 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: bp@alien8.de, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/bugs: spectre user default must depend on
 MITIGATION_SPECTRE_V2
Message-ID: <20241030183920.s4lk33ckvqtkguzm@desk>
References: <20241015105107.496105-1-leitao@debian.org>
 <20241015105107.496105-3-leitao@debian.org>
 <20241028143453.govo3bnbayc7rqjj@desk>
 <20241029-large-perfect-bulldog-ce53b3@leitao>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-large-perfect-bulldog-ce53b3@leitao>

On Tue, Oct 29, 2024 at 02:19:12AM -0700, Breno Leitao wrote:
> > If this is the intention it should be
> > clearly documented that enabling kernel mitigation does not enable user
> > mitigation. And an explicit spectre_v2_user= is required to enable user
> > mitigation.
> 
> That is fair. I didn't find a place where to document about diferent
> behavior when CONFIG_MITIGATION_X is disabled. What would you suggest?

You could describe the behavior in the commit message and update kernel
parameter documentation.

With that:

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

---
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..f8bc02cd10ec 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6241,6 +6241,8 @@
 
 			Selecting 'on' will also enable the mitigation
 			against user space to user space task attacks.
+			Selecting specific mitigation does not force enable
+			user mitigations.
 
 			Selecting 'off' will disable both the kernel and
 			the user space protections.

