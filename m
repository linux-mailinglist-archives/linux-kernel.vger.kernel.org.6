Return-Path: <linux-kernel+bounces-542104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D2DA4C5AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BF9188B922
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E2214A7F;
	Mon,  3 Mar 2025 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/ODPCqF"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A9212B14;
	Mon,  3 Mar 2025 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017033; cv=none; b=SI0ulsX2n3Z4MTb6LMNxdi/6b6pKvhk6E+GrTN+nbRIfxd5UZwV9fw8I+UoZz36wsTDGgajX3xVpdHrOR1zpGtbF0VyTGf4WLeQbpxX4DILBh9CoADW7HsZMlSFucBuljpUzOHqGykyZmBdW6jq/EM0OhSiSu895D34VyJwJ+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017033; c=relaxed/simple;
	bh=2t8phkimNKbCd3gTW6R8MiP4kSzgvA5udw5lS8cnwYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFeiGMu/37XG/2o1oZDUEVSd2ykzPJGA4rTwJ9W5sG29Xqo5BtfMoxQkdhSnGPMVZWxRP03h/eORLRE1IuR6QARDVBLvOsjc7PRElI9OuzOroNRvb1gm0VXG3mr9g4nZyjAZeu7HojMiZDfnwNZfJQytPmZ9k4hwZ7uemq42Uxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/ODPCqF; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2feae7e56c6so1213964a91.1;
        Mon, 03 Mar 2025 07:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741017032; x=1741621832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2t8phkimNKbCd3gTW6R8MiP4kSzgvA5udw5lS8cnwYo=;
        b=G/ODPCqFePTgRcxyDNKR5NYkpcIYvKz2y6KFcTVTWxUYLFc3BokRhT7j5J/5BgoFb6
         WDZlgtvIyuQRbIx0/56ZHx8mVFtm5xvNlw6AUSi+0tlB37VpuiyCCiLtxkJ7glCJQgpU
         Zk2vWCDFbILsk5otMlfo6OqJ9XEoErJEtwbKMkShDoSvY1GIDmJum3dVJK0MdsuJg7LW
         ysAq+Wb769uxGwEcvw3FShCd1YGYd1PS5LxBBrFyZRVbportlHqLry0wj/GSokXoa9f3
         V/Nm4u/z5eNO3gBQQ3e1dJGGtU13dm5+mKOj79bl4wG6zLpjBiq5pEmU1NRBHNz+4+hE
         zV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017032; x=1741621832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2t8phkimNKbCd3gTW6R8MiP4kSzgvA5udw5lS8cnwYo=;
        b=REfXpP5n1mpxPScQzuNJr/6mcTKSHR2xvr9xhhuwR/4V6GOiinuwqmBd3BsI26HBeU
         OzRdZVJ/53DRD9jkbmM/IV6acTcuXVhDKa7zHoSp7s+uryg8gzXJ7KHe3SSx2ucp3jyF
         hpNOLDj7yRLTHhtjxlB3d3+g3k5sWYW8fIE1ZLEnRGwVD24hGRzUa/wPEHiFKVLmGvzE
         vPxngJydZKfGjQwddjWr4OTgTdbp0eYzFNfhf/RLHb5qhQADnPc50dpNSWDxe0kf0Yqt
         iS0Nv6Lk+AqNHxpTuUsiBrpD7SXX34oIyc08zzyuUqrjPMkaJ50BTL+Rp4oa4vBIzH5s
         33nw==
X-Forwarded-Encrypted: i=1; AJvYcCUfEfOcPmDZc7pEFR+neuPwtEP/JcRpi2cLkkCLzyQrN13YzhxaFZVTY9D9rIzK/2CnNqhpFnpLvJDopQfq@vger.kernel.org, AJvYcCV4fD99WmzKfw1QKENd3pR0DgVUIhVIZio5dPkBBUK2Ad+ZRE3LVC5ufNGBqPHTiu47Fn5HAwelhmZ2SRsaGM0=@vger.kernel.org, AJvYcCWIT+bxH3DJv3M+oIWLH8iGIUrRd9tgcxfsl9XOyRcAaO3bIeLijhdk1oRc7wDdKsy3V+uJIxrIckI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgz90AHMdDRt5C9j9gyH9grhsLits8vM42P/l1ZFflH8x6ye3Z
	krzdgYiYoCwWs2j0yg1oMEn4GSJ9TuKAoZ+m73UyU636uDTAqh7RY465kajArFFB1M0SXvU67A3
	ZioyAYzg/02sKCLqkIPj+fwXYx8k=
X-Gm-Gg: ASbGnct2Y2aJY9aWA52WZ4mtdwUulqx/xSiQW8YYfr5OaDGN5BNUymy7nMJUCtVQEpz
	N/5f2N5oKUK/TrySZxKX+9kP6Cf6fsu3WNdgUPZ4frTD2YPJJE8ZegEueY9QR1+eBB+j9bqoIuL
	2XeZueGUfK332SHkRGSt87GPcDhA==
X-Google-Smtp-Source: AGHT+IFCWB/xyMhitMU72cViPJSPOslGxht2acBrAau8RUEYr8NM1n6NieTUvIWJwZXrkC95V761S3u1wfym0a6Pw6k=
X-Received: by 2002:a17:90b:1b48:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-2febaa8d1e9mr8553461a91.0.1741017031850; Mon, 03 Mar 2025
 07:50:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740995194.git.viresh.kumar@linaro.org> <023e3061cc164087b9079a9f6cb7e9fbf286794e.1740995194.git.viresh.kumar@linaro.org>
 <CANiq72kdWzFOZ39EoFNxEAbk4KYgzLi1OAEc1zn8BM07VpXy3g@mail.gmail.com> <20250303114406.xbfzhw7nvxdildb2@vireshk-i7>
In-Reply-To: <20250303114406.xbfzhw7nvxdildb2@vireshk-i7>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 3 Mar 2025 16:50:19 +0100
X-Gm-Features: AQ5f1JrFbQ8weMRh-VTlkqlPmvY2gp-eeqNwnDEPnPGmFG3nSI7bQLtENogFXJo
Message-ID: <CANiq72m2M=anoO5mbx5bR6UeYcaW++zFb62+h-vCgADibQMEKA@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] rust: Add initial clk abstractions
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 12:44=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Actually Daneil did suggest to make this "Struct Hertz(c_ulong)", but the=
n I
> looked at rust/kernel/time.rs:
>
> pub type Jiffies =3D crate::ffi::c_ulong;
>
> And I thought this is probably what everyone would have agreed to and did=
 it
> this way.

I see, thanks!

Personally, I would prefer that we consider using "strong typedefs"
wherever possible, as early as possible -- otherwise it will be more
painful later on.

> Something like this (from print.rs) ?
>
> /// [`pr_debug`]: https://docs.kernel.org/core-api/printk-basics.html#c.p=
r_debug

Yeah. The docs in the C side may or may not make perfect sense on the
Rust side though, i.e. it it may make sense to adapt them, add
examples, etc., but it may be that they are exactly what you want, in
which case only linking may be OK (i.e. normally linking is something
to do on top of the new docs).

> Yes, I was using this under `cfg` earlier, but removed that recently afte=
r
> testing this without CONFIG_HAVE_CLK. clk.h provides wrappers for cases w=
here
> the config option isn't available.

Great, thanks a lot for testing that!

Cheers,
Miguel

