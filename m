Return-Path: <linux-kernel+bounces-317823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D1F96E426
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CB6286C09
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3111A7247;
	Thu,  5 Sep 2024 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="P7oN37b3"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3E1A4E97;
	Thu,  5 Sep 2024 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568399; cv=none; b=FuvFdluEXon2ZEylR+cz3VdTq0e4MNVv9djD32hD7jBbhhth8FDGcJV5wREyg2TCDTSNR0ELjmJ9TcRXPkvLXawjmV6Ojj2uTyEtvsdYPgCZ2owITpbuITIbXqb9laVx0sEhscHVSZ7s2+JIxlFrQn0mRIFmC+DeSSffgOtwNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568399; c=relaxed/simple;
	bh=riBV2lfApg2Ld7xZtFtQGkOUs7EVTDr5KDFicVRWsgw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CW6WCYL+D3UjNku7msYXQta78LPsP/X4VVSKvaYEEfDBqoxo3uF8Tpr1Xsvms7NiUBDWM9KNlRh3t8ZqwvN9V71toNEbaSvqegXgMa3BlzIGxOEdCTiMUdXTA04BuxU1aIcR5HfGu92EQofFANdfey2C0DqgAbOL8HcXxObsU6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=P7oN37b3; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3287E42B25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725568397; bh=JuyDqlVA1do2mubnFAhREgX39ZXWLY4Qa+TRYZIPESM=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=P7oN37b3ddBaO1YpgGdkHEvev6o1O5rIHRrRfj0THLWdllwWN3B+NmZ0ssPa24yaX
	 6rTbDv116PjMg3oO8DF1goFohdRbRu7EpvYGlvyL/hHH4WUPg7tw4y8WouAT8HyTwx
	 pJPwlTTXe0WHsIRlOWIDK18ZYkAjZta+Sf1wQO1WH7/bxfCoEbSbJgCa4xJYPxy50y
	 3Px/b8HHkw4IP8rRyRoC6l8BevEPGYhqM+JT8UHR6klMUoOK8AXsq0scHmzyeGI2Z/
	 fTIUbu2NWejmLjf1V1JowHDGefLoUr44m2Gb7ZsUrgJOOOSh0JCWMpdlBRERMIqdDg
	 StTeHevN9aIkg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3287E42B25;
	Thu,  5 Sep 2024 20:33:17 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Aryabhatta Dey <aryabhattadey35@gmail.com>, liviu.dudau@arm.com,
 airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/gpu: Fix typo in
 Documentation/gpu/komeda-kms.rst
In-Reply-To: <l5wzytcamcc43eadaquqbrfqilq6ajfnnseh37c77eceamtw35@hhtdipi4h22c>
References: <l5wzytcamcc43eadaquqbrfqilq6ajfnnseh37c77eceamtw35@hhtdipi4h22c>
Date: Thu, 05 Sep 2024 14:33:16 -0600
Message-ID: <87y145g7sj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aryabhatta Dey <aryabhattadey35@gmail.com> writes:

> Change 'indenpendently' to 'independently'.
>
> Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>
> ---
>  Documentation/gpu/komeda-kms.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gpu/komeda-kms.rst b/Documentation/gpu/komeda-kms.rst
> index 633a016563ae..eaea40eb725b 100644
> --- a/Documentation/gpu/komeda-kms.rst
> +++ b/Documentation/gpu/komeda-kms.rst
> @@ -86,7 +86,7 @@ types of working mode:
>  -   Single display mode
>      Two pipelines work together to drive only one display output.
>  
> -    On this mode, pipeline_B doesn't work indenpendently, but outputs its
> +    On this mode, pipeline_B doesn't work independently, but outputs its
>      composition result into pipeline_A, and its pixel timing also derived from

Applied, thanks.

jon

