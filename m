Return-Path: <linux-kernel+bounces-175175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8DB8C1BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7846D282ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3404F1E5;
	Fri, 10 May 2024 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aftEdi20"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB21D68F
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300727; cv=none; b=flLGWEh2x60OXFbv/m0rYxqZI+N7Fp5bxRWhO7Bi2Q9PGluGF9ZG6LHcq3fxrm2DpPPplpRzYp2VbjsZCD0aQV3QzC1bE+thwMTlUiQn1Jh15+zDbpQPx3Qa8JRGuWScgjl/e/Gz1HEjEwfmAErl163gyqrYhASmYHOPzq3nKts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300727; c=relaxed/simple;
	bh=nzhgzXBLVmxRg+MI59G3H3An2IVTrWtLtRJv538SxT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbPn9RxlkFwm7eVFf+ZeqoA+1Ltwsrc6mP1w4OVUreperWBPI2s4jFPUNry+5Of6CLKfqJTJLtaI/DnJlUc9GjHM0CFY8Vw5rw0C8d2CiDw3Ln9JSBVHl/8k/L4eRMAu3Zs0q9f3Q9CGMmRIROX6UUGHCf2h16ukqKlpvZEuF0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aftEdi20; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715300726; x=1746836726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nzhgzXBLVmxRg+MI59G3H3An2IVTrWtLtRJv538SxT4=;
  b=aftEdi20DR+XHd4W/SvAarFHS6hoTeFOpMNuco4cQbbkXJkHZw0URFtH
   TZjTcN8VQdb7cn6R935cERaB/uqUUKXhYsoPOizS8kWdTd25lvrCX3nXm
   XtNVWxI4ZK8CeqjfkgSum0PsD011SnIqjiS+w12wLClp/3BlOV6grmwsB
   Z7GiCsDVHEvB3G5DusstkbncaiR8ZU7RCtcb/oFVy7MQZsjCPVK3/yYj3
   XFG/j+c/FKjRxDYuXYqYzVS0nZDwvgo+PzQTzG/e+VRofiPy3CT0ikCmB
   QyhL5DpAxtunnHXYk4KfA+ao8ZiUZP5GENFNStH6WvX1TC/q/pflJGWBZ
   A==;
X-CSE-ConnectionGUID: afsq/Wv3S0WKZ7NgsZMvrg==
X-CSE-MsgGUID: POCDxGRdQRatXvPz4KDQLA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="22409601"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="22409601"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 17:24:42 -0700
X-CSE-ConnectionGUID: HYoMje3ASTmMq3J1efmzxA==
X-CSE-MsgGUID: rXLoGBOgS6KbqEAn/FoqZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="29492622"
Received: from vuongchr-mobl.amr.corp.intel.com (HELO desk) ([10.209.114.189])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 17:24:42 -0700
Date: Thu, 9 May 2024 17:24:34 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com
Subject: Re: [PATCH] x86/entry_32: Move CLEAR_CPU_BUFFERS before CR3 switch
Message-ID: <20240510002434.gevlrqdiuhtosafa@desk>
References: <20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com>
 <5b5e597d-7620-4a5a-9bfa-bae26f0b0fa3@intel.com>
 <20240509221425.zcl6c45thb7wxyza@desk>
 <e3a8075a-0846-4244-85da-1af45c83bbc4@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3a8075a-0846-4244-85da-1af45c83bbc4@intel.com>

On Thu, May 09, 2024 at 05:04:36PM -0700, Dave Hansen wrote:
> On 5/9/24 15:17, Pawan Gupta wrote:
> > It probably can go right before the SWITCH_TO_USER_CR3. I didn't have
> > 32-bit setup with dosemu to experiment with. I will attach a debug patch to
> > the bugzilla and request the reporter to test it.
> 
> There's an enter_from_vm86.c in the kernel selftests.  That will at
> least exercise this path.

Yes, entry_from_vm86.c should be a good test case for this, thanks.

