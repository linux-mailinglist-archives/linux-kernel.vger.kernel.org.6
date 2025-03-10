Return-Path: <linux-kernel+bounces-555172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39529A5A663
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C7118905EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E986B1E5B84;
	Mon, 10 Mar 2025 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5NbGdcn"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99C1E573F;
	Mon, 10 Mar 2025 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741643177; cv=none; b=DLFfAa2qbNlF+4lxR8V5cHrcO1QlQFPrJcXQIueZ6+4IBKam0NQIdnZGSvpMTgCJ720D1XHtVuMwIY5TtJCFiV0ekYhSjXt2hZXQbTyYAimknvwYOs0WN8f0k3enueTW75+iolh/tRJQ46bE9vu65Xkh5byzbijnu0FTeiUO3Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741643177; c=relaxed/simple;
	bh=PypOLmbY/Kmt4w5khYXlz7jfuc6fDNP0JmNKzdEvUHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGIiQNS57k6hKBiDbIGg7wyxZbkuUT0kySMGPeXwqfeAOu8zA7IFVXJnSR/KJG1iXqGYQ+EUgWY07Tz10kQ4nxSh8pcAIw82dnavYU3cZZz6PC8BuzzzaVFnW0LuqO0Bbc9zOBCs7l7+DLtuW7lTxri94PlNaVXpXh0XX7r5qPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5NbGdcn; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30795988ebeso50995411fa.3;
        Mon, 10 Mar 2025 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741643174; x=1742247974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PypOLmbY/Kmt4w5khYXlz7jfuc6fDNP0JmNKzdEvUHc=;
        b=k5NbGdcnCbvkbs4zNc/1pip1PmpxWcXYdfcYveobVexyT2Nb8Z58iBxJKTu0Tpcxmo
         hJ9iUz8Akccp9bCI+9Gq4tb//Hv5KmV5b0F6ZUxRKCSSEuqFZ3NARvD2BuC0fFaPUiB4
         Gc7M4/uwzDQNmOmXilAhM+R5rSZdiVuneijbFrRwbtfpz+Cw9B+/kWCg3GtcJ40DXrFK
         zI2WHy0TGyxAU+G6DooJ7+mCdgczOTDsnQC+Hb8EHTXmoeI4ltJddi9AfohOw34j2ITM
         wkZnxRyWyeHa7gzQpOE1nwBzEdMmC97BtG/dvDLrgoOh8c4sfB7RXPRpmtq82gGhtVF/
         kaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741643174; x=1742247974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PypOLmbY/Kmt4w5khYXlz7jfuc6fDNP0JmNKzdEvUHc=;
        b=PtnlTKKytpR3yvwNPZ1zRcZC1OViJtXgPDw8gfji8vmoi8/EScJjRcz/mNTrq61AWi
         l0ID8zkHTu8tMbFDVf9WEL8uHlc3nDpVI0yO/DyzMXB5YXeTgI8GDP5bZgrGxCoBQr0i
         HI7siZ4V1Cw80a0gM2HQEvkR0hyE6cjYQutr3qk29QUZTHXmvnrUikpYMTGyP8Y3xytI
         Gaw1WgMjbMrKtpj3Vj5oY2kk9xQYX5MWFjjLwmaNmAHKohJzkLt81Lpi2RxmnxbF2BZi
         fH3LGXZbckjFMPozZ16bVB1tMgU5hTm7XV3YSLUswm1p5KEdp9+Dl4jCbKo0EXOu4DtY
         yWTg==
X-Forwarded-Encrypted: i=1; AJvYcCUNLPC7go7qrWbe9FlhoZDdBb45N+BYQdYIWhcFEVfPTr9qfmh4pwibbxEEpK6pfReEbGN3ayYypOS2wRCANcQ=@vger.kernel.org, AJvYcCV9FrZf7dJZe1qbBK9OWQmpY2TzlzKNHwDbfrG1Ntg/4ixpGdYQ3Ny/iwy9dMvKUt44nzLsHI/FBlLwckQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyk6XCU0k6tEEBxbllyI9Q5HMVZwCDodjOAA9RTqxcnPVEn2RX
	GavHlzLJJ1gb4W8Gw5sZoHOIqk5qqh300vBGgWKgXozMT0c9r/KYSlffVDRWhPwscv77WqrNJGp
	Jd5ZUsxhsGOai93pvr9PCoD4cTgA=
X-Gm-Gg: ASbGncvXN9LQ9IgH/88CDyFCdGDFfJM7vPrPEpunDRaHQcm5r78Q3ZM/+yZXQy+gafI
	XuOoRY2R5uk5x0As3PxEjXKQc9labfuG01FXr4lVxTWJqX1HvtMg18duyBF9Os4zcattAaJE9WZ
	iAlgUdTyxUpDIEdy0PHEGb1OI=
X-Google-Smtp-Source: AGHT+IGi6M0JVamYcsk9BY8Nm+Uy6NFRrDroERT6SAoVfnpAJRamyLT/EajOTfza+mYlX9RlNGQJLXE/bpEjgTh9824=
X-Received: by 2002:a05:651c:1a0b:b0:309:2ed:7331 with SMTP id
 38308e7fff4ca-30bf453cdb5mr63855891fa.18.1741643173750; Mon, 10 Mar 2025
 14:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6-mv8ahCblqal1f_T1RcVPPPb6QEedsAXlhmcyCNC-lnvAj1USOInn0YNogItuEdy_KthnPdFDElN1F6A9ncwA==@protonmail.internalid>
 <20250210-rust-analyzer-macros-core-dep-v3-1-45eb4836f218@gmail.com>
 <874j055csy.fsf@kernel.org> <CAJ-ks9mofNbtGqoYBummkfxZ+zrmEHg5P6viVwwgs9-BuNGbZg@mail.gmail.com>
 <CANiq72=_LW8dBbFbQz=tuuck07OhpPdPGuiEtq-SQ1=g-PyNFw@mail.gmail.com> <CAJ-ks9mLBNwm2869kczSpnvRqi_LPH9x1ayzsmwELpuDdDndDA@mail.gmail.com>
In-Reply-To: <CAJ-ks9mLBNwm2869kczSpnvRqi_LPH9x1ayzsmwELpuDdDndDA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Mar 2025 17:45:36 -0400
X-Gm-Features: AQ5f1JoVNOtEWaZtMvuq9crDueDZsXzMOw8iGd5n2hggGCRmdQQDtcWS-YbSdB4
Message-ID: <CAJ-ks9k1orFKE_PBNSMj5FCb0m5r0v6nJWaTBar7uH82AXnvHw@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: generate_rust_analyzer.py: add missing macros deps
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Boris-Chengbiao Zhou <bobo1239@web.de>, Fiona Behrens <me@kloenk.dev>, 
	Kees Cook <kees@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chayim Refael Friedman <chayimfr@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Miguel, gentle ping on this. Please let me know what, if anything,
is required to move this forward.

Cheers.
Tamir

