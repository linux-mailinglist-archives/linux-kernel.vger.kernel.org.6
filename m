Return-Path: <linux-kernel+bounces-367585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114D69A0421
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C612E2853DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CF31D2700;
	Wed, 16 Oct 2024 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rifhwFss"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6801CEADB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067044; cv=none; b=HnF6E8e0DgmKrnrUJlOqkNrzhNMcbDXI471fnO5kvzKSAmeGlPP01NkX8A6HlqcCtrS5Unobsq8BZkZlvlnLjYR6D7Nr5cffJfB92sRAbTR0+F29M6XMPniKupkKA9bmj77etGXnpgr6C2ossaBLaDil9uC0xV40MeK1VSrHDOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067044; c=relaxed/simple;
	bh=SOZstSuzk5x3rCH3QK0Yf4wRMdKOYSHN+ER44IuBXec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKO+9GjpMiSNk7wTzzwMV8ggcN1YtoSeIih9lGs7IBgwmToSb9WxxkF8V+AHNK8UqA3hsoGSOjvQUy07dtGlpizAG48uu6sLrE5rzVPQ149akveLZ0EzPMtLv0BSG4EuXaYB2eSCV2Jxg0XXH40JYTmSSryNnq40v7LwoHRl+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rifhwFss; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43152b79d25so2635055e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729067041; x=1729671841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOZstSuzk5x3rCH3QK0Yf4wRMdKOYSHN+ER44IuBXec=;
        b=rifhwFss9zkLwSBeRT2tFN04iStmXX/7r6VjBRUyd7AffqotOLO61xzCI6+6FQuy/H
         Yfn7Rbt2TTQ/zJ9KTL16E+N3jvj6pIMKEJUDHD+fJzRhHMH+cPRmyonzqkv1OZ2eXHxC
         ZS4TWorR3zB1ZDY7VGZK5x2AhTbTvG7CZI88m4eckDObzI3PeXVTGvoJPQxDHok7mmRI
         i469fQTkhhO936B2AtfPD9FfjEMtf0wxYomwjLflmPCT+lMipLuLVUgDCDms47JMqyq8
         wtXytkAzUI2BMCFRfTYKZNIcbFs6Jqn6ZobPNR4p7P6zdxFY8/RdM/det/Lnq4vQHl9A
         3kMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067041; x=1729671841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOZstSuzk5x3rCH3QK0Yf4wRMdKOYSHN+ER44IuBXec=;
        b=fX0HcglSrXFcTDJ3Yddu6dsujV1eJ+NmHb7jrTpgKRr3BJNa1Fyn9DUwAZuDBBn5+S
         tLgSfIzH0++TI1V+2FODKVMfypTt6ZAKcLruMtmpQ7f1XYyo6nBpNx6gvnQqzL3Ef1WI
         jiynsMTKamET/sHAVdgtkDiGEQu4ioNysk1MxR8dW+mguCUZclWWz5uNRwA0Em4ZRHjk
         ezyPinCZ+adEHDMBKs6KwkVspklA+y+pG/eFg0lNrWJiJlV+wOgwKt5rYMARG+RuUy7s
         9ntiCiXGtnHMnDMgYR2LqFrE1n0TPGLv/S2DQ5dbgsJ0k4CdYWT5jlVVZk1S8RNQzPSe
         XKJA==
X-Forwarded-Encrypted: i=1; AJvYcCXgcN+pQ9h79to9bpSUC/cM1ixeV5ijwY0XDg8WyqnRVPl5N1DuVuCuMp73PRXJYXuth57drO8HrxKoyVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9qV5TBRjA57zCtOtl/YYjgf+jbQlz0Pvtc4GL4ZvzFuXQ6tQq
	T9pz/uGAKazxA76L+UX8PAbX0BGG8v5MY94N3Pv2rqVixSCQb2WuCBW7g/7iwioaZyiAXgv2FdA
	fPj6C8yxGKEpeyizexGE8SYMIdE5IOQ0Zw5M5
X-Google-Smtp-Source: AGHT+IGOL0OpGbJgJF2jgld67e6vJYkFsp1kZtv8jTPjujkIVLdyXx6e+EnfYgZ4ba8ncqwErJP+TXDgSm3WswABb3o=
X-Received: by 2002:a05:600c:1908:b0:431:52b7:a47e with SMTP id
 5b1f17b1804b1-43152b7a83cmr7342125e9.35.1729067041288; Wed, 16 Oct 2024
 01:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com> <20241016035214.2229-3-fujita.tomonori@gmail.com>
In-Reply-To: <20241016035214.2229-3-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Oct 2024 10:23:49 +0200
Message-ID: <CAH5fLgirVk+9aiJGgXe=ikT0i3XKEiXSSPVQr4ZUD+0sKrU6ew@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/8] rust: time: Introduce Delta type
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:53=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Introduce a type representing a span of time. Define our own type
> because `core::time::Duration` is large and could panic during
> creation.
>
> time::Ktime could be also used for time duration but timestamp and
> timedelta are different so better to use a new type.
>
> i64 is used instead of u64 to represent a span of time; some C drivers
> uses negative Deltas and i64 is more compatible with Ktime using i64
> too (e.g., ktime_[us|ms]_delta() APIs return i64 so we create Delta
> object without type conversion.

Is there a reason that Delta wraps i64 directly instead of wrapping
the Ktime type? I'd like to see the reason in the commit message.

Alice

