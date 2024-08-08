Return-Path: <linux-kernel+bounces-279809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9282C94C218
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CAF2847FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AFB18FC8C;
	Thu,  8 Aug 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck3hCyri"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7DD1DA21;
	Thu,  8 Aug 2024 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132582; cv=none; b=evWX3rEsL580RsHatTiZWgEPSZumx9wTj9xVQiUyaectp48+OBnJlHrCX4eCeM+SrOjHuawnjYJQ1lNKxzLQ6OwtuaLx9o2LiEiByQDgx5Abs7J+2+V3EE5FRAxKA/DNdTFoA3asV9eROQ6PpCq4OthYDpmiki55QZOrowMuShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132582; c=relaxed/simple;
	bh=beVVsgffCfJyWiXjiXsztwPSP76yXZ3mJyuoVKJJMEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KH9qVCrmKSg4qMfSRAERokbKGnlrgc6/ApBy5je+euGBWW3DheKyqb7P8Snz60K9w7Fiq6C0fr3tXDz7gUEcX9a9cyEj7qTD0yXHvVuMkuDu2b6XQWb9jALyS+dQeJ71cnHfv1lGCFYa/nBsd51AZYDa+9uFPGft2EbIzBKatG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck3hCyri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9656C32782;
	Thu,  8 Aug 2024 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723132582;
	bh=beVVsgffCfJyWiXjiXsztwPSP76yXZ3mJyuoVKJJMEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ck3hCyrioKh1f6Or/w/vQon4EwcshPzhI2vhoaxujRsaoU8LqK0wKj3ghTKgLHCqN
	 MnnpMUN3TEWQdaJ+GmlLiwLUegeFFuuD7zxeFkogY+WXEYBs2goDxUW+9Tvnohu4a2
	 52LCGnZdoVqTyjqbnoAxKVR2qf0x9uQdEJ13GEp23Zq3gw5ejC/AZeWsfNHIm+Kp15
	 UqTMDQk4lsUOZa6T3kSGnHktjDJ/X2086uGZZH6AerAEWqFMq0IgjDi7ZWa/mSULFx
	 T3tcap09Afs2SmVEg6DA+6x3CPzFfDdrEcZtAJZJaX6+LxWPkQlA/od0/NsshM/3g2
	 HNpSx/sjmJJWw==
Date: Thu, 8 Aug 2024 17:56:15 +0200
From: Alexey Gladkov <legion@kernel.org>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
Message-ID: <ZrTqn7Fd25sWxOuz@example.org>
References: <cover.1722356794.git.legion@kernel.org>
 <cover.1722862355.git.legion@kernel.org>
 <6f989aea155817ef2f8a5fd2240ccff3f74d4edd.1722862355.git.legion@kernel.org>
 <83c9b05e7d359c0486a061f3bd31920ddb5c33a0.camel@intel.com>
 <rtqr63t6lyehdkj4ezobhgw5o7hyewoaqnhmxgxbfbrjxzyyo4@5v3thwohmzse>
 <ZrIE4FVBflJrJagX@example.org>
 <DM8PR11MB575097797C8CA3779F11C303E7BF2@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR11MB575097797C8CA3779F11C303E7BF2@DM8PR11MB5750.namprd11.prod.outlook.com>

On Tue, Aug 06, 2024 at 11:41:57AM +0000, Reshetova, Elena wrote:
> > On Tue, Aug 06, 2024 at 10:18:20AM +0300, kirill.shutemov@linux.intel.com
> > wrote:
> > > On Mon, Aug 05, 2024 at 10:40:55PM +0000, Edgecombe, Rick P wrote:
> > > > On Mon, 2024-08-05 at 15:29 +0200, Alexey Gladkov (Intel) wrote:
> > > > > +       vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
> > > > > +
> > > > > +       if (user_mode(regs)) {
> > > > > +               if (mmap_read_lock_killable(current->mm))
> > > > > +                       return -EINTR;
> > > > > +
> > > > > +               ret = valid_vaddr(ve, mmio, size, vaddr);
> > > > > +               if (ret)
> > > > > +                       goto unlock;
> > > > > +       }
> > > > > +
> > > >
> > > > In the case of user MMIO, if the user instruction + MAX_INSN_SIZE
> > straddles a
> > > > page, then the "fetch" in the kernel could trigger a #VE. In this case the
> > > > kernel would handle this second #VE as a !user_mode() MMIO I guess.
> > > >
> > > > Would something prevent the same munmap() checks needing to happen
> > for that
> > > > second kernel #VE? If not, I wonder if the munmap() protection logic
> > should also
> > > > trigger for any userspace range ve->gpa as well.
> > >
> > > That's an interesting scenario, but I think we are fine.
> > >
> > > The fetch is copy_from_user() which is "REP; MOVSB" on all TDX platforms.
> > > Kernel rejects MOVS instruction emulation for !user_mode() with -EFAULT.
> > 
> > But MOVS will be used only if X86_FEATURE_FSRM feature is present.
> > Otherwise rep_movs_alternative will be used, which uses MOVB.
> > 
> > I know that X86_FEATURE_FSRM appeared since Ice Lake, but still.
> 
> This is how the X86_FEATURE_FSRM cpuid bit is treated under TDX:
> 
> {
>           "MSB": "4",
>           "LSB": "4",
>           "Field Size": "1",
>           "Field Name": "Fast Short REP MOV",
>           "Configuration Details": "TD_PARAMS.CPUID_CONFIG",
>           "Bit or Field Virtualization Type": "Configured & Native",
>           "Virtualization Details": null
>         },
> 
> Which means VMM has the way to overwrite the native platform value
> and set it to "0", so we must account for both cases. 

I have added a patch that does not allow access to userspace addresses if
we are in a kernel space context.

-- 
Rgrds, legion


