Return-Path: <linux-kernel+bounces-335922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A1A97EC99
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C28A6B21FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F5419CC16;
	Mon, 23 Sep 2024 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v//RNm/F"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7081953A9
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727099805; cv=none; b=Bc+oBfvA/KD8kkIRHFF7iCIz4FTsCuw34v/JN3GnyBmTstFi8rNs8dM2JMg1UOE0i9SHdIeMeUWARfOC7rSNSTrkhj+Q4Hl97KN5ioeINH5QKyOqP0j5eeDCa9nT0YHU9DukHOOv1RDZ1iKErNMfqtaNUJCxeZrgqR8iIHxtMu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727099805; c=relaxed/simple;
	bh=giFoMYao8KNNQ2XYXQni00j6S3OL851OX7kh/nDgy7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IedP9sapjGXWvlNNZvzSLQUqoO1I4Z4+7dal1uYGv+cNm+upteDrsOeVszr+QxEzffqNRCPHKZmmz1O6TTSNdWoS9rKR7gtaQSOU2tyFYzxwN6l5dwWAHWzdtjKL+Sw944JSnUMDCElopGk9EvDJ1xnL0JL31WhDWvy53qKf56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v//RNm/F; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3787ddbd5a2so2476222f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727099802; x=1727704602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K65OUriigmcjw716sL+YS2krxSoNMHfBErxI4saQaak=;
        b=v//RNm/FDarDxZrGa/Xnj9Csbbe8bxtz53PWMzgI0BtJ+txNICkRLo3C1lJ+pIyItS
         LiKqTxyPVbMf3kxtfKOf/zVL5ckYkE+m97nPhB/pcxBiIujaurAkdjgx0jKtukvVvmW0
         lgYT6mE7vODyMn5cv6UvAp7lrREgL/mwTSkRB1ZXoK4wZcE1rtci2UK0ifmPZ/7AWRFS
         cWFm8mmuSmIPep7C/vjKj03aUF7Fuj60bOlSZw9ZU2w3veh/dQmJmk6QKZkob8pGaVfM
         x0RE9GJm/VAYG+Xtw8xAU/DD3aDaylX8V677NNCi+f354jd/FlxBi6/yqQxm0cuFwSun
         rkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727099802; x=1727704602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K65OUriigmcjw716sL+YS2krxSoNMHfBErxI4saQaak=;
        b=B1cCD+PgYE2drTkr5KJ2kBnE59rPNaPCga57M5oIeEM79J+NyBfpp4akdcZUKj5tXX
         f51LWejo41RKHj8SscIQUPVjYqg4vzWOL/M3UlnHZqmnaylDzJ32NyM9BhPomqjBT+VU
         WUb9yxmQbLE/sVi49EpORV7zqbBrNAp1m56kF1Q6OcYj6f4eFVM+ttHicDukgBP1pslJ
         EYXXL0h/PC6Gk5UeZebRMJUG1PFFOiz2Wimw3QXNUMlQQJ63uL3qKgCUAWsh2eXrGxV4
         g+1L6fbOqUYaLxmcqCBZEq/xGFDZeL/mJdb1G9gE3omX8JJWiVKYn9qjK6ApJDpm8MV5
         pUaA==
X-Forwarded-Encrypted: i=1; AJvYcCVOy7NmdgMjp1mGTM8SBTd4nWWdH0aMBFEqYd3kJaTxXawVbQr1fgjzGvEwxrO4g9GNzhrleZ2MU72poaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOqIX7ex239xP9qy5XTaMDV9ksK4bLU+EGUSxLhQWNA09Ti/ah
	Jq9M2Mdmm6cGFyR4iwc4G0VTScmQEL4DDy4xYSskLSgD3I0lGBJYbn7Ignsad9qgMSK5y0H1zbT
	OYC43hMy+qre2JElrPrvONvo5OJBvRyw121Ab
X-Google-Smtp-Source: AGHT+IGu+WNCdU6LbNA3wlsR43apKaz3iqjvGtP98waIXa8a0szU+JAi5FBbZVSSRy4+UhCRZsAvH2ClsaPWJOBmbIM=
X-Received: by 2002:a5d:6b43:0:b0:374:bcdc:625f with SMTP id
 ffacd0b85a97d-37a42398cb5mr5439848f8f.51.1727099801892; Mon, 23 Sep 2024
 06:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911225449.152928-2-dakr@kernel.org> <20240921153315.70860-1-dakr@kernel.org>
In-Reply-To: <20240921153315.70860-1-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 23 Sep 2024 15:56:28 +0200
Message-ID: <CAH5fLgievsJOe7QET+Wh2c0upygv-nhSnOuTN8K_QkruLwOPgA@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: alloc: pass `old_layout` to `Allocator`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024 at 5:33=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
> @@ -84,11 +92,18 @@ unsafe fn call(
>          &self,
>          ptr: Option<NonNull<u8>>,
>          layout: Layout,
> +        old_layout: Layout,
>          flags: Flags,
>      ) -> Result<NonNull<[u8]>, AllocError> {
>          let size =3D aligned_size(layout);
>          let ptr =3D match ptr {
> -            Some(ptr) =3D> ptr.as_ptr(),
> +            Some(ptr) =3D> {
> +                if old_layout.size() =3D=3D 0 {
> +                    ptr::null()
> +                } else {
> +                    ptr.as_ptr()
> +                }
> +            }

This is making Allocator work with zero-sized types, which deviates
from std. We should not do that without a reason. What is the reason?

Alice

