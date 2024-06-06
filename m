Return-Path: <linux-kernel+bounces-204499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A867B8FEFE9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D326B2C766
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9EF19E7EC;
	Thu,  6 Jun 2024 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGVaVkyf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2F219E7DC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684789; cv=none; b=QuL/fGdjyIEJded/EeDdek2L/dVCHGBdYKeqiIopMGvgX+cNmcl/ork9xeVAffXFECmO3Sqwmw3jt76+CSni7SWjNVPGHCjF0isqXZgGDcIy1PP4NKIX9CBxq3ROxPsCeYggMDTmnWKUXAFIfEL4bv51GKUgJwV4/NGSiHV54Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684789; c=relaxed/simple;
	bh=h7zjIQkZZTzWaJBKoOJsIZ+rDuw+R7H+L3cDkG6DR2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/eWSHAPnlFND555+XBla6wA5890ejK0Q1ZaysgPMcUv+sgXq2uWMnGlmRtTO8KHTNC1GwSRgRWfrSZZgxB/i8fbNeX2YZXc/jPeKbxEregYmQ50Ah18OMDmHWY/K+s+/y33lt2dSNct8maO5KhphXoReqG2sEwl8Cpg/uH9Wf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGVaVkyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79206C2BD10;
	Thu,  6 Jun 2024 14:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717684789;
	bh=h7zjIQkZZTzWaJBKoOJsIZ+rDuw+R7H+L3cDkG6DR2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGVaVkyf5/nh+sUMeJbg1le2pWIskJPBQor0Ur9hVRT7r7RNMYSoamsKBOUBt3edf
	 XGhXpu0TVRBqZgw8Pf+DsB/szpaZoLRcjOPl1JyOApwkO7vp0lWcuvL+msNfYHEkBJ
	 YsjTNhrSIMuhUYYiZctJT/oEKcxR1/KKblBZHMB2k3XFbXbKb+Cd7s/gMOFHQ/yACT
	 +mfoU5nqBt1mom+0nDn27nOdEb53xdkvs8/+RR/kRq9o36GHORnQsVpYM1D9KMhBOs
	 DVkIYuPlON5MNW5coXBxRpYs9c0NSgwDNZX/a6NLCpdR/QbY8EF/cTK1XQNJSjo3FP
	 8LkDV2NrezsTQ==
Date: Thu, 6 Jun 2024 17:37:49 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Borislav Petkov <bp@kernel.org>, Jan Beulich <jbeulich@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Narasimhan V <Narasimhan.V@amd.com>
Subject: Re: [PATCH] x86/mm/numa: Use NUMA_NO_NODE when calling
 memblock_set_node()
Message-ID: <ZmHJvY5h887hDN87@kernel.org>
References: <20240603141005.23261-1-bp@kernel.org>
 <171750701353.925406.16431237983148253122.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171750701353.925406.16431237983148253122.b4-ty@kernel.org>

On Tue, Jun 04, 2024 at 04:16:57PM +0300, Mike Rapoport wrote:
> On Mon, 03 Jun 2024 16:10:05 +0200, Borislav Petkov wrote:
> > memblock_set_node() warns about using MAX_NUMNODES, see
> > 
> >   e0eec24e2e19 ("memblock: make memblock_set_node() also warn about use of MAX_NUMNODES")
> > 
> > for details.
> > 
> > 
> > [...]
> 
> Applied to fixes branch of memblock.git tree, thanks!
> 
> [1/1] x86/mm/numa: Use NUMA_NO_NODE when calling memblock_set_node()
>       commit: c55f3cc2d9f241d6e45336fd48dafa755c012297
> 
> tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
> branch: fixes

There was a similar, but better fix from Jan Beulich:

https://lore.kernel.org/lkml/abadb736-a239-49e4-ab42-ace7acdd4278@suse.com/

that also updated numa_clear_kernel_node_hotplug().

I'm going to replace this patch with his and use Boris' changelog as more
appropriate.
 
> --
> Sincerely yours,
> Mike.
> 

-- 
Sincerely yours,
Mike.

