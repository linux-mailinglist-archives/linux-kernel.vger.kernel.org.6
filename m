Return-Path: <linux-kernel+bounces-390190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35E99B76B7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C3D1F2433C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9F3170A3D;
	Thu, 31 Oct 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0c1NRGGX"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D968F5C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364424; cv=none; b=Dhb+WSTLeGydqHAgRc64PU36SjyHCQrAoveREl40nq6gR1G6c9KYOqDUTZbAuN1Q7S/V5UIaf7sb8fGk9AHiBrRIg5LPVFnMNl4KnXnv2L4kNS9g+rU4Ft6I+Etip/k83/Vz6gLPdtAl/vHzgyreyG2W0YLJOVscut7qXbHVLw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364424; c=relaxed/simple;
	bh=0D4tVlRd687v0ISh56LHhdh4/Xc9l/Gat0sjfygQ0DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMB0fyJdSIrUfNQ69jc5S5/YvA9VYffWQWIOLw+0kg0tnICVi++n8NjcMSCgxqiQZCrjHMRVqU8ILeFYu9KCX7ol1YlBO1b14vzL3oPvyIdCHx9+uXkxAW5k22XhaSUufxqXgpKt7yHKVWFrKlGCwuHo1UGixQEKuOCINiaLErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0c1NRGGX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d533b5412so436858f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730364420; x=1730969220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0D4tVlRd687v0ISh56LHhdh4/Xc9l/Gat0sjfygQ0DY=;
        b=0c1NRGGXR585JoDEONKwdw78UWZX7CFGCy1WmkcAFY1RYxnQVsWcmkyJnjOJtTO60n
         4AWFdteYfeqG8GXVun4D6YvrnOrLsKANfm7cQ0wfO3dt2+OmTPAQDRQO4l4MUakQRlBO
         OY9kB7tlZpVd4aQw53ybTVYpCQPKl4oU7f2lQt9tUHRuOumQCHik/OaOU8Gsx2oKnBXE
         zMqCK6QGPCJJ70eLj5TEwCDvlp71X7Pe9GQDTUX+XoyTBCCIl2T+OY41bvj2ABIgqLWw
         DjJKB9Ro6H+jnIeugSitJ+00vx6PgnAlM8bgl+1DHVcl5IVRQZ5+X+6skkaGQrjLZQXm
         70xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730364420; x=1730969220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0D4tVlRd687v0ISh56LHhdh4/Xc9l/Gat0sjfygQ0DY=;
        b=lknk9KHKDqtG3qOyis7EIhRZt3kbZ1/RSr072MsaQKgHqmaFzYxtjz14jLBAGsWhfK
         BX3eXlETcB0WKxssxSb1XOzJyIXZUmVbGt+mZ+f44ijOFut19J8j3UhiM7y6AkeQhiiJ
         HOwkLfaNa9F48DuaMGHXYBw1/AxsBKDHb/DDEbxT5b/d86ZWOwUWgK/wDasyF8QkMbkM
         sau1rNQsSf2hYfAqNP8L8rxx2JrUtuznxelHojbm35gULJXOCuKUTULo4y45MmcpqEQu
         kIUDyLasdxrltrF+N4g5cydlBOQR/DWvyWt+uC7Yeb+aD2lvwgh4hUJd/xUBxZ+Hoh/4
         6ipA==
X-Forwarded-Encrypted: i=1; AJvYcCVo0wGb9bLEOdChXxWN+LTgSUXYmyRYCgJNrrTuOThxZLP5sgPkiLDSwruYUAjoarva18A4zOkureH1edY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTws3Ef9hJUQB+MY587tHXU2pydb71vv/7IANvZz1rnR2xDQ17
	Dq4DkTxsEQuTw1k+a+0Jf5Dnj8WGV3W9EqOyGsih99qg3vGY3RCwolodu4Bh6ftHCmcGluBLOmk
	3Ea2yLQI9cghLdzxnZy+tf90aahQta2d2yPW6
X-Google-Smtp-Source: AGHT+IEdVuVJE104C7GRWDnjlwViWFa3jZJwm/j9uc/7w/AVQluSXMtXKgS/kWAB6Cvl+10e3bPt272n48PAR3m0zoI=
X-Received: by 2002:a05:6000:1150:b0:37d:453f:4491 with SMTP id
 ffacd0b85a97d-380610f81c2mr11857437f8f.8.1730364420471; Thu, 31 Oct 2024
 01:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com> <20241030-borrow-mut-v1-2-8f0ceaf78eaf@gmail.com>
In-Reply-To: <20241030-borrow-mut-v1-2-8f0ceaf78eaf@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 31 Oct 2024 09:46:48 +0100
Message-ID: <CAH5fLghmVYwNKPGrtHzUQXhEyxiD=ZyF6LNHoWUREWH+dpK=DA@mail.gmail.com>
Subject: Re: [PATCH 2/5] rust: types: avoid `as` casts, narrow unsafe scope
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 9:46=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Replace `as` casts with `cast{,_const,_mut}` which are a bit safer.
>
> Reduce the scope of unsafe blocks and add missing safety comments where
> an unsafe block has been split into several unsafe blocks.

Reducing the scope of unsafe is good, but moving calls to "cast"
outside of the scope is excessive IMO.

Alice

