Return-Path: <linux-kernel+bounces-551154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A390A568C4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE9416989A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A13C219A64;
	Fri,  7 Mar 2025 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Lo5ZPRF6"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8683F1E1DEB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353763; cv=none; b=ViHUz8vKZHdCNyjSsfnKbOaJqGoTRTaTbGVDf1u0Exe3y1nBO/gNHVD2T+GzsYnErdOI36Up5zhz7w/+cb8QpaDOK6Op9N3mNFBY2R/z5JkHudJb/fzfmfUJc8tFrGUQ+iWc/xJQR9mrIuci22mkL8MHSVL4aigxvYrSVewKfZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353763; c=relaxed/simple;
	bh=+qCe7WBTKUohVXUdu6G/wFKNi5eJP34DteZiEWk3fe0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrjGI3r8YUisSdKni6UMHOj/fyxfMZ2p9sGbKDYHOpC/H+HHtf/acUtYzG/J/tTPU/+gqEKlXq+74xnWl3p7QgU2pWYjCFpeWoTf/O98Rr2tj8jJPwylrzKzP7qvwADrXWZmA2R2xErAzBnzW3pE0SX3TcMtwGT3ft8P+tiWRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Lo5ZPRF6; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=fp3ubbyvt5hw3nfdwfk3gybux4.protonmail; t=1741353759; x=1741612959;
	bh=+qCe7WBTKUohVXUdu6G/wFKNi5eJP34DteZiEWk3fe0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Lo5ZPRF64O1YK5ceOpbPmTt69Mwd5hUPAFe5xLztox90JUhcNMiiBm78z2vZRYWsn
	 SglVF7xj+FkOMtHD6ljNzJwjHYUAtNfLx6PXgAegw4R4KtZXhPr82OjYKSu/7Wf10P
	 B8+rzvj9e+N/KhLwxAuo3L+uH12iCgpoaFn8y/uLgBQ4v4eflRJVBXWvlWXlz60yuQ
	 cu+a6O2LGoFH3YRg5ZCLYyFqMXgaPTaGdN48vs3fcd+9fyDKcNCOK4YG//A60nm6Wt
	 6kvzcZEuyhVnV/y5as6ltBhgEUP366VESxfPdOSTBPNuClIX5J5fUg8NIG1IoCz/uf
	 smFTkd47+8c1g==
Date: Fri, 07 Mar 2025 13:22:32 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 11/13] rust: hrtimer: add `HrTimerMode`
Message-ID: <D8A2DW4Y4XPD.3RMLRIZWF10U@proton.me>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-11-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-11-0cf7e9491da4@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f44b3e2c1a9cf3ddff3bdf72c444a75f278b177f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
> Allow selection of timer mode by passing a `HrTimerMode` variant to
> `HrTimer::new`.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


