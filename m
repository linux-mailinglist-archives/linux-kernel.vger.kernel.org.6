Return-Path: <linux-kernel+bounces-249856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 704FA92F0C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2057B1F227CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B483419EED0;
	Thu, 11 Jul 2024 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="k5KqnbN9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025A113D626
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732400; cv=none; b=ojhrpqLjne/oIJuT9bN33ezapMrB0kksC3Haz+Q3XMZN8KlCOAmwN8YSvEnF25zdTpvNUCtN5H5s02fFsMbC1UpSjzqbfnL8aa49LsNW5yf7sjaz9rfo4ij75IrMaZCnSTXdKqt8vaHAtAJl8GSd8wB7s2TIdpT0vmHslWCsh94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732400; c=relaxed/simple;
	bh=aTiXrj3+xejUUrTCvsK1TranlzYVGOMQWvbn8pvRMHw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=V+9AhYSbYGkeW1L2R2a+xAL8vEWPdLYEI16n9r2ze6t15TZp3vEjXEEcebqIifS5Wbtk3Hrl186zuAGPTvvhRNPG3qVgzPmUtxyF18ZOZIPxqcfBGCtNclukLyZIlpir5AmazlBOG1Qc4UKKqgaQi00Phse8MH1gbgO/XCJ20/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=k5KqnbN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34066C116B1;
	Thu, 11 Jul 2024 21:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720732399;
	bh=aTiXrj3+xejUUrTCvsK1TranlzYVGOMQWvbn8pvRMHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k5KqnbN94gEyboFzfGInpP1flG4b36AO5Pus25eRK1l9aXz2EnW2MCxxoxxjwms7t
	 +4nDkMHCaXGvezNo2T/gyReR8ErjjlHgz9aH/NHJVzAC0HR4whAf/BLxCziAmk7etJ
	 jp5BnF00f40SkUiS2+i08DBnlyse0sic0O+CtrLo=
Date: Thu, 11 Jul 2024 14:13:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: zhangchun <zhang.chuna@h3c.com>
Cc: <jiaoxupo@h3c.com>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <shaohaojize@126.com>, <zhang.zhansheng@h3c.com>,
 <zhang.zhengming@h3c.com>
Subject: Re: [PATCH v2] mm: Give kmap_lock before call =?ISO-8859-1?Q?flus?=
 =?UTF-8?Q?h=5Ftlb=5Fkernel=5Frang=EF=BC=8Cavoid?= kmap_high deadlock.
Message-Id: <20240711141318.95c48cf7295f5e2d6f659aac@linux-foundation.org>
In-Reply-To: <1720681676-53147-1-git-send-email-zhang.chuna@h3c.com>
References: <20240710103611.809895ff809df9ed411bfaa8@linux-foundation.org>
	<1720681676-53147-1-git-send-email-zhang.chuna@h3c.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 15:07:56 +0800 zhangchun <zhang.chuna@h3c.com> wrote:

> >> --- a/mm/highmem.c
> >> +++ b/mm/highmem.c
> >> @@ -220,8 +220,11 @@ static void flush_all_zero_pkmaps(void)
> >>  		set_page_address(page, NULL);
> >>  		need_flush = 1;
> >>  	}
> >> -	if (need_flush)
> >> +	if (need_flush) {
> >> +		unlock_kmap();
> >>  		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
> >> +		lock_kmap();
> >> +	}
> >>  }
> 
> >Why is dropping the lock like this safe?  What data is it protecting and why is it OK to 
> >leave that data unprotected here?
> 
> kmap_lock is used to protect pkmap_count, pkmap_page_table and last_pkmap_nr(static variable). 
> When call flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP)), flush_tlb_kernel_range
> will neither modify nor read these variables. Leave that data unprotected here is safe.

No, the risk here is that when the lock is dropped, other threads will
modify the data.  And when this thread (the one running
flush_all_zero_pkmaps()) retakes the lock, that data may now be
unexpectedly altered.

