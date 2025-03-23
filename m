Return-Path: <linux-kernel+bounces-572841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FF5A6CF49
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950DF1899513
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC41469D;
	Sun, 23 Mar 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezcnk2TX"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059D117E;
	Sun, 23 Mar 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742733616; cv=none; b=DfJgk5nw4y7ZfRfJA2S/J1CzYCaR3WMF4qhp7y/YHnmb1o6+fUXRSmKag9RpP/cVfELyRinX+nCjP1ajqm6ZxgU0E110oHILKEG1zn3SGpc4QDVfPAkA7quNazLtQBTcHQlRS0KbJ4WcztWQIZVKkwp9K8a3F2apq8tboZbmsP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742733616; c=relaxed/simple;
	bh=DqHYYEjmaESQRVmk9vt2eOPivo88r2bvvnL3tP9sPpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i31n16Q3Rth4C9k9iTOsOPMWk4PsXjjW40RCEh6Fb/n2LehEnW7HP64PnMdnCNQFAYLDBuV1c7vNwLg5/KueNY4/DKFEYNUqpYxeTLRdJZsOEJmTV18Sm5syL2CA5ljNBpOGwdje+EF6ByW0/dCJP7uQxXmpmDvTMYcE/Z4e9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ezcnk2TX; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3032a9c7cfeso397154a91.1;
        Sun, 23 Mar 2025 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742733614; x=1743338414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqHYYEjmaESQRVmk9vt2eOPivo88r2bvvnL3tP9sPpA=;
        b=Ezcnk2TXx1DErYfo1LqNZpN8JJuV3PCGD3ejKXCm6K7FNDfZXkZ4MQfKKik9dmx6WG
         DXfzpY5R2dzCdxE01P5nQDXKRTlYRUGTxI8WiBf10NA4BjBNFVGMfMwN3X8sEXNtA72V
         Mbk3oHjdc0kr5kJ8Nr7yBZZhz8H1YCYuEadeuAMTBVRZX9jecrlHWJSDNcW8EpAJiHcS
         vGvCtGq5xM+k6SOHUNve5EVf49bOekEJrAP6B7ILRFptX5cgn7nTz7eM5NkXSi1XwgHw
         pg+A8OSetSHHp207onIE24CByOSL/pV5s8How3G2HtuWyXElYEn1IZCJwhlHKGMuwNQD
         AVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742733614; x=1743338414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqHYYEjmaESQRVmk9vt2eOPivo88r2bvvnL3tP9sPpA=;
        b=datY9G791sC3UNbWnOCHG1JXLnXpsnKFvQab+B1QbE6VEonhwxurzFJ6SZIbQYPJal
         QNke8mJ0+tYVxARIqZjAbQIhgmUBlTIklhE++Mdk9KArGrVZOlvy6bCGxebRvcRFsR5D
         zYywsYhqm3LbsavIRZx6ODqrpTJFnPLO+KKhmmw64l/qAdddmTpl3Ek85RSs6+xWY5az
         0F+KKHExTQM0IKmPOhuUBDrMcYu3qxOy7gzXbiTYXddI2U1Q6gXp5gV0vR/kIzPta4/b
         X8u7fcvQTeHALd0YIl9dqCNXwMuiULeU98paBymoEmPKJvhEeeigRxeR2+e7KUS6DOy7
         7oIg==
X-Forwarded-Encrypted: i=1; AJvYcCW20P/wGAzUeaXOf4bBc6zl1AT0LER5Vnaz4S5fX1UnQEdg54bGwEzHr0IeruR59CbpLi0yOSOT39vwhTY=@vger.kernel.org, AJvYcCX7NB4ktYFeFcG1FHrQzlBy166YJXaVnBmHLAVhrFR1BZzqXhNYYMrcU+7ZYhZyDTPW/NREkS8jul0rrIRRroc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZ+vXffISTKSwtlxDj8C9IwbaTk7+R2TI39S0zpkzTltDSI8k
	MJTKL4qldFrFZIUME10jmX95u77mIVNrxydGY5W2UF2v5ZO9sGx3oOBUzjYWV4OjzWLVhYFmZuK
	qzjdiNK7/J9eyhykJkO4vVlneoNU=
X-Gm-Gg: ASbGncsop6uNqLYRPfiJ8NK4FY+b2Q3YrWNz2/v5VkpG4j06/hCRvyYsZx+yGG/W8ze
	rPUKG7yVikbeLrsdhLs20vncykgntZSG6mMK0SEovIffll1Hh+bus3CV+cV1URg9tZqELm47AAU
	U/+lM1Oer2WQGaiZyv8cCZgbZim8CPawx4ycWV
X-Google-Smtp-Source: AGHT+IH8k8F+6C8z/XjZK4U0aEZ/jhav4xLIW/iNynqD8xKmmAL/snyvq0cT2pReqEwuzUGu42AHB2H3qS+tTQ4827U=
X-Received: by 2002:a17:90b:1a91:b0:301:ba2b:3bc6 with SMTP id
 98e67ed59e1d1-3031f50c61amr3730040a91.7.1742733614114; Sun, 23 Mar 2025
 05:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com> <20250322-rust-analyzer-host-v4-11-1f51f9c907eb@gmail.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-11-1f51f9c907eb@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 23 Mar 2025 13:40:01 +0100
X-Gm-Features: AQ5f1Jr5ZtaaPdcqhtzwSErRyhlPWdB08QAp5mhp8yNFWxfqZOTDgPoTyftM4h4
Message-ID: <CANiq72kZ145EzoQMbD-2ZDkb+s=bwfE_AGkoMpfk1a=KRVMaUQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] scripts: generate_rust_analyzer.py: use `cfg_groups`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Boris-Chengbiao Zhou <bobo1239@web.de>, Kees Cook <kees@kernel.org>, 
	Fiona Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukas Wirth <lukas.wirth@ferrous-systems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 2:24=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Declare common `cfg`s just once to reduce the size of rust-analyzer.json
> from 30619 to 2624 lines.
>
> Link: https://github.com/rust-lang/rust-analyzer/commit/2607c09fddef36da0=
d6f0a84625db5e20a5ebde3
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

A note in case it matters for someone out there: that commit appeared
in tag 2024-08-26, but our minimum Rust version is dated 2024-05-02.

I think many developers are using a rust-analyzer that is newer (i.e.
installed independently), but if others install the component that
gets distributed alongside Rust, then I think it appeared in Rust
1.82.0.

So I wonder if we should wait for the MSRV bump to start using this.

Thanks!

Cheers,
Miguel

