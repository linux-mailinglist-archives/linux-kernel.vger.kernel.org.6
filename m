Return-Path: <linux-kernel+bounces-538967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B00FA49F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF68189993C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D97274248;
	Fri, 28 Feb 2025 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeAAJdLN"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E2189B84;
	Fri, 28 Feb 2025 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761590; cv=none; b=CGX2nS5+vqFbzWgCGh6+L6GrAJV9ZOHF6fMCETepf1B3IN3XLDDkshO0VBgwIvJqUzcWZwXwB+WpeE3jgLVYEDPs2+RwlmUq1qZRdfNuNvw2WCzMmLtdSAVWm3SbpbWL6Orm9pqXsFk6I8PK3bon3NyUMxnGKFznCwFiXX4rLZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761590; c=relaxed/simple;
	bh=bLFy4dLPTMPmfedYKSEthq725z2E3f8b5RvrPsWSXqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfjNjGh2Nb5Nhja/5vZdEeDZdzirNAnvQRakBERHZieRoUAHOexKx7OplbNEtdVCewC4fzhEPjuxpCFRiAy0vXGOX4cFKMRZCfQ9RkG03qQkCtPnnvXG+KijKdixpXOBbKpw2PfvUOFVpmbc6fS2ue6Q0/g0ZLqX7x6hTtaggiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeAAJdLN; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fe5d75ff8cso610534a91.3;
        Fri, 28 Feb 2025 08:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740761588; x=1741366388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLFy4dLPTMPmfedYKSEthq725z2E3f8b5RvrPsWSXqU=;
        b=FeAAJdLN6/boNAdDSYWqq/ej9a+MiKQcfhEqYVMtlu25RiFhFySIbfkVI0Y93yD5pN
         StSl9GzZMKV/ZZNHhCOvX6bTYuu2fMIMeUjk+JAYj8x50PDSRNf1pdBt82hjp9VSiGmk
         p3BFnPb2V6nX1NH1zrzy0jB72+aJpJCB2FG7mi0EwHpG2HStrQw+YbsLjg1NJftNUHfP
         BbViS0NrLJBcO63eP3j31m+NkZJneOzjPZlmLN5OSKxXgrbRdiowSgv8m7U61cEYctmE
         XK5V0dLrLHftecqIAhuYc5MfLLa9KIOAUtv0GE7RjXBtuRV7bUsml/y5o7plpQruPv1J
         gZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761588; x=1741366388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLFy4dLPTMPmfedYKSEthq725z2E3f8b5RvrPsWSXqU=;
        b=WsM4ZQ6cqbRIGoK1M+4+C2DI9nL2M9e9s6eIhUz8yQVjYYF2wX/cGFrUwaj6Y/vcIi
         f5Iy0TZ0HuqnmYrxTF4nu6HW1cD+J3oPUNQ128QQ0rF5F7NZL+0b3LdQWs62wFKZeLU0
         FWi1mySMFIyZhJMHv6GKskpUdGp51vVcf68P6lELv9hbdQIYWA5GE/c4F+fj8LF4cVRI
         7AvTZE2nvDAicxGPpDWO/H9swvxtsbEz18ldgDdv2flFrLxxOHuLA/x7QJl2pSIKkDvl
         0SnZnkziN35SgryNpdrqje9Hvb8KI/OOapOjvlkhziRgSQAeGt+8stRLHeu5Cnol96Mi
         /3Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVBfGWlI2gElZ5jZrCR1LBySK3JFHFF6JkojSzSWMf7rSJIGxV+kGYrNqEk8BKa7OMUmpKb9prh5tzDet0do9Q=@vger.kernel.org, AJvYcCVN1JopyZZTwSBdZ1FmkRWbVRbD3y5j4aafGVcC/4hOoILC2OLaD4B5PerzpNQtTNqJV7cpL/4zX/WZhHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywd6kTunF/n9pkeLzvbqYoTCH3IhOedQBfjv7rD0AmS7uCy5UR
	z0Jd+hai2ARdPfnmi4F+/Cu+USC7UJL/rWcG8qFNZfRpxHPEnwhT7mHbTCeeQDxnn3UYcfsHfH9
	+A+tMqGTww6oR4CFROhoPPvj7vlM=
X-Gm-Gg: ASbGncsMvS0k8Yt8Pkrd48REIr1BkcH/V2mJ0Cz82Hvr8R+7ft7zgHT8d8WJZLj3n4T
	Ml4wrgGHsyROSTlVRNGYmtiyOzP8kKzDH5j5FgqQ2j9YfdoZcxYRYFjjBKKjzoVWkAcUo/oOxMH
	0/iG/yXas=
X-Google-Smtp-Source: AGHT+IEabpHlD/ZFJMOi1Nz8EESWEiDt15fTdWfPe5Dox78oNhY13LkdOtELGxHB3stZA3v+yeCpK201xo74IBiJJhM=
X-Received: by 2002:a17:90b:1c0e:b0:2fc:25b3:6a91 with SMTP id
 98e67ed59e1d1-2febac0576amr2629651a91.5.1740761588035; Fri, 28 Feb 2025
 08:53:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <kQ8hbiYXcV2MseWnElEexwgQswt23842ggoLF2xsd1hDd-4K106zO_gGho5K6KI147luazt2rZNOY3NOJP4JOw==@protonmail.internalid>
In-Reply-To: <kQ8hbiYXcV2MseWnElEexwgQswt23842ggoLF2xsd1hDd-4K106zO_gGho5K6KI147luazt2rZNOY3NOJP4JOw==@protonmail.internalid>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 28 Feb 2025 17:52:54 +0100
X-Gm-Features: AQ5f1JoTGWdcCTTOPcGWqmyjXyMYZPDtD1emKLgUhr33suYkWbeR2ljxGv-2qMU
Message-ID: <CANiq72kgAh2MkfX0+ihjgTAvrexmg+WoPyQnaQ6n1Yq=u61OQg@mail.gmail.com>
Subject: Re: [PATCH] rust: adding UniqueRefCounted and UniqueRef types
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 5:06=E2=80=AFPM Oliver Mangold <oliver.mangold@pm.m=
e> wrote:
>
> should I post it again with a fix, then?

Yes, sorry, we need properly formatted patches.

If you are editing manually the patch, I would recommend testing if
you can apply the patch locally before submitting (and check that the
commit message and so on is correct).

Cheers,
Miguel

