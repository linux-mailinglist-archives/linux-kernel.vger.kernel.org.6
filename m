Return-Path: <linux-kernel+bounces-549721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20B2A55672
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B19175D03
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C0226E16F;
	Thu,  6 Mar 2025 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="cPy1nk39"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C7225A652
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288895; cv=none; b=EWsg5yG32xbNEKrW7EN4fgkUasWnmqDXBOxsgyslYb3upBVm1tnWNEJyPUSyiXllnFAb07NG7Ju6gOfcsTBob9w5wngPj8YHsIXWqGscPu3wiu0xQDgZSlkEn4QiMcMHI4KAzqE1Lj4KZ4uvkfARwQYuF48HjcIcWPKrgpebG+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288895; c=relaxed/simple;
	bh=y1h2/h2GChr+rD6C56xfIFr9pjUo89anu+AmczJknlI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AFWyAIX2GyOqiuUXQzoBInRDLJ7otaLnGfn+bSvJTRVlbs25vDV7xymL3JssTD2XJOUizyPDA+VubwuRAEef4t4XkZJMuAnG6Xvhgnsr+khWnQPzPUdM5LigAoHKuX/Y+7uUHpB2UPTbp2v9dmR+nidNSGmsC9KgsQU2RDGVE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=cPy1nk39; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741288891; x=1741548091;
	bh=y1h2/h2GChr+rD6C56xfIFr9pjUo89anu+AmczJknlI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=cPy1nk39V5GtnOUCkgl1DgrKEpQM0Z82p1sprsSTktQVAAwzxLn+TacJz/5udWDh3
	 dZ+UzxebTarA/PIV/EKYDiG26VhLtHwVBp8b4BFIrZyEKiHz9SC+S0VYIskaRJJAkT
	 I0fKYuIWckpcrgBpTg0vfTkctzwArdLs6KpSALFYk+Ixz529Ud7swE3HOnzodNKnnS
	 wkWGlo1rugPxgmfJxSeUwhaBnGkR1B0+PhKgMLWLQyEy6dYv5f1ww/7hBepVx830+Y
	 xzaWvRMBkJlCLIKYFSE3h0rQ4ux3Nja7I8fbKFnFYkyO36+FVwhGvIvUDeRDef0gxj
	 yV0UfVnH5HrUg==
Date: Thu, 06 Mar 2025 19:21:24 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Valentin Obst <kernel@valentinobst.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, airlied@redhat.com, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 0/6] rust: page: Support borrowing `struct page` and physaddr conversion
Message-ID: <Z8n1qTP1Oysgxe-S@laptop>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 03685db8da271e4a00bb4176d470333a2544eec3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250219 1024, Andreas Hindborg wrote:
>=20
>=20
> The series has application in `rnull` as well and I will probably add it
> as a dependency for next version.
>=20
>=20

Hi,

would anyone mind if I pick this up? I'm working on that patch:

https://lore.kernel.org/all/20250305-unique-ref-v4-1-a8fdef7b1c2c@pm.me/

There is a lot of overlap, so it would make sense, I think, to base
it on this one.

Oliver


