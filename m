Return-Path: <linux-kernel+bounces-278421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6233D94B015
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943F01C21DCE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF413D25E;
	Wed,  7 Aug 2024 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ZL+8xYWV"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D42770E;
	Wed,  7 Aug 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723056882; cv=none; b=NZ/LHUrEX+SoyE8Ljy2gkfxBrRg550PWPeAMdwtEfDzkykzqFboUv1raRsWgzarn8l2zkTf2ArXwADCFvNUu0TT67GYPWI0qOAkw5/O0MOBHW054cqPw36Yq0kmNH/jU2hzRTO17OWZFOW3cLzWCt9nhCz84t7B7l59d3RIfwlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723056882; c=relaxed/simple;
	bh=eS5OgVnptRZen/HahpgvKUIcE9oPU+vpkiUvT4UU0jI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f7l82bXoq14JXHhghQ6m6vihJOoUbLYwhrZAFYFa53hozXw4/gA52QgWanhHHy60QyAvjSfryPjuMhmBtiHqLnTuwHINcGE95GWx/LXc6SGGh/Kv3JUSsJYmUET36mScbhTEglZqg50a8I7dWcDO5aMX3Pr+NUVPErkGh+AffeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ZL+8xYWV; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2C6CF418B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1723056872; bh=HT5EcgEnMFiayl2D7AjPhk3oSJU+IUjydwWSqwJ7WBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZL+8xYWV8yK+HQI8E2uPeOxQmBGm+Y0EsjghmRWH0Uk2WNgdyeHWuqs0UVgYa4P8A
	 dzAHyJ7g1SUpadFFV2v7BmToXcXvgM0nNCg5B5DOcstq64OnJSAAWQ1IUYLAfRP3v4
	 Gk0F0kNM5ARys62gHRMCbikPpwfY7kIltJvOkwDtBwQZ4Hsw1g+cF4mNTE4kS5J2q9
	 ZOJa5SuuOce/CElJ+9oB375vrIfOD8X2pOcl3sXAWwa5Xqrbwzy6uP7Vq0iydvf8tj
	 Ty8OdCetrES8ORXMIarcyfV+mRgC5tc1gQLeL7jZpV8Ma+9pYZLLy/263aetaBULMd
	 pyQ3ql2n3JY8A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2C6CF418B1;
	Wed,  7 Aug 2024 18:54:32 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Breno Leitao <leitao@debian.org>, Akinobu Mita <akinobu.mita@gmail.com>
Cc: kuba@kernel.org, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: fault-injection: document cache-filter feature
 for failslab
In-Reply-To: <20240726120930.3231333-1-leitao@debian.org>
References: <20240726120930.3231333-1-leitao@debian.org>
Date: Wed, 07 Aug 2024 12:54:31 -0600
Message-ID: <87plqkrwns.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> The failslab fault injection mechanism has an undocumented capability
> that provides significant utility in testing and debugging. This feature,
> introduced in commit 4c13dd3b48fcb ("failslab: add ability to filter slab
> caches"), allows for targeted error injection into specific slab caches.
>
> However, it was inadvertently left undocumented at the time of its
> implementation.
>
> Add documentation for the cache-filter feature in the failslab mode
> description. Also, providing a practical example demonstrating how to
> use cache-filter to inject failures specifically when allocating socket
> buffers (skbs).
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  .../fault-injection/fault-injection.rst       | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)

I've applied this, thanks.

It seems to me that the fault-injection docs should really move under
dev-tools; does anybody object to that?

Thanks,

jon

