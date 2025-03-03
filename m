Return-Path: <linux-kernel+bounces-545044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5CAA4E865
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485B2177B5B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14E027BF82;
	Tue,  4 Mar 2025 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0brHlXU"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD58527BF84
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107203; cv=pass; b=f+dyJqBL8zVmsi+KoZknHyiWwyQiJAb618kzEkBmccuQ0WWJAToWrhcOPewOl+Y5X6y5BXFtjkTkPgMEmaMyX3XMMtPu8RzXN1NCq6d8rhBX6zgR+OyRbFk+J4yftQG7GLgKmLEQ0MmGGRyG8KjFaLmTfQDS0nR8uJNHdN60mCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107203; c=relaxed/simple;
	bh=7QyQstdhk1iCcfADNLha/6aG2uup2vCJ66MTtxh2nZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PI8msjq/oEMgbmXE0kYXKrZmedHy1inLRjo5n5WBPqmg23MMfsLlPrqwy923GKI9s+AWguPNhaTYJWhJBwry/PaG5Kq+7VR8jgcIbZdNVd1pSzJJJd2wDam6lPQbBVVU22ONARft9aL2R2xMyKn1dXLrPXrDxA0LBW5QBknROSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0brHlXU; arc=none smtp.client-ip=209.85.128.52; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id E3FDE40D0BB5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:53:19 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=a0brHlXU
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h506Z5RzG3Wy
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:31:00 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 019674272C; Tue,  4 Mar 2025 19:30:48 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0brHlXU
X-Envelope-From: <linux-kernel+bounces-541335-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0brHlXU
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id D902143600
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:05:48 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 714A73064C12
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:05:48 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA313A7FD5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B3E1F2382;
	Mon,  3 Mar 2025 10:05:34 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659A11EE7DF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996332; cv=none; b=Fjr0ha59HuP/Qz6+OmzWC3ZutqrwKMn2GEnCrhkhFl9t4RyKCw4VznLtd5PlFaKkHeDh03h+8VH76L+zwq6Eg9z3o+bfRvp6bfCmbXdbtIXSjLNd7TD2sAus3/T8JOIEIsWaS+uNujbDecnWC5GLHdgZedmz0Gx6+PxbBJpvkSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996332; c=relaxed/simple;
	bh=7QyQstdhk1iCcfADNLha/6aG2uup2vCJ66MTtxh2nZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZy9CBRuE0UlzP6DYm9xON4mfDSklDRFOzPT27mVo108aSoOH9Yo7jeSJsuePomK8sW1wEsC4jLwfoxPVg6HyPBSo23DLpqHyvnQr1Rigg6gnJWW1bNFVSiczfdWFHRGPCmI3WF4ae4f/TolXDoY4xQmVOFjVrS/q4bL9tQInrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0brHlXU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43690d4605dso26539215e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740996329; x=1741601129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QyQstdhk1iCcfADNLha/6aG2uup2vCJ66MTtxh2nZg=;
        b=a0brHlXU2on+kl7ovToLUczsXU4U8kwPaZd+PkQlBdcT51KLmbcFyk8WXmNC5Id9JU
         jVKp424O8JTFpuMgYReujkGEZ4/W9b++mGMryJYsuU62kZRFjPyOJPgIwafLoTu6OJa/
         aJmVc/6kobfsq5QfM3mV/rvEE6V6ajHMBcyzV7csVOT+sKOKY4B6KkG8EBii153iqjkU
         VwayvXd/BX/eHY5mH7v3aIFl5CvcOk7H2ALFsCrq26M0+BQEF+Hw3kT2iKB7JS6B7rnk
         7R27n9fSJHTHui0z6wkapCp2B6KjsOUp/YTE/Eduo1WiYVd/Bcp4ExLmu1VFgqjRvSrA
         nq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996329; x=1741601129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QyQstdhk1iCcfADNLha/6aG2uup2vCJ66MTtxh2nZg=;
        b=XJMzdO5IfbLklcFnJx7yJB7nsiXGQczV3D+5EwPToq+vO3qQ/fqC7RLnp7n43SUT7p
         Q4H0mOK2Vg1vVEqckvLlIOxWssZ/qvEFWL5aW7oq0nB2HBRDWNCyxXUW26QuZrhiMHJM
         xhokgvH8hOtgav8yf73SOKaVwYOfNgi9kqaB1VEGWU+mSRBZ0W7dGdjOvZ4pR0Tr40DN
         d9HOJiki8S63C7yV5FZ9J4z36VFFx1N9X3kNPYbEiwcTpN99JPNPlwvfv+G9LRhFvtmY
         RWdjU5c6/sfW2Y2ZXNsubYFx0IN8RNQnbdLqy+D/F5jhKAVFXwkZ12lcBLK3CFBSF4S9
         1vlA==
X-Forwarded-Encrypted: i=1; AJvYcCXyVnPMLpop/cUyjfl0rVnBmX/vK8tqbS4e74XztUvkDjT0KIs+LO5MRw+5Qz3m0FXLiqd7eP1MrjD0UNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+rqBWFkC68lxT3rAJDBNEr440adW/1L7Zsb4GWZZa7xpDQA0
	DZ0IGZeL24Y44q/LFrBePv6SrkYbHpVSWvWf6iDPDT2f/p1FOemAvhVzGUp6fUo5bp+cNcKJkvr
	A6X9byG8GBQwCoBz7VQm12/iL3p4XcXmozuFB
X-Gm-Gg: ASbGncvo9qbEZHfiUaKojNM0Y/9Z4JspoaUdAm4VBcyIcVYOzvnJoQCMRhtAcL7WbS2
	VwOVticNX5QTjsj1olUGzAKinaJRQc+hle6DsaKXB58RdfM9G+KCtWuLMy2e+jqPpBa6bIaqIIX
	cm5RTakQz/0+BN3eS53Lsvkcbdpwqj6JsEIsbbXXgJkCJClWk0uPCKpD+6
X-Google-Smtp-Source: AGHT+IFEmyW0EbB6Ka9yQFfGVEPvOJqwYCEl504db3Ko2DygqJYxclr7CKQSdflmS7+pNsrqn4Y5OCDx9d3jRQoSqPk=
X-Received: by 2002:a5d:64a2:0:b0:390:d6ab:6c49 with SMTP id
 ffacd0b85a97d-390eca138ddmr11915449f8f.35.1740996328672; Mon, 03 Mar 2025
 02:05:28 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740995194.git.viresh.kumar@linaro.org> <171b6cd811ff4e913880ab33bc11e634f7cdeecb.1740995194.git.viresh.kumar@linaro.org>
In-Reply-To: <171b6cd811ff4e913880ab33bc11e634f7cdeecb.1740995194.git.viresh.kumar@linaro.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Mar 2025 11:05:16 +0100
X-Gm-Features: AQ5f1Jo64QlrJ8dyyVG_P39vJUDGWo2eEl4f6vfHkIrvzl7tE2S1Ro0v3PDYRZA
Message-ID: <CAH5fLgjNE7BF7fC6TxO3NjKV1OHXRxZFKn2Bs6fy8h_0zYd1tg@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] rust: Add clk helpers
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h506Z5RzG3Wy
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741711877.29565@lR6ChS64yJdSPnfLm+rMUw
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 3, 2025 at 11:00=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Non-trivial C macros and inlined C functions cannot be used directly
> in the Rust code and are used via functions ("helpers") that wrap
> those so that they can be called from Rust.
>
> In order to prepare for adding Rust abstractions for the clock APIs,
> add clock helpers required by the Rust implementation.
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Did clk maintainers ask for this to be separate? We normally just add
helpers in the commit that need them.

Alice


