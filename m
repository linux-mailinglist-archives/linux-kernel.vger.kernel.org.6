Return-Path: <linux-kernel+bounces-571014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBB2A6B7DE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFAB174C61
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B591F1517;
	Fri, 21 Mar 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxeLXvA0"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226911F2BA7;
	Fri, 21 Mar 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550126; cv=none; b=PK629PebHBljDRMUj4ONqZYs872TmTprFGaEoLsxANqjrLh10HzATIKOzgaksPBorDU03LArtVTtjQg0G2wSINIriBkT0UktY/XM52acfIB54HBwJXVWHNIKK/s1WTOGSkkv7oe0Nrp5Rod1gTt/Mnpy/6ieLUFL9wAVFenjVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550126; c=relaxed/simple;
	bh=+w3YyOe+koEjM1VaafgX1Vje1aaGPYCbmvv9MXnKfGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMEv5UG7LOSx1TJv7aEMvKoK3ZQMEF1jDBhsEtgkWKnip+l6aBnF+JsL+01/8rIi9UhWiNPnodkHU/+hje9n1BxKAiunDL3BQTL+VBPYzXlZhJKTvcZ8PcI7IqgzNcu21+YB68/QR+/2eHz2X/qoaQ9z3COKOVgZKjuHrvz1rtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxeLXvA0; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bae572157so18327001fa.3;
        Fri, 21 Mar 2025 02:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742550123; x=1743154923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Q4FPwmURHlffOb9OhV7hWFSsMazIY8Sr98tWaYEysE=;
        b=gxeLXvA0qbbb0fS+JTbhRtB8QdfTrZcq+XF1emh+P/kbDNRltRAKer5ulTojuFLiIT
         P7cXfBep9LAivVa0K1sqMdZHoQx8PplZHJ8mY7SSrq2eQnaaYp2tkAB6ibCK/k2WLnWi
         mmG93nGBjYCbqzMFF/CRg5Tf1hlFn5q4DnXFlsPXW7R7vuS0klJ+4xi5ISMW5DZwUlx9
         UeDJld9G+L6vChuF8sRLxCmBcC8lKSjzgKEP/XMzCMZrzrOhCuVM3i8rPyzx6uv/kbG+
         zlu4+ch2n/1brNG9/lo9diLBfHBANJBowdb2BD7/evGElseYX7VHP3C2ERIM9GH3tXN5
         5tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742550123; x=1743154923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Q4FPwmURHlffOb9OhV7hWFSsMazIY8Sr98tWaYEysE=;
        b=vyYfOc8baaWFkRJMXSRjuT8W9e/cNH8FHDuNZNQ7+aTqpOsy0ME53qWTXSGkQ7F6Ja
         zOujVbbTdJ14SiYlbEhvI03b4jaPERAclIYxPaAN/9Kx4okHOMHrr2hZ8C2xHg7PZqSV
         7936HdlKebuHkRwFWX2g7tSFeecl8HVZkUo5iwZY5D5g9ldZelWoT1ALB4hYx7sb3VGY
         OM9nJaNSIrr7oOovxtnPLV0wOAhcyjDQaKmU7QJTnANYinWzsu2PoIoJHMkvdpjGXCxy
         Mws/xO3dxAkRQx1KZnnsl6cHYEnBlbYQKx7Cs48cn8quh5OmdLhayhPxvuJY9r/j+yap
         hQ+g==
X-Forwarded-Encrypted: i=1; AJvYcCWterNkhvRvXUG9se2W7ad2x1D8ZxIwmWJU51UNZ/Rvk43ZgAtCwpSuTzjOrn58dpRHqUohueoGeFAdCZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWyea60JnNHeG24UWBVzHGtLmAfVHZWGS9WlOd/iYl5hR0xJw2
	FziLzrKqoKTgtDR5nSMAna/Xul9R7oIGY+6q5oVCL+ebbs+QortCtwO0W/i0/+MjjDolGlHbuH3
	rbKpUryau+Cyhtasisgvj5ehsIdA=
X-Gm-Gg: ASbGncvxIe2Nvb31COqbTPk7T4CtRNMKjZKoXrXM2cItqsS3yEtHPxW0ipeyK679CoN
	7/Iz2LlrXICM9kD1gfPbVQIBuW4nt+/dq8HUcIybWOm1XJFNjByQwosBLSB53TASAjRR6RSBMid
	ryvMeO89Y/8bwtC2prYWjvNDGNLCqNUFPznxtyojGfLZnyf2firGImKaugepNyNp09PUn8LQ==
X-Google-Smtp-Source: AGHT+IFbpfOSQucztrFGroIm51eYa1L2b4hgcmZIh3lh6p7CGExa1Cyq7b/aGjvypuc4U1w/TfgR69zktOfwDzmVCRI=
X-Received: by 2002:a2e:bc1a:0:b0:30b:b908:ce06 with SMTP id
 38308e7fff4ca-30d7e239f96mr9731251fa.19.1742550122932; Fri, 21 Mar 2025
 02:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319-rust-analyzer-host-v3-0-311644ee23d2@gmail.com>
In-Reply-To: <20250319-rust-analyzer-host-v3-0-311644ee23d2@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Mar 2025 05:41:26 -0400
X-Gm-Features: AQ5f1JoU99qrk6ClDjbnWGh7Hc3SFv244Kd9xbJX-aSKzyqYfMt0O5Rawh5IHLA
Message-ID: <CAJ-ks9nF3A+NZuvRJj_5KH=_4uCVmyLb-T8qQa8D3iyN2S-fVg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] rust: generate_rust_analyzer.py: define host crates
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Boris-Chengbiao Zhou <bobo1239@web.de>, Kees Cook <kees@kernel.org>, 
	Fiona Behrens <me@kloenk.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukas Wirth <lukas.wirth@ferrous-systems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 8:07=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> This series updates rust-project.json to differentiate between host and
> target crates, where the former are used as dependencies of the `macros`
> crate. Please see individual commit messages for details.
>
> The first 3 commits contain mechanical formatting changes and are
> optional. The series can be taken without them.
>
> I avoided more significant formatting or changes where possible to
> reduce the diff. Unfortunately `scripts/generate_rust_analyzer.py` is
> not consistently formatted before nor after this series.
>
> The 5th commit ("scripts: generate_rust_analyzer.py: use
> str(pathlib.Path)") can also be considered optional. It removes an
> inconsistency I noticed while working on this series and which occurs on
> a line which churns in this series anyway.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Changes in v3:
> - Rebase on linux-next. This is needed to pick up all the conflicts from
>   both rust-next and rust-fixes.
> - Drop `uv` from `mypy` command. (Trevor Gross)
> - Add `--python-version 3.8` to `mypy` command. (Trevor Gross)
> - `from typings import ...` directly. (Trevor Gross)
> - Extract `build_crate` and `register_crate` to avoid peeking into
>   `crates[-1]`. (Trevor Gross)

I decided to put this in its own patch in v4, will respin later today.

> - Link to v2: https://lore.kernel.org/r/20250311-rust-analyzer-host-v2-0-=
30220e116511@gmail.com

