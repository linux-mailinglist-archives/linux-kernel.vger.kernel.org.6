Return-Path: <linux-kernel+bounces-551170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53781A568F3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADBA1898AC5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC9A219E98;
	Fri,  7 Mar 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZYYqeHhC"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1130218858
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354134; cv=none; b=DAhZQaGvILp19yzPoDNtjsj4Wlw9qU7xZTLv0AE0SfjLYwU2+t2dwfrxFv7+kWipwOwBkp0CYzIYpxZzADPTaT1q/XoukX0bIYHDJRcFn/rrWwNlEOpe8oz+Iz5VI8bVZ7J7EVCLlhrbwkjDJKAeSLkaYQih+byP8OFZjzyGEJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354134; c=relaxed/simple;
	bh=ZP4tF3IYTfq5xSiI9AaVT2LKtPF5DFRmrGdG+HiAB4E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5bQJOGZx5A9alHOD6vdzOUG1/+el+G2HbwD7ZexinUEQRpvfZYxdn6H65tJlDWQlqHHe7VpsBqVLBurpmFGe8DXVxG6qVfkWdH9R5WxFFmpiZS8t0JU9+eWtmwiO1zeCDJM3p18HrBUpd6mX2cIf0mUFxch07PQSckYmHkrhPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZYYqeHhC; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3ci2nq23nzggpoigdqxlpz6ksm.protonmail; t=1741354129; x=1741613329;
	bh=Pr67z88ZqJT05+daJYJqoFoo2M9hUk/OxmbiH7Ad1eU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ZYYqeHhCeJgXZa1yHOjFFGgM6KikKKFjGiSi/0LPxsjoTJIThI6y/JBnezVAFwCot
	 vDqpIhpfbAJvNt9742uEqNxLO/gYE0udGIVYf+lVshxRBUBEc2a6wd+kNNPOQE9Alo
	 qpwwTHUacCDWMYKIACudyOV8OlwGVxSH8gR8rMk18WHj64GIQ/0flkHs8457GQvbEm
	 7r5Vmrug40/bDECQXiHx4g2UeNkFa69M6kXzpdb7A2nVFRckEL/aubWue+jKOl7iZu
	 fBwDdGE+rfY3fCbV+oabpSSECMOZUinxBOcKN0nRkw5/dCqesYCyxRhw7+fdi69u9Y
	 CWYeO9+95ECxg==
Date: Fri, 07 Mar 2025 13:28:42 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 13/13] rust: hrtimer: add maintainer entry
Message-ID: <D8A2IL07RV9S.6RF7B9326WFL@proton.me>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-13-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-13-0cf7e9491da4@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 75568d4cf981d5e2b22a0c592d439af24e8f337c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
> Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. Also
> add Boqun Feng as reviewer.
>
> Acked-by: Boqun Feng <boqun.feng@gmail.com>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

I don't recall adding my reviewed by for this patch (I normally don't
review MAINTAINERS changes, since there isn't anything to review). And I
don't find it in lore, how did this end up here?

---
Cheers,
Benno

> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  MAINTAINERS | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa065..ba8e802faabf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10355,6 +10355,21 @@ F:=09kernel/time/timer_list.c
>  F:=09kernel/time/timer_migration.*
>  F:=09tools/testing/selftests/timers/
>
> +HIGH-RESOLUTION TIMERS [RUST]
> +M:=09Andreas Hindborg <a.hindborg@kernel.org>
> +R:=09Boqun Feng <boqun.feng@gmail.com>
> +R:=09Frederic Weisbecker <frederic@kernel.org>
> +R:=09Lyude Paul <lyude@redhat.com>
> +R:=09Thomas Gleixner <tglx@linutronix.de>
> +R:=09Anna-Maria Behnsen <anna-maria@linutronix.de>
> +L:=09rust-for-linux@vger.kernel.org
> +S:=09Supported
> +W:=09https://rust-for-linux.com
> +B:=09https://github.com/Rust-for-Linux/linux/issues
> +T:=09git https://github.com/Rust-for-Linux/linux.git hrtimer-next
> +F:=09rust/kernel/time/hrtimer.rs
> +F:=09rust/kernel/time/hrtimer/
> +
>  HIGH-SPEED SCC DRIVER FOR AX.25
>  L:=09linux-hams@vger.kernel.org
>  S:=09Orphan
>
> --
> 2.47.0



