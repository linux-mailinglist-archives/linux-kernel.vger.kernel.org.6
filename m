Return-Path: <linux-kernel+bounces-446105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A7B9F1FEE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49F1166731
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2127192B75;
	Sat, 14 Dec 2024 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q8Slv0cm"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F18193094
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734195272; cv=none; b=e7VJoW3rsip8H5B1bnav0fesSni2MnGEKA+QiSsGVeou3BMV7BhmP0qh9iVBWl++ETrKMgoJRgpE1Ld+YRBrHoLnkwL/I4j4UYN0fRwzWnB6Fl3r0X6nHrxqmFVkf0/DggYsijoMcYoEoHxm/qfmpXm3iTrMKyLib6R3x/Hlhks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734195272; c=relaxed/simple;
	bh=PgibwtyBOqL+PRLjUN9sePmURkpYK7LM47le0yK1D4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLi8iQbPnNekZIfG/rKj2RlnrjUAD8M+D4Ye0cAQ7w5YVptOY/a16kEdFelZ9CGqAMrOb9RiT0jRezUUeuqqm8hf5a4CfFAggWDWzDTb136v6IOh8DVf/+cPw7bFEtbgc3nqeEEDF/IekUJRI7NrIMB8OBKupploxOzLLeCq4BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q8Slv0cm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa67ac42819so452449966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 08:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734195268; x=1734800068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H3BPgW74v84EgngZMaqM6VO7t79ywSu3q8xW0bx365E=;
        b=Q8Slv0cmz4h+OuN0j4PXKHzwvFxvfF5iDwxXu5N5QMQzdYGPC5QBdKX0IOisxjjG7v
         wSGqlh5UMg56RvbGZvm/Q5FAFXqybIdxYhegfhhV5kq0DymLLF+Am723dbGp6+QeYGV2
         laaPzpIzb/2GYj4wYwnrNIl1zr2CeZa08O4mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734195268; x=1734800068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3BPgW74v84EgngZMaqM6VO7t79ywSu3q8xW0bx365E=;
        b=ZygkQPVavR2YEJRyjWzYvWtdWLujUAjnD2IBkO/rSsPOW8zOY5iZ3/RNwd89itXNVr
         ixVk5P3Xnw9bj7/fnb8xSj4ykKjrKu2umoOJtaQdarJK7z8WcD6LQBdpVT4D4KREp/YI
         QWjaGWiAydCfLeHVTP+8Sg8eln0yQbjJ0a8pWTbPmnPoieQoD/e+Ky3x/ZMaQASZHFa9
         ShbVlq/91RDAu928HQcZLtyYfX2NtsBZ9SMTijMJPw20332xRTx6sWyMmnrOrAeE4yb6
         kfK44Lhugv0tAUzQ56CSXdfm9GzNJgVgVtKuuzUrfcCbrrW4EDxf+zqXHwvtf+yiT6lU
         sblQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/BITIYKtEJgSsTpkqa4N7uW+dM442KIa9CVhLicVVdAe5tJsgBMOwqpT8wep15UowQXnQWFOfX9zWeps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaiLPrVT1A1eoFycyg3aGT9ZqEiZNjQFFW1KG53dhHzNrzUcAM
	jfVy/XAivdYF44NsAkIJQDryDOaODZezcf5kRwxEKwqH0WMZFSRIe+7oi+Adg8mq/37nnvFGnxY
	8u28=
X-Gm-Gg: ASbGncsnsvXTJvEDwVOtP5+jgFuL1w8Rlja5RcYq4XEZmppivmsW9Jjlrvw1V4N6r2q
	xLAkRf8yG0EC4sKS8faInHO/8kuZNhe4aVgq0mdXuafx1OICW0jheNPnxDYBtb1PcsyEw1SHjk3
	9Hht9FRvd4ibNNwKIm+OHLzpcopXwXgdPHC4qnx+rr8/WiiZzN5E+xysw2yjHV/9jsc6aGHul5h
	VoitmWfRbZRS/rQw9sKxZQws5KJJga1R4KniaPXrjFobBovwo8U7iOE0GNIF+Mk67Cw2tmXc6cb
	C11fnG0ZfvbIIQT5r/dSmT8LiYtADR0=
X-Google-Smtp-Source: AGHT+IHkQuR3ZGDOvQoDLBr9qpRH41lwmZ3X8rX90fzj0xkenQJDlkEq4aAxKEn7dVjDLpBRUQ6IxA==
X-Received: by 2002:a17:906:f585:b0:aa6:5201:7ae3 with SMTP id a640c23a62f3a-aab77ea5c47mr715054466b.40.1734195268286;
        Sat, 14 Dec 2024 08:54:28 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96359b58sm113840366b.103.2024.12.14.08.54.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 08:54:27 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa6aee68a57so406441766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 08:54:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEq1hSW/O6p9T/AYi2MjkJNwTgkLkXMfS/HazM84uE0K2rcYBB+pUldsHtu4JQKa2DwHzMbqvQ2bRhroo=@vger.kernel.org
X-Received: by 2002:a17:907:9557:b0:aa6:6276:fe5a with SMTP id
 a640c23a62f3a-aab77ea5907mr622880666b.43.1734195266679; Sat, 14 Dec 2024
 08:54:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214065217.195385-1-ojeda@kernel.org>
In-Reply-To: <20241214065217.195385-1-ojeda@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Dec 2024 08:54:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgXdJswe7JWZ2G6m11rL4Yxatrz_iFBKpqCO5xHPwMyJA@mail.gmail.com>
Message-ID: <CAHk-=wgXdJswe7JWZ2G6m11rL4Yxatrz_iFBKpqCO5xHPwMyJA@mail.gmail.com>
Subject: Re: [GIT PULL] Rust fixes for 6.13
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Dec 2024 at 22:52, Miguel Ojeda <ojeda@kernel.org> wrote:
>
>   https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.13

Hmm. Is it just me, or has github become almost unusably slow lately?

It might be time for you to mosey on over to git.kernel.org, and use
github as a backup rather than as the primary repo?

But I'll see if I can reach out to any github people and see if it's just me.

          Linus

