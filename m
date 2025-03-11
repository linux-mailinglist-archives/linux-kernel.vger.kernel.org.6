Return-Path: <linux-kernel+bounces-557061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6296A5D31B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7B53B632B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE6E233120;
	Tue, 11 Mar 2025 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZU6i2AH"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB914F117;
	Tue, 11 Mar 2025 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735343; cv=none; b=gSzVqtVp8NdS2fi2tuI46RsYFlAmVORDN4zrS8aYUHIep0h1aaF/WMJK4mX1dWQkkAAUh4pBpFBxABFSVTTmULlmW5or5fJjDw1zsxA7xRVv1EM+G+QkrnidB5Whlfao+aG+9jkQlrleHwxigjqFGmYCOkL0yHhVn8Lmg+mZfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735343; c=relaxed/simple;
	bh=HXFnf7bmBLbcn8ullnazkUMmzk5SS8XU4aP6CidkRNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZFlx7rNLbTcnWn1E9KdJ396WkhBDbfSGhsdoJY/BemTfoQjCxhdNdcR9Lowe9ng2/4a3K6qAc52L566yJZIPikhE+0JJrAjX8E1jDauDSvxuNrOTZeOiHWnAYmXZ4nbQEo7kgFah9MdQd2FCjUfzdMPk47MHvZzvIqNXp2kfE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZU6i2AH; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff7255b8c6so1474845a91.0;
        Tue, 11 Mar 2025 16:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741735341; x=1742340141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK4GlJdh+J9aCWcHS5ZpFf2f6Q7LK8qrgkriJTAG2I0=;
        b=iZU6i2AHNB3L+L1lodBBSLVE1yFET2xSKKTJp2374Jc3mx8wr7nz5IG/KX8oJmbkGp
         oWVTIjtBCXN9j8sYdza8jT9krMZPgZVmn7EIp7NGl05Il1saeF+A4+Y98aUjn1z/Kq4E
         UWyYL5jzpoB3J6D8ZPAdGU2W/Hoaz6SR8CVL/vUjvsXH9iCsMlJDfQms96Mioh+A8XSp
         /TIft5EawkjjQc99vxWinhda+1Ws5dSRhRBUqgmjCcj4q7axJytrI1aXehcKDAgIo2We
         bxBtVfHrQXq8wrCbpQsouM8LeEQYAV1TT3bpZQKUp9wTheWEdXu5bBdHlHRFAZozcAP5
         RGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741735341; x=1742340141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VK4GlJdh+J9aCWcHS5ZpFf2f6Q7LK8qrgkriJTAG2I0=;
        b=ma2pXZtlWg+PRacFaC5kc4lB2MnQ6DcQ61uyi2e8gOqhrYfpcIHN0U6Cq1StDYBOKU
         n/jTRc+EEHxWyAFSYATtyO6DqpCK4cJg1BaYuSV0UYDGoNtmXu5ckegR21W9Qs0ewQcD
         +CfRheAKrVpO0RF7RpyCTqCQRBJSolBmVX6MVLPLnX27Wj6oFFNSjNTwMXLH4rmskNii
         Z2OlB0IJt8MWlnKeTH371vTw6/R0VCslqs9QPWjM7qC1DoitM8PBoCCUcY8et15LQkKF
         GSpgr+/ImOAaRaSI1t2B/jCFLy34/HnAg4JeFvIXo5j8kkVvt4omrukgNA/4xzgUVwop
         NDCg==
X-Forwarded-Encrypted: i=1; AJvYcCVAUKfXwSBaTr5nRbFmj99/nNjlHKmSSTDpeETonq+1HorgzuOGysZwhg3Rthw22qZVLr7WSrSRN9eRYcU=@vger.kernel.org, AJvYcCXaYus3KzAEdIbmkV+J7bGOuaTq/iWLwdbXcwAb8hSRon0Y9vY0sEqbilN30R/1LmrZbXs9bf/7S3nwlamIe+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwUaIg1u1vGcogJ8AaETrITgbwluuWiqHfns7NxPSkDq7K3LLq
	Orx9KcQEcnNum9kmUlMuy9h5ShtMiMOIwgbyKqWn1O6sR9Lf4e+4xhMcAE9vuzWzE3Kf1Vj2wk3
	fEgKdQm0YSU3Fp4Iab9KG1I7t1RE=
X-Gm-Gg: ASbGncvsFLhCkHYXLhesmgwrYOv5YzTC5OMnLHbPMe6gBam+bazexIkMMDxji+MPFX0
	Yg8S4zXEew+qV+YONTHwf6lD31qcoh5Xs2JfbyKFFkJXuhGFYxz71SBcNtjsU2C8MmmADlq90f5
	2lCpI2tiR9nw5NmHruLYei9uvnEw==
X-Google-Smtp-Source: AGHT+IEw+WMj/2R9/sdhL843Lbkfd/JrxP2/iRr0RSbilBBscResxaGBttqjawNdQBzYVdwcxD/vzMWiKopuLhJWwzw=
X-Received: by 2002:a17:90b:4c51:b0:2ff:5540:bb48 with SMTP id
 98e67ed59e1d1-300ff94c15dmr2595731a91.8.1741735339381; Tue, 11 Mar 2025
 16:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-rust-analyzer-bindings-include-v2-0-23dff845edc3@gmail.com>
In-Reply-To: <20250210-rust-analyzer-bindings-include-v2-0-23dff845edc3@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Mar 2025 00:22:06 +0100
X-Gm-Features: AQ5f1JrEpZcBAlx5PVa5ggQ0S_uR0lXug9Q0B1t6fYkOP8SVcHeP4VkwQj3eZUg
Message-ID: <CANiq72nv7nQ+1BinCHe2qsvwdUb-y9t7x=RGSppi_n9TBXNHpw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: fix rust-analyzer configuration for
 generated files
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, 
	Fiona Behrens <me@kloenk.dev>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, 
	Boris-Chengbiao Zhou <bobo1239@web.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 7:04=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> The individual patches should be descriptive on their own. They are
> included in a single series because the second patch uses a function
> introduced in the first.
>
> I've confirmed this allows me to navigate to symbols defined in
> generated files as well as to the generated files themselves. I am using
> an out-of-source build.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to `rust-fixes` -- thanks everyone!

      [ Originally we were not using `OBJTREE` in the `kernel` crate, but
        we did pass the variable anyway, so conceptually it could have been
        there since then.

        Regarding `include_dirs`, it started in `kernel` before being in
        mainline because we included the bindings directly there (i.e.
        there was no `bindings` crate). However, when that crate got
        created, we moved the `OBJTREE` there but not the `include_dirs`.
        Nowadays, though, we happen to need the `include_dirs` also in
        the `kernel` crate for `generated_arch_static_branch_asm.rs` which
        was not there back then -- Tamir confirms it is indeed required
        for that reason. - Miguel ]

    [ Slightly reworded title. - Miguel ]

    [ Slightly reworded title. - Miguel ]

Cheers,
Miguel

