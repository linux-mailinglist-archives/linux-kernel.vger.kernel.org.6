Return-Path: <linux-kernel+bounces-404923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6299A9C4AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35DB3B349BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6BC1EB2F;
	Tue, 12 Nov 2024 00:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGATuDiy"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1DD23B0;
	Tue, 12 Nov 2024 00:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369770; cv=none; b=aikwEU4i6F+43mnbA95mBPVl09RdRhDjFk0OSmyXBgX8JzTVIdEA+O5MxMQKA6ww0XZDGY8HIrngOjPEE3qDsP8PSIbvpmJOGXy5hqDfvkwllSV2pzoGMFynAHklIPHv+JrNi2GityhqrBwOxbyJsquC1pSh9FctnqMZ11GqmdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369770; c=relaxed/simple;
	bh=hqloVGNAQjeRy3aNvXaBMc6qYPHQUDKZaczGU0KY8tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeg5LMfi9eoxLUUdr6Li/FZut3tHZzmj1oH50wPbP6urdvwtHCyPkJB43kjApdvkdpfvQdnq28DkYU9u7Z6067tXFaRi3zAGD6pKxHn+5R7iLZOCfLjtPNVm4hsPAk/dEX8wF1XyqS6CYSIHk65DzbvggjDn8ypHuwbAvQFhWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGATuDiy; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e56750bb13so16420a91.2;
        Mon, 11 Nov 2024 16:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731369768; x=1731974568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqloVGNAQjeRy3aNvXaBMc6qYPHQUDKZaczGU0KY8tU=;
        b=eGATuDiyhMcuu+DNF4jQzItZfvX0z6MWdZjEYhLmR5822i1e0/+biRJXgHM4/UFZ5q
         gZ+TtIoGYUzZMC7qqegTEPkb8w75KvX/HB8P6h1UTpBW0ULgVJpFsBm4ocw0dGlgyGz4
         W5u4Hq/OrVOB6wEUMBB2X+TcizOB9QjcIWFaLFtfOKWCKyw9xWe6bbJNQ2AINVli9/EI
         TCivJV3tcRJ88fthTbXnBoQdRFOInurTz+GfqS7NJhDyakBfhNzF0AA7qvS4hUduFJ82
         4Vk+9IAsCpgAo9YGTw38+8LdeqWCNzow0VreH26ZJ3/VnQJZff722O8qalpE3KVdUOCv
         kzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731369768; x=1731974568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqloVGNAQjeRy3aNvXaBMc6qYPHQUDKZaczGU0KY8tU=;
        b=oZDwqHYykeGSo6KRz26+3mvqwpwLhFkAvvAuJSGjCEMmXQCOF03yBgoFGvHlpnNQgw
         fQ+qJhXJvMfw8mAOJlC7lQqwyul0/iOTk61kVOjgAB3FTecRihUONmf6WVPP0uWYGHzA
         4cOqfkUpylx2VLtjXzo4DePGn/vaUyWX6IaIMURvnxT5JhH7EH4Zfqj4MeZ3YG1PEsm6
         5a9QzDKuXZODtfFgKCo/smEXs4osZMFdkcAX5GwDnSUjyeHgISqJvqjVv9/4KqumufiS
         ft/DPOkfoRqnJDHhKysCaTgKBZCH9BU04RujgKT3/JEWm12f/XA81HynUYyztS8uxwIx
         kyOg==
X-Forwarded-Encrypted: i=1; AJvYcCUytWp8+HlSOxE8vpMW2AtQlgZsWaeBHwo+IYCIh9MpAFpML3sTnR2w8wr1IDK86Z9z5Nohe/njPXxTXNnoa2E=@vger.kernel.org, AJvYcCW4btlqz6QD+odHgShhNfcF7+nSJvXx0Ju3R7i+SUH8Km/8tjBO0a/CRZWCV9oTSqPnRiIBs0n2OYJsq8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMaNmh8F4xEvBFGNgF3rjdZql3mwG4je7xICwizHlKdyyPmGsU
	5UZg15Y4dheJnAWOjirEa1+EkgHdLQyQQXlym1uVUMkqBBuEWvAy2oOpIuZvZ/AHgaL5ZtUVOCV
	xd85Bv8xMSkRAUL1JLQBc+pC2ShQ=
X-Google-Smtp-Source: AGHT+IEaeVek+DtuJhFBlBEsv/iQ29u1BBc5XYRdORi1jyNVutViGIojkMBIO12N4a2Xzr5iWx3M9tNpMthyQldKOwo=
X-Received: by 2002:a17:903:2a8b:b0:20c:d8d8:226f with SMTP id
 d9443c01a7336-2118357541dmr80056325ad.12.1731369768540; Mon, 11 Nov 2024
 16:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110-borrow-mut-v4-0-053976068215@gmail.com>
 <20241110-borrow-mut-v4-6-053976068215@gmail.com> <CAJ-ks9mSu0Wivnsn605ZTFHiYqK4VEhURO-7rj5jFAwSxJsABg@mail.gmail.com>
 <CAH5fLghAJFbCaOF8YPKJaKow3RdPXAqRvkJ7Ua5Mo5LcFo2WbA@mail.gmail.com> <CAJ-ks9mnGvcsCZUjyjkYUSNSAv3004rtFcczBA-Wo58w-L+-vA@mail.gmail.com>
In-Reply-To: <CAJ-ks9mnGvcsCZUjyjkYUSNSAv3004rtFcczBA-Wo58w-L+-vA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 12 Nov 2024 01:02:36 +0100
Message-ID: <CANiq72mVe+geqsXAwrR+OdJ=H9DTb2Oxm5r+JWrawYz5O=fV=Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] rust: add improved version of `ForeignOwnable::borrow_mut`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 5:22=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> My reading of that discussion is that the new `crate::ffi` module
> isn't going anywhere, it's just the later patches that diverge the
> types that might be dropped for now and taken later.

Yeah, that was my plan, and I ended up with that.

However, we still need to see how it actually goes -- we will see tomorrow.

> In my case though I have a hard conflict as the patch introducing
> `crate::ffi` and this series touch the same lines so I think a rebase
> is unavoidable.

If there are conflicts, then a new version is usually welcome, unless
the conflict is small or trivial (i.e. sometimes maintainers may do
the rebase for you and other adjustments -- a new version may not be
worth it, and it depends on the maintainer).

In this case, please wait a few days to see if you get more feedback,
and meanwhile the linux-next issue will be resolved one way or
another, so you can use whatever is in rust-next by then.

Thanks!

Cheers,
Miguel

