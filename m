Return-Path: <linux-kernel+bounces-387481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9239B51CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A8C1F21913
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1323C200C92;
	Tue, 29 Oct 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0GGzwO6"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF211DB375;
	Tue, 29 Oct 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226609; cv=none; b=MuPGdYvO9wiJMYDi46hMAJLfbNbrplfCRxqeTouolL+syeRXf1VoeLfncYRbnZgbb6LBrerFNWlQoEB3b1R4Mg0RLGdQwf3M94fOj/f3XQeAnGJUDfC+M1gvLnmWc9DYI8mbEhWTv79aF9e5liNElqRapxaNJnzmeRUFth04wR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226609; c=relaxed/simple;
	bh=AsK+V9h+B2iwFQjjk9IGQoIbaacgNFVHv5zrTuGaT/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrgXqoQTyQDJ9Z1Ou55UvnkmQRjwOl9CUfd1T03wnyHqbxCLMDsIN+byOXkTGh0DJDbqlq60cn2e8kCA3WykypqADyC1y5CcSoWG+JIA5bww2Nqnk3Iidpcs1g+AbPZWcRO/bund4167iR1mjI1MwIV1wbGC2MLNj8VfjspWAok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0GGzwO6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea535890e0so698797a12.2;
        Tue, 29 Oct 2024 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730226607; x=1730831407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsK+V9h+B2iwFQjjk9IGQoIbaacgNFVHv5zrTuGaT/E=;
        b=L0GGzwO6tr2gmIX0T2imOHEszQ63DoZrAXyyeVHLc0cu4oqIWGSsniKDfxY4hA6lWn
         JZLShHVVE1sDOvWoI3TctH4i0mf75tbbHoebspPZzmVTTkljsWMjDMlF1FZZeI9PqvnF
         /i3/u79Tm7adgtheCGc6ug63AdhCmv1oGfRPF5HcHUNfuv5V9q4ViaWJiilKv7gTowq1
         w65MVyKcQpML6LViDZO9eblcNlheTXvk5MXWHnJcCMDZ9Nv80YR6P7pHNlEW9/bUn/Px
         PXYwn2HC+/QukYM/UheFvXXCpJbdq0IomzAmwSHpAxU9FPG58qLpinKkXVebNzkosP3J
         Puig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730226607; x=1730831407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsK+V9h+B2iwFQjjk9IGQoIbaacgNFVHv5zrTuGaT/E=;
        b=LluVKwI+6B9JAmluvp4+l2kcOMw5+rm1F+1t5QLBfHATJmwB+PT+ZRyPs0wMnz9W2H
         moQxu6n3yssH6c8EJtLo9cAyDqzEJBqhyHHnLOo4M9gvaPzn0cl5qmnEWDo7cYLWlAJo
         e6mvdVgo1B07ioHwSS/V35wAt+b8bvLuXV5UsBVyXwNyutIk/oU6pbsxVPLpC7Nk126k
         FFqYjgkLDowbxMj9k0uDd3Ri+fEkBbiXDZDV5G4IU8Gt7WuQwIXMyfMlBl1KHjxbKovF
         MpYjrptNprvQy1RzVlMtsXQfWQJEEgW6/zWkSpqmJ/Cqi0bTDQBGDMPVzVdwSPq4Lktw
         lbUA==
X-Forwarded-Encrypted: i=1; AJvYcCUE39DZGW3cvn8rITsz0FbvFRVrs1zVd+gE3vPBQEkdCA4e2s4zu2GEFeoJ3s0fuNX83XsKDCK1BYZU@vger.kernel.org, AJvYcCUyTHLB2P7oty1Z59P4Bs1jsF1auQSjP9C/LL4btD60lBMropKQ/X40CyRdhD2jPl/UslG1x4UCuSSsCHkk@vger.kernel.org, AJvYcCVKPre64+fb1Hu/mq+S1/eLjkixNkGqirM52Mtnso/Ho1rzZfGZRoU2t+tRRLENDC9GTKT9+Kq+KRToF/InIr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+gkUSLl4ITuqxRRvLWnMtpnYyxYZNZIztifc8IAHAITGtcl8i
	sxznS9nf4P5eKMSfweXld17JK620MSJOgMP3xMoHAAI+ohs8Oct+5vPVLeQkv8IAXREilQQ7d0Z
	ayT9e/oC4876wM23FseKYo3sImKU=
X-Google-Smtp-Source: AGHT+IHJQghLABmS2gIhLis8FSQRrsVGERtaxOKMLTernOVMHA3AjEDMajT1qr0GJDUeXdWp4rWn8id5I3hLeVrdAmU=
X-Received: by 2002:a17:902:e812:b0:20b:7bcb:5c63 with SMTP id
 d9443c01a7336-210c6d30b04mr67872535ad.15.1730226606814; Tue, 29 Oct 2024
 11:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org> <CAH5fLgjhiLUYPgTt_Ks+L-zhWaQG5-Yjm-Y3tfh2b2+PzT=bLg@mail.gmail.com>
 <CAL_JsqJWPR-Q=vsxSvD7V9_v=+om5mRuW9yYNqfavVRUwH9JFw@mail.gmail.com>
In-Reply-To: <CAL_JsqJWPR-Q=vsxSvD7V9_v=+om5mRuW9yYNqfavVRUwH9JFw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Oct 2024 19:29:54 +0100
Message-ID: <CANiq72=db5jQhup8JGZT3_93orrVQt-5pwPvSQb3k5j-eW7rdQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Rob Herring <robh@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Saravana Kannan <saravanak@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 6:58=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> I really want a build error if the type is wrong, then the _ case
> would be unreachable. No way to do that?

When you need to work with a set of types, you would normally define a
trait and implement it only for those traits, e.g. see
rust/kernel/transmute.rs. Then it is a build error if you don't
satisfy bounds etc.

Cheers,
Miguel

