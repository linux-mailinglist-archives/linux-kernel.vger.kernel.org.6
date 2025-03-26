Return-Path: <linux-kernel+bounces-576899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C141A715C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F34172474
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320D61DDC0B;
	Wed, 26 Mar 2025 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO+wudTy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE11DC9AC;
	Wed, 26 Mar 2025 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988539; cv=none; b=HwkRay/yf2ybTAX6w2Ie/7TqFbm4QATWzTar+NT00cOXqjnIZ2cRV08empkau/VGRq4qBAhpDm7/18I8qE4fHl6tF4MRYojB1cB7PTA3re3qQogI/LHwxOdUjz90wh32ilUpMiPZYB1Iv2ZdhE18X8s2SJFP0/f0Exx6zoRGi2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988539; c=relaxed/simple;
	bh=4Sh1ikImfk7eyob7pJYLP87Gp+VBMFoDyKt80LgWr+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plw8L5OCv0Ar3yYMz0KWPNTZyjlhZmOJPAX2K1F/n51rb5Yei4QX/xbXN5u5B/Hqiq5i7sHIJCw8LQL8KzWZNK/GrLmr96LvvlebILrsD0SpFT+u0PY2IoC02NyjlbzheuoewPYEsislaaRG0QgtQo/YfaclX4Xd021E2Ac7JuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO+wudTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D4CC4CEEA;
	Wed, 26 Mar 2025 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742988538;
	bh=4Sh1ikImfk7eyob7pJYLP87Gp+VBMFoDyKt80LgWr+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dO+wudTy752jbZBiKbEzH/y7kZltbC12thCjkIvnZenkEwF5D2goiKObY33+DZByK
	 62goXNL37ZMBjPsOFTzt1itoLJjbfI4q2kHo+gcavcD8Ed+ocOY+Elo0yUuq/RzkD4
	 FOqbHWsKAMpikkVh2I3TcWSLtiluyof3uUc5RxuLdFK2gbkm+vCt964jw4Ou0EI2Iy
	 SJHfXybHBPCt7535DKZ9pCxr1axSlbqbsF7nsodCCYZDBGsbw1rDAozoM+sEo3H3k5
	 40tkPnOq6VoCDvDqRAzPP/4s0qs6uIS8Ba3o5wFBmsURz9VrW0qQnuUQ5iLdNYoEuu
	 YHaiM9Fkt9Z/A==
Date: Wed, 26 Mar 2025 07:28:52 -0400
From: Mike Rapoport <rppt@kernel.org>
To: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	linux-kernel@vger.kernel.org, graf@amazon.com,
	akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
	robh@kernel.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org,
	tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
Message-ID: <Z-Pk9Bnr0lDVopKj@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com>
 <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
 <Z+JT7kx+sfPqfWFA@MiWiFi-R3L-srv>
 <CALu+AoQj+mHECTvbuK8CpUTmOYgx6n2oMFm5kQXtSigL+5Ks2w@mail.gmail.com>
 <CALu+AoRdfjNcjweq_ipxCC6UGBzM-a5ma417RBr-C3EQ=Em9OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoRdfjNcjweq_ipxCC6UGBzM-a5ma417RBr-C3EQ=Em9OQ@mail.gmail.com>

Hi Dave,

On Wed, Mar 26, 2025 at 05:17:16PM +0800, Dave Young wrote:
> On Tue, 25 Mar 2025 at 16:36, Dave Young <dyoung@redhat.com> wrote:
> >
> > > >
> > > > Have you tested kdump?  In my mind there are two issues,  one is with
> > > > CMA enabled, it could cause kdump crashkernel memory reservation
> > > > failures more often due to the fragmented low memory.  Secondly,  in
> > >
> > > kho scracth memorys are reserved much later than crashkernel, we may not
> > > need to worry about it.
> > > ====================
> > > start_kernel()
> > >   ......
> > >   -->setup_arch(&command_line);
> > >      -->arch_reserve_crashkernel();
> > >   ......
> > >   -->mm_core_init();
> > >      -->kho_memory_init();
> > >
> > > > kdump kernel dump the crazy scratch memory in vmcore is not very
> > > > meaningful.  Otherwise I suspect this is not tested under kdump.  If
> > > > so please disable this option for kdump.
> >
> > Ok,  it is fine if this is the case, thanks Baoquan for clearing this worry.
> >
> > But the other concerns are still need to address, eg. KHO use cases
> > are not good for kdump.
> > There could be more to think about.
> > eg. the issues talked in thread:
> > https://lore.kernel.org/lkml/Z7dc9Cd8KX3b_brB@dwarf.suse.cz/T/
> 
> Rethink about this,  other than previous concerns.  Transferring the
> old kernel state to kdump kernel makes no sense since the old state is
> not stable as the kernel has crashed.
 
KHO won't be active for kdump case. The KHO segments are only added to
kexec_image and never to kexec_crash_image. 

-- 
Sincerely yours,
Mike.

