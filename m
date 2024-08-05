Return-Path: <linux-kernel+bounces-274709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456E5947BB7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D9F2834EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8933915AD95;
	Mon,  5 Aug 2024 13:18:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D54155730
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863884; cv=none; b=sCQrMkIpKP6Zf/R5V52s+KQgxmqAFrDiKCS8ScEQb97rLd6DcH2ZrxkVBH8Iv+eYnlYKpcQtFCHixEUxD7deDrXt0fvCNPOqj8aZH/MGi5/x8xqysJa6CHHAzm2Wq3uQCw4VFUSH9jbjYo8kgARSSrgjb0KgEsvs0yjNVHIjb2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863884; c=relaxed/simple;
	bh=SvevPXi9fnjccO/eYyIhE7f24dWlC/0t/3PFVnasmbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2F8CEUcIyB5cPMiYEE4IOSleFXvHLGRzXTYgoYGtm7aF+gsx2N3W55At1jR0OvsxQlrTbAJnl816HcQrbk0268f8PLFBl9J5VgDJxxue0Vg22ooJ891BfFa8090jkkt2tiMVFaWBUWaaPX6vMQcoIAj/uFt/JjpbgVFz3cdMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B640C32782;
	Mon,  5 Aug 2024 13:18:02 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:18:00 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, bhe@redhat.com,
	akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ARM: Support allocating crashkernel above 4G for LPAE
Message-ID: <ZrDRCP9tyvXLfAYs@arm.com>
References: <20240802092510.3915986-1-ruanjinjie@huawei.com>
 <Zqy8lwZM2Z6RlV5H@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqy8lwZM2Z6RlV5H@shell.armlinux.org.uk>

On Fri, Aug 02, 2024 at 12:01:43PM +0100, Russell King wrote:
> On Fri, Aug 02, 2024 at 05:25:10PM +0800, Jinjie Ruan wrote:
> > As ARM LPAE feature support accessing memory beyond the 4G limit, define
> > HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH macro to support reserving crash

At least in 6.11-rc1, there's no trace of such macro anywhere. So not
sure this patch has any effect (I haven't checked linux-next though).

> > memory above 4G for ARM32 LPAE.
> > 
> > No test because there is no LPAE ARM32 hardware.
> 
> Why are you submitting patches for features you can't test?
> 
> I'm not going to apply this without it being properly tested, because I
> don't believe that this will work in the generic case.
> 
> If the crash kernel is located in memory outside of the lower 4GiB of
> address space, and there is no alias within physical address space
> for that memory, then there is *no* *way* for such a kernel to boot.
> 
> So, right now I believe this patch to be *fundamentally* wrong.

Indeed. Even on arm64, we keep some crashkernel reservations in the
lower parts of the memory for ZONE_DMA allocations.

On arch/arm with LPAE, we could do something similar like forcing some
lowmem reservation and allowing explicit allocation in the higher ranges
with crashkernel=<size>,high. We should, of course, force the kdump
image placement in the lower memory. The user kexec tools must be taught
to interpret this information and provide a DT accordingly to the crash
kernel.

-- 
Catalin

