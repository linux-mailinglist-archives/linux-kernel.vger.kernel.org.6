Return-Path: <linux-kernel+bounces-566348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3558BA676B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C4167A6A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450F20D505;
	Tue, 18 Mar 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Gokot2pn"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB181C5F32;
	Tue, 18 Mar 2025 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309016; cv=none; b=LgT1xSYScwAd3Qg3JQNjE3/HY0vEwTCIY6Rm7mfKc8fqdYrMWYl1QQIbSevlYBEuQVTa8lMo4Xk8aDbmZ/5ch/8OkDqGVboQGVDw64hkYKMoaGu8YuU+QfVKC+ahrlxuMBsWQ7a+rxGPRg7tU7jObgRscZ5NSintIwBa0Mqs8Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309016; c=relaxed/simple;
	bh=cqsBRt8ZmMLt6MtWdz+Gh+vgZfJbepNTIAPzVuhc7/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S9XfVGjizOTQeVfbV9DM1eRko+BN2Ixcv9MiEgAIQsoJ8wFliWo1XqV2tnQh7ZuZKUUsmyrghkltwG51aIzdrFKOWLBQhpgODaFiquaP6+UsdeLm5ss4P0J/YSsi20kXuQmpi6LGl/fZ9OirLjxnKV5sRPN4bWPuieuPXshsb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Gokot2pn; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2BF724107B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1742309012; bh=+EhGNEpSFKvod8JfD5aHgJIBk5oICr0X9rPl5M67D/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Gokot2pnDJ3QNNtVXcwq1iNq9GhQQiqc3WDlJ7WLjF/INXzD0t8QM7ZMdrgXsCmgs
	 /lX9TIKOSMZJ1XUWHHZ+Gwi7WVoTtN3sZXtpFaU1g/NT3EhVUfXNQSeNcZnxe3N5rv
	 gZAyNge2EKyIZU4RBsD9X+nP1srKlKjDaaU/ubbb5CqFEHWjH5N1+JYv3e7o5y1xz9
	 ysEtO3yNETqHqmAzU0TXDuZG/n7nyvbdKs6xH8Y2efUxorYL1Y15BKRTRaMW4wZM3E
	 aOmbVpqO8Fsp/xqghVQa9y5TlK6Sbpho6YklTjhmbd84Ku87AqHJbzkG2dC+Pw03n4
	 m2JuWsQDsMQEQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2BF724107B;
	Tue, 18 Mar 2025 14:43:32 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux DRI Development
 <dri-devel@lists.freedesktop.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: Re: [PATCH] Documentation: vgaarbiter: Fix grammar
In-Reply-To: <20250318041249.20786-2-bagasdotme@gmail.com>
References: <20250318041249.20786-2-bagasdotme@gmail.com>
Date: Tue, 18 Mar 2025 08:43:31 -0600
Message-ID: <87a59icsbw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> From: Pranav Tyagi <pranav.tyagi03@gmail.com>
>
> Correct grammar issues:
>
> - Fix "co-exist" subject-verb agreement
> - Correct plural form of "server" in context of more than one legacy
>   devices
> - Use passive mood for intro sentence of libpciaccess section
>
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Link: https://lore.kernel.org/r/20250220164946.18007-1-pranav.tyagi03@gmail.com
> [Bagas: massage commit message]
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>
> I have to carry the original patch [1] because DRM maintainers doesn't seem
> to apply that AFAIK. Jon, would you like to apply this patch before the
> merge window in case DRM people don't apply this either?

The DRM folks manage their own docs.  I'm certainly not going to
circumvent them during -rc7 for a patch like this.

jon

