Return-Path: <linux-kernel+bounces-187901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794D78CDA53
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A151F21446
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA2D7E79F;
	Thu, 23 May 2024 19:00:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BE02AD00
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716490806; cv=none; b=VDVm1YOMCJ3Cgg0BDb8xh7wwlXDUCXqaaRyj+42OFLx+/iDnRm0NZ4Z6TU4lWfUSziz5hSxB9ctQ7QQ+2AAqaUsXBDfDkPw6W6TWgiN++uBem7STkoPJ54OOfJPVjAPtlbJXT59/e+QX810XQyJkmB8PWc+umBjTGkHlU6oaDyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716490806; c=relaxed/simple;
	bh=EosZtLydwwPjBlSIxN8KIXivtKpM5s454tQXJ9Q6SBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5pJUq0dfuQ8+ECCpFlKR9wMPTrn2yevYQJkJvJTRZg1E3MYsPN2HY0Nazc4S+17HlInXSXu/86ElC5oSD8XN3RXqASZZYlzkrH8YH5/8o3YNuSV8zfTQA5mbip260TItG4SklkTdRb5vF8PZMPWbNEho7rOA1f6E0NbYwzOS3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFD1C2BD10;
	Thu, 23 May 2024 19:00:03 +0000 (UTC)
Date: Thu, 23 May 2024 20:00:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
	anshuman.khandual@arm.com, scott@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Message-ID: <Zk-SNVyEHT1UsxqD@arm.com>
References: <20240520165636.802268-1-yang@os.amperecomputing.com>
 <Zk93vBqAD3LgmbGb@arm.com>
 <640f8606-2757-4e82-721f-9625d48ded65@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <640f8606-2757-4e82-721f-9625d48ded65@gentwo.org>

On Thu, May 23, 2024 at 11:09:11AM -0700, Christoph Lameter (Ampere) wrote:
> On Thu, 23 May 2024, Catalin Marinas wrote:
> 
> > On Mon, May 20, 2024 at 09:56:36AM -0700, Yang Shi wrote:
> > > diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> > > index db1aeacd4cd9..1cc73664fc55 100644
> > > --- a/arch/arm64/include/asm/insn.h
> > > +++ b/arch/arm64/include/asm/insn.h
> > > @@ -319,6 +319,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
> > >   * "-" means "don't care"
> > >   */
> > >  __AARCH64_INSN_FUNCS(class_branch_sys,	0x1c000000, 0x14000000)
> > > +__AARCH64_INSN_FUNCS(class_atomic,	0x3b200c00, 0x38200000)
> > 
> > While this class includes all atomics that currently require write
> > permission, there's some unallocated space in this range and we don't
> > know what future architecture versions may introduce. Unfortunately we
> > need to check each individual atomic op in this class (not sure what the
> > overhead will be).
> 
> Can you tell us which bits or pattern is not allocated? Maybe we can exclude
> that from the pattern.

Yes, it may be easier to exclude those patterns. See the Arm ARM K.a
section C4.1.94.29 (page 791).

-- 
Catalin

