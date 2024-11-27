Return-Path: <linux-kernel+bounces-422961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F589DA07E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 02:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF4BB2206F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 01:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F241CFB6;
	Wed, 27 Nov 2024 01:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gdMTQTzW"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EBA14F90
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 01:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732672662; cv=none; b=ODaJJqG6noFO/tUzlSzUtYd6xRXYhUYOSh0+AQauqSfEx4MjRTKqacbWoRDUF8jA5pPJ+q/WvV9aQecGEoY3Lh99eOM1ixeuh+yTwolYQQeYEOvHMc2O4GNWtoEpdqDyUFhiAeEHfYnhUUAlrH24wIlaKqbqL/eXZgBuHlfipWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732672662; c=relaxed/simple;
	bh=ksWBzgOTRRjiMqwQKS27FxHnZp3t+25yvmXBAXJZHto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GX+tg9ulFlk4s6cME7Ikxr5YhYyIxfzE5L6FaPVGP01PIj6+lYImtR66epDBOs3vU3XoXU3sNCkXqqY08P+PT6alTyTkIGfv1DjcF2G2oVlB/fU3gv7Z1qsDka1/xpP4bYr6x1g4TmWvVxPbH03Y6tD6SIMdAdzp67+Rz8X4F9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gdMTQTzW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-382376fcc4fso3815639f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732672658; x=1733277458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GOqSZTMOEDNxx064Zu6yp+hRM+WY+GJu1uiInvQOD7c=;
        b=gdMTQTzWOVyfZ/XgpDLg66r79SAjGd4qH8rvaSzVHAPpMpFF97rcnHIilENp03RUHH
         ZEo6TOTqsoep6oeGkgC49vcd9FftE41a4DcsxSEsZqiIRLotiKqXFkkvq9ciumra26XD
         CCvqNvkIYnMZeJJjkA9oAnqdCUSfTItJkKA6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732672658; x=1733277458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOqSZTMOEDNxx064Zu6yp+hRM+WY+GJu1uiInvQOD7c=;
        b=Z1Cin1bb3r0HY9k3shn11LG5Mn3HJ0LYyidbTuSwjoVhQfH3Vh4cRDj77RQwZD3qy6
         lSjjtmyXfLUEqsf09J1pHWK74Ail52FtV4d2M7fd7/9ICgkP+F0ua187OQWNIJwhQqCn
         thTwRyFT8HlQKT4NnQOtCLI984Yj7HEQQIq63kWXt74DW8GdqB32EI5N/Sxkr0t40KJK
         d3Bb0Nxo71nDr9ARB/hUt5QnMoa65uKn3fs2Vw9e6C7Bno8bZthiXcmz1iUD2pXFIpo4
         M8ik5OlgbF9FghVdQk4u4MYJmqBUDXiXXKEk9jyCSCq2Joz9WM7+cqEQ/bcpBKfDarvG
         Gx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkSLhHi9mYTiPh9x6Ic3WcA4rKNxtK7gk/gMqO1X0xXsMlg9PYiYFWGyPOLp0D9sFgp2c65e2SxedgeX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYPO1kqXsQUtcftm99Av5VmeYdIPfb2FyiByQK9HMaL1t9+8B
	BmDk1DqTfZ+73h2UbzHyP24lpKTyAVjnlzkOlWKE37gWjxco6id11Z8g0+nf5k29MbkpzdqYn24
	ec3K8OA==
X-Gm-Gg: ASbGncsDf/b5ZsM8Dby/Y4rWO8olbFMrs+GyPDZyG/e6ONl1OrBXMB0+3zuKbePLgCE
	RdLmuGs7jSXsJwDM9b5nrHbKM9BJMwiomU9fAblp7d3+3UylOlCqYunWFWaYHyLjqZjgMIjwXWY
	zXFwVkRkpWIsH2f/Ciy1Vhxz8QtKRk1dPhqPhTQ4Y9j9Lc8z1Yms/g97GidPenLa5PpfP8OrHCL
	BA/zuopjXSQsQ5sbZv20BrnKXeqSuaDooeXxp8iuYVM21BrwUQx7rVSx/OrwkrTWW6hq88nI5fX
	0IUoFOONn1Su27ARcuTmapwo
X-Google-Smtp-Source: AGHT+IHyr6NKWg/kBFvEa2w1ftsRLc4Sp+MYvuqaMsCtsRaODd4JwWpH3pxqtF67v6rWu2UZQ/8rCg==
X-Received: by 2002:a05:6000:481c:b0:382:4a84:674 with SMTP id ffacd0b85a97d-385c6eb7ffbmr746046f8f.6.1732672658309;
        Tue, 26 Nov 2024 17:57:38 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f5322sm652793266b.70.2024.11.26.17.57.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 17:57:35 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa549d9dffdso463261866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:57:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5Hd/3LDiifqU2ar6fCLFXqnpOAVA0JJaXHTqwOuYZG0aGba81zGXKN8GNiBEPWbMr+gI8gPfJisUTYcY=@vger.kernel.org
X-Received: by 2002:a17:907:7742:b0:aa5:152a:d0a5 with SMTP id
 a640c23a62f3a-aa580f2c2ecmr68070366b.18.1732672654818; Tue, 26 Nov 2024
 17:57:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126022500.718070-1-ojeda@kernel.org> <CAHk-=wgRSWz=5e39P3Xb8FmsD6Qa-_LFBTs1q2m53yrw-yCSzA@mail.gmail.com>
 <CANiq72nqyFHkQFRLoXSA5BEvgNz_8iOCK+A1gU+2ubnJRd-OwA@mail.gmail.com>
In-Reply-To: <CANiq72nqyFHkQFRLoXSA5BEvgNz_8iOCK+A1gU+2ubnJRd-OwA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Nov 2024 17:57:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whv=DZ3beoAmKu8F0LyHr9shYR=5uqgo2P_EQia825W7Q@mail.gmail.com>
Message-ID: <CAHk-=whv=DZ3beoAmKu8F0LyHr9shYR=5uqgo2P_EQia825W7Q@mail.gmail.com>
Subject: Re: [GIT PULL] Rust for 6.13
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 16:19, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Doing the latter would leave you with what linux-next has for those
> `use`s. You can also move the `ffi::...` one inside the `crate::...`
> import and run `rustfmt` which makes it look a bit more consistent:

Ok, thanks. Done.

            Linus

