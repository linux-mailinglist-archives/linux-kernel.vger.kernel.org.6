Return-Path: <linux-kernel+bounces-443524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 960649EF566
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1789B189E7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E23C231A2D;
	Thu, 12 Dec 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huV5/2n1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B93222D66;
	Thu, 12 Dec 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022316; cv=none; b=BR3gzYK8QHBQUyFKPkL61wzc1ehUam8ft7+LDa3UYwdg5FtN4E/wcxwCjOlwKxdMGX9ErED5R0+pW/5rL6FMETm8DgKPeZj4WHRYksEzWiWzOZ80VBoSh6RkMYNAhkVohpChWpFEl/DH/gLdFxTaP735OiuE6ielmYKbz+q43CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022316; c=relaxed/simple;
	bh=woLv4+bBa3B3N1pK5meg8QxoAoisLOlR0KcLNcIPoSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMnJS8d1S3fX14hMUBfPXSBuzOBfqMvZE/zvSrwCSNuS7ywFFFri5+i6XeWuxYwJDwC13PAGY5qCFwjL4yWIQIBh2/3cGCUpwbXWzfLFymQX72OpisXMNalToDAqz4mbjzr2d9iZ2OrJw+Y2/LSNfzMTY7vj5HDRGY9Q0G9g4TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huV5/2n1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6653C4CECE;
	Thu, 12 Dec 2024 16:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734022316;
	bh=woLv4+bBa3B3N1pK5meg8QxoAoisLOlR0KcLNcIPoSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huV5/2n1xrfwVgXexkLe+nnYsmZZAKGoF61GTT8T8BrsBIj5Jzgw0pNwxwd89+ivr
	 d6x4ybi/TFdwd4SzBnO0aoxHfu/ZJzKsKAAbVLSwB4ITtRxredF9T5/kxBv2XsrjB0
	 KdqzlOPkPYKf7RBB98XGMACnoJ2kBz481YmlgmugEyeoCgjmtusJEBwTjyj2qnFvdK
	 LLZjalCDCFvn8AtcYQRAAMQnl0R/b3y3ewHSnkZAmNzHgg+ztth9m+sXeCiBR0xzWW
	 4MeRVGu+JhxY2bGGEU0feqxokU9rHxv6y8L7LJLWLnnOjXANvcQsjM06/QhWu+wDr4
	 R8Zf9TKd5WvWg==
Date: Thu, 12 Dec 2024 10:51:54 -0600
From: Rob Herring <robh@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: platform: add Io support
Message-ID: <20241212165154.GA2473511-robh@kernel.org>
References: <20241211-topic-panthor-rs-platform_io_support-v3-1-08ba707e5e3b@collabora.com>
 <Z1nbsNyOBvFTL1-6@pollux.localdomain>
 <A3F6B6C6-33B3-4522-8240-15421F240D3A@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A3F6B6C6-33B3-4522-8240-15421F240D3A@collabora.com>

On Wed, Dec 11, 2024 at 06:00:31PM -0300, Daniel Almeida wrote:
> Hi Danilo,
> 
> > On 11 Dec 2024, at 15:36, Danilo Krummrich <dakr@kernel.org> wrote:
> > 
> > On Wed, Dec 11, 2024 at 02:51:56PM -0300, Daniel Almeida wrote:
> >> Add support for iomem regions by providing a struct IoMem abstraction
> >> for the platform bus. This will request a memory region and remap it
> >> into a kernel virtual address using ioremap(). The underlying reads and
> >> writes are performed by struct Io, which can be derived from the IoRaw
> >> embedded in platform::IoMem.
> >> 
> >> This is the equivalent of pci::Bar for the platform bus.
> >> 
> >> Memory-mapped I/O devices are common, and this patch offers a way to
> >> program them in Rust, usually by reading and writing to their
> >> memory-mapped register set.
> >> 
> >> Both sized and unsized versions are exposed. Sized allocations use
> >> `ioremap_resource_sized` and specify their size at compile time. Reading
> >> and writing to IoMem is infallible in this case and no extra runtime
> >> checks are performed. Unsized allocations have to check the offset
> >> against the regions's max length at runtime and so return Result.
> >> 
> >> Lastly, like pci::Bar, platform::IoMem uses the Devres abstraction to
> >> revoke access to the region if the device is unbound or the underlying
> >> resource goes out of scope.
> >> 
> >> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> >> ---
> >> The PCI/Platform abstractions are in-flight and can be found at:
> >> 
> >> https://lore.kernel.org/rust-for-linux/20241210224947.23804-1-dakr@kernel.org/
> >> ---
> >> Changes in v3:
> >> - Rebased on top of v5 for the PCI/Platform abstractions
> >> - platform_get_resource is now called only once when calling ioremap
> >> - Introduced a platform::Resource type, which is bound to the lifetime of the
> >>  platform Device 
> >> - Allow retrieving resources from the platform device either by index or
> >>  name
> >> - Make request_mem_region() optional
> >> - Use resource.name() in request_mem_region
> >> - Reword the example to remove an unaligned, out-of-bounds offset
> >> - Update the safety requirements of platform::IoMem
> >> 
> >> Changes in v2:
> >> - reworked the commit message
> >> - added missing request_mem_region call (Thanks Alice, Danilo)
> >> - IoMem::new() now takes the platform::Device, the resource number and
> >>  the name, instead of an address and a size (thanks, Danilo)
> >> - Added a new example for both sized and unsized versions of IoMem.
> >> - Compiled the examples using kunit.py (thanks for the tip, Alice!)
> >> - Removed instances of `foo as _`. All `as` casts now spell out the actual
> >>  type.
> >> - Now compiling with CLIPPY=1 (I realized I had forgotten, sorry)
> >> - Rebased on top of rust-next to check for any warnings given the new
> >>  unsafe lints.
> >> ---
> >> rust/bindings/bindings_helper.h |   1 +
> >> rust/helpers/io.c               |  17 ++++
> >> rust/kernel/platform.rs         | 209 +++++++++++++++++++++++++++++++++++++++-
> >> 3 files changed, 226 insertions(+), 1 deletion(-)

[...]

> >> +    unsafe fn new(resource: &Resource<'_>, exclusive: bool) -> Result<Self> {
> >> +        let size = resource.size();
> >> +        if size == 0 {
> >> +            return Err(ENOMEM);
> >> +        }
> >> +
> >> +        let res_start = resource.start();
> >> +
> >> +        // SAFETY:
> >> +        // - `res_start` and `size` are read from a presumably valid `struct resource`.
> >> +        // - `size` is known not to be zero at this point.
> >> +        // - `resource.name()` returns a valid C string.
> >> +        let mem_region =
> >> +            unsafe { bindings::request_mem_region(res_start, size, resource.name().as_char_ptr()) };
> > 
> > This should only be called if exclusive == true, right?
> 
> Yes (oops)
> 
> > 
> > Btw. what's the use-case for non-exclusive access? Shouldn't we rather support
> > partial exclusive mappings?
> 
> Rob pointed out that lots of drivers do not call `request_mem_region` in his review for v2, which
> Is why I added support for non-exclusive access.
> 
> What do you mean by `partial exclusive mappings` ?

I dug into the history of this some and I may be misremembering where 
the problem is exactly. The issue for DT is we can't call 
platform_device_add() because it calls insert_resource() and that may 
fail. Now I'm not sure if the drivers in overlapping case have to avoid 
calling request_mem_region(). I think so...

Here's some relevant commits:

8171d5f7bf26 Revert "of/platform: Use platform_device interface"
b6d2233f2916 of/platform: Use platform_device interface
02bbde7849e6 Revert "of: use platform_device_add"
aac73f34542b of: use platform_device_add

There was another attempt to address this here[1], but I don't think 
anything ever landed. 

Grant mentioned mpc5200 ethernet and mdio as one example overlapping. 
Indeed it does:

                ethernet@3000 {
                        compatible = "fsl,mpc5200-fec";
                        reg = <0x3000 0x400>;
                        local-mac-address = [ 00 00 00 00 00 00 ];
                        interrupts = <2 5 0>;
                        phy-handle = <&phy0>;
                };

                mdio@3000 {
                        #address-cells = <1>;
                        #size-cells = <0>;
                        compatible = "fsl,mpc5200-mdio";
                        reg = <0x3000 0x400>;   // fec range, since we need to setup fec interrupts
                        interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.

                        phy0: ethernet-phy@0 {
                                reg = <0>;
                        };
                };

The FEC driver does request_mem_region(), but the MDIO driver does not.

Rob

[1] https://lore.kernel.org/all/20150607140138.026C4C412C8@trevor.secretlab.ca/


