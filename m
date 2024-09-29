Return-Path: <linux-kernel+bounces-342793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E859498930E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25AF01C2296C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B232126AE4;
	Sun, 29 Sep 2024 04:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="JEODW/Xv"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176DD1DDD1
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727585307; cv=none; b=Z49OG4W+zLcOz7YtVm2wJUJVHPoPwr/tGcQ1kVTawFxbO4ex/NmWXSnl8jDzRq8KpYiztEowk//f17N+v0/n1wEAwi+C0wK17s6Ocz8y+0K/rkwEw+9ykxDWZ6kPvKZ8vqZfW3/RXxrmFi/9nwdxYzp6Bi7dUSO+mLw41mZKBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727585307; c=relaxed/simple;
	bh=CIZA0W2qEjnnGnJknm1V6/RmDT3YVjysHtUxWt9fnhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqEkjhHXIdUYTgjani04TlxXS3thhjktAn3khmryyuHEQAMy6LdwrlifiyEZ8RV3/DME6ljHSmt3hGVYp4ZDleK/AJhOPSFOGDMUh2SJDTh7HDUnrJoDn3STRabIs+y1r6cWLD1V+aEyTgBj6q0/kJOISAJtYsX6wJaEYf2Yqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=JEODW/Xv; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e22f10cc11so27052397b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727585304; x=1728190104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIZA0W2qEjnnGnJknm1V6/RmDT3YVjysHtUxWt9fnhA=;
        b=JEODW/XvnqPjlLvPzYX1Ca+uAuaqkZxJtY3BGPEZGcn3/afVx/C6MtQ83OempD5iR5
         ZFv2ZZWPNs3PmNNHpfJERPcx9RQSOR4nECWiGm2fe3OpwHej9pXH4Er/GgVMgupbdDRm
         BM9iUQWTY0+bymuxJKU61K2CN5Iv9PqdRR/16r9+rbRjg1LYjxg1opgn6f9xjdn1sXTB
         KS8gGfvfQzBdmhGWsqlkt2p/ib0QeUZGUsgiqmLQr4icKuiW/2N+OX8uGm2xSMrwFJZn
         L0VWwWjhLVf2PW7E7Y2X19VBnUYfU++CKkksnr1uzWv/1eV9Atj5eWE7vZv6K+ptLfZ4
         mAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727585304; x=1728190104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIZA0W2qEjnnGnJknm1V6/RmDT3YVjysHtUxWt9fnhA=;
        b=tbSJyUb4egVfpeH6rCMh2R1vRD57dujK0IGSAR0gsqpwif/YoljoV+sJOOXdI3SZmC
         KBg4DpIKOJ5D2PcqHzPLJhoz8onFNrhqzWsWNgD7b6wZmKsGk8lkf3Pig4eE8zl2ygtG
         n8LbvaE1ncuvRAgfOpGk97gmN0rdC7X57YnMSiXVND0oQ0u3KzOSpH8gUzA7I/kuWniK
         WHdxOiQUimL0FTIwJ0TeDJ0LjAasjmFsAr5VZGdS7QuU6iK1NxzRefKXp+YzqOqlGMTm
         2sfJYp0T68Zr1YOPXIXgJxxwq5NAafFsfe3eMuhGtG87er3fsmrLd/pvSm94MznzMySI
         WDfA==
X-Forwarded-Encrypted: i=1; AJvYcCVrbroMy17Nh8DSgq39Sld+8jVKo5h9EZwajudei+083SPKwMWqlL3sS+LUdmXPa9T37zbBIwe9yCuw8jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfwl6Y4iDPhmtrTEimyVervYNszA/5zXYPqzD3eSCmc+LmRjMJ
	AJ4AUvj62N9ZETXk2egY7IseYfzceJ9paNe08BFOvyuVIUQBMq1aR/WuT0mf7f/hcdIgSW8ACH1
	mOOAymJ2zKXMInKIDdGhrYpcSGD14zjUOW7A3qw==
X-Google-Smtp-Source: AGHT+IHGLO8uFKk01lj+pc7xi5cN1UQcwjFwWI2vcUjxYujvaZ74Wt6ytZjstIUhVrZVb5X2wsWMAZgBbiwyKHg0/l0=
X-Received: by 2002:a05:690c:112:b0:6dc:d556:aef7 with SMTP id
 00721157ae682-6e24dc9c77bmr42360427b3.41.1727585303663; Sat, 28 Sep 2024
 21:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-12-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-12-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 00:48:12 -0400
Message-ID: <CALNs47uFsnrqetzZp58d_j4VO5y-LkiLejwp-NKAXQg7pPct7w@mail.gmail.com>
Subject: Re: [PATCH 11/19] rust: introduce `.clippy.toml`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Some Clippy lints can be configured/tweaked. We will use these knobs to
> our advantage in later commits.
>
> This is done via a configuration file, `.clippy.toml` [1]. The file is
> currently unstable. This may be a problem in the future, but we can adapt
> as needed. In addition, we proposed adding Clippy to the Rust CI's RFL
> job [2], so we should be able to catch issues pre-merge.
>
> Thus introduce the file.
>
> Link: https://doc.rust-lang.org/clippy/configuration.html [1]
> Link: https://github.com/rust-lang/rust/pull/128928 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

