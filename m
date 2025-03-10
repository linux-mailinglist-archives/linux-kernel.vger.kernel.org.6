Return-Path: <linux-kernel+bounces-554602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BFEA59A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A909B16CB2B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9051F22D79B;
	Mon, 10 Mar 2025 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihvbZR7T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E899C1E519
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621821; cv=none; b=qRx8GJ/Kzda957uA2bHS3Eyh5UfMfpuO6MHJMhYZx6igQ/O1RTl0U+zwJ5Ayp5tawUPWwWrThfOW3j5v+dfYEBkUmdnGAIRT2ijbiYZnc1dRKNyqrXSC2R77xgHk+r6kE6NltyDEJ6yi+kxogZukxiTT4UKjTms1sLwsyXVH17A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621821; c=relaxed/simple;
	bh=rKqJdaCGrVTq7fNXHtoNo7yxxOy7HgFbH3suWMmXC8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhUXE/tMv/21u1ARkelvVbRlebipBXiUn0GQPEQMgDQTmuo9gcrp7zKIuMLsGtOXFytznGinrdzUFWHGu4DagJkgEZEOEpC1dnjh2bqPG8ceq7+zxXx/jaGdh2vdz2OweHWFXf4sDpSFw00kpv2nMFzligW9hkXU5T9DX255G9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihvbZR7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CABC4CEE5;
	Mon, 10 Mar 2025 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741621820;
	bh=rKqJdaCGrVTq7fNXHtoNo7yxxOy7HgFbH3suWMmXC8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihvbZR7TfRvi0q3mkJBev9kqUd7LrUGGYhN5ojcjSWGA8Wrx/rpISWILDKYL6MF4Y
	 +je15DXjJ/1P/0K90rmtsslvlItR0w+diCs31k12h0WOjGl89rVfDYNBtAWUakwK/2
	 ppscyp1NtY6yuc2H8WpU98saUmS/3OqgdcqN1wK/Ad4uI+DSSZGTa31MxmHYk+ZHpv
	 hHpPNQwyBsjcvppnTXomHTRMQMI2oNVA4r6hYxQ8TMAOB0b5DhDkHboVVkk3n1d5ZE
	 dBHZktVDv3meyeeirDf8Fx+biVqU6X1w3QOZN/oNlepUW34MKDPgS2E/Vl59Hnvxm8
	 lEuh7HX47tv8w==
Date: Mon, 10 Mar 2025 16:50:13 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z88KNWJ-6SsT4NPZ@example.org>
References: <Z86-3n1-MArVLM9Z@8bytes.org>
 <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com>
 <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <20250310154152.GQZ88IQLEHoAi0HLdU@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310154152.GQZ88IQLEHoAi0HLdU@fat_crate.local>

On Mon, Mar 10, 2025 at 04:41:52PM +0100, Borislav Petkov wrote:
> On Mon, Mar 10, 2025 at 04:33:08PM +0100, Jürgen Groß wrote:
> > Kind of.
> > 
> > /sys/hypervisor is meant to provide data for running under a hypervisor.
> > 
> > It is NOT meant to provide data for running as a hypervisor.
> 
> Hah.
> 
> Which would mean that
> 
> /sys/hypervisor == /sys/guest
> 
> the way we envision it.
> 
> Do we need to dump all the HV levels in it?

Hm. We already have:

/sys/hypervisor/type        (Type of hypervisor)
/sys/hypervisor/guest_type  (Type of guest)

I don't really understand how you propose to locate the files for host and
guest and what you propose to put in /sys/guest.

> I think Joerg wants to dump the fact that there's an SVSM present. I guess we
> can dump the "stack" of "things" running under Linux as you suggest it.
> 
> Hmmm.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 

-- 
Rgrds, legion


