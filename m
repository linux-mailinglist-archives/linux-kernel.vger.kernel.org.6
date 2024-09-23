Return-Path: <linux-kernel+bounces-335637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEFE97E868
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08648280AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC481946B4;
	Mon, 23 Sep 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cu0/2Oxt"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34446D1B4
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083057; cv=none; b=VrBAvACpWqhu1sZ11EYFWvWnLKydBwDBw6m/Nl8N6vSFLtLPSAnE2LLMKhtZBEDq9K1OipKtvyYA7UtjIZO6x5KDNqPiyksW7CoEG9bIlc/xNq56XJiid54ovHOq3DGEYxrof3GstBMYt4kUmfn1wn4L8jcNVx4zhDOHaDKnqqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083057; c=relaxed/simple;
	bh=dXtU+p8lSm5203QVSlqw3BD+P2o/6IwPYH/o0HqI2a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8Z+Yu3U3c+Z0Ek5VEz8XcWNE+KEQB4DHLiL6XITZGvCh+G6qR5UUrsOOzEz6dUBjnPwk7m8cntgAZQDVwciq8m4xWQqSGBQZk4uz6KpKZVa4OGQs6RFefpj33JKXF3rqpRylvkfNvOhYcUu6KEV9UdieXPlwp1v5PzQFeE8KWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cu0/2Oxt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so2389616f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727083054; x=1727687854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVtSaoR0biX2T9CVpvtypIFchxY0cdh/phffmHsW2PM=;
        b=Cu0/2OxtLAxf0yQk82JJqmZXNnj0Z7R1j99eH4BGHfcIimv1OKbWpkA35JyM2u7iy6
         Qw+wBQ7v+lZl11cq7tbgKwFtgKtC5IBcqUZZRhUWznKh7xDE8EiBdt3H3dvQKqTFT3dh
         sxvPHpRxfy/5ynXvi/edK3ihvtj8MbeW2SQDC7S5NHg8/THM8AxToG6z8D1feOfhySn/
         0wzTkCIz/pYZtw6x+xPqNNukQUI/ZqqaZhxp5OBRpCRFg7LyAnufNHJSKajqOM54UeeQ
         xKhR1sqCwd51/CJoSpPLUTAiMDPiZeGoEcQv5yJfUjtvcj7nhvmb6wl/gSxtSZddlVUD
         RXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727083054; x=1727687854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVtSaoR0biX2T9CVpvtypIFchxY0cdh/phffmHsW2PM=;
        b=DYT0gEI2vG9+B1b4jNLN3fL/KS8IP7507cdApNNFTmkNagTJgBuiZdIOXbthzYIuvE
         mQNonaDaMmnnrqTqRqlnJMXpTZwfIUgEi6J6e782TGsT6j8pb3bOW+1kHIZiAu8H+iAf
         yFf22hG7DEcdUKXyRm4uPDgDpUMh8f81C5YxkNOQ/1CA/gIv52x6f0SkSLW6IZAO4vFc
         0cX6whemZ70WDBDBMoC1rFSyA5uCLC5ryC2KiFteY4w3E/4fAoQ235zDdpKE/j28UhJ4
         cu0kd8pX2z6tMqmfj4x18X2RU9xjslpT9EKfzRPRNfgf1jILtJ/TscYAMYqlWS6Isk+n
         qwog==
X-Forwarded-Encrypted: i=1; AJvYcCUu5G9Bx6U0DgRRDa/+nTS+aaSBqpqDpK9a/PJDzXImbsHr47h/9+QYypQxIUSRKzmbFI9hvSxyO8bA1Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9JYZ1tehUTBoci8PrQbi94lZHbRm9Tc1SbQmF5Gdp8T+xyLo9
	VzMGTLtX7TbqH+OPiHlFF8gdCbNGrzbC3mjgMMyOqhR4K8/Gw6M5ehE+QYXkuYZ5OgMb438fKVM
	0oY7cPtJ7xdwRB9739utl4hX+LYYACBP6YAlY
X-Google-Smtp-Source: AGHT+IHI74AJM69zd78KpzyQE1BtUUEeyU7RmQjBJekSb/384i3CmT5ZOtSPPuGLTObOrptz9khgPTIsTLIdBob0qW8=
X-Received: by 2002:a5d:64c1:0:b0:374:c3e4:d6c5 with SMTP id
 ffacd0b85a97d-37a431a7142mr6905859f8f.57.1727083053706; Mon, 23 Sep 2024
 02:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913180622.1327656-1-masahiroy@kernel.org>
In-Reply-To: <20240913180622.1327656-1-masahiroy@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 23 Sep 2024 11:17:20 +0200
Message-ID: <CAH5fLghY0TQWX1T2jjxEFQ0kQ9cCVVZ6hHsMFknn8RX8K0X2jA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: remove unnecessary export of RUST_LIB_SRC
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	rust-for-linux@vger.kernel.org, Finn Behrens <me@kloenk.de>, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@samsung.com>, Benno Lossin <benno.lossin@proton.me>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 8:06=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> If RUST_LIB_SRC is defined in the top-level Makefile (via an environment
> variable or command line), it is already exported.
>
> The only situation where it is defined but not exported is when the
> top-level Makefile is wrapped by another Makefile (e.g., GNUmakefile).
> I cannot think of any other use cases.
>
> I know some people use this tip to define custom variables. However,
> even in that case, you can export it directly in the wrapper Makefile.
>
> Example GNUmakefile:
>
>     export RUST_LIB_SRC =3D /path/to/your/sysroot/lib/rustlib/src/rust/li=
brary
>     include Makefile
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

