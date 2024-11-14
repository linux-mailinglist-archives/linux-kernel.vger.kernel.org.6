Return-Path: <linux-kernel+bounces-409756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741EF9C9198
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F287B38B01
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F7E18C028;
	Thu, 14 Nov 2024 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giRMiD5L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21664262A3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606089; cv=none; b=b9qlNdTZ94e22Gkkjdc+4YgAYGLsDVZlOCjbVBFEjwtrMPzwhIZO46W7y9qjvWEq5yzaXo3y/TepYKHeBWID41NLAu45vGt8Plhsc9RAXpdCv7iWdVIV8nEDdzBnksnvxXPN/vmDC9puWsmUCa1QF9LL2GcFohYT36jbr7wZ8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606089; c=relaxed/simple;
	bh=k8WtIOCVInKWKBVtdYPd/j4xdlsdnL5n48egOpNXD8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxKlzpuoW4CQahmGxauEZdUfGtMgtQQ0haYiW2ek48nLamSOnNl0w7Bz3WCR8YU1WpDeiZxST/rzalVvueP8PCap7PflAYbqRCZlYdUjPKFEfSajyHSECr6rBUA2zsT8ltdUnJvmhBSOskyEjz6S3dNOCbMl33qAAuwyg+uI2h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giRMiD5L; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731606087; x=1763142087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k8WtIOCVInKWKBVtdYPd/j4xdlsdnL5n48egOpNXD8E=;
  b=giRMiD5LSYmCRjGSFcS8NW0gLZyDa5gLPx/kxWApmyCE9tkLooYEWnH0
   P/o4UK5oadvKJgjESeFwG05h2epgthSm+/rh9PTubFfSQtI4TVAQHSW0L
   tK7AnED8gTWsXKIToGCIvkcL3GWyHSW19F9oK49JoprmVZ4OOXC74mmEv
   eUPGyoJtY08DWPn5Kimxo1TVNLlYdpRnVWMQ45kf0Tfq7ZSDMN2IjTt6A
   RG18MWAtCppssIM5R5wLSyEQaxDS8hTAb8eMVYBLGOGayBHI93UtFNU0N
   tbHR+33KNJCw2RTtau8Q8Rm9w5vNjY/NENICun6hkLhMaVOzqKUcdASmh
   g==;
X-CSE-ConnectionGUID: 1f0Gfg/vQJml6kLTVmRA9A==
X-CSE-MsgGUID: otdQ8xi5RLS2lbj6an3IVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="34428041"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="34428041"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 09:41:26 -0800
X-CSE-ConnectionGUID: +eZDw0HoRyGP++RwhVvaAw==
X-CSE-MsgGUID: 05kO8I+wQr2osqDx+k6ZDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="119103956"
Received: from eareitsc-mobl.amr.corp.intel.com (HELO desk) ([10.125.149.35])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 09:41:23 -0800
Date: Thu, 14 Nov 2024 09:41:15 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
Message-ID: <20241114174115.qucm7lwbfiavodyh@desk>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-12-david.kaplan@amd.com>
 <20241114064001.v6ogsiaptrh6oixc@desk>
 <LV3PR12MB9265747DB95F1F54E826A971945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265747DB95F1F54E826A971945B2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Thu, Nov 14, 2024 at 03:36:44PM +0000, Kaplan, David wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> > -----Original Message-----
> > From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Sent: Thursday, November 14, 2024 12:57 AM
> > To: Kaplan, David <David.Kaplan@amd.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>; Peter
> > Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; Ingo
> > Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> > x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Tue, Nov 05, 2024 at 03:54:31PM -0600, David Kaplan wrote:
> > >  static void __init spectre_v1_select_mitigation(void)
> > >  {
> > > -     if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off()) {
> > > +     if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) ||
> > > + cpu_mitigations_off())
> > >               spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
> > > +}
> > > +
> > > +static void __init spectre_v1_apply_mitigation(void) {
> > > +     if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) ||
> > > +cpu_mitigations_off())
> >
> > We probably don't need to repeat this check, is this okay:
> >
> >         if (spectre_v1_mitigation == SPECTRE_V1_MITIGATION_NONE)
> > >               return;
> > > -     }
> > >
> > >       if (spectre_v1_mitigation == SPECTRE_V1_MITIGATION_AUTO) {
> 
> I don't think so.  That would stop us from printing the message about the
> system being vulnerable at the end of the function.

Sorry it wasn't clear, my comment was not about the return, but about
simplifying the check:

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 22fdaaac2d21..e8c481c7a590 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1115,7 +1115,7 @@ static void __init spectre_v1_select_mitigation(void)
 
 static void __init spectre_v1_apply_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())
+	if (spectre_v1_mitigation == SPECTRE_V1_MITIGATION_NONE)
 		return;
 
 	if (spectre_v1_mitigation == SPECTRE_V1_MITIGATION_AUTO) {

Since we already set spectre_v1_mitigation to SPECTRE_V1_MITIGATION_NONE
for that exact condition.

> We should only not print the message I believe if the CPU is actually not
> vulnerable or mitigations are globally disabled.  Although now I realize
> my patches may not be suppressing the print statements always if
> cpu_mitigations_off(), so I need to go and fix that.

