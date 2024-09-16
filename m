Return-Path: <linux-kernel+bounces-330861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850F897A556
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37CBFB20F68
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF9156861;
	Mon, 16 Sep 2024 15:30:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A82D1BF24;
	Mon, 16 Sep 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500645; cv=none; b=Cw+Wcl3auQAWa/Vg4xEV+vuZt7xDiCh36MtI+aukCIKJ5PzTFMmqHyOO0zMVlH6fLBO1m0SznbiJdZ9KJUfLDgeyXINrZ4VBf0nxtllf8xl3/QW3ooptQFZVm2hCjwh/tqkYVArWHCXO0HkVF4alDvWjfuiBv6pEVQdx09BRJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500645; c=relaxed/simple;
	bh=WCXq8/m0f0eY3CA7UHZc/7PY/9TzlMuVY6/oBP5vKl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZF0dk2Gz4ed5VEo+JATzorybYvnUVKowLswi53C/tvh2HcRDvLOhJOK7NZoZXrP/ksaMRLCxWjn+DoeRVh24MD07mgDvJQXHxRcvLz7+kLhu3IF6jrHyLysNH03tzvnOoS6ufpNppDpknFky9tU3CxXagS9yYMz0z5rBRllI1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DA1C4CEC4;
	Mon, 16 Sep 2024 15:30:43 +0000 (UTC)
Date: Mon, 16 Sep 2024 16:30:41 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: cpufeature: Pretend that Apple A10 family
 does not support 32-bit EL0
Message-ID: <ZuhPIdnx36yXJhHi@arm.com>
References: <20240909091425.16258-1-towinchenmi@gmail.com>
 <20240909091425.16258-3-towinchenmi@gmail.com>
 <f908c9ca-8063-44f4-b534-ddfc067b98c2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f908c9ca-8063-44f4-b534-ddfc067b98c2@gmail.com>

On Mon, Sep 16, 2024 at 09:41:12PM +0800, Nick Chan wrote:
> On 9/9/2024 17:10, Nick Chan wrote:
> > The Apple A10 family consists of physical performance and efficiency
> > cores, and only one of them can be active at a given time depending on
> > the current p-state. However, only the performance cores can execute
> > 32-bit EL0. This results in logical cores that can only execute 32-bit
> > EL0 in high p-states.
> 
> Further research shows that the MPIDR_EL1 values between the two core
> types are different. And whether the two core type have any extra
> differences is anyone's guess right now. So far, nothing seems to break
> horribly without special workarounds for the MPIDR value (with cpufreq
> enabled downstream) as:
> 1. There are no KVM, GIC, ACPI, PSCI or cpuidle
> 2. All CPUs switch P-mode and E-mode together
> 
> However, all of this is broken enough that this piece of code should go
> into arch/arm64/kernel/cpu_errata.c, and also generate a
> TAINT_CPU_OUT_OF_SPEC for these cursed CPUs.

I wouldn't carry any additional logic in the kernel for such
configuration (long time ago Arm had something similar, the big.LITTLE
switcher, but the CPUs were fairly similar from a feature perspective).

> > Trying to support 32-bit EL0 on a CPU that can only execute it in certain
> > states is a bad idea. The A10 family only supports 16KB page size anyway
> > so many AArch32 executables won't run anyways. Pretend that it does not
> > support 32-bit EL0 at all.

CONFIG_COMPAT depends on ARM64_4K_PAGES || EXPERT. Do we really need
these patches in case one enables EXPERT and tries to run 32-bit
binaries that never ran on 16K pages before?

-- 
Catalin

