Return-Path: <linux-kernel+bounces-423464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC249DA7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D28CB22CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5B01FBEBB;
	Wed, 27 Nov 2024 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XEa72S2h"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AAF1F9ED9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732710429; cv=none; b=bqu08p8aSOj2sKP0qc79JYLeeoXFCqK7CcKj/a5TO/Kf2WKPZZI+tRgFCW+jSDYizN2IQP6W0MgfMgMXHjPeSLZTy986tJrKxyXX7W3M9oQbCmuGXLaM4RSXJlqWH4D1tdNRYYROUHsWSfwL9pPP5/cCdEMDvcnoEcnE9EA9MIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732710429; c=relaxed/simple;
	bh=9tcXomEL5hDFYb9pYCG1IynV24I+wMljj1u+owSimKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwii/kCsK1dAQ/GsTwW9eY6aPyjhZmUhmKT6P94NCQiO2zi7nPfM23UIwX7SWQZO/MRFM5r55P+EXsC7wrzGVoWg95tePiWOibwf6qlvhsFtE5nYDGVjTOTHjB5gKPC1xPuDREVCWIWh7VCbRjRMVDSjwT2D1oB1/APdfw6nYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XEa72S2h; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38246333e12so6587268f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732710425; x=1733315225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NerEvXZ0IWkIR646OECjt+ladaCNDTIAbJWxZSh5tV8=;
        b=XEa72S2h5/Y3VFLh7/qXe/SIbDbWosT/dG18VHu8W9LHGg0rkBC3JvHUWsgCM1rTl8
         X6S3Wy9UNEOam/heg81kc5269mmkbqSQmbplNKrFBnvXf/sFmJxwrYUZec5EBKeXIixe
         Etl+TJGJTk0+tOeMgHTGR+49S9RY0JfpMp/2io2KtYpZFZiV0LF0uMCM63dfNES64Ii+
         0+50nMEq7sXWKBo/ZrmmDqBDzzzJKBaaBhIzCnf10LVcy2y21PIPpJV+hZ6E7Gu117di
         zCvNlWytCBTHlc54GevUTpwS0YuhIkwuJTW2As9+h46Xkq4d86qTpS2FeC66iTdM+CCr
         LgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732710425; x=1733315225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NerEvXZ0IWkIR646OECjt+ladaCNDTIAbJWxZSh5tV8=;
        b=gdvyO+CNwOtjj1GuF/SFxFCEFVSKhCeBrgAnaFGH7gEVOBB1vBSO1lVBrygiqSA37k
         dUlY18tR6O5ifYu+2D3febiq1SphnmoDvhf3xcDxDjICJkx1nB9WQjy3NqLOHZfXPpl5
         xbkG7ucUHZtfvXz9Oz0mG40rAozHiQoMK4BuNfkfl9lO/zX5E802EtLky9zWsFI+26qj
         RbPDDsjThwX4LcZLovAGIQLNwbtcso4eYiiyo+Ol6Utj74XZkX9krfq2scER+rk/9bWz
         avcrF0bMZ1keDK4/DmNrmqMkKwa3psbF7slJmFlTj310Vjato0kHlArghOx27AiXAiyc
         hL8w==
X-Forwarded-Encrypted: i=1; AJvYcCV7nHk+v55q3SE9NclDDLteUlCW/RIctkTyK8oNoPr3vqMtnW1q4OZvq2CM0i2A9SDbDH2Gg68ve0ttamA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhVxwt3RYXmb35zlZlWL8pEjl2VycKmkAcjV7+yP3Z37oAWVC4
	lCYUOKChkBcwhZh9dayC1ws8BnkmcagJpZilpoH/PqjrwB0AV4vqIQqnsVeDtxML+zW8pLN6M6n
	+z0yV4mJu0/lW6Xnnxb3PD0PPjQgBzq8Db06e
X-Gm-Gg: ASbGncvP7APwJ/0CcfFgoV2TAlduqrAl3nvI3mSBslcTKPM1MYaqThoPNmxq84ApGFL
	BDqLBhpWlqP65IWhlhQRqUKLiazMQeQjAEYp/C8HN1UyaTrsetNF66PprgIIJwA==
X-Google-Smtp-Source: AGHT+IE3/u6hPTwoMgl+sPnAg9L3GbfPlv/O5UbGqSwqJkkq12a3v1N1YaIJiNotHeACN+FFjZynzfAYly8sFv9S5N4=
X-Received: by 2002:a05:6000:1868:b0:382:46a2:3788 with SMTP id
 ffacd0b85a97d-385c6ebb9a2mr2270198f8f.25.1732710424749; Wed, 27 Nov 2024
 04:27:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io> <20241126-pr_once_macros-v4-1-410b8ca9643e@tuta.io>
In-Reply-To: <20241126-pr_once_macros-v4-1-410b8ca9643e@tuta.io>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Nov 2024 13:26:53 +0100
Message-ID: <CAH5fLgj30AmuobugAgzG9vOhSOrk5SqWwguOoNeh3J2fmLRHCA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] rust: Add `OnceLite` for executing code once
To: jens.korinth@tuta.io
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Dirk Behme <dirk.behme@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 5:41=E2=80=AFPM Jens Korinth via B4 Relay
<devnull+jens.korinth.tuta.io@kernel.org> wrote:
>
> From: Jens Korinth <jens.korinth@tuta.io>
>
> Similar to `Once` in Rust's standard library, but with the same
> non-blocking behavior as the kernel's `DO_ONCE_LITE` macro. Abstraction
> allows easy replacement of the underlying sync mechanisms, see
>
> https://lore.kernel.org/rust-for-linux/20241109-pr_once_macros-v3-0-6beb2=
4e0cac8@tuta.io/.
>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Jens Korinth <jens.korinth@tuta.io>

> +    pub fn is_completed(&self) -> bool {
> +        self.1.load(Relaxed)
> +    }

What is the use-case for this function? Why not just have one atomic?

