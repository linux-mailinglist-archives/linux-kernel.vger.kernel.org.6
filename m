Return-Path: <linux-kernel+bounces-169179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5521E8BC484
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 00:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D612815D0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB86137743;
	Sun,  5 May 2024 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7Q7Z/m8"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F3D136E36;
	Sun,  5 May 2024 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714948144; cv=none; b=UCfSGbrmY9XpyH2zNDTmCL5d0sNLdDSGOUwQ0xaiGrQrnX8UrWeruNzco0gPsE/qRQBp2Q9AF0M8zjwk1n6RlwiQFlIkwyiNsEyzKvTfLthFe/8AmgtfJzMV2QueL83jJElSP4ISNhJsrIFbOjgEFr/ljFWkEY6SsSCuF7YOtSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714948144; c=relaxed/simple;
	bh=eUQQleMvSVLVulCJRkbWmyly+60mD86dyOdlya7uQY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6MUhfu74L9md/gmc3zk5g7Qo96XpJ2TxJDZ4P84EkWU/uomO8Q1rz7o2dLTaISbYotwRxAl2I1wfJ6/5cJx73uNbaNVR6wjDTQlEI1VkvfI5aEli2Xy7HAueqiNj5m9E7yr/vVSFT8wTfxalz+Y/TXANebDk5T2MLfJ7A8ySpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7Q7Z/m8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b273cbbdfdso942747a91.1;
        Sun, 05 May 2024 15:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714948143; x=1715552943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUQQleMvSVLVulCJRkbWmyly+60mD86dyOdlya7uQY4=;
        b=T7Q7Z/m8PCYb+xcyBGYtfiMiA4e5OVoq7/hi4USks+PAZ5ppKhQ4QcZx5b5iyikxSx
         BrrITuckqRdXhInCMVfa6F7i+WOVoXhtV8GAVXLACZgHHykt+Y+ZlVba5ARzcwhi/HIE
         HndRmQFMVicbvOHfe0tWf9+vdNzhKnXRfSdp8tmc7NxqCcaQSRAAGuOiUmkgIu8b5ec5
         vrOgK441foetgFhVUo0NieL2VFWLlXC0fTmrkJ07qAv4O4Adq5QpjcKVFVy2D/3xQeVg
         0HQDXUcB4mySsqzVnEQdLPouLP9yc7yXwIZh0LRQcM6wQIZeEsaaCfD8bp/ijonCMqf3
         AeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714948143; x=1715552943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUQQleMvSVLVulCJRkbWmyly+60mD86dyOdlya7uQY4=;
        b=QQ/BjkAPibh+PYkhbyoci3C5YRUG1tLt/2ncyVPVen5vEIK7oLbVkEOpX19vAeR5hY
         gxWVpPNVCys5XXKcQej6B7FIesT16kR/y+yrtzlQNhKc3Yg52SmhdQq3tui6RMYtS59H
         cSxXDSjLDzmSYoXPGyATmrx8+FLXcyXCEX8s4awEOYfAJLsX81Eqbb6J4EuHJzuZx8Pb
         VHntMWpyKeH5KE36L+t6XQrwKDN24VEpovUsOGOdNcEyEkTXyXNshg6kD/yudMKIYAhZ
         y7DjygcX+f1YnLTLrX9Nr5lsueu9DjP61kExLLKXh5GC2WLzFRWBiKMAg2K0ILWA6O9R
         7xNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSfvPDU67pyoHUO4DI37MN57CoQUKGCoCcPNRYsAIQu+lHRjU6OVyuiRYgcao5wv4LAeSyrRnScMpqT4LAHciHdYQ+nHRc3VBvyyyu0rmQnt3DxChce1+TgPwbIUDl93qIpIm+kz9KX/b+YUI=
X-Gm-Message-State: AOJu0YwP9bo5qfOt1K12G7+h1oD8o99rUEu32gYrC7/whzlzcmnqoDL+
	yQNQqMU14kffCM8Dw4kT3YABVwjjSY9drSDjkbsQmn2NCNiukUaL8mEPDJEK0VhhKFrroxMmo2t
	IPIIR0Yx6VIA3N/2RCCbCDVusEwo=
X-Google-Smtp-Source: AGHT+IG7V8Yp60YHqPzYcVkmvmzJBA8elpk/TeoONqKz1nK8Sb2c3DB6W15/4bZHGcFEDFIVMRLFZV9ssKg0YXM9hV4=
X-Received: by 2002:a17:90a:f289:b0:2b1:817d:982b with SMTP id
 fs9-20020a17090af28900b002b1817d982bmr6831234pjb.14.1714948142788; Sun, 05
 May 2024 15:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403194321.88716-1-benno.lossin@proton.me>
In-Reply-To: <20240403194321.88716-1-benno.lossin@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 May 2024 00:27:39 +0200
Message-ID: <CANiq72k_2gY2X8bhDmjEax9aGP0yXJfEsN_Cp5ebJ6Mf1PwmFw@mail.gmail.com>
Subject: Re: [PATCH] rust: init: change the generated name of guard variables
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 9:43=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> The initializers created by the `[try_][pin_]init!` macros utilize the
> guard pattern to drop already initialized fields, when initialization
> fails mid-way. These guards are generated to have the same name as the
> field that they handle. To prevent namespacing issues when the field
> name is the same as e.g. a constant name, add `__` as a prefix and
> `_guard` as the suffix.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

[ Added Benno's link and Gary's simplified example. - Miguel ]

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

