Return-Path: <linux-kernel+bounces-236641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B76491E53F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89671B268D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C09816DC31;
	Mon,  1 Jul 2024 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHtK9xzM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E1416DC17
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851032; cv=none; b=OkWzNSkFSJ3AM65r6u7JyweudM/J2UrZRXHZb90gCDJe6CaLN2s78Ig9Fib4+e5z0ovq/gBlXpaeN2gw9ZO7t3pTMXjo6pRwlOKgD4AjJFRwozMlcyD53lROPHFzwGcgr8gw+lMJ75eZzknl1Qo8adrBfYx+yY7gZuItpTCyurA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851032; c=relaxed/simple;
	bh=jH/ZnzzQGp5lBLeQUMDAOesA7BuApN1VnzlQQtHYMzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+2NbTLUeogJfN991AHmpf5R4smuXJGOrv+7ovVvOAD7dsKvBONdZp+LBC3b3yY4MrfACTygnRfobXmfoPwkViwR7kXcDC93aSRzinhHjc4KvRRHMaCSEFjY1VnMDBu6mxso/24WXRD75Jyvu7RxHbPtweb/jQBFf2lyFvDR3u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHtK9xzM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719851031; x=1751387031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jH/ZnzzQGp5lBLeQUMDAOesA7BuApN1VnzlQQtHYMzc=;
  b=mHtK9xzMZuxhLLEc56CnprIsR6z47v+asVZMWxJBRreNzZffey1OrAyJ
   KvEFmyur2931Ppf1Qn+gsraZU1l94s4T/pvD3N7N9UWbLoqF3OJmQIDsx
   arVOXWOMcHeStNTozd+NKMQn7AGlwNXMHheexQMm4cUDEZVk8UDsd6ELc
   XaTlmZyxWS855F+xisEipYw81eT1dfLPMzvED/kppoloelcsoYO5qql6H
   InGrF57ts74fjc8l6w0sMksOW1UvdY5dEJkz9Rs0Ud+F9lVOSU69QsHS3
   Vna1Sx5yxv6GZrfCr5VqG2EIKXMsZ5WnsTE/uOwHKBm3EjG1Z/mfE2pp0
   g==;
X-CSE-ConnectionGUID: YnqyShRHScCj3OuGuYg4JA==
X-CSE-MsgGUID: u3jN23oITnOB4Pmd0MW9iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17119636"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="17119636"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 09:23:50 -0700
X-CSE-ConnectionGUID: yhjr53r+THS0NWq2U4HXSg==
X-CSE-MsgGUID: wwlapZv0RLCfplGyGTsEvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="46014374"
Received: from aadeosun-mobl.amr.corp.intel.com (HELO desk) ([10.209.8.130])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 09:23:50 -0700
Date: Mon, 1 Jul 2024 09:23:36 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Brian Gerst <brgerst@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com
Subject: Re: [PATCH v2] x86/entry_32: Move CLEAR_CPU_BUFFERS before restoring
 segments
Message-ID: <20240701162336.ox6yedgovb7qdwde@desk>
References: <20240627-fix-dosemu-vm86-v2-1-d5579f698e77@linux.intel.com>
 <CAMzpN2gmxgbuYqwEcia7bpXhHHh_KgY37_wbwGeK5oBAy5=reA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2gmxgbuYqwEcia7bpXhHHh_KgY37_wbwGeK5oBAy5=reA@mail.gmail.com>

On Sat, Jun 29, 2024 at 11:41:07AM -0400, Brian Gerst wrote:
> >   #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
> >            FS, or GS segment limit.
> 
> This isn't limited to just VM86 mode, since any user DS that isn't a
> flat segment can also cause problems.

Right.

> > CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to
> > user space. Add CLEAR_CPU_BUFFERS to the macro RESTORE_REGS before it
> > restores segment registers. In vm86 mode kernel does not support SYSCALL
> > and SYSENTER instructions, so the problem is only limited to int80 path
> > in 32-bit mode. In the opportunistic SYSEXIT path use
> > CLEAR_CPU_BUFFERS_SAFE that ensures a sane %ds value.
> 
> The simpler fix is to use an SS segment override (verw
> %ss:mds_verw_sel), since the stack segment is still valid right up to
> the IRET/SYSEXIT.

Thanks a lot, I have verified that your suggestion works. I will send a new
version with your suggestion.

