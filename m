Return-Path: <linux-kernel+bounces-316764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E892B96D3DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC561F220D2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AA21990A1;
	Thu,  5 Sep 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKlPNsFB"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044F3198845;
	Thu,  5 Sep 2024 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529532; cv=none; b=qkY9fKXwYCEbFgHhRZaGIOVytgbCGKSl0nrlXG90zaLBFVEzOz6CXFjibFPgKMOimzbovZ4C3+0+u3RCCzfk6UcZgXL0NORCFpWe2EkAn3Qcv2F3CJ+Scqeo3Yfo1Rh5Xyg8i/ZbsC2oPMRtQj4E7oX74nYlpdDz9Z/HR/8Lt8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529532; c=relaxed/simple;
	bh=T9uAT6P2XJVZAdZnyx/4GZlbV0cbx0PWvTakz+ui324=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+Jc888/E0GyuwLc0jJ0eF5ybyVUa3HZM9Ymo8Etin/GWzslJuCkEYqNUtUB5TtVc5wxQNLTrA2vEHs6wjBeej/LyUtX/7C7mqsB0kP8aiNFALE4FLh+HXxcbIkP+gYYqEa81++h4vGBDcZJwMa/kl8eN2clG5b9R0aqK18vQGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKlPNsFB; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70f5f85971dso73626a34.3;
        Thu, 05 Sep 2024 02:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725529530; x=1726134330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9uAT6P2XJVZAdZnyx/4GZlbV0cbx0PWvTakz+ui324=;
        b=hKlPNsFBu9coNLPi/j5IDWlqZOCZGdSJ6qhhtHsaL533KLRUEo10++Ng8oFiYl6BF9
         1EYHOVmKTm4f9tzmkYBhNfk6iAVos8mY5okRo20Xg5sa0E/P/mrQGEN4+uSajj+r1dJH
         9oFtNRU774J1N7VIvxaLL13DgeWYlD8ROH5Nv0s257SQC5ilhVjXmv/gXdCtkcEtQ5TQ
         oAlLewOG2qa66E6ZPnJJ+Jirf5ShKggpfoNT3nZfl+zL8YeXundKdhwRK+ZazLAkhUvC
         SFOxIiDqDqxwfDckNLVWJ9cOskAEWbspr4fbaI0MtDu6Gw1lZp8QBuuwzjp8Qr3Aji+l
         t5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725529530; x=1726134330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9uAT6P2XJVZAdZnyx/4GZlbV0cbx0PWvTakz+ui324=;
        b=qnL98HocVrAp6qEZLQd0rnG/HgTq7qLrUh/zv3mBasI5DwYcGyOQ589Kl+Mgqe8p7M
         RiCQ+co1JH6fBzSK6ut0/hH6/PWbofWWw9fgwkQOeo+O5Bok7ogt0izcqxQfxtyNL66U
         Hmmg+09F2I+Xr20EIbz1quJU+1suEJpE/e0EYd0Z/Q7zQ4inAycMDSCVH96n9dSAqDVt
         ZbCKFnlFV90ts0ZoTEgSEFDRDmEfmGraOdsH2iOQc/VVChBcZacPYQ2Nik+PAnjfh9Lr
         8TSLXngP+ynCAK0hxgmicysV4Gm3FPuvBGPeyp3FfkmM9jiF/+hV4uN7CdpajQXojX7y
         95DA==
X-Forwarded-Encrypted: i=1; AJvYcCXZMao59pscHr2LWcZMeMyrRrxY8WrNHTBoYN/8sd58USIZlS3cPjzhRqE5+vn3Hud4f2qlzH2dzSxhZlnSAMA=@vger.kernel.org, AJvYcCXjmsUcqb1lBPG7Pc04ZCjru7jCDg4v+Q2KAkfvw6Em7la5qnRL4yR0W6J2cxuwXJd4k8a/F5WgmXPegYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsG8wp3rwmjmeVn4RLEBKWGOG5U/3H4lgnL87GHZBgg3zTViMa
	z2uSXB1xsfF34xH25E/eWig9eqvwJckBg/yEXEv8gXqiNrlS3W+VP+gQkWpWhb9AtnmexoqHerW
	Uv3qAXrmhl7XgkH6CADt52SiPdLM=
X-Google-Smtp-Source: AGHT+IF4/iqCXFx0YZniYl3ZSu+g9OE3IT6hrjrMVy3pCALICpQGkQrU5kNPgWw9rFg6Yzz1lTOlB0WKywfTKVKf050=
X-Received: by 2002:a05:6871:54a:b0:278:6e3:934c with SMTP id
 586e51a60fabf-27806e3966fmr6728709fac.5.1725529530073; Thu, 05 Sep 2024
 02:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-17-ojeda@kernel.org>
 <CAH5fLgg20kDCJfD_6+fTSogOnpqK0x3a6eKaTahgSvdgfFzSEw@mail.gmail.com>
In-Reply-To: <CAH5fLgg20kDCJfD_6+fTSogOnpqK0x3a6eKaTahgSvdgfFzSEw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 5 Sep 2024 11:45:17 +0200
Message-ID: <CANiq72ktnMSfMfGEhN1kO0F+C5O_KsUY1y_eb7ZL+qzzSkg9bw@mail.gmail.com>
Subject: Re: [PATCH 16/19] Documentation: rust: add coding guidelines on lints
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 10:16=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Wow, does C really not have an easier way to do it?

Yeah, it would be nice to get a similar system in C.

There are targeted attributes that can annotate certain things, like
`[[maybe_unused]]` in C23 (and vendor attributes too like our
`__maybe_unused` macro), so `-Wunused-function` is not really the best
example in that sense -- I will think of a better one (it was nice to
use the same as in the other examples I wrote for `expect` later on,
which is why I used it).

But, as far as I am aware, there is no way to handle lints (and levels
and so on) in a simple and consistent way like Rust does.

Cheers,
Miguel

