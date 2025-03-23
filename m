Return-Path: <linux-kernel+bounces-573012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCC5A6D174
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF633B37A0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D561AD3E0;
	Sun, 23 Mar 2025 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYmtxTxm"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598BB3A8C1;
	Sun, 23 Mar 2025 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769088; cv=none; b=Q0Y97R8FwxQAUpnm81ISxVaa/WDXk45qiulm7eFKw6H8mJMdltksQesOZqy7Ga2fE7/U+3q+npcqMRfDTu5Ztzo0G3qhlhYeJqBG7gAzucgkIoXbDrpCVLZocNrPSbnP1Eqeemahr0pINIZsAJhWVWisP1l4Cj3hq4NIlaQFQgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769088; c=relaxed/simple;
	bh=vi8nwrQRl+Ctbxa5rHKQmTF1XKMZtYj/xv44j6HGrKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOu3CO2haKKFonPABuULtFC7KVChva44tZsA1+gURWQnfSiN9/0Fs8rs7RpxzmGPKv9gDfY08+pus8BA2y8uOLNNqbmwxJQ/hGxZew6Qq27iiv1ZVYtXnUxItWCg0qH53UM584VbbfT6z98LSd+HXuP2LzKLWlhpKUk0dDdmVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYmtxTxm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff7255b8c6so733295a91.0;
        Sun, 23 Mar 2025 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742769086; x=1743373886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vi8nwrQRl+Ctbxa5rHKQmTF1XKMZtYj/xv44j6HGrKo=;
        b=hYmtxTxm8VEuh6tIwTyfIZsaF516X0ma/pv18qyLlrSZjql+fPkQejXUrmt/IRTun6
         cMWNmPB+mogI395WqAIXcr22RbYSQs5AMdnAty+EVXr6ED6hfupzAxArzBobI6CYEHS5
         NODGu/Q96ei6m95QUzDc0JxvGJ7aOuCeGWvzVfwjeTz8Ge4CxNxYxPXheaI6VELxZJx+
         dFqotIwpPTvCb8wOwSHMndT4W7s2lbFflMmS1B1mEdxhk3J6ldxBiD3RI4DRaiILn7Jo
         L/E8IaftsH9XItkSp4gRi6DP8D6uqPZN4V/MHm2ADx22iRfCX6PKyXPzm1dmtt3AJCBz
         9sjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769086; x=1743373886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vi8nwrQRl+Ctbxa5rHKQmTF1XKMZtYj/xv44j6HGrKo=;
        b=VeYGLp8ndPlB/jzXeHy8BgtYfyFOzjIsptCZkyKxXLwLUtecYcBpd2JirNHaZl8meE
         PvQ4oUWo68TrvBabSqG7tDGuxafzxnsKsh8JyWBa5qdvnwwGJIUqaKcSFgd0SIF0pTkt
         uYf+rTssbtG21wDGCgkcoE5NYJo9hAEu/+IuJ6lm7sR+e0irVJauIW5ij26arrO9cBh0
         uCMvECdpSMEA5b5hvYRinYhP4kwjBrVv8lWDmiWRwhyUpnVHtnC/MlFDWvOE/frEp//+
         Tmb6nv5W9Sz1YeVm1D3Su6vwh2PF4e16bJlKQoE4rtgkDh2cdhUgWAy0yCso3wDkBFna
         s21A==
X-Forwarded-Encrypted: i=1; AJvYcCUwOylDWzqvzKO5pH/qFL5fPc6LkMnhyGiOJO9U6roCufyFix9K3A4qN4jY+HU1mzMiPmE1yXtnKphaG88=@vger.kernel.org, AJvYcCVmHrKza6GN/fhd7pJHlrhxZDfig8AeO6P/rzpDqp8c1HJ3I96tCXXa6i/Ye76ipbXMYjv1IvHG9Po9fZmhysE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIsPN+W7xMUoJdIYfupN6YpD3Ky7dkaJHJwN7nWk557OrBFbhp
	Iq8WOzDzRDZ6no4dJRkUrvFB8gJM14S6lW+Z562vOCKBX+oLQIj7GnOzxl173/5fEOTSDPKCiAj
	jSarq3SJsIWnha8PjLfsFByqiZu0=
X-Gm-Gg: ASbGnctlepX8eZqN15kMk37wjgVhucpAJssB9RM8a2HGnL9tTQlwh2zJESWnjANbI4C
	4xBYT9WelrUXM9LmWYRAHtlvSBl9TcvoJ/ZjT4JufxJc4lSZGc2Lg1L4bYvdHYok+glvAxHKTyU
	PWWMDpvdcz9Z0C6nCnD+Nuk4kP9w==
X-Google-Smtp-Source: AGHT+IHQo2n43xO8//iL3FcMh8NVFex2EDQgWKMg8A8PyOkWXaQbgL5V3eTTRHK7jFG4UW9PyVXdDJdhHm6u9RxsXzM=
X-Received: by 2002:a17:90b:4b51:b0:2ff:7c5a:216d with SMTP id
 98e67ed59e1d1-3030ff0e874mr6971249a91.5.1742769086548; Sun, 23 Mar 2025
 15:31:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315-rbtree-comment-fixes-v1-1-51f72c420ff0@posteo.net>
In-Reply-To: <20250315-rbtree-comment-fixes-v1-1-51f72c420ff0@posteo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 23 Mar 2025 23:31:13 +0100
X-Gm-Features: AQ5f1Jr8BpEbYPANsPPeKmiuu_KlFlW0fSE0d-7cy_vl3DPimUSjADFb4a9XWJI
Message-ID: <CANiq72mGvYnK-iuOO2e4q9MZJ0h4V_mLZp4xKsaPcXrnA_RJ8Q@mail.gmail.com>
Subject: Re: [PATCH] rust: rbtree: fix comments referring to Box instead of KBox
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 10:48=E2=80=AFPM Charalampos Mitrodimas
<charmitro@posteo.net> wrote:
>
> Several safety comments in the RBTree implementation still refer to
> "Box::from_raw" and "Box::into_raw", but the code actually uses KBox.
> These comments were not updated when the implementation transitioned
> from using Box to KBox.
>
> Fixes: 8373147ce496 ("rust: treewide: switch to our kernel `Box` type")
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

