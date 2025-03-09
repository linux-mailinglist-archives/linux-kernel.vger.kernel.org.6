Return-Path: <linux-kernel+bounces-553086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC541A58370
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B379A7A6D99
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190681DE4D0;
	Sun,  9 Mar 2025 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Nq+vRrzm"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0941CAA98;
	Sun,  9 Mar 2025 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741517311; cv=none; b=NOhUMCD2G1X0en6a0MtUMzT/+k5SBQinzeySqlvvPVWsZRiOBjlgxDFzG/TeWMvWE8jTpPvLKFahh0wk407CkTGUIBP8aUT9ynE8X9RWxCeuqjBQ54///t4+hlpNGJibnHdX2G/xymj+cMBpKk7uLcZ2uHIRziMkjFnh/IZXutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741517311; c=relaxed/simple;
	bh=TjZmsSHVn2SQaXWQ8Iww7+RL5TcnsYTFLjZk+aCqfro=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPcL9I+1PHYUl7yLGCeHFC9tUrO3Ddtax5ID7Ul5fAN6AdPKhtQm0UaBOeMA10gCHO5+6r7MmxE2WAk12Ht7Z06u2Gf24Lp26XKtXmfrwMamaL4SIjKn7gr7CnKiPDJZE/O89k9Xcy6Tyl+fH+PKeAwJrzW86JkU/hyR8ZrjicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Nq+vRrzm; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741517306; x=1741776506;
	bh=onuREebFVAgubtnf0xzHhQjePAlGKksLg0sZJIHSe2k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Nq+vRrzmSYbN67fo8nG+S4xwnmoZWxabsmSV2shfUTAsjBgYCh7dFeqTkksz3CRHo
	 z5A/sSHDdoSYBlffpKpZyO17VfWiK5pcEi6q/72dEOo9DzBJ1y6M7+b0oIeseFJc/+
	 JU34FVGgITf+kptigttGUemYp3ZCxudcPpP/pQvtLpxSNTsnJg0nWNbQ3hXsr7bhRP
	 rbKIwiuIJbhNTpnl7/tpTLS+zHdv82txDL7Mb70PDgnDmlPhnZ3MF2k53itdGJ6OaW
	 F3a1ZIX6HexQCs35+RuyBXmMMtl9Xo+QjEiB0xl0iTSZbWmyhDv7WWq0NaF1ZCDU0M
	 fAFenup7rduMQ==
Date: Sun, 09 Mar 2025 10:48:17 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 03/13] rust: hrtimer: implement `HrTimerPointer` for `Arc`
Message-ID: <D8BOCUZJCEVI.3JD6KJK3UTCKX@proton.me>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v11-3-7934aefd6993@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v11-3-7934aefd6993@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d7874bcbc129a3e3c118a19be8ed3c2630d93df1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 10:38 PM CET, Andreas Hindborg wrote:
> Allow the use of intrusive `hrtimer` fields in structs that are managed b=
y
> an `Arc` by implementing `HrTimerPointer` and `RawTimerCallbck` for `Arc`=
.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

With the safety comment adjusted as I mentioned in the other thread:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/time/hrtimer.rs     |   4 +-
>  rust/kernel/time/hrtimer/arc.rs | 102 ++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 105 insertions(+), 1 deletion(-)


