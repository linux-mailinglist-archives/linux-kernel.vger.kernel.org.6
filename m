Return-Path: <linux-kernel+bounces-550925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5595EA565F1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477543A9563
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6697C212B38;
	Fri,  7 Mar 2025 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUy70o7p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30FC2066F9;
	Fri,  7 Mar 2025 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345020; cv=none; b=jK8qEQ7zGvReHPb38EwS8a7TGRor+QJ1i3vapdyVKN6u4iZSjnItCrLGvFONu8yzusuNwljO8OdfYrIYGA1BEVZvwQZz+ExGZ6GZwRHsGAdGMGPr7YQU7CLP+q2EtXi/aaoMI1uomVBf0DI7XL9IwZwB07tur4RjykOYGcDlCsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345020; c=relaxed/simple;
	bh=0V66XMCNY3Rp+V6nGtFEXJXDKx3PA76ITGZT1ijnM5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tHJHAeYUhFzO37NrchakWpfnjC9E00ZMaERoaaeGq6iONan+N9XIc+EJtRZMT5gKKN6Jbmlxc22U1f2eN1sNSD5I0MabQngFpOThI36nwjGmYKut43J/w98/5GFgqvI/GiQwyo9dPUFWFx677ogis+DL7K7LLi5zx9+2bUUv65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUy70o7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBCEC4CED1;
	Fri,  7 Mar 2025 10:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741345020;
	bh=0V66XMCNY3Rp+V6nGtFEXJXDKx3PA76ITGZT1ijnM5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SUy70o7p1xUnsuCGm9oll4ND/8P7tO4PJmi7z590o3FnoKl1coJseoLv0RzZY0yHj
	 ciuvO/amoE+6cK0w0mqS95Q0/peThCKxFUwOyA0Ghs6Feaxwr4UsM2TM4KlnV42J6B
	 ai2s2/DprbPzTBvPbuOp/J1I9mRm26iZwGKVTRu4LfGpWz3ZwEsg5twi1vYVh9+tE2
	 MEnEMeoTkKSIjlpG0XAaCLQpQszfCJZ8KLPp1RF4PZayz5tZkuDTbTFXKhcd4GjahE
	 IxPy2UEHUww9XlVniBtxgTe/qn2WRaq7NImjs+AQSTwPs3MPmsYZWNv0q/zc0oTogW
	 IByNNnCE74+og==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Boris-Chengbiao Zhou"
 <bobo1239@web.de>,  "Fiona Behrens" <me@kloenk.dev>,  "Kees Cook"
 <kees@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  "Chayim Refael Friedman"
 <chayimfr@gmail.com>
Subject: Re: [PATCH v3] scripts: generate_rust_analyzer.py: add missing
 macros deps
In-Reply-To: <20250210-rust-analyzer-macros-core-dep-v3-1-45eb4836f218@gmail.com>
 (Tamir
	Duberstein's message of "Mon, 10 Feb 2025 12:03:24 -0500")
References: <6-mv8ahCblqal1f_T1RcVPPPb6QEedsAXlhmcyCNC-lnvAj1USOInn0YNogItuEdy_KthnPdFDElN1F6A9ncwA==@protonmail.internalid>
	<20250210-rust-analyzer-macros-core-dep-v3-1-45eb4836f218@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 11:56:45 +0100
Message-ID: <874j055csy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> The macros crate has depended on std and proc_macro since its
> introduction in commit 1fbde52bde73 ("rust: add `macros` crate"). These
> dependencies were omitted from commit 8c4555ccc55c ("scripts: add
> `generate_rust_analyzer.py`") resulting in missing go-to-definition and
> autocomplete, and false-positive warnings emitted from rust-analyzer
> such as:
>
>   [{
>   	"resource": "/Users/tamird/src/linux/rust/macros/module.rs",
>   	"owner": "_generated_diagnostic_collection_name_#1",
>   	"code": {
>   		"value": "non_snake_case",
>   		"target": {
>   			"$mid": 1,
>   			"path": "/rustc/",
>   			"scheme": "https",
>   			"authority": "doc.rust-lang.org",
>   			"query": "search=non_snake_case"
>   		}
>   	},
>   	"severity": 4,
>   	"message": "Variable `None` should have snake_case name, e.g. `none`",
>   	"source": "rust-analyzer",
>   	"startLineNumber": 123,
>   	"startColumn": 17,
>   	"endLineNumber": 123,
>   	"endColumn": 21
>   }]
>
> Add the missing dependencies to improve the developer experience.
>
> Fixes: 8c4555ccc55c ("scripts: add `generate_rust_analyzer.py`")
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Suggested-by: Chayim Refael Friedman <chayimfr@gmail.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Changes in v3:
> - Avoid shuffling compilter_builtins; it is not needed for RA support.
> - Align more closely with the long-term solution:
>   https://lore.kernel.org/all/20250209-rust-analyzer-host-v1-0-a2286a2a2fa3@gmail.com/.
> - Link to v2: https://lore.kernel.org/r/20250209-rust-analyzer-macros-core-dep-v2-1-897338344d16@gmail.com
>
> Changes in v2:
> - Change macros deps from [core] to [std, proc_macro], improving
>   autocomplete and go-to-definition.
> - Remove Wedson Almeida Filho <wedsonaf@google.com> from cc; email
>   bounced.
> - Link to v1: https://lore.kernel.org/r/20250209-rust-analyzer-macros-core-dep-v1-1-5ebeb3eb60a9@gmail.com
> ---
>  scripts/generate_rust_analyzer.py | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> index aa8ea1a4dbe5..1394baa5ee9e 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -57,14 +57,26 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
>          crates_indexes[display_name] = len(crates)
>          crates.append(crate)
>
> -    # First, the ones in `rust/` since they are a bit special.
> -    append_crate(
> -        "core",
> -        sysroot_src / "core" / "src" / "lib.rs",
> -        [],
> -        cfg=crates_cfgs.get("core", []),
> -        is_workspace_member=False,
> -    )
> +    def append_sysroot_crate(
> +        display_name,
> +        deps,
> +        cfg=[],
> +    ):
> +        return append_crate(

Why the `return` here?

Otherwise looks good to me.

I never had any errors as described above, but I can confirm that go to
definition in `macros` for items in `proc_macro` work with this patch
applied. It does not work prior to applying the patch.


Tested-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



