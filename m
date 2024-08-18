Return-Path: <linux-kernel+bounces-291240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 141A6955F8A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 23:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F40B20F73
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 21:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C524D15624C;
	Sun, 18 Aug 2024 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbN6ffNH"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4261552EB;
	Sun, 18 Aug 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724018168; cv=none; b=qhS8J+GR/0PIwIquegU9dbX0HAmoDsoD7yi4fhZDwUFDVDNYtWB+33M/OMEmpl5xyd9JohDSbB0gQa8pSzhKxbguYsNbsKCfJqMpJzPP7FJMD7OwSCkOHoUsHknsrs+lSVoB0Xd7PX6ugKg3bJCs5+uYMWO9vMJR+6v9rgO9nvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724018168; c=relaxed/simple;
	bh=7XQrBstONpqqg5tBlz3FmFfN5Ko3xGJY1McB5aTD4Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXTRlxulu8CJjsQzABprWLZ70+pDtstuDyEazLSzGX8vYnAT1J1ml5PIdNjMKzr+TBJFItB4eQJ+GLOVs1F30a4DwUjmYYL6tU4cmWFeYV3dhapuihG1vnHcU//zdryDN5nsO4fkKvM6587Bi6jIwl+wTmPimAxMcto7KNpOiv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbN6ffNH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3d58d6e08so2407893a91.3;
        Sun, 18 Aug 2024 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724018166; x=1724622966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XQrBstONpqqg5tBlz3FmFfN5Ko3xGJY1McB5aTD4Yo=;
        b=gbN6ffNHAW1zWyu0UgTzvPmhry/Zfq7jW0FVC7sghs98NQ8qcOLmZpSU6AE9h1O0Hu
         V5sdbh0awlE0VyMqMuaAjAJselFdCrEAx8f+kPUOJyRQkqHpgl9h1lMp0r19KV1K1Yeh
         T+VBbGJPRflifFqs+CPrEXgsxO9si/vZmMoctVbYwDG+R2bh7UT7HNTdChyqKX1Trse3
         MEXsXHGMT0czfls5fhXGAEPbku3fMU5Hi+qO/1nTJPBocy9bEl7FvCjv4oJmly7xN1Z2
         rFOQauVz/e9CI8cWYELA9z5sd9H7tM7XuoOrIbur/n4DDCi/AY3G9BTThNqaZOG2IlDO
         j1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724018166; x=1724622966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XQrBstONpqqg5tBlz3FmFfN5Ko3xGJY1McB5aTD4Yo=;
        b=H2jOIos3c3nWwfwRmO5kBbepqNq9pmt59amZ5u2wybiaBSJQdwadNNjSGAz7Gy7qYD
         +KGdiVkyaTS+M/nDwIfOc3xSo9mZ8Vm+wsawt26IIB/fUzsOSwBShz8BhNT9HPjRO5mt
         IrNhYogUFAK6yA4qvq+LJUUcaCqXBq/kEMmz6LFdmGbqlPUBP/KyGEoAO2lVRr1WfcUE
         4nweRd76v23+XCiyxR83fDTIzxANV/bjE1c+k0ojoHHgFl9e0OapxvCLpjxLqL+ND7Cl
         ax0kjj8/raMhHgcTdFSLNPIeSZxHle3GWaLReFADH/XKguCAvVZTMT3wtg1uJgdZ9D/Y
         Ww1A==
X-Forwarded-Encrypted: i=1; AJvYcCUrgrn8poxrcoUGpmmx5ngtoAkOsS/y840j++xcbBcw27LhHluoiyQqo4nHEBmGgXeV1Z1g8TOUXno=@vger.kernel.org, AJvYcCWzAWz6Z674brp9mjPpzUjal4JZvZmbQG0EW4lQUOYVMCRlyRT3wshqfULAjvPJQ9mUi3jnPQ1EVanuliL/j9U=@vger.kernel.org, AJvYcCXbGg2oukrGh/efHWQylwZSTuNNxXzDWyCPYBhk8mAT1xdVx5ZJHhfM0ifKGfjR0T3AxsOMPQDm3HZw9pjp@vger.kernel.org
X-Gm-Message-State: AOJu0YzFhk9BPvc99J7Yx8IbP8hSOT+UpDpnqhQbdVunq3KlgiEvt4eI
	OgmWUxMrMjGJPivWWGFohuGMN65cJ0+Wuj+TcQ1iNQtiezF8yaBvQratnZHhXMIhL2g2qdPRzAk
	1FPykI6wS+aCFU6UmJP551i58R/o=
X-Google-Smtp-Source: AGHT+IEZ4gT6nABs/K41mitZD0wdXrUuQ4YqCSCqh1GuMK83jxlywWLfsBWcImdS1SuTQf9stCTv0wBYynhUq+X4s0Q=
X-Received: by 2002:a17:90a:1f81:b0:2c9:80cd:86b4 with SMTP id
 98e67ed59e1d1-2d3dffc0f90mr9173142a91.11.1724018166043; Sun, 18 Aug 2024
 14:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818141249.387166-1-ojeda@kernel.org> <20240818191938.20ee1766.gary@garyguo.net>
In-Reply-To: <20240818191938.20ee1766.gary@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Aug 2024 23:55:53 +0200
Message-ID: <CANiq72mF4=o82Ju7y8wrq+5fCVbungWf2iry2S=1McQ03DJOSQ@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: enable rustdoc's `--generate-link-to-definition`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	Guillaume Gomez <guillaume1.gomez@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 8:19=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Thanks for doing this! When I visited rust.docs.kernel.org yesterday I
> noticed that the definition links already existed, and it was very
> useful.
>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Thanks Gary, I appreciate that. Yeah, you caught me, I enabled it a
week or two ago. I am very glad you already found it useful :)

Cheers,
Miguel

