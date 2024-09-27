Return-Path: <linux-kernel+bounces-342005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82060988985
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3051C210D1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3F11C1749;
	Fri, 27 Sep 2024 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSPeB3bi"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747CF13C914;
	Fri, 27 Sep 2024 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456891; cv=none; b=PMQLYtbHx6Tb17D1zeKNXVDJfmZB6OvyU1JV7PYioqr6l1jzAcsY/L+a2XrPiZHsKGrlGG1U9oFHg64Y9qr9h/12J1pahmz5UODQTq5A6MGukTfovKr9QisFJPyrKZ0FQ4VKOXICimd+EFycagUBjr4uCAZ0TIf6f+2EfThHZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456891; c=relaxed/simple;
	bh=gHzlo4cOS28cjIM/reymBy1+bVdXWtgnUI4/EktNPJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joZ5POMT2xcAenYLYhZmoP7oDh52FzK3AGjU1C/f+TXalC1AvMkyP2KTOJrNcHL9DAm/L3ZHw2Q0KQHXZX+lMp4WadNxUfK0HLo/lOWj+JPAxWFo0clUQVu8C+SyJq7VKTNdZIQdJ2D8/+OSXgcZScumIwQ15rozAocRBoZnrw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSPeB3bi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b09a83466so2998505ad.3;
        Fri, 27 Sep 2024 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727456890; x=1728061690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHzlo4cOS28cjIM/reymBy1+bVdXWtgnUI4/EktNPJA=;
        b=fSPeB3biWONzVPjgoBFK6KLjiUX6iw4lcjlSFyhs92WPWaJkOwGYNVD7Y0FKj0k0oP
         tqGrcjcpLl2HTVBh0gMx9bwuYGVIm0FD6Ozhn6NBV8KGpIBKjf/lACFTN6xKKZw/V+3T
         XNjyvzm8EK4ojuMhWyVrrJFOBa1ksp+7a5H514rjMdZALdOOXyxMq0ahFlkAhyoUrkl6
         3FDaRJOmI1Qg/Mw5aB4yerQ6XuY8TJgPUzVA7kv+ShdrRbWbRQEk7JEf6QkrTmdeDnSb
         h/ndY/ZLYmH//wvO/uL95WjG63yZCppj4jscF2kJpUQxD2/n2AaDnE9BllTlHr9coX3w
         2eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727456890; x=1728061690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHzlo4cOS28cjIM/reymBy1+bVdXWtgnUI4/EktNPJA=;
        b=K0miqrCAVR9EOs9gprLjYMYZoYWcLfFTgyjjfiRoxFwxGi+P7puhrKO7/CV16Uwmj7
         nJ+L6b/LBwEYWwEHHK5Q2snPyngMCi78hSFQN59SWntr6hgPlVZeAJ1rSfdYr1c9M7LC
         s+oQB4d8uQ02gbzN5diWT3+f8pJZ0fcVC/cho5FAcSUGhBsskwLEzMLwLKiJu7adDYwv
         4bAJzjUu6TmL7yvOn0IKJ6MZaml7JYHXo6zxwz2kyXBTcITMleTP1uXgHQWz+33g4bDu
         7n3vtUMIhgpvzd+BFGFvX3JeOeSl8zUVL65f696CO8nsGN5mRSoYDi7QCcXGkiosujYU
         vcoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFllsH6QLojtPRqJFK8SNVKhV7Sist1YCjc7Dhq5I8ltuCvFMF2UD7FHJMzC7ZVX9RvU26GjNaa2JrHys=@vger.kernel.org, AJvYcCXN8gkyUqk7oclZ0mlqyVrbeX8zy2bnU+K2is3mUprT1EUQ6syRHFg81YDGg1ir26OITy7lj3NKnlWRoqT1jyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0y+0c/nPRzslwqTlTjTOGNWJgdA/wKBOgLb+QlPRfTcw0VOBu
	HIOvvViADCf82dfwcAJMMWBrWQkHD8ZmOf0kS0U6YmZI/JQaDU29SIqkt1xjCHIEMrP5mMkxQjG
	h6fvGhOCSpej5eEkPGtk33En63oI=
X-Google-Smtp-Source: AGHT+IE76Yj2hnfFIu8kAGW66X93Xu9YW4uSsE7JdNgXmMsRkX5C3b0gcgeZlmhZc91bxmg1tmB5fMbsrwV0gFj2Bfo=
X-Received: by 2002:a17:90a:a78a:b0:2e0:876c:8cbe with SMTP id
 98e67ed59e1d1-2e0b8ee52a2mr1924596a91.7.1727456889778; Fri, 27 Sep 2024
 10:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927164414.560906-1-ojeda@kernel.org> <d8d610d0-5cea-40de-868e-8c80954daa27@proton.me>
In-Reply-To: <d8d610d0-5cea-40de-868e-8c80954daa27@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Sep 2024 19:07:56 +0200
Message-ID: <CANiq72kMEyGWFf0gh+oi0TdnSq8fTcDS-PTsA4j7X_s4=wz3pQ@mail.gmail.com>
Subject: Re: [PATCH] rust: kunit: use C-string literals to clean warning
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 7:06=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> I thought our minimal version is 1.78.0, or am I misunderstanding the
> wording here (I interpret higher as "1.77 > min-version").

Yeah, sorry, I meant that our minimum is higher and thus we can use
the feature in mainline, but not in LTSs -- rewording artifact :)

Cheers,
Miguel

