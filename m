Return-Path: <linux-kernel+bounces-270909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747089446ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7191F21C4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE8416E884;
	Thu,  1 Aug 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FTF0jKq8"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C571EB4BD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501969; cv=none; b=j9BMWLhAEE2volcKZDaoBxujKKnvFi7VsWEDUbF3HuPPRm2LZcdNqk1Hv5D18jsv1o4TOh+XeZez5Bc2rA3iEEJ3bH3vdh9v0ZUIUeU9U3QcipvUkxNTpyStB6k+auFcdK7t3lLbt0pJ0M4XW8sRzETthrjSHh7NbxWUEG7B9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501969; c=relaxed/simple;
	bh=5nfLyUhSwdCvNZ7U1JIKCThQBYGQcPVVZFNOS2yg99U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/E2kcyUvjl9S5nZnL/DbFr51ACl5k4Pc9K2wHtq4HBZHP0TDYjDfIwdbBHY7efRuSsnrygvt6DY7zeEFN7wqug0Cj+LOHxUnnX6WbJmR+XdaSs1nfySmn7q9bLfv2/Vv+KnVcQuf+TDwkLRHCssM43ymLYK+apqvJCOjLfQ8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FTF0jKq8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f04150796so11045536e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722501966; x=1723106766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nfLyUhSwdCvNZ7U1JIKCThQBYGQcPVVZFNOS2yg99U=;
        b=FTF0jKq8p+PDVpwZ//pp1LJgmFSTtVYD1FidUhseUC9MegaStm+BxxRD0Pe/IKnOCp
         WwqpnWW635/VxTWIYVnKJYJHU3yf26kCGcUTfnTgHdM9wI9Qsu1r3pq2dQsLUHKU7xSn
         +BAhhoF27LjWF9bSnbqvHm1anrA7Eby35uyaFT3ya4DFlfOCy82NyuiFkT9lDvJbfA8K
         HLu6wp+L1WsZB+UbG23QM6SNd8L7NzwfN8v1/ic+5zBG9XV94AlPMk27NR+gUT2gTUB1
         Sag3q9Dgh5PdYfL7ghCMeXxtk+BtsGKmZUR+A2mVnjCRVlM57JjUHNIFHhQkje38BdqS
         mw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501966; x=1723106766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nfLyUhSwdCvNZ7U1JIKCThQBYGQcPVVZFNOS2yg99U=;
        b=eTllsnu+vYDn8GDNlxm7TtwZZY5B+KdjSDyaHY8YBfDbZG6Cpnu7psMAKhkpud+D+E
         Ft+J5zl+HEMFtR3Y7OCiVQPFpL8YAb74/hypoG9+tEbxI7K3nCu7eMFqbeHcewmvPP5r
         GAyaf4zv9liOWBom2RPF10c96r+oXG2E2ZDQ5MHDO+FRfxqOpFEnIxAOARDa9O1lKU9L
         1dwcrBboQXzZZceW2X1sW4diqOv7palCiesTwDZuokcTgUmZ/us7cPeGlnMR4o1wwQSr
         P6ConNVIIGQ/26pILsCRQvvQuY0yI0hOJFN5slgJTnM++F5BKHTQuxnHgznfeK0xowRB
         lscA==
X-Forwarded-Encrypted: i=1; AJvYcCWdmjvZQ5ia6TdUCui90FH8baGLVpntNdHVKJu7P+qOKCqZ1nHN8tKYK7W3Gp8fVyHCFgXS2Yt5P+CTNPh+4PnHjJlUiD9udPptQKoR
X-Gm-Message-State: AOJu0Yx4UkKuU63XCNIhgvmIFPNO8iOnnR00jvk+0Ynd/C+1ZzxnBKeN
	CYMX7bSpBcXsmNeoMe8zaPZdVeUyomzNzEIq94d2IFNcEQndeYzBKSYxr1xJg6yR5VcqUgrzpLL
	jKOsLadt13HxGEMvW2xq/XuLrLo/AHtiT/6Su
X-Google-Smtp-Source: AGHT+IFN2UR8WSAl5gylhHpTY15QGFvKiCG7UBeB2JpSyJXc+k5DXeSah0KlURrlJr8LyFkVwCQAWTEobHctV/efbmE=
X-Received: by 2002:a05:6512:685:b0:52c:82fa:ef7b with SMTP id
 2adb3069b0e04-530b61f8e09mr1087052e87.44.1722501965930; Thu, 01 Aug 2024
 01:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-9-dakr@kernel.org>
In-Reply-To: <20240801000641.1882-9-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 10:45:53 +0200
Message-ID: <CAH5fLgihauE8enXj7x4BjtpXpG+CkWDrfx=3LOwQAuRXgMxybA@mail.gmail.com>
Subject: Re: [PATCH v3 08/25] rust: types: implement `Unique<T>`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:07=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Implement the `Unique` type as a prerequisite for `Box` and `Vec`
> introduced in subsequent patches.
>
> `Unique` serves as wrapper around a `NonNull`, but indicates that the
> possessor of this wrapper owns the referent.
>
> This type already exists in Rust's core library, but, unfortunately, is
> exposed as unstable API and hence shouldn't be used in the kernel.
>
> This implementation of `Unique` is almost identical, but mostly stripped
> down to the functionality we need for `Box` and `Vec`. Additionally, all
> unstable features are removed and / or replaced by stable ones.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Some of your impls could be derives, but looks ok.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

