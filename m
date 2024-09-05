Return-Path: <linux-kernel+bounces-317841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724D496E45F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323F82896F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFC3D6D;
	Thu,  5 Sep 2024 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Morwnrlu"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66C41A4E70;
	Thu,  5 Sep 2024 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569295; cv=none; b=mlLGLTrluflf0lNYiID91QC2tx6P5ZzhoGMGMqHZsC/hYO0g1bjLUynYvZgy8OdBd7xkapSB44VvroFWf2sDsmTCUuO5zFx3YqOlGoCQpbrgkALM/bEoJhkXUDeA1efZZMuxKt6IHtWfVwe8/9RmrrgKTvTaRU9U42TMrrOVWCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569295; c=relaxed/simple;
	bh=teJozzuAzYNGFvITuemM0lDipsAWg9rPqnxy2KjPqLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c/RdRTX89fkb1gv9o3/EV5RmLLSUV1gCmBFULcgI0ZmHXPi5vIF+QmJl2nIN+17UDsISa7Fvzom0426CaDAitG2NpbcCnBQZFHgQAtEy0OqHp/+O9eG/i64oPFoxG6JYbiMpT3FVek7RAyU/oSBYy7804NNGgV+gcAt6SH/Gbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Morwnrlu; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 95FB542B25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725569292; bh=C0CclTpsrFLoIVZ/AVRQrp1kUy3qZhuq4yRZatF4T+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MorwnrluNiy/BV5zdfwN8Xt/HPH/YE044ZlpJEV6tCl1rg4FzFfPWbvDrUG758naW
	 xaX9PtI5gXthNcOhNGg6ORsIrY/yvuFdP0BmVixGAxr6UemJlTrXn8x1spJMOvUOPz
	 DMaSWqSurdiTo2rCH/hkdPmBs5cYZLXnX6jSq1MVAKdgtA9KbXggIethEAKJK1LKpU
	 i4TXsSugggfs9ToODzcVqhyayYJstteF7DZPE/yM6tO4lPVk+1GQ6ktb/E2wiPWmA+
	 RPuLvvidLzbiT+DxWxo+WBQeabLtfdn/OSLLMxQjEe0vI/pfzVYHLJwVWLneoIE8DK
	 ui1ESsSADNA7g==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 95FB542B25;
	Thu,  5 Sep 2024 20:48:12 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <siyanteng@loongson.cn>, Hu Haowen <2023002089@link.tyut.edu.cn>,
 Dongliang Mu <dzm91@hust.edu.cn>, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs/zh_CN: update the translation of security-bugs
In-Reply-To: <20240611020514.48770-1-dzm91@hust.edu.cn>
References: <20240611020514.48770-1-dzm91@hust.edu.cn>
Date: Thu, 05 Sep 2024 14:48:11 -0600
Message-ID: <87le05g73o.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Update to commit 5928d411557e ("Documentation: Document the Linux Kernel
> CVE process")
>
> commit 0217f3944aeb ("Documentation: security-bugs.rst: linux-distros
> relaxed their rules")
> commit 3c1897ae4b6b ("Documentation: security-bugs.rst: clarify CVE
> handling")
> commit 4fee0915e649 ("Documentation: security-bugs.rst: update
> preferences when dealing with the linux-distros group")
> commit 44ac5abac86b ("Documentation/security-bugs: move from admin-guide/
> to process/")
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v2->v3: revise the references in zh_TW
> v1->v2: remove admin-guide/security-bugs, and revise all its references
>  .../translations/zh_CN/admin-guide/index.rst  |  1 -
>  .../zh_CN/admin-guide/reporting-issues.rst    |  4 +-
>  .../translations/zh_CN/process/index.rst      |  3 +-
>  .../security-bugs.rst                         | 42 ++++++++++++-------
>  .../zh_CN/process/submitting-patches.rst      |  2 +-
>  .../zh_TW/admin-guide/reporting-issues.rst    |  4 +-
>  .../zh_TW/process/submitting-patches.rst      |  2 +-
>  7 files changed, 34 insertions(+), 24 deletions(-)
>  rename Documentation/translations/zh_CN/{admin-guide => process}/security-bugs.rst (57%)

I found this at the bottom of my docs folder; I'm not sure how it fell
through the cracks.  I've applied it now, thanks, apologies for the
delay.

jon

