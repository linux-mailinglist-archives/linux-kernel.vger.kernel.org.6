Return-Path: <linux-kernel+bounces-412660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68F39D0C82
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AFC5B21833
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63721193079;
	Mon, 18 Nov 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LsFH/Xyu"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4294118E03A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923275; cv=none; b=B9BOgGBgVDGxd0S9HjzxW3CjTuQMJ6ts0LZFHOMw4JzKgVhWJFs/n6JhlvN/+pgVq0NH1pJHFxw2q71TU6MhCRLGBbxvUXppRn1eBGrZEz2jW08QTdU/3RAvVVKE/0OULhdZyLN6l3V+UdUxsHFU8KBLLY9xtXC06Kzk/3xNOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923275; c=relaxed/simple;
	bh=XXsIrjaLPtAbu9sbK4FP88OFsgTuPGUxicrKbpGG+pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkYAZsWx+VAbLBIwzVGcLhlWKTBWkpwdhAagKGVVVwRantJIZ14QT66R39MGFB+maJlfWjFrSROkpzllZrRnwEW+1EHypDL9s7OzWWLEDh0SEtfJFCKUoiMbRZLBDpSeUmh4t/ZYt3UJ98vkaLLlSs5MmXmDPxZrowgDT5iGtfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LsFH/Xyu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so36353385e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731923272; x=1732528072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXsIrjaLPtAbu9sbK4FP88OFsgTuPGUxicrKbpGG+pw=;
        b=LsFH/XyuHZ0TAiVRgIl3wQ6hzgSbe+GqQVz8y778tJcBiP2StudxriHQaDeQqx4sZc
         dh1/cnHPBuTlhiwFBkhuPG4lfYfYFdEBh/pYknmxse1fsVrWDY4baL7WlFQ85AGLOgBC
         hiHF16apdzojPXNulsRX1PW/xUKTBaNeQn/gQ1RJIks82ipr/kPPtLJtTO+5zgIC3sO5
         bJGZLEwA8uA2eBliv04EdWKWuQKyUaKdjDxYJgEqSgESjBKMvnofnKvVSqYvmBI/LiQy
         3k+iMDEYcws7YChs9KLvsiBJj2ntwTAE5AT016a+51IS1T45skutVCV8oKr7LKEKVuwm
         SRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731923272; x=1732528072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXsIrjaLPtAbu9sbK4FP88OFsgTuPGUxicrKbpGG+pw=;
        b=sjeeTADHupgYFJ1zlqyXKc778B5hCtxWoUJ5EIRM3xXSiWHMiZOpNIkkOScd0Y3hTg
         eZjt51pCF/q4vHoKji070+YXjGkXaVlJ2OlgY1YbHI7Fe/KQOHaSQp/q1FvXDQGtnnqW
         pL9NtMsKX9MyMhxnqNFIrlMmtHrazeFyftllINCWqKlAnnHEI7RFbz9yU3zarpSLy6Ix
         Pd96pGuVTjIr5p5KOpT1+JB12wEpws9NVaw2hBqCpSyZ7I5xEOKm9YiKs4SSdhXgjbvj
         bTjt8YfDclGZBinYJUnWtfegoNxHhVbaVlBfLRK7yv6Ht9kcvdayNuLCr9uUWOkcpFPw
         yTBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBM+empVBw2nBg5zRoIOb78IqHAKCsIzGtZk7zggpCGH7iDMcf3juIVKuVKKxjiE2kenDP4Q6K8QFQaks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7hWtumtzCL06o6QPnwhldA4eopo5KwRo6+wL9TsmJEIJhLcWQ
	nkQEAI7A5RQBDFEKJgKBKWVAnig1UzFa8QrDruj2CBBdDiObHuCjnnbz1//aJW7a8peqzF3o748
	AsNtA/j/cifJrdMTjklReOVbbVT9IJXDTOkOV
X-Google-Smtp-Source: AGHT+IFW3ZZ2HFelm2woVtQeHr8EXXk1OydjKU40b/QkCRm14XNYCXSKqUggk05fm/ig0XesvILnEgyXAhF6bD1p/U8=
X-Received: by 2002:a5d:47ab:0:b0:382:3789:191c with SMTP id
 ffacd0b85a97d-38237891a14mr5679855f8f.7.1731923272561; Mon, 18 Nov 2024
 01:47:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117133127.473937-1-ojeda@kernel.org>
In-Reply-To: <20241117133127.473937-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 18 Nov 2024 10:47:40 +0100
Message-ID: <CAH5fLgj2ikduoBOCekGxdStemVR1EAN-fdcQxOVUJuUL5Z2KtQ@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: remove spurious item in `expect` list
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 2:31=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> This list started as a "when to prefer `expect`" list, but at some point
> during writing I changed it to a "prefer `expect` unless...` one. However=
,
> the first bullet remained, which does not make sense anymore.
>
> Thus remove it. In addition, fix nearby typo.
>
> Fixes: 04866494e936 ("Documentation: rust: discuss `#[expect(...)]` in th=
e guidelines")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

