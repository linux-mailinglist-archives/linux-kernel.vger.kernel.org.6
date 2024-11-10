Return-Path: <linux-kernel+bounces-403090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2499C30F1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 06:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18EDAB21243
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 05:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D448F1482F6;
	Sun, 10 Nov 2024 05:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBi/wc9Y"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEE2347B4;
	Sun, 10 Nov 2024 05:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731215972; cv=none; b=BaVuTSbNYNXQa4y/RGtWv9Lk/z3D6kxzESw3HNaYv8GcM/k+neGQPuhMLmGdL5rVa6dgf434l8uV0lIhomJS4v+evsB97pdRz2Ykxx7DJE/Un9FzNIEg1sUatnb1gEjnlXU6vKlX3oq2oVs6k6Dp8XileJL1q6ZIGEeRsD2lW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731215972; c=relaxed/simple;
	bh=1pI+1hXvAZDsPYyFJCp0JUmnMP4z7cnbB2n5ysqGvKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrYIfMPW2Q3cQoXX65no/O5myc8RKWqC/bzprj6Nhp+C7NawkG8249SzHqFSAlO6WGd+AoVonHSb6o7SctDx5rblIoaptN5M1vt74qIjawjlmdScgyocxmOLj4imsGJba7kJRnhl16v9v1J5KQbmEbaVHC3KNHpXEYPCDzykSqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBi/wc9Y; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50d5a459ebdso61921e0c.0;
        Sat, 09 Nov 2024 21:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731215970; x=1731820770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NTMju2UnNFrYjgugqzkVlUGD0mmpi2BJWg3s7Jc/TXA=;
        b=LBi/wc9YafhHorycScw0EJ6qa4EQPE+l+zLkfLmL01bwboUezeUDCygmi7koKG5IzX
         13PMUfw+Ael1q8pwexz+mskdN/EYfegYtFydBqRQUQpmn5G7Lmh/VpwKNL1uxFqJGZTq
         EmvwZKujD9j1uO4ZimbklqHLsotmB7+RuhDKoVdYG7If1mZgX6ASEGFE0SdLvvPjbIwU
         WP2Fm/ZSx6VmRdTTPq9fg/B0d5ZITnct4ynyBaqe6Eb/yRTk2Utmocz5iLdQUhu1fBOI
         yeIWA/+P8Dxpeu2M9rodAs4i+p1vwiobLsmrn6nhBf+F7Gi8VAIbo5UCzwAOP8nfqk70
         fZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731215970; x=1731820770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTMju2UnNFrYjgugqzkVlUGD0mmpi2BJWg3s7Jc/TXA=;
        b=STkcbpHERyOVsaH59eph7JaowTm42Tu2XkJAKxJUU6tHiFUgLPrZJCk2eVury2kNcm
         y6PPg9drCSuAVwPQOzjKvvx3koiHsbKADKZRBsSxdAE0TzwLtjxIV6HuWzdBO43waLb9
         CVroDl+iNz5TxaSWmZRTk341wcdAYC5eaT4ZmOllyLN8/HetkCesJR0j4ZCP+1Z9NQA1
         6ga2vts1QT9lbIIvehRD7OKlzMyoL9PQPNKgIcTwOpBccjb8eJ6jY9woYHdxPTxmpbBd
         5og4p0nO3uvB/VjYr6SD7YRbv8juQ2vkRwmu45/3szmGrbi/fYzdVRaSSp7UPkpy5nLl
         vYpw==
X-Forwarded-Encrypted: i=1; AJvYcCWsSgFExAGQh6DzkPWY3U9TFgHXXDXBZAZioD8DEXGnpTLn0vHkGHXPkirKkDaq6D2E4C2L/Axqnjokz1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMDtc9PsEJ3m12pLwQvZYdLoGCxurJ9nOseDWWK6UGUkudri3
	c1oOnE+EPIh254a5wOqpi07cUoOAppqHABPV/iXP0zdFdZ7gC/wwC/C0tTTi0BL2L3kEz4zUEpS
	qL09AbC20HH60RYQs/QSQ92VtHs0=
X-Google-Smtp-Source: AGHT+IHU81GseyS7OqHvNJXOmUvRgbeU9iufbSZ8jAKaBdcr+2TucRuAFt9UN8Ha2wNxAxFckp5T6BlzyNYAgBLYs5c=
X-Received: by 2002:a05:6102:150f:b0:4a4:8b67:4f71 with SMTP id
 ada2fe7eead31-4aae134fcc0mr2744146137.1.1731215969605; Sat, 09 Nov 2024
 21:19:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109055442.85190-1-christiansantoslima21@gmail.com> <CANiq72mhgL-eidEBhxkzMKFztAjRjAFEdeO5Oe6Uv1mVMtEdoA@mail.gmail.com>
In-Reply-To: <CANiq72mhgL-eidEBhxkzMKFztAjRjAFEdeO5Oe6Uv1mVMtEdoA@mail.gmail.com>
From: Christian <christiansantoslima21@gmail.com>
Date: Sun, 10 Nov 2024 02:19:18 -0300
Message-ID: <CABm2a9cRno91A9yPRzkoYytNf6SxMUmtew7B=3fQ5qZ5=0ojEg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: transmute: Add implementation for FromBytes trait
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, ~lkcamp/patches@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"

Hi, Miguel! Thanks!  The last change was because the code didn't
compile and I didn't realize I had removed it. I'm adding it again so
the code can compile now.

Best regards,
Christian

