Return-Path: <linux-kernel+bounces-565903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D7AA670D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD79F19A1031
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0C1207DF6;
	Tue, 18 Mar 2025 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgaaHVm8"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1A9207A22;
	Tue, 18 Mar 2025 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292666; cv=none; b=bFhrm+ytdpJKUWl+cXfGnZfiOZOmCrSk7I0VrFQF18UKSoF2osvCvAB2UD0fO7sgD70yDypK/ikAnv6RH5tZwNFuDgZIw3jyTz7tmP6J3pODEFtr2C5/D8mQTSPdeqf2M5owFNoXhTHWGvCdGCtKB8luwljCvJXNePK6XJGXvc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292666; c=relaxed/simple;
	bh=puwZpc9fnpT0SxWUpm3PdjIjszBtFGfGzbiYPyhX6wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q016jHWIK01KbapJlYXHHI+wjP/h4cBeR8JkOGpaF1vyG8esZpovOoKQPPcGwknj4IU3Y3rm+Wio8y+rVXmISLUAjV+0jdxcULkBlO8gkqiCBEDpG9MN6R9f3d+PrLhEw//ShzaUP9M3sSz/gOWfSLUiqRlm5SCAaiahy6daPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgaaHVm8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-301a8b7398cso77899a91.1;
        Tue, 18 Mar 2025 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742292664; x=1742897464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puwZpc9fnpT0SxWUpm3PdjIjszBtFGfGzbiYPyhX6wQ=;
        b=YgaaHVm8R00dfWZJqdjU1w1aTMNjq8+z0s8SeL8vF6X6Z2ks49LMgDgIdc12ZKnfrd
         1t90Z/tAd3Kx5v1K+BBbXKkqx4fAN+dYZfMRU1LPzYdCg8lE+zoY66ZPd2t90PE3dixM
         uz4HSZcN6K2m7CzQY6vff3fgzzmKuumOkIA8vTDXsBappYVWcFSbYNiPyMwICl7dA+R5
         +5/iQ4MRdYdGy2gCVY5SsaSlAGEE7IN8FoTjQevXali4TtFWdKbcaGtvdoZh68eYIBHU
         3rvTdkynVK9TWXcnvSLkWSXcBUyJU6PDeTalsQpn6b+TAGUDKcY8AY185404RlVFBRjp
         WyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742292664; x=1742897464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puwZpc9fnpT0SxWUpm3PdjIjszBtFGfGzbiYPyhX6wQ=;
        b=MjgntvTfBb3DMghy59e7NKty0TKKLLss6jf0lcL3LPwS9l1gXh+uNCa+GhxP4w0R/m
         o4eVvbWYWq7BImWNWIjYhhaulafLYRFUII9cy1b49Dfli0qVAbflE8UwZndtrb7gHy6f
         oQCXhK8KSy8fxcjW7xMbHwFFvwHXZ/lHO6qZPLAxusb+DDHi3QxQeaxfMAdPFUiX6+F3
         yO0/00M4gpL0dtHzVac1fB8cSZZzh7AMXIUh0vTcTPphhdReAzUPIhXkJT1GalH/5HPV
         kjBU+wOi5LxYCsZOBeegXuY1B1iYwRaEqvWfNeYqXDqTOyiDJyI6BesXGgHQCH2J1Ttf
         qy+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfdswLkdNtFzzTXDmmFYwU1rcBfEo3xrjJcK5DeQpFRnH4+PWwlxMJQKAxYj5Hci4M0/AQ+thmU4U1QNbj/N0=@vger.kernel.org, AJvYcCVJWKLRmfTg13LvoaPsG8LElKgQz5USBlGEcpLyxZttJgoz5iQiSG77bJYvxtBQULhKfVTlNwga8Hdf430=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMLlzY6xblIslChLOllkt/nKI6Y4lGYH1P/j4fefXD4yvEPo4
	trPmtjsvfBVgmupSFfSaMYEbcl0o3f6lx/xD+hNiBs0v/KivYxNmJMxlpH+bnwNs2f3rdswf5JB
	z7EddksbbfbMBHdcuLcHukICpcc0=
X-Gm-Gg: ASbGncs2kqOgc0V++kUec6jh56dF0yu4CFZXNPpipReFjZ8d0y/P1tlASibGJlu8RCN
	WKsDy1+/am79PLAMP4h/6/TvgA39F5Yy5bg1a2hWAAnSHhs/EhYMO7JnYWvKUAL3WhHxwvIGxx5
	g4oa6hJSCP4srRgTq6k8GHriMf9WXqkvMPfw7n
X-Google-Smtp-Source: AGHT+IGB4pLNiuryWOPuCO6MoIuBuFy1ozidD17nVmrb8yE9r7RMjTngizHJUOGCma5BGINdrBLFwwq4ZGQsKrsA1Os=
X-Received: by 2002:a17:90b:314b:b0:2ff:78dd:2875 with SMTP id
 98e67ed59e1d1-30151d89050mr7818390a91.5.1742292664500; Tue, 18 Mar 2025
 03:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208-rust-kunit-v1-0-94a026be6d72@weissschuh.net>
 <20250208-rust-kunit-v1-1-94a026be6d72@weissschuh.net> <CABVgOSnwkDihbRzYF3uh3At_x0MgOB42_E8sUAD8moKwx+zjRw@mail.gmail.com>
In-Reply-To: <CABVgOSnwkDihbRzYF3uh3At_x0MgOB42_E8sUAD8moKwx+zjRw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Mar 2025 11:10:52 +0100
X-Gm-Features: AQ5f1Jq3f-pICr0X9p55_4vrGdEv6uxkF7XdN3Ns9pEmybRWGVbLLKT6D5l6wa8
Message-ID: <CANiq72nnwopFAdETMhgkCfN9dj+JJZQ=K1BKz_A_xUViis7Avg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: pass correct target to bindgen on Usermode Linux
To: David Gow <davidgow@google.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 9:07=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> Is there anything holding this up for the upcoming merge window?
>
> Miguel: I'm assuming you'd rather take this (and possibly [1] as well)
> via Rust, but if it goes in via the uml tree, that'd be fine by me,
> too.

We try to get arch maintainers involved (and everyone else, of
course), i.e. it is up to them. But I see only the list was Cc'd, not
them directly, for some reason -- doing it here.

Ideally, maintainers get involved and pick their own Rust-related
patches, but I can also do so with an Acked-by from them, which would
be nice.

If they don't say anything, then since you have tested it (and you are
a main um user due to KUnit), that should be enough, but then I would
suggest we do it after -rc1 to give them time to react.

Thanks!

Cheers,
Miguel

