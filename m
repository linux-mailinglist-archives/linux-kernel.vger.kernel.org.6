Return-Path: <linux-kernel+bounces-291609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D569564B0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB401F21A67
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2529E15820F;
	Mon, 19 Aug 2024 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NaC6+FVL"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33C1140E38
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052540; cv=none; b=hnlbu0i7zo4phxzgpNA8mSP8jXOTiNf0q/TcETIZpir5H6ptm0FLR/9UGfKFEi+K/OIERlug0QOVpdRdQmo8rwvsOzvLbbNLzCmYw2i8Wf/sL+owUMo70o8F5nct+pu2GRlGUJig9UwTgozo1Rotjw8vUVGUFmEHxpOqKeoupvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052540; c=relaxed/simple;
	bh=9RpqaSW3EP8+7YSs6+tNYph9FaHPbkC6S+ZfjCCWSvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Or4ZYMyK7lDye8BVtu7pm+XSpacSmhiYzCrK+MMOFc1StApCgev+KoFkB/Qqc/TH2l8QUa55lST5q7s3NYbcdUKHN0rxGos7FOeMqu3eK8Zgz8AY00MfS8JBRYsJCy6MtRbjVctzJ/toyCt5n4U5vFV915/NVJhFuy4umJAaRps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NaC6+FVL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so25680285e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 00:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724052537; x=1724657337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RpqaSW3EP8+7YSs6+tNYph9FaHPbkC6S+ZfjCCWSvc=;
        b=NaC6+FVLQE9PUe/A8woofJQkxb4eRv3AcLCZMkmdButhE88Z0m5AoM8dohL7qTd7UH
         4YGh3ZzaxwCTSmc6BTbZhEygtGTbfXudLqwwnBPRm8Re9w66mA2xStkcIW2eWVlS0XuE
         IGJN5oQNTj4O/knvnwWQVGF5Zm8DMqtD98MzCHDbxbpdFBLtvjmAvYAPO65OYU2ljoqo
         Q+p1ZZtiVKwUcn1KKF1uKBtPzvC24byYZa+Z6Xx5uY2aSleYQC05bX3rXaxL9ndMyFYW
         yuON27L2OVBfnV9PfsS0U5hDyP0atGUf9eQ2Xe6/cuEFJDw+Tp5kTBhB4iRlXPo9EgFE
         sdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052537; x=1724657337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RpqaSW3EP8+7YSs6+tNYph9FaHPbkC6S+ZfjCCWSvc=;
        b=j2dzlW1eMasTf2gIZ1+aWzuyOn74R2TuPxw8UcB+r7rAeexXCyBxp8uN2n2SnHE5BS
         QR7SCtfcKmIiYiCT+cazlHRjHFbCPmcPGNn3B/ifVTG3iRaAaxK6fs12PvxhdmCBCfWm
         9oXs1KYLB22gobGpxmG6ymhTXXU+R/TdhOiHt1T36yqy9t/NA32z5Su2MfLR98GXaoI1
         CFpC3ldz75nyfj/6Jw3xyFe7XpA0Ybsk8AUNwi7zEktGUfLns7/uDjLd7DrWLD0MY0MT
         brbhsRD9pZ0K7Mp8ddIMyFKpGlmyl4BtaUX3Mw450qih8zErssI3Vf3FNCf3b6AiMNvI
         2rIw==
X-Forwarded-Encrypted: i=1; AJvYcCWeG03V6xv322VmV0IFNbcPsFuD2B9i5+io6gv4hLJl+bg5+U3wJ3hH0ZAU7pUO6dzPGp0Lav5Ipsen6k7ThVXuRw+NAiARm2xz9ZiI
X-Gm-Message-State: AOJu0Yyd7GXNfA2CqatWUK6/E/hhA+DNMDr71drfQKQ0al3/lSSHrwFR
	7fmm/iIbw/wTG0PCIrdOIvSArWynIj2XA7JE3bLJjB6GrmkgWC29/3/1BUiaa1Y9qLmuZoNPcJJ
	7rH1pecX3QU7T2dvN0UrrHjtTitZE90sMyzkA
X-Google-Smtp-Source: AGHT+IFbDPWP+j/rqNlthxQd7CrAdmAs9wRe0NTha3CeBwITtFOy28z/1Ffe4WKvnY7vqXrMteXUHK3icZnMnT+QQxY=
X-Received: by 2002:a5d:49cf:0:b0:371:8ca4:1b76 with SMTP id
 ffacd0b85a97d-3719465b8fcmr6024363f8f.32.1724052536815; Mon, 19 Aug 2024
 00:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808221138.873750-1-ojeda@kernel.org>
In-Reply-To: <20240808221138.873750-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 19 Aug 2024 09:28:42 +0200
Message-ID: <CAH5fLgh9Moq_9M+zMu300ohK=mPqkLyS6cpQ6An2Q3THCPFjaA@mail.gmail.com>
Subject: Re: [PATCH 0/6] kbuild: rust: add `RUSTC_VERSION` and
 reconfig/rebuild support
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:12=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Hi all,
>
> This series introduces `RUSTC_VERSION` support, which is needed for
> several patch series getting upstreamed, and it will be increasingly
> useful as we now support several Rust compiler (and `bindgen`) versions.
> Later on, we will likely introduce other macros, such as
> `rustc-min-version`.
>
> In addition, the series introduces automatic reconfiguration and rebuild
> based on `RUSTC_VERSION_TEXT`, to mimic the C side, which is also good
> to have now that we support several versions.
>
> It is based on top of the current `rust-fixes`, since there are a couple
> pending changes to the version text Kconfig symbols that will be sent to
> Linus soon for an -rc.
>
> Cheers,
> Miguel

I tested this together with Rust Binder. I also ran this patchset
through Android's CI setup to verify that it works in builds with
CONFIG_RUST disabled. It passes both with and without a Rust compiler
available to the build system.

Tested-by: Alice Ryhl <aliceryhl@google.com>

I'm happy to rerun these tests for new versions.

Alice

