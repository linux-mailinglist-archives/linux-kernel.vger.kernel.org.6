Return-Path: <linux-kernel+bounces-553076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5437DA58338
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375243AE6BD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0321C5799;
	Sun,  9 Mar 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BFJcg3i0"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057191C5D44;
	Sun,  9 Mar 2025 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741517199; cv=none; b=X4Ub5pWaEhM7afC4La1diHJB+yaJnS/VJ3mcwZvo7eYzaeLtRC86CTp+m+NMdkLXDpvfPXMuUeTjwRKIctlsc0jbCDwQ5CacqFuqQJ89R480DU4wMC+YKlRAREhtvPlXaxDwe/Z2ho9MgssfJq66YDWEPA1pZskpxryBSpZOAYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741517199; c=relaxed/simple;
	bh=K9bwZnbaYdHSuSAVeV0+hTESIYX1CxBK0FUvducPYZc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHmqsENGLhdgoZHOF/uQlcrPY1mDqfsG/hHHA8Xi24WATHdraJBPaSaokdiTrkMLzuKDVt4ADTqNNCsE1rPVTl/OqMc9WGU4G5UlrjuJHTChyjLQNpgPLfYBUW6DdHUkmtjKh/J5hpcGKZ8ZD551mnMhbQq6rK4OOa1wSQ1VRR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BFJcg3i0; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=mf7c7zjixvfpfdegtz3lis33je.protonmail; t=1741517194; x=1741776394;
	bh=5xhYrjSTqoAtpk/MmRkmGqw7guw56xwxoOH7W3SVX2w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=BFJcg3i0E2kuIx3svhplMxSu7NtvjIC8aN0P3PtOg77zRJUbLMX5ga+UmGubXAM1q
	 qr8uu5uaUKK0nffNT8SMUdO+OtftUFTCl1t5j4/La5NL/bY4QFWed4eLxH/5Z0q4e0
	 A7MUnmPMFHcUKUataeEnoptcT/DDIMpHwSCrJAm/NgCpi+6G5amB3Qt0mXsApoYC9c
	 ei4RaZvdkF6nriq5nArGT+Npn2eqKUIR6QPadtj9lxhYkj/95Tx8dCJQ4G272dRGoZ
	 5XUwS6dzHCIouYv3xoqtWus532+S6pig84VuRbGNMVdG6genFkkb71ORSgVotvrM8q
	 AbKv8mY7fNbFQ==
Date: Sun, 09 Mar 2025 10:46:27 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 10/13] rust: hrtimer: implement `HrTimerPointer` for `Pin<Box<T>>`
Message-ID: <D8BOBGBX8X4S.1L3PO31142PE@proton.me>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v11-10-7934aefd6993@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v11-10-7934aefd6993@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d07c69c4a717b2b7ba69da8b7987bb6618b20b39
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 10:38 PM CET, Andreas Hindborg wrote:
> Allow `Pin<Box<T>>` to be the target of a timer callback.
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
>  rust/kernel/time/hrtimer.rs      |   3 +
>  rust/kernel/time/hrtimer/tbox.rs | 118 +++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 121 insertions(+)


