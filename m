Return-Path: <linux-kernel+bounces-262124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E0E93C113
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11574283121
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7EE199251;
	Thu, 25 Jul 2024 11:45:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174453C3C;
	Thu, 25 Jul 2024 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721907914; cv=none; b=MHegGEbNTWEhfSKZI26WXKLnpBolk6EnkNutyABFlHFp59qpnE5E60x9tXgIuml2bbyXyfF7GMjzvjzCF9oZLOFfdSbMKeuK+VhcGQdrkDiPlHZPJdLsOhKPc8CoIV9g9js87ZwMFgw7O22T3+/So1rTtsWPhWLoyA/tVkvdLNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721907914; c=relaxed/simple;
	bh=82HUmzeqarD4KrIPXNsJ7gdikxRUHGCc9rvH7hg483g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTo7Bmenl1LJg8Q/MDCzxYNcsX6u8WFMq43QzhhluMhmPuHhTjjDRCaLUy4FjAQWBQRafMdqVeO8WrmSKoK6h3VQ4aaSWppTIzKkVDdqRTuOpFlmbDt6sX1O3HBHNAokegHJg4SI2vvZ2koN9W5mXhHDOYCTr206S1asyhgoU2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4DA21476;
	Thu, 25 Jul 2024 04:45:37 -0700 (PDT)
Received: from [10.1.196.44] (unknown [10.1.196.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D22093F5A1;
	Thu, 25 Jul 2024 04:45:08 -0700 (PDT)
Message-ID: <3db15f74-2f48-4a43-9a2f-27b54c22dbf1@foss.arm.com>
Date: Thu, 25 Jul 2024 12:45:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm: panthor: add dev_coredumpv support
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, ojeda@kernel.org,
 Danilo Krummrich <dakr@redhat.com>, lyude@redhat.com, robh@kernel.org,
 lina@asahilina.net, mcanal@igalia.com, airlied@gmail.com,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <fe84a028-01a8-4987-b1b7-141fb76d263c@arm.com>
 <4344B22F-D859-4C64-A351-69FFB5208362@collabora.com>
 <edda856e-3102-495a-8cc6-b79f5f114833@arm.com>
 <20240723180642.73502856@collabora.com>
Content-Language: en-US
From: Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <20240723180642.73502856@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/24 5:06 PM, Boris Brezillon wrote:
> Hi Steve,
> 
> On Mon, 15 Jul 2024 10:12:16 +0100
> Steven Price <steven.price@arm.com> wrote:
> 
>> I note it also shows that the "panthor_regs.rs" would ideally be shared.
>> For arm64 we have been moving to generating system register descriptions
>> from a text source (see arch/arm64/tools/sysreg) - I'm wondering whether
>> something similar is needed for Panthor to generate both C and Rust
>> headers? Although perhaps that's overkill, sysregs are certainly
>> somewhat more complex.
> 
> Just had a long discussion with Daniel regarding this panthor_regs.rs
> auto-generation, and, while I agree this is something we'd rather do if
> we intend to maintain the C and rust code base forever, I'm not
> entirely convinced this is super useful here because:
> 
> 1. the C code base is meant to be entirely replaced by a rust driver.
> Of course, that's not going to happen overnight, so maybe it'd be worth
> having this autogen script but...
> 
> 2. the set of register and register fields seems to be pretty stable.
> We might have a few things to update to support v11, v12, etc, but it
> doesn't look like the layout will suddenly become completely different.
> 
> 3. the number of registers and fields is somewhat reasonable, which
> means we should be able to catch mistakes during review. And in case
> one slip through, it's not the end of the world either because this
> stays internal to the kernel driver. We'll either figure it out when
> rust-ifying panthor components, or that simply means the register is
> not used and the mistake is harmless until the register starts being
> used
> 
> 4. we're still unclear on how GPU registers should be exposed in rust,
> so any script we develop is likely to require heavy changes every time
> we change our mind

You have a good point. A script sounds nice, but given the restricted 
domain size, it maybe better to be manually maintained. Given that I 
also think the right way to access registers is to do it as safely as 
possible.

So a gpu_write() or gpu_read() are "unsafe" in that you can write 
invalid values to a just about anything in C. If we're trying to harden 
drivers like panthor and make it "impossible" to do the wrong thing, 
then IMHO for example MCU_CONTROL should be abstracted so I can ONLY 
write MCU_CONTROL_* values that are for that register and nothing else 
in Rust. This should fail at compile time if I ever write something 
invalid to a register, and I can't write to anything but a known/exposed 
register.

Interestingly the C code could also abstract the same way and at least 
produce warnings too and become safer. It may be useful to mimic the 
design pattern there to keep panthor.rs and panthor.c in sync more easily?

So my opinion would be to try get the maximum value from Rust and have 
things like proper register abstractions that are definitely safe.

> For all these reasons, I think I'd prefer to have Daniel focus on a
> proper rust abstraction to expose GPU registers and fields the rust-way,
> rather than have him spend days/weeks on a script that is likely to be
> used a couple times (if not less) before the driver is entirely
> rewritten in rust. I guess the only interesting aspect remaining after
> the conversion is done is conciseness of register definitions if we
> were using some sort of descriptive format that gets converted to rust
> code, but it comes at the cost of maintaining this script. I'd probably
> have a completely different opinion if the Mali register layout was a
> moving target, but it doesn't seem to be the case.
> 
> FYI, Daniel has a python script parsing panthor_regs.h and generating
> panthor_regs.rs out of it which he can share if you're interested.
> 
> Regards,
> 
> Boris

