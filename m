Return-Path: <linux-kernel+bounces-323152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7894C973895
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2431C246B9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCCC1922FB;
	Tue, 10 Sep 2024 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iU5C/C4l"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47267137772
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974836; cv=none; b=SHj/7aqv9l4ybkb8ElbaPTHNgJK998xXMKNNdlkZwT8hitJTElm2K8+xHwbszvI6biBDjCsSTFDTy1CzgwJGGmMGf7wmro4G1wzDz4GQuikEvOBW6i98ywbDXhL0De/pgcT+jfwcYxVfXtOYBqwZApiHTC6oAu4pt+/S0caIsjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974836; c=relaxed/simple;
	bh=59LhVAIff5XFYxepQj3fCMMGfNu38AxikS6S1TnocIU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTLfOUVpHRtbyi2Ro7gz98nGn5s6kcDglPaRqO/SgOsJDh8dWMRTGtYe9Ukv/e7k21Q2H1dJpEKfkQ1hZrpYj0yHR2UEkd71RJe0ayWU+B3rUZfnTvEWeyiz8snkJr8nXhlWEOCrINr3KeFg3syQHP1k962/63pXA3ANE8lVNls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iU5C/C4l; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3zq6duxak5funmskg677udfreu.protonmail; t=1725974831; x=1726234031;
	bh=59LhVAIff5XFYxepQj3fCMMGfNu38AxikS6S1TnocIU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iU5C/C4lc1wDQpjvu7u5lF6rLP0RPcCAxj8iItwLBSDbUuC8L0NQe/P9kkpBtTBjA
	 rIKTPEO7wMAHGZDWw0c6NesqGzwT+xg2uj84RYDve5tEoiWpLOwU44xVS/p3IfJ2Td
	 /r4A7dbhWxw4qflriH/KMDatltcqfGlN7JeBeixZEJnArKWo9IUycL7ft9pN9PG/IN
	 xmmP7Q+9Pzda0MWqZdilpz2e5R1oJvioTVEnsUPleLLeuS0L2mf7fEPB6sWps+JLQy
	 21Y90qkyKAe/B/KcXdODV+xMLNf0s+6w/ivZGF+LUDol8OsabzEC/bQsUaEIHe8Gbl
	 AV8jcN9Fn55TA==
Date: Tue, 10 Sep 2024 13:26:34 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 26/26] MAINTAINERS: add entry for the Rust `alloc` module
Message-ID: <05abcf53-4997-4bdc-953b-30bbb5118639@proton.me>
In-Reply-To: <CANiq72=MD8jmWb9EGA8yW6eMT6Prj8fYEiJM81-HTq3p4dKmGg@mail.gmail.com>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-27-dakr@kernel.org> <20240831135712.0d7366b6.gary@garyguo.net> <Ztb6_XW3ccnHQDmw@pollux> <CAH5fLgjbnGstjzsudjavzt5+UwK_r8n8X3LPdw29QSkBzaygxQ@mail.gmail.com> <f99d8d3a-5b56-4555-a1fc-bd7685dcea40@proton.me> <CANiq72=MD8jmWb9EGA8yW6eMT6Prj8fYEiJM81-HTq3p4dKmGg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: cdd673e249abf917c1ab57e7aa7cac4657d773f8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.09.24 14:57, Miguel Ojeda wrote:
> On Wed, Sep 4, 2024 at 2:51=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>>
>> I forgot the reason for not using it, does anyone remember?
>=20
> One of the reasons argued was that `mod.rs` is the same name
> everywhere, and thus it is hard to notice the difference in some
> editors and may be harder to "jump into" in history/tabs/etc.

I don't usually open more than 2-4 files anyways, so it's not an issue
for me. But of course people's workflow is different, does anyone have a
problem with switching to `mod.rs`?

I have another reason that it might be nicer, when I want to edit eg
`init.rs` and I decide to directly open it with the editor from my
shell, not using my fuzzy finder, then I need to press tab to select
between `rust/kernel/init` and `rust/kernel/init.rs`.

---
Cheers,
Benno


