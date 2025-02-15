Return-Path: <linux-kernel+bounces-515957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 849FCA36B29
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BBD6188D7AE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579645103F;
	Sat, 15 Feb 2025 01:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="B49MKmbV"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9731FE56C
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739583576; cv=none; b=ru/YNmv6pW8NAuTJGWHd85KJbJHpoZgnzMNISdl1nsyJg9ZYhUhZ0GbA4p2DBOTUc7UB7sbkZhfv5N+A1WlVmelvWrf1NdSc7aTC0RpvR6B8jmPTKgSJWT1GjzkxewuWeBALxTHurv0XRX3vI4sqi/Hlltczm1ABnK/vCf+8yEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739583576; c=relaxed/simple;
	bh=bsX85CP7pzM0SjdvrvK6LSPQnIzQhM+OefTQsyAnXzo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/mX9q5q16wgu6KB0S5633MxXpYQeXi5C4cXaWUSotuuP6pGaBBRq0byRLOV7iS8M4tZmQ7rtm0PVrGJFIlJd2xBFKE/e5IHMyZDZoVSuLxB0tdVMsuGEm9tSNrlhVsMqoGb9Kj0oAs8pfcrHyV16ikh/0bmuWWV2kQBm42IoKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=B49MKmbV; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=nb3yjjgtwzcs3kslqmelwsnaoy.protonmail; t=1739583566; x=1739842766;
	bh=s/r6aRv9p6Uq44FUePVy+nAMfK+OelCF9axDvkmd5Jc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=B49MKmbVFN0l7StcAtVkqON8zzDAkZwVpP7upmKvXaVj5aCEmyLhNqRDYk4Ms/R9U
	 2z4k1bzTBLvHTJotfLDg2yF7erSPGKCMBnKacGNnYhJbtrzio4U8+AYE3T44BBmLsK
	 kLj8cR4mr3qdZj2B6e0zrRBVYQOtPO/0an2x7/DjMUaMaj+ekoX4DXvWLwofdt5lQm
	 pYjU/YKyXiZc4fekl+PGY7FNrTiiEBb8HNH8oqkx+S+cmsq73tqmn6qgJhOxA15Oft
	 Z31QT8vbYxwU79B2pUgHgry5EOSGxLIcu5b3FO0ck8+08Ge3VP3xNFzJUHm9yg9UHI
	 8Nn3Iol2nhLgA==
Date: Sat, 15 Feb 2025 01:39:17 +0000
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>, a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk, bhelgaas@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, dwaipayanray1@gmail.com, ethan.twardy@gmail.com, fujita.tomonori@gmail.com, gary@garyguo.net, gregkh@linuxfoundation.org, joe@perches.com, lukas.bulwahn@gmail.com, ojeda@kernel.org, pbonzini@redhat.com, tmgross@umich.edu, walmeida@microsoft.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH V2 1/2] rust: module: change author to be a array
Message-ID: <93eaeb37-9913-49cb-be6d-367696a81baf@proton.me>
In-Reply-To: <20250214184550.120775-2-trintaeoitogc@gmail.com>
References: <20250214184550.120775-1-trintaeoitogc@gmail.com> <20250214184550.120775-2-trintaeoitogc@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1c5caca312692a065895a85578fd508e033bbad0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.02.25 19:45, Guilherme Giacomo Simoes wrote:
> In the module! macro, the author field has a string type. Once that the
> modules can has more than one author, this is impossible in the current
> scenary.
> Change the author field for accept a array string type and enable module
> creations with more than one author.
> In modules that use the author field, change its value to a string
> array.

This commit message looks a bit clunky to me, though I am not a native
speaker. My suggestion would be:

    Change the type of the `author` field in the `module!` macro from strin=
g
    to string array. This allows multiple authors for a single module as is
    already possible in C.
    Additionally, rename the field to `authors` to better reflect this
    change.

Feel free to change/adapt anything.

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
>=20
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

As already mentioned above, I think it makes sense to also rename the
field to `authors`.

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
> @@ -103,7 +103,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pc=
i_dev) {
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

You should also change the documentation in this file, there the field
`author` is listed as "string literal of the author of the kernel
module.", so it also needs to be updated.

---
Cheers,
Benno

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
>  ///     firmware: ["my_device_firmware1.bin", "my_device_firmware2.bin"]=
,
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
>                  "type" =3D> info.type_ =3D expect_ident(it),
>                  "name" =3D> info.name =3D expect_string_ascii(it),
> -                "author" =3D> info.author =3D Some(expect_string(it)),
> +                "author" =3D> info.author =3D Some(expect_string_array(i=
t)),
>                  "description" =3D> info.description =3D Some(expect_stri=
ng(it)),
>                  "license" =3D> info.license =3D expect_string_ascii(it),
>                  "alias" =3D> info.alias =3D Some(expect_string_array(it)=
),
> @@ -184,7 +184,9 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream =
{
>=20
>      let mut modinfo =3D ModInfoBuilder::new(info.name.as_ref());
>      if let Some(author) =3D info.author {
> -        modinfo.emit("author", &author);
> +        for author in author {
> +            modinfo.emit("author", &author);
> +        }
>      }
>      if let Some(description) =3D info.description {
>          modinfo.emit("description", &description);
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_p=
ci.rs
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
> diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_de=
vice.rs
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
> diff --git a/samples/rust/rust_print_main.rs b/samples/rust/rust_print_ma=
in.rs
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
> --
> 2.34.1
>=20


