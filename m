Return-Path: <linux-kernel+bounces-316573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40BE96D168
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933E8285BF4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560C7194C61;
	Thu,  5 Sep 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQsiOz0j"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24049194AF4
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523667; cv=none; b=slL/vlRrRrYnc32+42pRCmKuYZ8KhNvlJr1vdawJSrFCuyyPxsHAxFrvuCzg0Gp2CJA5iVINlBbms+UoJ3aCoL/44xLec0yk+vK3VCYff/gvoB7JFx64PVuDVJVWc2MYBrmJ9cPH2wO1a/fpaM3GuMxcfXoHtdLS8K/R52N8AHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523667; c=relaxed/simple;
	bh=HZnCJipsXwMP4VZBsZOkHz1xv48awVQlqhiAnpcMQ/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SG/9Scpv74lm0tU7vqs4RZ6v8rnGiyusCycPVJ1rj8Fi/6IuLWl4EdiwY7JKsZE5FjyheYb2drHfIdbEcSI7gu2ROMOr2W9zsh9z6vx/+znrJ+RIKwg6B8vGU3AOY+Xbe0OYL7T3kvPpI3/MMEOS04RpE1ggANIE99zL9jfCQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQsiOz0j; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bb81e795bso3218405e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725523664; x=1726128464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZnCJipsXwMP4VZBsZOkHz1xv48awVQlqhiAnpcMQ/4=;
        b=hQsiOz0jE5rJ9UVB6AUQ6shs3DAlhYcaeNbn4hTVkcsaFpc+mXnnTO3uN4L6MhP8u4
         K0E6Wrv1VPqkpWGVVt3D5To1j0lLchYPQCX2mJi0NvYELMZMxOykBY5+0kMf9yewOh6y
         MvrjQCwJ6nwiyU7v/mR6dVqv7qz3oHzwoHFqsNY95YQhvYV8CzFSXIzG6/BKF+gVoqsA
         Vufeflbrn5uuMlqcv/QdBx+pDMZUtLaoEXMFX0Md0r2fXCPG+Fi7/XVvgLhcXlH1a/n6
         Y3W3KDVD+P7XOuVwypkYs9vGFrFunHIupcQGGx8sN2KVgWXoVu6s4hoeP2RQSgHVi5Bo
         wLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523664; x=1726128464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZnCJipsXwMP4VZBsZOkHz1xv48awVQlqhiAnpcMQ/4=;
        b=EnKtGaJyxjHp7g/Ie2Ftz+nET1gD9AivervnlO+93Aub8KPHoioGmycQeGxtHm91MT
         uDFb+taPLCvIic2D5U39mAE4BiRavMgziRTHL4AgAn5PWJkfGkSXjdCmEWrqjzHpwkus
         iO0b+aalHBBOvsFtj9qPjaGGjmKPZ6tF1RsTLBBcTNos/ObtibVRSw82/clsUmkDLxZ4
         BEPhwtCdihs0iXpFVRMSgevMk3/UJpyaX9mTVOJZDJG4RVbAgQSyyfly6wFo0RKdkc30
         uc3XnovuYPHZJdz1OUui+3Q1tQ0OzWSFsTaxVlfoG+kuXiJcjRJYn51arndlg4+56f/+
         uPzg==
X-Forwarded-Encrypted: i=1; AJvYcCXIb74vHYRxXr4mr18yJH9dPb9WMutzVl12UOCJ/pBFelm1e227cwW7xTTxQfxsYeVxxp23hUmPBl9AdLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN2yH6MSDW8ES8FBwNWtAH0gesXYr6jdCcMXniR95AQWDa8ND/
	KnNO/qd4oAtRiMBznQeNFynyM2BfBlf9qxgkzeC8+G8BS8hRnYKkZ6zyfL1Adrywjex4ECdo1oy
	rcutrW8IEld5GVZhFvbcIWy8DzeQ8nenz/kTJ
X-Google-Smtp-Source: AGHT+IFhiAj/3EFHGD/JiFE+H1pUAlKa3bW4DHEc6Kdw3MES/KJPwsv1V++t7JJOI75tAiCoDGf6ibbzuzPSulZPbkc=
X-Received: by 2002:a05:600c:1e09:b0:425:7974:2266 with SMTP id
 5b1f17b1804b1-42bbb436e04mr134483975e9.24.1725523664230; Thu, 05 Sep 2024
 01:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-6-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-6-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 10:07:32 +0200
Message-ID: <CAH5fLgjmBQe-VmNP5RUB3sAVGh7EKi3i6GZmaP2b3WZMnGkQ4Q@mail.gmail.com>
Subject: Re: [PATCH 05/19] rust: enable `clippy::unnecessary_safety_comment` lint
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> In Rust 1.67.0, Clippy added the `unnecessary_safety_comment` lint [1],
> which is the "inverse" of `undocumented_unsafe_blocks`: it finds places
> where safe code has a `// SAFETY` comment attached.
>
> The lint currently finds 3 places where we had such mistakes, thus it
> seems already quite useful.
>
> Thus clean those and enable it.
>
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#/unnecess=
ary_safety_comment [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

