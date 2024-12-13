Return-Path: <linux-kernel+bounces-445269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E582F9F138C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103C8168585
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A7E1E47C7;
	Fri, 13 Dec 2024 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsQx3+cm"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CE11E25F8;
	Fri, 13 Dec 2024 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110696; cv=none; b=Uj846mjf5LA3PrId1ZV90qUd23K2t2h7pPggq9iqzNbSDIxmCUjwqbTc+d3dgb93RJ340lQA7PSVbvmTOne3FBOF9jMGf+ddmpVUdBo4UUgmrMtYeDsq7+zLql5Pfm+KK84hZKNhy32he3fR6gQOkdIqw7HwyCdMo6wXkXzIsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110696; c=relaxed/simple;
	bh=XeiDdqn+E6wo5Zj4adHw30JgRPe0PPB0gjeoDHKjNcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtmQhQlN9XXXHWUEXDH666VkqBFyoQGH/m9O39bSIbPXnLzhuLrBSzl8IFIuI/MoJgvHMl9LKlf5GWUxm45P3CX5QM8CIp3/SG7n/vjyIOUB0CyU32grswF+mazFV0Bh/SfxPUy4ugIJ51dUejz+/WsicUq2wVWSgxegZbdlfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsQx3+cm; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7feffc649efso269376a12.0;
        Fri, 13 Dec 2024 09:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734110694; x=1734715494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeiDdqn+E6wo5Zj4adHw30JgRPe0PPB0gjeoDHKjNcM=;
        b=jsQx3+cm2ZyaVfqdOEKeRL5KaLs6xMs+dMJJPxZM0f/ZP3XoMAb6N4982IRi+5zpZj
         qAqgYjnHANI90S2k5YbMcecWvLGGy3hrhHJ0+1uSoakDQR2bfMagZ2BmWH73HQKZJT0V
         5hbx2Tcga73pLHzog+NQS+mkf/grMvPok+8XqBsxrvVZusnrUTgQlqm1Yre0BmC9gEZL
         ZSo0mQaOzYzATNZ/P/yXZV5ys+U1YoFItQzhVDOmr9Y49wau9B27UBQcUMMjWGJ0UIuj
         cwxLA/US+UcaDbEP+vQVQIfct2Vr99/KSL1ZdXHEjQvsHePHD+G/Qtryn9gvbcQF6J7F
         StvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734110694; x=1734715494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeiDdqn+E6wo5Zj4adHw30JgRPe0PPB0gjeoDHKjNcM=;
        b=fZvjGAttyhhn1fD1X/qmBeXJB1rv1YbqsbRCasrdHSnZtb/6f8Awhn+1kf02gZPsSq
         bB15/eHgz1ov2xZLhDBW0yLWFfmrj7kFS4jOatJsbXS1FA0ojU9OxA0Ztu6nvnJysBeo
         gRMGfXdqY1Jway1GyrTbX622Lm6alnzmICwtvVxTvXlq8RJcLvmo2E5Mr14gjCZpeBH1
         6oOe0u3A71TRcrJZsOnGRyX+tBhoAXCsuPAnOiDdzEYgENlRDzPcDfH+dZJ18dlyVyYR
         87UCy+sWyFfm87+/vOf1dqS7REVykH+tsCu1qKFJKmFBqhqoy5yp+6/hqaSL1GCndV8l
         LAUA==
X-Forwarded-Encrypted: i=1; AJvYcCWctYNLEu50vE9Ng2+oAQEQ+VjNzNV0JF37e7aWPLgM1FzFr/lHcpAFzFyFZOlpdhm1O1WBBFNASl39nt4=@vger.kernel.org, AJvYcCXlKAUgybSI5MHz+9kfUSVxqeWAyeu7vwyQETGk0Qzri2GmVzLntOWlRWEhZKhK1xYYDZIAO8rWbyvKRSPf1mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBtRJ32h7qXAQJ+KJX/yQu5aFBDOnImn2OeqTS5FdUW8Y+nqxQ
	SiX8Wm7SA6WCsQeapYH1FxdK6eAn7BR80HqW3mRkh5Am3KZoMg11ddlMCrQkgaKy9GKDkvT6lSl
	RChZq9lbcQSPNSIRkZndo/Y5Kn2U=
X-Gm-Gg: ASbGncuGu/Ma4PIam6mv2Yo5+/V0vAOig8VMJD+wZugELGlw6hqd5ZMmkD4Ozy40wwO
	gQeic146tp6JCJ4Zi+CfuGK12GG1nQSFCnyNEsQ==
X-Google-Smtp-Source: AGHT+IGJDBsQSAoNDr28Rh9mkCMbo3opglsMqk0ofcgse3NQSRh901z/GPMRdSedrBwDu3neIE41tH70DQARrmyRk9k=
X-Received: by 2002:a17:90b:4ccc:b0:2ee:a558:b6bf with SMTP id
 98e67ed59e1d1-2f2904b6227mr2018495a91.8.1734110693892; Fri, 13 Dec 2024
 09:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-rust-xarray-bindings-v12-0-59ab9b1f4d2e@gmail.com>
 <20241212-rust-xarray-bindings-v12-2-59ab9b1f4d2e@gmail.com>
 <CAH5fLggwK0LXAsBnP3FtFHCnEzzBNNZfsCy3iJ6w=nT07CHgVg@mail.gmail.com>
 <L-1MAJJDE02BClBz6dbLWTKAz6RM33gupqt5fPEyX9tYoW43aDrrH4oY-OerHc17mpVTgy6j4e6_EauQQY8Viw==@protonmail.internalid>
 <CAJ-ks9mTEcRg6=ZiYFX3ebHSYgMwTv692ufUdTCoA1vX5E1nNg@mail.gmail.com> <87pllvczag.fsf@kernel.org>
In-Reply-To: <87pllvczag.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 13 Dec 2024 18:24:40 +0100
Message-ID: <CANiq72kEk5y=As6rOSe6V7w7AV3qg7u3Dd+PKtwWzzDEi1a1RA@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] rust: xarray: Add an abstraction for XArray
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Tamir Duberstein <tamird@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 5:40=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> I am! Let's not restrict ourselves to a subset of rust that mimics a
> language invented 40 years ago.

It is not about restricting ourselves to a subset, it is about picking
something that is more readable for the majority of readers.

It is also advantageous for the submitter, because one wants reviewers
to have the easiest time possible reading your code, and reviewers
will be, in some cases, new to Rust.

Cheers,
Miguel

