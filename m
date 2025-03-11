Return-Path: <linux-kernel+bounces-557060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBFFA5D319
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E4217B6C9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4823236A;
	Tue, 11 Mar 2025 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvGZx69b"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C661C14F117;
	Tue, 11 Mar 2025 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735290; cv=none; b=PvA2U/uJHf+DN9rWIykNf7ed/RYFFlFx3WAYzRKT+S0/FHQ0PvdHW5tc/nmtwhWDNEW22y/OUt+eyNrXG3+6LWB7Fh+kQXs4/0/T5D2vgNNoHmzwf1SS3jugxvCHWmNdMULULnMZYtCpX0fFuqYL/87zAf7sXqQG5XY4qNqVg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735290; c=relaxed/simple;
	bh=OIIeemNBI1QQ1GSVApW1x16wbuS+wTe+mvf+3+Q3i1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcwhmjhC5cUIx+hgfBv5ZbPKLGZBsyYqL1aOWTWVEPoJG1xmb2j2pyHhrQmoN3USTp8/PTGSVARg3Bfq/taQO9hB5y7KPXX6ENSglNfwaHSo9s0DjZhMSC8y/P/8KqeM9qd9HVrFLkJjtOW1bn+P0k8KVPScbbQWxCqq1q0vpks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvGZx69b; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso1573609a91.2;
        Tue, 11 Mar 2025 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741735288; x=1742340088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIIeemNBI1QQ1GSVApW1x16wbuS+wTe+mvf+3+Q3i1s=;
        b=KvGZx69bQJRP8PFIyUcZdulCciAOKPaucH5aKExR4/dCgSz9pFIHYJbgSo5LmTBA7A
         9SHW8UolAIA3V+JshLy02mH4nWdDcwTZseQHKQKJj+SW/iDCKXbUtvYt2oV3C9q08y1H
         oKgTv/aArA0IN3GyWrbCgz0yv8LwcdMipP/77ouMkDOoDB7efO7+cr530glAUA3UMLwD
         ISue3zw/zoR0P3wCK8YQT/liPJ87HNSoWGBp2D8W/xl4oI4aYLNMMo2JPXvXljjUOmzh
         eTNG5n1P7+KydF/uDZpaSskHDbb84aGOqM5bERVhrBgLLX+w629zxlftv6Ug75utLaQS
         yTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741735288; x=1742340088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIIeemNBI1QQ1GSVApW1x16wbuS+wTe+mvf+3+Q3i1s=;
        b=S7N6C0/fLk41LoC0o7X+iUtChWcMSIzb4KjO8qpUpygTBewb/sCkYVvFrfvegf9K1t
         e6WHajwg1F5DB0ElBrrYkZzuVoWiIoUP9Zxs02KTfI96RDAeDLnuO9qM1AR84Ngl6yIy
         aHxeJXLjWr+cjQG9n/yrxMB6Brrdg/zFOWgLk5+qh3yZ8fa9EuV/o2ASeb0MKohXNzfO
         KpZitGz9b2ur7RtLdeM8zdMYw/P5n70zhvtKTQyYZT5l6wuO/vS5h5AHoRn45IU+8i/s
         qZ7DrFcaWkE8Q54koGMxJgqH2J2p5C/DUkmhgmYU26TeUU02fTN0RSyjpeaNJjy3gP/n
         ZDPg==
X-Forwarded-Encrypted: i=1; AJvYcCUANfU4j+P5rAIvFsDiuT+dwFrJTCzQLcdRONnmOM1EVXV4Sli2e4poI9r5DMU/nJejKUYxbu/InGgVi/RQIeE=@vger.kernel.org, AJvYcCWo3fbUo8+smXCm4wpXvaUfX9WS63WBZX8VAqTEn5xBNVkqIkKQpWTL/C5YCgpZiweYcNe3IH/6MzBD0aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE0euhEcv4KGp57zSRV4cIGJwWoXWdAvMdbMw7tRtmrMxOTIQd
	r7t5/knPJDHYSSuptu5kkCYUkQ14ykqTgfB2yXldE7bg4QvESRyz/1fsawNVPEifpyddDeQonge
	5paFkUHROHA+/09AQ58Xo4yrYqP0=
X-Gm-Gg: ASbGncueIeT9EWXwMhG5AmIAWGUBAgQgE5zHrExY8T35Lh+gWofBOs5oF1N4Z8Vp50c
	oUWghx5JZqtFUZyqWVmSEwgzaoaQ9xqIk22DeRxEaTGd6mMhn7ch+VurRiA/JclWL+TLQLQb2nX
	lXHJpaMDefgYAiTXe73bistNWTjw==
X-Google-Smtp-Source: AGHT+IH3z6DZ1Kx3Ne8HAD+wPpPj+j7Fd89gd82FGS05L61prHuJy/aso6TXotpUbuPvJrk93SOfVbrBte99jEMYyD8=
X-Received: by 2002:a17:90b:1c90:b0:2ff:78dd:2875 with SMTP id
 98e67ed59e1d1-300ff8c0db7mr2581097a91.5.1741735287958; Tue, 11 Mar 2025
 16:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-rust-analyzer-bindings-include-v1-0-6cbf420e95b6@gmail.com>
 <CANiq72mWZ6YDECjvnhGdWOGmVY0PQJaJdwY0sHJLc1h4p9B6ww@mail.gmail.com>
In-Reply-To: <CANiq72mWZ6YDECjvnhGdWOGmVY0PQJaJdwY0sHJLc1h4p9B6ww@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Mar 2025 00:21:15 +0100
X-Gm-Features: AQ5f1JqRvWZ5I3Z3M78hvKSgLxieGmaQ5GQvQLA-m9XFrqVRxVb4ADrP_NoGY3Y
Message-ID: <CANiq72n559pxR=ptgMz0QubAWOUUkjrWe394T8XJbkVeFZOWrg@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: fix rust-analyzer configuration for generated files
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, 
	Fiona Behrens <me@kloenk.dev>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, 
	Boris-Chengbiao Zhou <bobo1239@web.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 12:19=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Applied to `rust-fixes` -- thanks everyone!

Sorry, this was intended to be sent to v2 -- resending there.

Cheers,
Miguel

