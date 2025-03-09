Return-Path: <linux-kernel+bounces-553377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ED9A58855
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 22:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E6F3ACF92
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 21:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F278221D5A1;
	Sun,  9 Mar 2025 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj8XjnpC"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C11DED4F;
	Sun,  9 Mar 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741554240; cv=none; b=USqzJ6LkJzxi41LwE0RwU88Neh3i6hIIxPFMKGijHX7HBQKjjd8Nq2zc5yyJZQdlwFP3phuyEyyHzK3e7lpgjB0RoBeYyimp6RP0lf3rewAYD4guSkyHpxGSCWsGjMX2s33JaaUNDmSrwmLEAhOgOoosAPnhhpLa9lUT67G768c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741554240; c=relaxed/simple;
	bh=RA9W3oHlY4KJp+wgZSd8vSqJaduOtvWsPqByxgfkz3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Shw/VxGXLUla5MMRQe3+7ch2+8aXtvrxkwwCF9tni0BIzM3G2liW14GH8mXLcKPrtARLFPtXVepjL77V7uviAh+WEIw+R6ffKQz4ponq/yCHoiznw0AJUTKF4knRC+ohE5B2EwFGKLG7gbe7d0HUKHTkauAjWnUnS7cGmjD5KWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj8XjnpC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso993484a91.2;
        Sun, 09 Mar 2025 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741554238; x=1742159038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA9W3oHlY4KJp+wgZSd8vSqJaduOtvWsPqByxgfkz3Y=;
        b=jj8XjnpC93Xpk6yIrmXsXnjoxFKYS6153TKDBZnxZ9OgJ/U5pR7vZ8uKPc0nFjW0AF
         mSmMijBExdBnFr2WJGSyyIwnwsXxLKYxMxGJoVsM1B/NIR4rNX4S3sYlBanIlIfkj6u1
         Ep/N9sUy9hFKOnA+ptmx6zC+VXcMO/3bEHzyJkt29RPS0Y8qPt8h9OLE7QN5KXv2ifp+
         +ceUDO2vL/6BBGFA2v3N27/fGoaPCbwluRKP4CwavyIIpmCHbBJ6Ssv3yvGh5sP2PHic
         ZZjPLtJvZzKm4nkEkMOsPnNvlBnUqE/e+Rba+DykVYjYY6Dt3pOsi7CMA8XyZDu8QKxG
         ZPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741554238; x=1742159038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RA9W3oHlY4KJp+wgZSd8vSqJaduOtvWsPqByxgfkz3Y=;
        b=AIoCTsyvIWM35RsicKgCkUYrFLLCE/ruQgxH4RRo8pCJjk1htmQiWsK0AYQkA/C+9T
         PWUjeOLWQospIgIYN96y26w2178proEKZ+StKcAw85YDCmDxKhnZ47YW9V9IZMikLMVa
         UQiVaQ4fja6edVzCHKmtxbNe1+CbVyBsp1YCpjZu/lDiXCGsd7vCzYDhoayqPAbidk7j
         drXvGannNDkvpO5KP+jLFyli6ju/xPs6X8WAgrVuOXF0h+39yaYuq4nUghhaBhlQp3FR
         Dvn5XGEa6mfYtksINCRJWSZVSiT5iyVG8z09DPJd2jWGQ6sANW4VhIsfPCDmmHm7wuBX
         UapQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAtDa7khF8n+NH3uJXyUvIQdDzOIL3QxOaGsPBrn3BQgasIhmRUWEGJKmjAubvJsHrI5EEZl1BbMk7N7w=@vger.kernel.org, AJvYcCWotNbZ2nm7A9BFeCKLTmorf2oR14zOT1BfXNuwNh/a3iPoUEoUH+cte+SBGkjMXC2IC9bCKEfAbzUHpAFKvrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvh2sS4KQh73d/4+7dHfZDgjVVnjRPe1n0aMFU4mCmLCZ97np+
	KHveYEARjTZrMM/56E/RZu0nZieSb8bkwH3A6uN9JkbJzQnRtCVtsLGA/1k5PJ2G2JN/qzt4ElY
	Bmn3zaoxvqHesyG06mhssv8e7gOY=
X-Gm-Gg: ASbGncttM0H63MM2kQoLD9qqncY7jxMNA3TQAUQAVKZqaCp4mbMGg2g8UFgnB0BzrkR
	MG30/nBu8DxVPN+gGGR1zWwcRXKvXybLkp/1TMZWIcw1fxuvNSuERctg5svKxfUFdG8FIhN2vO9
	pkkHOh3jvyJH3Yw/YT40cvOudn5A==
X-Google-Smtp-Source: AGHT+IGCY0kf3itX3GXBqDkNrWc7YC8LPUxMdr3KN1AB4Ks358KFkmPj4YxS7gWk2MA75UKS7Y8rIBZW5UXeUuT6vgQ=
X-Received: by 2002:a17:90b:1d04:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-300a2891b9amr3882801a91.0.1741554238370; Sun, 09 Mar 2025
 14:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mWBrHpv9XYcBbVsJkhH9SzM9N4fcL2SqoNQ9X-4GiZbw@mail.gmail.com>
 <20250308004019.655958-1-trintaeoitogc@gmail.com>
In-Reply-To: <20250308004019.655958-1-trintaeoitogc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Mar 2025 22:03:46 +0100
X-Gm-Features: AQ5f1JrsbZlkeBDbv69VoVRS4FHTFjREsGGtvDCIzH9Tn-mcT9si3YP-krHfddQ
Message-ID: <CANiq72m1NW7UVYD8+bt2bYivb++pR+7_2P9NooAcLX4zjKWkHQ@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] rust: module: change author to an array
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk, 
	benno.lossin@proton.me, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, charmitro@posteo.net, dakr@kernel.org, 
	dwaipayanray1@gmail.com, ethan.twardy@gmail.com, fujita.tomonori@gmail.com, 
	gary@garyguo.net, gregkh@linuxfoundation.org, joe@perches.com, 
	linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com, ojeda@kernel.org, 
	pbonzini@redhat.com, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	walmeida@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 1:40=E2=80=AFAM Guilherme Giacomo Simoes
<trintaeoitogc@gmail.com> wrote:
>
> Yes, this is the case, didn't change anything in this V8 in the rust side

I think what Alice meant is if you changed something from v6 to v7
(not v8) -- from a quick look, I don't see any changes, so that is
good.

> Well, now I already add the reviewers tag, I think that is not a problmem=
 here,
> right?

Yes, it is OK, no worries about it.

Please also avoid sending new versions for very small tweaks or very
frequently, since it gets confusing, e.g. I had in my queue to reply
to this message, which is v7 but v9 is already in the list... :)

Generally, you should wait a week, or at least a couple days, between
revisions (there are exceptions, of course, but this is not an urgent
series).

Thanks!

Cheers,
Miguel

