Return-Path: <linux-kernel+bounces-318780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC0F96F33F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1E9B23791
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F0A1CB339;
	Fri,  6 Sep 2024 11:39:59 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6E91CBE8D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622799; cv=none; b=IjaitkwTbkVBpzieAQGazZbv9NZijo+Y3zyuuBRQu7Oplev6XYTofdJAYiSmqRMU05e0zkKGEsUW2ZgDpnbJLIXpoy9FVJa4uRGvkSmtNMgld3vwCOAqKPivl+lWHpeTMrcA2YNcqvAGJBRdtPbNrLjwwUSbc4/KfKCDAxrK73k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622799; c=relaxed/simple;
	bh=b6EX1KbjDsbwjjyz8D2+nppHJaklNhNxOJ4QiOIDYDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXdHylLH/Lm55jzytpbbL8S6VAF5WR2PSN/LCB+oOBeLctsZK0IG6S5sLHfrmXV5hrlekhip+dEos/T3OSZgTEf9enzPMzm9VwIVqecJ0AODd+su4VVGCFpDA80SvaparNuyNnvTiG+X/RIqn0CPQ/Qt7RU3ApQyyMrP7U4a+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.67])
	by sina.com (10.185.250.23) with ESMTP
	id 66DAE1BC000070D4; Fri, 6 Sep 2024 19:04:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1108818913234
X-SMAIL-UIID: 851DCCE2AE5142398F3D38AD0207E054-20240906-190431-1
From: Hillf Danton <hdanton@sina.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: yosryahmed@google.com,
	mhocko@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: introduce per-node proactive reclaim interface
Date: Fri,  6 Sep 2024 19:04:19 +0800
Message-Id: <20240906110419.2079-1-hdanton@sina.com>
In-Reply-To: <jw5skccxwi3u7i2ieb2l5gamekobbiankxbdzcxtctd636fh4v@wrfgdmkomiu3>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 5 Sep 2024 16:29:41 -0700 Davidlohr Bueso <dave@stgolabs.net>
> On Fri, 06 Sep 2024, Hillf Danton wrote:\n
> >The proactive reclaim on the cmdline looks like waste of cpu cycles before
> >the cases where kswapd fails to work are spotted. It is not correct to add
> >it because you can type the code.
> 
> Are you against proactive reclaim altogether (ie: memcg) or this patch in
> particular, which extends its availability?
> 
The against makes no sense to me because I know your patch is never able to
escape standing ovation.

> The benefits of proactive reclaim are well documented, and the community has
> been overall favorable towards it. This operation is not meant to be generally
> used, but there are real latency benefits to be had which are completely
> unrelated to watermarks. Similarly, we have 'compact' as an alternative to
> kcompactd (which was once upon a time part of kswapd).
>
Because kswapd is responsible for watermark instead of high order pages,
compact does not justify proactive reclaim from the begining.

