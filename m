Return-Path: <linux-kernel+bounces-515624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B22A366CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E2D7A498F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACEC193079;
	Fri, 14 Feb 2025 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Hzffh1ee"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D5819066D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564374; cv=none; b=keWLg/9QwahdSq8afKIg5bDRozW0m3zNO8fJIL3Ma7azBMQjyKNvJW+wq2LZcD+cg8t4URfI6/ICEL4T+09QR4rMaxKhIaHthfEyXPJuR7D4jt8m+0xH13zQD3UwbaFTI0E0AgHZPe9brUb0oEE9BgWhScnUf8Z5QnrU/7a9eqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564374; c=relaxed/simple;
	bh=CtNM/RVMZqKpZrHwL+U6jZelnKrkdf6d3UdZtJeqU5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MFyVvqqZhbkwm7JLVTPVNR93B+okWJM46i78iqL/yZ4eCpfGUekWQ9i2iiPsLpcYYf3sR9R3WsbIowpBaX1rKmFZR1bM4s0tbwmLDEDSLKkuVlVPjI0+dDkQrUa2VH1C9pl2M+6obBWGRMlMwfmmM58AGhuaKgEsJ2a3q6Z6sAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Hzffh1ee; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 6B34C240029
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 21:19:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739564370; bh=CtNM/RVMZqKpZrHwL+U6jZelnKrkdf6d3UdZtJeqU5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=Hzffh1eeRVsBC5BEEkcbABraLoDHCbk6Sj7oEjvox2EKPBeJbpcpZnHgyMvhIatBw
	 0ZnwAn3CQcEoz8DV6h/KuQZViD0QB4Zu952aOQfxBXk0LkQq8fmASrgSxYqTgDjJgy
	 aHZt+9gOSzIZlKT1phtB7CXRPg4zWKI/bClAArm4xFMwgaTKel0HaZx3pnrfELYN4Z
	 Klg0QeR6k8hb7UlWDcri9yd2Jf1Tdx3fqUlwWMp4Y2UHT70bxFK9nO4lbbwsAs1tnh
	 GkJh7QzmGt+ZszhdYkni5/x5kqBrD9yjFxlsFCkLdTMjNaClsjMgJve0oXVzZowBKk
	 upHLJh2ny0+8g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Yvk0r5GLrz9rxB;
	Fri, 14 Feb 2025 21:19:24 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org,  alex.gaynor@gmail.com,  aliceryhl@google.com,
  apw@canonical.com,  arnd@arndb.de,  aswinunni01@gmail.com,
  axboe@kernel.dk,  benno.lossin@proton.me,  bhelgaas@google.com,
  bjorn3_gh@protonmail.com,  boqun.feng@gmail.com,  dakr@kernel.org,
  dwaipayanray1@gmail.com,  ethan.twardy@gmail.com,
  fujita.tomonori@gmail.com,  gary@garyguo.net,
  gregkh@linuxfoundation.org,  joe@perches.com,  lukas.bulwahn@gmail.com,
  ojeda@kernel.org,  pbonzini@redhat.com,  tmgross@umich.edu,
  walmeida@microsoft.com,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH V2 1/2] rust: module: change author to be a array
In-Reply-To: <20250214184550.120775-2-trintaeoitogc@gmail.com>
References: <20250214184550.120775-1-trintaeoitogc@gmail.com>
	<20250214184550.120775-2-trintaeoitogc@gmail.com>
Date: Fri, 14 Feb 2025 20:19:23 +0000
Message-ID: <m2y0y8b7p0.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Guilherme Giacomo Simoes <trintaeoitogc@gmail.com> writes:

> In the module! macro, the author field has a string type. Once that the
> modules can has more than one author, this is impossible in the current
> scenary.
> Change the author field for accept a array string type and enable module
> creations with more than one author.
> In modules that use the author field, change its value to a string
> array.
>
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/244
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>  drivers/block/rnull.rs           | 2 +-
>  rust/kernel/net/phy.rs           | 4 ++--
>  rust/kernel/pci.rs               | 2 +-
>  rust/macros/lib.rs               | 4 ++--
>  rust/macros/module.rs            | 8 +++++---
>  samples/rust/rust_driver_pci.rs  | 2 +-
>  samples/rust/rust_minimal.rs     | 2 +-
>  samples/rust/rust_misc_device.rs | 2 +-
>  samples/rust/rust_print_main.rs  | 2 +-
>  9 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
> index ddf3629d8894..cb133993f27f 100644
> --- a/drivers/block/rnull.rs
> +++ b/drivers/block/rnull.rs
> @@ -27,7 +27,7 @@
>  module! {
>      type: NullBlkModule,
>      name: "rnull_mod",
> -    author: "Andreas Hindborg",
> +    author: ["Andreas Hindborg"],
>      description: "Rust implementation of the C null block driver",
>      license: "GPL v2",
>  }
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index bb654a28dab3..b179ac3a8d00 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -790,7 +790,7 @@ const fn as_int(&self) -> u32 {
>  ///         DeviceId::new_with_driver::<PhySample>()
>  ///     ],
>  ///     name: "rust_sample_phy",
> -///     author: "Rust for Linux Contributors",
> +///     author: ["Rust for Linux Contributors"],
>  ///     description: "Rust sample PHYs driver",
>  ///     license: "GPL",
>  /// }
> @@ -819,7 +819,7 @@ const fn as_int(&self) -> u32 {
>  /// module! {
>  ///     type: Module,
>  ///     name: "rust_sample_phy",
> -///     author: "Rust for Linux Contributors",
> +///     author: ["Rust for Linux Contributors"],
>  ///     description: "Rust sample PHYs driver",
>  ///     license: "GPL",
>  /// }
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 4c98b5b9aa1e..1218eaa7be02 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -103,7 +103,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
>  /// kernel::module_pci_driver! {
>  ///     type: MyDriver,
>  ///     name: "Module name",
> -///     author: "Author name",
> +///     author: ["Author name"],
>  ///     description: "Description",
>  ///     license: "GPL v2",
>  /// }
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index d61bc6a56425..8d74e18caf96 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -36,7 +36,7 @@
>  /// module!{
>  ///     type: MyModule,
>  ///     name: "my_kernel_module",
> -///     author: "Rust for Linux Contributors",
> +///     author: ["Rust for Linux Contributors"],
>  ///     description: "My very own kernel module!",
>  ///     license: "GPL",
>  ///     alias: ["alternate_module_name"],
> @@ -69,7 +69,7 @@
>  /// module!{
>  ///     type: MyDeviceDriverModule,
>  ///     name: "my_device_driver_module",
> -///     author: "Rust for Linux Contributors",
> +///     author: ["Rust for Linux Contributors"],
>  ///     description: "My device driver requires firmware",
>  ///     license: "GPL",
>  ///     firmware: ["my_device_firmware1.bin", "my_device_firmware2.bin"],
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index cdf94f4982df..09265d18b44d 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -94,7 +94,7 @@ struct ModuleInfo {
>      type_: String,
>      license: String,
>      name: String,
> -    author: Option<String>,
> +    author: Option<Vec<String>>,
>      description: Option<String>,
>      alias: Option<Vec<String>>,
>      firmware: Option<Vec<String>>,
> @@ -135,7 +135,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
>              match key.as_str() {
>                  "type" => info.type_ = expect_ident(it),
>                  "name" => info.name = expect_string_ascii(it),
> -                "author" => info.author = Some(expect_string(it)),
> +                "author" => info.author = Some(expect_string_array(it)),
>                  "description" => info.description = Some(expect_string(it)),
>                  "license" => info.license = expect_string_ascii(it),
>                  "alias" => info.alias = Some(expect_string_array(it)),
> @@ -184,7 +184,9 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
>  
>      let mut modinfo = ModInfoBuilder::new(info.name.as_ref());
>      if let Some(author) = info.author {
> -        modinfo.emit("author", &author);
> +        for author in author {
> +            modinfo.emit("author", &author);
> +        }

I wonder if we should make this "for author in authors", for code
clarity concerns.

>      }
>      if let Some(description) = info.description {
>          modinfo.emit("description", &description);
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
> index 1fb6e44f3395..5784677c797b 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -104,7 +104,7 @@ fn drop(&mut self) {
>  kernel::module_pci_driver! {
>      type: SampleDriver,
>      name: "rust_driver_pci",
> -    author: "Danilo Krummrich",
> +    author: ["Danilo Krummrich"],
>      description: "Rust PCI driver",
>      license: "GPL v2",
>  }
> diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
> index 4aaf117bf8e3..74279c3bd039 100644
> --- a/samples/rust/rust_minimal.rs
> +++ b/samples/rust/rust_minimal.rs
> @@ -7,7 +7,7 @@
>  module! {
>      type: RustMinimal,
>      name: "rust_minimal",
> -    author: "Rust for Linux Contributors",
> +    author: ["Rust for Linux Contributors"],
>      description: "Rust minimal sample",
>      license: "GPL",
>  }
> diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
> index 40ad7266c225..e840c12005cc 100644
> --- a/samples/rust/rust_misc_device.rs
> +++ b/samples/rust/rust_misc_device.rs
> @@ -116,7 +116,7 @@
>  module! {
>      type: RustMiscDeviceModule,
>      name: "rust_misc_device",
> -    author: "Lee Jones",
> +    author: ["Lee Jones"],
>      description: "Rust misc device sample",
>      license: "GPL",
>  }
> diff --git a/samples/rust/rust_print_main.rs b/samples/rust/rust_print_main.rs
> index 7e8af5f176a3..f6d51b0884fb 100644
> --- a/samples/rust/rust_print_main.rs
> +++ b/samples/rust/rust_print_main.rs
> @@ -8,7 +8,7 @@
>  module! {
>      type: RustPrint,
>      name: "rust_print",
> -    author: "Rust for Linux Contributors",
> +    author: ["Rust for Linux Contributors"],
>      description: "Rust printing macros sample",
>      license: "GPL",
>  }

It could be that you developed this with an old tree history. You missed
changing the author for the samples/rust/rust_driver_platform.rs sample.

