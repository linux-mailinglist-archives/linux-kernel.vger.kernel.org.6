Return-Path: <linux-kernel+bounces-556930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA9BA5D0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD2C189E2B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70262641DB;
	Tue, 11 Mar 2025 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avPeT40l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121913FD1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741725429; cv=none; b=D5JywR+vFuyErnXzdTIoBR7WU01+8HdtWlDqliq07MpqthYOY5zvfq6QvAD+6r5JsJL7lQuFwifvNqGoqe5qx+enph9EjGf+iCJUlKlDkt3+GBELAlStuWvY/Qf3/iro2cfZkHENZ1U9d6ZZmXHKKj0Ded/Qykr0IWfxxh5aU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741725429; c=relaxed/simple;
	bh=BaUQMvtGuv+G+U8HEAuixqWeE8A1/dTw/aM12UROE/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh4ZID+pqbSSW5AFJALqEGXLQ1CqvSLOY5npqhGo7IcZN+5xUejVSFHJ3hOiWf9vET3mXuYB+keGlwLJ2erJKQpXVAqKer0CZOXQai1UJv1eflHXdYO8405ObjBh8efvg/tLhtyUg40VKTbTLArbpOhyxtL99K/k9wYURblk4Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avPeT40l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D38C4CEE9;
	Tue, 11 Mar 2025 20:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741725428;
	bh=BaUQMvtGuv+G+U8HEAuixqWeE8A1/dTw/aM12UROE/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=avPeT40lDjf+aCRvTPFqZKyhlseoq0fvSNCB+XeufWIUVp/mXdxJTGMxgaGrHPctv
	 VxKOX0zkXozYg1TI5aTC6CjZI0Pm3mUmh5lmn7ONg5RTRLKtSEouIgHWp2brVSva5B
	 lY7F24vo5+K8E/U6BQWEYEqJfjLoRVmzXFTR3cl9rWe6tGQx0Pee0UaIN++TAsyboR
	 ZOu3t2nau40yNVKBagipShMCOmrcmgKaoq64itJ3aSyuzbepDNyZcpH95mDA6hu9hD
	 ubb3va5Gortli9J5gRmb1DveL70FP0iaGAMLb3CHEiX7AMCZGmZFaCRdb6ZHNWIEvD
	 cP9UMRGgh/mWQ==
Date: Tue, 11 Mar 2025 21:37:02 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Borislav Petkov <bp@alien8.de>,
	=?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z9Ce7hVyCNfd_a_H@example.org>
References: <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <Z9AFyG7798M4VNJQ@suse.de>
 <29fa0d10-0d3d-47a0-8832-b2c7fc04f637@suse.com>
 <20250311110748.GCZ9AZhPYYAz-MXErv@fat_crate.local>
 <Z9B_yS_d8ny9hYUX@example.org>
 <Z9CDjecpydOsRhUy@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9CDjecpydOsRhUy@suse.de>

On Tue, Mar 11, 2025 at 07:40:13PM +0100, Joerg Roedel wrote:
> On Tue, Mar 11, 2025 at 07:24:09PM +0100, Alexey Gladkov wrote:
> > On Tue, Mar 11, 2025 at 12:07:48PM +0100, Borislav Petkov wrote:
> > > On Tue, Mar 11, 2025 at 11:22:23AM +0100, Jürgen Groß wrote:
> > > > I can live with that, as long as we make it possible to make e.g.
> > > > /sys/guest/xen a link to /sys/hypervisor (if xen is the hypervisor
> > > > the guest is directly running on). This means that /sys/guest/*/type
> > > > should not conflict with /sys/hypervisor/type.
> > > 
> > > Yeah, so Joerg and I came up with this on IRC:
> > > 
> > > /sys/hypervisor/{sev,tdx}
> > 
> > This directory is for guest-side information, right ?
> > 
> > > 
> > > * It should not disturb the current hierarchy there
> > > 
> > > * No need for a new hierarchy like /sys/guest - we haz enough and besides,
> > > /sys/hypervisor sounds like the right place already
> > 
> > The /sys/hypervisor is for host-side information ?
> 
> No, all under /sys/hypervisor is for guest-side information. There is
> not directory for host-side information yet. The question is whether a
> directory in SYSFS is needed, or whether there are other means to expose
> the same information.

Ok. Now I get it. Agree.

-- 
Rgrds, legion


