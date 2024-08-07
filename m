Return-Path: <linux-kernel+bounces-277984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4884994A90D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21491F288EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5364820124F;
	Wed,  7 Aug 2024 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5GbbFwQ"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D4220011D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038700; cv=none; b=OqF65434Fy/bNTTAf9zJnVdRb2HDWlBi3HTjrIUSjFOjIp9S701YcLpM2IsP21qKyTArdt/iAtgUKTM0UDwjOI5vIjlyFwq1ekhwrhHLqvPD0fhDgPO+u0244VU+q53+uJmOCDEBqEQIIqfdyNU+xXCgxLuzMR2pxea8RU9RsLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038700; c=relaxed/simple;
	bh=pBYKm4fpVfzgQhza0GcXL5Svom4ImHO9MgVTTC8V5uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQqnrqINmPO/59B6rzH594H19FVffmHz6PGXK2zn9NymYEwwOhTdwre64x6CDaNsNNVQlDHSmppwaVeR51npTOzJx+9EB1bMaVh8tuYPzckOrWDZ11dV+U7jR0bqThgh6A7guezXSKnDVfHdyVwpxuR0tRKsmHMFFXozBaYSuEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o5GbbFwQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3684eb5be64so1193912f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723038696; x=1723643496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBYKm4fpVfzgQhza0GcXL5Svom4ImHO9MgVTTC8V5uM=;
        b=o5GbbFwQVVzFnWz1njC118t6Frfs8UYBombXVHqEjzot7jm/5tUCRZZb0KeS+7oB8A
         ASxdnMUwRW2bp9H22lFrfIkEJKvQpvOZ1DjXpVREbOGsRQGH2GbAsiLFut0VRxi6FoQy
         8RyZ/ptv7/59yM07hwPOz9YCqRktyDuSyRt/PaBax2w2qrZkmm8DPOUN+prANCN0vcoi
         WQYGLvQbt5xdbEwk8g1aFAiP6FiY+unSW1v+VJ2YSzTY5fWma81HxAYSo7Ob1PHzyX19
         NbA0ITRGH93zYoV0qs6KaOazc2rU40DAaEhPoOuGemXkWIkakC5OlQJ72l/WpxqcgGgO
         dBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038696; x=1723643496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBYKm4fpVfzgQhza0GcXL5Svom4ImHO9MgVTTC8V5uM=;
        b=rR6GsF2oas01SVICRjsctcGoBexEHjoFh6pfvWxYVyfMe09RriQt8Anke7kdXX4+it
         T+8s1Vy0F/0iCxFUfgXOQnDCBtA5g8pBnEP3c9+h55mf4Yu5bpPmM3OHYO4+dgBO+R6X
         D/BKA7q0h4eQCnO/SdvI+q8Stgwf+OB/QXKk1xXyRybQlk7PneDcsM4RVW9m/BrMbVwd
         17eTKE+VOx8yVeFcGPpeR87S9Eq8cJ5QCaa9uZMu0yHO23JK+2c0IB1d8fIq5qZyQMzq
         RbfONYokzbyC/NuqeGPIjzUIBOmVdYybQUBn6tO9lniXa+daLZOpefz8/HOIZXxMSXV/
         yu3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5NLg1nIFtTtCjxquNICqmhuYl1rUejbWaeXVQCG5whR7QMz7ncpcoSHa1cJhPABQaRWDwwzqlzTCiCMk1FDlwVnCToUFKPcP3JhwR
X-Gm-Message-State: AOJu0Yz8Ex3l9jtJ3Qfba73Ijxg2CzSHGRjRBSbStZ9PCrNEMNnHWK0j
	S/SNRRrcKCpX6J4etNe2aaXQ0ROyKWsot8yyBytvWdW7OhjPXeQVtfhkGw++h00Lr7WGHwLgDeI
	La6+fHX8FLDD0B40vlDuVWjqfyhPDLyUtoE1Z
X-Google-Smtp-Source: AGHT+IFuC3HLUp9hyD6So6+hnbU37q4OQ+Ukt6B6VnPBLXKa8C8jCu5iGy1pQ1I1JNmaotgHtfO3vh+Uwo2gUSz6CmI=
X-Received: by 2002:a05:6000:c03:b0:367:923b:656b with SMTP id
 ffacd0b85a97d-36bbc1d2019mr11524154f8f.54.1723038695630; Wed, 07 Aug 2024
 06:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-27-dakr@kernel.org>
In-Reply-To: <20240805152004.5039-27-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 7 Aug 2024 15:51:23 +0200
Message-ID: <CAH5fLgj1YjuBaenY1TN6dGGbAPWK1zGBA8e-0zVjy7amouZ3ng@mail.gmail.com>
Subject: Re: [PATCH v4 26/28] rust: str: test: replace `alloc::format`
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

On Mon, Aug 5, 2024 at 5:22=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> The current implementation of tests in str.rs use `format!` to format
> strings for comparison, which, internally, creates a new `String`.
>
> In order to prepare for getting rid of Rust's alloc crate, we have to
> cut this dependency. Instead, implement `format!` for `CString`.
>
> Note that for userspace tests, `Kmalloc`, which is backing `CString`'s
> memory, is just a type alias to `Cmalloc`.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

