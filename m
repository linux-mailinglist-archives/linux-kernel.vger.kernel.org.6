Return-Path: <linux-kernel+bounces-374924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A70EC9A7208
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9FE1F25872
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0537B1FA271;
	Mon, 21 Oct 2024 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adBji/2s"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABF31991AE;
	Mon, 21 Oct 2024 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534371; cv=none; b=Pr2l9q9vBQ1Hw55+5yINjv5iDCEuNoJu5HtsY3xm6DWlKCcdcfn+aklPtiYDxl92U8wrLgeQ3Ylz6Q/pHRrGTvA+4Ri+sHlJh8ba5hXJPWsdn0iTbR4gc23WSCQ8fLyymdpE/+I9txnIkXVoIgeM+BXXybEC50EeenF80KF8kD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534371; c=relaxed/simple;
	bh=gG9la+UbjXkYYDwwmvFw6RqEbWAz8w1nv89BLZeythY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8/HOFN6riam6vtXLtInM0YkEdIFHLLWlWES+lgOsMrBfvIcXQnvXAGLtO6FIuJzuSnDhWzz7kw7nhZ368gz3BlqXf8U1O0ewdEuWY5oA+hcJhdzSaarePcD3MrV/P+iEo/508tX8rWT63zwFFN4ohNbMRfyQNTsKCwXgsG7l7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adBji/2s; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2ab5bbc01so789366a91.2;
        Mon, 21 Oct 2024 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729534369; x=1730139169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NTgndgTEyOJpsZjbycQD9UO0OcociRFzORnnCdJBGc=;
        b=adBji/2sY2p5w0ntg56rXkWdAu0lH7sPpXpkKH/na5diNLevyz0/6bpKhBwIQGtQ9b
         BealvE5euQdQIbuXFoR9KGf7HiVwjF/MbOzkAb/1d2QI0vgdJue67FgJHHB1ItzqbyjK
         +oKnV6Qn+yVbskmPzZdgJsSPj4rgGzBQ3bGvN5CT/xHoYA6mmlpy0bZR+gH2irQiRL8J
         Fc5qlXA5R06b1dES0+uVH904PWa+fT85xb1MRSqh8CoBXZldOFTXmrRugcef2Yjme55q
         inKyLFE8DezFNMhkGjptZ1UlNyDS5ZQD9nU/40ZDkAgQIrg5Th5gahxs0oeex6EAuenb
         rYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729534369; x=1730139169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NTgndgTEyOJpsZjbycQD9UO0OcociRFzORnnCdJBGc=;
        b=jEOBBR7OrSaGm2LQJjVGkCPbxa69OONJTvqNPWyLpwK10wME3CTKtqsuZvbL1n3gMT
         WYQaB7D3inrZV9PDlIcEgMfyF06+alRKHS85VAgWFeuaiqmOFb0O9tiI+7FvF392OuiB
         bJqLyIA8hTdaYqB03/pcw7EXyQpvCnOO2S9dMPGL9qjWzGeU+ryrSqSZhil1QYv0l7Z+
         Qe+6U4EEZ10IFiilbfAnHNWwuxWC5ZVvYOUKBg5oI27WMPgXG70h8XHeh2YF/Q7266M/
         OZNJklS84ioTjQgKHeOoJwzxiT2T56HwY248lDdLH1elqFi/dvgM1u4Yu4caAebY+vwZ
         ZBDA==
X-Forwarded-Encrypted: i=1; AJvYcCVg+a5V/CSThvurYkHp/AfRTKTs80uCuXDmV8AyiTlbTsSYExD3LwJ/wQfsl8Ai11Asx7siJ0S5nHrNSrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwhVw2WVXuYBSGMbfoYL+uivMmQDoamcb31TO7ozUAGw4U5IVI
	QIgeMCNsbBMNkmDOCFoZzrjpaL7RHj2E4Z3KHyDtqGW7NcL/bcDw2qzcy4Kv6OMyKfSqOpo/8JL
	RGWuraJEXkNZodBR3MW1m6O88vTY=
X-Google-Smtp-Source: AGHT+IFW5FCA2Dztg6+kRu5JR602IeaOSAzQAC3HeXxk2ob+alX7LD90roPRtrGAzAblzic6rxP+0XqTLbkL8elXWho=
X-Received: by 2002:a17:90a:f189:b0:2e1:f0ee:f41 with SMTP id
 98e67ed59e1d1-2e5615d5f6emr6007304a91.2.1729534368887; Mon, 21 Oct 2024
 11:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009162358.27735-1-tamird@gmail.com>
In-Reply-To: <20241009162358.27735-1-tamird@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Oct 2024 20:12:36 +0200
Message-ID: <CANiq72kG7RLD6EPCvPk3q4uFTLJs8wVx42jGhsYSvWm0SG=cVg@mail.gmail.com>
Subject: Re: [PATCH] rust: improve grammar in commentary
To: Tamir Duberstein <tamird@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 6:24=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Commit e26fa546042a ("rust: kbuild: auto generate helper exports")
> added an errant "the" where one was not needed; remove it.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to `rust-next` -- thanks everyone!

    [ Reworded title. - Miguel ]

Cheers,
Miguel

