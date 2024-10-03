Return-Path: <linux-kernel+bounces-349451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C268598F66D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A69EB24113
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8611ABEA0;
	Thu,  3 Oct 2024 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL+ZkmYw"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C86EB4A;
	Thu,  3 Oct 2024 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981047; cv=none; b=b6T8ABp4b5+bswYWU8npUD60ScHmntTrAKVHXVN7NLSzyURuxIgeTfrIZ2a3gm8ZVEQQ42NE7AEsH2zUCIR3g0XYHvrh6ybzUJo+uoXRlR6QQy17JcpCeIPKgGMUHQVocTFraVPWKrIT8Iy3iUXJ2+o+R+ZkJ3j0HJRtsw4dLys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981047; c=relaxed/simple;
	bh=AohMEN6//bGwLbMRcFuDo/HMLCFf72VoCIMQubro9Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNEVVVqLjdh28JnRN5XD2vIdoWoeHvDtTqA0EHByPyhL1Xxb/4PULl7xgvR+IPARpo9+2wmJAf40JQBSIzlDBeq9LIurqqLeHT+YTmR71JF7HSH6JJzEw+xu/vD3W8Ag3yY67emidMUFMoNxBBy5EgPKJp6NntsOsFpo68Qs0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eL+ZkmYw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718ef6a26dbso64061b3a.1;
        Thu, 03 Oct 2024 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727981045; x=1728585845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnBEBEIYa5oSJNvztsWVVc0YabLIFyfFtgDbS8eEAAE=;
        b=eL+ZkmYwBEj0hj3pphUtKUUY59/zC25W8ToY0jC2Y7340cDhfOzVnF/z0XK0oHiH2s
         VH4t6gM3qRr26viHvDWXPryHy4n2cg08buIyjLT2uQMTS1B0Agc7NnDKeuytv1ejV+YD
         EIvPZ2ES5J/w2/O41WRXXyD8ccF1NeT25AjsExM7UH9pQqGbAOlBomkJECqQX6hCz5Vs
         PFW8PEcr/7evJVhyUi4gjaX1l3DCboZb96LQg61JRmwPw8dKGsJR42nzp3DOKHAGXZOQ
         go9ZGG+bBoKpst+dnArO+jFR4Zol3SBczJxow5Dl4RvtGOLCKmPCpH+EUOke0OgRsx+L
         wRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727981045; x=1728585845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnBEBEIYa5oSJNvztsWVVc0YabLIFyfFtgDbS8eEAAE=;
        b=DGPmRDU53LRMBbSs8VZ/hsfe1MgbWN8oDd68R4YsNKzosSX2As0J2PRsbxnURjCPAu
         x0vv7e3bFs1W7mOT3dfzg7ae7wd/xQHAvM0/9XJsUwcrqKPwLECTrzV3sF04BY0oBYY0
         RyvJcErresjCPqtOLTsXOnNrHPrdDo8uvyaHCGf6K3nxKpjxoYhRmjkxHmBgWGto36/e
         Fg76BCc2rg9wMhY1aVHvs1vCHwL5p0bu/RJ4CXQoevnfFzmNItWT9uZStLTVX9uaCpfN
         bunsWViLWQwdM3t+Z9TFWhjgdcg18LCpalpFm8E7bVTWhb2DX+/kNsks94nLnGFIxoF8
         874Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSeshtvgzo9VrbmVw9WPe/zl8ERQO+uMZFOj7L/upuSh8ibjzTlMTnM0jDBBkkU/ymN2fYea+Y0VteHxa5B1g=@vger.kernel.org, AJvYcCWXYEJQoRueWQ8bA0irn/Z8/RlfarRtKw6c06pj0Gcd1HnkZodQ0NzV6hVyX62J0BPkiEb1zzuSt5xq09I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXVmbEyaRJ4vG2+kmbnHun38IyipmlnPgzcCAqK4mKNMjTmU4y
	GixoZmaPtkOnYHDDm3EYnjAJmyX6vdF83th2OcXWD6JOfYdhA4kHFTW95sNydrl4YDYzQOE7x+x
	ikDih0WOl/BKeOcdteKLbVNkkshQ=
X-Google-Smtp-Source: AGHT+IGkMX/n88gTuOQgSAEyHpcdoHRMJhqSDTvkr4IaK1p75k5TAFT+NTfKcVsqg5Fe6N2QdRLLvDfUZu6Mjl2Zm9Y=
X-Received: by 2002:a05:6a20:3942:b0:1cf:4fc0:4ad4 with SMTP id
 adf61e73a8af0-1d6dfa3bd54mr164516637.6.1727981044848; Thu, 03 Oct 2024
 11:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-13-ojeda@kernel.org>
 <Ztk/rn+wztXYVTtd@gpm.stappers.nl> <20240915001035.5fc4d4a6.gary@garyguo.net>
In-Reply-To: <20240915001035.5fc4d4a6.gary@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Oct 2024 20:43:52 +0200
Message-ID: <CANiq72k4X2OUBwLZ9BMHCDtfJfkWrLsMm0T6RgE-4J9YOfHvHg@mail.gmail.com>
Subject: Re: [PATCH 12/19] rust: replace `clippy::dbg_macro` with `disallowed_macros`
To: Gary Guo <gary@garyguo.net>
Cc: Geert Stappers <stappers@stappers.nl>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 1:10=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> `#[]` would apply to the next item/statement, and `#![]` would apply to
> the surrouding scope. In this case there's just a single statement so
> they should be equivalent.
>
> Miguel, is this change from `#[]` to `#![]` intentional?

Yeah, it is intentional -- it is what the last paragraph in the commit
message refers to.

I think this is e.g. https://github.com/rust-lang/rust/issues/87391
and https://github.com/rust-lang/rust-clippy/issues/10355:

    note: the built-in attribute `expect` will be ignored, since it's
applied to the macro invocation `assert_eq`

In addition, `disallowed_macros` also has some false negatives I
noticed back when I started playing with this:
https://github.com/rust-lang/rust-clippy/issues/11431

Cheers,
Miguel

