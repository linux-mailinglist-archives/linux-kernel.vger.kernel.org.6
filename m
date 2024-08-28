Return-Path: <linux-kernel+bounces-304703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85BA9623B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C69B23001
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA334166F1A;
	Wed, 28 Aug 2024 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUnRpNSQ"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA058158DDC;
	Wed, 28 Aug 2024 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837960; cv=none; b=WQQSkwW9m+d5zEoLUlRCRSPn+6D+nKsZcdCahhjDRM0yHH6cp00yr1LAVRwAFhbqGHxM4ELjUjoZTM+FgMvTyhP4I9noIBnykAUJe4K0fUQvUN+FZRZm8O273Mv4MyHWg5wSFkLTpPqMV40LA1QHE54tfVWm5u/hc5jlVGNxg0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837960; c=relaxed/simple;
	bh=tDCMEZY4ROGolIVEcp1aMHDTEMvgP72/upv7zWxS7mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1u4T1ThpCS69hZzbY9wYpTSCKk1HIoNVqcj303fApc98DyLv15S6I/q4e+7fi7r8QhFnbG4d2ME73a0VQfgEIWzV8+gkIKGer/Jbr+lR2or2WL/Rm7c3hME0R4TtDhx7UC+A8fGeYz85//XSRkuIMfOLPjk5iZakGkaRKtYIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUnRpNSQ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d4750be8c6so1207432a91.0;
        Wed, 28 Aug 2024 02:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724837958; x=1725442758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoDr29DOcw9tyA2bqcOEO54uAa1jA+8Cey/HFxrHW7A=;
        b=PUnRpNSQsJW7ttXEQWBchP+3qjnrkqCfXJSbi/KCWoozCtTU9IwQ90L1XD9InH1COF
         gWZiQyGYlCGe6CyV6M+iqPirjo8Y4eaMljSqU3v3a52CmP5G4pOu1G8w3gFb1DXdc7Wt
         fH2qwFveVgVBLmJU0LCCt/k02ARdBtnILBdntD5QZl1Jzlx+O5eutGaiN+pWi8bN3O7+
         lXXcuERCB1Svw7p7JsTlrBSsWCtFspoR+oQMpW1uTRFWnK1n13bs8bprsF+QezT8o//t
         hRxYZaE+1BP+YyCjd2pny0YtlqbA2EAdL3/nuGa30sXaW/KC39Dxe/w8UCp+VKlq4/Sb
         Dz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724837958; x=1725442758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoDr29DOcw9tyA2bqcOEO54uAa1jA+8Cey/HFxrHW7A=;
        b=wyD8xAvBUHeJI6tQXhoLVxqLJ4DrYj7EVGd6wtYQf2Ao0iScV42x/EmHPjQyFOL8/x
         YNcPaGaYrPs5Q7QISpMRaz7xcMSC3Q3fCVIjXzS63O9tI2foQX2ei2vnkRESU45r8de9
         GjG4xpg5XvsUkcKIyDF+1ilubLIAg7CuVJOhhl3ZbnDOqTcDRy3l05vpIUNUMdcyGQUg
         CFiaQlatnIiQDTVylxkQewnXRwXQfnpYnuHGNrj1fq5f6WuKhfR5RddeKohHUtWK/12P
         MFk3VbPdLSeQnMw7ytfLUDpiOHndxWnrXeYu1FM5TZIhZy8+1EKXxNm/yGYSXYcaolrc
         xWyw==
X-Forwarded-Encrypted: i=1; AJvYcCUcrFrPwmpfFgor1p452HXu8IcC7UTQWErRpSYzZDSEFn4ZyUZzTlgAeX9MU2OHfkc7xQH5Xc8ENzIjbEI=@vger.kernel.org, AJvYcCVkkLQJ6czlbR+2AJtSAidastk/tPm2tQgbUtsg1YwcnejOMRpuwhfbRfOV4vEPjysHUT4sFRnuGdTr0qWdGL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNO88vjzSsg+4KDmWGIctYq8Qev/IsQmA36Jgb1R7bif3413bt
	fI7nzB6BLp5GHKPMR+XrFMK54ghLFxQ8pHKJ+zNLMAS0Nwp+WMeG3u7jdgP8K0ebDY6gI8h1qit
	OM2fX+SRUBoY34mwE/45S6l3k7Hc=
X-Google-Smtp-Source: AGHT+IFGqbbys2cpK3+MtRg5laEkHU+h2N/t6LMPkJRdqiXvqZZmqZSkMJjbM3N1G39PHuAMyiRYP9Yy5ZmWTKiFFoU=
X-Received: by 2002:a05:6a20:9153:b0:1c4:d4e4:d089 with SMTP id
 adf61e73a8af0-1cc89e0cbdbmr11637734637.3.1724837957847; Wed, 28 Aug 2024
 02:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827100403.376389-1-ojeda@kernel.org>
In-Reply-To: <20240827100403.376389-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 28 Aug 2024 11:39:05 +0200
Message-ID: <CANiq72nenMJUY3GK0CWUdDzQOXNgdr0zka6yb8nB+_vvCRAF3w@mail.gmail.com>
Subject: Re: [PATCH] rust: allow `stable_features` lint
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 12:04=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Support for several Rust compiler versions started in commit 63b27f4a0074
> ("rust: start supporting several compiler versions"). Since we currently
> need to use a number of unstable features in the kernel, it is a matter
> of time until one gets stabilized and the `stable_features` lint warns.
>
> For instance, the `new_uninit` feature may become stable soon, which
> would give us multiple warnings like the following:
>
>     warning: the feature `new_uninit` has been stable since 1.82.0-dev
>     and no longer requires an attribute to enable
>       --> rust/kernel/lib.rs:17:12
>        |
>     17 | #![feature(new_uninit)]
>        |            ^^^^^^^^^^
>        |
>        =3D note: `#[warn(stable_features)]` on by default
>
> Thus allow the `stable_features` lint to avoid such warnings. This is
> the simplest approach -- we do not have that many cases (and the goal
> is to stop using unstable features anyway) and cleanups can be easily
> done when we decide to update the minimum version.
>
> An alternative would be to conditionally enable them based on the
> compiler version (with the upcoming `RUSTC_VERSION` or maybe with the
> unstable `cfg(version(...))`, but that one apparently will not work for
> the nightly case). However, doing so is more complex and may not work
> well for different nightlies of the same version, unless we do not care
> about older nightlies.
>
> Another alternative is using explicit tests of the feature calling
> `rustc`, but that is also more complex and slower.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

Cheers,
Miguel

