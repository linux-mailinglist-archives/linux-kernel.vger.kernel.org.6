Return-Path: <linux-kernel+bounces-420668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36D59D81F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A32163449
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CDC18FDD5;
	Mon, 25 Nov 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3K5WG7m"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D118FC89
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525884; cv=none; b=huJy+IHSsWIDACls3jpR1fWZ25mfoMcqzJKTpqAvRC5uRqkSOBJbDRvkSGWv8eeK5MuzPGLBfZahmt54b2ibsjtrx5keE8BZIleEsrvRAeUXa7AuXcjBGB0Mgh2UXoQrbv0o1tHtxC3XupJKq2ECzf21SevpCHvP/d0K0+xlysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525884; c=relaxed/simple;
	bh=wT2QX0BLl+SGVNLChvroK93Yxa+Mm8ft6/n++IH3SKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUkfuqWcMPF3VxFDDoB6qOdn/dbWRB8exr/Jr2sNxQnuBjlJMR947/GmJY35ZDUinDUwqso9WQ/nkZCZT+YRScDu0ObCsZsDrZdkz9tuTTrv3lStJliH/vhjry8XU9TID/J8ypd+89gl9PT1eiBobeRwuKDlrECoSzetbrftPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3K5WG7m; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3823e45339bso3130025f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732525882; x=1733130682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wT2QX0BLl+SGVNLChvroK93Yxa+Mm8ft6/n++IH3SKg=;
        b=O3K5WG7mm/Wg/xhuw1n88U8ZiYPFBM/huCT0K5mNdAogN2McMQsT2l0xXqf0My0Qbe
         eFVsvzo+258sVQZricwUkvpxasVigyhIWqIiOiFIDAK8crBnZx8Ie5YsHAJlJbhLXjA2
         TaTCroHUd9zHLcbScwLaQtD1h/ohYJ+n7tBO/9qALh8HSLFq9566ftL87J8QjyCVEvdh
         Da1QY8jCqeg5Ncp3LSMET5i8jXvCyrCfDpFHEAxX78DgavFVpkEHgf2lK37YDS4alq7Q
         eiUOxHfxF1mnP4HsKmzJonJzGSRsrCdr4vb0DtiyO+6gzlyiYQbqR+LDR7ZIAQd/ms55
         c3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732525882; x=1733130682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wT2QX0BLl+SGVNLChvroK93Yxa+Mm8ft6/n++IH3SKg=;
        b=h9H8pdejOwTtAPU15b5bjHWiT7OjRjmBflDKD+w8gmY2YZrHP415N1wKts5VAEwG0H
         P/c803zvpmZKeyV9WRjmwcs+xI45p5kG5VyovcRVARzqEH+1CoLWdIq36vPSgcN1j8pf
         7jB6yWy9Thwi89oGejolSWbN5c/2O4zHWBw/hckdXoPwL34XetgcA2x09pPDggUvXsWS
         4r0GTkWVEeBs5Fb0U6/eYzur2uj3eOLiQqxbrv2JjjZFf1g5httdxzcB/TMQPCBYSsFv
         4BZdSwpCz15zQ/MnzOBtplRfs/FGWNWbaKB5H4Twl1oHIRgxaHMitugZuphVYXewkZ9h
         NrmA==
X-Forwarded-Encrypted: i=1; AJvYcCVKsfXpNrMaXqj+hbVmplHsTc3/Audz+1rhwChwSH1DO1GnESUn5H0ES7TuhY/eT292gACFG0y2auP+Kqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxumuTg0ihPwZKvYR/0XqYPz3ZPNX5EnHz8hP7JDPLFqf87ATpe
	T7L1Di4XYWpV7xaEAOgxtFXeop5F8N4mE2fV73XwY6uJ6D63EXfuP7dJdh68avwOQB5Hp1jqY8L
	VkOQfndHP2KzL6pnORDTC/7X+JgIiGwlOZ7gS
X-Gm-Gg: ASbGncvSSgAD7MnCkRs50iXdE7iw7MhA44Jw1Tc8JN+KHk1D9k6wkG7T+MJJYOiwpjw
	dzbkvim4NXgos0qLPObAaXN17OnePjB9kXAX5gziqOvtZz1eKbV/v2cUydnz6Ug==
X-Google-Smtp-Source: AGHT+IH8xUhObePFMXX+6uJ4DZH46fnDECSOgfgui5FdlJfDvg099oVJfy7l8jGXt9Hpo3OEBqlpkGLGHf9ruibw67E=
X-Received: by 2002:a5d:5849:0:b0:382:59c1:ccdf with SMTP id
 ffacd0b85a97d-38260bcbb70mr8904576f8f.46.1732525881617; Mon, 25 Nov 2024
 01:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123222849.350287-1-ojeda@kernel.org>
In-Reply-To: <20241123222849.350287-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 10:11:09 +0100
Message-ID: <CAH5fLgiOHnX14CtN2rtC8ssUT03ECLOAGNLYPfA5ELSch9fONg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: use the `build_error!` macro, not the hidden function
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:29=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Code and some examples were using the function, rather than the macro. Th=
e
> macro is what is documented.
>
> Thus move users to the macro.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

I've introduced a few more instances of this in the miscdevices
series, so you probably want to amend this to also fix those.

Either way:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

