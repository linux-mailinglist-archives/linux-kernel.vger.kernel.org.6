Return-Path: <linux-kernel+bounces-284720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E042A950469
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816321F222EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC95199E82;
	Tue, 13 Aug 2024 12:04:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DCC19938D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550676; cv=none; b=SaOR7libqvqNeoGGb/Plbk77PjSkQw8PMISCgdZjveSgOyJBJWu/1Ecfb/CNcbr29g7t0DsofUJQCMESNpL8VjXhH8J6szg4h9yrOaTFFSDwMOiTiHfbBJ5TUWMfb6QrMWJCknWf7aUDqt3PdAh5NzIyhNdCRhMuy39HjFkF5Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550676; c=relaxed/simple;
	bh=q3plWg+ipU5a9ye6aWHhJI7i1/Mmbaj20oIK2hhbuPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpPvXf1B/QAFNuAXPlgFQkiHAaLwPhGG8dwJvb+lA57+30wh4KhauWAUJoBehouF4gnYDv+9IseLDSzeKVoZ1/c+20NA1uNxUCloAdHJduP+WSUaz2xnZ3nn1UQ+mmd3ZNHIC2LYfJd1opCpYffKcUoo9VtwxJcKSftCGuEEq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67DCC4AF0B;
	Tue, 13 Aug 2024 12:04:33 +0000 (UTC)
Date: Tue, 13 Aug 2024 13:04:31 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Baoquan He <bhe@redhat.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
	vgoyal@redhat.com, dyoung@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, chenjiahao16@huawei.com,
	akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Message-ID: <ZrtLz8VHzZIULbOT@arm.com>
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
 <ZqywtegyIS/YXOVv@MiWiFi-R3L-srv>
 <ZrJ1JkyDVpRRB_9e@arm.com>
 <ZrJ60vopeGDXFZyK@arm.com>
 <20240813104006.520bf42d@mordecai.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240813104006.520bf42d@mordecai.tesarici.cz>

Hi Petr,

On Tue, Aug 13, 2024 at 10:40:06AM +0200, Petr Tesařík wrote:
> On Tue, 6 Aug 2024 20:34:42 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > I haven't tried but it's possible that this patch also breaks those
> > arm64 platforms with all RAM above 4GB when CRASH_ADDR_LOW_MAX is
> > memblock_end_of_DRAM(). Here all memory would be low and in the absence
> > of no fallback, it fails to allocate.
> 
> I'm afraid you've just opened a Pandora box... ;-)

Not that bad ;) but, yeah, this patch was dropped in favour of this:

https://lore.kernel.org/r/20240812062017.2674441-1-ruanjinjie@huawei.com/

> Another (unrelated) patch series made us aware of a platforms where RAM
> starts at 32G, but IIUC the host bridge maps 32G-33G to bus addresses
> 0-1G, and there is a device on that bus which can produce only 30-bit
> addresses.
> 
> Now, what was the idea behind allocating some crash memory "low"?
> Right, it should allow the crash kernel to access devices with
> addressing constraints. So, on the above-mentioned platform, allocating
> "low" would in fact mean allocating between 32G and 33G (in host address
> domain).

Indeed. If that's not available, the crash kernel won't be able to boot
(unless the corresponding device is removed from DT or ACPI tables).

> Should we rethink the whole concept of high/low?

Yeah, it would be good to revisit those at some point. For the time
being, 'low' in this context on arm64 means ZONE_DMA memory, basically
the common denominator address range that supports all devices on an
SoC. For others like x86_32, this means the memory that the kernel can
actually map (not necessarily device/DMA related).

So, it's not always about the DMA capabilities but also what the crash
kernel can map (so somewhat different from the zone allocator case we've
been discussing in other threads).

-- 
Catalin

