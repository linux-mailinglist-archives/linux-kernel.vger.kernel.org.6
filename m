Return-Path: <linux-kernel+bounces-394380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081699BAE36
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF80B28312F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF471AB50B;
	Mon,  4 Nov 2024 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d40mDmHt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADDF3214
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709358; cv=none; b=fvsirvcFpoj/ad+9YenU5UTGX06JEaXVeKHjsYO00tCvcModb/Vxke5fvKJFaPmjlctugPnyPECwFP+b5f8f4Fk4TcR8CMUHevoXCKXjunDNluv51NAasI63g2v30bxVelTw7QRRGlmVgS2dQPVh1BnM3Bj1cwagYUcP3Jp4nF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709358; c=relaxed/simple;
	bh=kyIazxcsnD1piSdyaQzAEKNQGTi5kMoAlbZhxGC4Hsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwfbBeG3S/zqCS2C+zpPKuQGa9nPeAuQAYt711tsnAA4EhzVupTAAJS3PynczWzOxe3ADYjr1+Q0K8GrDx2dqoVHLuWI+wB4PaJgXU8wEPDYlQI0ZiKr/PiqcKmn8sLcZ2QKl9Uu6IzA/WSsXmnVpKW9/mLTqKgZ1jG4Vv2sChs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d40mDmHt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730709357; x=1762245357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kyIazxcsnD1piSdyaQzAEKNQGTi5kMoAlbZhxGC4Hsc=;
  b=d40mDmHtM2qDWsyjuJqB/aXncgPCMba1ajm0YURECELStfFWs8LtXuJ8
   KXOwaZnCuJsOavPb7Ecfcnx4I8H2tCMfaUv2AklKTOHmXvPLbZSyxjJui
   gZwHflKtM7QDadp8uuATHqaVbKexNsaQ83H/Fqyf43baKK1xzHqVe3UPv
   2RFAwAUDGgCXWrI2Z+lvsJ3EQBXxUItwvMmoS4BC3Vu0Nb+K47eholyvJ
   feCSq1fe0dlzqm9BWuJQ9/588dVFkmRJVDaS4iKxRNEQGJsPoVC/Yy+L+
   V0ZehQMbVsCJCDCGfzLaUi07c6MfYX3nzmspscSxCDLvoMNOgiX9kwyGh
   g==;
X-CSE-ConnectionGUID: 02N+d2ymQmyEhFcD2wuR/A==
X-CSE-MsgGUID: O25c2zBuT8efEZy2D/jIjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41501593"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41501593"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:35:57 -0800
X-CSE-ConnectionGUID: /GZTW6eHQ72wu5JQUTGKsA==
X-CSE-MsgGUID: NQ0MhvZzR7mR/WXC6VUHpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="84031503"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2024 00:35:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DD1824A3; Mon, 04 Nov 2024 10:35:53 +0200 (EET)
Date: Mon, 4 Nov 2024 10:35:53 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, x86@kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <ktwgnbsni5pt2cznxj2g6qyb3xwkhjrciym6lpk3uvsxgi4324@tllciap26vb5>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
 <ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm>

On Fri, Oct 25, 2024 at 04:56:41PM +0300, Kirill A. Shutemov wrote:
> On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> > "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> > 
> > > Waiting minutes to get VM booted to shell is not feasible for most
> > > deployments. Lazy is sane default to me.
> > 
> > Huh?
> > 
> > Unless my guesses about what is happening are wrong lazy is hiding
> > a serious implementation deficiency.  From all hardware I have seen
> > taking minutes is absolutely ridiculous.
> > 
> > Does writing to all of memory at full speed take minutes?  How can such
> > a system be functional?
> 
> It is not only memory write (to encrypt the memory), but also TDCALL which
> is TD-exit on every page. That is costly in TDX case.
> 
> On single vCPU it takes about a minute to accept 90GiB of memory.
> 
> It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
> it doesn't scale past that in my setup.
> 
> But it is all rather pathological: VMM doesn't support huge pages yet and
> all memory is accepted in 4K chunks. Bringing 2M support would cut number
> of TDCALLs by 512.
> 
> Once memory accepted, memory access cost is comparable to bare metal minus
> usual virtualisation tax on page walk.
> 
> I don't know what the picture looks like in AMD case.
> j
> > If you don't actually have to write to the pages and it is just some
> > accounting function it is even more ridiculous.
> > 
> > 
> > I had previously thought that accept_memory was the firmware call.
> > Now that I see that it is just a wrapper for some hardware specific
> > calls I am even more perplexed.
> 
> It is hypercall basically. The feature is only used in guests so far.

Eric, can we get the patch applied? It fixes a crash.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

