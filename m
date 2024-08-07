Return-Path: <linux-kernel+bounces-277905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C091294A7F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B86F1F26873
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B43D1E6749;
	Wed,  7 Aug 2024 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="koKOUPAy"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2E1DD3AF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034557; cv=none; b=VKcGBlzauU+I/c7SB7FeYAl8+fcXXqQjV+0zyXLmQuppyd/PkD/KwrmqLavjwLyKgLli8xpKt2cZYFHBcwlicHJqTf8TQgTb0E0IXS2vb1vW4xaUJNbcnYzrukUcywz0qD5gzU9im3OXV5/TTYPHzF4lv9/GKdvrAVVHrcL3T5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034557; c=relaxed/simple;
	bh=dC1Gqu+ImAfjVByCQHuV657Tr7jIv7TZOwNXzQfDCT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igx8GKDIeWFLsFPP9w5WJi8gUqLfPkfBGwqBl/rezHmf9HGRfGwDM4xTiRY5S5JCc7RDxNhbNgnzwEVG6LXlQNTkfJjcYPoqnHPZEsUnll2Rr05TdkFou/lK9nJQtyrYHknGnA+2q3FXNp94wEc0X+uQkRbLXCzsz63sDFkTwec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=koKOUPAy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280bca3960so12710145e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 05:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723034554; x=1723639354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dC1Gqu+ImAfjVByCQHuV657Tr7jIv7TZOwNXzQfDCT0=;
        b=koKOUPAyxBR4fz5wHc9M97hE0J+oxW4fEmKLMwRbArj4bYyZfpItBbh1/i3+UfUQGm
         GnmK4UuY/bVCQ2VWahE+paYGvn08hBsXXFW4exBA0o+e3wvSWGTaeVtood8jRgHFFgfx
         7dige0ulLHr44iV3xeabno1pP41WAWbV3EfMTU/eGLdoSmQed0m0fZfVDa7H4LWVL9yF
         VVbViv/bE9nbHqNWQtZBMw+A2oG5TPhj89C7GinsS5pQFmUuuNGHcwmZSZJQ1Vml9r9Y
         dJwV1MJI8TpChjYZHvjjYpxgt2j0A28jset14aZmSCASiYJDslaTeIItaUxwM0REMw8D
         F46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723034554; x=1723639354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dC1Gqu+ImAfjVByCQHuV657Tr7jIv7TZOwNXzQfDCT0=;
        b=r70ngGCUV0tgV7Pl5qwYPfTVFhVUfO45PUw9EU1+/3chFlYTPyEqPoq8QyDji7T4U7
         m6Eos2jYZ6a+qECi91cCEoZGdnouekx/pqc1hu6lZirFjaOIznjMV66zXV1umNEsb/i2
         30fp1CWpTgfWYA2Hx2207wamdnH7vZWspV0P/NjTk7taSDHIYzuDTemyItmoN3gaanCt
         YhdqMXKOuu9E6xa7OJGgPY0C8tNzD8XmAE+PHafUJKxIocV7gmcnwE6BB+Me3ndL5Y2y
         33/aQC+2Q0PXsMMl84EOMSG/k4/QW6p8RCVX3ZO+eMD0yWjrneVBM5NFA3BChyIMSNrL
         AoQA==
X-Forwarded-Encrypted: i=1; AJvYcCVbH36QcQLxSZNMTWY66ytTeo/5v2LJV21FHx6oLE2F7fpQ9o+GfDMIQaKWTW6qv+N+ghxjkR8680cLUDgVMkXl16Cl3lP30psJNvYG
X-Gm-Message-State: AOJu0YzVt2y6BBn7a87tlbOVXLoU1C67bp4ntqYKxLFor4n4Q5EwHNi2
	4cWNtUcrB6GFGzhoHJrGSfRuTu6g63klbQVegLdAWa9FiYJ0yAeicX/fx5SIyEq9+BnAZ4KgjP4
	08j52iGneDW40AAeVHwZqwdXflRZtHEHqnZvT
X-Google-Smtp-Source: AGHT+IHMOwVO5PgoY1ty91l1/Mip8oCnfxb9A32cACdLXHKInsEtqb2h7xNIx7PEOPNHhk73co0BRxXODtmm62aFDIQ=
X-Received: by 2002:adf:cc89:0:b0:368:68d3:32b3 with SMTP id
 ffacd0b85a97d-36bbc11aaa5mr11469188f8f.26.1723034554173; Wed, 07 Aug 2024
 05:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-11-dakr@kernel.org>
In-Reply-To: <20240805152004.5039-11-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 7 Aug 2024 14:42:21 +0200
Message-ID: <CAH5fLgjsHQvJB6O_81O6hBx_XHocQXv8qCEZZXmUeNgQuNZv3A@mail.gmail.com>
Subject: Re: [PATCH v4 10/28] rust: treewide: switch to our kernel `Box` type
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

On Mon, Aug 5, 2024 at 5:21=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Now that we got the kernel `Box` type in place, convert all existing
> `Box` users to make use of it.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

