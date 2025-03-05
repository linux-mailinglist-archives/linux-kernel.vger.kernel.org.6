Return-Path: <linux-kernel+bounces-546710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5BAA4FDE6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B8517122C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822F223ED52;
	Wed,  5 Mar 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmuM3J5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E4230BCC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174966; cv=none; b=PLieGAdRaefFdZYLJEFlgbdfbnZXBVqhfhXHv62tKXli2AxJT5gJdkTnJM1OXg60X8UnBwxcP151hTlxqs5YGyBWHy++0iiSGEZy1s2LQz1HFeXfTM956O5y2fGsLUr7ni2RT6enYlECy80zyHvyV6q+Em5E5O892xlsJdRuLjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174966; c=relaxed/simple;
	bh=KjsfbTU7zD5Gvhg7iuchzjdqtY822AL3RH1z9Wz1FdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2xHn8cI9YhgZaVaHkmKilwT4HeB0KqgngvxDysNlzGJOZRD3ASj/DauKpNLzoZNQwlcjdEir67YNgBnN8hFoZQClmcowYZOefFRmBMShfxwxO4FWKKPFFDa8TCXZC0OOC4Uxuk38qb/jvS1Ok7NeXHjXiqh1aPf1DHtfP+PpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmuM3J5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC5CC4CEE9;
	Wed,  5 Mar 2025 11:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741174966;
	bh=KjsfbTU7zD5Gvhg7iuchzjdqtY822AL3RH1z9Wz1FdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmuM3J5hqIDlLN+2AY/hFSRqrzMITLYt9bez0Fj2LlWgj7FD9nDJuJhYM+4Kqfgps
	 JRGrmFfGa7PDRSuZapBDALPKIKIDVDDAVdcOOCvOcC43M8gkNCqxxw38vAoFe+qhyA
	 D0xGiMIp3qkrBJTOt6mAeALfGhE3J8oPZVzgvCVAYvBu/2UJIyHHLmQxx9ykSCgLgs
	 e5pO680AVNFbIfs/ILmRXG6mGBgflOOAsPtVX+UZ9btzL10L3QgSYGlVfS4wGVq8mH
	 utSOrMwWx/78cMMmnqe2+sh1AHjx4kxQuKWXtXVR7JxutSqMOVR4xEq7D69IkqDw1G
	 vUl76qVNNzCfg==
Date: Wed, 5 Mar 2025 12:42:41 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z8g4sU_dsZgY0PuS@gmail.com>
References: <20250305105234.235553-1-joro@8bytes.org>
 <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Mar 05, 2025 at 12:26:13PM +0100, Ingo Molnar wrote:
> > It's *far* better to expose this via a targeted sysfs entry than 
> > polluting /proc/cpuinfo with it that everyone and their dog is parsing 
> > all the time ...
> 
> Pasting what we're talking on IRC:
> 
> - we don't want to expose a naked MSR u64 to userspace.

As long as it's architected values that won't change randomly, I don't 
see the harm, and we expose raw feature bits all the time in sysfs.

User-space tooling would just unnecessarily parse and decode it anyway.

So if the convenience of tooling is the argument, the raw feature mask 
exposed is the best option overall.

> Might as well use msr-tools
> 
> - the backstory is, there are a bunch of tools which wanna know this so we
>   need to agree on how to supply it to them
> 
> - I think /proc/cpuinfo is the best option right now

So I disagree with that placement: /proc/cpuinfo is fundamentally 
per-CPU, while sev_status is a machine-wide word in .data. Also, 
something that is needed infrequently should not be put into the 
frequently used /proc/cpuinfo file.

> - and then TDX can use the same thing too
> 
> - we have a general need to expose what a confidential guest supports
> 
> - a .../sev sysfs file clearly doesn't cut it because TDX doesn't have "sev"
>   - it is the Intel version of a confidential guest
> 
> - and I don't want to have "0xdeadbeef" in some sys file but "SEV SEV-ES TDX
>   SecureTSC" and so on user-readable strings

So the /sys/devices/system/cpu/sev/ directory already exists and your 
arguments already apply to that, don't they?

As to the hex numbers - do you prefer to put string versions of these 
into the sysfs file:

 MSR_AMD64_SEV_ENABLED
 MSR_AMD64_SEV_ES_ENABLED
 MSR_AMD64_SEV_SNP_ENABLED
 MSR_AMD64_SNP_DEBUG_SWAP
 MSR_AMD64_SNP_SECURE_TSC
 MSR_AMD64_SNP_VTOM

?

Thanks,

	Ingo

