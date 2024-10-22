Return-Path: <linux-kernel+bounces-376147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C79709AA0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6590D1F2312F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0974199FC1;
	Tue, 22 Oct 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZTwpzdb"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992419924A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595085; cv=none; b=cQ8sz6ZBfb2CQAaM3z6Fe9mvPBpOYJsBDQ3I2QsEPvJ+diqljbC/4D6Hkx2m49j4K/RZL0TFUvXw0eao/oZSIZMA0o5wN2OWMgtVy4KOzWVjKKPOJbaLNkQ16eXfG1SUFtW/W9/sGr3hAiPE/jAtnKXdLL2E0qLZFlKLs155w4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595085; c=relaxed/simple;
	bh=iVg2FAzFEvAFxXnNkdf9ZCF59BnILSc/6WBCXGP6J6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7tMNI25/JviiiVvKCINi1yZgoLsNA7mb2kSOF62A034dptlUIPYe3bsHleOvFRVs2x23g38MBJHlb3B2LJ+l1/8DxuHBXSWBk+x1w4m/GYW85PttPo0nrntL742Uqe9Xq5kb40KgjFGMFj22/1TBfQTTKje2M4flKSB3wUuu4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZTwpzdb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so25229875e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729595082; x=1730199882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYqphra7ioMyXLLZNQGAcA6KShSPo68yjMcIhmyT58o=;
        b=LZTwpzdb+LuFLyN1yeYZYzjyvQI/9yRxKETnfD1sSA8J03+6Iechj4G3uarvWIeJtk
         gKg9nd4qJY+bcB6V5dvYsy3eozBZSFDydW3b1P2ZhLhvFGExlZDsPfGxNvOXOnQrkb0X
         uaMhhRCNUJ/OiuAzXOO/bQOR4D7TXbdrh5BM7oE9GTMYLa2fAWWG/pGTebthQp0MI1cV
         l3Pi9NbIrbDhXY3QaVRQr0IxonqdwYE8zc3czfQEzRoMUDs0436/vl+lKmJnkKfQpS+q
         SWG46yZitprT5Tu0hAtE8K8JDB7CxSe/2s8cJMSZjJqXuvWJgcB8/c5iPpjfXw9RFKRL
         tvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729595082; x=1730199882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYqphra7ioMyXLLZNQGAcA6KShSPo68yjMcIhmyT58o=;
        b=LwmQd6N6aJ6J0LWvVtYms3L3tw4BYMhIHbiQFS1Ml2rZoc6d/sBC0/bJjEKmdRM19P
         gm8LIS2azQcrPL+w/ka07cs7nRIBH4nqFjwyTvnX4EdZNhh8d4V4NtcsHuaHfAERS+am
         Utk3sbOT2gzSUD0+t7SfWuDxxeABvuYnCQJupnPLqBT39Y7gSKULwHwCcQ9e0X4v3uzG
         DoTCAVp6/3Qgneet24sGgRKwr0bOdQwbaKGSqZZ06d/burTZAFKNNSsgDSosdP/Aw8Q9
         rQfwfROlmyZVe3oiiq31+PMysX7DPWO5ePSixlAlzlM4HDTz3exyetgvipRDn0T6BkmR
         lbcA==
X-Forwarded-Encrypted: i=1; AJvYcCVuOvxfEtX5dLK+3xH/5L5To1T2bWQYQgtpITwbbHuM7qPlWqy+G/34p8d4OY6DvBqacgEz573MuDKiMvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcf+mujjwJMHbPWIdVS5/7LdycBpOVbh9J7AKPS9xvEXib9800
	VgNTN65vjto3QvWHl14CuWxdtv7Ga5+5auTHUUvHrAvAVmZnS78dwk7jgYfsGeUtoVOAE3Z2Zn/
	MmvPOlyR9Uf0Wmj4tAofibDZFoIKzx/5rLIpT
X-Google-Smtp-Source: AGHT+IHu1TNYDncA5Nl/blFWdyNhhH3fwJ/uZG7OcrIUntvcftPXLjUPBpi3MwZRKTeUeq7lNS9mEDPXMqTC8YgDiU4=
X-Received: by 2002:adf:ec0d:0:b0:37d:377d:c7b0 with SMTP id
 ffacd0b85a97d-37ef0b7cf52mr1871673f8f.18.1729595081737; Tue, 22 Oct 2024
 04:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-static-mutex-v5-1-8d118a6a99b7@google.com>
In-Reply-To: <20241021-static-mutex-v5-1-8d118a6a99b7@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 22 Oct 2024 13:04:29 +0200
Message-ID: <CAH5fLgjpYPBwoE10eschOVnepbYmcEKtaZkWyPT8ZXG2wGrruQ@mail.gmail.com>
Subject: Re: [PATCH v5] rust: add global lock support
To: Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 3:18=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> +                    /// Lock this global lock.
> +                    pub fn lock(&'static self) -> GuardTyp {
> +                        $crate::global_lock_inner!(new_guard $($guard)? =
{
> +                            self.inner.lock()
> +                        })
> +                    }
> +
> +                    /// Lock this global lock.
> +                    #[allow(clippy::needless_question_mark)]
> +                    pub fn try_lock(&'static self) -> Option<GuardTyp> {
> +                        Some($crate::global_lock_inner!(new_guard $($gua=
rd)? {
> +                            self.inner.try_lock()?
> +                        }))
> +                    }

It came up during the meeting that these should just be pub, but now I
remember why I didn't do that. Making them pub means that you now get
"private type `MyCustomstruct` in public interface" errors on
whichever custom struct you're using as the item type of the lock.

And this error isn't a lint you can silence!

Alice

