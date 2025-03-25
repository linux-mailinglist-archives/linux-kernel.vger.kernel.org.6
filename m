Return-Path: <linux-kernel+bounces-575806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E302FA70762
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D6218866F2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706DE25D1FA;
	Tue, 25 Mar 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="d7aJH10y"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BB225A322;
	Tue, 25 Mar 2025 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921517; cv=none; b=BzEBKWV6BWlFX+mkdL0dqyEQ9c0blE9defZE7DMCer/9Nk984uF7KihPRMWmVft095/OnLMpVK4dwBoJfDzKdZNJvK4um/5VMw3X/kP/cXfv58ppSedv51n9GNIRpiZZZ8TnSbRkYYHOgj3oC1JHluu63QAfiJA6g2NhhBDWbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921517; c=relaxed/simple;
	bh=icI1nYJSAsZtHikGXcRAYlVckSdSYGzgOdPYTnynXDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fq7HT2+zNRfVpXKmhilAcVAetyAg5rY7wRhzojES/XS5uKStCFx4wwsPQhzWfG37iEqooJsSjWGa/sUyJeFpOU4fp10UIlJfRLrUIr3yPIZcf26Zynk8QEScmSY4Bq9OKMLZCom3Z8CfH9W32O/TGifVXkWUAjtf2eZqnixBzKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=d7aJH10y; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1742921510; bh=wD/FXARrybXtyOrneocrxs4F05aeFnco4F93wzPQ/ws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=d7aJH10yXZ7wRF12y2NWfVCjtk7yKbfDJy3drH9I+fRy8IshGzmKMCFN1wMXpU4Zl
	 NmFn/sDZaS73K0URBn4unxoKTVjUpjvQwLIYDj6S4WzNn7GancnvXGJmf3W/0pslVT
	 5CDI123V7hm1DHDJaQGSwZ0Y3zx2VSgXdPEvcvZM=
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Benno Lossin
 <benno.lossin@proton.me>,  Andreas Hindborg <a.hindborg@kernel.org>,
  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  Danilo Krummrich <dakr@kernel.org>,  Boris-Chengbiao Zhou
 <bobo1239@web.de>,  Kees Cook <kees@kernel.org>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org,  Lukas
 Wirth <lukas.wirth@ferrous-systems.com>
Subject: Re: [PATCH v4 09/11] scripts: generate_rust_analyzer.py: avoid FD leak
In-Reply-To: <20250322-rust-analyzer-host-v4-9-1f51f9c907eb@gmail.com> (Tamir
	Duberstein's message of "Sat, 22 Mar 2025 09:23:44 -0400")
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
	<20250322-rust-analyzer-host-v4-9-1f51f9c907eb@gmail.com>
Date: Tue, 25 Mar 2025 17:51:49 +0100
Message-ID: <m2cye59hp6.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> Use a context manager to avoid leaking file descriptors.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  scripts/generate_rust_analyzer.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> index bd6e321a6aa5..ccb15aa66929 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -211,7 +211,8 @@ def generate_crates(
>  
>      def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
>          try:
> -            return f"{target}.o" in open(build_file).read()
> +            with open(build_file) as f:
> +                return f"{target}.o" in f.read()
>          except FileNotFoundError:
>              return False

