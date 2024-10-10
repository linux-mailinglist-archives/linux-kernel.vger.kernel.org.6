Return-Path: <linux-kernel+bounces-358822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5402E998444
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812B41C229CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6982B1C1AD8;
	Thu, 10 Oct 2024 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oyriwGmb"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383541C1755
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557903; cv=none; b=Xrc3KYHr3EsN2pIrrsT5pyGaeqPUBdVVK/HtAsOZcs6uPPPyx381mJWeGq278Jw7m91LTWsAket24SSJuoiaWPdKWy7LF3pTtysd0DrRyaKAdGFSEAq8RGOppW4MSagudrI59HVBzXd7jSXlzwP1d+kSlTfBH2hThuiyFp70/24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557903; c=relaxed/simple;
	bh=StoaWEIYCCwjnd/+Bfx66/ND8mpJjgF5frrP6tUdr44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SE3+O0q2dhudRDRPvcKqppLTluwU7er3BUmH8jNH7ycfy5la55U5D2191w+RX/KzGVYdKWczUzG48YGQi4kDQbfaKe3QA0c9zkXB50DFzEboEz6qDEgpGMpncsv5GO3DTlGZk2ydH3ulS1mUPfSfOwSpLXuWSFAXPhjdBNWPVU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oyriwGmb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d3ecad390so1057842f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728557900; x=1729162700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StoaWEIYCCwjnd/+Bfx66/ND8mpJjgF5frrP6tUdr44=;
        b=oyriwGmb0SYdoNYaKJKK0DV/Nsq8B6E5ts/qZXwUjE+eYIRG9iHrBHSm2NuOvEJLT0
         W4vMmx3v0ZAO2pWTMuFsWpnIw7oRzJddO0KaSk03bZ2oEE4/ug8uOQg6ySQL9qWhgnNz
         bi51pKldd10Dr6knemch1BJcSkzRF91IAn/t+nJf28tNTz3PLL39XI1dEodlCTHGxMfE
         i/Od99sw/meHoiux+1nme7YH7cTfuCPa0XXOta1VuO4ivTzBX9aMll/fhALyHLZSQtCE
         rVCO3hGowiG23KJk01F3LlgAsvBAzpR8uuTnEgAVKRjGZpgzNqBMSSFmpSFfLlxnhy6n
         Uf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728557900; x=1729162700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StoaWEIYCCwjnd/+Bfx66/ND8mpJjgF5frrP6tUdr44=;
        b=So/o7bAHN1hFh8ZbYvaRV6KZX1oMNRdMKcxGhTstcJm8VkAwjJbvGVq8ew/Eu5HvQT
         l7kJJobun/M8Y4XcYpepv5mkh6QaVQGpnzGwPZHKEkLoSJcmx9Ajp9XZWv63cX+UqJq6
         Y6Xe9/PrhnXBqdeXOFlZOunMMD1eyt4elh+QS2iGmqgg+qVTLoVrlOcK/ly/moJ2FtAk
         3X7r1/gKc0mHN5bgjYPL+/kc6Kkj1NM5XZe/SjrwYACVs3/DEHX8LQyuOU9Yr0huD+5P
         VrQozuleLvbnEg3wvqHvvpBHl9HG+W2zZR5E5a0b1OSjl1kghm0OCiiaJHDtYeCik93h
         LnMA==
X-Forwarded-Encrypted: i=1; AJvYcCU0ApDe6fdCUrJPoVo6BnjOdLVqAakCzWAuNofJKv3JdmAuXOogVpLB5QIOqAP0yhoxaArB4PGvWVKJhkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2S9jbqgJHmOm5j8yiB3QtoOvUhXxMUyAadCvzcwfps5LNsA9
	pQo64dCiwgvOYSwe0wqb8elzln01a0Rcmq8hmvpDegxQ/P8YAoooBSjRBdlYcDZlFtko3QvmiQG
	+XgSlu9Vbh+lHMLXPfw4/imxZnm5XeGRW9IAm
X-Google-Smtp-Source: AGHT+IG6zteYy0eiXshByN3a31ubFooYapYA71mK/l2zbvcpHK0YoSgYWnV/kyVCloGT0HPQCGElonWjcU/HzmR4ZZE=
X-Received: by 2002:a5d:4092:0:b0:374:c613:7c58 with SMTP id
 ffacd0b85a97d-37d481d300dmr2263009f8f.29.1728557900384; Thu, 10 Oct 2024
 03:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-icall-detect-vers-v1-0-8f114956aa88@google.com>
 <20241010-icall-detect-vers-v1-1-8f114956aa88@google.com> <CANiq72ndoSmGVzuPR6ikq0HG1kbMp6ADOY8BonD9=ij9tyU=EQ@mail.gmail.com>
In-Reply-To: <CANiq72ndoSmGVzuPR6ikq0HG1kbMp6ADOY8BonD9=ij9tyU=EQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 10 Oct 2024 12:58:07 +0200
Message-ID: <CAH5fLgiqwdKgEux9A-SFAWmhbosW15Ey8j8deKtQa9r336vXZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: rust: add `CONFIG_RUSTC_LLVM_VERSION`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 12:55=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Oct 10, 2024 at 11:38=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > From: Gary Guo <gary@garyguo.net>
> >
> > Each version of Rust supports a range of LLVM versions. There are cases=
 where
> > we want to gate a config on the LLVM version instead of the Rust versio=
n.
> > Normalized cfi integer tags are one example [1].
> >
> > For consistency with cc-version and ld-version, the new version number =
is added
> > to the existing rustc-version script, rather than being added to a new =
script.
> >
> > The invocation of rustc-version is being moved from init/Kconfig to
> > scripts/Kconfig.include to avoid invoking rustc-version.sh twice and fo=
r
> > consistency with cc-version.
> >
> > Link: https://lore.kernel.org/all/20240925-cfi-norm-kasan-fix-v1-1-0328=
985cdf33@google.com/ [1]
> > Signed-off-by: Gary Guo <gary@garyguo.net>
>
> Alice: when I apply this, I will need to add your Signed-off-by here
> (i.e. when handling patches from others, you need to add your SoB
> too).

Oh, sorry I forgot about this.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>

