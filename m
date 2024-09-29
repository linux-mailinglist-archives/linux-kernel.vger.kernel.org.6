Return-Path: <linux-kernel+bounces-342782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B29F9892FB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83441F22BCB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD79325779;
	Sun, 29 Sep 2024 04:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Rw0OsT8G"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51841E49F
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727583491; cv=none; b=YQqR4gCtu7jv3gjWFKVCff6lYe498Iax4gTTKvjbXrppnlSoIZ2LjwErIKQ25ha3DViaHfcBu756Sjg1GJaLH4DccZ/VmIRCYHLS/tL7llSB4Ya1MniwVu9o72v0rp9LUW/M6YY17HcBpXWz+Tnr1D24S2ZE2JmoQ0j1UeNLgMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727583491; c=relaxed/simple;
	bh=FMIGLf+Y9vF5aJ2DZoLFX9IXpQMyVobrCuEt6UgGFo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MV2izDco9+v3H6mDSS+Uh/7vQ6j4RJFAJym9UbEWTOb6aE+o9wZnm9JBorJpEeAulXY3fDXE8rQc+Y0KIjhmTRoKetuq7ZL5d5XtouOvRsMVvkah6NOZD2gYPWm5aVpc23UuuiD/d2Ih0kRQ2+6meIrd5gwcOAdU+aWwkpCqa3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Rw0OsT8G; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e232e260c2so26283627b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727583488; x=1728188288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+m8AqonS+5wkQ0t+OwfdrCfKeL0zOxEqCmb5hKElDc=;
        b=Rw0OsT8GmZYYqglm8P6Wz0ymY7A3YaSe7gpCXqTFLQdNPh20uWauc1AHlHBFBynH92
         DWV/MncdSIawdGrMeu4Il44XZ3PnHGKA5i8foNYHn/hm5fLW19tCa5UZDjuMDU7LeD1s
         KndlFC7krm0ILQFQ1oDojEcz5c82R3eVCtvOCo2Vri7ZyOfFNZQLbysHBLom8qAXol0J
         QcFm4nQJxMWlVABexneUxCswrm70C3+WQSS8tSMPOviF/CpstRxRXztdu6ZA1IowibJT
         AylNUrb48/I9uvx1sYsdiG1FSF0dU1aj+QyEj6RcTq9eY0LK5qsKhrLrlik5fXrfosKX
         yB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727583488; x=1728188288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+m8AqonS+5wkQ0t+OwfdrCfKeL0zOxEqCmb5hKElDc=;
        b=HNZHLfFoj2MKiIZqOh3QAwem1YzETu4wLqZCddSkYdIUAjc63SgJ9OFLunlj95qcTf
         pQBUAG7Ir7Pui1Jh6q+8NNhDCM3nDAy7gI1UIHa+4H/LR1uKath5e2haOOdzZCJvvtsX
         0DT3qiBw19yYqHMoxECdexUrIC5A81ZU45y/pyVtfgeAXRdxKO9G4jjt9l7IuaeTu7Uh
         0ZCtKuOw2WmbYA9Un+NbgcvITYS8+pnZeId+wtVedh60vvggkGyirQeo8kxCNNb4PB3f
         mGT1uwZNx9qH/B1IBDmuVezuArVmHv6L2jsLcCj/1Y6BgJmsjYRBvgcB1/b+FVBy9g7j
         /Dkg==
X-Forwarded-Encrypted: i=1; AJvYcCVw4huIdWrrETqPDikp8a1XoRolztlWDZbjJaJ8mfbFbBnI6GFy/6EkGxQNl52crXa26O4wK8DOiS5hWik=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa+gPJa5WIq1dRnZKkv90izdpab/WNwBC9UTVB6fCU6yCzD1Nv
	fUFq40YxnPHRP6ZAFEaAe9nFwaYogH4Wia4lfJbOJG6v5/ykieMNgFAQZri90gl/QKkNwmiQMaI
	5ypEm+fkHXWWr3KkNJPqQph0/nBV9kNCcQv8Jyw==
X-Google-Smtp-Source: AGHT+IHG+ttejnUk0zyaZpRqlfVcERFzFnZe28OrhK/N94BnvFQjUgcmlw1DztcdaSHGiLlQpGJBubePZGpNHYH6Hi0=
X-Received: by 2002:a05:690c:39a:b0:6be:92c7:a27e with SMTP id
 00721157ae682-6e2475e2d1emr59019207b3.28.1727583487761; Sat, 28 Sep 2024
 21:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-2-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-2-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 00:17:56 -0400
Message-ID: <CALNs47sLuQU3=kT_eMi_kR1_Ak-75P1S+-G5sewop8J396EmoQ@mail.gmail.com>
Subject: Re: [PATCH 01/19] rust: workqueue: remove unneeded ``#[allow(clippy::new_ret_no_self)]`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:44=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Perform the same clean commit b2516f7af9d2 ("rust: kernel: remove
> `#[allow(clippy::new_ret_no_self)]`") did for a case that appeared in
> workqueue in parallel in commit 7324b88975c5 ("rust: workqueue: add
> helper for defining work_struct fields"):
>
>     Clippy triggered a false positive on its `new_ret_no_self` lint
>     when using the `pin_init!` macro. Since Rust 1.67.0, that does
>     not happen anymore, since Clippy learnt to not warn about
>     `-> impl Trait<Self>` [1][2].
>
>     The kernel nowadays uses Rust 1.72.1, thus remove the `#[allow]`.
>
>     Link: https://github.com/rust-lang/rust-clippy/issues/7344 [1]
>     Link: https://github.com/rust-lang/rust-clippy/pull/9733 [2]
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

