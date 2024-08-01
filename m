Return-Path: <linux-kernel+bounces-270937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C77944743
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253F828165F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909713D97F;
	Thu,  1 Aug 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBM5uNOp"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53549482C1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502847; cv=none; b=M0gVSXrYMdBcaxNMFlRUUwhgBEDRgZzdJVehCfsthiLPpEOGbw6ompkqdufB4pSdnoWHJ6UlpMdmDvefNBmNC8COrETcvrheNS8Z4TYgPT2rlkYsjL2bUWNhsMY+jd1tbSgBIpyslSr2Vsryb2a72jRW+dqMBYvbgHjyAUoOCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502847; c=relaxed/simple;
	bh=3hQuQcN2gMGVSPwErmioh4yq+cgkg4q17a8dhn5NTF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwuJiQ7ssd8hZ6771qfHjO4AUDB199UfJhzhSuId4z13T8X/+ZXjCTLWTEVJyj2EtTMfjvxUKU0HDasVpob/BE9kZe5nbwx5GUt/0px6zMi6gc93Z0iGi1Ah40HApPVqYic9dBmpp8DVE60ZBp/MmdAOQzksJvnPtiHqv0wRnU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBM5uNOp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428e1915e18so3019125e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722502844; x=1723107644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hQuQcN2gMGVSPwErmioh4yq+cgkg4q17a8dhn5NTF4=;
        b=UBM5uNOpucnDWH/OsdOTwfc44yuOSOtAs0lSVdRJyYcNyWrqCD4qKlTcjnaE9PwWp5
         DFkdLYXZO2qCtHQnOAVbzEkEeRgUo/lPTVfsMuTZGBUJ8CGO5PI7wtdwuVWZ1/eDEFnp
         s1IlcDGgwuWKEXEVfeNXuuK77rMQSb88y+hx2bgVGbtOgzmQsDYFMUbM4iRwwsMTB85j
         3xfvKDUTJa6vkcqBgjfqI/UIB0t+lHdJkR10IRfWPaJt4H/k8EkG3PFkQ1SNgZIaa85H
         M/1vS5XPi5cboLeuQxxzfkrAEiuBJcqxcm8jBmyLF81Y3WH9VeVLPoPgew4nq76QjgAp
         l/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722502844; x=1723107644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hQuQcN2gMGVSPwErmioh4yq+cgkg4q17a8dhn5NTF4=;
        b=LEgffO1XkYrSf8d71htCgTZ0Cm4idkbcRVYVujbKkxZ5x8gilbNxxaZVDVFpGETcdn
         PFeTGz8lZCP9tfPX8AIh/XkjhlleVgI6Ia5nNJ1zGuJPBlHi+bTKS01H54vbW0umh83s
         Oe1hvngVLxvTMCne4UpQFvuLB61A9McFm/sp+QOK7TooQNtJU9T7WDMaRVGNBsmBMngq
         Dnt7q1NSSdt+TFFVXgynlpC7gu5qydi43Wr5ld/ymvNyrdX9Gw79d25Key3YSWR7VoHn
         NMHYbKG9mcBzM4W1qgRIYtixV3rVoszP1uzGhdoEIQ38ekCx1wDO6g4qdCnpWAY6WnIE
         y/PA==
X-Forwarded-Encrypted: i=1; AJvYcCWBM/oM87QgjoR3p0JvpV9T3RqUJnMPxVKoDqAUkqCMjbmth0D2Wbd8k8BmdJGzErsCgylH2HJ9c+l9iT5KWSEa8s9mn8vsDLj7xaH8
X-Gm-Message-State: AOJu0YzZevoYX3uEnwnq87li48qOMO1UtFSMKg2pLMtnN0eqdopI8s6X
	lDVSpFAxHD9J91Lf59nG4KThNNfOfBkiOnzAPI7pf5x6SbYpEuqxVVgWMpw+YDBjmMjD8yiZryi
	kgobLih4fpbJreatFEhPK89fwdAmq7/mLayI4
X-Google-Smtp-Source: AGHT+IEvv8uqz4euwoAFnEvyIjvzVDgT6Fm779QfgNrBvXN7M0uQrA391FvKVou1+/JSodt2L0kMaV9QJAyp4aV8NL4=
X-Received: by 2002:a05:600c:46cf:b0:426:5dca:50a with SMTP id
 5b1f17b1804b1-428afb4c28bmr15393065e9.21.1722502844316; Thu, 01 Aug 2024
 02:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com> <20240727-b4-rbtree-v8-1-951600ada434@google.com>
In-Reply-To: <20240727-b4-rbtree-v8-1-951600ada434@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 11:00:32 +0200
Message-ID: <CAH5fLghFv8uYGbfjcjtxCET54xG06=Ck15fmoZQJF1L9S=sStQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] rust: kernel: add `drop_contents` to `BoxExt`
To: Matt Gilbride <mattgilbride@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, 
	Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 10:30=E2=80=AFPM Matt Gilbride <mattgilbride@google=
.com> wrote:
>
> From: Benno Lossin <benno.lossin@proton.me>
>
> Sometimes (see [1]) it is necessary to drop the value inside of a
> `Box<T>`, but retain the allocation. For example to reuse the allocation
> in the future.
> Introduce a new function `drop_contents` that turns a `Box<T>` into
> `Box<MaybeUninit<T>>` by dropping the value.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-323e=
134390ce@google.com/ [1]

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

