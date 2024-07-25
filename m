Return-Path: <linux-kernel+bounces-262499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278B793C7CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557991C21B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AA419DF7A;
	Thu, 25 Jul 2024 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDNNlkmb"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0921381C8;
	Thu, 25 Jul 2024 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721929612; cv=none; b=N4lQIakKGY2dCI3INS/c0m6P0a4eUGKxpWCiifupi/cHvf8o9Kvt9PYsWykHIArRgkdOrfySrCJzyvMgGU/a88aZoxeJVTzSjoQblhcFWeBNWYTBbC4JQbQm9e+rrbwbD6Q7dsV0+OUugFuJH2KGC/C7cAX4XZ7f0XsXXNxc2Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721929612; c=relaxed/simple;
	bh=JVyel6TyoIgSIzZnF0S8FKLtkmddgEdvOUC+QVqFR4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0u+kjcRMN4TiceEdBs2LAXj+RKAWIy5qUof1QNqN9Whe0pNJW9z771GQfnE5MVLMolkjASj7VxHMm4/Q6iU9l0u51JP5H5U2bXrFtpgftTFpcEzOf3C3vx361n2vaaa/bEk7DI16lkxxuCSHP2Lr2VNN6f8UtgRdsvJa0UsirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDNNlkmb; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7669d62b5bfso86627a12.1;
        Thu, 25 Jul 2024 10:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721929610; x=1722534410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVyel6TyoIgSIzZnF0S8FKLtkmddgEdvOUC+QVqFR4E=;
        b=iDNNlkmb2JZzs2LzUTEHEA0aAgqqyKo4Sst1bCNdwCWAU25oICRZFh5bmkHiPnDsvQ
         i8iURMCXm13XdBoThvoGp9Wlj8RQ26GEmYxcioV4sUuj3tEJNmIITEDPtUD5Ea1kt9rc
         YeUga4v4JJCFvR6seTP1mBTEdRCkOjc/BsAsZylnblpWjPveBxp1cMYjA2Z4Qxz/7ZG/
         jUOpN2xxxTFsHCvwghsqLfq3NeYz0d6yPEmq5+8/VaPMRE3VEry1ch5FnTvGZXCtPFVg
         kCHDzT5WccOqUpgzFHXR48qx+BKXgqbhszkbAJKKgWqdQNZKbPdpshgc9KwRGPY9kDhc
         5o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721929610; x=1722534410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVyel6TyoIgSIzZnF0S8FKLtkmddgEdvOUC+QVqFR4E=;
        b=EamdAxXkAKDuKFi7eYIjrGz1/1J8a//ecy/UK98xVwBVyD6avV5omH6FaJMxffyvD9
         x1Rc1NCBKSjHuZVSTRmUHKSWNK3bQPL0F8osVEjWJnm3yeueRFCB1WWTL3WWyTzsIuR0
         Q8Qk3d83q6/NQUA3RG1QYnko2F6Q5Ck0LJwz00iNdtvjA+edrui/Ny7UFPsk9JvrE4oS
         uU38t00vctFXL/sxrpmk/rt/XlPB9okrZlokCWSvQ//2r5bnNlpVbpXqA/jrVrpdRREj
         H0HYGFDUI2AqkndwUAHulMLuj4gC/h66lCZq4aYZC5e59nKvqlLXXFQ9C2JXWcvIHfTy
         9FYw==
X-Forwarded-Encrypted: i=1; AJvYcCWQseEyJ3w4ZOeOC4OR7h3S+KPK9MBx8ymwn4ppgNmjy8ZNsAIvsHAjebq+psVy9Wzxw/Q02fvH0Mb6D7ktM/lbh+V9qgHL/eFHibX49gwCopv1b/jpvxEY86iejlP+VzTjsL5ZvWR0tRXSiDc=
X-Gm-Message-State: AOJu0YwCDz24Tq8jU2GTnxVAnaLTNZwhRT9UBLJjhUoJuwJP8cNL+XGj
	NC/FB3SJEuO7CyMmNBeCRrRLvaTTqxwoIg1siqsOKLyFG19F5BUo8LuBJ3ODK+K35DjLvLzS7Vm
	2JMhDijcahAEj47S03GJtMuQZWXc=
X-Google-Smtp-Source: AGHT+IF/zsC4mt8anDKAXtlX5iOlGNHy+uUW7r23kwswz+uALnsBpL3D30exas+OKtu+RrmYR1kD4OJidTO6Lz8BwO8=
X-Received: by 2002:a17:90a:c58f:b0:2c9:77d8:bb60 with SMTP id
 98e67ed59e1d1-2cf23df82famr4118133a91.35.1721929610169; Thu, 25 Jul 2024
 10:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724204649.7de3ffed.gary@garyguo.net> <20240725174449.102724-1-ojeda@kernel.org>
In-Reply-To: <20240725174449.102724-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 25 Jul 2024 19:46:38 +0200
Message-ID: <CANiq72=9CWHgzTdUMePNVGpNpHuk8TN8i+bhq7cyBe1_iWLBPA@mail.gmail.com>
Subject: Re: Re: [PATCH v2 1/6] rust: module: add static pointer to `{init,cleanup}_module()`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: gary@garyguo.net, a.hindborg@samsung.com, alex.gaynor@gmail.com, 
	aliceryhl@google.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, jpoimboe@kernel.org, linux-kernel@vger.kernel.org, 
	masahiroy@kernel.org, mingo@redhat.com, nathan@kernel.org, nicolas@fjasle.eu, 
	patches@lists.linux.dev, peterz@infradead.org, rust-for-linux@vger.kernel.org, 
	tglx@linutronix.de, wedsonaf@gmail.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 7:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Boot-tested under QEMU for Rust:

Sorry, please ignore this message. I run a script of mine badly... :)

Cheers,
Miguel

