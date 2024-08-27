Return-Path: <linux-kernel+bounces-303666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88AC96135A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 448D6B22D36
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F681D048F;
	Tue, 27 Aug 2024 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJFXeS42"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7381A1CFEC6;
	Tue, 27 Aug 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773921; cv=none; b=iPpwHriRFMoPCAUQUhAKWJu7y+66zc3crnLxoqGIuU4VSRW3Fc7Zfzt+KvdQ7TzyYsCk7F/1wsDwc7NzZDT5KUYyJix/d7fQxcEt6gGrERaHNLbKtNb3r020vBiEaCQJ41i+YMvn29dcK5zs77xx4lBr3Pcqjd8RZf4HqvhIaSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773921; c=relaxed/simple;
	bh=nkxZmjJsQD+WMFNTPKl18ceTuqzu825y5NWLg20zRY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fC/mGZHDo3ekaVF7c2kxIiVJA9SCGPilYJgyReimDPd9KPNPe/ziac1kykIknIFhDj2eekzAqlj5pfooltvElmANBc2zWcZxUQnuLKhnxwyp5jcWNZWBKqbYRb3jNhaQ6F482imiA5VCpFNKIr2q65EIjM4H1EarRCTmh7ogc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJFXeS42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9583C58106;
	Tue, 27 Aug 2024 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724773921;
	bh=nkxZmjJsQD+WMFNTPKl18ceTuqzu825y5NWLg20zRY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJFXeS42JQvsvgV8UWsTvI+dwLXioBc6g2SXLHPRsvJQ0Uy8fY/y6CmpY8G3T3npC
	 1+r8Hod9g/If6UCs6ykeab8xFfuhQMYnMQRWpwon27//KLRj0xW66hrDLDIL7EZP9b
	 0GdRVIRW8vzazsj6n5Nn+fxDdVH8//Rk7FPAosWipBJ3lUHD83KtM/LDP2oLo75ugM
	 FxU0eGMSQH0abLY/g6cNTD7qGS0wMmpSMTXKxE9hKQ4PLMu2OZqh37Ot34LjMAOpEy
	 pp7VRZnPRT+wylabBzGnOwahF6fkB63hbG2mwqmnIR/ePewcwlHjbmLGLHbTa65iHt
	 n1vqQ/ODA+9YA==
Date: Tue, 27 Aug 2024 10:51:58 -0500
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] of: move empty_root and unittest data DTBs to
 .init.rodata section
Message-ID: <20240827155158.GA3940418-robh@kernel.org>
References: <20240826124802.1552738-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826124802.1552738-1-masahiroy@kernel.org>

On Mon, Aug 26, 2024 at 09:48:01PM +0900, Masahiro Yamada wrote:
> Some architectures can embed DTB(s) in vmlinux. Most of them expect a
> single DTB in the .dtb.init.rodata section.
> 
> For example, RISC-V previously allowed embedding multiple DTBs in
> vmlinux, but only the first DTB in the .dtb.init.rodata section was
> used. Which DTB was used was unpredictable, as it depended on the link
> order (i.e., the order in Makefile).
> 
> Commit 2672031b20f6 ("riscv: dts: Move BUILTIN_DTB_SOURCE to common
> Kconfig") changed the Makefiles to ensure only one DTB is embedded.
> 
> However, commit 7b937cc243e5 ("of: Create of_root if no dtb provided by
> firmware") introduced another DTB into the .dtb.init.rodata section.
> 
> Since then, the symbol dump (sorted by address) for ARCH=riscv
> nommu_k210_defconfig is as follows:
> 
>     00000000801290e0 D __dtb_k210_generic_begin
>     00000000801290e0 D __dtb_start
>     000000008012b571 D __dtb_k210_generic_end
>     000000008012b580 D __dtb_empty_root_begin
>     000000008012b5c8 D __dtb_empty_root_end
>     000000008012b5e0 D __dtb_end
> 
> The .dtb.init.rodata section now contains the following two DTB files:
> 
>     arch/riscv/boot/dts/canaan/k210_generic.dtb
>     drivers/of/empty_root.dtb
> 
> This is not an immediate problem because the boot code picks up the
> first DTB. The second one, empty_root.dtb is just ignored.
> 
> However, as mentioned above, it is fragile to rely on the link order,
> as future Makefile changes may break the behavior.
> 
> The cmd_wrap_S_dtb rule in scripts/Makefile.lib is used for embedding a
> DTB into the .dtb.init.rodata, so that the arch boot code can find it by
> the __dtb_start symbol.
> 
> empty_root.dtb is looked up by its own symbol, so it does not need to
> be located in the .dtb.init.rodata. It can be moved to the .init.rodata
> section.
> 
> When CONFIG_OF_UNITTEST is enabled, more unittest DTBOs are embedded in
> the .dtb.init.rodata section. These are also looked up by name and for
> generic purposes, so they can be moved to the .init.rodata section as
> well.
> 
> I added a wrapper source file, drivers/of/empty_root_dtb.S, because this
> is the only wrapper used in driver/of/Makefile. I moved the rule for
> generating *.dtbo.S to drivers/of/unittest-data/Makefile because it is
> not used anywhere else.

That is likely to change. We've had fixup overlays (fixup an old dt 
to a new binding) added into the kernel from time to time. There were 2, 
but they've been removed. However, I just recently suggested adding some 
new ones[1].

It seems we need a named section when we access the dtb by variable 
name and an unnamed or boot dt section for the one boot dtb.

Rob

[1] https://lore.kernel.org/all/20240812212139.GA1797954-robh@kernel.org/


