Return-Path: <linux-kernel+bounces-565909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE90A670EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D7019A15EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A6207E0D;
	Tue, 18 Mar 2025 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pQdsj08h"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C5207A01;
	Tue, 18 Mar 2025 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292887; cv=none; b=GbLxIBroaGQJjtyyue3HbUHIZZB1KhnO1useIJd2kSdCgbkitu3g7QXI/qPcV5CS5L5GxvHlZSTHYIwd6dJUjKYyQxgctv3gZRLLQgNuJS+6LyEB1d+IHaeFT3tG0xoHA4LeK7pw3IW79EXjHmHHYk4a/aDtiZUlLpFlDNF8Zlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292887; c=relaxed/simple;
	bh=RU1GG8P/fyn/N99uW51RxZ6VdojKLsD0tL5X3G1oLKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mKsldug2IDFRbElfvIJ5Ge6aAzdFcuqj/yYalgAaXg8owq1SfvbZmYS9hGaVI95YI5CTDVfHZlhQ99i08AVNt67fpKkLeuele52mOZoTAGX/muW0GYg1ACAWTfx8Vy3hEms19uA2LzVPxqp1rL/eY4MfH+0ixIapm5ocLFJIjrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pQdsj08h; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RU1GG8P/fyn/N99uW51RxZ6VdojKLsD0tL5X3G1oLKI=;
	t=1742292885; x=1743502485; b=pQdsj08hCTqaKqY3VgKEan977qCht5QDQbATEJrjz79gFiq
	xKLhtv74r9JB94lpAbtAQQtfJWrra/ODf3GOD6T5q+RxqwZrhvlK28SxrmyePXvBW4gLLZM+5v++W
	zuTHgO3+7PXfHGByaq2kfz5zane8JxR4+SpU4r7/vaW8RXfntHXDBQMbwZZdIE571MZcDA2LMTGSq
	6t4Wa3tA91kfu2hhZ34DT2duQEOY4pe7tsB3PXI8se4rN0YdaajQIYMbUNanYWWu9re5zb27TIM8t
	PSMYTQ2mKifgsO6sb+K9lGAulQtaGlwhGKRfEAlyhsYwLz2CnX5yKSp6TUXITnVg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tuTxt-0000000FD90-1rsq;
	Tue, 18 Mar 2025 11:14:29 +0100
Message-ID: <1a1ea09ae8cd82db0b8c3205bfd179bacfce4700.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] rust: pass correct target to bindgen on Usermode
 Linux
From: Johannes Berg <johannes@sipsolutions.net>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, David Gow
	 <davidgow@google.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
	 <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>
Cc: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Miguel Ojeda
	 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng	
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich	 <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers	 <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>,
 rust-for-linux@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Date: Tue, 18 Mar 2025 11:14:28 +0100
In-Reply-To: <CANiq72nnwopFAdETMhgkCfN9dj+JJZQ=K1BKz_A_xUViis7Avg@mail.gmail.com>
References: <20250208-rust-kunit-v1-0-94a026be6d72@weissschuh.net>
	 <20250208-rust-kunit-v1-1-94a026be6d72@weissschuh.net>
	 <CABVgOSnwkDihbRzYF3uh3At_x0MgOB42_E8sUAD8moKwx+zjRw@mail.gmail.com>
	 <CANiq72nnwopFAdETMhgkCfN9dj+JJZQ=K1BKz_A_xUViis7Avg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-03-18 at 11:10 +0100, Miguel Ojeda wrote:
> On Tue, Mar 18, 2025 at 9:07=E2=80=AFAM David Gow <davidgow@google.com> w=
rote:
> >=20
> > Is there anything holding this up for the upcoming merge window?
> >=20
> > Miguel: I'm assuming you'd rather take this (and possibly [1] as well)
> > via Rust, but if it goes in via the uml tree, that'd be fine by me,
> > too.
>=20
> We try to get arch maintainers involved (and everyone else, of
> course), i.e. it is up to them. But I see only the list was Cc'd, not
> them directly, for some reason -- doing it here.

The list is fine, but the patch wasn't even CC'ed there, so we don't
have it in our patchwork:
https://patchwork.ozlabs.org/project/linux-um/list/

> Ideally, maintainers get involved and pick their own Rust-related
> patches, but I can also do so with an Acked-by from them, which would
> be nice.

I was just picking up um patches, but given that it was a series, and
changes rust/ rather than arch/um/, I think it's probably better if you
do it, so:

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

