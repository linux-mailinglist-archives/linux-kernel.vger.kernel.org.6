Return-Path: <linux-kernel+bounces-322054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D111C972368
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5BD1F228E4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80F217D34D;
	Mon,  9 Sep 2024 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JanhGMzk"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A43CF51;
	Mon,  9 Sep 2024 20:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912949; cv=none; b=tSXiXVhp4c0usPgnZJmhA3LT5Narw+HMxFundoze5hE4RuS7gHOM62IIwTTRArGTrJ7H5Q/QK++7VkYIh3sLmOmYHhUNcVdYP22vAArwqGEfvkoBb5Hu0iU6JYtQ2hSdGjbsGrznwuwu/fNQMG5A6z0mKUmCyhvu+mGn0mxmJTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912949; c=relaxed/simple;
	bh=VcR2FbwmPv0Gj9qmkH9BdXMgSSSwUnB+WT2o/Sfe8uY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=srcvFhQmUVsP49/V+OqRYCxB6wifXzhGgm1KkeLbUUQAE/ayj2rkYTCHHxwyOltvsP6klZ6Nv9hg8x+ekrEGNPGYJamnRe6PozqP1Q+puwCuEvmz1KmVqt5EkLF3nz9MPukkeTqKxyz0L+16/QMdZIVzdDDw3OR9yByYVAFTuc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=JanhGMzk; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 72BA84188F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725912946; bh=XF5+qiqDiKQFsBWRRA9xBf5qeeLlXYgufgEO4/vQZmc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JanhGMzk/8/zKfpNu4Ja1MFiPTyV8umxI15SBUsbmfF4QJvvg2V3kydaLHS7HMNbx
	 lfriljO0VTh49cJbmEEdXcSD9+ykDKrvEG7VD7p1B0hzjAL5YJzfHEfl8Xx0h3IiLQ
	 X6DXiYgFzrP9nt0LrKLtO+PwHbi+9tBhHWC/ShPQzSiMRmggkP39xWN5I+v+Q+5GAC
	 ZTCBKx+hZL5xVO6h5LC+g6vI7ieM9mddfrmUvkRacFTK/eJrWKpBiswbsq8egbX/P9
	 +aR3vEVQZH8FUOylBDkIt5xPnGo3i+l1fpNWd0gFVhsnooiRp585RDzGctkWMRTlbP
	 gxg0/xPwCmFMA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 72BA84188F;
	Mon,  9 Sep 2024 20:15:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: cvam <cvam0000@gmail.com>, kbusch@kernel.org, axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, cvam
 <cvam0000@gmail.com>
Subject: Re: [PATCH] Typo in the file 'feature-and-quirk-policy.rst'.
In-Reply-To: <20240909200253.19818-1-cvam0000@gmail.com>
References: <20240909200253.19818-1-cvam0000@gmail.com>
Date: Mon, 09 Sep 2024 14:15:45 -0600
Message-ID: <8734m8h9ce.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thanks for working to improve our documentation.  Some notes...

cvam <cvam0000@gmail.com> writes:

> location: 'Documentation/nvme/feature-and-quirk-policy.rst'
> tested: Not breaking anything.

I don't stress a lot over changelogs for simple tweaks like this, but
you could still try to write something in our normal imperative style.

> Signed-off-by: cvam <cvam0000@gmail.com>

There needs to be a blank line before the signed-off-by, and it should
have a full name in it please.

> ---
>  Documentation/nvme/feature-and-quirk-policy.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/nvme/feature-and-quirk-policy.rst b/Documentation/nvme/feature-and-quirk-policy.rst
> index c01d836d8e41..b5461aa303a4 100644
> --- a/Documentation/nvme/feature-and-quirk-policy.rst
> +++ b/Documentation/nvme/feature-and-quirk-policy.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
>  =======================================
> -Linux NVMe feature and and quirk policy
> +Linux NVMe feature and quirk policy
>  =======================================

A nice touch would be to adjust the width of the "====" lines to match.

Thanks,

jon

