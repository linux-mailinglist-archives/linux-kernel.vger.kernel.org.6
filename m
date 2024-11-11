Return-Path: <linux-kernel+bounces-404284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74429C41E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898C71F24FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294D119F130;
	Mon, 11 Nov 2024 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOYr/emS"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3D339A0;
	Mon, 11 Nov 2024 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339156; cv=none; b=uKLV5rNwweZRdBGqDNe8XyRlUsP1eUwjr1YMYlV+a+uC5lbVLsrprAHjj4ibWEV1t2oTgqRHSmIo5Sr+O9m0qN1D0ApR8uiLPZzwDEZqQEebqTpKev2kafUn1ZAU0dg8Abrjua8Y3PfjmvFZSHV4jF3oHecRN3bfuGbUlJjZY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339156; c=relaxed/simple;
	bh=4dtLWJYlffHE+FCD0GMA/gShdphBSPEvhwHTIGZTc0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twjWp9brKkU5q03L6ZmkFh23kCfAdyA5RMeoVXu/6IiVQEDh+bHZVQzyWLRYqcuD9WBYo6aGSGYGeIbxSymWrqEgWTdykHO9ULdRqG0asKkBc27EdrjCRLMV/NNkJM4s/ezN02IXUe9wnzsEyQ/SYJuxYHslanlojLOhotxUOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOYr/emS; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so5171995e87.1;
        Mon, 11 Nov 2024 07:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731339153; x=1731943953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4dtLWJYlffHE+FCD0GMA/gShdphBSPEvhwHTIGZTc0U=;
        b=mOYr/emSI1pRJoGP3JMFRbl91VXZ/zkrUy0l3TE69aGG4CeJCdTN20QcZFKSGgJGHJ
         XUC9L0k79XPw1tmDv2eLqhBZJonmZ7FRDCprLJ2qUSybchXQNkB8QpATQ57R616kKg0J
         osus+pktrv852vHv8PThuQr7nmhRYOBS/fl1SdmouPVsnFn33Tqngs/cdcqhQny2dJUv
         HDyqWZhwU3L3LFIqR2jqNBnp/PzoUDBvrHEX8AhXKBafXkYKai3ET64a3wbtSs9dPwsk
         AKgiIcIOYDogOaX/pW+EykUbVB/K5vd6BwrlJyRwnSytIQN/RrZGADedmtd76h56+bqa
         31Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731339153; x=1731943953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dtLWJYlffHE+FCD0GMA/gShdphBSPEvhwHTIGZTc0U=;
        b=auYKWkGa+WMd0FBv4fdI5zhPVREUSedOv8+T0Bv4eBhE43h0jPufY4R8fWHi13CK0v
         hpYUZdUh4EaXi60X7BsGDW21TZLT/BZy46qhXF4U7tEyMHZotX8N6butwyQkembdaHPo
         kXRnKWQf8tnesmRSey9CA4aYhhnh5w+cOMoMvmpKwMZslBCjXQJxmU0eFlpxMe8QobQl
         jtr/zCVmQYpgY/xEBnaMMDtApmA7nIPH1Y0A+JYoEfoOHKSxPEVi2zEjdqDcYmiX5y3p
         SEMJudXrIcqWdeYF57HL6Ag7sHah0ueesbNCPKG3s9Y8LJjPOpWnlnjmyYc27S8uEzgi
         Motg==
X-Forwarded-Encrypted: i=1; AJvYcCXTe/mB43z1L5zVehkY9xNjiC9fsE4xj4GeTz0h0NqwIYWfk3vw8fGDci6aiNorl3jJkw26v1KqcGv+9FY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY107Ygu5y/+y79cRunLu5975dlsjEICeRJ/LwkJ8arVXuQ9O9
	ZPe7TeLr+g51ziuc6GG3hGsRqmeS3CCFIL+aWLOhqubzQw6juJlJY2J8nLTr4I+QA2mSpVIM1MQ
	UAyjr/NjpiLSVe0IljHh6pgG6s9Y=
X-Google-Smtp-Source: AGHT+IFuiqYDT9JdC80x9CPndyU414wpLcL/PyRMvDOTe4bSWrY9Foalx3TwTZMRqSaymMhfEtjOkrojGWv8DxyUzwQ=
X-Received: by 2002:a05:651c:1501:b0:2fb:5cff:fcd8 with SMTP id
 38308e7fff4ca-2ff20281d5amr44961441fa.34.1731339152770; Mon, 11 Nov 2024
 07:32:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110-borrow-mut-v4-0-053976068215@gmail.com> <20241110-borrow-mut-v4-6-053976068215@gmail.com>
In-Reply-To: <20241110-borrow-mut-v4-6-053976068215@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 11 Nov 2024 10:31:56 -0500
Message-ID: <CAJ-ks9mSu0Wivnsn605ZTFHiYqK4VEhURO-7rj5jFAwSxJsABg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] rust: add improved version of `ForeignOwnable::borrow_mut`
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This series conflicts with Gary's FFI types series:

https://lore.kernel.org/all/20240913213041.395655-4-gary@garyguo.net/

I've rebased it locally. Shall I send a v5?

