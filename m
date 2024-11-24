Return-Path: <linux-kernel+bounces-420352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4049D793E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 00:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0BB16337E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0112188591;
	Sun, 24 Nov 2024 23:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC9DmIkN"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F896F06D;
	Sun, 24 Nov 2024 23:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492553; cv=none; b=iI9VKiSCnnIMXU6NorLfm1dLCRZeYn/pEZxC92LJpOREGO98c7nDC+PFkbBBJ/ni80P5GzzpNC7s6U4Im/Q5SCP0dnSY+1/Hq9MnJ3FpNE+JizhrQX/vbol/KWtYdLhV7PE7vt42cQjndTo6ynbzhp5UKtFAXxcHNn72hKjBDm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492553; c=relaxed/simple;
	bh=ahIJZ5ejiMwN/JQi1QRVHKcYWH3Zh8Fe+Ycej3jmRV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnpBTORh63Vv0rKTuTJUrqlDb23cmZgnsoptnArSkXkfE25wP11bCif37Ed9sq4xIV51N+Mvdm4UL7aB3fp6L9HFKcxGyAZrloG7g9Muf/iUdC4+LX1g9GxHxg6WlhBAYqoQbEUftlE/pbH3K1S8BFxyYuTRWXfzezPdjX71e0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC9DmIkN; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea4e97ca43so651905a91.0;
        Sun, 24 Nov 2024 15:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732492551; x=1733097351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahIJZ5ejiMwN/JQi1QRVHKcYWH3Zh8Fe+Ycej3jmRV0=;
        b=iC9DmIkNOxrrYI2U5r2oeT8pbP0caWBEARca4QkVeB05MRKca38CxKBYOxFHgKRKQg
         PIJfcJxIXM7rbwHeDar5E6YfzfSKi0/5BPPpFHIgx6YVkWKOinM8vuuABTUHjgyjY7wt
         KhNBvB+hz5DhlB0KBkvpg+IRQzbBwGWrAqIKOeQzBG1urgkKrvvlknVV2/1deHTpUVTR
         0Wa8EbLxpvOZFViVmG5pl6tCMdIqCeXWNxayTqRLEX0TOewRfiJA1QmU4dXGIJLAayIT
         YsEilPbx7poplE/dimHPSFAvAgovww29BjfDjCLW551xseTvoQuBOyz3dN79liCG1/Zt
         Dpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732492551; x=1733097351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahIJZ5ejiMwN/JQi1QRVHKcYWH3Zh8Fe+Ycej3jmRV0=;
        b=QUtVAicrpCZxwdUKb9PqDt0qURoW2LErm85d2AYPrHN42o24KZt0ogdEPIJJlmeU/V
         GxTAF4YxtW3R8Bc1th+iLQUbBisSn2STgHwQxHH2j+d9uLZqRe11uM7N4whZQaaV3MHU
         UFUs3kHvpsIg4BOp87DERsy6igwJl+6AQotW5H9p8WFwmgIsQnrnQLcCj7hzPYhAUJA5
         RNnWW64NN1Oz0dt442X1N6PGWHdFgg1dmSLaRWlYxJTQZBHx+JPVrcaA5bdrvJYsLfFK
         tqt+uMw382gm9EgRDVQOS2neiLmnlu4WYXHUSLZYrxH7AwefsgpqyTqCGXMBVfwl4BOX
         kWiA==
X-Forwarded-Encrypted: i=1; AJvYcCX63W48AaP0V+X/dnQFKPl0xX6nPk7SFqEv1Bt1syExfZ+Q8yefs76iLhzrUEFfiwXrV7lmnf2OJgVtmdI=@vger.kernel.org, AJvYcCXAneRKcCn+t2MwJc8zdb3AJGF4rGvUtAJAP31JjmHcN4SG8nYSQPPsPGmJzILCgiQPLLls8hegIoX6LmN85SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRY6Mhb2v1BI7LLh0ZtQfHm1VnwtremE0ghg/k9bKKdN6DB1pF
	3gdN+WKOLJcU+XV9AKEfstHVDVSAM7I3usFhegsP3QI+fphX+sMF7nnIlB5cfA9/Jq9HhYEtlSB
	oURgjHKeygO7SlY4JElKI54aquQw=
X-Gm-Gg: ASbGncv6zdKZEb9T5+QYhFv7iZvOJ14l/WoSXgkQHNmzkZmFClLwdW+wtUMmN35kk9B
	aYSd+svLse/ll377UnHJlxlCKJwYWzg==
X-Google-Smtp-Source: AGHT+IE0GVGXq6FAVz/1ZUH7H5yK+sxF6g6rGaYnxrsAhuXE3bPolOfAEBR2JrYP4HASDtXdNgIzJ9T+bA3QL/2iIhQ=
X-Received: by 2002:a17:90b:1b51:b0:2ea:580f:6c0c with SMTP id
 98e67ed59e1d1-2eb0e024be7mr6003360a91.1.1732492551429; Sun, 24 Nov 2024
 15:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116181538.369355-1-ojeda@kernel.org> <CAH5fLgjU3BUU4nu6LscYKHTtZ8WSChXvf391v5v=xNK_2w7nrw@mail.gmail.com>
In-Reply-To: <CAH5fLgjU3BUU4nu6LscYKHTtZ8WSChXvf391v5v=xNK_2w7nrw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 Nov 2024 00:55:37 +0100
Message-ID: <CANiq72mSo9aq9Wu0WemVRsC2XXDKvw2D=rTAXg5eUF3g+yHO1g@mail.gmail.com>
Subject: Re: [PATCH] rust: allow `clippy::needless_lifetimes`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 10:51=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Does this need any backports to keep old kernels warning-free on new comp=
ilers?

+1, for stable, yeah, if we want to keep it Clippy-clean (which I
think we should, especially given it is straightforward). I will send
it.

For the LTSs, which only support a single compiler, there is no need.

Cheers,
Miguel

