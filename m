Return-Path: <linux-kernel+bounces-404306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F4C9C4230
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED691282F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3A819EEBD;
	Mon, 11 Nov 2024 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lj475Egf"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9461C01
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340540; cv=none; b=BKhE3uDqrYkK4EZzgEHc1Ugwff6Xh/aiDDXF97hK+FQnXU+8MPJkFJkbGhiO/fzb3AVn1swc7+MGJ7ecpgq8O4LJXJGVtda6WspY6uz/nxanu3hS60Ug31Lbq0duyTKy3Yo4B5PC54WVLuKEbeHeeohpTJYRpiguKb1Wyrr5qm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340540; c=relaxed/simple;
	bh=W/VFz5Yo6VK3dmt/YM0Fcp78e5JXY/Twhc0ShEwBMeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kN6YvdKRd64qba74j2L9AQBXTkISGeqk0eqFDOEfbnvp7688fi1/AeaDhCGIgFYLQqNpsoShqQs0XGJFwKEqITLTnyaZs52bsyIUlUUNfEA6pXLwCg/vWvbXcXWsccSPD5qxY7geHxdo1gmFuayG13og97iYvnG/FmuN/TjGWAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lj475Egf; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4c482844so3174347f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731340538; x=1731945338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/VFz5Yo6VK3dmt/YM0Fcp78e5JXY/Twhc0ShEwBMeQ=;
        b=lj475EgfFC5Qb111yx3I2Dg1W7C0piG+3lnD3IQV9UwXKYzM+0EqOXziBSptxLA4NU
         U5IIsaewYlSEpVkMtHeO/uTreZiR97oOK1/lN8G2qjJyC7fRI7Yw/C7C9WA8B57DfB9f
         xdA89HrvjKOvQ1zcpeOILTWicvU0Yv3wtnIP4PttAsBNRqjeJAIRwtd26z17UhRmrXzv
         zFwsw+3Wf4PtKOQxraqHw2oC8K5ZE4GzQpusx4ZSy9y/2nQ3u5P8HgM5VUIR6Kr0t125
         HJy8CGAOMdqowU3UMKGyjUe84QcgoDfzCvmF03JWHE4s5qZKP9o+UgGsRWheHQMkl3SI
         3XlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731340538; x=1731945338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/VFz5Yo6VK3dmt/YM0Fcp78e5JXY/Twhc0ShEwBMeQ=;
        b=LHFxDdsLC0h2b3Ekdg9VRyTMgS+8GUBCzXrZhqBMuLY4BqBFKkvNIKcVisLh1GNz7+
         w14iziQ5WAjotERdezZ3Jgb8lwOz9oD3kny0dTMmg69uLU8i28nsYQOa9lZmvj5w+rbo
         JsQzguxPrk6zw3Ar/IjIySG13uwFQbLSvSW4aPBmxKfdx2VG31H6QW+bvcEJ68f+Bwad
         vcE1n4hSFbM0X3y67n6c+rY6K+x7g3dXw0SktNPpKQPocpafrgibAZiPnHrm/dh93CbG
         NCJavHrkEI4J6n9veTOmrESl8Vqty4rJi83OTLN+NjCQVEL80516Xn6wVMHL9Vyv2axg
         uDFg==
X-Forwarded-Encrypted: i=1; AJvYcCVKCTJYX75IzQ6VWZv4ms0W2FRySKne1cF0NkajR5llXzd6BQfeGKTqiciHInzY4y6+KGz5q9izdLGL2HA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw06AVYUAlZFt5hIV5/PZI8QpkFHEnu2cfRCW/mF6sdyszuxzBD
	+250h8QzeXb1AXntzPFhGR+Kf4UQAQqxQwd1TexjkTKZ10+weKVV6GyuTjWYu/sGlZJZiv5Ioce
	+Xg+nTOndIJ2bot7SfvO/JMYbuUn9ZrCjcxty
X-Google-Smtp-Source: AGHT+IHZ0vko7pQclRllMVoZHHLj6D5VQ4GyxJmsFhMgJZgKneR87tgFlzSTuAPnlbUTZJX2byH2euC5Vpl7UOXjA+o=
X-Received: by 2002:a05:6000:2588:b0:381:c8fe:20b1 with SMTP id
 ffacd0b85a97d-381f18855b8mr10892615f8f.42.1731340537609; Mon, 11 Nov 2024
 07:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110-borrow-mut-v4-0-053976068215@gmail.com>
 <20241110-borrow-mut-v4-6-053976068215@gmail.com> <CAJ-ks9mSu0Wivnsn605ZTFHiYqK4VEhURO-7rj5jFAwSxJsABg@mail.gmail.com>
In-Reply-To: <CAJ-ks9mSu0Wivnsn605ZTFHiYqK4VEhURO-7rj5jFAwSxJsABg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 11 Nov 2024 16:55:25 +0100
Message-ID: <CAH5fLghAJFbCaOF8YPKJaKow3RdPXAqRvkJ7Ua5Mo5LcFo2WbA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] rust: add improved version of `ForeignOwnable::borrow_mut`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 4:32=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> This series conflicts with Gary's FFI types series:
>
> https://lore.kernel.org/all/20240913213041.395655-4-gary@garyguo.net/
>
> I've rebased it locally. Shall I send a v5?

You should probably wait for Miguel to decide what to do about
https://lore.kernel.org/all/20241111175842.550fc29d@canb.auug.org.au/

Alice

