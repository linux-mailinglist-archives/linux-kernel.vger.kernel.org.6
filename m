Return-Path: <linux-kernel+bounces-545653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5529A4EFA7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D961891A9F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9272780E6;
	Tue,  4 Mar 2025 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bkaC8UBe"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A00260384
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741125457; cv=none; b=aDoAr2Usx1FZ5P9P02+D9ORFpo6g4Hb8NpsbPwzuXkZJVqkdVVXV639lVjZqQ87cxf86vliE6Zc6CbFDWJy4OybhdWIzEDTsrBy3JXL2uuj1CHLHJ0UE+93RgaONmRQi2TVQXA625IDrGWSI6PbJ+cw53JDBhPZFYVadmp3sF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741125457; c=relaxed/simple;
	bh=KzrIAcArmLOe3V1Ys+bs9y+LLe/XSWtbLOyhy2D+VqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyjI2U8azK8rpxcnPCsMi3YypoWAfHnt3nbjItni04Eb/8XFwWgR+6bKnajx/h4AfxIrIRYzwxNkMWhp80UMJYWWW/bkxMDner+CRLtpRMaT7ZvAgKeFtXZS6VNzu8DbM0oFuObF2mnomN4zJC3a0txseX9pF7my6jwXoHjWJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bkaC8UBe; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e549be93d5eso6648873276.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 13:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741125455; x=1741730255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsnikvCe3hOdMVeN/xhtWmCodnyXPzUwaCFk12jXD3E=;
        b=bkaC8UBeyV+6iTNhL7uDElTcS3201kHiMWEc1FMXzAdwMNkWYZLkHnogppVerOK81m
         KLnoNDjYnE4rxQcyVsT/eXRXn/D9K9f2lviEodsQONjWgzj5v2JuxLYVVynRE4yEOEva
         oiuRX7Wjl/dQ1+2v3UY7aNVL7emIikrFe161NQ5pDaD+LQ3geLqH1pJEQPmmk3nLa9i3
         n3gS2N4e0zZr/hU1Z+dbHVEGxsPBoWusQCj0wHXIdcLVjtmmx4kDTdCQKYvUbhCYn9Gr
         vi7ron7PpGnarKkLs+AQxaMLnckOV+Fey+ahHq0LqKistGoO46PMeaI8rT3IRG1tqE/G
         lIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741125455; x=1741730255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsnikvCe3hOdMVeN/xhtWmCodnyXPzUwaCFk12jXD3E=;
        b=jhAJBv4y6QjjqV+sxav/A38zIQUQTK6SnnNMpJ/aWzRPsI1ptnNzvR/+qMhkJprW9+
         XBVoY3RWzta1VYrXhOEjsmG+TMJfpaFPKQlfjRTXIV8sDdTZk1YXnMxyLpLyV0/XWpr4
         E5od5/GjfhKWSoj6+EIHcGlqhvo90Lz0Uj84hnQgKUTABVF1t7g+XYfn2JrbqyxW7R6m
         JFIoceX0FSgr737CbqV6CI7+uJ8n/J03sW5yqAWOgUfYnhu1XxX5+o/ziK67eMlGft0U
         cRWU1kY4rFXVIJIXPyV4gvoM8s15LaF14BtIC8Ozh/SHbYwScSPvESlWmwjqXg0Edqd2
         t1Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWaDXL7kKp7u2k3wuwLlbmbnPEpIoq6sgmNThgDzrkKJ1MmL5Fx2k5VDl0H1PQLQbRonRXuEAd0/hjHIOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEoDbM3IFpgx7kzV3i1cLFxCj/CjdebarZjB7a9cBAPEX+Q18o
	HBP5gXq3HS1E8JKPxRgpdQho0hSXsSQwDdL/xddJMiPM+4wnUeqsGq+PCmlp6vWZyU9Vv5/YFI9
	G1Zq0s2viRz/bBxWjNJCQ+gEBv+YDSSJRpZOr
X-Gm-Gg: ASbGncsk6uR11M1hlum4dfvoZqPGuFc9ZWzKeMJSPd0lRZWq/8N9aW35O4dcisWmt8/
	UGUFfsexjU/dYBq0yF8rgXdWH9Y7eclUMsAABOyw0ltbxQz1pj7+OSXBB7zC/AsqWD2TwYIJHMx
	5qVsIJZuxMVJjLCtcIXsORue4Omw==
X-Google-Smtp-Source: AGHT+IHTuaql6CxX9+oW0vQt7zfON8FgK8oPO4Dgi10jT0f1C5KKKb1wciqXNbcYDDrBoPtRQrQnfcYSdkhYI8GxvnU=
X-Received: by 2002:a05:6902:100f:b0:e5d:ae04:1e33 with SMTP id
 3f1490d57ef6-e611e18dd27mr1373344276.5.1741125454946; Tue, 04 Mar 2025
 13:57:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com>
 <CAHC9VhSo3aGsJVd=a3MTeakgU66oTN86oh5sZE8P4ghSk8Rx2g@mail.gmail.com> <CANiq72=n_cGmrb6+6CH1AbGePy5dRMMFyzAFv6O1VEp8EgKR8w@mail.gmail.com>
In-Reply-To: <CANiq72=n_cGmrb6+6CH1AbGePy5dRMMFyzAFv6O1VEp8EgKR8w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 16:57:24 -0500
X-Gm-Features: AQ5f1JonifUOcpqfOyjEvG2iJEgbZmlcgciRANX9bY2EJ9_XOLCe5zh-YKF7hu8
Message-ID: <CAHC9VhT3DqOeYbC+GCQRgH3NNUiOk6Sh=6fzsFaiHk2LEFbi2g@mail.gmail.com>
Subject: Re: [PATCH] lsm: rust: mark SecurityCtx methods inline
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 7:04=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Mon, Mar 3, 2025 at 11:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Beyond those nitpicks, this looks okay to me based on my *extremely*
> > limited Rust knowledge.  With the minor requested changes in place,
> > would you prefer me to take this via the LSM tree, or would you prefer
> > it to go up to Linus via a more Rust-y tree?
>
> In general, if a subsystem is willing to take Rust-related patches
> through their tree, that is the ideal scenario! So please definitely
> feel free to pick it up on your side (and thanks!); otherwise, I can
> pick it up with your Acked-by.
>
> Some days ago I wrote a summary of the usual discussion we have around
> this (copy-pasting here for convenience) ...

Hi Miguel,

Thanks.  Yes, I've seen the summary and the recent threads around Rust
in the Linux kernel.  I don't want to drag all of that up here, but I
will simply say that from the perspective of the LSM framework we're
happy to work with the Rust devs to ensure that the LSM framework is
well supported with Rust bindings.  However, I will add that my own
Rust related efforts are going to be very limited as my understanding
of Rust is still frustratingly low; until that improves I'll be
reliant on others like Alice and you to submit patches for
discussion/acceptance when there are issues.  Thankfully that has
proven to work fairly well over the past few months and I would like
to see that continue.

As far as the mechanics of which tree to merge code, I'll probably
continue to ask in most cases simply so we are all clear on where the
patches will land and how they get up to Linus.  From my perspective
there is no harm in asking, and I *really* want to encourage
cross-subsystem communication as much as I can; I've been seeing an
increasing trend towards compartmentalization across subsystems and I
believe the best way to push back against that is to talk a bit more,
even if it is just a mundane "my tree or yours?".

--=20
paul-moore.com

