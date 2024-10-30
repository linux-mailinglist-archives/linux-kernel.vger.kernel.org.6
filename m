Return-Path: <linux-kernel+bounces-389556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109A59B6E64
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1BCB2820C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223FD2144CE;
	Wed, 30 Oct 2024 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heCIvecj"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31CC14F90;
	Wed, 30 Oct 2024 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322435; cv=none; b=RcFWlZxE8VolJ8y6oni1LsubRyh0Os1CclmbW2pMX4xd7Io29Y2i59QCXw3WxVC51wxjBZSetTGKBJMwddUlGZYq8wf2nfAVwtZn9wAlK8oA4bLYObbNPeak8197QjDYtziB01jWbmLOIn8WQ0+pQJZOwz55pg25Y9ccINeiJp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322435; c=relaxed/simple;
	bh=h2L7SUYMGT2A2xgyq9e7pwTUTiOSuRTfqDYwxLdZbAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkM7w4Iqfsf23tART0wr6HQg2dzxrSzatDyS9GbdW34PWKttLeycDLqusDjDPcN7+9sgmJgCojGdkBf0DqwB+rjL/ufn5EeV1/ZtrdJcoSTyQCHnlBLt7FFZyOA8PH95sRPr4odkxW5XO/QEEcHAJ29NlsoQBhXtWuVk5Ds6bK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heCIvecj; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2d83f15f3so37826a91.0;
        Wed, 30 Oct 2024 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730322433; x=1730927233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2L7SUYMGT2A2xgyq9e7pwTUTiOSuRTfqDYwxLdZbAI=;
        b=heCIvecjPXy3yeAWRp6cmlElEdY5f1QQ2xTk6rUTE+k1+zvyrlsNggTSlgpucYUYRA
         FJHLnXdsnkOoezssDvu1gTtSzy0rimQO6uuano25mRHZQycOcqvCoFR/CfOMoZhf8V17
         rdU1M3qj2IimGVZKYKemiyn5cDYFkMVUYQMq54aMBc+wOJNC/giRebnh2hrhCJBh4ScV
         CVKkBsrcdB/bJnk7bb1sQpiKDPeXrAslE8UtWk1iNye7hyT4GTqcHZPBizDtsuzsLDfL
         1uYEmoyQKonlVTbEEGf94XHNTzEV4ZD+WCLMpyoustNjQ7qKRBFG9klueSirtny/m3Qg
         Nfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730322433; x=1730927233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2L7SUYMGT2A2xgyq9e7pwTUTiOSuRTfqDYwxLdZbAI=;
        b=TXYGiin0rPf/xVrJoH7aS3oqewG/ewbz2dnTIumum6FR0jCYmZ7mCJ5QCOIO4nW0QU
         1+i7Km81Zviia/U8BeKpi99yX/ObM8DACIEMoDxYxaerHrWEr3IDTv68Y0QyOo2SYYDL
         Q9P3W1afDENkv9VgFJM9xBCb9xo/hcolGvM5cnJNe6ZpDndp+Q1jtL6zFu9bSE5dFZdH
         ghOsLlLol1x6JTUGkYZq5fzXqAHM9ggvltAOFYS3BNG9Vu7rOjjYm7+dfxHeGyv3BK8M
         GtfmJYcHWEU8Ghetmoqko6To7hf1ypQqYKMi1LPXVl0QQlQhfzAhyF/ySYyNd2GIVRkC
         8K/A==
X-Forwarded-Encrypted: i=1; AJvYcCUA6rGlTb4qBbJeNT03jImElX6cQL6pWZgL5hnXFoiDk2LK7lODVjM5MwZcczZd2NxQEkSqjZ3dC1gA4vodEj4=@vger.kernel.org, AJvYcCV1mMJtGb/pkV0c++ViIYvWoEheZXuNgyd4+j90LMpv853AlXyiqkPL6iFaTcFMS4sQbj6QRaqCkFtW79c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLysblf6XX/j7Ml+s2lCHYA6XkeN+DUCpIR8uNHK1T1heuXe3k
	AH+1nffZpMsV2p1hVncmiN7UXP0HZQtlDaFubZPdi/nQAP13mW1yriK3A7Y7ss/bQNbBW+EzI/b
	tTum6lZRjU/qa29BnhdWxcUBAFkw=
X-Google-Smtp-Source: AGHT+IEo1G6mW80Vx4XiYAKfACrYdglAOmtjPfOP/BUss867AwoFXLEluBwIOWsmOdMPtzcuDICLsOIytFygXEfdZnQ=
X-Received: by 2002:a17:90a:4bc5:b0:2e2:c04b:da94 with SMTP id
 98e67ed59e1d1-2e8f11a71b2mr8298497a91.5.1730322433048; Wed, 30 Oct 2024
 14:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023-static-mutex-v6-1-d7efdadcc84f@google.com>
 <Zx_OoCRrA_WTay_O@Boquns-Mac-mini.local> <CANiq72mb9X0LiDtDe9ptbqm3Ls527Xp+szX7px+Zw6OP8-aefQ@mail.gmail.com>
 <ZyFPvO4jNLieAXUe@Boquns-Mac-mini.local>
In-Reply-To: <ZyFPvO4jNLieAXUe@Boquns-Mac-mini.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Oct 2024 22:07:00 +0100
Message-ID: <CANiq72nb0b7yO5EBubpD63+u6quvaOTmny880DmzVwKqbeYHRA@mail.gmail.com>
Subject: Re: [PATCH v6] rust: add global lock support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 10:12=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> "usually"), I submit my PR at rc2 to rc4, and tip will carry that into

Ah, so you only submit up to -rc4, got it. I didn't know what the cutoff wa=
s.

> Got it. This particular one needs to be "// SAFETY: Called exactly
> once", right?

Yeah, with an ending period (pedantic nit, but it is the style we try
to follow).

> For this I'm following the precedents in tip tree: always put the patch
> links at the last line. See the "Commit notifications" in
> Documentation/process/maintainer-tip.rst. (And yeah, I have to manually
> modify this after b4 applies the patches if you have to ask ;-))

That explains it -- thanks! Sounds good (though perhaps the bot should
be amended to agree with `b4`... :)

Cheers,
Miguel

