Return-Path: <linux-kernel+bounces-571207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC75A6BA65
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2713ADD39
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CB7226CF8;
	Fri, 21 Mar 2025 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uqLqPeH8"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2722576C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559126; cv=none; b=b20oDcFVBb5GhrUCq9T68pjh1XsSoK1FYBK+bKw1trOD5BXL3lEGmiQB9Lm0DfbCWVeVm8I7QMaZExYS6jnS//wCDAFrx1/980KyMPTamXYR/AkwRWov+Z0vUol123qx+B//0/KsLACN5CwdMEN0CQTAkgwUgTdhr9E3lWpjPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559126; c=relaxed/simple;
	bh=UNNCij3fMV5Om5k9iqqBpbqo+0QEFQXW5NWRoa/bHY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJu7SW8O+Ylv4qWOLJ0Jsqn8fKAiubF6UyDNuVTtKlY46CbtzbFr8Kqa93ClJqZRke5KwBOBvH9Y24Pt0CYz10fPz0jCJw7fEJB4KVgGFUnJ+jzQ3p6LpkHh8/7B1FBqrExbQO9uBTP/vxmfeRoL1J3Z41OZ/1OO+yOSb6ChyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uqLqPeH8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso8880645e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742559123; x=1743163923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxPHoqhgPR3ScfztQgxMw9I0oJllqAs23ggh4XWBe44=;
        b=uqLqPeH8SXL9uJ46G8BR/pzliLpuMA83/himHieOyhAMlVRP+GUKt5GXb7Sak1Uze/
         mooJuZUFpvHwBaEpNTh3EPaLaFTEK088EZgK7LmyLinuChslWfD6y9XYjl52WMSJoVu0
         jspEfWtQPzkJIjjjJFEqUppatIYeONY/4BF2GWkamBurO0lKcaxcMLc/1fYQCfLDP3WL
         HT3SHZyfn/oLUQUuyrB0Bu6DFPf7xXYmCpkOxX9WnaNetIC98UQKc/3aJPfWeEzMEqU1
         MPrAQR6R0t6egvdteO95xFsmu3YeCGafuBIPtvxtIgZtPJCJ2KagEJjOP8rma7NKW7bO
         5ECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742559123; x=1743163923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxPHoqhgPR3ScfztQgxMw9I0oJllqAs23ggh4XWBe44=;
        b=Xdjc3ChaeVCb4XuySraOyhWk5wK71lQ87sJz1NmdW2M1aNZ/mB6hCjfvmGlZS2ui2r
         BIr0BqSmTPkPvlz+uvuMLmZesOKtP8kslCDUs+jzqeK/XJoOH2qOvJOcxHfkMVxSF+m9
         9dk/yEXzLVawLuhzYmBf8vMd+rG5tqUhZ9yBUqtyXmM3wVCkYcmVKa6BLUrBt2M3wzFn
         4l3dcZaPDnhBP8AhDNHVMxwNzsrbdpVbVdogsmnU3P41iqLezJPKs64nBaSEkUooEQTH
         HhRRevWQjmjqS8SQg6am2gWTMFdRPIHKLy2kR+CNZkua8/tXSbs6wzaPYxTu3OMWerEW
         1JeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgDIhX/B1YHOUbymoNqhABw9yYqmJETlaYfWDiOZJJrUYAktr6SgTADveakBUKf3+jnAW96oiJrkUqFU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWO/ywBR3UfCfc72j1elXsJTaCNDIYgzh/aWPEx3hUC9gopTDR
	TUaxpiRjPWKaXQ/qHxKQltnPZtCMTsj04QLtJNtuERe0S8bVVw0YSecxcD42G99Hw4XOxChU4Mi
	VBW5KiWxeoWWrzqELMluh2dwbvQ6Daeb7V43KT8IEu9F0vmwR7g==
X-Gm-Gg: ASbGncvVW2otyNSIgCju1UkIUBMmbvsLI/y68WlOxgU/5rf8x15xqWM4nHKqg0GRwkQ
	q2uSY89CUDmITGJAkKLluD9ySs1/JwH+KfuWzZ8LpKX4NayXqmjRhbfFoAmbadA9j7Ua1tirYZN
	owFtkeht2ECYgDOJkIr1WpuHyTxIZ/qN3Fo7Ecww==
X-Google-Smtp-Source: AGHT+IHcoh8/QLn7mrObj0kGT04nCNT3y+m/6M10pyXOF/OwjgtcjH1lC6eTC2KVDOD+2C0+ZdF3uSQni3goOcVZ8S4=
X-Received: by 2002:a05:6000:178d:b0:394:7c55:7030 with SMTP id
 ffacd0b85a97d-3997f90e02fmr2478820f8f.30.1742559123170; Fri, 21 Mar 2025
 05:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com>
In-Reply-To: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 21 Mar 2025 13:11:51 +0100
X-Gm-Features: AQ5f1JqeMlZW7mWOFw0Am6uJ3EhRKQScUKs9fqcHcnY5iXEdr9Vcqb8rhgOVseo
Message-ID: <CAH5fLgganhjZjoVipYtMDpVMLYy4-k+L-TRG1zo31OCWvXsZWw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Additional methods for Vec
To: Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 2:53=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This adds various Vec methods. Some of them are needed by Rust Binder,
> and others are needed in other places. Each commit explains where it is
> needed.
>
> I'm not sure what we concluded on the set_len / dec_len changes, so I
> don't depend on that series for now.
>
> This series is based on top of Vec::truncate from
> https://lore.kernel.org/rust-for-linux/20250316111644.154602-1-andrewjbal=
lance@gmail.com/
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Alice Ryhl (5):
>       rust: alloc: add Vec::clear
>       rust: alloc: add Vec::pop
>       rust: alloc: add Vec::push_within_capacity
>       rust: alloc: add Vec::drain_all
>       rust: alloc: add Vec::retain
>
>  rust/kernel/alloc/kvec.rs | 147 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 147 insertions(+)

I went ahead and sent a new version now. It's a bit quicker than I
would normally do, but I wanted to get it out before I go on vacation.

Alice

