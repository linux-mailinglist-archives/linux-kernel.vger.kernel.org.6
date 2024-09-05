Return-Path: <linux-kernel+bounces-316544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAD796D0FE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457E02857A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E5B194AE7;
	Thu,  5 Sep 2024 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="05Z4+D+o"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5740A194A70
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523041; cv=none; b=SwoCrLeGjfmP/YnO2D31jqShxjzANibFYg4/Ivpc45GXKbxRKraK6xLa0Ty1Hl4SAvZCpPNXuBg2ngEK0x+8RdysRxuTwOndr/RvfXJ9TpEex6vXxeq2gbLu1NiAAHh4IhOhpdrN21YEqbTCxHY0lEyEOB8e8BpMvPE5tC3+cuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523041; c=relaxed/simple;
	bh=/15VqRopHjfs3Vag1wk1OqFB52SnvYMNDXanIJRXvYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipdM4vAJneYAIY/yKcljGXNp6ojSwah89SwaEObmSBYZ7zIERua/2Mv8JLkKyXvwlaFA/3D36fHaE6U+8luzoFCSEflt2JSDhz1Gwp1CqwlMYUvq1d39Tslt1M11o3XplMqCg0kyzoXjYKZs/H08fKJ/PErDgp9o6VwkXtpSar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=05Z4+D+o; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bb8cf8abeso3132885e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725523037; x=1726127837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7YrEnRdBza8n37TnMfyYmOU2+akv+XRSo40dZskXfA=;
        b=05Z4+D+o1hte8gG8ebxJ9uhLz2VkZYWO2y21Q+7/LEK8Q1bo+ICRp52NgAhPn/YIpQ
         9gmUkMUxnn6eLFsddi7LjQvJxMQAObqxDf2+cGI7vtxvXqoXBTFweDjLyx4xZZ7XXrNK
         TSu18Sd6CmsOfF3A7Z3MuiSUjmWNZsurpm0uWNY5WkcurJXJOzSCP6jVxL+O/mew1aK9
         sD7EKuGMOipnlcSS3prj0/6EiOn2G2PL69U2R9bybK/MC8l8ioYV0nvWH7d6AQnpPW3D
         HA+b8NuTILCJ0zNySkDs1XqbegyfYH43WuoqFI35U1XPZVPZDDaGLH5hMIzsC/MgOu1t
         dCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523037; x=1726127837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7YrEnRdBza8n37TnMfyYmOU2+akv+XRSo40dZskXfA=;
        b=cduFZ3Sc78jYjUrHWo5Kdrsq2tgJUbEvYKO/sp1gV6bySu3QwK1JWeH7WamAUVev6f
         KEnoHnzt1iX76Kn+E6G0ZwlDM9iT4mKFM+gndy7aDaE6SRnbR3JdkZ62nCI01B/WS12N
         OoiPQJaeuz4w6jhhB5SXbySVFaKY0elMBAp8+G6WwgedVkpOGykkSK7vDG3uTEvYIMg5
         nUg+KJjBUC/SkGRBvHUqRl4auG7U7k3yqsExhLMOnS91e2NtCu3yoKfKl+pDwkL3hb8J
         BYJiOPRshrOJW3UqEMc2o7Cz8COw0yCOTMWJFXYzm4gR/azfFTtyAJ+0dY/J5ck6iL6v
         jVSg==
X-Forwarded-Encrypted: i=1; AJvYcCXsYEXkPTp8Rivd6a06bRrJU5VtOI7uhI9PGVZuv3SukDvASjpbSJ5XsIN4USMYyFKRGby9nGmWUDDGzPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyikEw/yuVBikY+NbH241yAg4KdlOf3QwdicIgbpcKO7DOIiCP
	KX02DPkcO+r5UCXLRRkcHA7616ets1wPnUGsaDt7LILlValKuv8Qe9/omMJpfk5WYaOGXgWJhvs
	RMqLgfqLgPv69uCfVg+QfzTxq7OLJBYamNpqm
X-Google-Smtp-Source: AGHT+IFGxSk5gvaezHEawui3mVYKQEAynuLTKFXTokKk6E856Tt9Cj3ku4PsaYI/2eDBJp3YhF0CWjK1PgsgItKLriw=
X-Received: by 2002:a05:600c:1551:b0:428:ea8e:b48a with SMTP id
 5b1f17b1804b1-42c8de5f5c3mr45944275e9.8.1725523036325; Thu, 05 Sep 2024
 00:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-2-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-2-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 09:57:02 +0200
Message-ID: <CAH5fLghM7mLjaivcErwwMGREvdJJMosHDLdCn-RUbdqJQo-DwQ@mail.gmail.com>
Subject: Re: [PATCH 01/19] rust: workqueue: remove unneeded ``#[allow(clippy::new_ret_no_self)]`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:44=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
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

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

