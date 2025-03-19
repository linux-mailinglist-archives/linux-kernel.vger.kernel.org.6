Return-Path: <linux-kernel+bounces-568332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E4AA6940B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710A3188EE14
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDFD1D63E3;
	Wed, 19 Mar 2025 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETZ0MMgD"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACA1C1F02;
	Wed, 19 Mar 2025 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399044; cv=none; b=J1zi56TRwr9OfOvAbPzAEAvb6aQOzPC0JkszUcgxy9IQyoCSH4YeiUCuOmqFTuAziAwxlSFePx4HMbLjdkDsGLWKGANdU9UL36bsvwwSwWz5qWdDQKfTWvV0poYrWtTalu9Dvw980iP+PAE11M1UGQp8ce73OnfP3Rtzlu3/uKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399044; c=relaxed/simple;
	bh=Suwb2PTy7IoOls+Zy0HQ0z686OYE9SwtK8N8b8Hiyo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBUEZ//Ku9HxUa+ZA7U0n9AwgsHdt0afWm/e9ZnQLh7HQ5oUTAr2uCQzR8Fhh6QTgxPQzTpbOrnq8oFtHP4D6AUwVJPNFX0Y1U5H73TGgh83EfJLOQN0Pt7qRj1tNeCy5MH/YXCdj7vts6KDmozXV4AApaOQON/a3ZfT+lTqW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETZ0MMgD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-301001bc6a8so931499a91.1;
        Wed, 19 Mar 2025 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742399043; x=1743003843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Suwb2PTy7IoOls+Zy0HQ0z686OYE9SwtK8N8b8Hiyo8=;
        b=ETZ0MMgDIyuyuFoVZ67cOYSdpctZeqyFYkPuF6Ss1jwZuKb1l6CgoZP1Db9tukUC3L
         eS59MybjAeqNg+CL2OBaocjrNd+IX42A53+/3MCTA12e3BzmGNe2iA0lugX17KiFGGDx
         K5JiLACJ+hKYaGVq3RbV+Wa3T1BNns+xAFdtyk2IyKqzqtKbcuxYeHxLfs6MEtsG4WxB
         QbYpSxoBRaUjm4BuBkuQ8E2XTXCqHnCLG0QjKT2dGZraP0lyyWJPo4khUAgax8NPhXlr
         jCqFwsNZK5TGk9vm7r0XetnHkKI5CyqUmem9KH92tbR2uztdIWNx6+b4se6N8Bqwlvzl
         02ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742399043; x=1743003843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Suwb2PTy7IoOls+Zy0HQ0z686OYE9SwtK8N8b8Hiyo8=;
        b=nKL8zU59n0Oc6jGUhJS9aH6YH1QDp81kIkz+F2/krqV78z1zgI/cbr0PxQJOTJoTlQ
         HYNENI+EWOhYLNQPqEYjAehfF1yFZZ3VrNT1bcJmbhX/nx/9Tare/WoqV6QudeoztChc
         xVqV4gJugBPwoLH42WekRrrGcO3Wcvsoq1lquxZlrD6gwcZoXyGQueZRrAuilGbextAS
         JUe9hHPMrIQnE6W94TGFlI//eGbp7rtBqn5W6LsAT5nlHIIWfTsLfwq8HL0ZVcEb9B5z
         SwneqnlY6Z/Ig6VzhVrFXxYVNMS1Wago/JypcWYox/s2qTicSKbVwqevcUmTokXRip0t
         V+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnL7luAhycpV8Iwdo1CvTvCPeCkERcZEZWFNcu2osK+ffsIat1uUAI8704KVzZVlRkhVmrC4dCE6Ayz4M=@vger.kernel.org, AJvYcCWKRJmo3dI27PFKshHZWkrNAS4vOfaJKazwJOJgXQTxZWyoUIRS3xV9HU1hXF11jzsZANFnkgSsO78hfy7VvWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+OXMD/4/EDZ9WwTk5fZJ1/bqrHUWhZjOSvWfD+JkIh3gWMab4
	5TxfUjjhbdWNCOEQeQ+0cn4Y9oOSUo1A+ayqphenAGLfhavrC1WQds6raJ8JjHgO/YvbcIyyOU7
	jico4ClbyKJobR91CJaIBl2MRSpg=
X-Gm-Gg: ASbGncu+v+kdESSrGPyrlYa7JFU06Kp1DATO700SLg05t8DeOOU5BrDOf+lAs2S9rjI
	jPBc6Cf/4wHApG8qdaqpX1Slls84HKM5WQ9bbaru77JMiCOkEbvyt6Vg0OGLXtfPt8QMQn+9ODU
	uQBET9cgL703PhpfPubnYVXI+BzQ==
X-Google-Smtp-Source: AGHT+IF0WQ6LFNJOFQfijZ+YJ9XxXRovdYJWiNEvkRBwEYn4hHBV0SMgwqXfIYfMFme9QZmf59tYbXqaLkwZ107byGQ=
X-Received: by 2002:a17:90b:1c08:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-301bfb7e9demr1758378a91.0.1742399042723; Wed, 19 Mar 2025
 08:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319112822.1961241-2-bqe@google.com> <CANiq72=fBJLhgW64vohSopsR0RQLch+_cKqRKDQT7yR9B6A-mw@mail.gmail.com>
 <CACQBu=UC-DmLGpg30=Dyp5hhWV7HGXG+bL73YBSq5vSa4t3mig@mail.gmail.com>
In-Reply-To: <CACQBu=UC-DmLGpg30=Dyp5hhWV7HGXG+bL73YBSq5vSa4t3mig@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 19 Mar 2025 16:43:50 +0100
X-Gm-Features: AQ5f1Jq_eszWsSE3-jdd_k7tby7vgOyLeR3gifDwHYGpicMDY3ts6rpUO5ZFXBY
Message-ID: <CANiq72k8-5YRwmcn1h+avuyusAC36ttOqwsMH_eO-DLxTm5gpw@mail.gmail.com>
Subject: Re: [PATCH] rust: adds bindings for bitmap.c and bitops.c
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 2:58=E2=80=AFPM Burak Emir <bqe@google.com> wrote:
>
> Thanks, I was unsure about this. I understand the desire to not add dead =
code.
> Yet, next-20250318 does now contain helpers for `cpumask.c` without
> corresponding `cpumask.rs`
>
> So, I will include this in v5 of the rebased series, but with BITOPS
> API BINDINGS [RUST] in its own patch.
> Thanks for bearing with me : )

No worries at all! Perhaps wait a bit in case I misunderstood and Yury
wants to clarify.

Cheers,
Miguel

