Return-Path: <linux-kernel+bounces-342791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B00098930B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEAF1F22B1E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F5F22611;
	Sun, 29 Sep 2024 04:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="jc5FU52a"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004AD33985
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727584923; cv=none; b=qOib+Scz7wqLjVQB4eGU7WY4sCTCTld/2/3FmeEKSHFCiA+YHIL1g2XQppFVEdHUNX1TH6nrLLJyWGr2/QbKBs4z3btcZ8TXrA5c1C9+XP7wyYYc0CARmu0h9WqnI6mh3vI/DNGoOfc8RZEVRWnWsNuqzyce8rSS2pbo1yqQ0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727584923; c=relaxed/simple;
	bh=vHzOMj9jD9kuxpfdw0bcPVwZ1W+/Pn85ztnlnrksZHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9d0zSN0cBSJpiPucLEGFGaUspvgBA3zo1d2e8wWY7yqXkcx/HzgBJ/o5JKBX/62HuNsyWFp+SSfUaVpntrn8y+A8bkcd3QUWaOlKvv3wIJysAi0/qNOzhqdmQ4RRK6cAnwjDZLgfHBYVOOZPvLWhajN97+4dnjIolUjFmNnuyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=jc5FU52a; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e255b5e0deso9917637b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727584921; x=1728189721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHzOMj9jD9kuxpfdw0bcPVwZ1W+/Pn85ztnlnrksZHk=;
        b=jc5FU52aCdmNijUbU9BoYtNWXUYIGDUhfaTRy0Wfpv8mYOQimPL4rpZ0aN5NG/hlzr
         BczpzloZsLRoM/lw3O/vBIAO1h9AeGJJS0WyZHLSCov5rX69aLfNvRXJ2lX9vaIhe483
         zkrOvmzLXXAbTaxQ2iS7p04J2KYybZt2oTcLhDX+jiY6nHiVRPxRVwjcDYo3ojciNP4M
         JULQHoprAdYKZg5RhDTsAb1qj/BvxUzl77FuVvYe+7WsVsWFoKNXfvaZhvnUj/N2JqsW
         wINX7x1WwPSQNUWkB0YjLlY5eLSewyAI0q/63Mw+Od3cDkqcV4kA9dZMzpcH/nIvLp1+
         uOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727584921; x=1728189721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHzOMj9jD9kuxpfdw0bcPVwZ1W+/Pn85ztnlnrksZHk=;
        b=aUwYa+PCxQgnzNeUhxdgaHN1YbymyBwPIilq+W+jj+1uUjj8QABhoe/uDLzckU42La
         ++RyCnB7xJz384VkJCkEBw95wfmsWMC9Bwa4GXKQaBuqiI8YXWl5zi/8516emzZbUu/7
         MUQspW0UxKaQ81Qi7JmRkbGCDnFjD/An0Uwe2VvPnQJhpRk/lVYOssfnDbUw7aJ7a8ga
         o7QHKhfVVXZE6Q88reeBBF1zQMt2p8tdTv3Xs6iu2TtzEg5FkXKJDsARfKIYT7QeMlZu
         ohkP0zqC1VZYT081GvFnaJg8aTQ9xAp/LJSU+x+zjqHnDRkwKDHNJEkEnDtfqrjzGGcZ
         UpHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRzVWIvDQGxzyBx6yu/yaQ7QQzQJPyfa+MU8q+WiM/pKVo+V4uMMa4nPwTYUrBt3bHkg4IrsENLG7qbpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmvNILIU9DjNxL5cAWSSLokFVezsMb8ZNe59HxnHmJoOn+0wfu
	wPTMzIAI+mF4ffoPJNpG5ydtDD+gqBqslrV5B8Po4KzprGWKchRUpyVqRwXEQnwSGFsfG+yFqZj
	5dAZSDhI+C5ZOrd+fJGM7/Ba3OzFaSU82wEYA3A==
X-Google-Smtp-Source: AGHT+IFvrDAqZx5NgF8LGfqkqSWrF6ZyKve0RQW2JLbiFzouK/e4QQP+LYMhrvl/TomKpgf5kQZo16BsN5iCCk3XejQ=
X-Received: by 2002:a05:690c:700f:b0:6e2:2e8e:7a20 with SMTP id
 00721157ae682-6e22edded73mr82279697b3.13.1727584920951; Sat, 28 Sep 2024
 21:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-11-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-11-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 00:41:50 -0400
Message-ID: <CALNs47srxg41krbHiZmv0cVuHNj-SQ8_NFzxpnnHM8GeBFKhhg@mail.gmail.com>
Subject: Re: [PATCH 10/19] rust: sync: remove unneeded `#[allow(clippy::non_send_fields_in_send_ty)]`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Rust 1.58.0 (before Rust was merged into the kernel) made Clippy's
> `non_send_fields_in_send_ty` lint part of the `suspicious` lint group for
> a brief window of time [1] until the minor version 1.58.1 got released
> a week after, where the lint was moved back to `nursery`.
>
> By that time, we had already upgraded to that Rust version, and thus we
> had `allow`ed the lint here for `CondVar`.
>
> Nowadays, Clippy's `non_send_fields_in_send_ty` would still trigger here
> if it were enabled.
>
> Moreover, if enabled, `Lock<T, B>` and `Task` would also require an
> `allow`. Therefore, it does not seem like someone is actually enabling it
> (in, e.g., a custom flags build).
>
> Finally, the lint does not appear to have had major improvements since
> then [2].
>
> Thus remove the `allow` since it is unneeded.
>
> Link: https://github.com/rust-lang/rust/blob/master/RELEASES.md#version-1=
581-2022-01-20 [1]
> Link: https://github.com/rust-lang/rust-clippy/issues/8045 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

