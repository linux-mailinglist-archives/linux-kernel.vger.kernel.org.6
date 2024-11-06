Return-Path: <linux-kernel+bounces-398930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEE89BF828
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265D4B22FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5554420C48F;
	Wed,  6 Nov 2024 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lJWCNvGH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94DB20C487
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925748; cv=none; b=i3Zs4JGizuskfvy9B81ytwML/tzVUFIlyAIGj/TnqWS6VGIrcg+cpANRWhw5uXaHlhrwuWmu54fmgmXJLeV/RlJogdzwHxmVESqz43xSazWT5lyARN4wGfKzSNgbLgtIpcj1gp4FKiltDGWb7b4DfwvMFk87loiQyuCTe5s/KoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925748; c=relaxed/simple;
	bh=Ib6H9fR5I9GUBeW/NbyrXJtXsVF6eBCwNR6pv3nYMrI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cz68LdirNLWxXBngalK5xr0sn6lAlHT9KVztNEHrfom8xf3ZomwQOK556vEBlQCopX9OD/5OGsPOFX+EqiCM8Ta52Xqyc7Lv/nmqYifGL51+lmqnRq8Ygdn2YXt876mL8BYybD7X4rLzwcFKttA/W12Bt7eSSEISp/isTxvN+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lJWCNvGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91722C4CEC6;
	Wed,  6 Nov 2024 20:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730925746;
	bh=Ib6H9fR5I9GUBeW/NbyrXJtXsVF6eBCwNR6pv3nYMrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lJWCNvGHdUprCOPVuf629SfJ0VvTqN+hY9HER1iQipszU+K/DGmOzZf9fCBDO86EZ
	 z0BSe3z9oNBtJgm1/WEPvQGdEIpItduW+PJKi54rSW1qjbhOGgxMoiyePYggNi5KFW
	 k8bUQIBMnEwfd5pnUYys5Ukg0wyTXOJIro0zXbEM=
Date: Wed, 6 Nov 2024 12:42:25 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, Nhat Pham
 <nphamcs@gmail.com>, Usama Arif <usamaarif642@gmail.com>, Chengming Zhou
 <chengming.zhou@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, Hailong
 Liu <hailong.liu@oppo.com>, David Hildenbrand <david@redhat.com>, Hugh
 Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, Shakeel
 Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v3] mm: count zeromap read and set for swapout and
 swapin
Message-Id: <20241106124225.632b42c3680cae0b940d2871@linux-foundation.org>
In-Reply-To: <CAGsJ_4zYiRzG6mBnW-2wh7YCo_PJQc7u1syd05DNdic7MaE7Zw@mail.gmail.com>
References: <20241105211934.5083-1-21cnbao@gmail.com>
	<20241106150631.GA1172372@cmpxchg.org>
	<CAGsJ_4zYiRzG6mBnW-2wh7YCo_PJQc7u1syd05DNdic7MaE7Zw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 7 Nov 2024 09:01:14 +1300 Barry Song <21cnbao@gmail.com> wrote:

> Oops, it seems that it depends on Kanchana's 'mm: change count_objcg_event() to
> count_objcg_events() for batch event updates,' which also isn't present in 6.12.
> 
> Otherwise, it won't build, as reported here:
> https://lore.kernel.org/linux-mm/CAGsJ_4whD31+Lk0m2uq-o=ygvkRsw1uXcPeqxBONV-RUXkeEzg@mail.gmail.com/

argh.

> Hi Andrew,
> What’s the best approach here? Should we include Kanchana's patch that extends
> the nr argument for count_objcg_events() in 6.12-rc as well?

Let's do the right thing here.  I'll drop this patch from mm-hotfixes. 
Please send a v4 against Linus mainline fairly soon then I'll redo
Kanchana's series around that.


