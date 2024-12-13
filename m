Return-Path: <linux-kernel+bounces-445267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD489F138A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C251887D38
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E551E47CA;
	Fri, 13 Dec 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzVtgzZA"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BAA1E22E6;
	Fri, 13 Dec 2024 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110602; cv=none; b=bAmwiqdkmFYVsH+zmSzZbYKzLjtecKoTfuVHkJenPwS/EjOPbfMng81MUoqTeh0QsOazyXr3U1CiQMqw3jSJkoyd0UuYls7QZsHwUW0K4VxEjaFZ2CEAcsgR4cfacfIpEDk6Bg0j8ptjMfOtEXLWqZrZnnC2iWNt06tedQuoG8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110602; c=relaxed/simple;
	bh=0LU1zDAvgs3/X5OusvmBy3mFEzBMIiEAJcJaoHDIYwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouPObLjByKmh2kuL9rwRgPCASjGHTzLZT8/4McDkarl7nJaejfOcwj1oFWfujVDwtCDCSy+SKnnNGTX5YANl7sVNmmvDNG+vEGWb93aJVhgrc63aFazfe1zgQv95jHL6JD1Keh1pVyXlQl+QavXo4C67cSQ6ogD2tItTLHrCiww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzVtgzZA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea7e2204d1so171870a12.0;
        Fri, 13 Dec 2024 09:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734110600; x=1734715400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LU1zDAvgs3/X5OusvmBy3mFEzBMIiEAJcJaoHDIYwM=;
        b=dzVtgzZA+zlP6lM6BkXQVRIG78a7j08kj5EULCfh4tQYAvaYMwn0Ap9l7lof0pXZT0
         XIo+TTAEyfTtuQHNsZWlabLVZ/2DgwDwiAPb7Ze4bk5zXrNymDLladNaWIZ7ABs1FMUm
         nkynzGnBfbVykj1NromSctRALlqzXwqqFK1kb51IkiWOzhb8dRSRboRN9kf1VAxJC/0Q
         NfBwkq1ug1VbMRmhmU9zwh/IOC6PJX3N87u/42V9+FcfPDWGkyONMALw1qHFogWgPR1E
         VfD6LC+m3v4WErq3r5lqE0CMrPNxU6qR5FrhIdQdq/Ky3wR5QSTQZ5gvUBGZR564iAhM
         YueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734110600; x=1734715400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LU1zDAvgs3/X5OusvmBy3mFEzBMIiEAJcJaoHDIYwM=;
        b=sfVRPRh5Jf78vwzWboNEDxqaRa9FkkAQw/k+3kogDI5B6SsvOHUzm3Cl4Q3CILpyJP
         6M8K2Xix7FEPhkCMwvrKZH7+24szba6iuhFC+ZJjtUTKQ2tCKcobsyF7pbIg/zI6cYja
         BnLJKgI8iYfEeADbe4EwzQvqpDuzRKHyBUyZZ0xdmBHZE4Rh2RNxk66Erz28hNJh6AYt
         2nXjlqhAm2Thrjple+nCE9qFnI07SS2ZGw/+4p3MoqiP9kKWE7thDxgHriuKxpio0Ej2
         IMjtwVKpomxm/eC0HzwOpYVkpY+F5Jjr/Tvc/C89OxYz4U+EbZwcB69qupF+gg2OXm4a
         JKjA==
X-Forwarded-Encrypted: i=1; AJvYcCUzSqzEQpv2Qa6MeATwwzVVTmMXJetyAgDlTGO10m7DnlUwEC1IMXy56CajPvGlWVU3Qj4udyOTS+TjzL4=@vger.kernel.org, AJvYcCXT3fr3RisNlsEcAFWKPm7Xcu8uPMP3qji3XovHkfw9QahbxwbP08FXyBopI39ojbsDGKlPoC/9KEQAiG0xhXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTWTQ5FnKAaq4EQ8WCp6Inn4sscCGXXNNkj3PADk05N7md+HjA
	hwq8Dh9M4bcvjnINCiCPPJVmsim/n0HCxpLR7NNRjg4srf6BcFzTXTfBqsM0ZUntHg1lXV8IalP
	3bMnSCkKRAdW5HUYilYqXR7ItJMk=
X-Gm-Gg: ASbGncsXPIidHeKpZX4z3cat/jxyMM+vpLtIgislssqBQDYN2pRnISI0vj7+RCUhis/
	Hok0YfF7ua6WlkXB7fp4qq0lKX+ITWOewawfTlw==
X-Google-Smtp-Source: AGHT+IH5+lViv+6PstZSAVIysWY0Uty1Sv5xRkbV+fAiGfTDntLJaDT+EO4gFroRKbxJ2QF2Q7DpoMx0vfZISYXCCfc=
X-Received: by 2002:a17:90b:1c8a:b0:2ea:bb3a:8f09 with SMTP id
 98e67ed59e1d1-2f28f860e10mr2006224a91.0.1734110600256; Fri, 13 Dec 2024
 09:23:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-rust-xarray-bindings-v12-0-59ab9b1f4d2e@gmail.com>
 <20241212-rust-xarray-bindings-v12-2-59ab9b1f4d2e@gmail.com>
 <CAH5fLggwK0LXAsBnP3FtFHCnEzzBNNZfsCy3iJ6w=nT07CHgVg@mail.gmail.com> <CAJ-ks9mTEcRg6=ZiYFX3ebHSYgMwTv692ufUdTCoA1vX5E1nNg@mail.gmail.com>
In-Reply-To: <CAJ-ks9mTEcRg6=ZiYFX3ebHSYgMwTv692ufUdTCoA1vX5E1nNg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 13 Dec 2024 18:23:08 +0100
Message-ID: <CANiq72mvQAmU4HAypfh7iwX1DmJg48wHJU-sr+_Jg1M3n2GUzg@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] rust: xarray: Add an abstraction for XArray
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 5:25=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> That's a fair assessment, but it's a subjective area -- Andreas was
> fond of the approach (in a preview review).

Some things are subjective, yet we pick particular options and have guideli=
nes.

I think we should generally refrain ourselves from making code
non-obvious for others that are still learning Rust and its standard
library, unless there is an actual advantage writing the code a
particular way.

Over time, when more kernel developers are somewhat familiar with
Rust, then sure. This is also how other features in kernel C have been
introduced.

Cheers,
Miguel

