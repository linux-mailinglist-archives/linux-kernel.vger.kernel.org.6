Return-Path: <linux-kernel+bounces-362918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFE799BB2F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 21:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47C81C20A15
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 19:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700AA1494C3;
	Sun, 13 Oct 2024 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYe/s0EU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q7NGCNrk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FED126BF2;
	Sun, 13 Oct 2024 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728846364; cv=none; b=ffQuQQvYcOVmOWw9Gc96cvsl/bbnj6a5Uqr2w6dKg1BTs7nhteoKv5OwCCG07iw1qJ3y1HEsfUYbiEJHl/Zt3tAgOBgO8g2zF4zC94zf5MMPoT2JoJx9cLBfnhlZ24SPDBHAhO4gpZYIT/XdDH7st8/FNpAo2oK5bvFEeJTB28o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728846364; c=relaxed/simple;
	bh=LWUt83+72p94OQBvu7LDpY8JmXsbW3JX7rQCpLqvzIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O1iphNzn8WhEWsYHtgA1lpjnZTtGs4nG/knkRLVg9iasoaSQn5k/rCf8mwtRnHYATDURVgbWJUirTqkD4wAPqBuEyLhfe0ydbLtrq1GaExAfXZ4OhCaEz0BB3GcdNi/Giz8P9qIkfE0FrQVpG2Jle2ljlkEbaRdFmWaDnYOg+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MYe/s0EU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q7NGCNrk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728846361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HX93gLvvVYNZTz0n+RbjU7CdU6pUjX+YaKABzt1dakc=;
	b=MYe/s0EUp/S+Yz44ZaJ36e1oIv8xGSCGMxaGq+6RAoHdNouIo7z/XKX1El8qcYRPXHh5kf
	9zD/f0YxO0m5tzt6SWEDgYn0ZoCYyXWAiv/DxT417mTOcOjbkyXwprI+7UBk+aLhYetB3c
	wRsS2Ns8gTmG0u7ETyIsf/pHaTNXxohl4McaaiA7LFQRySG107KfTARAIy3T+JUQLpc8NO
	OsIy5HBGIANNVYRa2LGUP5eT9mugmjscxJldqZnYj8KIsmoEAB6NZGiyiFEotaEs4L8NPz
	Z9Fx5z88+VSxaWYHJpWqbiv/lfkD59xcmpLRxB+bbXyy6Jjwj9QAg8N0rSGPfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728846361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HX93gLvvVYNZTz0n+RbjU7CdU6pUjX+YaKABzt1dakc=;
	b=Q7NGCNrkkzLxvrOMLOdfkpQECOBDL/DL57W6opOUV3DPXYc3zu80Qqah4+bvx57r8Oh/qc
	1Nk96r2amPDtUIAw==
To: Dirk Behme <dirk.behme@gmail.com>, Lyude Paul <lyude@redhat.com>,
 rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
 <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH v6 0/3] rust: Add irq abstraction, SpinLockIrq
In-Reply-To: <aef35907-b92a-4f56-a330-b4be06f11984@gmail.com>
References: <20240916213025.477225-1-lyude@redhat.com>
 <aef35907-b92a-4f56-a330-b4be06f11984@gmail.com>
Date: Sun, 13 Oct 2024 21:06:01 +0200
Message-ID: <875xpvhlgm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Oct 12 2024 at 07:29, Dirk Behme wrote:

> Hi Lyude,
>
> On 16.09.24 23:28, Lyude Paul wrote:
>> This adds a simple interface for disabling and enabling CPUs, along with
>> the ability to mark a function as expecting interrupts be disabled -
>> along with adding bindings for spin_lock_irqsave/spin_lock_irqrestore().
>> 
>> Current example usecase (very much WIP driver) in rvkms:
>> 
>> https://gitlab.freedesktop.org/lyudess/linux/-/commits/rvkms-example-08012024
>> 
>> specifically drivers/gpu/drm/rvkms/crtc.rs
>> 
>> This series depends on
>> https://lore.kernel.org/rust-for-linux/ZuKNszXSw-LbgW1e@boqun-archlinux/
>> 
>> Lyude Paul (3):
>>    rust: Introduce irq module
>>    rust: sync: Introduce lock::Backend::Context
>>    rust: sync: Add SpinLockIrq
>
>
> To have it in this thread as well I just want to mention the discussion in
>
> https://lore.kernel.org/rust-for-linux/87a5falmjy.fsf@kernel.org/
>
> which results in the impression that this patch series needs to update 
> `CondVar::wait` to support waiting with irq disabled.

What means waiting with interrupts disabled?

Spinning? Why would you want to do that in the first place?

There are not a lot of use cases to do so, except for core code.

Thanks,

        tglx

