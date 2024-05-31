Return-Path: <linux-kernel+bounces-196615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5278D5EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D6A1C20E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85B1137C2F;
	Fri, 31 May 2024 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lldvXWDn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08E013665D
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148667; cv=none; b=XzDDdSLCkXRnJW//w+06X/FPxyBiM62AXEGiW314anaSZ+5ioqVBHib1Bilx7TjJbBDBBnrnRkXujOrQ7tgxzzLbxSl05EhnOsg2bs9OIUHY9eoSWuum/6zAiQXAdeOSA4tV+DtZQa4Esk3zk8/DKio+gXNlsj3VB3ArZy1IvzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148667; c=relaxed/simple;
	bh=g7uZiVfUTpbSwjMd6U9QyTBugO8rfC8rQMTVhjpqVvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCTmM73tYpnWl8kq2l49b2FfMpGIvetQlRyoblGYzeKFUTkKKSHcQJXhsuYcKXX7Fz4u4CV5o6o+TUdeoeOxFYzapgUNnApOkYcTsoj4mnU7UYLubR1Xo00zObnFLYQQ4JAZzMaAjF2m03zcXE5YxTWxKeHXiN+mG/W5JtjbXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lldvXWDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AB6C116B1;
	Fri, 31 May 2024 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717148666;
	bh=g7uZiVfUTpbSwjMd6U9QyTBugO8rfC8rQMTVhjpqVvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lldvXWDnTr5ZsMdVI4TWGiD3UxhCzBGltVXIJP24uhIIfxmyChNutM1v8qedY4QQg
	 z3rtp7CxbjVSpA8FSvaus0QfpU8PQDsJ0xwZp6e3XYdoE71qXwVCaUdqhxMEdd/U4W
	 sMr40E/FaHXjbGnjIT1HAFEpIpkSBPebknODyPvgyli01LgqEAL6HyggGI24EYSBua
	 980RbFLA86A22PK9eRacvPTfETqSk+0MBqUJvVjB3yl2rToguK/DoCDhd1hmmy/2IH
	 80FZHmxV42qBx9RTMDAzPRM5SSR7aE3W3+Sb6FJN2/zlJkXhXoyjpg9aHkD/UPdeRT
	 LWz71S615AKIg==
Date: Fri, 31 May 2024 12:42:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jan Beulich <jbeulich@suse.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/NUMA: don't pass MAX_NUMNODES to memblock_set_node()
Message-ID: <ZlmbitudD6_JNb1s@kernel.org>
References: <abadb736-a239-49e4-ab42-ace7acdd4278@suse.com>
 <e33ec69b-21e0-46e3-9b70-6d89548a145b@intel.com>
 <997fcbc7-4e75-4aa2-974c-15d984f02d02@suse.com>
 <bec94a1e-8c87-461a-a8db-1ea57385e745@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bec94a1e-8c87-461a-a8db-1ea57385e745@intel.com>

Hi Dave,

On Wed, May 29, 2024 at 09:08:12AM -0700, Dave Hansen wrote:
> On 5/29/24 09:00, Jan Beulich wrote:
> >> In other words, it's not completely clear why ff6c3d81f2e8 introduced
> >> this problem.
> > It is my understanding that said change, by preventing the NUMA
> > configuration from being rejected, resulted in different code paths to
> > be taken. The observed crash was somewhat later than the "No NUMA
> > configuration found" etc messages. Thus I don't really see a connection
> > between said change not having had any MAX_NUMNODES check and it having
> > introduced the (only perceived?) regression.
> 
> So your system has a bad NUMA config.  If it's rejected, then all is
> merry.  Something goes and writes over the nids in all of the memblocks
> to point to 0 (probably).
> 
> If it _isn't_ rejected, then it leaves a memblock in place that points
> to MAX_NUMNODES.  That MAX_NUMNODES is a ticking time bomb for later.
> 
> So this patch doesn't actually revert the rejection behavior change in
> the Fixes: commit.  It just makes the rest of the code more tolerant to
> _not_ rejecting the NUMA config?
 
It actually does. Before ff6c3d81f2e8 the NUMA coverage was verified
against numa_meminfo rather than memblock, so it could detect that only
small portion of the memory has node ID assigned.

With transition to memblock, the verification relies on node IDs set by the
arch code, but since memblock_validate_numa_coverage() only checked for
NUMA_NO_NODE is missed the ranges with nid == MAX_NUMNODES.

I took Jan's fix for memblock:

https://lore.kernel.org/all/1c8a058c-5365-4f27-a9f1-3aeb7fb3e7b2@suse.com

but I think that we should replace MAX_NUMNODES with NUMA_NO_NODE in calls to
memblock_set_node() in arch/x86.

-- 
Sincerely yours,
Mike.

