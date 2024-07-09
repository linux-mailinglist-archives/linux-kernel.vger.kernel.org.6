Return-Path: <linux-kernel+bounces-246544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FC992C355
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F17E1F23834
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4BF1B86E4;
	Tue,  9 Jul 2024 18:35:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FF1152E06
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720550117; cv=none; b=X1wgC0lRbNAn2PMDlX5aK4ofOs0uE6SwhmSgiASUfyVEl30D+vLBOy4ELkozo/ujYc4reDEnZ9N8nttUgBF4fuBKFXfvG/eUQqu8rh1KWgmEuDCF5uAhVvpwsdphkBEa2PERaMAZyeQsyw9Trgh6XZ8ELkYWVYOjJBxgU1/XAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720550117; c=relaxed/simple;
	bh=/kmrUjfG2lke5V47WD9Hzhi1nWUEYQPuTIPtqN6DaQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDzSQ9looGj8lF9p4YKOGRiKloIcl2oK9h6rLeo124k4CLERCKfsTRZFIT32nsNyz/nWtXpH5HF6w/Up6axV5EkJKCYaCdoK/tBVEcir0/VN4BmZHh5Xbv9MBwIQvhez4IW9kQiG+03oYvQ5xYbvt5Y7Xt9mN7HgzPNWXFKnX20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F4DC3277B;
	Tue,  9 Jul 2024 18:35:15 +0000 (UTC)
Date: Tue, 9 Jul 2024 19:35:13 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
	anshuman.khandual@arm.com, david@redhat.com,
	scott@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Message-ID: <Zo2C4eXr5_9kifyO@arm.com>
References: <20240626191830.3819324-1-yang@os.amperecomputing.com>
 <Zn7q3oL1AE8jdM-g@arm.com>
 <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
 <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com>
 <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com>
 <ZoZzhf9gGQxADLFM@arm.com>
 <35f70ba6-5305-4268-b7ba-81545cacd83f@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f70ba6-5305-4268-b7ba-81545cacd83f@os.amperecomputing.com>

On Tue, Jul 09, 2024 at 10:56:55AM -0700, Yang Shi wrote:
> On 7/4/24 3:03 AM, Catalin Marinas wrote:
> > I haven't figured out what the +24% case is in there, it seems pretty
> > large.
> 
> I think I ran the test much more iterations and I didn't see such outlier
> anymore.

That's good, thanks for confirming.

> > What you haven't benchmarked (I think) is the case where the instruction
> > is in an exec-only mapping. The subsequent instruction read will fault
> > and it adds to the overhead. Currently exec-only mappings are not
> > widespread but I heard some people planning to move in this direction as
> > a default build configuration.
> 
> I tested exec-only on QEMU tcg, but I don't have a hardware supported EPAN.
> I don't think performance benchmark on QEMU tcg makes sense since it is
> quite slow, such small overhead is unlikely measurable on it.

Yeah, benchmarking under qemu is pointless. I think you can remove some
of the ARM64_HAS_EPAN checks (or replaced them with ARM64_HAS_PAN) just
for testing. For security reason, we removed this behaviour in commit
24cecc377463 ("arm64: Revert support for execute-only user mappings")
but it's good enough for testing. This should give you PROT_EXEC-only
mappings on your hardware.

-- 
Catalin

