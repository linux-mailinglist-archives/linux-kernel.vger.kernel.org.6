Return-Path: <linux-kernel+bounces-191233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D438D0874
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91501C22CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2226F155C9B;
	Mon, 27 May 2024 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKnIPKTO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A22A17E8E3
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827064; cv=none; b=fuL9HRZz4kK3D1hAYiL8s4bVzl4wdc0YnlbZ4mqbVvv8gU1TFonwqet59h8I8Nb+I//FSoouleIX6AVnyqzNkk3oI8gMIfJ0LzfXhPjqGkCAqWQHfDsSwyuIv1vT4htF1luG46S0myTHiiIN9+UHpQXstH8FrGvWgtK833DzOcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827064; c=relaxed/simple;
	bh=PgMG8Nl4HW/frSEexzbSY5VEC+HJRgX+juJE9zXQsSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjDAfpk9lPaA91coPkOdxcrtxLqzU5/MRTi/ikGNYejc93Ivt873mbR0JKmDzo3FGbx9vLyBxz5Wyb401ZKVtd3l49TCAQBE5E969yqZrALwMgYXVLUmmqpu3ECDh/lSsAHFyreWHKyGEOFZwWQq3Gxpo1Z33j9YbfjqPN+WU50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKnIPKTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4EAC32789;
	Mon, 27 May 2024 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716827063;
	bh=PgMG8Nl4HW/frSEexzbSY5VEC+HJRgX+juJE9zXQsSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKnIPKTOd1Ifou5xt4csJYw733fCEaV6tSXDjNtxd1rExGVMOebjmIefiycpEkpyr
	 M4b5JV2jfbN/KY9dMchyigO5c9ks+h/oC34GnHTDrdNyd8cKRigRr5IJzaa/CBhSsx
	 krHZXoYvMB8kxz9UVkpvQIrvxe/+AX8feryEOPl5VcPyNyXuIVGHpHdiQ6msNtYk7L
	 vKm4WpPXJbWgwc1AigzcUzNFE7/AtJ0nU3WPGsLOvx8kjsd+g1tJw3YrBlDsieL65f
	 FZoTkNR6tozVwFk+9jWPBA7guzEtM5Xpdi4xiBpgViAyQnoxn42bRIjU3f5UMFcGM8
	 65r2KD1aRtb1g==
Date: Mon, 27 May 2024 19:22:36 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jaewon Kim <jaewon31.kim@samsung.com>
Cc: "vbabka@suse.cz" <vbabka@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
	"tkjos@google.com" <tkjos@google.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Pintu Agarwal <pintu.ping@gmail.com>
Subject: Re: (2) [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
Message-ID: <ZlSzTOSu06ziefUj@kernel.org>
References: <ZlM_Ndng_JstAee3@kernel.org>
 <Zk9UCsZdizqC1_36@kernel.org>
 <ZkxN0yQ7Fb0X26hT@kernel.org>
 <20240521023957.2587005-1-jaewon31.kim@samsung.com>
 <20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
 <20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
 <20240524090715epcms1p274939a1d5954be3423f6ce14a3df6f92@epcms1p2>
 <CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p2>
 <20240527013504epcms1p22bec7b83f2a42e76877b97ed0d769009@epcms1p2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527013504epcms1p22bec7b83f2a42e76877b97ed0d769009@epcms1p2>

On Mon, May 27, 2024 at 10:35:04AM +0900, Jaewon Kim wrote:
> >On Fri, May 24, 2024 at 06:07:15PM +0900, Jaewon Kim wrote:
> >> >On Tue, May 21, 2024 at 07:17:53PM +0900, Jaewon Kim wrote:
> >> >> >On Tue, May 21, 2024 at 11:53:29AM +0900, Jaewon Kim wrote:
> >> >> >> 
> >> >> >> This is actually RESEND as it was introduced 2 years ago.
> >> >> >> Please refer to https://lore.kernel.org/linux-mm/YkQB6Ah603yPR3qf@kernel.org/#t
> >> >> >> 
> >> >> >> > But you never provided details about *why* you want this information exposed.
> >> >> >> 
> >> >> >> For your question, I'd like to say ;
> >> >> >> We can see the same format and exact information between different version of kernel status.
> >> >> >> 
> >> >> >> 1) Internally we can check if the reserved memory changes.
> >> >> >> 2) Externally we can communicate between chipset vendors and OEM, with a same format.
> >> >> >
> >> >> >Why the existing debugfs interface is not sufficient?
> >> >> 
> >> >> debugfs/memblock/memory & debugfs/memblock/reserved have changed its
> >> >> format but still does not show name, reusable, kernel size.  If memory is
> >> >> reserved from memblock, and did not freed back to memblock. Memblock does
> >> >> not know even after the memory is freed to system.  I think a simple
> >> >> debug interface is needed to easily communicate with others or compare
> >> >> different SW releases.
> >> >
> >> >I still don't understand what problem are you trying to solve with these
> >> >patches. 
> >> 
> >> I think we need a common API to easily see the reserved memory status.
> >> Through MemTotal on /proc/meminfo, we can only see only the total size
> >> of reserved memory. We don't how big kernel init size within the the
> >> total size. I think this really helps to compare different kernel and
> >> communicate with others.
> >
> > As was already mentioned on this thread, something like
> >
> > $ dmesg | grep Memory:
> > [    0.000000] Memory: 8058204K/8388608K available (35392K kernel code, 8706K rwdata, 23320K rodata, 16832K init, 848K bss, 297636K reserved, 32768K cma-reserved)
> >
> > already shows init, rodata and bss sizes.
> >
> > And size -A vmlinux provides detailed breakdown of the kernel image into
> > sections.
> > 
> >> I think the debugfs API or early boot log shows quite much information
> >> for the reserved memory information defined in device tree. But it is
> >> difficult to see after boot, as the boot log already was removed ouf of
> >> the kernel log buffer.
> >
> > Kernel log is persisted, isn't it?
> 
> Early kernel log is removed after other log is written to the log buffer. I may
> not be able to get it, after waiting for the target device is ready to be
> connected from host PC. I wanted to keep that information.
> 
> Actually the commit aeb9267eb6b1 ("of: reserved-mem: print out reserved-mem
> details during boot") seems to show most of information if I can get the early
> boot log.

Unless the kernel log is stored on the target you need to redirect
target's console to a file on the host, then all of the boot log will be
accessible on the host.

Then with memblock=debug kernel parameter you'll be able to get much more
information about memblock reservations.
 
> If you don't mind, let me ask one question. How can we easily find the undefined
> DRAM memory regions in kernel persective. Do we have to look into the debugfs 
> memblock/memory and combine the information with the kernel log information?
> 
> case1) Actual DRAM is mapped as two regions like,
>    2GB @ 0x00000000_80000000 and 6GB @ 0x00000008_80000000,
>    how can we find the hole, 0x00000000_80000000--0x00000008_7FFFFFFF ?

The actual memory banks reported to Linux are shown at
debugfs/memblock/memory
 
> case2) If some region is already carved out at bootloader stage like.
>    0x00000000_81200000-0x00000000_812FFFFF was not initinally on memblock.
>    0x00000000_80000000-0x00000000_81200000 was removed as no-map through device tree.
>    how can we find the hole, 0x00000000_81200000-0x00000000_812FFFFF ?

nomap regions are shown in debugfs/memblock/memory as NOMAP.

-- 
Sincerely yours,
Mike.

