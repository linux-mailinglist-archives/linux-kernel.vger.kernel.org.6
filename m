Return-Path: <linux-kernel+bounces-553054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54159A582E6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3046188D817
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72CE1AC892;
	Sun,  9 Mar 2025 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Yh7IzBzw"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5572D78A;
	Sun,  9 Mar 2025 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741514886; cv=none; b=Lal2+ekvNWj6TmisLexZ0OoD8fCf1JeyOAzAe/R4LJwhEiBco8DzcTU0YiLb7oasC26BDidZ/frry+aOnUAbJj1syiSYQR/kCNCXe0iHgiMS37Kqcui+HyfvQBQ+lJdo5CZiPq8DaWSuB7fhgLKry0EmjWJeVLnC7P9I79dWbho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741514886; c=relaxed/simple;
	bh=c2A+klZSExiNlAPxwhyn4LEUeTLm6oc9Vq+3xf0qWtI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyFsmPW+IRbtHWbSJBMPLE1sEC9EuFOPbTlln8668NkSLnWG6Uvnx0uc7ZxNcxvCy0LxySdsFnFjyqj9yQdfXPDnQVSP6zAaocyF7NfuBjqKKF0VMRF12z15/0XvD2C6ZTyH5T+QaMUQbSSDymiYpw5ZxIhVpZChx2XGj/V6+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Yh7IzBzw; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=cqofltruibdaxnwyzyaonfgzsi.protonmail; t=1741514873; x=1741774073;
	bh=JC50hFgaV7t1nHyD3ez0xSaJgOLl/XNBm3Aok157kh0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Yh7IzBzw0Untx/7BS1Il+MRdEU+vZW81F+oQLTU/E3U8obpd2LIZeN16/XKr9jo90
	 nAOfFRQkGzeDoxOTVAsVX7g7/efAFqsau/7sCZgVPf3ReU2H5hnMmjJXxqcGUmKkwi
	 aKVurF2IcThzgrLTb1CIW2QJ6qPeS+JAIIb+1FZqgJlgT2GEoJvu+6/MdjmYW2pdiJ
	 vq+HOd6Wf9/DsTTOwSKlnDquRJg6tVneplWq3BwlIuFCv6ea+koZ1/VzRjvUaXjWxe
	 Q8zpPFSuaepEWxXSG5HaD3FjxqjCqm1/4eiYKXafgeXsSoaGyAAzKKkA6eaeoI7BD6
	 ++u5twUgK80iQ==
Date: Sun, 09 Mar 2025 10:07:48 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 07/13] rust: hrtimer: implement `UnsafeHrTimerPointer` for `Pin<&T>`
Message-ID: <D8BNHVSS7SQ9.JDW5ORJQKYGF@proton.me>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v11-7-7934aefd6993@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v11-7-7934aefd6993@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: fe94d37c54ae6d676bafd89cf45986e3f2853aa0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 10:38 PM CET, Andreas Hindborg wrote:
> Allow pinned references to structs that contain a `HrTimer` node to be
> scheduled with the `hrtimer` subsystem.
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
>  rust/kernel/time/hrtimer.rs     |   2 +
>  rust/kernel/time/hrtimer/pin.rs | 104 ++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 106 insertions(+)


