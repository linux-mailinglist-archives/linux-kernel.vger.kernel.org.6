Return-Path: <linux-kernel+bounces-276029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CC6948D78
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD8528447D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4611C231A;
	Tue,  6 Aug 2024 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiZEA9MP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBD5143C4B;
	Tue,  6 Aug 2024 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942696; cv=none; b=n1MUxiAihPhXri7pxUJf2BOrU/HGaITqCSgk7buJvGwx2mAnk7xlddOeHAw+opVcWfTbpOHhPxM0bpjXI5bHeFF2H1wQzubCGeJeLK2eE8x9zCWf74n/Be6CibKqk9ZEYcDNDYyJEM/XK5EBvyPXsrRLHnIIc1o9GYwRvoDPUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942696; c=relaxed/simple;
	bh=g6QvjT7m7l08FZPHFs+nghjmOmyJDJ0hhzLbYwWu8JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHUPukhULB2zYno4XhaDlfvi27wou0RHSKqjUqjUNxHVueRUy8+ORhKFa+Q0NPe9H+BhvwpkGqYG8xbFmtMUE5ZwA6pIl0mRJ7m/J4GRDCQUI2VwsdryUXjkKY6ossgNsP8Tlqac8QU7HEi35C6VRjH0bV7NJxtYrriTlLXD4kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiZEA9MP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B35DC32786;
	Tue,  6 Aug 2024 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722942696;
	bh=g6QvjT7m7l08FZPHFs+nghjmOmyJDJ0hhzLbYwWu8JE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oiZEA9MPStt9neWWoaDIK4RhPVZ/jsajiLvbS6fGbnb8620rkuQLTA+E6t4JhosJk
	 Aqoaxr9aLLUIk93NaYkveasob5Szf7CYkYyxbcR0ZY1FMz8zLhcBxGHtv0a12aJoE4
	 q7wXDp1NV1RluR0ynPiRIWjS8mNXY88kckMSssmnzY3STU0WY5VxJOpIhBM0XsBHQb
	 Al8jgaSu2QkIphXCcSdY9Y85J2WS8A1eJ1mrlZLAB3B45L7/Nlrh10RCI2e3McV5G7
	 1pJVAPAUSQLD52mz8Aoq2AMZVyZE8AswVRuiVrkGUg6VcAxPwn+rN6HCY9qIBkNLBm
	 So2LPl8579T0w==
Date: Tue, 6 Aug 2024 13:11:28 +0200
From: Alexey Gladkov <legion@kernel.org>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ytcoode@gmail.com" <ytcoode@gmail.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	"Yao, Yuan" <yuan.yao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"John.Starks@microsoft.com" <John.Starks@microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"Cui, Dexuan" <decui@microsoft.com>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>,
	"cho@microsoft.com" <cho@microsoft.com>
Subject: Re: [PATCH v2 2/5] x86/tdx: Add validation of userspace MMIO
 instructions
Message-ID: <ZrIE4FVBflJrJagX@example.org>
References: <cover.1722356794.git.legion@kernel.org>
 <cover.1722862355.git.legion@kernel.org>
 <6f989aea155817ef2f8a5fd2240ccff3f74d4edd.1722862355.git.legion@kernel.org>
 <83c9b05e7d359c0486a061f3bd31920ddb5c33a0.camel@intel.com>
 <rtqr63t6lyehdkj4ezobhgw5o7hyewoaqnhmxgxbfbrjxzyyo4@5v3thwohmzse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rtqr63t6lyehdkj4ezobhgw5o7hyewoaqnhmxgxbfbrjxzyyo4@5v3thwohmzse>

On Tue, Aug 06, 2024 at 10:18:20AM +0300, kirill.shutemov@linux.intel.com wrote:
> On Mon, Aug 05, 2024 at 10:40:55PM +0000, Edgecombe, Rick P wrote:
> > On Mon, 2024-08-05 at 15:29 +0200, Alexey Gladkov (Intel) wrote:
> > > +       vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
> > > +
> > > +       if (user_mode(regs)) {
> > > +               if (mmap_read_lock_killable(current->mm))
> > > +                       return -EINTR;
> > > +
> > > +               ret = valid_vaddr(ve, mmio, size, vaddr);
> > > +               if (ret)
> > > +                       goto unlock;
> > > +       }
> > > +
> > 
> > In the case of user MMIO, if the user instruction + MAX_INSN_SIZE straddles a
> > page, then the "fetch" in the kernel could trigger a #VE. In this case the  
> > kernel would handle this second #VE as a !user_mode() MMIO I guess.
> > 
> > Would something prevent the same munmap() checks needing to happen for that
> > second kernel #VE? If not, I wonder if the munmap() protection logic should also
> > trigger for any userspace range ve->gpa as well.
> 
> That's an interesting scenario, but I think we are fine.
> 
> The fetch is copy_from_user() which is "REP; MOVSB" on all TDX platforms.
> Kernel rejects MOVS instruction emulation for !user_mode() with -EFAULT.

But MOVS will be used only if X86_FEATURE_FSRM feature is present.
Otherwise rep_movs_alternative will be used, which uses MOVB.

I know that X86_FEATURE_FSRM appeared since Ice Lake, but still.

-- 
Rgrds, legion


