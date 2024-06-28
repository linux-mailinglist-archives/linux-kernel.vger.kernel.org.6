Return-Path: <linux-kernel+bounces-234290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E03291C4BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A15C285430
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE99B1C68BC;
	Fri, 28 Jun 2024 17:24:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789AA1DDCE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595448; cv=none; b=szmd5PmaLzLCPWUvCNP6VfmRhy4CnaH8n+NSGeI7UtPVKne/Vi+VblcEZ4voaV+zz9+sNwwtz60SyrUrWciWntGD+9e7TgU8PQYH5GovKtBf1KGDQmMiDZwigOmawK+ZGyNRdVOD9q85igBmW3JX6ku/f2CQVxoY/lyeT4pdo7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595448; c=relaxed/simple;
	bh=Ql5xPJU3Wom/MH58ldYMFaIe3lWXq/uMQ/D0jWtAw+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLpoV6d8TjEJcPM/huYn1iWHUoqgmI7SVoU0dhsDh2YeRdpYtLx7IcQrGfIJSuabFaEMAd0M94j1ddjD29b6WoVWQtczQTsAMrSI8eyVgiTmlgJupmYkKzHLiiITY6oze3Zeq7qIrLzgJvhhQK8pN84L7VmvwgMKMgaPCvn5yG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A82BC116B1;
	Fri, 28 Jun 2024 17:24:06 +0000 (UTC)
Date: Fri, 28 Jun 2024 18:24:03 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
	anshuman.khandual@arm.com, david@redhat.com,
	scott@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Message-ID: <Zn7xs6OYZz4dyA8a@arm.com>
References: <20240626191830.3819324-1-yang@os.amperecomputing.com>
 <Zn7q3oL1AE8jdM-g@arm.com>
 <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>

On Fri, Jun 28, 2024 at 09:57:37AM -0700, Christoph Lameter (Ampere) wrote:
> On Fri, 28 Jun 2024, Catalin Marinas wrote:
> > On Wed, Jun 26, 2024 at 12:18:30PM -0700, Yang Shi wrote:
> > > @@ -568,6 +596,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
> > >  	if (!vma)
> > >  		goto lock_mmap;
> > > 
> > > +	if ((vm_flags & VM_READ) && (vma->vm_flags & VM_WRITE) &&
> > > +	    is_el0_atomic_instr(regs)) {
> > > +		vm_flags = VM_WRITE;
> > > +		mm_flags |= FAULT_FLAG_WRITE;
> > > +	}
> > 
> > The patch looks fine now and AFAICT there's no ABI change.
> > 
> > However, before deciding whether to merge this patch, I'd like to
> > understand why OpenJDK cannot use madvise(MADV_POPULATE_WRITE). This
> > would be the portable (Linux) solution that works better on
> > architectures without such atomic instructions (e.g. arm64 without LSE
> > atomics). So fixing user-space would be my preferred solution.
> 
> Doing so would be requesting application code changes that are linux and
> ARM64 specific from applications running on Linux.

Linux-specific (e.g. madvise()), I agree, but arm64-specific definitely
not. I'd argue that expecting the atomic_add(0) to only trigger a single
write fault is arch specific. You can't do this on arm32 or arm64
pre-LSE (I haven't checked other architectures).

IIUC, OpenJDK added this feature about two years ago but the arm64
behaviour hasn't changed in the meantime. So it's not like we broke the
ABI and forcing user space to update.

This patch does feel a bit like working around a non-optimal user choice
in kernel space. Who knows, madvise() may even be quicker if you do a
single call for a larger VA vs touching each page.

> A lot of these are proprietary.

Are you aware of other (proprietary) software relying on such pattern to
fault pages in as writeable?

-- 
Catalin

