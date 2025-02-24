Return-Path: <linux-kernel+bounces-529778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EACE5A42AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB347A2D15
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14279265CC7;
	Mon, 24 Feb 2025 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gn/X48wr"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF5263F2C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420739; cv=none; b=CArLbVnxBlTouNITjCMHcmtRVynTxZHdTnmhXZM+t5lN56X0LnMfeuDSTzja/jIXpNjMVSuAEVeZ3Qyy5v3M5MhLYq3tRUhkXIFs8EKYOfUyXBuFMYWHvRRrKjjZDc/q+zBzTkN1VU0Csz1+E7evG+ys1z79dCYzxYHhDjGWphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420739; c=relaxed/simple;
	bh=xvAR+mvpnEkw3V0bWLcJxiiVQwnNac2zGB3dNnVWVd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9DM8lBi2qiCWkFuujFg1BCtK7dGQPlCWrkNux+K/XXEgJ5XcDEjmRxqpJha/1zRkha3w/L3WezFNOWVM27kReQd+zBessRPomoUbQXxv7Ijmq85DwPU4JEIMBDxGgdkMZt+LnZvkWHhghzG9hOW5beIwvzoCySOpNHradRSH7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gn/X48wr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4398e839cd4so33658535e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740420736; x=1741025536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvAR+mvpnEkw3V0bWLcJxiiVQwnNac2zGB3dNnVWVd8=;
        b=Gn/X48wrexe6Aii9vE3OZHM1VFTzXIV1hRR5EI26zCanued5/bMR3ug5DT0mItJ06j
         iE/bnIRN0wy9zUmy3IUghXz78bhCp3ahzzT3RxRl/m6B4EV7ud9klxTWpEGEprXs41d+
         m68q3w2SkUKXq3vMicJA6aBPOHRSyys5+4f7ROuF8ivxZIYrM3yX3f4L6RtHNZJk1SdK
         j1gm1KEu9m3vZD6pjme9ngZQvhbmuWacQjXXtedjC62tO0GHiNqcvyXNjwJWHDjxWe1Q
         2hdgxrwHb97k6IjHJCCTqqZl5oEowu1HHQ5bT/vtKy1FEzD0K/3+e3AkdXXjEpqqh9AP
         AzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420736; x=1741025536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvAR+mvpnEkw3V0bWLcJxiiVQwnNac2zGB3dNnVWVd8=;
        b=WsW19qSOk4bP/Rq9yordj1zDyoK4mJPDUN09fAu9UCdREB80w0QJG64ePq73JNOrm9
         iG/mPDQWUnSGzyGk6oN93VNPVS3jJXdcNM8ydqRMmt1uuYDOwfrp5IMekr/zAzQliTPY
         WYVKwFyFU7mkzqUz8Ix3R8bviSAQZXegMxBfvKKiWHa1qKILOy78kpvQLPFh7f5ZXYU7
         F/MrZkqgNbR9JBH1zeYg9nIEXWpaM51xG0y6w6ix4tD84LF9oPVbt+WzUuO/TSvmbUT7
         HC6IX6FwugjbtvSuzGs/1bDq61FkYWTarmWpOVXf3b1it7aM+1hacHSlx4DNibA1XbEV
         pdJw==
X-Forwarded-Encrypted: i=1; AJvYcCV+JqjoU0UQuHO0MgMT455xLhNitYEEMaUSQSm2YBBow2/nAr95D4K6W9V3OsgN03uSWBA8WuZuTApTtE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPo//0kSF83xldNhFmCRRMRPJbjaJ3F99VbGmYbm8jne90cx7t
	FSHcRRgetfj/Mg/M+uY6NTmYTwH8xkuPLCR0QPW35z1/ehz3APAEIaRcbSAOYm1IAX2cOwnXdut
	vrBU9YBnPiu/F9VKdTqts7j53M1a/9CsLupJC
X-Gm-Gg: ASbGnctmxvru+viUfy1PSN9jfVCheT+r34bGrLGna5TZBcr4btEZ0o3G7ZjlMG6qrXz
	LQVEyLTi77WbWHzucAS6gQjaHZ97iCjQwS5M62ES8Rh6/EZ0bBFFcHG5MQAPsgZGTFtJ2otqv5P
	QUTs3W1u4w
X-Google-Smtp-Source: AGHT+IFPMrPhjY/2dbKor0Wcfga1hfkHkJ8ba0hmBnI5YCSJx4/LsXQeF2I6GzVJfar6jBGIA0OBsizuejhRq8QbqZQ=
X-Received: by 2002:a5d:5985:0:b0:38d:c73d:e52c with SMTP id
 ffacd0b85a97d-38f6f3dc27cmr12092538f8f.14.1740420736050; Mon, 24 Feb 2025
 10:12:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224142326.38396-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20250224142326.38396-1-hamzamahfooz@linux.microsoft.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 24 Feb 2025 19:12:02 +0100
X-Gm-Features: AWEUYZlZXAqT7XF1ViotPOrIIHvgMB0pnr6HYaxTn8vUab2MyN-OHlP2BLxEzrg
Message-ID: <CAH5fLghR0BBFtV0eGHJsuX_uBFixQT59=eaPFHcCf=agJQSOfw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: workqueue: define built-in bh queues
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: rust-for-linux@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Wedson Almeida Filho <walmeida@microsoft.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Konstantin Andrikopoulos <kernel@mandragore.io>, 
	Danilo Krummrich <dakr@kernel.org>, Roland Xu <mu001999@outlook.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 3:23=E2=80=AFPM Hamza Mahfooz
<hamzamahfooz@linux.microsoft.com> wrote:
>
> Provide safe getters to the system bh work queues. They will be used
> to reimplement the Hyper-V VMBus in rust.
>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

