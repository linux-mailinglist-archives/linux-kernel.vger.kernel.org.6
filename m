Return-Path: <linux-kernel+bounces-546676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2133CA4FD92
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65707A8E6E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD369233702;
	Wed,  5 Mar 2025 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD7K+lLP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C805226D05
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173979; cv=none; b=EsODphPu2ML/L8mV3oXclJMHn/wGbV+LYWMrj0xPgSmqFuk0rnbBfQhXuZtY2JjdvUxLdka9szEWc2vC7/Pgdyn0RnoMxCw2Mk0K6MZeB6E062hDdVuy+bCKUJ5oTjycTTu7thtiACux+UGHpusgbQjpZDUMnggyGm3EWwiIQBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173979; c=relaxed/simple;
	bh=kLkLGgZXjECujqtI7XiVDr+CXG2v/hLywPI1/ND5u4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmUms9iG8bOGTrjweo0OdBG5okND69LGWR1BOoMXHYKSbrTt52CB9AfGV0A0l7Gfg0vtbcz1uUzG4PubHj6GWA1laaF+H9eDmpBN18tYJjGm0quSfQhSgbTvqnbFhOc4S2INysHlz/k6FhTLaS76LJGhNsTpLKoQ0AwWo+SIsoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD7K+lLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AD3C4CEE2;
	Wed,  5 Mar 2025 11:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741173977;
	bh=kLkLGgZXjECujqtI7XiVDr+CXG2v/hLywPI1/ND5u4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OD7K+lLP9CBJWJufvqy709yusFGDAGO82O5AP+SfmVAoqDIAdrH59Q3vp86FBVCXQ
	 I+GVyMVMjnLcvHAqc8evhc2IZq7wTdfnHQQHY/k9+EV/tCiqbIfdbmW+VKY1VvQTnR
	 BI337I8j41P6WvF1RftUcfOybbIwEMaeJ68Q1d7EEsDC738x/hjovl4BivGB+S2chs
	 j2AjbGD8FRy87oy8PKu3vIn5fspdQYh4YxbH9UrAL9ZlnRbHo8vv3Ux+lAmk2NL3A0
	 34+Sr3LsQBEOUj43V0+p5V4yR+UFyds0RSBwFEAv6hWiQ9RKpBraKrAg1BCSMvQflk
	 hzvG0dkaNdgpA==
Date: Wed, 5 Mar 2025 12:26:13 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z8g01YhM_FtdB5n6@gmail.com>
References: <20250305105234.235553-1-joro@8bytes.org>
 <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Mar 05, 2025 at 11:52:34AM +0100, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > Current user-space tooling which needs access to the SEV_STATUS MSR is
> > using the MSR module. The use of this module poses a security risk in
> > any trusted execution environment and is generally discouraged.
> > 
> > Instead, provide an file in SYSFS in the already existing
> > /sys/devices/system/cpu/sev/ directory to provide the value of the
> > SEV_STATUS MSR to user-space.
> 
> Right, to continue this discussion on the ML, like we said yesterday, I think
> that dumping a raw MSR value is not really user-friendly.
> 
> We could stick a
> 
> Coco:
> 
> line in /proc/cpuinfo and simply dump SEV_STATUS there and TDX can put the
> respective TDX-specific feature flags of what is enabled there and then we
> have a good tested and well-known interface to communicate such things to
> userspace through.
> 
> I'd say...

It's *far* better to expose this via a targeted sysfs entry than 
polluting /proc/cpuinfo with it that everyone and their dog is parsing 
all the time ...

Thanks,

	Ingo

