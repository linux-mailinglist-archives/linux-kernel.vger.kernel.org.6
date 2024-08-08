Return-Path: <linux-kernel+bounces-279804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F8E94C20B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEDD280C62
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C0B19004F;
	Thu,  8 Aug 2024 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpD3PSsF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571CF18FDD0;
	Thu,  8 Aug 2024 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132447; cv=none; b=agcBU5NWyyBB28tihdaeFjDLaVdgrLSIX5eSJCkRzU7PO71CQPwHAZyb9y1DYA36caXcnxYqe2f8c5wB0eel40bBuGW6pB7wmkaMOqzPdotF6+lpxWL1+UkYJcWvxRfo1N6O0bbiV1LYTJx5+Y0Q6t6o+1Lh3kKjyDIv8TLOYMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132447; c=relaxed/simple;
	bh=7QVMA4gZW04TulQ8RvcdZrL4LP1a4XGmaliSJwlefcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEgad0zwENg5gkDtCrkyavsrRxd6LHa0W/6uuMn4/7cXdLRQHQJuCxtG1C1m5VJeNLJgRaqEh9Oi/IWxjEUWzVExy1Nmboe3IYekSxrYx101HHOQd+ELY8AtDapNuK/5tVIQEyzQr14F376cMkE6spYnjxSxErth1ogvfpYi/SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpD3PSsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140DEC32782;
	Thu,  8 Aug 2024 15:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723132446;
	bh=7QVMA4gZW04TulQ8RvcdZrL4LP1a4XGmaliSJwlefcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpD3PSsFNm5q0PF96AAwKQJZPp0qrXD9DM462UnRSTU8QpLLnGmDZsj2iSkHv+Ftt
	 E7agi8T85hlQPAQTSfw9IWPMiwq5Wt80v6Usbkj1ASkTfHdN32UtyQJvEbzI31BLda
	 FMvjOczqVCgm+x6IpDsNj1ODlKZcv6Hzr8Z+pd3xsYHdaz3oWUMjFpCTn8UBiT2B8l
	 xP/mr7svITTyNgdwkAdCK6IhIyNmaqxnPMIDJo5lyQxTZ9PQNMAP9cHKcLZR8GNVKP
	 SgkIEWey47+rOR8O6iy8yF/hCdLSTspVoG8etZ6zqDHd+ygE2l+FbozpuTg/BWNFWD
	 V+Z0sGZuWN13g==
Date: Thu, 8 Aug 2024 17:53:59 +0200
From: Alexey Gladkov <legion@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ytcoode@gmail.com" <ytcoode@gmail.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	"Yao, Yuan" <yuan.yao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"John.Starks@microsoft.com" <John.Starks@microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
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
Message-ID: <ZrTqF2CvkpcIkpPc@example.org>
References: <cover.1722356794.git.legion@kernel.org>
 <cover.1722862355.git.legion@kernel.org>
 <6f989aea155817ef2f8a5fd2240ccff3f74d4edd.1722862355.git.legion@kernel.org>
 <83c9b05e7d359c0486a061f3bd31920ddb5c33a0.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83c9b05e7d359c0486a061f3bd31920ddb5c33a0.camel@intel.com>

On Mon, Aug 05, 2024 at 10:40:55PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2024-08-05 at 15:29 +0200, Alexey Gladkov (Intel) wrote:
> > +       vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
> > +
> > +       if (user_mode(regs)) {
> > +               if (mmap_read_lock_killable(current->mm))
> > +                       return -EINTR;
> > +
> > +               ret = valid_vaddr(ve, mmio, size, vaddr);
> > +               if (ret)
> > +                       goto unlock;
> > +       }
> > +
> 
> In the case of user MMIO, if the user instruction + MAX_INSN_SIZE straddles a
> page, then the "fetch" in the kernel could trigger a #VE. In this case the  
> kernel would handle this second #VE as a !user_mode() MMIO I guess.
> 
> Would something prevent the same munmap() checks needing to happen for that
> second kernel #VE? If not, I wonder if the munmap() protection logic should also
> trigger for any userspace range ve->gpa as well.

I've added two more patches that should fix the problem. We can try to
avoid crossing the page boundary by first reading the data to the end of
the page and trying to parse it and only if that fails read MAX_INSN_SIZE.

I fixed this locally for tdx because it is required to read and parse the
buffer at the same time.

It's generally worth fixing elsewhere as well. But this I propose to do by
a separate patchset.

-- 
Rgrds, legion


