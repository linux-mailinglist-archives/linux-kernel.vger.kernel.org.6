Return-Path: <linux-kernel+bounces-321188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655B59715A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C43B2215B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624A71B4C40;
	Mon,  9 Sep 2024 10:53:01 +0000 (UTC)
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CE12B17C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879181; cv=none; b=CFzC+Rvqbad8cy8JdYNMx6u7IUkjwPw/qXL0Biq6W4C4ka+u9x+YYZMkWFgKC8FZgETew3a5S99ePbsXgNjhcoq4gqIFSjK/TDu/MPP6/ErVdTM+QP7CpUbXFrrpOJgXlJikhuxo8sHc1jmu1r7jI59+ZTQHIRhKEYu7dj0TC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879181; c=relaxed/simple;
	bh=k6rzkPhOo6lj4rSMToLU4dfqNi1A2723OsN/cGNSVqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E1Vn3/Umn5eOXGcuYqxCCZ4S5eeQxYR3s+W5NeS4+fcvV82rUBGIuabse+sv9Sui6yCdupmvasroikFnjnYKTpjxAXLuZQ6EKPMlhSISYCAHx7inZNx/b5SZJcwOkGAL6WB0N9+aHY247mk2nsQWKIbQIUkn/V+LvIUhFeanrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.122])
	by sina.com (10.185.250.21) with ESMTP
	id 66DED35700006845; Mon, 9 Sep 2024 18:52:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9132623408182
X-SMAIL-UIID: E5A1A39DA601451EA2E93BE98ABAF976-20240909-185210-1
From: Hillf Danton <hdanton@sina.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	yosryahmed@google.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: introduce per-node proactive reclaim interface
Date: Mon,  9 Sep 2024 18:51:57 +0800
Message-Id: <20240909105157.2663-1-hdanton@sina.com>
In-Reply-To: <Zt6fw4ibDq_XA_0q@tiehlicka>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Date: Mon, 9 Sep 2024 09:12:03 +0200 Michal Hocko <mhocko@suse.com>
> On Fri 06-09-24 19:04:19, Hillf Danton wrote:
> > On Thu, 5 Sep 2024 16:29:41 -0700 Davidlohr Bueso <dave@stgolabs.net>
> > > On Fri, 06 Sep 2024, Hillf Danton wrote:\n
> > > >The proactive reclaim on the cmdline looks like waste of cpu cycles before
> > > >the cases where kswapd fails to work are spotted. It is not correct to add
> > > >it because you can type the code.
> > > 
> > > Are you against proactive reclaim altogether (ie: memcg) or this patch in
> > > particular, which extends its availability?
> > > 
> > The against makes no sense to me because I know your patch is never able to
> > escape standing ovation.
> 
> I fail to understand your reasoning. Do you have any actual technical
> arguments why this is a bad idea?
> 
> > > The benefits of proactive reclaim are well documented, and the community has
> > > been overall favorable towards it. This operation is not meant to be generally
> > > used, but there are real latency benefits to be had which are completely
> > > unrelated to watermarks. Similarly, we have 'compact' as an alternative to
> > > kcompactd (which was once upon a time part of kswapd).
> > >
> > Because kswapd is responsible for watermark instead of high order pages,
> > compact does not justify proactive reclaim from the begining.
> 
> What do you mean? How does keeping a global watermark helps to trigger
> per NUMA node specific aging - e.g. demotion?
>
In addition to the cost of pro/demorion, the percpu pages prevent random aging
from making any sense without memory pressue, because I think it is aging that
rolls out red carpet for multi-gen lru.

