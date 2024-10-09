Return-Path: <linux-kernel+bounces-357970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915E69978A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3502E2851F0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8741E2857;
	Wed,  9 Oct 2024 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIWjNpcG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EE915D5D9;
	Wed,  9 Oct 2024 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728513764; cv=none; b=Z2Fnmg8BdOVtgE+Egd8/Cctq3VZeAo+QKiZx8HGB3LustJQPgRafPoThaL3vtxY+yJIszLstZGKijevn6PBTISi9GVKG2Lfb0tD9F38+3QDCl6IHHW3fX09OTs1fRVYTXc0/mX7Pz0FUrckzxGoLuNQ5KcRQ4EYJfmqIsWVV+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728513764; c=relaxed/simple;
	bh=M/jYqexT1hPJpZFhtuqzJvWEFeg2v79s2Hd6JNUeEzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eexv4f3Vnls2bC5+gbM/rpNKtul6hpTq2bsoJzy1Pkh4LKaoWxKJfHBH8xOpmzEhN6fdBktNoVrpiUnDZV2q25pDiPi8zc3J5K+214MieyqymjFPGUu+gQO0nukzEv0eDfDT/5negr/yENrIcMiGd/MRjeQ+S3pzDzQniulBFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZIWjNpcG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728513762; x=1760049762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M/jYqexT1hPJpZFhtuqzJvWEFeg2v79s2Hd6JNUeEzI=;
  b=ZIWjNpcGZLaEaAEDOrmyV01GHNN8Y+dpS7Z98nAJHJGqt9x+ctO+K1aC
   SbNFHWQJ5eQksKKmkIS3fROMwjdyZmFAdJZhy+o5s0IAL0GYU5HunB0XI
   R38WqSraI88r+aqqhkf3jc0r2MMKDpoKJ5IE1kVpmDS5waEns2dux81Ca
   zQXqUbgiJ1IaqoJD+0TIbwXSvGrsNQMgBsWLJdvu2JsWXC82qXQY8Ce5F
   +G/35e9RYh1GSJV1QOq/CCCg+lckK8x6/czZ4QIh7lwOwuMH2JlzvzIGc
   uMmCo8VEnm2qAnQyZxgr2A+e+Br623S6boogGT79+p6l9zAktECVEz8iW
   g==;
X-CSE-ConnectionGUID: CNIFzll1RlO/Eo7NzzXoCw==
X-CSE-MsgGUID: 0QQaw1JmRjis2Dh2nui8Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27931565"
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="27931565"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 15:42:36 -0700
X-CSE-ConnectionGUID: VYgdYngeSbqWRF33DTyLxA==
X-CSE-MsgGUID: VFaRBY4FSYOoKihsqrBvIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="81410626"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 15:42:35 -0700
Date: Wed, 9 Oct 2024 15:42:33 -0700
From: Tony Luck <tony.luck@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
	kai.huang@intel.com, kan.liang@linux.intel.com,
	daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
	sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com,
	peternewman@google.com, maciej.wieczor-retman@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	eranian@google.com, james.morse@arm.com
Subject: Re: [PATCH v8 07/25] x86/resctrl: Introduce the interface to display
 monitor mode
Message-ID: <ZwcG2e90vXHlIVan@agluck-desk3.sc.intel.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <dc8ffd9074123320ceeecdc8e0b36d1ac0780e02.1728495588.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc8ffd9074123320ceeecdc8e0b36d1ac0780e02.1728495588.git.babu.moger@amd.com>

On Wed, Oct 09, 2024 at 12:39:32PM -0500, Babu Moger wrote:
> +"mbm_assign_mode":
> +	Reports the list of monitoring modes supported. The enclosed brackets
> +	indicate which mode is enabled.
> +	::
> +
> +	  cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +	  [mbm_cntr_assign]
> +	  default
> +
> +	"mbm_cntr_assign":
> +
> +	In mbm_cntr_assign mode user-space is able to specify which control
> +	or monitor groups in resctrl should have a counter assigned using the
> +	'mbm_assign_control' file. The number of counters available is described
> +	in the 'num_mbm_cntrs' file. Changing the mode may cause all counters on
> +	a resource to reset.
> +
> +	The mode is useful on platforms which support more control and monitor
> +	groups than hardware counters, meaning 'unassigned' control or monitor
> +	groups will report 'Unavailable' or count the traffic in an unpredictable
> +	way.
> +
> +	AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
> +	enable this mode by default so that counters remain assigned even when the
> +	corresponding RMID is not in use by any processor.
> +
> +	"default":
> +
> +	By default resctrl assumes each control and monitor group has a hardware
> +	counter. Hardware that does not support 'mbm_cntr_assign' mode will still
> +	allow more control or monitor groups than 'num_rmids' to be created. In

Should that be s/num_rmids/num_mbm_cntrs/ ?

-Tony

