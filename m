Return-Path: <linux-kernel+bounces-307453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BEF964DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92B5284A95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB911B9B27;
	Thu, 29 Aug 2024 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Jtez3PWx"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1331B8E8F;
	Thu, 29 Aug 2024 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956569; cv=none; b=di+vM9ZJWNKR96sfFIr/A32Zf0qLi9umazniIQ+KBIdss0dWZyVjVG7zqixwWCXm5lyl/tEMEo/YzGE7tlfrM+xmQVT7bI1cbgQAc82o3U9yziz8xBo/O6oP0Ew6cO8eFG6Vs2nrwm2iSAb5h4FY3mqJgyJo6sWFelML+PtTtyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956569; c=relaxed/simple;
	bh=0CeoohYIgEl750/scRCCTDN+fV/PSMmnH/dD9rfKobs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAqHxh+0Hj07kXULVPdeX6UhnDRA6W00GDct33CN/8Ej5yLGBeOYo8cW50a+eY0JGSrGlVP5bmzkO0VOC4jeYxug0cNcOgwwIsDCtBvIjBWqYyllQzl5N96Ld2gTUVL57FJe0D9n03MHaYDPPPkFa3B5YglXZdKQgVUOEnyjWfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Jtez3PWx; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724956555; x=1725215755;
	bh=3cGYxjk1l4dXDgwObkWKN+gXbK3hp40TD6HTmR+dAg4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Jtez3PWxGwRZWIWVUcG/pLjrPWB+sa9D7TAeT8SItktHtnPOjKQg+SJZPVsr+OgoZ
	 N3X4I5qVjQMpQosknGw2D5dN9NJyYHl9QGsZ4n/j7pyqN+nwZFrho25iawCR2nLW4R
	 w4OESkEWfj4U+mbVypAa6KZKBL1sQTXlxROBnxDp4ys2xnks3/I2u4+/L3R3nFuvIP
	 /wz6QlcF6ns18qdTz6qWWCA0vU0O6Mv3r3exhlNMxKUK5IkrZt8Y/7uv7Zm+GIsnrh
	 g4EQZjab7gzKKWFK5GYmod/ab/fQdHd186rRk4lEidSeNK9behqTopRviYnl5dlJBX
	 7IIwBaNbZiFNg==
Date: Thu, 29 Aug 2024 18:35:52 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 10/26] rust: treewide: switch to our kernel `Box` type
Message-ID: <87500c80-5724-4091-9f70-a8f1516b85dd@proton.me>
In-Reply-To: <20240816001216.26575-11-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-11-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a9f476956df74de268fff20e07093f19f8b7871c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.24 02:10, Danilo Krummrich wrote:
> Now that we got the kernel `Box` type in place, convert all existing
> `Box` users to make use of it.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  drivers/block/rnull.rs            |  4 +--
>  rust/kernel/init.rs               | 51 ++++++++++++++++---------------
>  rust/kernel/init/__internal.rs    |  2 +-
>  rust/kernel/rbtree.rs             | 34 ++++++++++++---------
>  rust/kernel/sync/arc.rs           | 17 +++++------
>  rust/kernel/sync/condvar.rs       |  4 +--
>  rust/kernel/sync/lock/mutex.rs    |  2 +-
>  rust/kernel/sync/lock/spinlock.rs |  2 +-
>  rust/kernel/workqueue.rs          | 20 ++++++------
>  rust/macros/lib.rs                |  6 ++--
>  10 files changed, 73 insertions(+), 69 deletions(-)


