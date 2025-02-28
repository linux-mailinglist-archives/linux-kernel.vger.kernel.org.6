Return-Path: <linux-kernel+bounces-538090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3060A49478
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07DB170852
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213C25484A;
	Fri, 28 Feb 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YrdBKK1G"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29D254875
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733851; cv=none; b=dCobdMfeJarKuWVelrS9Lx+86xywDpGLteIfgeJgWxYhxxphM9Mk/OFo19bq3br38XD3Ss0k7yQQC7EGzqCWXAMstGsuJ93+gaXjkdklD25UKmcgiPYeFXfPchCIErXRRy27iOtkh2QiB6jL9AlAoJ5gE62XRvW2Y+TF86PGZcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733851; c=relaxed/simple;
	bh=B+KZR9U+QNu7SUxJ+i8T3VOmdEx/39PbN2GtIhllJPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZccCDlVAhAerWfO2cfABvTzzbgJVCiq3ywfQ5PDQxVT6jo7nx6L9pORLt8Ow86t3w/5+rDw86uDrDFiI84Jo4DO+UqmRiKpTmag/Vbp2r79En8Qx0mSCOWZgQOUwM8Tw1O9Tz73GtNe/al1CGkFxy8I+/DmA41RjV8XFpHZkqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YrdBKK1G; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so1118445f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740733848; x=1741338648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+KZR9U+QNu7SUxJ+i8T3VOmdEx/39PbN2GtIhllJPc=;
        b=YrdBKK1Gc8taDPwF3BXslAm+4RyH1VD/8Y4MpBK18oEBxGYhAXV32Ixzwr979xnnfI
         X1XGf3igKoEAUZ5I11awrSNmbn9bMboYqs/4vY2FUouqYIK5LXuc9954EGcBDr4kUCM6
         6nDnFZ0Ni/nhoP43QfIWAki9ebSSxrz2lxV3yTxi0uvYPNdaYV8dZE9u9bFMzf3yhOtM
         bJuhBoR2FxtP13b6TuvKo9l5x3yseZ2Lsz9Q8hsudHLRgc1alY9ZJ+OMfNUTfc80/2az
         Q3reEXuXNt3ed9ugMzBGI4WxzZFZiS6qQn7K8Ds4IzXmvSQJSvAeRCM16zpPDwKkO/a5
         WbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740733848; x=1741338648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+KZR9U+QNu7SUxJ+i8T3VOmdEx/39PbN2GtIhllJPc=;
        b=I8Ef8A9pq1b9+CjGgee7CRwXfOYBtXTVzH8ViIcFY/U1tAwWvuXTwPX6luWG6Z3mmg
         yEK1rC7eo8MJxarC4lYMiguCozr9PvE85l0BANq1ZCRyf/nb+vgxT0/oJJq65RPPtiah
         Z02BmNL45V3ArhKiOgYHRsjMuqdxAyyiqnRIMOl8wOFxgCD95JdRL3CUtJgU9eu7+YpV
         tXqbnlU315dNuyHFgPXKpQnwvmKUngvYG4cR2G76tS9qajyRtdC0XIKJFeir+0qZ86TS
         xfx3Ky0ykzDXVKe0oFz7kicv8m/SWEG7+L3qyhSfJzU42N+Bf+9yawKV4hjVew49Aa8q
         NYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdZf2qpWHijdLtLOuKpwblJslkOtFIMeDeFo1GSvZceGuoSxOwLkKD9rImXA206VaS8rVNo4selUUARzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7nl/BlSi05OoPhTuAkC3s8ROQmSWFRY5oAO4JekXBnc1JFRp8
	ZvbWbh7lDZe3A2okf2oFlmAREhwlwVSX4BmdwesTBPnbsG4DZMpdqUqPn3ARz/uU737aYCYM7eJ
	A8aZQkorouZrTWwu0U1Ej5Sa6DoqS7AxcxB+M
X-Gm-Gg: ASbGncvvTqXdbdhjQ9uICWvT0E1HH5rKmdQZSGbt7SRzhdp3EEBEN0+j6n3waip1ePB
	xggD5RAsuj6LDk/h2jQycsCr+RN0qjSUuL8/Q7gTb9gr2KYXrvRm1fHPnpsEEVfo0QR1XWKEx1W
	iWu6E9CBpAUkmZr+cVMQgv2FlGhay1Xv1qfGyg
X-Google-Smtp-Source: AGHT+IERGpvzIDS0sWelP51+WNxcT7yjVOKO5ZFHLOo3Y6uovfZdy2A/BnsEEhMwf3nYmys4gVtLG8EpMJrjOz8W398=
X-Received: by 2002:a05:6000:4029:b0:38f:2726:bc0e with SMTP id
 ffacd0b85a97d-390eca138d2mr2034057f8f.44.1740733847661; Fri, 28 Feb 2025
 01:10:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-module-params-v3-v8-0-ceeee85d9347@kernel.org> <20250227-module-params-v3-v8-2-ceeee85d9347@kernel.org>
In-Reply-To: <20250227-module-params-v3-v8-2-ceeee85d9347@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 28 Feb 2025 10:10:36 +0100
X-Gm-Features: AQ5f1JqSvSbT0FH7s_hhnc_jNCyh2EVcbOEFqp5yXZR56yXssuri7XnydNHPcvw
Message-ID: <CAH5fLghKoWQqOC8jRES_ZdSg_PJHd22bQWngaQ4fRHJPHYLB6Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] rust: str: implement `Index` for `BStr`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Adam Bratschi-Kaye <ark.email@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Greg KH <gregkh@linuxfoundation.org>, Fiona Behrens <me@kloenk.dev>, 
	Daniel Almeida <daniel.almeida@collabora.com>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 3:39=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> The `Index` implementation on `BStr` was lost when we switched `BStr` fro=
m
> a type alias of `[u8]` to a newtype. Add back `Index` by implementing
> `Index` for `BStr` when `Index` would be implemented for `[u8]`.
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

