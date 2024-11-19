Return-Path: <linux-kernel+bounces-414878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7419D2E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CB72812E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2CA1D0426;
	Tue, 19 Nov 2024 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTtdukzZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF41487C5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043628; cv=none; b=A0jcqNjMgCaIkcdStlpzRvMe8Vgr1vkE+YFT9tR0rZv0iRxMKDQqaAs5pVj0MgOFmJt+WhYAqhMYTVZX5BXTAzbyKuXq399Y1/7bRLkZqv3dJMaSyh464LLZBQ1CNO51GwTBEFhOpyx1JJs5DzQ+LPEwsSgH6yhXP205DJk3QlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043628; c=relaxed/simple;
	bh=VEcFKydOK/gXlariFXvoqJXD5+TMm17xBu0XVyVfVrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hmb7Yo5hdcbZ+opfadAGnt7S3p7fuKbMYabn9VhzdDTKf9bmAlYsfv0e8RDCRtHoFnkxeD07g53HH+sRl5JDsmBHZapCPoXbFL1w/a9B7b8ZTD5BmTao+2sT55iZqb8fKK7Xuadl9MNpKFiF61SRsnBH7bG2rKheH6wuGOpVAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTtdukzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F8EC4CECF;
	Tue, 19 Nov 2024 19:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732043628;
	bh=VEcFKydOK/gXlariFXvoqJXD5+TMm17xBu0XVyVfVrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MTtdukzZI1q2lNyJ69t15/PvCdEf+yPGFke4kFLvxCYwmauJbXkwcppBix8fBMm/t
	 pxTL2hDjziHwuYFIYfWMDAwbT/a2nWlbulVAKEOE0JFJcIf+SRyB8YsmjRuZ//I9qU
	 +EgN/hbJEVAkKrtAbdWWlOTX8if5VaNUtnphkiej+VHdblNXOiKGGYKGpZEI36uAwP
	 XgxYSJP60uR/v0lTl3z+YH/3z+/V4/SROaAsBrjCdzWMUl0BUfDImXFoSl1mIfvico
	 5B21REFHwDoI2/YR5t97tgqmKe7z91z5uUr7ulaxi/rSvt0JwGcU6kCeF/PA6OD1hL
	 4WxPUB+PSBbNw==
From: SeongJae Park <sj@kernel.org>
To: winterver <295107659@qq.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pintu Kumar <quic_pintu@quicinc.com>
Subject: Re: [PATCH] mm: Remove 'return;' at the end of void cma_activate_area()
Date: Tue, 19 Nov 2024 11:13:44 -0800
Message-Id: <20241119191344.53712-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <tencent_E213136E4B8D60D984B3095D9C2E2F0FD107@qq.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 19 Nov 2024 19:59:40 +0800 winterver <295107659@qq.com> wrote:

> From: Jiale Yang <295107659@qq.com>
> 
> Remove 'return;' at the end of void cma_activate_area(). It's a void
> function, so an ending return statement is unnecessary.
> 
> Signed-off-by: Jiale Yang <295107659@qq.com>
> ---
>  mm/cma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 2d9fae939..070399bce 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -135,7 +135,6 @@ static void __init cma_activate_area(struct cma *cma)
>  	totalcma_pages -= cma->count;
>  	cma->count = 0;
>  	pr_err("CMA area %s could not be activated\n", cma->name);
> -	return;
>  }

Looks good to me.  But, seems a same change[1] from Pintu Kumar has already
merged into mm-unstable?

[1] https://lore.kernel.org/20240927181637.19941-1-quic_pintu@quicinc.com


Thanks,
SJ

>  
>  static int __init cma_init_reserved_areas(void)
> -- 
> 2.43.0

