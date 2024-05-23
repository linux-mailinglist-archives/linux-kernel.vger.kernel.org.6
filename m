Return-Path: <linux-kernel+bounces-188042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E97A8CDC27
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB3A1C209D5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0696B127B66;
	Thu, 23 May 2024 21:34:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90488811FF
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716500079; cv=none; b=Whb0oHWL8Gyiz7hEV8uVZUnjgR0+nuLPNT9NCeGwJJXZgbPTwRuws3TJO9JlnxShWmXAMYGebhS37Tlq2Cy7PVMi9x/Gi1v0tfQ+B9VqSsw0BsQ0xzsY4kBDp7d7154CsxmQPAET/MytZJtURD7tf6dB3eh8yTWdx0Oi+JdLlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716500079; c=relaxed/simple;
	bh=K7OioervpsduQtFyeU96++HOAKnvbyCclRoqOWrO4Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aup2+1Gdl76x2ovRGv959hQGWJSUVoOw+m5Lp05vPKIs0ggKs3+wsoLTIQxQMZXlzVP0QiNLvLttU1I43uvzZOpado6toNGO3AJAvAPu3Y1G4SGSCMB/zLtTIUDwF4KK+7GGG2Bjl4UvOOZI6vTI4TnybA8bW0/keKFP3jo73hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C89C2BD10;
	Thu, 23 May 2024 21:34:37 +0000 (UTC)
Date: Thu, 23 May 2024 22:34:35 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
	anshuman.khandual@arm.com, scott@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Message-ID: <Zk-2a7s2pvkVsm2C@arm.com>
References: <20240520165636.802268-1-yang@os.amperecomputing.com>
 <Zk93vBqAD3LgmbGb@arm.com>
 <640f8606-2757-4e82-721f-9625d48ded65@gentwo.org>
 <Zk-SNVyEHT1UsxqD@arm.com>
 <ad87bb77-a9a5-2c0d-b4b2-13db09615d7c@linux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad87bb77-a9a5-2c0d-b4b2-13db09615d7c@linux.com>

On Thu, May 23, 2024 at 12:43:34PM -0700, Christoph Lameter (Ampere) wrote:
> On Thu, 23 May 2024, Catalin Marinas wrote:
> > > > While this class includes all atomics that currently require write
> > > > permission, there's some unallocated space in this range and we don't
> > > > know what future architecture versions may introduce. Unfortunately we
> > > > need to check each individual atomic op in this class (not sure what the
> > > > overhead will be).
> > > 
> > > Can you tell us which bits or pattern is not allocated? Maybe we can exclude
> > > that from the pattern.
> > 
> > Yes, it may be easier to exclude those patterns. See the Arm ARM K.a
> > section C4.1.94.29 (page 791).
> 
> Hmmm. We could consult an exception table once the pattern matches to reduce
> the overhead.

Yeah, check the atomic class first and then go into the finer-grained
details. I think this would reduce the overhead for non-atomic
instructions.

> However, the harm done I think is acceptable even if we leave things as is.
> In the worst case we create unnecesssary write fault processing for an
> "atomic op" that does not need write access. Also: Why would it need to be
> atomic if it does not write???

I'm thinking of some conditional instruction that states no write if
condition fails. But it could be even worse if the architects decide to
reuse that unallocated space for some instructions that have nothing to
do with the atomic accesses.

It's something we need to clarify with them but I'm about to go on
holiday for a week, so I won't be able to check.

> The ultimate solution would be to change the spec so that arm processors can
> skip useless read faults.

I raised this already, waiting for feedback from the architects.

-- 
Catalin

