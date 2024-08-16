Return-Path: <linux-kernel+bounces-288987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE8B9540DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 262BDB21D33
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD78D78C99;
	Fri, 16 Aug 2024 05:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="j+y/LT96"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB92C7711B;
	Fri, 16 Aug 2024 05:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784831; cv=none; b=kZx+Rznd0RO3Q61rvfkzbZmIBckIpnXBtz5U2RHESgDqhfZfFZHJhLxRJaqOJbpa9lUI4t7oqr4L2BLeA7dkIcxb+qp+60riyk4JsseMSProGfCkkKhJIl1UYExTsdv54OQQ0vSiHIbnwgBPEEDSaB56oJ4UbNVbglmFKD+nfzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784831; c=relaxed/simple;
	bh=fVTFzKmGilLgCOyO5lFikSEeFJ8MfmdAx7V+UZK0OKQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cI4ebbZoc4ubQ9fg7mz50O3evqMhabGr7MBvosz54u7wh71IxHdFil80ZVLfQsI+JvRdmOqHaKWrtBJ+WPT0uDbRg5eZsq9Is2/ZWW2igLokniFxDaqw+dmshuINoHoaG2+dUtndGzIW6PIKVCmvzYquk8OdywiFTR2GnVAbTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=j+y/LT96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC38C32782;
	Fri, 16 Aug 2024 05:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723784830;
	bh=fVTFzKmGilLgCOyO5lFikSEeFJ8MfmdAx7V+UZK0OKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j+y/LT96GF5Yrb4iQ5H260+KTEB00Efqr/TA+1iKOCpi/wk+z3hdRpoh9BarM1RED
	 DqmJyBb4RIOOKtTKriEKhVuAnzul74ZLMxxn+vGiGME+/e7Y5ZOVswy9NHDYMq6BdR
	 cEei7b/KJZ4JAi17fbE6Sd/Ly3iEqoUJW5aABGx8=
Date: Thu, 15 Aug 2024 22:07:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Barry Song <21cnbao@gmail.com>, Hailong
 Liu <hailong.liu@oppo.com>, Christoph Hellwig <hch@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>, Tangquan Zheng <zhengtangquan@oppo.com>,
 stable@vger.kernel.org, Baoquan He <bhe@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-Id: <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
In-Reply-To: <ZrXkVhEg1B0yF5_Q@pc636>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
	<CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
	<ZrXiUvj_ZPTc0yRk@tiehlicka>
	<ZrXkVhEg1B0yF5_Q@pc636>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Aug 2024 11:41:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:

> > > Acked-by: Barry Song <baohua@kernel.org>
> > > 
> > > because we already have a fallback here:
> > > 
> > > void *__vmalloc_node_range_noprof :
> > > 
> > > fail:
> > >         if (shift > PAGE_SHIFT) {
> > >                 shift = PAGE_SHIFT;
> > >                 align = real_align;
> > >                 size = real_size;
> > >                 goto again;
> > >         }
> > 
> > This really deserves a comment because this is not really clear at all.
> > The code is also fragile and it would benefit from some re-org.
> > 
> > Thanks for the fix.
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> I agree. This is only clear for people who know the code. A "fallback"
> to order-0 should be commented.

It's been a week.  Could someone please propose a fixup patch to add
this comment?

