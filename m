Return-Path: <linux-kernel+bounces-446107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ACF9F1FF4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4DAC7A071B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA0219E961;
	Sat, 14 Dec 2024 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RmCaU2Tg"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FD9196C9B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734195570; cv=none; b=CzxdM9EoFUQHBpI1uoiqiLvwuVtHM9W3SFdo5osDoRAqBKp0VVERTL7M1Ehi+MilHRdMn0IhRNWPfMT3f3RfznerzGzWrTrNag/j1ilXijcFWFzd/PtuMA53TbDK7CaJQ2UGbY1Cd/aj4XhK+cfHTNPAF+qyOesPUbFORujkLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734195570; c=relaxed/simple;
	bh=VpwhmVuFREzWXVXH8gnnNco4qEiGRJv9gM39JCdSzBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oU74ERp2J4IH1mmC22t5vAZQo8NQ8zkyz9pumyBU7Fr7h44VdyWLIq2mi7WdI3nUBNdyqmHrEl1jaHTJ1jvc2ZOlxt49r8OKnnnfwD7yDSs1GaVWzVIUrUiyZ7RgZafgTARaLz5Ep38mP17hzWlBnChunzFhg2Aea0osrlR4r4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RmCaU2Tg; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ec267b879so443806766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 08:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734195563; x=1734800363; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ6dwpHnhWlqcuUvdCT/LS27IX2tWCaBK6lJ5BI2H/E=;
        b=RmCaU2Tg5lZLvfiEvZqpFyXTBHzpbg3XGsu563/fhZbzlYVM4Kv71JI2uV1QineC9H
         e9iKRhf+T9iBdz0cgCd9hbZyk7ghfTDr3GPEMwtjnbLcmEIzUe1/79sg3c9ct81BGN1Q
         lE++Gbk334D0/Ap6AGJXK/kHqQJ0XzR2+0crA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734195563; x=1734800363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQ6dwpHnhWlqcuUvdCT/LS27IX2tWCaBK6lJ5BI2H/E=;
        b=jecYcqTV8MtY0ATNu4NTRhWmFuKc74D5SpFc4Oa9Dg6CW19ER4GRNrmNObYAykYvQr
         ShEvs6SJTw8jvW3a1KuNGJCk+U+6DQcisC12TGQ95S5Y5FJviLtD4EOUSr2nHJxq/ETo
         M7YrYMGS8WshQb4epMFnSzQJt5j4AYLzGYzHjvtusNCvZwWsMhIEkQ6zQ9V2s5fAVebi
         txX32RxYP6mGCeTRz1aq9mnVtaj1YCfOb1OSTAjzyAAffSDGp26kBc0xq0BBB7S3mn6i
         mmvua7R+PmG9Tp2WW5Tl8DyTR3yftDZ8i0q4U/wpjh00I2yTD8l5ilZuK9kY/sOBv8pT
         lYJg==
X-Forwarded-Encrypted: i=1; AJvYcCWUEhOb5LEbM/qI2nZHyj/FCSjEX8B78hjPjOpifaQAWB3cjhMQMgLdl89kuUr0QSPFRrsLqQne7HUh0Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj/SQP7ti3Gjq2H6saWwKweeupg7Wa4Htu/c28FKAYJx1jn5TS
	v+rO69f4dW4Dtog6VTlUqvVhzuN7DvcedVSw2LMFmRgPQhVnQP43VmpeXnqpJA1C7zBbR8Om/me
	n4dU=
X-Gm-Gg: ASbGncuVltolcX2XNGqeAOZrG6SPxLFLJwgNpeN6g6EzzXolSpfdvVsX5lesa8mXmlX
	lqCnz2C0Fq5nl4W3g5u47+9/keaEHp536qlmHAY5GOGM3GPTlbTLY/YdLgBs6ALUWw3Hhxj9j5A
	00kPgzIZVdJoXD8pabPmKlyJRTLlDY7yCaYpk9rUW7fEJ6tI1QY3gp66ABWIa2iBjLNlxNYg5+C
	9LHfkOXN6aJ2ApuO/2Rn0ufigwMkbbBd60/sJnp6fCFqAdr+0/Ce8BFo9WvgZbbPKvcv7VzEzT9
	u56GjecK61IFWw6BxKN4urgOUdoy3qM=
X-Google-Smtp-Source: AGHT+IHIge6xwXugpGlCQMX9U9QQXGagIIcy5ie4AOt/+1YaEPjRpkAuXjuC3hAEKwxfBIXfYNv8LA==
X-Received: by 2002:a17:906:684f:b0:aa6:b1b4:520b with SMTP id a640c23a62f3a-aab77eaf4aamr677732466b.58.1734195563182;
        Sat, 14 Dec 2024 08:59:23 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ecb7sm111530866b.155.2024.12.14.08.59.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 08:59:22 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ec267b879so443802266b.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 08:59:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXGpx5ITXIFOmdhHW7gLD7mlWB5ghOfw83KKg77VRC8D9UUf9Lv9KTlohh1l7dVsMIIN9QaZgDF2Lkq9Y=@vger.kernel.org
X-Received: by 2002:a17:907:2d20:b0:aa6:b5d8:d5c4 with SMTP id
 a640c23a62f3a-aab77909d77mr776435366b.17.1734195561732; Sat, 14 Dec 2024
 08:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214065217.195385-1-ojeda@kernel.org> <CAHk-=wgXdJswe7JWZ2G6m11rL4Yxatrz_iFBKpqCO5xHPwMyJA@mail.gmail.com>
In-Reply-To: <CAHk-=wgXdJswe7JWZ2G6m11rL4Yxatrz_iFBKpqCO5xHPwMyJA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Dec 2024 08:59:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiHC9ATW72NVqM64kFjcO9BhMR+Hh1oLJrn0PZ7xcK3LA@mail.gmail.com>
Message-ID: <CAHk-=wiHC9ATW72NVqM64kFjcO9BhMR+Hh1oLJrn0PZ7xcK3LA@mail.gmail.com>
Subject: Re: [GIT PULL] Rust fixes for 6.13
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 08:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. Is it just me, or has github become almost unusably slow lately?

Just to clarify: it did end up working in the end. But even an empty
pull - when I retried the pull after merging - took two and a half
minutes.

                 Linus

