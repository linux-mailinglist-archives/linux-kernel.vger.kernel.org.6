Return-Path: <linux-kernel+bounces-559347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FB9A5F28A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AFC188A1D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCF51F12F2;
	Thu, 13 Mar 2025 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AueC/Mds"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F31EF09A;
	Thu, 13 Mar 2025 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865667; cv=none; b=gscsrAzXbpDPxy2uRfRNLiLGtx44EtG2IxkwVBqN/0UtKkAneJd2avYNziogZ/9ffeydb+16JPIye9Ha9S4kNHpLUkW7vbtvARm1G8K2/9yR8ln0JMhsvh8/gLk+uDLOEvIEII/xRJmm5XSzA0egMQrFDFBzyNiRg/ZpJ+2KLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865667; c=relaxed/simple;
	bh=GFbTCjg1/pxvv+17CHj2EJG9lWLGwZk6sv2kKcyz8YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZIDARhpgkREnah3xmAgCwwdNtAX29NidAPf0qInhbZ7bL4gO4h6Y5M1rl1Gmcl7D6I39ZONnHp122ZbVBWfg8qTtvbmD+xEG0T+2aVZ7Oxe5tbuiSHNENopPWl+UUYtPv0Hq55Zm6oHJWwAKi0LfFVKZMEz5YEh7dSd6DCK+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AueC/Mds; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff66327419so214830a91.1;
        Thu, 13 Mar 2025 04:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741865666; x=1742470466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU8CC9O8MUiqmBbpdq3oaKsO2jjCCn/v5uQfYRKDF+c=;
        b=AueC/Mds+WJwMkfzb/gVYJVC2mu+fJmNP2+j43V62hEEWLFyj7EJ2N3syxemQXLOFR
         VB7bsVh/Leu3TaLjScj8cG8Jo/NZ+cmvXtq9uMIf09ZeMVHgfPfauR+Vp3tDKq38tt8G
         mgr9qn2GQ05fzeOnF+0M8WhzSgVzzc4A5AhSR9sh9/W45SZ6z1LNZqKghUB0s3EIouIC
         eHaxMUOE+W0jvpZNfe8CZhMk/bO3QTVr7MlsXd2JR6LMdSUV1EeDv2a6zdSNNZK+tyx+
         LzAy5/rcGsBPE1g96/CrSFPu3FytDst+fOiVBubZym5DdyZ1oYiXAd1RbkUcYWZt1CJH
         FHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741865666; x=1742470466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU8CC9O8MUiqmBbpdq3oaKsO2jjCCn/v5uQfYRKDF+c=;
        b=gvZQjsacLb/2hmVvxwgIhMrIvK4vZ1F6ktbR8cOs1QOoNq1novuYwjHLZq9jt1eiZD
         U9jAj7NlvdqnQxpF/HnUWeVOY3cO16020zMpLFwRhzgW2yTIdhpXAfttRq6YC/xmgPlm
         musSq6KZei3PMcCFaUNAVJwYCwHPUhtd9XxdfaR/nBTwfdW/KFfPDrlk1G0uMcBer6g1
         9hNxL93/CLpbYFv6PjgfltwK0qc4F6yc5cvELXtDUE4HNLzwxZNwS2NVRwSLyyGG2h/q
         jPkLipbFaWMN+/rqTDIw1uLn9pzWZHZuGtuvtdIuxDx/VUGufMbEovo58ZT+dwJtsoM5
         4cHg==
X-Forwarded-Encrypted: i=1; AJvYcCVVKCL70tFSzI3U03nMbM/zUMGn2wpMSDYHUD4crwQUkJchQ3BX4oOG9lpuzLTZYDX0TvH6kbq+ti7oz2OyVus=@vger.kernel.org, AJvYcCVY1n/6HbwJFCb5Qdccw3jwdsvUPon1SJnjkq40fqnpPjKINfkC1qFFqsTzzMq5jnmmD/da2k1TyvIi7+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/eazD+iLZVTC0AYGLtb6vbXwrRVEdcGiWnuggXl1VlosntABs
	mVHoM8gkhZahRXxvLe9ub6pbywnvX0Yg1tDcI3jQuiW233UsdUNVxHxZ9U3Rd99a/2DxCZm1t6W
	6z5CYDmHSgW97vR2gqioS7427J/k=
X-Gm-Gg: ASbGnctw5qkhBHi5tgnXMEc5XKKF519qz3YWIFNR8bh7weVmQOZ4LKOYYcFRvMyn9D8
	PAegE0VMvhOLuj+EV0DwfJV8y9dsSfpRImjlY/WLJHP88RO9oHzIv+qoKhFBhsXFylbGBd0pBc8
	ZzojA0VUNAw4zoGeYmsHyRiKcsJw==
X-Google-Smtp-Source: AGHT+IGRELWIyA/Aadm+t8rwcoGa4FkMtZTEm13XS8RSsCl4/vLIUg9xkLRLtTFVUJTThXipMf5VB9e2wIt+VhD8zXI=
X-Received: by 2002:a17:90b:1649:b0:2ff:5759:549a with SMTP id
 98e67ed59e1d1-300ff7245bdmr5597393a91.1.1741865665547; Thu, 13 Mar 2025
 04:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313-rust_misc_device_tld-v1-1-a519bced9a6d@google.com>
In-Reply-To: <20250313-rust_misc_device_tld-v1-1-a519bced9a6d@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Mar 2025 12:34:10 +0100
X-Gm-Features: AQ5f1JpYX1j1aEf7U2ye4lCsQbT9ULk0b6tIyeQvRfQnYvp2h1dba39KtItN-1k
Message-ID: <CANiq72kaHF9tV-SJqSfKU+n+HUh_2D1Uf3wL=+nTbkJDMQEDiQ@mail.gmail.com>
Subject: Re: [PATCH] samples: rust_misc_device: fix markup in top-level docs
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 9:52=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> -/// ```
>  use core::pin::Pin;

It would be nice to catch this -- filled:

    https://github.com/rust-lang/rust-clippy/issues/14402

Cheers,
Miguel

