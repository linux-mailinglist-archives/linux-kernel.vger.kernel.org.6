Return-Path: <linux-kernel+bounces-553345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B89A587E6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D399F3ACCD9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A13421578A;
	Sun,  9 Mar 2025 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVhlJey3"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A791EF36B;
	Sun,  9 Mar 2025 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741549449; cv=none; b=tjgbzIs7CBepnURJSBMpEB59tsh8V1XQ2VdmXJl9+exFXbmHLK1HjX6zKWiObzP/09InSar0tFkTtFI+9vdQH1XVOYo2sR28hGXmsqukp+u66MnBUum/mm6KWUixZjPNu9YUg2vK9otWyduyssmxD4nk4puiGOwWGU5oGGC/TDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741549449; c=relaxed/simple;
	bh=cPQCmsYr2PzipMe6z22fZFkIXFoEDcH2N0IJnkDAk7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unUj9+xhfv5HEW+GXWeong1LBOQ9xgDtSoBQ2eXqWmenRy5OGHjvsAWaK5KmNtWJpQ2gyoC4Tmgc3JVdUp8tUxYbKGxQsnZgUQMyVJDUvjQHUTHZQWJGF9LMI+w1wheNaWtXlE4QiYhN1XAebfrKFACKvhczCdE5dIJrfy75ydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVhlJey3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff62f9b6e4so992187a91.0;
        Sun, 09 Mar 2025 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741549447; x=1742154247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPQCmsYr2PzipMe6z22fZFkIXFoEDcH2N0IJnkDAk7I=;
        b=HVhlJey36WYDY+shES65ydlT7XlrhoB1e0rEPDTD+e8/qf6OgxxqO/Tp3Ekj+ubhc8
         0RjMnl0wSf3MCF9TKdvk2iCDyfeaVNwcEmK3cC9MZ4qm1U0iZn4SwdFmsxFY3BRPfjIi
         4aYt1H1a4ytjKkjH9EmwSK3VNlHlz+oohb6H7f9P6pKMMOO+u3c11SK8OtPFlvNykonM
         fHOCNAa+g6oK+J9eY+u8XwcfNsa3WoNhqTZRRtJdovncP3fwWdEPf5VSaar6SJg3vHEi
         X7GCUJBi/v0y0BrWleEKGLQtNEdwhIIRj2dTZolkaJL6l4I4AcJyuL3J9/BGdSVokHjk
         m/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741549447; x=1742154247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPQCmsYr2PzipMe6z22fZFkIXFoEDcH2N0IJnkDAk7I=;
        b=qU0IOx02xoL5WX2NBKbWAPe65L2BTokfxalCdjdVGdjYDHHty/xzLaBzVN7jdl8TrE
         9DsfEMmeW35bvivAz63qGGec6s/BwiL/RGaNeKZCbiEprtBbCublAm0qwzvVebmBq7zF
         kvbV0k+nLoS2kgpdxpp/zHqEcxOuwbBxwNdLLsKz4qE4cJa80Yl3twbdHtO7QIJGSQWP
         RHte6alvAj34kCGOLQFg7CrkdwUWI4hECnmhiawMRiY/5i6tKyFkqmXUTMaGX6a0qyLl
         Bk6e70Slo9oGDPB/tXb4IUmFhepuOzERLdYcoNlxrh5spAH4/DhzDZGdW2Y6p+xcACgJ
         5SAw==
X-Forwarded-Encrypted: i=1; AJvYcCUgSPQLFLo8lJpPc492tHhkiniXXhBAkWISn04U11kVKd7dEUFtpC9vzFqJnrqvD2r3YTcTxog9H14Egzxs2l8=@vger.kernel.org, AJvYcCVbp3ao6ks2nz0lXHOF6g08r8SJHho+TvxEqe2ULq4Q9p3HroBkriJxOICB8Rh3ZB9iLnne9RGr4ha1Y4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUGMN/JoGO+X1iK1rA6ajcG2VMw4edUxLC6z5dq5dHbRp3GI4e
	nb2VDbZdkikpHb0jWul0MDwYshGYxsNlxoJA8UKa9H77ldYkQ8FI31ZtGuwjYqnHtrfa6CG4mR3
	UJ1XBigmaEFTc9GImnAC5EfBreok=
X-Gm-Gg: ASbGncuJws7CXw4HLHFGldl/N3czkwqXlVXQiXvYr9KL95jjz1pLsMhkrjAU7GVl+q/
	8s/75SPHi7k+h2dN2lsccOlCxk+O33qvMBNdyll/hs/AaOysDerqM6y2LSAodVlP0vCJtsFNttQ
	BQDMBR0mKiTB9apV8xTd6/CWPA4A==
X-Google-Smtp-Source: AGHT+IEMc4kBT97Jfzxo5YsrypzNB9u7BtESDdjeS9ngtC7b8j/ybOgQTqQF7M/R/EzqFCxACzFfUgRXd6RAc/LZO9g=
X-Received: by 2002:a17:90b:4c42:b0:2ff:78dd:2875 with SMTP id
 98e67ed59e1d1-300a57877a8mr3860566a91.5.1741549447386; Sun, 09 Mar 2025
 12:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-cursor-between-v7-0-36f0215181ed@google.com>
In-Reply-To: <20250210-cursor-between-v7-0-36f0215181ed@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Mar 2025 20:43:54 +0100
X-Gm-Features: AQ5f1JqgsI6yQkAem1iAPMXfe34pY7vHQKjlO59Yy1AZAbfA0rDC2Z9Pn7eatk4
Message-ID: <CANiq72nnEB4ZBUzwpw+dH7fQsjNCn++cZM5Rirweadwy0LZwyA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Make the Rust linked list cursor point between elements
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 10:54=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Please see the commit message of the last patch for more details and
> motivation.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

