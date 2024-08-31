Return-Path: <linux-kernel+bounces-309956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 716BC96726C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9AE1F22661
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA182D61B;
	Sat, 31 Aug 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STI2AcUS"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4F1BF2A;
	Sat, 31 Aug 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725118755; cv=none; b=aArlV/IqjSa5i4epS2QC/9R7CFkEe0Ai7KkPZ/JhHsAyN9wTVB9jtUKvPVbVWL1WRUCu3LS5F80UC0sRdcipXBqYOQNh9buEeArGg4FlpRMt2LR9/Xy3y+oaY/H6kZNA0EMuo9IInv2LLlpa9hrP2CdsuBAlMXRLg4XGpo6/px8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725118755; c=relaxed/simple;
	bh=ahurQa5FI24eO9xASRdqqtS8a9K0/iZP/9OMmcBshs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjyJsaCPXwB1zBz0t3GVOf9fBprTvp1SRi26Qem0mUnwXXdE0PFLR9x78zIshaNedEJpAI6g4P7vVm+xNPQQX3aOh6PmGa9sB3i5WW6R9aJ+7cT5zgMYa2LVbMsv2PEnhANYuAyeLuJGDOMNTrYmfcO+rpDuGy0cZPVzmOrbbTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STI2AcUS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d42c59df79so427847a91.1;
        Sat, 31 Aug 2024 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725118753; x=1725723553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/+zy1AihyOQmE4HlfQrNJzzAt4M25BoRRVXXmg17Zw=;
        b=STI2AcUSkAqaCQuiRDS3W2hJYTH2b2C+cmT7DySk1vwI41poFEbBPAoSMPyqVJW258
         5TA4nmZNWTK9wc+RdLgM2wE602/wmWSAVAEbI5jPp+HAzsLa6p3SeWPUf6aH6uBaVpdh
         f9rCo5FupasH0wPrylP5vdUVuf52oORqF8i9UE8Ij+moAp0PvLmVWOIMtI+R5bda/Fzu
         fKbWLyqvCZjNxcnFLM1k4i9ZOaeHqgmSVbJye2u67/2IY3TVelLSVYOUZXRP8N3s4n7Q
         +3re6Mhmn/87e7KCVbVAHoY6FiEp/yC9SK+esRh7WEp/jQqn2wF3RDR4pok0BYBgc3vM
         feEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725118753; x=1725723553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/+zy1AihyOQmE4HlfQrNJzzAt4M25BoRRVXXmg17Zw=;
        b=lY+R+1TYpljy1ESVOWeSFLDdXWnpqsoHkx4Nu4ing8rEmILyi8/9VZk3SISWnVNj45
         N0HY2dTvtOnvLauEPRUVUuxEXnSrKQl6D9PNl0Xo/LftUNqVjJUzX7cgYs9p5tZAJg+I
         YMOIyoW+91Bi9UdEAJBBJjt3gvujWWzr7FXYl3KCDz2iIDkeMyaOFbb8J3iHZjiTFh3u
         lGnaIpQQgVPcRCDwBdQSFQc0JL2cvEerbEMCUsFwamTgRhyX1wGB3GuHwlNX8eyOjTbd
         qu52xZNFoSwcwHtgV1xcm5A8zD1HL3HnYZiuyu5LzPfhgZCkJarPRCnnBZSyWHISXKkV
         NEpA==
X-Forwarded-Encrypted: i=1; AJvYcCU7eAUIGUlwh0A/0QSUctOeATTytdE7ZqE26SRYJBy1sjFuTEInub/dVlm430iD3TUO2h8pkJVakrBD357AUBI=@vger.kernel.org, AJvYcCXcKlN64lLWx9FnEHaWgl7Cg87XBAflBYV0RfnsaYsdIl+y1U3j83kKxdnwD+swEqzZJLzctESwBl8G5Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGwrpj7GirP2cN5sOlq8QJAn8SBdmlgqe5B9MyjZ5f3nYQIo3q
	YzMEARCa2uDAyw8fa5Lbr6hvFs6i8HxRq71HVa/8Kka5TZ9zfhhxRouCZwIxg1aD5VYCXWQHZVf
	ZZfWA/dCKvHYWUIbPrl1XojakuAM=
X-Google-Smtp-Source: AGHT+IEg1Cd2X3hLA3oTG5oostG4sSUQSp6gtJ0jWShz4vxrCs5gLOLnAbTw29gf4Xe01NP+H4E21J0U1E4vpgloI/Y=
X-Received: by 2002:a17:90a:ee87:b0:2d8:b071:e10e with SMTP id
 98e67ed59e1d1-2d8b071e1b7mr391289a91.1.1725118752942; Sat, 31 Aug 2024
 08:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822-b4-rbtree-v12-0-014561758a57@google.com>
In-Reply-To: <20240822-b4-rbtree-v12-0-014561758a57@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 31 Aug 2024 17:39:00 +0200
Message-ID: <CANiq72=Up8PEaYeWiquzp0Xquk7ZnjNtn61UOm8qechmU8iA3g@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Red-black tree abstraction needed by Rust Binder
To: Matt Gilbride <mattgilbride@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, 
	Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 6:38=E2=80=AFPM Matt Gilbride <mattgilbride@google.=
com> wrote:
>
> This patchset contains the red-black tree abstractions needed by the Rust
> implementation of the Binder driver.

Applied to `rust-next` -- thanks everyone!

    [ Updated link to docs.kernel.org. - Miguel ]

Cheers,
Miguel

