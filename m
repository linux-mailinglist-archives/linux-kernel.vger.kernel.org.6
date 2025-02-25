Return-Path: <linux-kernel+bounces-532027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 679B6A447BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937DC42127F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0921DDC2C;
	Tue, 25 Feb 2025 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0mOhkKe"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD791DC9B1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503570; cv=none; b=MuTzZMvGKFygWkL98CO/oHclvABDgKCQMsD+ckUR4155EhFnRnhGlE4dyhTuUeHXwGrmlLYGqTRxeeEGjWpIPvszuI+0ez06/Diq04/dMAibO6Zn0J463yob/Q6GsJSV/+jpCGeh0yIqwhdNgImbmQetvZEmxvDgM2HbfugrXlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503570; c=relaxed/simple;
	bh=ednjTSjvw9Gt99tA22MMvDogCLInNdUvhE7Mq9C+1L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxS76n0XgV90XoswX2EBp/I9tAJqgv30HilqgR4JNBK+rqlhfU7KQs4N3y5L1451ymBWzxM0KO9gTaPrCyk4/yDUMXNJdyQteA14Wr+CAaRxkJTIKpwS1sQtISC0YktG8KOg9vjhGyz1MCbuOfzoPYOVfmtw4nxNoVzp9hLKd28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r0mOhkKe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso59636035e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740503567; x=1741108367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ednjTSjvw9Gt99tA22MMvDogCLInNdUvhE7Mq9C+1L4=;
        b=r0mOhkKe52C5HSBcSuZib+01ooiaaXSa8OeULguCFDcuOUlBBec4b4bsNwAmhh7LhX
         pImjvjtHsEUr+NIL8ekHZHzIFmnjHK7RAP19zt65Gv905ZFC+9z9s9spGvti+jwlE3h6
         sWtl3AF094JttZd8Zlnu+E9OCTdv0UwdxE1c/m0OAjMZA1RRsuDzhzashXa5RY1NWdeX
         P7+o3ugmbKIKha43Qmw3KLGS+YUrTKYzt77gJ1Jx0kP0viM0FFo0ev5IwQhlSWY1JOsY
         ucO9JdJ5flqRygi0xl9nsd72kjwjkUWErL6K8unClBs+33NWuBD03oVhjdN0wN6qfC2T
         FHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503567; x=1741108367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ednjTSjvw9Gt99tA22MMvDogCLInNdUvhE7Mq9C+1L4=;
        b=LcqHvdfQLgWgR5xFWuB2bXwt5MJNvdpNc9nbzTGwC+GUpNRm3FKGbTi4DWqib7dkLS
         WpGpWY7puMRr35yBa4qGtTL3XD1rXQmuQPs6gnzGpX6MRbWLear4ExIWAN3pgC3F0HFe
         0OShGHqWwPCzB3Xukw3jJiSd9y2Z4iTPuPf6AOQJZk5oQzOolJnZu1j/NJ4qnpx3Yl3H
         Hon3ESU2rvxq8KkLTgYZPSP4pdhkhUQb6xNf7IejL99xMquEiF8463ni+wTzoWXWuQep
         eeI2mmeKwGfsKb1lH0Cfpde21SSEnPQBoVXubVGcW9aFfQb9N/Ko279Qd9tQ3BiUW9a+
         YffQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk//IiOU0AO8iwikZp0bbg0CHIcZYHWh11Hvqm79iEM5t9nSF2EH+gFFWQ5Kn/HV7pP4Ynty+NDoBUQ8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmvQX6Rxqv9bfr0o/NgA0amnhv1HofKWo2EQk1kxVUIi8FJkKK
	N8nsYiBPI/D6eD8kun5BxCJ9qCeMBRTg8h/hkBxB5gsNseNNlpb93pqpx+xRX3DO096r6qJYCpb
	fbHVNGd2E8upAdc2eECsJhDorQ3Ak9uwye3T4
X-Gm-Gg: ASbGnctUU8mjh0oEnpXXHM9HqAw2f88qjgNuU/gOQ89yNtcbGBwAQ5Z5g9uiyq+6i4I
	BEFoqPa4Y96xe+81NN6Uhh/IjG/yDGLYlDE0QT9U4ygANT+Mn4Ak3L+9trrNiELaP/s7J2vX8vG
	qd8RD4aF8HZbEGeynrUfk8uNQek4H3eHUJMY6YXw==
X-Google-Smtp-Source: AGHT+IENL3tkr5YY1W1LPao/+fxPS1FpvFsCT1UPYovJTPV5D1zitQeIdtwEVZnuTIAS+IO71JyVmXj+d+y+IFJL6GI=
X-Received: by 2002:a5d:6c6e:0:b0:38d:dce1:f207 with SMTP id
 ffacd0b85a97d-390cc631a3emr4656547f8f.44.1740503567098; Tue, 25 Feb 2025
 09:12:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740475625.git.viresh.kumar@linaro.org> <68ac0f0ee3c0ebd3d3cc078a6270752778a1b732.1740475625.git.viresh.kumar@linaro.org>
 <CAH5fLgg7o7hs5B4mMzPd6RzYm+RcX8gw1Aw8voJqnmfnA_aM4Q@mail.gmail.com>
 <20250225114830.64p56bndn4hkkkgq@vireshk-i7> <CAH5fLghUDz8tpkTuvWZgwT2_VKgxuS+iZKnoT4prKwS9tbp8wA@mail.gmail.com>
 <CAKohpo=uiCS6nyissb3ugiyniwnZYu5kCf4+bp32dDzRhgGfCQ@mail.gmail.com>
In-Reply-To: <CAKohpo=uiCS6nyissb3ugiyniwnZYu5kCf4+bp32dDzRhgGfCQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 25 Feb 2025 18:12:35 +0100
X-Gm-Features: AQ5f1JrsvkSYfxf47nMcctFkIDr7cuUGNXZJBCZDafLE5kFdCo2jxMcIoSYI5eI
Message-ID: <CAH5fLggyEXyyaFNnmBCPOSX051TiFyAp0B8GfahbPg=+LrtUWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Add initial cpumask abstractions
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@redhat.com>, rust-for-linux@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 6:02=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On Tue, 25 Feb 2025 at 17:23, Alice Ryhl <aliceryhl@google.com> wrote:
>
> > Is it a problem if a value of type struct cpumask is moved? It looks
> > like it is just an array of longs?
>
> With the current code, if I replace the Box with an on-stack variable,
> the kernel crashes.
>
> In my usecase, the pointer to the cpumask array is sent to the OPP
> core, which may update the content, though it doesn't save the pointer.
>
> But for another usecase, the C code may end up saving the pointer.

I don't think that case applies here. Variables that could be stashed
like that need a destructor that removes the pointer from the relevant
C structures. This is because pinning only prevents the owner from
moving the variable - it doesn't prevent the owner from destroying it.

Alice

