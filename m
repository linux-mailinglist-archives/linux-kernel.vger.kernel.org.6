Return-Path: <linux-kernel+bounces-373459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 179569A56E8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 23:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98D91F21E7F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDB3198832;
	Sun, 20 Oct 2024 21:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agXoNP4m"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D53A1CD;
	Sun, 20 Oct 2024 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729458271; cv=none; b=D+FSI6NzLa8yoQS4bZDyMV9Ely80dfu/0uCqBiQXLEK0bZueWfj9TxmOGqeCEeao0T+Tx9g1fszELshKT3qa+0CoeWG8qFIZPjh9nEmZ6tfakgrrnQNCffrTn4LluPDd11CLAuDUiQXwwmjBiNoezWLOEYelPB21VfqW0DVzGB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729458271; c=relaxed/simple;
	bh=UNqWV/dZwFS3eMNwGcF9VEENhaytIiNOCmaKg9KAd3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOPiKXX9nxBr+8Iqo3ua2fd1b+V/WepMdTh/+z3gphEtIkQRRTwD9zrt7UVfFaf+YggDm2LecP9fqvGJehcBBGHGqTFYYt8XcMAaj9Wn7MuISDoI87Y2eaZIAJDqoS2VfKk3hX16TnJaU6HAenIxzF2T8RCCqXvbxUQbDoOBBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agXoNP4m; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2b4110341so682954a91.1;
        Sun, 20 Oct 2024 14:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729458269; x=1730063069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUATmSfCv27W3Mka25ndw/fZUUEfWKvZU2Hc9HtXU4g=;
        b=agXoNP4mVlLa+BeZ9vc/AvaS+mezvSzKQdgbxqD5CR7Icp1SsPAHpsy7sgfSt47roD
         GQm2I9hWn243anKhC48Q3GmGo7E+8zvQTbaAP2IgXZUaf2DE6NXZB6GOXntrxi9Qt20V
         bXpYulr4x3tiUEvPRUhj9mYU4T69qVTs+7hdHt2cIIK4mduA9HLQ/fXW5upwyhGhw5j+
         367zQ6hs4dzG8ENQPxvGTaCimWvxuUDZjOh9kBkuKaeVPTsX5WWFhN3UXUe9ErDKv+1h
         MLVsHPuJnq8Il4lXSn5Ts7asnc/6DgNewTR3X8H0vZ8peNpI/xX18Fy8mJir0NGnKTcY
         NLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729458269; x=1730063069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUATmSfCv27W3Mka25ndw/fZUUEfWKvZU2Hc9HtXU4g=;
        b=Vg7IOC6MSxXNdg/70ue1XxrS98QP+jGBQ+xQDYBJ462eiB6PDF5Gn9HTaw2N5CbhLB
         yqmWsuHbMUG3uQ/JQ/oM9eDC/u3syGsTO3Xk3j5jzz2vWwAxgxgYOdxvIL3Q2OJXNVRP
         G65+hF3mw0q8egZG3hssrefbKWm2egzmAWSKjQYHy6nSqLP5aun9VsLrujBvM/AxBRwr
         +d99siNb73t7FwUE+2/tbo456wpGoAWxTTFb5pNCQIwt0E2U/Bgrqffw14yGB00VwtDu
         HH/aX6GQY1yqeaAwYCmkVi7Gp9SfyHWupA4j9IZdm0i9THTF5kVLIKL1UItH4BmIMXf4
         G87A==
X-Forwarded-Encrypted: i=1; AJvYcCV5rgTitn4uTu+cqBkL5HEizRKdRTGqeOWUVy69Q/+x56RRS+DehsXbOwjEd3G0pUDko+xTlgjUl0yqICTkszA=@vger.kernel.org, AJvYcCVaY9On0WdIbuCtD/Yk3N9thYo1GD/6sHfQnTc06kp09G8Z7tEJmyk4xYp9uHa7cy+zBmJdhWzyozvmbf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWAaBmouhJ3sTzKDAGIviVbbNr+E6brMVN8bxBwTNPCCVcvxsp
	+kg3RHWpJWWCbzI7QvaiW1G80N1bG9Wx+1D0qvZ7JP5Xg3pUIkY0r7Aa91+6t/Uo33TRwXiMCY2
	TY9yD3GPSc1i1VP608+3IeiJ78RU=
X-Google-Smtp-Source: AGHT+IGbb8SvqnhDRVnQof3SJzAdGMzboePIlLB2BLxQxSnmOnedwP/eIElCwjyUsMPZIW7RxW8ToytJ0ApID//+6SE=
X-Received: by 2002:a17:90b:1889:b0:2e2:c1e5:2df3 with SMTP id
 98e67ed59e1d1-2e561856753mr4552264a91.8.1729458268896; Sun, 20 Oct 2024
 14:04:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019084048.22336-1-witcher@wiredspace.de>
In-Reply-To: <20241019084048.22336-1-witcher@wiredspace.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 20 Oct 2024 23:04:16 +0200
Message-ID: <CANiq72=FAV_aijHyPLO3EJ4LVXQVysNfK6y=RqNZSKdDTXkg6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Cleanup Clippy issues in drm_panic_qr.rs
To: =?UTF-8?Q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Jocelyn Falempe <jfalempe@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 10:41=E2=80=AFAM Thomas B=C3=B6hler <witcher@wireds=
pace.de> wrote:
>
> The file drivers/gpu/drm/drm_panic_qr.rs has some lints that Clippy
> complains about. This series cleans them up by either allowing what is
> written or conforming to what Clippy expects where it makes sense.

Applied to `rust-next` -- thanks everyone!

    [ Reworded to indent Clippy's message. - Miguel ]

    [ Reworded to add Clippy warning like it is done in the rest of the
      series. - Miguel ]

    [ Reworded to mention the redundant closure cleanup too. - Miguel ]

Cheers,
Miguel

