Return-Path: <linux-kernel+bounces-556710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAE7A5CDCE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1DCF7A5E06
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2D02638AA;
	Tue, 11 Mar 2025 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyG4UNAn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3552627E1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717456; cv=none; b=NyZ9NvsdVzRA7iG6KI4ROlGDme0pSkmDo5jnrNuV+xA0Q0vVeYZoEG3ODS7IM6IgNnfbAPVvivHbdh56HAY60lj+oXlzoOb4WukDXhSSpfrhNkkQaJQQ2Fsq7jZqLXsmrMdyJpqTBQRKrYMq8k1LBN7MmKolX1R8T5aLkbf162Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717456; c=relaxed/simple;
	bh=lpmksGqTnjCHS4LBQ9EZZlVH6U3AAEsOASjDiSMAZ/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=et88133XD1GdhDflP7T7biF+f/1BfAwyfcYJA6mLY3UcDsqMUZgTtmXXLNxyTDhwWCHyBOqkr2G6jE98qURbZeVkgKgeE3VISGkW6SdyFMFyvhRN4yiNRy20kiHphsjffSvYQzuYbwvj2Mv/s8PQsI/m+YqngOWFtJcCxJIBM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyG4UNAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4B6C4CEE9;
	Tue, 11 Mar 2025 18:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741717456;
	bh=lpmksGqTnjCHS4LBQ9EZZlVH6U3AAEsOASjDiSMAZ/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyG4UNAnJB4is7D+csAq/6otpUF6OdhvFBB/WhaQyHF3KGAvfRYvWOsqKsebK2XjP
	 +WaDVsv9rMQyoIeMZpVeOK1ZT5iOhxN1ng7/P2+YnDoSWmByiay+zJTLRM/3rZDzPY
	 0tpssyV9xPWOYzDasa4TIM4rR8HNoyYZzfqD+s6PKpJBjHn58jARLj6ZaYjo9G17Uw
	 8O48YoVIOyfInpRiJqbATeO/kBk1Nup075PZOkMViWsllbfgT9qY0FxrkbFP0CLMg8
	 3E15+fuWkTm60av3h4cUTaHuXHuxwLpQBJe8+771hrsPTVPDlO360fUhO9VjGhqCyh
	 mFTjNk8c70mfA==
Date: Tue, 11 Mar 2025 19:24:09 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	Joerg Roedel <jroedel@suse.de>, Joerg Roedel <joro@8bytes.org>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z9B_yS_d8ny9hYUX@example.org>
References: <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <Z9AFyG7798M4VNJQ@suse.de>
 <29fa0d10-0d3d-47a0-8832-b2c7fc04f637@suse.com>
 <20250311110748.GCZ9AZhPYYAz-MXErv@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311110748.GCZ9AZhPYYAz-MXErv@fat_crate.local>

On Tue, Mar 11, 2025 at 12:07:48PM +0100, Borislav Petkov wrote:
> On Tue, Mar 11, 2025 at 11:22:23AM +0100, Jürgen Groß wrote:
> > I can live with that, as long as we make it possible to make e.g.
> > /sys/guest/xen a link to /sys/hypervisor (if xen is the hypervisor
> > the guest is directly running on). This means that /sys/guest/*/type
> > should not conflict with /sys/hypervisor/type.
> 
> Yeah, so Joerg and I came up with this on IRC:
> 
> /sys/hypervisor/{sev,tdx}

This directory is for guest-side information, right ?

> 
> * It should not disturb the current hierarchy there
> 
> * No need for a new hierarchy like /sys/guest - we haz enough and besides,
> /sys/hypervisor sounds like the right place already

The /sys/hypervisor is for host-side information ?

> 
> * ...
> 
> So yeah, I guess we can try this.

If the answers to both questions are yes. Then I have understood
everything correctly and I agree with it.

-- 
Rgrds, legion


