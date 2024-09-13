Return-Path: <linux-kernel+bounces-328766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1F097888A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BAF1F2402B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5077224CF;
	Fri, 13 Sep 2024 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwmVDq7R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545912C530
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254636; cv=none; b=jaixM0HTxj0+OTFincUJ/r9zCZAvfbGqctmPjonki+TAne+cRfXE2v9fo44Wt7fZF0ggDHoki8GObsCPuO2EmPcSrzaekoUZS5TP/lZ0ancyDJCYlDvnbK8ktMmJ65XPr9FLTtAMKLKe9q+mRfzxW84R2//XxFvgylUsxgq1lX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254636; c=relaxed/simple;
	bh=yI3QrCp/pi0JzzZON7++Qj46ldFDtiheKOj7nGwj0Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvbLfDuGViYsnE7H+Hee0uiUliMQMjRJo+xJqI1lP9PEBSdCSYa5Jy4xZnX4LCqwXE82g7A+naczLs6brwKeG/ij0p/X82JqZj+BHx/wAPzGoGetZ9MCHe50nZpb9NwSGcuvDU58kxdJG8P1uyBlHtrl4kSfIyypci6b9WOJm3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwmVDq7R; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726254635; x=1757790635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yI3QrCp/pi0JzzZON7++Qj46ldFDtiheKOj7nGwj0Nk=;
  b=XwmVDq7RMhc6gpT+FIPNV/hPtJPWzZJThtA4VhDLBVt8vMS7oJO5BjsF
   RqWvRamX29aAUzbk6lW23kddjjpcGRSpjT2HnnHvKkhHApXMNBYJKrJ3H
   kmZvnKaflNrMHtXud0xF1nfrM4u8DEMHLd/0Nta2ExsD6KcelX3BT0mQD
   JLYsvVPuj+IG8r7sEXpYKso+p8c+9phBz0NVoUtV3gcvr5M695Ldm9UkE
   t1e2jRYLnbHjZKed5Icu8ltRUsyWhRmceUpH3YG4+f3oSI0meNQmjTCLN
   Jho90p9SJJwUn3OoWXGgdigbMKFlvAzJYpPh66WrdIhzlk7HU7dXIrVud
   w==;
X-CSE-ConnectionGUID: xnHNCkF8QriKMcJR65+Trw==
X-CSE-MsgGUID: TPl5dRy7SRmU4ademcPzQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="24993559"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="24993559"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 12:10:35 -0700
X-CSE-ConnectionGUID: 5I9Jfr7gTHSUutMi6V5I2g==
X-CSE-MsgGUID: kgRR71QhRPGOwzgNvf+mmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="73169267"
Received: from tbrumzie-mobl2.amr.corp.intel.com (HELO desk) ([10.125.147.158])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 12:10:34 -0700
Date: Fri, 13 Sep 2024 12:10:22 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com
Subject: Re: [PATCH v6 1/3] x86/entry_32: Do not clobber user EFLAGS.ZF
Message-ID: <20240913191022.fqipwsazkkrm5x67@desk>
References: <20240905-fix-dosemu-vm86-v6-0-7aff8e53cbbf@linux.intel.com>
 <20240905-fix-dosemu-vm86-v6-1-7aff8e53cbbf@linux.intel.com>
 <cd2897c7-2479-4358-bd5e-b55ec84db2ce@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd2897c7-2479-4358-bd5e-b55ec84db2ce@intel.com>

On Thu, Sep 12, 2024 at 10:45:23AM -0700, Dave Hansen wrote:
> On 9/5/24 09:00, Pawan Gupta wrote:
> > Opportunistic SYSEXIT executes VERW to clear CPU buffers after user EFLAGS
> > are restored. This can clobber user EFLAGS.ZF.
> > 
> > Move CLEAR_CPU_BUFFERS before the user EFLAGS are restored. This ensures
> > that the user EFLAGS.ZF is not clobbered.
> 
> Just to be clear, the new (later) location is also safe for RFDS because
> it only exposes the contents of EFLAGS (not sensitive) and RAX.

Right.

> RAX might leak the old or new values of CR3, which do not seem super
> valuable to me.
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks.

