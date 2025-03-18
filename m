Return-Path: <linux-kernel+bounces-566532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C485A6796B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA118865A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59AA20E715;
	Tue, 18 Mar 2025 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHeIf52c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2FC20DD7B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315114; cv=none; b=k/fMVcGD0x8y54MjUZHW3uyhFfVuH+4mRaGe5C+W0H6dNvxG3Hwz0o64NwgAh3oHgxQRRRXEL3eSbvddY7vTWglf9mDJBNIIQ8e+UGe3EHURUjk0LM0A7BfKzIhV82i9JztYjcA7n3miYfq7jlBfnMXuDeWe/vX4BUhLo5rM53A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315114; c=relaxed/simple;
	bh=uuN8TNeJbrbvmRgycVT/eao89jaTOkR+7JhDHz399oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMBS67+g7ChJz/Mcvsq4CmsGNGyXyHXVhVqC2jW6G6w+Fe5RfGMvASzLRUR5pMPmcpKgT9M+1iqVAS96iYeAqL2I2iskn5IbLj1ryOstHYxkw8PrlvPLaf2+6A3xEv+EjuqDFlNDT+u58mhYYhOzJ3KYiDkkv/oVj/7tSRnYd/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHeIf52c; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742315112; x=1773851112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uuN8TNeJbrbvmRgycVT/eao89jaTOkR+7JhDHz399oA=;
  b=ZHeIf52cybQgmr3ER73rBEAX5AHPX0WAqZtWztMMSrkWXqnEeONAZd60
   xofqGYOD4HU+hAxQv2PX+bu6XNVF3Tevnf3emtJ8by0AHVOwkPHPeZm+9
   W+47MO1shyqMGn5SKI2egVgI82dV+mrmil6RdBQyGYWnDY1sIeJCoA2WZ
   W0tDTmhyfPweLBOl46gXo8Tk1DsIKyUGrg3FygBd91gX3s+vJ9VyqXYQ1
   2fe+2KQegHNY4fKHl4HKbSbCnzSrM5Wr/fOjudp4y4LB/xLR8XR+sqKFc
   mjpG/0Y9jHE60OoNLwrLiPhK44Ub80UDk7yjOWNYOV0QENRKhZrYgeF/j
   g==;
X-CSE-ConnectionGUID: aEvJdOKgSG6vFa9ZwCrDkA==
X-CSE-MsgGUID: aT4WYkQFQHa8uv9HuSqbIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="47115688"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="47115688"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:25:12 -0700
X-CSE-ConnectionGUID: N6F56dRNS5OtFvykoqQgyQ==
X-CSE-MsgGUID: DPXPVFc2QAyTQdMR13pN5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="123064882"
Received: from eballerx-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.191])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:25:11 -0700
Date: Tue, 18 Mar 2025 09:25:05 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: David Kaplan <david.kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: Re: MMIO and VERW
Message-ID: <20250318162505.3ptnegnjz46hchep@desk>
References: <20250310164023.779191-1-david.kaplan@amd.com>
 <20250310164023.779191-4-david.kaplan@amd.com>
 <20250313093617.GHZ9KnEXpdM4dwLYFz@fat_crate.local>
 <20250313192606.iijythngqtpx4tyy@desk>
 <20250318141659.GDZ9mAWwa3dkQDHkCk@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318141659.GDZ9mAWwa3dkQDHkCk@fat_crate.local>

On Tue, Mar 18, 2025 at 03:16:59PM +0100, Borislav Petkov wrote:
> Carving this thing out into a separate thread:
> 
> On Thu, Mar 13, 2025 at 12:26:06PM -0700, Pawan Gupta wrote:
> > On Thu, Mar 13, 2025 at 10:36:17AM +0100, Borislav Petkov wrote:
> > > I'd expect to see:
> > > 
> > > 	if (mmio_mitigation == MMIO_MITIGATION_AUTO) {
> > >                 mmio_mitigation = MMIO_MITIGATION_VERW;
> > > 		verw_mitigation_selected = true;
> > > 	}
> > > 
> > >         if (boot_cpu_has_bug(X86_BUG_MDS) || taa_vulnerable())
> > >                 verw_mitigation_selected = true;
> > > 
> > > because the above branch already selected MMIO_MITIGATION_VERW so we might as
> > > well set verw_mitigation_selected, right?
> > 
> > There is a subtle difference between setting verw_mitigation_selected and
> > MMIO_MITIGATION_VERW. The former is a system-wide switch that indicates
> > VERW is needed at both kernel-exit and VMenter. MMIO Stale Data is
> > different from other VERW based mitigations because it only requires VERW
> > at VMenter, when not affected by MDS/TAA. So, turning the system-wide knob
> > here would be wrong.
> 
> Realistically speaking, do we have a machine where you *only* enable VERW on
> VMENTER?

Yes, more on it below.

> I'm not talking about some experimentation scenario where one measures which
> mitigations cost how much.
> 
> Do we have a real-life hw configuration where the *only* VERW mitigation
> needed is at VMENTER because that machine is affected *only* by MMIO and no
> other VERW-based mitigation is needed?

Rocket Lake, Comet Lake, Ice Lake with tsx=off only require VERW at
VMENTER. There are other MMIO affected CPUs that are not affected by MDS
and do not support TSX or disable it by default.

