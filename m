Return-Path: <linux-kernel+bounces-411554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9117A9CFBD5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FD9281C70
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990A17485;
	Sat, 16 Nov 2024 00:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQjl2dtJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC31854
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731718330; cv=none; b=XQentonrUEUJA72+zkpqdZsFPbsq5jQZ3WhAOHMF59tcSj1GSwfl1dRwzdcGzzlCVnYUvlpFN7lQltbskmY5QFTGoPHAB2HIGXnOR9zBFxPTi725NLtHd0DWYXhRQYUyjSHIXHyTsolndJwAVxKTSeHEw1yDDrd9tX05xctxFoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731718330; c=relaxed/simple;
	bh=SJozEzYy01mdlTtQa8b3X5OY3kqgIJQXY35tddum9Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zkvn1Xf+eb6csZ/vu+G8OWlFZfrKaEBRkd5mwd5OmE+aQFRVt76cESvqrE3tKbzOtwa1WWjh9zVLc+OVkAR9Lzt1DvnvPnNnX7KAA/i2jB5Z0ynVPpQZ7dzAZ/vPWRJ7IFxajh8mb3qmO4rlcOV4+GjU3KCiiIkKS2UjyxMUVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQjl2dtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57053C4CECF;
	Sat, 16 Nov 2024 00:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731718329;
	bh=SJozEzYy01mdlTtQa8b3X5OY3kqgIJQXY35tddum9Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQjl2dtJu1x0T7qxHlx4Ikct7Uf7o1ic6CWoKOZ+A2ugFEkwxPFbgZWEMHlfoj0ti
	 pCnzr5jEi1g6mHUmiSDxLjWfY/T7X68Dlf2GXXi0TSpxNHJGuonUkwGiPx1c5ekYUp
	 YaVhV/obVTVXy6vkWN++Uced6epEE2Qd5lGJHuVKt5hWG/8vn1LmDRTx/HRIsBjNq7
	 walgbD3EqSy11PzYC2hghbpxt9LydRmH/hqmjSr96rX/RAJ24PU78t6lv2WWnnK+JU
	 rMx0wthtp3iD+N8moYM4Esw1jdWkcTzXlkactDIf/hlTiR3JBz0ipNPj7XZmcyL0CK
	 4eH2cXRHC3XWg==
Date: Fri, 15 Nov 2024 16:52:07 -0800
From: Mike Rapoport <rppt@kernel.org>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, thomas.lendacky@amd.com,
	michael.roth@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/sev: Add callback to apply RMP table fixups
 for kexec.
Message-ID: <Zzfst1FwR/DJqtGg@kernel.org>
References: <cover.1713212104.git.ashish.kalra@amd.com>
 <96b2949cf225501d686b47070c7bbad341e160a3.1713212104.git.ashish.kalra@amd.com>
 <20240420130533.GNZiO9nShSxjxB-FQn@fat_crate.local>
 <ed4cb373-e626-4b79-b692-df5ea2ca8899@amd.com>
 <20240426125803.GDZiuk2-YonyodvSbi@fat_crate.local>
 <5d515e4e-5db8-4840-a200-a67e7df8043b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d515e4e-5db8-4840-a200-a67e7df8043b@amd.com>

Hi,

(sorry for jumping really late, I've just found this accidentally)

On Fri, Apr 26, 2024 at 09:56:25AM -0500, Kalra, Ashish wrote:
> On 4/26/2024 7:58 AM, Borislav Petkov wrote:
> 
> > On Wed, Apr 24, 2024 at 06:48:08PM -0500, Kalra, Ashish wrote:
> > > This callback needs to be invoked as part of setup_arch() as it needs e820
> > > table to be setup in e820__memory_setup() before the callback is invoked and
> > > snp_init() is called from sme_enable() in kernel/head_64.S (startup_64),
> > > which is much before start_kernel() -> setup_arch() is invoked.
> > So?
> > 
> > snp_init() still runs before e820__memory_setup(). So what's stopping
> > you?
> 
> As i have already explained above, snp_init() runs before
> e820__memory_setup() so we can't invoke this callback in snp_init() as e820
> tables have still not been setup. Again to summarize, the e820 tables are
> setup in e820__memory_setup() which runs after snp_init().

I agree that snp_fixup_e820_tables() should run after e820__memory_setup(),
but I wonder if it's ok for it to run *after* e820__memblock_setup().

At the very least making changes to e820 table after they were translated
to memblock creates inconsistency between the e820 and core mm views of the
memory. 

So I wonder what would happen if the memory from the problematic chunk was
allocated by kernel rather than by kexec? Couldn't it cause RMP fault?

-  
Sincerely yours,
Mike.

