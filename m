Return-Path: <linux-kernel+bounces-444802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC699F0CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A180D281AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1BB1DF97C;
	Fri, 13 Dec 2024 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qiNEn3Qh"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0B11B6CFF
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094211; cv=none; b=ZmUgBE/zcxWEno5nfus+Z0SwE8+DlA1u/Opk4w/PWCRndABaZiTmmkEcJu3vGBImJguBIVN78aY4Mb0Hec0e0arKpVRB+4qygnCO4d9ObSFbJ9sgdno18NlS4Fv0r/fzoqbKm9XQ+ucq+9geRvj6z+a3jfwlSjv+2MEXkmrDceI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094211; c=relaxed/simple;
	bh=k6suJOebW+T2tQfGVv5Vkd1GGLC7hP2TbXFK9BWUYTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTnH7ObKNa7K1lw1lxH1c8y9+q0fu6EczCp7L9MuT7sEkOC08g8uYPDOdJ2lRmCMvEyJ8iXREOqn9tJwtcrZgwLLd6Y39NievGW+OyHToFdyT4QinsHbpjop7FPu/WzgPlbegkZjteYYP7Si9T8r66uIJUgMYylH6uj4sI7vjvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qiNEn3Qh; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385de59c1a0so1036914f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734094208; x=1734699008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6suJOebW+T2tQfGVv5Vkd1GGLC7hP2TbXFK9BWUYTE=;
        b=qiNEn3QhLiGGvjAIHhKeDgnHAOD3NHqwCwbPPcCb7Mxn8sH9Pkm3ey73LvaXxUN3O4
         AEyh09OpMp1k07cGrAI5PJK3clmNjF6wzi6r87xhTRKDIB10AswRiE6XRFjJYQYwrihC
         OKnLkYyUyBJ1coY8UyVwmJO8a0IPL6JxL61MIBmK5tQ/za4+tV7SrkZUAr/f1eEJ6kPb
         wokxH6tfHnjtyynwEeM0I1gyq5vQIvyuyfiy7o/yJP1nYwMlMhEkJLOfkZ/u5X32Nvc7
         AY1je6Z19DzjxH3gNIE2yRWbWmv/z9RkqRTk0THHS7KjAXaMD8p+YoFjTIvACAuashBK
         HxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734094208; x=1734699008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6suJOebW+T2tQfGVv5Vkd1GGLC7hP2TbXFK9BWUYTE=;
        b=VBEjf3/6F57lz55/Go6lDikqa0Oun/jEOGGAKD/+FXANZhVB7t1Y7p1H0ve+ILe7i3
         iCL4AJDmJ57/KIlzGtF7ZIHIPpgL8SFy10GSWQ2R3QSCnpEVTwe58I/9bm39YXsLcvNT
         neYsS2AK+1tWt2us+GKCq1LtNGdd5Ho1ef/cLGf+Oy5MU6VKBF5Dbmgf3tXD3OrPPDYD
         unkyoamVpZkq0o/5z43+S8RMLOcLplrprLZPAvIQp397Rpt/AOdx2iYZbxMz2lurUmnh
         7JwkaXHlDd5waWjkt55rgxgGA56Mxozz6C1ICgfIFiY5Dk9yGsvkvsBW7vOyEkqX26nX
         oYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp5JM/WXsqPajxJzSYPTvJpPEWpmUWSGNwkR3IcEpLCvQ6j4QPNT2UIaj0vQYFdYgYADpcxHS8x3APoek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzfM89khAO0jXB4kECMalTkVlmAh1rjTveIJNYjmuz2+msKQb
	hmYtlujEAj7REPReW2Br6ZFHh9OMPG9ElCm0bNxQ9CcWyfDzDAPEmlJ/MmHiKzfOQ3mUZqbvTIf
	i9iVXGG/G4cpDTim6+a48CewNVPkV1tIdVtVq
X-Gm-Gg: ASbGncua2dk3HfGqZxZK3lDMvLob14+PzfaALkVwUrHmUZEHpYrCdvPe3wN+1JomPui
	SJUFBJ8RT0McrxhQEEcpmqv/Fo4TSRCSQU5qiIpE=
X-Google-Smtp-Source: AGHT+IFJwfW3yssZ7+jsglJf5d+5FmvssL5C/KzY0tcQAh75c2NrYq9vh2lXeL/kRzsw+F2F/hFZXHTrxvm3QYHIi+4=
X-Received: by 2002:a05:6000:1fa5:b0:386:45e9:fc8a with SMTP id
 ffacd0b85a97d-38880ac21c4mr1917804f8f.5.1734094208479; Fri, 13 Dec 2024
 04:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213-module-params-v3-v3-0-485a015ac2cf@kernel.org> <20241213-module-params-v3-v3-1-485a015ac2cf@kernel.org>
In-Reply-To: <20241213-module-params-v3-v3-1-485a015ac2cf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 13 Dec 2024 13:49:56 +0100
Message-ID: <CAH5fLghA6qHsSrC1YL9M=e-YHBa69xr7dp+_9nNR65C27ssO0A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] rust: str: implement `PartialEq` for `BStr`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Trevor Gross <tmgross@umich.edu>, 
	Adam Bratschi-Kaye <ark.email@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 12:33=E2=80=AFPM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Implement `PartialEq` for `BStr` by comparing underlying byte slices.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

