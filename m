Return-Path: <linux-kernel+bounces-349041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F292898EFEE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54841F246B8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBF3199938;
	Thu,  3 Oct 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMYzaPNv"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6115B14D6ED;
	Thu,  3 Oct 2024 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960595; cv=none; b=H1BFyRLF2MmxG9+9+9qInMme6lE2H6CHx+rAilNTiJMEnAR0XD+S5aA2b3NxHTMUA0/DOTvjLUGYlb5zGNWI+9/EGm7oi930/BdAe4eK+K2/AkaygRAu+to3I7jJJYoc7wUwaBVTKeNFTfeoGhchM8TipKEXF6aYXn0wV7+43ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960595; c=relaxed/simple;
	bh=0pjEEqKZB/jOjZ4/wQHEo+m3ps7ACgQNfifBOM3AuuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdUeAom/9s8EKk3Q2FWMu69OHsb9UPn54CjJ68nw55d7mOfShbdt4Kmf/dOdja6lKE/S/6IUkXWBNJrps/MJglJvVzyiy7cAnJgEZlLfQGyjEfZqcgNWOl/Kr8dC7nCZifaoaQGYRJTGKbSrncY28G7H9ItaySPrIxgY6S0/5Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMYzaPNv; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539899c1febso110355e87.2;
        Thu, 03 Oct 2024 06:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727960591; x=1728565391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pjEEqKZB/jOjZ4/wQHEo+m3ps7ACgQNfifBOM3AuuM=;
        b=LMYzaPNvF4JWDIuOEvQOpXuGdDKIV7D7wQc7Vja7XWvJiaurCdgmG5WBcRek9vYjRB
         vOrNTOSJHaJtKK/lex2I6IxI6T6NTfJo8WLJjPB8ln7hVXYctL6pHMi6yPfWZlMQgULO
         XpsuAowdhK1cflu0EQ3qy48Wvl1j/Gkf8Kh4EJIXTTOJza0e6pG7hFn25b14oyQRCPYs
         1c/tf8PyVH2jeDVPg87irSg0ocqaXmEnLv3Ny06qma81016ve32Mg0LeZM7PNDgiiMNB
         soFYpHqy2voPI9KwizsC6VvCgWC/uA9W+k1/IjfJP2EJ37yph1ZfKQrriUhwkGL+o3in
         V3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727960591; x=1728565391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pjEEqKZB/jOjZ4/wQHEo+m3ps7ACgQNfifBOM3AuuM=;
        b=q5v+MCcyLrd9MEo8ug7HvCnSU0JtZedS00VAPuYeD8pDibu2T4byEldF8NcU4eH9JS
         WQYjan72y0b7algEr5luRp4NZPEq8EEI48O1Q0WSewEHTMAohYGqQTkvgl/793IG0jG7
         vLQYi08JOjVjdmMG4SqVQZ+Ce7XwDQIdb83NWmOfgHxu8qjHfkpF+Kbnt/1vD+dttMSa
         eU5CCTG8iblcjDk92t47kA8dlVXYkKAtzxWu8CazQ8uZt1jmNr7Xb025QDDSUfAu/T7n
         lVTIYr+YP4SO/j8S7CuzWIIyvwnkQ1ujVaRc31JxT5sVIhfIzzigh3xh1URb/Zra/lqS
         HR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUo/d/KDYWqEBv0VtvETZE5niivlar7FxkUF/ssSGa3ODAvtdIwn+Se/eeUEl/mKA++9tkGx3Fxzhe2Ah4=@vger.kernel.org, AJvYcCXFnm8IWK2XWp+y/LPs4bqe5tczR9sBsS+hy/OXH7khwdLTkLesA+6tpc3pHaNa7nfyD6i/cx4W1woC/C3n3iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhqX7As/fLuvH6k0vR7WpYInMdc8HBUdYkfeivDj0HnU5bjOvv
	cfMk5YfUqY+xX/ZJDaBth8tdkJcjE/oRc+t7qc+Uv9ix4WGKVrGYhnk434toW7MtFXgTCoT6f8V
	yOP37C94BUoFpKJbRVeyEsbT3NcToa1Dr/XA=
X-Google-Smtp-Source: AGHT+IFD7y/g7S53GYq8SiQwnOk8qWSqXT05lzuITIkOIY2dV3j4VDuyIeBqThOBN0TfTDlNvXy/9tNoXVrAV/yNNmc=
X-Received: by 2002:a05:6512:3c8c:b0:535:4d89:5b52 with SMTP id
 2adb3069b0e04-539a065f9ecmr1045863e87.1.1727960590956; Thu, 03 Oct 2024
 06:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927164414.560906-1-ojeda@kernel.org> <20240928193632.063d62a6.gary@garyguo.net>
In-Reply-To: <20240928193632.063d62a6.gary@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Oct 2024 15:02:54 +0200
Message-ID: <CANiq72kQ+E5-qQ9X8UdgcBN_P=7JYHo6Ft8rLNRwAXmxbMyeMA@mail.gmail.com>
Subject: Re: [PATCH] rust: kunit: use C-string literals to clean warning
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 8:36=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Note that the cast actually need to be re-introduced instead of
> cleaned-up -- `c"".as_ptr()` returns `core::ffi::c_char` which might be
> signed, while after my series `*const u8` is expected by `printf`.

Ah, right, in your series `bindgen` will point to the new one while
the method will return the `core::ffi` one which might be still `i8`
in some targets.

It would be nice to get a way to modify the target for `u8`, i.e.
`-Cunsigned-char` or a "target modifier" or similar.

Added an entry with some links in our `rustc` list at
https://github.com/Rust-for-Linux/linux/issues/355.

Cheers,
Miguel

