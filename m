Return-Path: <linux-kernel+bounces-443685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145B79EFAAA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E631628C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CB122B581;
	Thu, 12 Dec 2024 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gPXeyVU1"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4501E223C6F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026924; cv=none; b=eYLZUNNWWw4IEP6CMxKbssjXdg+jD/wFxUR1DWxc8lNVyfODoOlX2ll7hZiJAxP6ntmGWoDGqu8TtGqWes9B9lhfBe2rF7mYLZ/o5m8ClWtWvAyIjhOtmETSgeI8aqECnVt6lXxOXd//+4Gr2WXZ1PgkGX5bnmcPiz+6GxHEEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026924; c=relaxed/simple;
	bh=sM/aBm5R9i3V4Hw5oNSQXhoPLBfwLGRIWeKu/O+2n9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=fXQHyLclmYiw2quodob9uAIQM4aneOclh6FVltYMVSqPlOXEzgNs7GPZxtcqLo3VJvlXrCqPyDUCMoRD29dwBWjYaTCTeW570JfCe5Nl0K0Blx0pPyKuzxRVSzMt2nlMO53DAzjU7qAO2+qNS7Q4vwIFXFVI4F9vE8EXsNKe9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gPXeyVU1; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1734026609; bh=rW1uozfEC7SPx1cDVc8hLwCIqkxTu1qCKfK0nmnrfvo=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To;
	b=gPXeyVU1sqMyd88RavlhtjN9OoED28DjK/kCUoerogqSspoS6FK1rm6QVCzL1dwQI
	 gtiGLobEAeu4ZfELIcqyHCspPRNVH5FZ4m16uxyf73j9b/GZJz152bkxoOWzYyq0th
	 DgkjbTqT0Ar/4HNhtvrl+0hOIu7GyUid9Ht4Erpk=
Received: from [IPV6:2409:875e:a030:1001:14::e66] ([2409:875e:a030:1001:14::e66])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id DB3A252; Fri, 13 Dec 2024 02:03:27 +0800
X-QQ-mid: xmsmtpt1734026607tife24nal
Message-ID: <tencent_59A379EC8F58DD64596C72493C232856CF0A@qq.com>
X-QQ-XMAILINFO: NCkMfDbncK88mtZVQlmuQbM9Dq5MaTBpopRHRzqYAexImyF/jY00PpQEZmXYgg
	 DKXbwUigXtOLOu01wy8VsdeQkVteACuRoFB11wTJ4TbIBPkr3e2AVwnSweNO3/bN5E2tTpON0CEl
	 DQT1QmKIK1ZFYOX5juw7zIlg/gk6SzdCEBv3mV5vOk0I7XeFZ7LDPQZrBJBUB8MZkEW66VHrHhmI
	 Sa0elMEK3esawfGu/0yOkLu4f0BUBco4HIuCWZG2UlaRDDA4tXc5xs2/iowusV6ge2jiNcS3Gc92
	 M3xCPrShaydoD66QPHnAs5KGLD0NLJKBEF4xHKiAdNfJwo0UobGDzq25dRVMP/tkUhVSJ4Qex7/8
	 nzu0bROkW6dtZ4rcWJ7WyC2iManGS+IBeck3gT/G7B8/zITXSaTT34BheyuBJji8r6w0dD6yI+t2
	 V+CbeZqAjFprcxkF1HC/J0r+eaDJmZcaVa3um6vmlRBVP0daN8wl8AsKzwqleIUHjKUiD/PCqiAb
	 nf/p8yC6KMpcaMM+vuntaKWiDWimpJdW4rQIkHWZodAhk/LgvD9VrYSlJDgYfeua1Nu35Znnfc2e
	 +fnbZ84DIYbbi/VAan6D64iFkrPF8FGHl99lEV2dOGjL2bqZjAuapsRnR12BxLWBgbb6jzg7+etq
	 J5Q3HKxKjEr/6tXlm3W6zPNeTLbr5Eo81RhbHEUDG7Od/6jKGC38WipSknGMzwpRFXu7BxJ2qIWi
	 eBw5riWWg+H4F+fn/ow6qjJ7DHEDGjm1XAGTk8p4MVIMS1DHDU8rChBlIXEqNFu4sPZUEKPtKyRq
	 Lm7IRBm5Heth2OQDjNVPioIcioO4/k+nzLVAuxTePykmvf5Tb5gYdAAk+UE3tH5ulrBqwFoARRUE
	 u4aAdnrrR/JK3KI3g1V/0VJm3u0b8pymRCzL/xNo9+79I2elpRxwsKEIwCL1+zTo0LcDtR5NF+ve
	 pvYg8kK7ucV78mGD0s4w==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-OQ-MSGID: <392ff9b6-f603-4ca8-9d31-2e029bdad2d0@qq.com>
Date: Fri, 13 Dec 2024 02:03:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: include linux/pagemap.h where needed
To: Arnd Bergmann <arnd@kernel.org>
References: <20241212153916.1292365-1-arnd@kernel.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, SeongJae Park <sj@kernel.org>
From: Junjie Fu <fujunjie1@qq.com>
In-Reply-To: <20241212153916.1292365-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On December 12, 2024 at 23:39, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The pagemap header used to be included by accident here but is now
> missing:
> 
> mm/z3fold.c: In function 'free_z3fold_page':
> mm/z3fold.c:353:17: error: implicit declaration of function 'lock_page'; did you mean 'copy_page'? [-Wimplicit-function-declaration]
>    353 |                 lock_page(page);
>        |                 ^~~~~~~~~
>        |                 copy_page
> 
> Add the correct #include statement.
> 
> Fixes: a6c37165ca40 ("mempolicy.h: remove unnecessary header file inclusions with no test failure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   mm/z3fold.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 379d24b4fef9..4ae93bb2e3ab 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -30,6 +30,7 @@
>   #include <linux/mm.h>
>   #include <linux/module.h>
>   #include <linux/page-flags.h>
> +#include <linux/pagemap.h>
>   #include <linux/migrate.h>
>   #include <linux/node.h>
>   #include <linux/compaction.h>

Thank you for your fix!


