Return-Path: <linux-kernel+bounces-429742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAC79E22B4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFEB165A59
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FA41F76D3;
	Tue,  3 Dec 2024 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIBmZhR3"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FD71F76BF;
	Tue,  3 Dec 2024 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239365; cv=none; b=NLZ3jW/R2Vo7kmACys4oe4bCGGpGFxJSBP7Axxl8k+2PeQCt2ckkB4oveh957k/hUWdFYBABbUhrGFVSgzMfvR3dsdN6Oy54KEKHMEJcdXxEJbR9r1NMQPjJwbb3X5TKvrhB2efVoZtbat0run94MpZp25hPVqTSoOT918PLWns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239365; c=relaxed/simple;
	bh=182UmQCu5g2TPwxJMht8MviW/zfKZDGkhyX3FIcaS8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3Qx3T34rPvFgwrz0sJql7f/PxAIsBKiVI82X0khlJwJQV7CQESmETC7IGuBWejzsJ9EQdzKDJham3uq1FtAZ4VlOS7BwhfT4J3O90Fy2SqiI3udHMEubTP2vp+lQMHvuH8VYbkgZMZS8uQNcmh12IiPJiIywyjk/z8Dw40mRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIBmZhR3; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea7e2204d1so449807a12.0;
        Tue, 03 Dec 2024 07:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733239362; x=1733844162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=182UmQCu5g2TPwxJMht8MviW/zfKZDGkhyX3FIcaS8Y=;
        b=OIBmZhR3U96R83JyJWoxRVZ3rybBiSiewM3nwPvv0Ipi+lbVMUattpt94xP+J7WU9e
         nsbDYNVryNibP+g8ycG+JAkbqBgAKZBzmmB85ih98FroeeU+cMyU00MX3UKwt39i+Jbt
         lGhO3UIyO4l8YtqyfVwEUz7nhn0Z+H2xu1s3vcWu6sFC5Y7vIPf7UDye8TZf6ffVYTbN
         jJJfpnS+F5G5WXG+M+FcyTlB5a/BNap6/VGjK3o3wK7yX6WoYNOYYBDnx0x2BNvo/2ge
         6OHAlvyHC0Jr76t21z0OZ8WK3bSiCskixiIZHlUhIkT6Eab3ZhxUS0Hj5RBjcMbLTvzB
         ZWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239362; x=1733844162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=182UmQCu5g2TPwxJMht8MviW/zfKZDGkhyX3FIcaS8Y=;
        b=Lw/ETlN5X6SS+//wUWJDwoUrR1IP2+Wn1jvq736A/IkKfyVEX2lzkrZFwOCL3hHqZS
         qbAqt6zSpHkrm2nk1uldCvabZzJMHCe6QwDzi/rH3oPCQcQ99AK9E2uquh5+Ruhv+YOC
         4qy42iwrq3HKS9oAC33HPNbYxt254T7CDbkLxWXj/7wD/KIPbuj5VoanIgVuswsiuoy8
         dfdy9/60OhIngsI2Bi5fl03+hWPHFlz3b/GSW9dMs5zL4FHIwReG5x9Pxn8zf2FSPW/0
         qa2XNVuWgax4mfQTGYmS1Pz5Ch6a4OehHT4rLUSZrJ5KO/wH7j+rKgdgEZlLSb7FkqXI
         95nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrkoaNG34sLrk/zOwKcAHyaqUg89BrUHz9aZVYQgh0Sp6pqm/84a0vkmzaeXOJEz+nv0vwoex0xVg3Kpo=@vger.kernel.org, AJvYcCXsPnQ71//XBK/cnXsTduyrytYcZrSt6m2mI35DYdX6dJE/gfQ28QsuHSA5W+3eXChfu7lhHwuEjUU0tn45m/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvCDlUT8om4+O+HhAFOcIc9VhIGe/MsfKqsG+PkNl2zIjeFYMR
	fT7JLlOw+tPtjWjbjZUtcHyF1GiSxzFVAN7Gk95miEk+Amxe/QFpBANY8YMWl/RQ1WMxBjdHLvX
	YbyR2j6v4dRLEM9yzcjcMuwjhXQk=
X-Gm-Gg: ASbGnctb67nUGKDoevQWZhozkIclklUY8g7IkRovznqsacO6hkoWmHcFeCyO/f/WIjF
	ar9gpTCJkZ2A7Pmv9M9CQspiyyH6wfAU=
X-Google-Smtp-Source: AGHT+IHWgpear/lfANs3KvdqvVwJNJUX4pt7DEsqjZBvp1WEc8BE/IG+rftI1oghw0DW5bnOVZ5UwFkhvE+O/m/fK/8=
X-Received: by 2002:a17:90b:3b8d:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-2ef011fece0mr1735290a91.3.1733239362024; Tue, 03 Dec 2024
 07:22:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com>
 <20241120-rust-xarray-bindings-v10-2-a25b2b0bf582@gmail.com>
 <CAH5fLgipntMtu7_pdZDZGerGRO499yxDdz2dP=2Bb5FobcykYg@mail.gmail.com> <CAJ-ks9kwGi+hhsNUC=Ti3CL8iJ4mEN2vSkoFUnz67Usu+-_P6Q@mail.gmail.com>
In-Reply-To: <CAJ-ks9kwGi+hhsNUC=Ti3CL8iJ4mEN2vSkoFUnz67Usu+-_P6Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Dec 2024 16:22:29 +0100
Message-ID: <CANiq72=8kyfRomVijZO-5tW-Ckuf5KshCTYnHt96CSi6PbDkqA@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] rust: xarray: Add an abstraction for XArray
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 4:00=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> I prefer to be explicit, unless there's guidance on this somewhere?

I like explicitness in general, but do you think there is an advantage
for things in the prelude?

I am asking because I am considering adding more things there, e.g. I
have a series to be sent to add the `ffi::c_*` types -- having things
like those in the prelude reduces the noise in imports that everyone
knows about (and that nobody should be tempted to alias anyway), makes
things more consistent (because then every use is unqualified vs. the
mix we have now) and generally the code looks easier to read to focus
on the other things that may be less common.

Thanks!

Cheers,
Miguel

