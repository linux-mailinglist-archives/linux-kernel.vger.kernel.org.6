Return-Path: <linux-kernel+bounces-420747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D62339D82CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764F3161FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17F51917EB;
	Mon, 25 Nov 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hjw/W+XB"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D77B190058
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528090; cv=none; b=NjTlcRJKtOxYrIhHIDA6YkocYUQwsGdnDvdPlJek3geI74TNDRRAVPuPF8l6+wA2CJG5fPO8ADqhdrx3OZw2StdxvbFr/mFHqJXDLMknoBqGdu2ts6TZLnNfiHkmfWfbop6CgLy4tTBg6q+JAzA27fvX8GTjS3Xue+zL+bF+sl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528090; c=relaxed/simple;
	bh=hJgbsrfBWfExYUYOXftgJ8QNfNKyzy7L4+nDPv6NGyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSgCBCZmkT6b8Xt6wZQnWOaIYDINVrB4dibqw/gbeKMmbw/sB0Vb9arp0aC1jhIw943zK06+MfacSCgnFy6eliQZKnp8Vln2gh7aEdPwXCnuElV4ZpEsRnqrncXUKmZdI4bWJFV9Y48l1ECXvDppNRvKFDj5qzxfW+nHCjEKq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hjw/W+XB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3822ec43fb0so3291046f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732528085; x=1733132885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJgbsrfBWfExYUYOXftgJ8QNfNKyzy7L4+nDPv6NGyc=;
        b=Hjw/W+XBUclTXXoC6N4/gsPL/AtCMlhqhBf7y3AqheCg4lNZ506rsxawfHXl5Ny21o
         NLD/wNdR9rA0AbH0duzpnOZL2x3qZ72k8x+IoPpDLOipXO+gIw1GTDbuIlS5OY2oPi6u
         NDqFgtNyV0YrBivs1ddNX+3uXOtqkijhq8S0QrgRFbnCs83LHwW7QdAJVhMe9itNEqYp
         vQtiMHtI5dJsWKScKMYHVGvkZgoWpqHT59V2J3cPxnGiw8u+mmvi/RzIFx2djzxJSFb0
         QNItsDqVSSrilJoL2S5aS9pgg9z/PWi2mQpmymewZjc3Wi1yAi8A3GkfwhawSbPMPBoH
         qf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732528085; x=1733132885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJgbsrfBWfExYUYOXftgJ8QNfNKyzy7L4+nDPv6NGyc=;
        b=EkU/a6xIBNDTQPbhg2V1cPRTZy8GbiIzox8ZTEflDUXidhezAqZIHAPBgcP2I6lqlf
         ZEtIdvlp9TNHGf7Ajchn9/B+qzT1EZWf1JXAQutC8OUWDAjMCcQ/fnpSyfEizz2Obq8y
         xrKsnCAawKIRhsEq+b1wz1VmrwaxRtXJGy4yZoOzzC3SStrUvv9VBjujyLJLlfgGcYe9
         vKjJ5EfByunju1RfxfPEn3zr2rjM78jfOc2tkOlM2n0k6z54rCSJ6aFIwCLrbpfrCxS8
         d/E/SG7VBfwDFzQ6utrjoGvv1nr2n0Gbu9VtPdEcg4XU/9YureMc//KfgkiA9mEO0bPW
         yhpg==
X-Forwarded-Encrypted: i=1; AJvYcCWiDPP/olb/C7QlK/nZKeCsyYVnj6on3Y+RE5T+OX2uwIilYVH7sGjc/OimhRQh5mpNeNY8QF8/ermaKjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJsOULaHyTIx6KTXzZ7SLVk8BKO6Gnh9vtMk2XR+zdXbdoGOz
	q/LPc2rZOHZc7rIYJ+qUISYMPCCRrQ0S1lktrxiZp6jNjcmtrALIoYvN11Z8RB2tiNTj0T7w00C
	LJxUgW7jgigyxGfIYG4kGSjLIRiIZqR/YBpPW7r7yCwHhzY3po9YL
X-Gm-Gg: ASbGnctSfG34A7E3u/YgrLvw8q6TW4NjUUtONXWz8zcbKzJ/3SZD2J6TKtcwjGSmQ2k
	veBKBo8+5YARvDiu5cRugYu9CXOgb5Sz9s6e5BMod1z7s0YvGNVk4wSg9W1ViTg==
X-Google-Smtp-Source: AGHT+IHrAXO8603RTW/PSQBZ076E7pfsRnlq8MGRYZ3LzsLhVNpRdvt57aeVDXGLjOJh8YU+EzwhhwVNv7DddX7Yl1Y=
X-Received: by 2002:adf:e18c:0:b0:382:2d59:b166 with SMTP id
 ffacd0b85a97d-38260b83dfbmr9653111f8f.31.1732528085567; Mon, 25 Nov 2024
 01:48:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120222742.2490495-1-lyude@redhat.com> <20241120222742.2490495-2-lyude@redhat.com>
In-Reply-To: <20241120222742.2490495-2-lyude@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 10:47:53 +0100
Message-ID: <CAH5fLghL8OPnAGud5OuMUc1SpQ3j2DO2s6wtm2HjnvzCihrKuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: sync: Add MutexGuard type alias
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Filipe Xavier <felipe_life@live.com>, Danilo Krummrich <dakr@kernel.org>, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 11:27=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrot=
e:
>
> A simple helper alias for code that needs to deal with Guard types return=
ed
> from Mutexes.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

