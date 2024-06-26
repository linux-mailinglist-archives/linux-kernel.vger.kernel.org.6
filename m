Return-Path: <linux-kernel+bounces-230823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A404918255
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB105284BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC3018133E;
	Wed, 26 Jun 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwNOYK2v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE6A16190C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408400; cv=none; b=gTl8D8nM9dqMRtdslpQnEhIk8wtWKnpw68qL9qbq/fNdiPjDcx8QNqJrQjYCP5+BayMTfKe7N/+4NQrWHDmv2ErWAtPK6HGPlRIa/6H9UnoEaV8pCuFd9V1bHjHQawTmAMgk0IKtsQDaQbIfNCrssRLoJb8U2u31h8nQbUu3LU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408400; c=relaxed/simple;
	bh=EKEukY2Atk2e+DpV4wGfieBESQlkebWAUM/m4x4vr1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izkeSHlQoO6/lbl0eQQk/E6Hvrq3QIsPTYSfXJw6nTtL63dxXCNe2peFuI3h7aqomy9ToYM4Ztsqyk051qyoiAHQ28r5BCxdeYG6Vdq5UTwwrSUZrm73xiHU25TeepuKsqP8G24Aabqqxp4FNDSCXRIr/NxmGHTso7cce1uoy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwNOYK2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEF2C2BD10;
	Wed, 26 Jun 2024 13:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719408399;
	bh=EKEukY2Atk2e+DpV4wGfieBESQlkebWAUM/m4x4vr1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwNOYK2vPy5I+hqLF4ZE535mms2YuZ2Qa9GYhitSARJ6bRBkLJO+pFN76bUOWcXZL
	 rQwTpClSKJZdJjylUZwh5JfhgIPwsetcAxo/CCvGv8eUX4NLD9wkeUT2Ocwqx5flgu
	 TH4WcdTeg1b9t0AW93B0qs40o3SBIGxV4FQg0b6SyO5VH9SoVk2yZZ6ObBE7h+ryjf
	 UyxMpxQ7gkFyy+XOUR0BAz7HS1y3bOY/75S1Ji54ZLvr6uu6Wp0UYkO9fnjL1Bf4ZR
	 MS/OobgU7/1MUC40mp5T4iht5IDJaaMNAVrCZLzO3GQUyF3V5Orsbfllh7XbbM7ZGQ
	 BDT6a6HyfWIQA==
Date: Wed, 26 Jun 2024 21:12:34 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] riscv: uaccess: use input constraints for ptr of
 __put_user
Message-ID: <ZnwTwnSsnZ8Td9GZ@xhacker>
References: <20240625040500.1788-1-jszhang@kernel.org>
 <20240625040500.1788-3-jszhang@kernel.org>
 <mvmikxvonjh.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mvmikxvonjh.fsf@suse.de>

On Wed, Jun 26, 2024 at 03:12:50PM +0200, Andreas Schwab wrote:
> On Jun 25 2024, Jisheng Zhang wrote:
> 
> > I believe the output constraints "=m" is not necessary, because
> > the instruction itself is "write", we don't need the compiler
> > to "write" for us.
> 
> No, this is backwards.  Being an output operand means that the *asm* is
> writing to it, and the compiler can read the value from there afterwards
> (and the previous value is dead before the asm).

Hi Andreas,

I compared tens of __put_user() caller's generated code between orig
version and patched version, they are the same. Sure maybe this is
not enough. 

But your explanation can be applied to x86 and arm64 __put_user()
implementations, asm is also writing, then why there's no output
constraints there?(see the other two emails)? Could you please help
me to understand the tricky points?

Thanks in advance

