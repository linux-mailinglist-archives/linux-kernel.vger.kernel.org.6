Return-Path: <linux-kernel+bounces-386867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 928319B48D0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D760B22A36
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F02A205AB3;
	Tue, 29 Oct 2024 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9HVOxQP"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D5204F60
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203162; cv=none; b=Ik9gpY5oYtceTvWut8oF+5z4QOP/C792yt7tUlAlCtBWpLKB//K/KYhHYBXJO7tPc6r6knxHd7By5iOk4yWLL/sW1z0KyToe92i34xHZCx41bdlVWPSBgB7Wprpn7mF7i09z4ohg5wd1SkxXahrcE2Q+v0oPXePO9c9Z1S9mBEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203162; c=relaxed/simple;
	bh=KnVUXaVKB5y0TG2yLz8bQXQzHlldf0oR8DEfxOVn/Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qqi5LHr/NFP/smvuHwKwjVMH9me04VLGkgtKn9q3p6ZWf/PS718naSpiWh9b3iqAstTeVKBhfeAoKIC4S1AxCahnM346xzzfJMgHfTZakaoEVXtqjfvKFISshO5rDCCbO4/htDb+5lkaLp7AD5S/Xp3ro9OhohffPY4KWBBIBPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q9HVOxQP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f8490856so4957439e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730203159; x=1730807959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnVUXaVKB5y0TG2yLz8bQXQzHlldf0oR8DEfxOVn/Co=;
        b=Q9HVOxQPEIysoFbSHzRVMaF2EcU9lSoSDcXUMaFrcP7Wz4JbME58ESZK+ayfVaYOM+
         tlU43+k0f3Bt9N/VAyQoGBrWjC2NRgCcMmqrVP+EUn2P5yA+5e2YJH6nVcAp5u/OeQQU
         ruAC3cJMkMwa+ZaMNfvlnZB4YEqBVzuinGHp/tx9rnr1ogGiiUSGHHPpx/5UKQiV9txn
         WiZRqz7pkGxQnuaBockNBydX+QoEyNoovT1gfj5N+YivNTqT3rMLwMSuOlsCyBTfZHyp
         a/T6M8wGi5ieHnB3nx+ga3Bj7nUAaryR5GtWNIlR4IoYqQPoZQIoxv+PvxQDJ7Qi0pR1
         JoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730203159; x=1730807959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnVUXaVKB5y0TG2yLz8bQXQzHlldf0oR8DEfxOVn/Co=;
        b=B+r0EFZV4mQSGxh//uFMmxzWyKHcGiA6wDX+xIM76P7ioqFJqLS5Ce5u7rIKbWnTL8
         O4YJcwWF2Gjs19I4uBdomyH39665U6ffxRDhhKCB1/i+9TNkVFJcz/b96Ctza8vUTMKH
         CTPsAP0ZV3NsHMeecaaPCGwLxZu4Os8TRxNauldSPpJOnz2mO1infP6Xs1WLEj/L5SMI
         Bp+fCREzA/9U1X0Uwdg/RXF3eogZV97MkPHq51dsOnRI6HIwPoXFAugqhALEEwJu9blO
         tRglIaG6XiB8lDsGqYiE7lM2/xXxOd8OWA4iCvSXBmAz1KZRxmhZu4tJSpvewL4Sqvlw
         lBsw==
X-Forwarded-Encrypted: i=1; AJvYcCVRRo6mjY+LOvNiJNSncUb2tbWA7t2A841tZEEb6DfPO6mlVVJYSJFl90iDFYRMTGsZLHubCTtvQWbAzJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfs6Kb4W1gPJEK2GATMTA+2AN+vMq/+7l/Q5xb1J8eeLbyWyBX
	RIzLIvYokHNxJnPwk12TBUedN4F+xgJmXx5LQI0JeHxfy2nzkTaLf3NzCxnyBXAVpb41miIJTM+
	Gprc/Dd/fnMF1zuMoNMr/vwDRDicm7Uv5HDT9
X-Google-Smtp-Source: AGHT+IEXIWzFCFMjjrHGrHTNAb/w0zyZCb19ulrPIZWWw3Hxnr8q0Cp+66ZSr9KrOfShicv/GQzC/wNYgN3ZdxtSuEw=
X-Received: by 2002:a05:6512:110f:b0:539:ea49:d163 with SMTP id
 2adb3069b0e04-53b348c8a11mr5903365e87.21.1730203158778; Tue, 29 Oct 2024
 04:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024-topic-panthor-rs-request_irq-v1-1-7cbc51c182ca@collabora.com>
In-Reply-To: <20241024-topic-panthor-rs-request_irq-v1-1-7cbc51c182ca@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Oct 2024 12:59:05 +0100
Message-ID: <CAH5fLgjmfzTU_88H4mGiv++CbBj0xB5AoiimULCEx_b0wsMmMw@mail.gmail.com>
Subject: Re: [PATCH] rust: irq: add support for request_irq()
To: Daniel Almeida <daniel.almeida@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 4:20=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Both regular and threaded versions are supported.
>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Why implement request_irq over devm_request_irq?

Alice

