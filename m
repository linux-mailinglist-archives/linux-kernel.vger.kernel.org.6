Return-Path: <linux-kernel+bounces-541913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98079A4C34C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B457A283E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B410A139579;
	Mon,  3 Mar 2025 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRSTMxff"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9192B9AA;
	Mon,  3 Mar 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011793; cv=none; b=dYAembzq99tRy6yd78ABLHqTwZFTCJN3Slq8PMxALveQ6gJ5n6ZGjZ2CUTBQt5/LBfvTMeDJ3/ZXTYzP0el4YBi6LrROAdNDohzac7kjigD8/NBDV65GWKQbtNfOxY/acUJXy062BxKFAkoEANGaqSU1xTcGal8+B9lCovxmlqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011793; c=relaxed/simple;
	bh=pIJkqSLeUyRInezerfpiv4GfUMAC4on8F2v45PH/XM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hkrmnv2wTty4lF5Las0hBrLxV9KQLMjroNz07MGAHoldHm8tLHVJRwxD/TEZmXKc/4AJGeDzIJ852exum7JI0Pnt+5c8LF1ObciEzJP2tuvjaROStE1ctariYhkGveD+dZbEiTgYiD4urIryinLMImrzHVYugJ3IBGEvXhe32cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRSTMxff; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390eb7c1024so2495428f8f.0;
        Mon, 03 Mar 2025 06:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741011789; x=1741616589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mrGT9P3YIII/ik/a4tG5c1QPCrLv8EWAGnwxrm4FLFI=;
        b=VRSTMxff2ROwssGOVNjuDr2V8KiFfORhXqAtN7gmF2admZNGJmZRQxWLB+NKMvW8Lv
         iGb0Wy/wlkdHPlg4SHBpQD9Pgwc3Gq45lAv3y+4k+aRHtSc4OF/vb4HmxvxXyviStFGa
         wBWDX+S627bmG68FXSIlPYgqO3fgqXsfghkqLwB6Mjnp7LIcHb63HAWZfP5uFltwDkRP
         eQTwYo6urlJs4TP+YZBIRrpXya+yMMVAJaeznfRhexcdSI8V7gr5NuXl1xkIn3DKi2Il
         a/aJJfdBKBpb7O5yfKIsk3sVfJEChWpu0+xY8Mr1pm4jKlb8s0Pum/koQ1VstvJtyTsX
         mJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741011789; x=1741616589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrGT9P3YIII/ik/a4tG5c1QPCrLv8EWAGnwxrm4FLFI=;
        b=I/MF44qNxDxymHINaity++AZqRvnT/RUDKUy92zJq9XrE1z0WCke3DQLbSzi78tmS5
         PSGskcAzSjDjpXfD0YwCXC3EI2i4cT/K59aJgsLQ56/6gRAJb7RaklAGo9xVZ51uBVgj
         1sClqbffiXK3FSjmJn+rH6HNgOIspskIlKx9Z6HKir+2SdCykNgdNW1pvgRojoEUMP3X
         bWt8heR6Pz6Wqn78TtIhZXoBz3xuxckCMQqPN2ycoskiXBiMv+K73dOU5/dA9z2B4xTV
         dD9Sv8DQ/5I2l1G4b3VcASgdQ0eW6dwLN+SDKHVPz4Zsq3JGRx2MRXlNxJ4tR/U68564
         H+gg==
X-Forwarded-Encrypted: i=1; AJvYcCWbrm9hM51kPxGeyVDSqGjYjW/LH46nObrX30CTXJG/3U60p50RVT1Bey77PB0fOn+6goIfVqaGYsPuecM=@vger.kernel.org, AJvYcCXJ9eDV0rKwExHycLFbwzrRJsDTvtWrj3jego+NPZvFVLMsWrv6PA5xMSFhyTN4o7dwSb3CRliEEAaQVN1wvjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0I6gz72TvZJvlzk2/NdE5naA3Rz8thPTOkSQ0NyMxnCfkDipq
	cAkLnZX4m0DXOhTIUteFwWCFMRfaUrUS4XOyx3DjZEfRY9IZGrUu
X-Gm-Gg: ASbGncs993kbXlaUipW+1foPjMybYJ+vpERGnWxlx5boxNpNexD0Ovrlq/ZFRyY1kKI
	5qvLSGZdFF1pqZMvXaPGjLYOvf7c8k2yf4ayq/rckXjyiniM7PRzwI6sdAlCNp2FOKFRjXe6XiS
	IkFW/KLCpsCqhBcPOlwUPNvns+0pSIyiqffBZHznen1o++/aTyKydXz1hhK1na1cE8QoToDtxlu
	9qmx+ZGcPcpAhBpoLzF+clpdex8pYYAPi4N3tTBTYrEehPkmzJFDNBPu+9lR18x4ezAN6Hb6Nxl
	rGFq26/WjTkG+XGPXnA9JAKQwOtVzYP2gWmwimVGVcMn2Y/FTKaO7g4j695mRvCAu+oyBKlckf2
	cOw0OG0O0kBBl1valPSM/xlAFKoNZMe1xEyFRcpGYDCskgUnAFmsE8LiGKENV3wNXM1xc0om7/8
	6u
X-Google-Smtp-Source: AGHT+IHxdKpeKW+iuPDtegTXuf7HTIpCYH3Uf3Vd0h2zHZE7LvI/t8Y5S2/PEiWD4OWu/II3SjRc3g==
X-Received: by 2002:a5d:5f4c:0:b0:390:fd7c:98be with SMTP id ffacd0b85a97d-390fd7c9b46mr6237286f8f.19.1741011789369;
        Mon, 03 Mar 2025 06:23:09 -0800 (PST)
Received: from ?IPV6:2003:df:bf24:2700:73f1:1935:b744:5d51? (p200300dfbf24270073f11935b7445d51.dip0.t-ipconnect.de. [2003:df:bf24:2700:73f1:1935:b744:5d51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4795978sm14341725f8f.3.2025.03.03.06.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:23:09 -0800 (PST)
Message-ID: <daffef96-7c50-4162-bd93-e7bc20af9ee6@gmail.com>
Date: Mon, 3 Mar 2025 15:23:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 8/9] rust: sync: lock: Add `Backend::BackendInContext`
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>
References: <20250227221924.265259-1-lyude@redhat.com>
 <20250227221924.265259-9-lyude@redhat.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20250227221924.265259-9-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.02.25 23:10, Lyude Paul wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> `SpinLock`'s backend can be used for `SpinLockIrq`, if the interrupts
> are disabled. And it actually provides performance gains since
> interrupts are not needed to be disabled anymore. So add
> `Backend::BackendInContext` to describe the case where one backend can
> be used for another. Use the it to implement the `lock_with()` so that


Use the it -> Use it (drop "the")?


> `SpinLockIrq` can avoid disabling interrupts by using `SpinLock`'s
> backend.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/sync/lock.rs          | 26 ++++++++++++++++++--
>  rust/kernel/sync/lock/mutex.rs    |  1 +
>  rust/kernel/sync/lock/spinlock.rs | 41 +++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index e7c1fd028435e..54c77972c83f8 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -32,10 +32,15 @@
>  ///   is owned, that is, between calls to [`lock`] and [`unlock`].
>  /// - Implementers must also ensure that [`relock`] uses the same locking method as the original
>  ///   lock operation.
> +/// - Implementers must ensure if [`BackendInContext`] is a [`Backend`], it's safe to acquire lock


to acquire the lock (add "the")?


> +///   under the [`Context`], the [`State`] of two backends must be the same.
>  ///
>  /// [`lock`]: Backend::lock
>  /// [`unlock`]: Backend::unlock
>  /// [`relock`]: Backend::relock
> +/// [`BackendInContext`]: Backend::BackendInContext
> +/// [`Context`]: Backend::Context
> +/// [`State`]: Backend::State
>  pub unsafe trait Backend {
>      /// The state required by the lock.
>      type State;
> @@ -49,6 +54,9 @@ pub unsafe trait Backend {
>      /// The context which can be provided to acquire the lock with a different backend.
>      type Context<'a>;
>  
> +    /// The alternative backend we can use if a [`Context`](Backend::Context) is provided.
> +    type BackendInContext: Sized;
> +
>      /// Initialises the lock.
>      ///
>      /// # Safety
> @@ -170,8 +178,22 @@ pub unsafe fn from_raw<'a>(ptr: *mut B::State) -> &'a Self {
>  impl<T: ?Sized, B: Backend> Lock<T, B> {
>      /// Acquires the lock with the given context and gives the caller access to the data protected
>      /// by it.
> -    pub fn lock_with<'a>(&'a self, _context: B::Context<'a>) -> Guard<'a, T, B> {
> -        todo!()
> +    pub fn lock_with<'a>(&'a self, _context: B::Context<'a>) -> Guard<'a, T, B::BackendInContext>
> +    where
> +        B::BackendInContext: Backend,
> +    {
> +        // SAFETY: Per the safety guarantee of `Backend`, if `B::BackendIncontext` and `B` should
> +        // have the same state, therefore the layout of the lock is the same so it's safe the

the -> to (safe to convert)?

Cheers,

Dirk


