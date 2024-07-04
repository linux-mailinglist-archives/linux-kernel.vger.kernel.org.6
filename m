Return-Path: <linux-kernel+bounces-241338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AF09279EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA171C24BFA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972231B1212;
	Thu,  4 Jul 2024 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZGB4JxL"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A681A08D4;
	Thu,  4 Jul 2024 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106566; cv=none; b=gK2JM0U9WZBMaYnEBV98Z1WLTGzl/LUfx0YMe7KLhxoRLfTPuS+lUfzQP0kypA1FYqlqLFINQYrQMXzNNVfeF+AXBpfP/IPHrXQQo7m+Z6iZ6sVEQIFuIwsGi1nAaV0Ffy0kRP/VWjGSMZFkS/lzeTsrpKqKYB54GoDls2esgrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106566; c=relaxed/simple;
	bh=wFHhVJumckKsysKCIZR45w+PkOdLpxaZi2rmHtCtQr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6ZH/F59e9bPQbhDKQIporjfD5F0jPB8DWe2WiBZ47B5V2s+Iyl/XgTtTrE6XqSn7bGUveBHvqG9vMzbGpoYHBxseU8+xJ6eH3W9r1TkM/4pKLUE7vNBz00EWpzBQPJngSCUj1O5mq+k4xWkTKMqM/9Jy2bIhuBoWGN04GqHa6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZGB4JxL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c8e7553c9eso548080a91.3;
        Thu, 04 Jul 2024 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720106565; x=1720711365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVFK2WSYZ965lLjkevQH4tcohQ9krtqpk0QXLUCUgcA=;
        b=gZGB4JxLN/FOFQo8lyeZDfQy/YVhWdEP3KchqzkAex8Z4RYdlu2m/eFwNzMmJz+9kt
         763bYqXatIij7/72bEzNlgVpj2iRaTwkicf1vwhvz0BwChiQr0QjmQIpsP/RTzdNf5Fx
         RTMN5u1OY1RLmEHpj/gRHTiN4CQBJiVOvlZ9eQ7ohEpcbVXjY+SjeW9YDoguQ5vSPjlc
         cdsFhUrbakjb2xR/ZBph4LqweKrnxE/kF1OLXYfTwzPNQDwhNI79Nf6VwNbdjIx4/JdX
         +iHBLUacVBjTz6IREwtiZ7Q37ujgcY/JgOS1PLeiqbewOqRfIai8On8Ck2B3xXzqTv3w
         YXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106565; x=1720711365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVFK2WSYZ965lLjkevQH4tcohQ9krtqpk0QXLUCUgcA=;
        b=lGlILspJUYt174vzfcfFg3MUW/1n90bLim7DNQoOGszmVpQhd1VO0UEk++WcbmSQbF
         KRjLsMKJTjGxG6Yc8n/15GHkM231oLxrd5MENydLVaWYrj+WzRn70dXpKPyAt1C4+2e0
         JSXk2HE68zEBZVgjII2jXE2Ngqou2TQ0A1dHxk6BXauP5jyzEu/xhOvc0q9xzANmuZpS
         V67ZBRGLUnlNLW+rQV+HiRteRvpdlxdR1h5mkHEVLVNdBJkoUuX4L+/OsM4MuMmT42+L
         KxWsMBKWYLaQIaJS76KFHzjtQdgaqb4jmAP/76yyRsoyPXTw3g6qHiPKkMSxTH513gkU
         e7OQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6rMp+xLUJeYV/Pl/bkDtdlY0V+yIDT2IpOGOpq1v6DM7PekT8KJ1uwpyBX7av3jqC3qTTVgWHyy5hcf1liEmbajWFGicQcK9LATjXXFDZoh3zCMO/9INKNUVSq1nsuwwGdZeV/oGM1bTs6rtwKSvbWPWJoe+DbwR/b0fdxC+TC7foF2z+EdUiMjennA1IzQhCLCXrRoePM57aKT/hcpYSxhY=
X-Gm-Message-State: AOJu0YwGR41maLLrp5pBC5xABYDDoHtke8mV+rbEQAhGi3/qsPrWWTj+
	Mhu4nar/fDHqvhxJ5o65GV/+1fc+gURxtkZUbKEFD7G/B1YgFUXnbB67TvPldzQEMsU/ezJSbXR
	SW1iG4akeLjoFBcQ6CfnYveHyA+0=
X-Google-Smtp-Source: AGHT+IFfBoeinZVknPJ2qB+zv1AA45Y+rwAXZJ2EypvSPSD3MCuzlu8qe3Z/aXwaSOKHiC9JvGHvi//0bilEXU7z030=
X-Received: by 2002:a17:90a:f2cc:b0:2c9:8f97:d2e7 with SMTP id
 98e67ed59e1d1-2c99c6b91d2mr1536223a91.37.1720106564696; Thu, 04 Jul 2024
 08:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ed8a8ka3.fsf@metaspace.dk>
In-Reply-To: <87ed8a8ka3.fsf@metaspace.dk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 4 Jul 2024 17:22:32 +0200
Message-ID: <CANiq72n=dF4Zzpoq9zpQ_Baapy_MXYJh3OHkuDRAySCThCh6Pw@mail.gmail.com>
Subject: Re: [PATCH 06/13] rust: start supporting several compiler versions
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 7:20=E2=80=AFPM Andreas Hindborg <nmi@metaspace.dk> =
wrote:
>
> This does not set a max version. Will older versions of the kernel
> always compile with newer releases of `rustc`?

That depends on how many changes Rust introduces around the remaining
unstable features (as well as plain bugs in new versions, like for any
other tool). With the kernel being tested in the Rust pre-merge CI,
hopefully we will reduce those to a minimum.

It is also why we need to keep reducing the unstable features and get
into stable Rust as soon as possible. The Rust project is starting to
support us more here, and they are setting up a project goal for
2024h2 on their side to resolve the biggest blockers for the kernel:

    https://rust-lang.github.io/rust-project-goals/2024h2/rfl_stable.html

Meanwhile, on our side, we can do our best to backport any workarounds
for new versions into supported kernels, i.e. stable and LTSs.

But, at least, this series should already help kernel developers (they
will be able to compile the kernel with Rust enabled using their
distribution) and Linux distributions (they will have more freedom to
pick a Rust toolchain version and avoid having to package another
version just for the kernel).

Cheers,
Miguel

