Return-Path: <linux-kernel+bounces-543874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBE1A4DAFB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5441880409
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E1D1FF1DD;
	Tue,  4 Mar 2025 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOZ/Q1ss"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051D21FF1C7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084627; cv=none; b=REBDDXO/aAaYCIgnglEjNhfREjkDjRwTLgQhtLI0luvRqBj3iErqypzF0PgrIkSqCD8W7vLD/TcgG6U2yfWXz6WqMeX4fHAeNLlcy47DceLH2v6LBx9HumG1x4q3y5IFVe+Sf2aTf8FHn3cn7yXUhuGNkQlVMX0mSJApzffYWQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084627; c=relaxed/simple;
	bh=Ph7Z/eQgdHPhRHi/cGs92I8dsrsvDBOdjLTZ5ObY0Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riqGeUOl4FaryIdE/w7SGhB03zU/z/uZqxQrV0o9TuUsp+tF0mPohguT41FywgaGMdAKEngieb+jw/0Cs8GOPkyh39OYw0mNmbAzVITLacGWYY0P9cGajn3srUi4ShM2CEg04RVbRW4sL5lZS3oxfE7YfkoGztr1FhI0yUgff1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cOZ/Q1ss; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bc63876f1so14121595e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741084624; x=1741689424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnfoXHWbkxpn8CLKu2E2rVl/Oeya0FmkAvYXgZjUPXs=;
        b=cOZ/Q1ssJvP5NH+A/AgBtKieSCXSv2M4jeXGyim7rZDJ+kGJc7dYtK/M1Ea9C6q504
         4Lwmha3jPiwBJmA6hC5GXBZLs3MeNdqZK5R4c73qdghfsmwYZZVWtmHzrtzDK4f2EfyY
         hDFSb6gQs+xT19BeqAs1FXsa+NGhKhnWroL+RU6FQm8Kb/LlQu545FKNUX9WuTX/7pe5
         H5UtU2kfvvP61ZNlhIVGqpKOigycvecGOKQR3XBBKGgHMaFfxThmp5xSBiu0GMNn6N7S
         ++N7tC4Rlbhg6UGIHiR2x6yRMe0J544C5kHxEVgcLelRG0uQGLw0gYy2osXiGFl8pd7b
         gr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084624; x=1741689424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnfoXHWbkxpn8CLKu2E2rVl/Oeya0FmkAvYXgZjUPXs=;
        b=uPYQ3ooAJJyhhzrm/i0IpkQrigIq/vYgaQH+HyvHRcLJD1T3Er0rgbCnBiGthOhumX
         0a3coEKAiYiS8MN7za3q846JA4zCbxgjXgIaJxA0yQ4GLvIOaRuvIts1Why85rPb97Cu
         jChylYGU5uioUqlEhCAVH4QlBxoJUWPdIV1fXvTmgdefafj4OfB29ZPuVVeTk0Ss+eC4
         ZCidMdjpml/TRMvUpEiXFgfvyb2EskysRZJu/ywfr7ouzwDDoZcquApR6huGcew0aQ6I
         1Ztqp4L7M43bgSuOvRGdoBuhCq8JxLTiXym7zNVVcaJV9NxrgdbB1gSVsueRLDLlwpJ/
         /SZw==
X-Forwarded-Encrypted: i=1; AJvYcCXJU76lWMBQYLDztPVlk/dPUNWtVETUo6jL+6+wAGwGrkSWvQ3vSmxfrm4iSVkFb7MpApbVQ51Np0Xwim8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykay776GJrvEukrRyDzpHmw/CrYS0lB3nQr3CZYFigCkm+c7bZ
	qNTKqeMsqU5Qr+s2Z7+ryOe0XKKgaG6Myo4+mT5qdJdppTKR0kVDEpSdWjSuJDuX5Xfl9Omyty8
	/ZPc21rGesY7DBk+2yULoiOTvwJOW4tDxPoOj
X-Gm-Gg: ASbGncuPvWIM3XuWgJ2bkkilgp9trOuxBN4D7KcWY/s+o/u7Hlh7mpGEzy2a8gRb+07
	L0rjdjLZ5kMQhXAaf7VIflrNdb9PCCK7aPHTn1Fh7Bs1CbOvD7+0b5G/R5upVMvcs5/0mS6zbKd
	WhF0pDQGLEzkapd7IAxnZFeYUZQAPrqgUnYm/je0VhSZoBEu7prQZnqVQ=
X-Google-Smtp-Source: AGHT+IHnZGopTu14rJhQmFHdcWS/CmtUr7Vq5gBSfsQMqLY+ddlQ2k7+IHh8qMlJWxhe9a/q9UgVjpEYak7y23CaNeo=
X-Received: by 2002:a05:6000:1786:b0:391:1213:9479 with SMTP id
 ffacd0b85a97d-3911213986fmr4342313f8f.51.1741084624201; Tue, 04 Mar 2025
 02:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com> <CAHC9VhSo3aGsJVd=a3MTeakgU66oTN86oh5sZE8P4ghSk8Rx2g@mail.gmail.com>
In-Reply-To: <CAHC9VhSo3aGsJVd=a3MTeakgU66oTN86oh5sZE8P4ghSk8Rx2g@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 4 Mar 2025 11:36:51 +0100
X-Gm-Features: AQ5f1Jr6vlrRiPYv8T2mmkPxNCUjz2IzWb_BB5bszisP39eJSBbTg3T7YfzmtPY
Message-ID: <CAH5fLgi6ZFBqtyUuGPbdST-tEzHJ=Wp1khDxQhO_h+bZiFVj8g@mail.gmail.com>
Subject: Re: [PATCH] lsm: rust: mark SecurityCtx methods inline
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 11:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Mar 3, 2025 at 10:30=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > I'm seeing Binder generating calls to methods on SecurityCtx such as
> > from_secid and drop without inlining. Since these methods are really
> > simple wrappers around C functions, mark the methods to inline to avoid
> > generating these useless small functions.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/security.rs | 5 +++++
> >  1 file changed, 5 insertions(+)
>
> While this isn't specific to your patch, Casey's comment about "free"
> vs "release" is something to keep in mind when working on the LSM
> bindings; what happens inside the individual LSMs for a given LSM hook
> can vary quite a bit.
>
> I also saw a similar Rust patch where a commenter suggested using
> "impersonal facts" in the commit description and I believe that is a
> good idea here as well.
>
> Beyond those nitpicks, this looks okay to me based on my *extremely*
> limited Rust knowledge.  With the minor requested changes in place,
> would you prefer me to take this via the LSM tree, or would you prefer
> it to go up to Linus via a more Rust-y tree?

It would be great if you could take it, thanks!

Regarding the other patch for "Credential", is your tree also the
correct place for that? It's a bit unclear to me which tree maintains
credentials.

Alice

