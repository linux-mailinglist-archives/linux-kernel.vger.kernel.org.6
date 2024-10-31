Return-Path: <linux-kernel+bounces-390528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A9B9B7AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60DE1C20BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69F61A0B04;
	Thu, 31 Oct 2024 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX10xMRg"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A91A08B8;
	Thu, 31 Oct 2024 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378436; cv=none; b=CF8L6BCWOdRWve8fvjo2y1LIufT6GKNcAPe5y+DOU1TgnnfZzlE3gP6wfMkWF6aFLvkuHoLRszbNm6oaEHh7tAWIzL4CnPtuSHk+sWtw9H43f1Anw72ytjHpp8RG8nh3whsXeuUD9eeRA26kRLZHtxh5VHOGbSsNyRGEI+42Hyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378436; c=relaxed/simple;
	bh=amOixPXCr+CZJ/yctAFKZ6OtYBT8ncNZRjWRP40Ffbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IABXCjf3yV9r1Gk2tWt8xmxihe70ppGu8JMgkxWtgQrTcJFldl4OffUp1oaLUvp1BkyM0KJcbfjc1hys/Cr8hQ+O4krUrJXk9mRVm18Ea7/tRWBU1ms5MHT2+ethB4WvGm+RSL/nIXYqYqo4ZBN2L4o1FPD499BnVd4hFBuEYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX10xMRg; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea535890e0so114104a12.2;
        Thu, 31 Oct 2024 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730378433; x=1730983233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amOixPXCr+CZJ/yctAFKZ6OtYBT8ncNZRjWRP40Ffbw=;
        b=ZX10xMRgPc+ItH+jVue3VXKclxw7oWgSLUY3427Kq0mR/rQNTHvp6CKiFJdZOmurvv
         I8Nc4r2b6hDdjbVSDDiqohtJxkxjGrtyQKcs7l/W9mv6yESMtvL2XEfTLZe4bor/M9wR
         rT3cnQp24M6s4BIRmPfKq+gcKp6LLMU5KYhp+q3ChekwINQQmfjQTqD/77Tv16u1s18R
         dHH3tKI6VwDk4C8WXrvQNp0NJVD4/YOupScjCchWG8c4H36KlWp0qRFnpNk+hw7s96+Y
         Q3MkYXHoLh8t4likHP8SjIKV/Jz0S21P39BuYiLIXM9HH5it9gE2b/LXVHo1APD+cSma
         1oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378433; x=1730983233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amOixPXCr+CZJ/yctAFKZ6OtYBT8ncNZRjWRP40Ffbw=;
        b=A7qVsVWi/x/qcdJaFhDAQytfkz13aN/ihDPmzuFIUYTZyCXS6GTAUI1PNMalXJ40fV
         iINYzNAIpGJCNanUfWsz9vChBb+wFr3b1pcS3mbLd4fiU+xpjfP6aob53krYMQN63MDR
         Ws6QR37O+7p9iuETym/si53cuHI8Udz7UlhoRsTV4E1OZDkGbtdlp/zDG2h6+LErFD1E
         lAaKyVFhaIjQ3qwCNqGC7+5m8GlhpJxnu/9SrC1UiLChNz5+6F5gd5iW5AtZ8ge3Q0jD
         Ml2PVLrDU1HrXqQX7b0LsEu7zccZg4BzmHPjDGGAWijiC6ayR+WRy6n8CvPXd19p8lVj
         bF+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQFyuGLg+ufnDls+yMP9K/nsaEb3/NxhkhPAnhobX4sN2FdP177FMhAIV7jxeVkas9Gv6s2vE7t1Sjb6Y=@vger.kernel.org, AJvYcCXy8vwKI/vCyMftWo7EM8l3Ya832GYZGM5CGjcKBsB63kZaajdfaTx76/cnY/S6LXijb1ZA8c2cpWsLgBt2ECc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2vnlKjnkuMEtYbQdr6r0CdZ/qa0TcTIkbihCdwfTOqIcKUhK
	oYL6nB/NjOkotxhdKsvtXONOyXqOq8mrTgbwQ5fRyQa96Tc2Lzi6HYwZnVA14qvd4m/NBLtwPt5
	P5CybsKJ9AX7qqvoZDJbD0DfvmPo=
X-Google-Smtp-Source: AGHT+IFFMeukhCc1eqnAGpFNQBlV3vHr720txMMeqSuPmBF+HNPw+E54xnG/AVd544ePZK2CWFmQgokkPxb22SXiVls=
X-Received: by 2002:a17:90a:77c5:b0:2e2:da8c:3fb8 with SMTP id
 98e67ed59e1d1-2e8f11c0f04mr9525410a91.6.1730378432817; Thu, 31 Oct 2024
 05:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
 <Pn1b5OU4cqz38Aiv4RL7MuzPDwDGvxLVRrLuCF7Q3_HaeLzlh4jaM0krBqB39DCFmRLWK59Do8DPaVxLNaaTNQ==@protonmail.internalid>
 <20241030-borrow-mut-v1-4-8f0ceaf78eaf@gmail.com> <871pzwpsm9.fsf@kernel.org> <CAJ-ks9m-THyqK1tYL39t979BagBqj3Z-MOSn8wPhDc82awjzug@mail.gmail.com>
In-Reply-To: <CAJ-ks9m-THyqK1tYL39t979BagBqj3Z-MOSn8wPhDc82awjzug@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 31 Oct 2024 13:40:20 +0100
Message-ID: <CANiq72nX2=yigRKhP3jN0kQ8vD0kMvUOp3rFpRQZJGAX6RrRhg@mail.gmail.com>
Subject: Re: [PATCH 4/5] rust: reorder `ForeignOwnable` items
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 1:23=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> This change was part of the original patch. Do you prefer the code
> movement in the same commit?

If we do it, please keep it separate, that is a good idea.

However, I think Andreas means to avoid the movement at all,
regardless of which commit is used to do it.

Cheers,
Miguel

