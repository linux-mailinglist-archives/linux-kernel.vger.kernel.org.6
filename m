Return-Path: <linux-kernel+bounces-307467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B60E964DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB897B214B7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5CD1B86FA;
	Thu, 29 Aug 2024 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKxi7XH/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAA4148FF0;
	Thu, 29 Aug 2024 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956864; cv=none; b=pEQYY5tyTdgdB+uV3yL6mBs2ZoAiZ2TBAADb7bMUlCu6Ja0BxnIB+y8tAPJgAToi/nscIfgCD5+dHGv8JLkQV2XFBEoNNVurFmHQJB+ANfuyYb/AoXo5p/BJYlDVJxKOrhjfVLpSty4ZGTEy88P0oJt2SnP0BpBOXVic3S0IchI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956864; c=relaxed/simple;
	bh=FLcFkLH3+Lv6+PmzGb4e9u+eCIxjMRaOgAkP2qTMK/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQAhUS00A+ZYyD7VmXOt1iEH0AjbKkFPHlIx/N1Wz5K90VjHflJK1yE3yFtSBNIH6M0ByURzuMzSU7CaXqmB+Bace4HOiV9iEiFmM2LWUGj/f2WZYS7kg4eoFWu/Pz40gcWjjEMUJuUoBtgJpVhtzCFya/EoVvyjBBl8V1CLRPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKxi7XH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F16C4CEC2;
	Thu, 29 Aug 2024 18:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724956863;
	bh=FLcFkLH3+Lv6+PmzGb4e9u+eCIxjMRaOgAkP2qTMK/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKxi7XH/rml0la9geg3Di8jmTtNqxF3mKzrtGlcSK7a5fum2yv+e3itS+FZjXAO/W
	 kpFldxTzKcJR+W+ry0hYPhv3Lhq4yGfqhPmLAsVEaX306B3RgsiM9EpOoxKqm5gpIg
	 8T04UZeQLcC9icGRY7JbSQrPuJa5YtmT4saxPhUYBuVmy5a6/yNHFP6uv7XagPdtoC
	 tbCkmauap143goVLGvm+5yBxubEKiFGgqQl+0o11fljZxv0JUnYlznM2+zkE0v9VRi
	 SDk1pa26ZVp4I/TUWt1Er5FfPAMzv1yXkhfv6uNwZrJCqwIiXrm0fcxTAbYe5xtS8o
	 6s25lRAvkgv+w==
Date: Thu, 29 Aug 2024 20:40:56 +0200
From: Alexey Gladkov <legion@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	cho@microsoft.com, decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v5 6/6] x86/tdx: Implement MOVS for MMIO
Message-ID: <ZtDAuDAyGevAhSj-@example.org>
References: <cover.1724248680.git.legion@kernel.org>
 <cover.1724837158.git.legion@kernel.org>
 <86af46ade7688c9f4216da51573b6f74b7c53143.1724837158.git.legion@kernel.org>
 <6n6tn2t4tabiclau7cpav6b7kisuotqwg246wp5lxgfngoyyl2@674snretgst5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6n6tn2t4tabiclau7cpav6b7kisuotqwg246wp5lxgfngoyyl2@674snretgst5>

On Thu, Aug 29, 2024 at 03:44:55PM +0300, Kirill A. Shutemov wrote:
> On Wed, Aug 28, 2024 at 12:44:36PM +0200, Alexey Gladkov wrote:
> > From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> > 
> > Add emulation of the MOVS instruction on MMIO regions. MOVS emulation
> > consists of dividing it into a series of read and write operations,
> > which in turn will be validated separately.
> > 
> > This implementation is based on the same principle as in SEV. It splits
> > MOVS into separate read and write operations, which in turn can cause
> > nested #VEs depending on which of the arguments caused the first #VE.
> > 
> > The difference with the SEV implementation is the execution context. SEV
> > code is executed in atomic context. Exception handler in TDX is executed
> > with interrupts enabled. That's why the approach to locking is
> > different. In TDX, mmap_lock is taken to verify and emulate the
> > instruction.
> > 
> > Another difference is how the read and write instructions are executed
> > for MOVS emulation. While in SEV each read/write operation returns to
> > user space, in TDX these operations are performed from the kernel
> > context.
> 
> It looks like SEV only returns to userspace to retry the instruction after
> stepping on failed __get_user()/__put_user(), unrolling back to
> vc_raw_handle_exception() and handling page fault there.

In vc_handle_mmio_movs() if regs->cx is not zero we return ES_RETRY. The
vc_handle_mmio(), vc_handle_exitcode() return it as is. In
vc_raw_handle_exception() if vc_handle_exitcode() returns ES_RETRY then we
just return true. So, the ES_RETRY is not further visible.

Or am I missing something?

> 
> But I'm not sure what happens with #VC inside vc_read_mem() and
> vc_write_mem(). Can the #VC exception be nested? Tom?
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 

-- 
Rgrds, legion


