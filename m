Return-Path: <linux-kernel+bounces-389041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733E69B67CD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3707B28410C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA33204F8D;
	Wed, 30 Oct 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI7F8N+b"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F01F4738;
	Wed, 30 Oct 2024 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302057; cv=none; b=XmAH7RKUn5V+cF0wfEH2cnDQp7X+ZZVbcp7aD2N0+xWDqftzyhE/m185TxdO+uTWQrPGdwJtOXL6l3QEtPspR+SrdC1OraCHKVXLTJDxJJ6t1nerHrkYDoLSwT78s9USJLzJdot6JnyRJ5kd0XclOzuOIUsmBB60xzlWuBY2Pm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302057; c=relaxed/simple;
	bh=Vp9pkwaDlcQA2MR5Vk7C+O+0ZH8fUUsq+HZZU2PNuy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPzjVHHiqjXBH/lY5apNCG1/uSgA1B6z+k31L+Welinx0K0YQqF6zDoyFxd1ZgbL59iiROihiyLwQ+IoIwTfgt07hEiCcBILVZzdNrzB+/MS6Pp3PeoTbOwlX3D/8Gjo+CliSpxubNf+rz5HN1DtWcWus6NjeKFKkjENr+ZDWSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI7F8N+b; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e576d665so822019e87.1;
        Wed, 30 Oct 2024 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730302053; x=1730906853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vp9pkwaDlcQA2MR5Vk7C+O+0ZH8fUUsq+HZZU2PNuy8=;
        b=PI7F8N+b3SN4ooHotAPELYoXPqr6qy6gXbz+G15cm5unxD6I/MqS1dv+u4b5mnam0w
         /WJz7u6KR1p1J3nVs2HeEVWadaTqYJUFmF7bCnFQE6pmNnFyVtkgTRSRvmnWsomTKwJv
         B6a01E+6X4DxSGd/OVPpCHPJgyCn0QrjAuiG1RoToZASOQql4h1KL4ToBE/j5IZuxBcI
         3sH+wqo4deS+X7kImDkhATOEbK0WjtF5MI/yKYV9JET38p1ZZWwpB5Glbqb8vm6YSzv1
         jBbxuiCK/m4NCZVJujQQowacpiTQWs1hyUkuazzHs4R2Q+FcHJZ4zTFhtalqdcdO2Lbi
         xP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302053; x=1730906853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vp9pkwaDlcQA2MR5Vk7C+O+0ZH8fUUsq+HZZU2PNuy8=;
        b=SB6PU5XSq8YxujcyZlsgGKXXls4DQKnQG8B2fkMxah7ULsOYxM+XzdiU0X9cFzKmUO
         lIlEu71yjpCav3lzesQhB5T/H1KzG6PerNJJvq/T19yPs9uGs1qc5GGzD8jAdYJLq8Qt
         nrsqHjQ3APefxsnroTQQTFqOoIIcKuaeDr3TXFym4mX8/9XPrra1iEe6gxuzb7y1R0He
         Ipqm8HxpfxpM4m9Hr0dziyOIqvCXmhRF0dU/CbfVUVMz9EsK9KETk9fFobjY/Ou2DQxO
         j3+ZqZ38kk1pjWiwBLZ/fBNUsbJ+jWckC7uFueVYbHMXAaPClSUWVj+plf5jmmeuifvZ
         hPrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEBDAD8pGyTeayTqGWrNwcwuGpBbYHEosRJCaoXlylWdqR0GlqVDPrSnmxVydSqYvAVmblsWOEK31QDt8c+5c=@vger.kernel.org, AJvYcCWpre5Lg7Gtck+VZ2ItmL3pqRzczAJbtDFDZ+lSjyQzEQ8qswcc5GNTU7WmJ7U3mJ/yMH4IbznAmuo6sCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTBhgXvpHj3azUz6LCKNokgJzMl0c+kyS7qxyQ93NMdFJzWTij
	mH/PCpT+YhVV7YFejF2t8u9dAKyLRB8kFmyzF/p5nAyvreS1RiiVVu0GrIZ3Clf0/z026iqfIvQ
	YIOXkgmnSuct6sm9U7aIizR9MdpSxNS9PWSs=
X-Google-Smtp-Source: AGHT+IENK6j4uWzMzppluYi0B0zwjvnL0IPEkGkwxe+t4JBumOn/x+9goTnJmpguEkp831ljUYUceXq6ndhNJCFSgRw=
X-Received: by 2002:a2e:a9a4:0:b0:2fa:cf48:14a3 with SMTP id
 38308e7fff4ca-2fcbe062327mr23983151fa.7.1730302052943; Wed, 30 Oct 2024
 08:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-bindgen-libclang-warn-v1-1-3a7ba9fedcfe@google.com>
 <CAJ-ks9=8Bo94Fg_By956ce8X0r-6xBWGO_Ka+rCQ2h3tF2nkRA@mail.gmail.com>
 <CANiq72=2ALWH-TeHH+=YEmkWw9CEyNUp5EZoBFU=xvqewheeWA@mail.gmail.com> <CAJ-ks9k8S3g_DaWYOdLs6JYr32OZfexqOoJ3XNf87HQ221-JZA@mail.gmail.com>
In-Reply-To: <CAJ-ks9k8S3g_DaWYOdLs6JYr32OZfexqOoJ3XNf87HQ221-JZA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Oct 2024 16:27:18 +0100
Message-ID: <CANiq72nPgYGgtB_H+yJoSsoW8h7p4VvwfeoJL3348f-YpdrmqA@mail.gmail.com>
Subject: Re: [PATCH] rust: warn when using libclang >=19.1 with bindgen <0.70
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:24=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> It seems to do a lot more than report whether or not rust is available.

It checks a few things to decide whether it is available or not and to
inform the user of some situations that may not work/ideal, but that
is the goal. We don't do extra things unrelated to that, so I am not
sure what you mean.

Cheers,
Miguel

