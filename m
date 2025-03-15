Return-Path: <linux-kernel+bounces-562531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734E7A62AB7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 11:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726D93BAF93
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FFA1F76C6;
	Sat, 15 Mar 2025 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="I0bXoVB+"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66F1E1C1A;
	Sat, 15 Mar 2025 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742033414; cv=none; b=bIWAkA5BLgqAX8/tOsbEV5+Z24yMSM3L3bobdjaxEDB/lFkyqatquvlJa77wLppYbdeIHmyVQ2O/V9s1EKRl7lzCZG5rZkQ5L8PpeqilOh+cVxbofSKWj/J8fjWjVYdH4JlW18kv5ISg7jQ1i6reElQFqMY1zmtPBmp/PNaQmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742033414; c=relaxed/simple;
	bh=r7Zo2XWrtRv4X3V9iLD3xbfQeBf+CgjbidARWQSKhBI=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCVela/tTMauFRga5X8dIc8NOieGDUOQIn2aNKCZzmHY4vzCbIxYl1O8awz0VPT8gYU4dp3lLaY3he3oOWROO4xJz6KDmbOAz1fw+itFwzJbGQ29vWTem7NqOSv0b5R7Uhgy/3OWJ0/VK3/ZBZyvN841jtTyaVvMOHbm7rNQzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=I0bXoVB+; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742033405; x=1742292605;
	bh=+Tktglt/oH5/YnWGKr/OddZjWfCWSqMjnQ64O9FHmDM=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=I0bXoVB+OWHVNgc3HMgIuPVU+p/6bThJWO1NkdGbQPljgBWSImAcyTx1hGOIyVouk
	 ffVw0k2EjyPfXvzHFcI9V9aCXxUnOibwaXlobiEs1L5cOb80iAP81Mp0klnZ2iCIt+
	 k/ChR26PSebdG0O+02NtqXozMb75veZkQ7Cvfe4bCYZm5sC1ahnAEWPS7FgsnGA0QW
	 k3vzLET9v6+VC2UYuJNL1Ppm65Q6KcnOJPwLoBt/6BSXZQCp84BYzCxwQJRa4A6B4d
	 PNSwgLObwJnq7+f4Jot97HHE9tQjcG/rwXboNAYh28maa6PFrjcnKWsJDofesPCgtl
	 2jxHYqvoAG0ow==
Date: Sat, 15 Mar 2025 10:10:00 +0000
To: Andrew Ballance <andrewjballance@gmail.com>, dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, acourbot@nvidia.com, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Subject: Re: [PATCH 2/3] rust: alloc: add Vec::resize method
Message-ID: <D8GRASU6UVLX.3C8EMGGXM35O0@proton.me>
In-Reply-To: <20250315024235.5282-3-andrewjballance@gmail.com>
References: <20250315024235.5282-1-andrewjballance@gmail.com> <20250315024235.5282-3-andrewjballance@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 0b0b71ccc623222af72834b86048786342382325
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Mar 15, 2025 at 3:42 AM CET, Andrew Ballance wrote:
> implemnts the equivalent of the rust std's Vec::resize
> on the kernel's Vec type.
>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/alloc/kvec.rs | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)


