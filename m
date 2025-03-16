Return-Path: <linux-kernel+bounces-563089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C02FA636E2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EF9188EDD5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49341DACB8;
	Sun, 16 Mar 2025 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="br+hPYt9"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A601C862A
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742148098; cv=none; b=gDItpmF7s2G7CbA4etiQMv1W9m9XVU6KOKGZHAFGwIYsZ860esX5KCtjXWe8/JX/P6nJubMPitKOH7o9tIzMFZxQZZoPXdIMKLdY9FoG3EbjwI8kAr6Ho3V68AF3uHn+KtoUmB4g/HmoY4UC4M72eBbSv25a/HahQNZ6mUKfgSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742148098; c=relaxed/simple;
	bh=QXR00CS8QUxl5UcLkdVT8Wo7n+Glksoub62YlpafMVE=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/gV/omMDapW3NCpL97Tf/vF2R5pfSAAZCsLgYCa6WjwanD39p6tHOd5jqyUdxAGUr3GgIkfpFvODaffEfd6kmrGIXOhgNCKrkZFc07REeOhTOLEc1jO5UZ9fa4A91fDy8nhn6dxMUaYtEg15iiUATtVPjE3qKH9dP8GzDlNw4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=br+hPYt9; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742148087; x=1742407287;
	bh=tAOyqqzV3U1doRz6F+tF1ZAeoLpn6CDfC6jWDliUrEo=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=br+hPYt9Gnwa7o6IBCW88llVLpCKrhm1GWAa2kho4+eWWTBZS+6S+ubbKlEWppETU
	 RAw9A5p1vS8w3QiwmwAkDMufLI12hL6tdt3JVJNO4c9T/OskCpr/dealfBc7Vf7w7Z
	 AcMQpB3mxJRdx7/zzZ6AyphoU3rvhuaUAZ5zgM2f3Oaueb4+JimxwN0mIOpMtcOhfN
	 dip7LuZI88MW7P4jIdzFCMmtLWD2Um/0oIXMwQEDrAETEIdXnI+zKCoxt+Vvini2Mq
	 +VhEZC/9B8C5JHR+jk2qxrJaZEWcCff2YaPaqVJna4WLKcsVlefSZJ4UOcvuhKerlX
	 uiiFEnDxfCqcg==
Date: Sun, 16 Mar 2025 18:01:21 +0000
To: Andrew Ballance <andrewjballance@gmail.com>, dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, acourbot@nvidia.com, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Subject: Re: [PATCH v2 2/3] rust: alloc: add Vec::resize method
Message-ID: <D8HVY5KSXNRL.YPQRJFX9R8XQ@proton.me>
In-Reply-To: <20250316111644.154602-3-andrewjballance@gmail.com>
References: <20250316111644.154602-1-andrewjballance@gmail.com> <20250316111644.154602-3-andrewjballance@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6851ab4816f7ad4e9864ac4c422a20a36671b293
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Mar 16, 2025 at 12:16 PM CET, Andrew Ballance wrote:
> implement the equivalent of the rust std's Vec::resize
> on the kernel's Vec type.
>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/alloc/kvec.rs | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)


