Return-Path: <linux-kernel+bounces-353564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1096C992F80
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC012283C9F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863C41D5CD6;
	Mon,  7 Oct 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJxTYD7B"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9181D54CD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311716; cv=none; b=L2VI9TxaV6h1IbUb1bSy/Hc2Dya+kqD1XhtGz/a2L5grgQKl+wPETUr7wwRfF5h5xwBS2XiBbnwNSDVnDl3AXJVTFIam2Cjf3UC9fyp/3t/xim+hFParlQsME97vJd1n1EtKULTgW2D5rS307HsnQ6TvwJkIDumpou47UbdStkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311716; c=relaxed/simple;
	bh=YQIWDQsBjmGWt/IZ/1+qK+QOBolwzDnONBcCpa4ixGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBMaMGSuL0ZciPyxjzBT+VOofErW9hlyeykiQNQiM58rCV0aKBL8tvAEEJZ7Hhz8iGVE01FyKfG5pDnPrF1g6yH+IsUyylKzF537wMsFMmLSnrSHe8GYgNBzcdUdyHCJhttblzz6OwbDNv5/VncpxVGMTEO+vPSMCFRcHKldrHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJxTYD7B; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e050190ddso704993b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728311713; x=1728916513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQIWDQsBjmGWt/IZ/1+qK+QOBolwzDnONBcCpa4ixGA=;
        b=pJxTYD7BrfnODxY8cEhOeeFuKsSnkcNvZyKB/+ldiJ1YEX4cyhf4pIyWGcInwliC4l
         Guezwm5cKqZeJ/fRGXQXliB8pY+aBjW4EGw/CpmMr9nhc32PeR0m/2m3LDcFFP26L0Ih
         aQsM3SKKOZpemaHK2sxItvKF6EilfKbKuoQ5jcPLJftFJt2mpz0x8RnnuTLcgh0mcH7A
         +Y/uP6FTslj0XWyKjCjTLXTd6IhyvmLD082pPo/z0/3fLdg+zOQSGX/sdca3gKTYA24Y
         YdazW9gsUyJQTV/XhoacbGV0XMAamUtUwRtYMa7UWmb/Tiu4lg1eNiBcwwjhshHFszfH
         MCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728311713; x=1728916513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQIWDQsBjmGWt/IZ/1+qK+QOBolwzDnONBcCpa4ixGA=;
        b=H5f1GqEbB7+euPz+oXOFGM+bBSzPIf1eFYNx2jMTL9tRPnPQ8LWsB0TubN/ucPVoUt
         XfhuQY0hUAUkdIt5Xh1xYPM7UELMrwk924e4r7eGruzI44P+9JfgKinctdKskcUrQSHb
         xF9HV8ZQ0o0YGdI5j+aEK0om4OkUiSBLsdgdnunc6b8q28J7dp75nKJ4YmVqMK66IC+E
         AVtue+Lc91zWZOqcRMFUYPU0WSx1WbuwlHBC3fM+Ok0XIfUP+52pPp51kLct8DMWKc/7
         RbwRscgz3xXHk8BqePjxp8QdhdM0GXLvqUUbP6GdJgd9iFxBwIOv2uINus/IuTvDJ+ii
         LO1g==
X-Forwarded-Encrypted: i=1; AJvYcCUF+QROCpgpGdPIsbNQ3IuqvT0MnN4ltKB25YnK36IP4GXThBazBkbqYVskosCt+AK9tUnNbY67gOSeDHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1L48DIsdiOCyn2NiC1sLtoBWo8PqFbSeCayTBSjQOnfg0S6TD
	beUwA0t948iN/M68kp59OrRMJj1zZVwLfuANYKYHiPdY2csdOSUBvf8N7KAMPHqDYD1aW4Yqv4W
	OCIbcyYbZoEPQF2vv0e4GufZ8eNdLql7pmdn2
X-Google-Smtp-Source: AGHT+IENnpbQRLAhmM9zeB/XPptPvJ9f8ZUvqcFNr/6Np7wOvHJi32Koo8lIjURY4/1ZXiXlq1bGgVLVn6dI82s6Nkw=
X-Received: by 2002:a05:6a20:db0c:b0:1cf:6d68:5654 with SMTP id
 adf61e73a8af0-1d6dfa46bbamr16309367637.25.1728311712719; Mon, 07 Oct 2024
 07:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004154149.93856-1-dakr@kernel.org> <20241004154149.93856-20-dakr@kernel.org>
In-Reply-To: <20241004154149.93856-20-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Oct 2024 16:34:59 +0200
Message-ID: <CAH5fLgida5mybAqE=4kk022ui0hmjRMnAttWrkn213XGXBWLXA@mail.gmail.com>
Subject: Re: [PATCH v9 19/29] rust: treewide: switch to the kernel `Vec` type
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

On Fri, Oct 4, 2024 at 5:43=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Now that we got the kernel `Vec` in place, convert all existing `Vec`
> users to make use of it.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

This is missing the mm/kasan/kasan_test_rust.rs file, which was added
in v6.12-rc1.

Alice

