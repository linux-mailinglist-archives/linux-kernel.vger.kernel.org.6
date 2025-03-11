Return-Path: <linux-kernel+bounces-557031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D82FA5D2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3503B8FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C191EE7CB;
	Tue, 11 Mar 2025 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T07KfZop"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892B420B22;
	Tue, 11 Mar 2025 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741733184; cv=none; b=FnUIVv23IOCD6a3dVPOLUC7452pjxbWif6lWLRPaoCem2YbNKcAp3i7DftOavsZi9/g+MAOun4tFzN45h5I2g4PnR4nF7MY+DrL16vDqStuF5CVPpb/vNuO8jMjGe9eQjRhmKpL7s2VaSW1+alaD1z5SWqCog5P4HHW/bojhGV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741733184; c=relaxed/simple;
	bh=lO4DRE7IzcNZdu+1UcDVREvshouQ4Mn7WL8CtCnl4nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdjNfD8W0QUIUa0OTmMilY0Mi+MNCuu8855SGW+VJp6gmCmdxlmXt3obXAhMMUbVeQy3gB+kvJowuJgtN1dnWdw69pwA9oxT5kL9SmwfjBZ5Rom6JAWbiwSTWyzgKpzYDiNcmLlaEe8mwugXh/8zRPWnuqIbEjf2byZ5ArISftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T07KfZop; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff66327419so1569743a91.1;
        Tue, 11 Mar 2025 15:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741733182; x=1742337982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPBJLygds38LuxYe5kmZDzx1vUiBx96YtNFMFAGLggY=;
        b=T07KfZopZy9Z1/C9ucdbUnpc3kFhvXwfT7G8h093IJs3RhkyaBmXCYDSLwcIuzTkg0
         TvkwdnStTPlYOIP1eenI9SFy8F7XQSM47tj5rww5lO0NQ0dHwbmS/vMm5Lx/OhyHKDlA
         95jaZcgO9XPKy2Je/ZaXI8tFfVCUwFITilcLN0V3RIn65TxobXbM3oaN9HJwTAwNEL8G
         7SzX8MMk7G9pO7Rm2Hl+cdKZEwxOudlpggVGaCVVkCqlDuLVyjhn2ui0XLYGOri/Lu+C
         PyjXUy+cLol/F6udGpERCd1NvipE1W1QNrOFGheS4nN8dkOAvhZhqZmqTBwXl2vtdffv
         ObrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741733182; x=1742337982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPBJLygds38LuxYe5kmZDzx1vUiBx96YtNFMFAGLggY=;
        b=QtSgmSiiV1Pv7KBodCjggpfUxsorN3Tf7S7S7r2JOBkv0It2lUV3CIhV6JE7A3Jocf
         oUZEfFFKuZeqkCxeltbqB1LTxj/7LRk6M2NNxJrdHmNC6FuvVg5MgbZh4xninW62FeJ6
         yfBGjduXCiG+k3Wc5VNHKrPQep3j0SMzLNTrjq2kxKPnyfcf6o4w3OcoWafKOSblVcBd
         j7fcXjvXoJNvvBoihmp/3fsudb+OP5gB+6/zduAx7ixBxa1CjLhG38QG1X9+EXtYZmJ4
         H3hKRWJN0kioWNMaVlSDi52g0jAaVIPkls5n9FtTcxGuGKomADvjG9dagsShlypB3DvA
         rxSA==
X-Forwarded-Encrypted: i=1; AJvYcCUFzKW9ze92DuK/pQkjAQD7QXH3HFhmjOk8JQqDnyNC55YnPi8EP0ufjpsm2r3dsO0Kja1InTELXPX9rcnFq4Y=@vger.kernel.org, AJvYcCX7OQyrP2aSmbW6ppHRnLU1nGIY+7BmnIHJYLCrlURvtgKfc16XKYBbAh4oWHRXUoQ4vyn2Dc+BgaFIJyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNBY8PZCWbkcmsh/a+1Ez9cfOtadWu9pmn55/EsPSKJ4dtKGQ+
	qa3Qm4LDSTvo2kkIE0XvzocyJZfnUldnIKQAZTkgsYpCLJBqe3re63rN0gaWR9oxPTU4tsQf/s8
	yUwWLC2cVtgVWW47RRoiAl7wIEP4=
X-Gm-Gg: ASbGncvf+fCqGw1AyFh4ofGZs4fcVSXzpaCsZF8FbLovC739IIqy3u2FobqVJFxMhRX
	FnOWnsObo2ROSD+dSh7sNlnEtR1oVJ/cD+3QaFuCDfXy2owAWDcCDZ1TEf4OxPogG2PCI/JQGEm
	HbleYwG29Dx8fOXB9vunD9KzmAzQ==
X-Google-Smtp-Source: AGHT+IEBT4YmRjhA/Por7XHahRKY5XBLFnrIamATCZLdpSPi9tDGPHCurnfoKRveFGOa6xopNK9rBOwRZNviVA2NUhY=
X-Received: by 2002:a17:90b:1b48:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-300ff380401mr2573810a91.0.1741733181766; Tue, 11 Mar 2025
 15:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-rust-analyzer-macros-core-dep-v3-1-45eb4836f218@gmail.com>
In-Reply-To: <20250210-rust-analyzer-macros-core-dep-v3-1-45eb4836f218@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Mar 2025 23:46:09 +0100
X-Gm-Features: AQ5f1JqK7jbDAViOgCtWrMJbji_fxLKzgIKB0gJpTIXMNwZ1_VCSMKP78My6QQM
Message-ID: <CANiq72n8G3Dbd8sh410J-g-mJo863xV1ycS4OGm-Vv6+n=24ug@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: generate_rust_analyzer.py: add missing macros deps
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Boris-Chengbiao Zhou <bobo1239@web.de>, Fiona Behrens <me@kloenk.dev>, Kees Cook <kees@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chayim Refael Friedman <chayimfr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 6:03=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> The macros crate has depended on std and proc_macro since its
> introduction in commit 1fbde52bde73 ("rust: add `macros` crate"). These
> dependencies were omitted from commit 8c4555ccc55c ("scripts: add
> `generate_rust_analyzer.py`") resulting in missing go-to-definition and
> autocomplete, and false-positive warnings emitted from rust-analyzer
> such as:
>
>   [{
>         "resource": "/Users/tamird/src/linux/rust/macros/module.rs",
>         "owner": "_generated_diagnostic_collection_name_#1",
>         "code": {
>                 "value": "non_snake_case",
>                 "target": {
>                         "$mid": 1,
>                         "path": "/rustc/",
>                         "scheme": "https",
>                         "authority": "doc.rust-lang.org",
>                         "query": "search=3Dnon_snake_case"
>                 }
>         },
>         "severity": 4,
>         "message": "Variable `None` should have snake_case name, e.g. `no=
ne`",
>         "source": "rust-analyzer",
>         "startLineNumber": 123,
>         "startColumn": 17,
>         "endLineNumber": 123,
>         "endColumn": 21
>   }]
>
> Add the missing dependencies to improve the developer experience.
>
> Fixes: 8c4555ccc55c ("scripts: add `generate_rust_analyzer.py`")
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Suggested-by: Chayim Refael Friedman <chayimfr@gmail.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to `rust-fixes` -- thanks everyone!

      [ Fiona had a different approach (thanks!) at:

            https://lore.kernel.org/rust-for-linux/20241205115438.234221-1-=
me@kloenk.dev/

        But Tamir and Fiona agreed to this one. - Miguel ]

    [ Removed `return`. Changed tag name. Added Link. Slightly
      reworded. - Miguel ]

Cheers,
Miguel

