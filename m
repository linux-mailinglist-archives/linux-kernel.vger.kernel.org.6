Return-Path: <linux-kernel+bounces-438436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEDE9EA14D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A15A1639DC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CFE19DF44;
	Mon,  9 Dec 2024 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITsnDwfP"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EF119D891;
	Mon,  9 Dec 2024 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733780218; cv=none; b=Xcyo5wVsw9UQXwgcJgL4tVy7uebtQ5FJsw4dGeJxvySlLGkXZUt5btRxNzbOpSg5elODq54YUoIfcnSpQHbSTVbWi8lCc2efMjeMpxVrfxGjhzIoI7NkkH8X/1CtFuN7ixUkqjyMbPcgL2RplIysTtw5bw14PT1dGIZNeAc1eB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733780218; c=relaxed/simple;
	bh=8n0fC9ZE6D0p6rJZEmckvduO6PYD8RKMnW4ut7hQX4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqXDycSBaoXqa1CnAen6MV25R9EOmRsodEr9m2vCgh/ax1I52C/cNOwRN/2CXFdChLxzbDdB+inHK7IfDTeT4jkbrMRDuwb8KAH8HUBBB76gpsqyT2UNOVT6AV7PbZjdAyp7e6IDguMaC4pF6QA4X2h2wONokPwKiiZPwF/NaKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITsnDwfP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef718cb473so567855a91.1;
        Mon, 09 Dec 2024 13:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733780216; x=1734385016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8n0fC9ZE6D0p6rJZEmckvduO6PYD8RKMnW4ut7hQX4I=;
        b=ITsnDwfP0aUf0IjDj9AB5cb4F6AFGvZvoG4t0cbeP+kUNsteUsLm6gvyoIEryppXR8
         wMWt/juDjJ1vp24QDnMIW1L7uwaYwXyFUhW5deTsIfaTQZ0EOhVn+yo+bSBnlIlX0G7v
         Zyu/KK0vAot49KD4nE0EsbAXB1n7XOl469n76sc0e1n2JOlP0slv986Jb0otX1GXtlcU
         Xn0B5xAbTbXa32rWoCELvxBA1CtRJXTjyaid07uzqMw8sSVuZJgVRShxuEaf4MfqUD/F
         sN2Xt5Ub9YvqLVdRDf8HMWbSsS5AU0wAZ2fygFcDOhrWrC+GKUAzmCE9VviYGJz/PNvX
         35wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733780216; x=1734385016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8n0fC9ZE6D0p6rJZEmckvduO6PYD8RKMnW4ut7hQX4I=;
        b=kFypvrKg7kbkc12la7EOqjGcKqohggroT4eNNb+mQ/EOS5wK7OcKBlwMaPUwyk2CuI
         NlKE6nyc74aZnR5OPPIqcSCuB88NvUP1iYPgV4MnhQlRo7ipkgCqKMKB5PCQCD1cIe4B
         +cA2GuP+9A/OzOBPvNondR+stFee/GHTUy/J1qXr5/ajkq6bRY6d8cO7CMj6Np9pLs/T
         f60iqUmmfaA1blz0FnsUypuSDj7XyZlGv8sS2OqprQ6WTgtm4Z9Yn2SdjlFkdH1H8ppY
         KFDKbG6+Ve/qP1nn5TP+YqGZpbnfEFu1T9V0MI9Yd7hjSMF8QmOS9K3dobR+INvUMIVK
         T9cQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6QjdZ9/7JbGGdt59pQVZLeYiayJvkLQup4qvMwVhQp1kkj0/46YuUbmaHVXi0yk92B66t6zdO8GLSK9o=@vger.kernel.org, AJvYcCX1e1Xa0MolEtwRTdIVl6P1XL6qQz3YS6EEitkgvkDuIFV6LMBmAknOc5TAA45GB8roklCEAS69cPfJCbdsCjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXIk8fBGGegSebnYX6/w2DgPEtTgpuQAZr2ZQSnFWDqDqzal4E
	Vu4J/PO48sx4tdM5WWBjUKWKRSeRFzzUSvzk2djX/JKwCngJrK5T1wBLwut6xRw2twUb0QSvAj/
	oPsQt+h2h/NDC4pHJM0rriHo/PxQ=
X-Gm-Gg: ASbGnctzVazly3xqmAxTAHp1jvfboSWHiM5FwlFueQVlVua0MQvGCMqHkv58XsqLJ/l
	FYHPHs6huwFJU/FwesCmHSLrPrjvpYahv16M=
X-Google-Smtp-Source: AGHT+IHC19751IBjjmIqdepj0XOBKOO7FVShTTRs03NQ0pwL7CWDoFU/7ogQLa7yG2AqehvsmnjEFsUO+OKGkdnNkIc=
X-Received: by 2002:a17:90b:17c2:b0:2ee:a558:b6bf with SMTP id
 98e67ed59e1d1-2ef6ab3ac63mr8000241a91.8.1733780216416; Mon, 09 Dec 2024
 13:36:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
 <20241017-hrtimer-v3-v6-12-rc2-v3-4-59a75cbb44da@kernel.org>
 <25I5c2B_KkmqpaLqb6jsZyMd9WMhQbTaIKyUYY5cKa8bvR7--HvRiXJ_5cDiyde31tnivT5_C_5IJ6XvLqCusA==@protonmail.internalid>
 <73814ac7e363af44ae6e410f101feb75e94244ef.camel@redhat.com>
 <874j423p7r.fsf@kernel.org> <xSW32IhgoSjRIqCoAHtm1UkO4trcAg7QE1-2cite-wE1dNgIJLtZwnRjMGlSP63MaqOqUjXdmiMcOWhedRz4Yg==@protonmail.internalid>
 <CANiq72mkBufEV43HcZZVKB=1UDxOrpweFxeZJBXt6U0=vPMsdg@mail.gmail.com> <87wmgfefak.fsf@kernel.org>
In-Reply-To: <87wmgfefak.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Dec 2024 22:36:44 +0100
Message-ID: <CANiq72nkArkecv9x3JGdG6YBPqjf3FDm-xYvhMKcxC5hM3okqw@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] rust: hrtimer: implement `TimerPointer` for `Arc`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 2:41=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> What is the rationale behind this bias? Perhaps we should do a pros/cons
> list before settling on a style.
>
> It is arguably easier to merge and rebase when using the `Item` policy.

Not sure what you mean by bias -- I was referring to what we have done so f=
ar.

But, yeah, it would be nice to weigh the options and decide.

Cheers,
Miguel

