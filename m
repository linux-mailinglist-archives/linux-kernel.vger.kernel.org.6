Return-Path: <linux-kernel+bounces-409814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244C69C920F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FA31F22D18
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225AF18CBFB;
	Thu, 14 Nov 2024 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="be5W9GL3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8245C18A931
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731610927; cv=none; b=Taq636o8JCS0ik/Yl3nYDa5yPTcbyE3+vJkzSexd1iRFRRPLPLTqEwPkMzUHyJuN9QiC6gV7XBIPhmWsMX0dGgjrFjQJuka9fw/to74E7zqoO45oKleaPezlJ7A5oE+4gVBleZ3j3/DH9y+Nz7vVfZJgmBVzX7mPlYgWLPYaYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731610927; c=relaxed/simple;
	bh=04uCFxNnoXHw8ZJOUz+3cpJZ7fV3XVyz75fxmcXtF8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rpeyLdcxy1n12mS2875j1qxwwFz0+tLyW8W/oIMKhg+AqS9b/d3wzsYpVOQSC7BHh27nE1h7u3XXOoU23sjZ39rYMQsPMm1XaME/NlkW2DV/oOUQE+3jTOUoHJzJP34B8VQljUGB3J5bw/CGuS0ASTW4oY541+04FULxYPjCx7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=be5W9GL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC73CC4CECD;
	Thu, 14 Nov 2024 19:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731610927;
	bh=04uCFxNnoXHw8ZJOUz+3cpJZ7fV3XVyz75fxmcXtF8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=be5W9GL3BM4deoppqgH8P/rvqgjUlEVgER+YlMyTfRLegf8K/lLEK0BoSlOnB31CW
	 KR01qC/dWq8rBf4jtKLCRkz9CT7GQZEAI8Xa/4sGAHtBsVRxKj71QWnb/6/xu2TJzP
	 ww7ZJzEbRpc/dorJRrQ837+1SDERkWtqPD/8trcuDl8yYaY4ivNB+Cu1zKZnlCn5sH
	 UGv/OaLARzEfrMmZukkppccakyXMZB3JTnLujxKU3lLFYy2nNJUkFGJ5i0ZxvU9SrM
	 ifE/a+3ysYhdmjB4btmFfDGyO41/vgZzq+LqFB1fZhckTr+qZefSmcPU2o9BB3Pkid
	 tWz2V5xLKUctQ==
From: SeongJae Park <sj@kernel.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Wladislav Wiebe <wladislav.kw@gmail.com>,
	motiejus@jakstys.lt,
	vishal.moola@gmail.com
Subject: Re: [PATCH] tools/mm: fix show_page() build error
Date: Thu, 14 Nov 2024 11:02:04 -0800
Message-Id: <20241114190204.1486-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241114100140.406416-1-oleksandr@natalenko.name>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Oleksandr,

On Thu, 14 Nov 2024 11:01:40 +0100 Oleksandr Natalenko <oleksandr@natalenko.name> wrote:

> At one point I needed mm tools for debugging but couldn't compile them due to the
> following error:
> 
> gcc -Wall -Wextra -I../lib/ -pthread -o page-types page-types.c ../lib/api/libapi.a -pthread
> page-types.c: In function \u2018show_page\u2019:
> page-types.c:423:49: error: expected \u2018;\u2019 before \u2018if\u2019
>   423 |                 printf("@%" PRIu64 "\t", cgroup)
>       |                                                 ^
>       |                                                 ;
>   424 |         if (opt_list_mapcnt)
>       |         ~~
> page-types.c:416:65: warning: unused parameter \u2018mapcnt\u2019 [-Wunused-parameter]
>   416 |                       uint64_t flags, uint64_t cgroup, uint64_t mapcnt)
>       |                                                        ~~~~~~~~~^~~~~~
> make: *** [Makefile:23: page-types] Error 1
> 
> Trailing ; was forgotten, so add it.
> 
> Fixes: ece5897e5a10 ("tools/mm: -Werror fixes in page-types/slabinfo")
> Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> ---
>  tools/mm/page-types.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
> index 6eb17cc1a06c5..bcac7ebfb51fd 100644
> --- a/tools/mm/page-types.c
> +++ b/tools/mm/page-types.c
> @@ -420,7 +420,7 @@ static void show_page(unsigned long voffset, unsigned long offset,
>  	if (opt_file)
>  		printf("%lx\t", voffset);
>  	if (opt_list_cgroup)
> -		printf("@%" PRIu64 "\t", cgroup)
> +		printf("@%" PRIu64 "\t", cgroup);
>  	if (opt_list_mapcnt)
>  		printf("%" PRIu64 "\t", mapcnt);
>  
> -- 
> 2.47.0

Just FYI, a very similar patch has posted a few days ago:
https://lore.kernel.org/20241112171655.1662670-1-motiejus@jakstys.lt


Thanks,
SJ

