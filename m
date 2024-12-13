Return-Path: <linux-kernel+bounces-445151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACCC9F1208
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063B9188C9F6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9746D1E47D9;
	Fri, 13 Dec 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAHV/BsJ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592DD1E47BD;
	Fri, 13 Dec 2024 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107124; cv=none; b=WCDyT/0U1nQ0ZfaBctwjfaiyJXPOnubGqGDA7riJt9vS8iBePXuMAc+JWa239+RfuNVOc8qCNPQ2w1X6BKbAupKyecvwAQwTlcxHtvta1Ybn/JjoLL2syglXG+aXfnaaO2wmHgBneAYvF+dtH4c6pOxR6uBsQ5pEI74kClyP94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107124; c=relaxed/simple;
	bh=utTGiUY2KFTz5GWPj+z9ni89H11QDVeYdPSg/6nfzkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LW6FrztdUOqucfgsNF2MDhnwcYawYGrM88RvVntK7Rv4xwD+7iaZMQrNvzY4ZXffE2n3RLpGglU3Q5y77htQo6pZZUOrlwQeFaTfNbTSHiK6MXNQr0OczmGbwr0nbZATM2HXsHPOQcjt7fja4FJpD+a37yzgAsZbLBqBDin0iKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAHV/BsJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso21291201fa.1;
        Fri, 13 Dec 2024 08:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734107120; x=1734711920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utTGiUY2KFTz5GWPj+z9ni89H11QDVeYdPSg/6nfzkQ=;
        b=FAHV/BsJFtXfbXqzL5rWlmTV1qhFNyEDZBxugyMbKKMOjvvE0O0sCXyACoZ8yNh4oL
         OKVzRw68bnEDODiz2baEHi4kVfqBP1CjoaAB6gxiupFvYSS0DuXAHfscHvI4J8f+DyPT
         Rgo28Jh+PlU4i/vdw5cbHSd21cKvngub+dxyXzoMysQs8QrK6oaIWOh6AlgfRaxng7v8
         e2oLw7PaWOBgR21TBHUn7k3XU7oRYiwnTZPjd2w8Lbc+goIuptPNWEZEb9kjrzANNlF5
         Uzu3dCIoDBWCsBGnjPB5HooOqyTgKbwgnpl1qGsAmJmzmF5Au1Vj0A4QgPJuOyMCNaH2
         K9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734107120; x=1734711920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utTGiUY2KFTz5GWPj+z9ni89H11QDVeYdPSg/6nfzkQ=;
        b=BZBgIMPbHmFLAUafu46sgkAyI31Z8QRXfrh/astjL1L4YS7lEJ8AqKrHBrbjvaOL8I
         N1Zg92fRlJaWQEizLU2qhcPA0LHuPl7D1IZIjjQ/xFGbf2IrcOOLUBhxk3ze5Iw/ru5A
         KyKguUIqktKNGvMk5q1g+/1tCCQgU9uyCtHPudq+CZiDOuKK10CmGdD4g0EbmShlVYq+
         IG1ZE6dUBiBM77PZmodMAn4+An7Bk5o4qtykVzWFiC8zuuczKRVKf2BAWqaS/JQBYx5m
         enKfOdnRzf/VWaypss3xPaDNhzrPsSobz7+EAPocqj6fwz2cha+8XFOunx5MIpGXXbf2
         bj9A==
X-Forwarded-Encrypted: i=1; AJvYcCVN+ikmeFAuGuzrcCHoWQYlIvNddZUbu6jtsZQsNqRUtJ/rtyaN4fvbJCtwT1AsvcDv1Pne68v7JfBOmiP0hAk=@vger.kernel.org, AJvYcCVWM8z87SqPceZhgFW63MiZqhF1i4o9CifjytaGRm5itTOGlmKvhZ3O9s7jOL5W4sTy1i6x4SUFCJnZYVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAlLw/f04phoBN6f/O6tpN+1P1nNePRphmM8oL4/KSlT9UAYcm
	GgwVYPu7hdwht7MBuftMNlxoSjMhJwKv386oTeARDtU52wHnhE6IJpdyMo0tR/vi9R5toPn+EfL
	2j5E+yagLMDDLa3Nk6Xl60ngMsNA=
X-Gm-Gg: ASbGnctePXgkuwM21ucmIqcnJUvh2gkjzdyOLjyysd/qR74ByQ6fdR/OVNDbSFJ9dun
	EzeEdfcyjBfuF/QUbNDFiDEIaUpx7h6UKtepYpvR+iX31NwkDs3lhSw==
X-Google-Smtp-Source: AGHT+IG6+Z/vc7PfFQuJAFc69iMoTu2hkHUqC+2mW132HdtWerzfD+W5ZppSHbn0aM8OBx1kcQpyrVtjci4763bp12k=
X-Received: by 2002:a05:651c:1546:b0:300:7f87:a65 with SMTP id
 38308e7fff4ca-302544cc311mr12540091fa.35.1734107120081; Fri, 13 Dec 2024
 08:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-rust-xarray-bindings-v12-0-59ab9b1f4d2e@gmail.com>
 <20241212-rust-xarray-bindings-v12-2-59ab9b1f4d2e@gmail.com> <CAH5fLggwK0LXAsBnP3FtFHCnEzzBNNZfsCy3iJ6w=nT07CHgVg@mail.gmail.com>
In-Reply-To: <CAH5fLggwK0LXAsBnP3FtFHCnEzzBNNZfsCy3iJ6w=nT07CHgVg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 13 Dec 2024 11:24:44 -0500
Message-ID: <CAJ-ks9mTEcRg6=ZiYFX3ebHSYgMwTv692ufUdTCoA1vX5E1nNg@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] rust: xarray: Add an abstraction for XArray
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 8:40=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This coding style is pretty far in the functional programming camp
> compared to the rest of Rust code in the kernel. I tend to stick with
> a more imperative style to be more familiar to C folks.

That's a fair assessment, but it's a subjective area -- Andreas was
fond of the approach (in a preview review).

