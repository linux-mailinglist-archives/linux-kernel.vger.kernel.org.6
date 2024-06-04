Return-Path: <linux-kernel+bounces-201454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7D28FBEC2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963501F2211E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366EA14D2B9;
	Tue,  4 Jun 2024 22:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Mz4zL+fk"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1607514D2B2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 22:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539479; cv=none; b=IkooezudTCtoEpYYK1b5tpZk2e7pPrUvVHq2OBEpBP2uRna02d7WcwzYY+tVmR3y/ocLAKbEqxs4whpekL/fHjILxIezZ/p/7ZoGKf0RYcbJT630rL44w3zWxItTZAql6Cj0bhhJ0XP2Ozo8Ds/UXmOHNaB8Za46hW09RCaXMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539479; c=relaxed/simple;
	bh=DK4CPWNPGd3mRzWeANhjnOCdP3YfV6KKDwPWj2sjMFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYzHewmcyTf/8A4xuHUSV34hIhQTfwzos79JSSTCK0Jgb08oDso6QolAYzLF26+fDNz8GPPBziStkrbef8eiNFaUGMbyR5vgVdtGhgXooBSJlorrw+XZu0X6lEIDT7EtjwxGK34oKocbKCShRcEdqL8MCutvlLGmqzVKWxYrVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Mz4zL+fk; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Vv4jD2Rznz9sSN;
	Wed,  5 Jun 2024 00:17:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1717539472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guuxTy+CZVyMI/LzvDTj+NobCvDyE9ykfdNc4s7xxKU=;
	b=Mz4zL+fkVn0xahQamRTxt5EodXqPnJdgpFxGEsfrP3tDTxMI+LHndT9Z8o1KAcwBPp1B+l
	VU4Ka0eWCs5sSk2DCHoMRZ9YG/UMSnfp+i/eI0pTcb4jNdwKT8hV9RltP54v1PsltDNWnW
	6yOJkScrh8ZisDXePiSziqOVyxJXk9+kY2vGYc6mtMtDzXUlLFkRvrxB8Xxcj4QmBcmW4n
	O8e/JjOBVk/A3feAyjNQev4hhGBaBkOZpIQihowArQFMCW77Un3k+b82g91js6V+DOQPW2
	zV4WyuOhiKTPb711dsqV9bAIuljb1AvFtHgRM85SqodWENpIC8QQPhSwrj1JlQ==
Date: Wed, 5 Jun 2024 00:17:47 +0200
From: Erhard Furtner <erhard_f@mailbox.org>
To: Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Johannes Weiner <hannes@cmpxchg.org>, Nhat
 Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>,
 Yosry Ahmed <yosryahmed@google.com>
Subject: Re: kswapd0: page allocation failure: order:0,
 mode:0x820(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0 (Kernel
 v6.5.9, 32bit ppc)
Message-ID: <20240605001747.2d3e13fa@yea>
In-Reply-To: <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
References: <20240508202111.768b7a4d@yea>
	<20240515224524.1c8befbe@yea>
	<CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
	<CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
	<20240602200332.3e531ff1@yea>
	<20240604001304.5420284f@yea>
	<CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
	<20240604134458.3ae4396a@yea>
	<CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
	<CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ik41k7m3xcnx6y18u6tq8497mnd3iouf
X-MBO-RS-ID: e7369f9761aeea9ca46

On Tue, 4 Jun 2024 11:18:25 -0600
Yu Zhao <yuzhao@google.com> wrote:

> Hi Erhard,
> 
> If it's not too much trouble, could you "grep nr_zspages /proc/vmstat"
> on kernels before and after the bad commit? It'd be great if you could
> run the grep command right before the OOM kills.
> 
> The overall internal fragmentation of multiple zsmalloc pools might be
> higher than a single one. I suspect this might be the cause.
> 
> Thank you.

I used watch -n1 'grep nr_zspages /proc/vmstat' to get the readings and repeated this 3 times to check whether the reported values differ much.

Bad commit was b8cf32dc6e8c75b712cbf638e0fd210101c22f17 "mm: zswap: multiple zpools support", next commit in git log after the bad one would be 42c06a0e8ebe95b81e5fb41c6556ff22d9255b0c "mm: kill frontswap".

With this kernel I got 2440, 2337, 3245 as nr_zspages and the kswapd0: page allocation error.

Commit in git log before the bad one would be bfaa4a0ce1bbc1b2b67de7e4c2e1679495f7b905 "scsi: gvp11: Remove unused
gvp11_setup() function".

With this kernel I got 25537, 11321, 16087 as nr_zspages and the OOM reaper.

Tomorrow I could also check the .config changes Vlastimil suggested (CONFIG_SLAB_MERGE_DEFAULT=y, no CONFIG_RANDOM_KMALLOC_CACHES) and report back if that's of interest.

Regards,
Erhard

