Return-Path: <linux-kernel+bounces-401667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 564E39C1DB2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F9A1C2123E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDDD1EABBB;
	Fri,  8 Nov 2024 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ens9IaMI"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15D1E0B66;
	Fri,  8 Nov 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071634; cv=none; b=sRsaLJ9mPcAxksuydU8wougPH/UfI8SFPxW8p7uAJJDRt6n6U0nNF8JNWr3gZm/Q3DYxS0F2PgAdt5OAMkQx4lXS/rA4Es1MhTZUhUo/X6p8LgJexFgWh+iUdSBOzHsDgCUS8OgMx1B6SJPVGdMJMPeTqTtqS7uS7lzkYsZiub0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071634; c=relaxed/simple;
	bh=N5pWQxlHcc2dwHiRSIg+NN/d2DilzRLSZISJB0UfURM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KguGS1qj7KSZ6y/x1tKEHvEfAbJCGdTI+iviZ0ciHOcwG3m89Epx7ngGc91HHD9cSN6UFD00XCVeTLk5lLPxfM8LpRtWLE9kXQvqNufBMw8RgoNAy6ZbR1zRLAgr5cMureFxSjlmWYN1Lj2L7e76WmEUyYBS+7s8LzF7apb+BzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ens9IaMI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e31977c653so291656a91.0;
        Fri, 08 Nov 2024 05:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731071632; x=1731676432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/x8B2/vBEewsh7Nqwh1OUibNre29okGAiUfwZlgjiE=;
        b=ens9IaMIKEnKw7OWGZ/jNcw2gGKZvbw9NVhUJnJMf2xiE35lGLGWmY5tRuB+YCLjFH
         fBYkLdiTSrCGPwuEBF0tOcMy5JAZPUbbKm8PIUU0Z+8QGxsKnZaWD0FEefzhTo5HtMzt
         i5mbGxrWumyZFi15yjtUGR+Pc7p2xkYO1HRaL5wCGKLO4cO+75GrFrGJeKH6w87tMGbj
         KBswO2OpAg4wJzFEYL0X0VxJEKgVLYE5LtrA6uzmNUgl6B5mdLnAjPMFKGvDWBYXaAMo
         S+vkQ32WaB3YoMl/tQST7hgqhX2VvBxhm0tsejy0/Ilw7uB5u+3Kr+ApG0MFbW5RmoeU
         jaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731071632; x=1731676432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/x8B2/vBEewsh7Nqwh1OUibNre29okGAiUfwZlgjiE=;
        b=jFFtXBBrMKS70OyJzPUeigKvlhDgqoRFxrZoyuEtS5/xucluZ6azrG99raG1RSqr6v
         BomfVpIn5un+MgtPXCMMpHVP22Z0zTmMDO7Zv2dzub+VBwa7Gaf46QhVOJ/sxpSGGhqy
         wtaXHlHIGM65eRrqDJfJV2vZ/2gYzGrGEgtCb/leG5X9hy0o3d9pucAeJOfri7I9D+RL
         sqqqAPBNXLBehy5FQndWpV5zOOErZLGGmdf5Fy/qd76apoBFgFwPQz0/3DxIkrHl5Iwb
         Brl+CdsolDlkx1cBmgGWbvgYY5Wi80FP46zlrEKnB5XyjzYKrfsaejRCCiLmKonJsCcm
         pGSg==
X-Forwarded-Encrypted: i=1; AJvYcCUAatViG4SMEV4XhZI8E8bvZMIiwc46WDR02iyv0itY9n4p5xir32XKqsK8bkocyZ9BVDtracyY2zd1D4C6FTc=@vger.kernel.org, AJvYcCV7Ly7PC3TLQxOAXjDqK07ibGSi588yMbX9rJH7ZRyBRK5EsC0p+XsXFWx2qhKQ/NA2X5oGXB3cWiUGWYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbA4SLhDW56ywmT1ctHWHlHKZ1XPHwZdcu4iPvZ0HX75IQlUNP
	DLmybA3dRGKVKLtbIN8HU2UFghIsl+uo1f8/LGPif9BdyDsf+6tczw2a/MMzN49WCylNHhOnLry
	91s/UqrciZR9JY57S1gHs6ymS4HE=
X-Google-Smtp-Source: AGHT+IHRlvte0vtT16pL+15CXpPExfa2kAy86QQ2//oC9ZrAYaM1A7uMRJ7G4MLiIh1T9l2d82Ofuf189toe72h6cb4=
X-Received: by 2002:a17:90b:164a:b0:2e2:abab:c456 with SMTP id
 98e67ed59e1d1-2e9b14bd4admr1743702a91.1.1731071632521; Fri, 08 Nov 2024
 05:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com> <20241104-borrow-mut-v2-2-de650678648d@gmail.com>
In-Reply-To: <20241104-borrow-mut-v2-2-de650678648d@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 8 Nov 2024 14:13:40 +0100
Message-ID: <CANiq72mT4FfDXDX-tdWo3owLdrsg3KBDrQC_1whA7-ZhVH4H+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] rust: types: avoid `as` casts
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:20=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> -    /// let ptr =3D NonNull::<Empty>::new(&mut data as *mut _).unwrap();
> +    /// let ptr =3D NonNull::<Empty>::new(&mut data).unwrap();

Nit: this one does not change it to `cast_*()`.

Cheers,
Miguel

