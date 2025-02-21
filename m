Return-Path: <linux-kernel+bounces-525728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1347A3F3D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07437179FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C1B20E714;
	Fri, 21 Feb 2025 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMVo8UM7"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4FA20899C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139545; cv=none; b=CboGIiMnl7gg6iSD6cotdL4KbJF4UCNULQFtxO1LVZk2F+RSrlMi6JzXkvR4pb9f8qWy9mCqnyAFsrAbs56lsYA4FRURjap6jgXlX9jswzDa+vzfDeTUwhcviY1tk2OAi0K9Ph8JwbqdSl8j2WppCDCWRutDwkecKeZ9RbjmtJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139545; c=relaxed/simple;
	bh=BQstsiPQ8cT1WzjLJVwY7xRdnhbI7ttgU9Qm/4wMFTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peRSLQxq/wGcv2fs7kF5IrZoFQWh7b0GO/s90fZUIi3OoIMvtKHwjPDBHmYCezV8P9OB4mnrp6NbkPdwJgQedc18437M8oPi65mIlHozh0VADhOuMBiAemb8Xl/WXJlQHh+Ygh7b9EbLvyivu8TWbbKfejdlnVVSY5qdDiF0urY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GMVo8UM7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f378498c9so1807685f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740139541; x=1740744341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ehjj0CJUAO6DDOfCpZiQMMSQ39JXaHMG2u6ksCe/iG8=;
        b=GMVo8UM7K4lA+qzqk/sSeOVpHUy1JlbnaQ+2nlUxGegu0MINfkYg080tEmFLnYf3Qo
         5wh/P5LffBGnNTy+gt9EOe4tz1QKJrEz9gYGu7lBZC9duMbUGCoznFpyHJzdh8t4ryEq
         pXm9jQaQS+xK8r5ahZAcA5Zo6bjtcKwrpnj9mkNqAt0YSTjM3eNm/h+Pw28FazMIUpyY
         9TKAPWZwZQEiLl8plMs+me3ppyvZFTCAd7h1mpUcmzpz1aco25dDP4b3gAUQZ0SJ6hdX
         kncB9oNfnga/GU5adnCH21TH+I+6Q48yIOCmXALVxuxtyDJCK6N8OVFCgAlZ6KV4q+rD
         IQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740139541; x=1740744341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ehjj0CJUAO6DDOfCpZiQMMSQ39JXaHMG2u6ksCe/iG8=;
        b=hl3sLooGkaT9vU1LnjEUUyhYXA8QcSv2he+LlhbObSvc4cg9NNGGQG26xAQxhMySF2
         ExuxDCe0YpvgJoy36QYbjl0+G/h6eUKj5bsMV3tt6ZwebxTmo5ZLfIpYa0LPA/+aZvwy
         zyVHoFg+u6c7M+ZJDw77whOC1VVyLgKqdUHczxrUFdjnKRUhqEKRUsoCVg1me26O9Drz
         WOVKpvKyJaApaA2W+IfJh5qb5xTEz0QhPMcv9lGqpXYNXn2FpZrsShVeRwXfEoYucvV1
         gpPvy0KJRwaE1ut1hM555qp9GAT7LKd+YXBt6CdN0VD9lZ6TwSeawyAx4xd6JhDEjeCy
         quBw==
X-Forwarded-Encrypted: i=1; AJvYcCXCA4utcazjFoArEXOKZAmpiNZce1IRthcndrlVr8K7IK31i7ZC6TqdX+xyiEknHE+MtXFb9GUUxp3EeDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbIfKzLfqQdW0FIEl47UvGHANeK5rXCT1hCnWRrdISthmzhChs
	42TghJSXXdYIr+8cmcMZDyrBHm2JAKRkrA4haBlBaNawkUeICYCDjHpKYC0I+s9QlkeKh2qKcz1
	Sa/hU+LN1jRoCFcAChLQV1BD+UVJ7Jy4egYZS
X-Gm-Gg: ASbGncv7jl+IXLT37+3sEQ/OVuiKt1Q0+LFP+M1WgfwXdvH4tk+XeKY7rm0cUJBKXSO
	+BcoAYuyEbQ2kl2ppJRDoormiu+w1CDkWs8VdGpatnyqGjjd7zesLpJO4FiBPjyHPIaDTkNBghy
	I67RkuwPrRuUvEoWdNb0++vX0aiTmWgV+4APE=
X-Google-Smtp-Source: AGHT+IFUVqGJpEfAn3seSUzRTwg2k1L+NzWo5q83w6Bc89WWGUBJughjK3PTWCt5aJQbVcCE48SJfo3U/1oy8D2Zi4w=
X-Received: by 2002:a05:6000:1447:b0:38f:2f0e:9813 with SMTP id
 ffacd0b85a97d-38f6e4c074bmr2748320f8f.0.1740139541509; Fri, 21 Feb 2025
 04:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219201602.1898383-1-gary@garyguo.net> <20250219201602.1898383-3-gary@garyguo.net>
In-Reply-To: <20250219201602.1898383-3-gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 21 Feb 2025 12:05:27 +0000
X-Gm-Features: AWEUYZlMILyXoM87TavacNdZrv7qxkgn9wtRgwQznZAn-Ot0POHswTlmHPK0Q8M
Message-ID: <CAH5fLghKXePs1bJA1pHtnofKRmbwEt_PjdB380-zjQZ4PSxzgA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] rust: convert `Arc` to use `Refcount`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
	Wedson Almeida Filho <walmeida@microsoft.com>, Alex Mantel <alexmantel93@mailbox.org>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 8:17=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> With `Refcount` type created, `Arc` can use `Refcount` instead of
> calling into FFI directly.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Overall LGTM. Other than Tamir's questions, I have one:

> +        if refcount.dec_and_test() {
> +            refcount.set(1);
>
> -            // INVARIANT: We own the only refcount to this arc, so we ma=
y create a `UniqueArc`. We
> -            // must pin the `UniqueArc` because the values was previousl=
y in an `Arc`, and they pin
> -            // their values.
> +            // INVARIANT: If the refcount failed to decrement because it=
 is 1, then we have the
> +            // exclusive ownership, so we may create a `UniqueArc`. We m=
ust pin the `UniqueArc`
> +            // because the values was previously in an `Arc`, and they p=
in their values.

"If the refcount failed to decrement" seems to be leftover from a
previous version. This should say "If the refcount was decremented to
zero" or similar.

Alice

