Return-Path: <linux-kernel+bounces-315886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FA196C822
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51683B21D01
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EF41E6DEA;
	Wed,  4 Sep 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtQvlasp"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18A613A276
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480257; cv=none; b=cDVl2vCn3BL7dOdsWNob4coBxgD7n//S1BQWbw2u4TECshfp0RRnnkld1/URLp0jLjfmHBM7RXv+nwW5RXZBuCUz1r3lgpVsKMiA5bkAkeLBUzyWPvusQw9ncORj8TDOWszH1PLMin4ZVH/KETu4wMzMaRL702/4b7v8aFFNqIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480257; c=relaxed/simple;
	bh=Nwwtm3gb5EVFg1QQ8q5oQ2lg4UdV1nv5ZcbJYMrhVjI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDAmdYtiDb3tOlz99o/rU0JkT0ZOopwms44u0G/N0sctTp+rO2O+8KLn/pd7SM5mQvruG/8lQguZemxvc4hwCp/pcbeGjsSfJcMR1efr76h6D1P2Yj/4/rtopdMAMkx13+gvSzPzwudVOQxDjISw8W6A2l17+OQL1ayLf+UWbBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtQvlasp; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2da4e84c198so977345a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725480255; x=1726085055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7P01zdosL/Ew6te7Jee/NFhd5KWytMh+G9FICWSXg50=;
        b=NtQvlasp1+U0Z8iFVyBk5YckkVUhWMBn2iXpxH42WxsOAJU3ux9I9jHAzEqyqV4qF7
         qO6irgWaWV4ElbbktPZeivKGZ0Oi3vTTZa+n1ut4YhD3Y2DFHqqsz1W4baTW6AME5qpG
         gM8YNs9XPmToJPQv4DK0ZEJMSSuiB08PWwGmscRxJdiSVerqBJ7oOhuLb/HwdDnLs4Xo
         YptIpNZRk7RO01O0zsZMFO1G9CZxijsq/dORGzjgl5vTQjskg1+X6m5Afehh+yUhgVSd
         amkqo6ooihB8WxAU2AvcYqLhZRsrMSTn6kcAxN5f9TkcHrU7xGs6DM1cmUvw56PV+sCK
         iLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725480255; x=1726085055;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7P01zdosL/Ew6te7Jee/NFhd5KWytMh+G9FICWSXg50=;
        b=N1IJiaN35OtB3HvKUPLBdxhLY5KM25yuU91Jgkh5F037bi1fl+X3ZkTvYVdZITOxCj
         78jE1eP0E1XShjAuCTrtwtomeB9xB+kBL9AHWEWjtvc8AnsPP9cWMeN9TwTEtY6qNUU3
         s7JOJ6GppRq/hr325sQjCA9YuxNzfKfdvKWTucQHI48+aQTTlTUBnSDJBJs0ny5yITGl
         PpCGyh6elw2+Z7ASPr7Y8cobMg+eAsEc+Azc75IIHE4NcJIqREee6M91MK7LC8ZOdCp6
         kmWmStuRHf2o2KrdiwSD+f0nk8rR0FtU8H/JjVZk4OA/raoeIfNxe8Xtefpcl28ABOkV
         FoIw==
X-Forwarded-Encrypted: i=1; AJvYcCVKAbQl0Txow7LltlTeLSP6Cz+55kwY3tL0vFmwDTG2S2q9E2pfmY0qjxDXI77Eg9IgK9RxmLrLrTrXCJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHr13sjXSG8+THI7ptMQZpnrsPnR3xQWJ08VG48yoIP4ZXkWuj
	KX8fQqO9KUFkebHNWOKgJJCnUedE4w/aMkya0AdLr0IQ/LmKDJDU
X-Google-Smtp-Source: AGHT+IEoupr+sdgE5S7hpAYxcU7rovNwhSDGb7GQdjQ7KQ4AA1F5858sPAcOf/1h9zP1BirAMX5E5g==
X-Received: by 2002:a17:90a:ce90:b0:2d8:6f73:55a with SMTP id 98e67ed59e1d1-2d86f7305edmr18806198a91.25.1725480255089;
        Wed, 04 Sep 2024 13:04:15 -0700 (PDT)
Received: from DESKTOP-DUKSS9G. (c-76-133-131-165.hsd1.ca.comcast.net. [76.133.131.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da6a50265esm4105761a91.51.2024.09.04.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:04:14 -0700 (PDT)
Message-ID: <66d8bd3e.170a0220.18832.0206@mx.google.com>
X-Google-Original-Message-ID: <Zti9Oz8yt_2FGuCY@DESKTOP-DUKSS9G.>
Date: Wed, 4 Sep 2024 13:04:11 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Alex Shi <seakeel@gmail.com>
Cc: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, willy@infradead.org, senozhatsky@chromium.org,
	david@redhat.com, 42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
Subject: Re: [PATCH v7 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
References: <20240902072136.578720-1-alexs@kernel.org>
 <0a10e61b-f0e6-4423-996c-7884c93af65f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a10e61b-f0e6-4423-996c-7884c93af65f@gmail.com>

On Wed, Sep 04, 2024 at 02:54:14PM +0800, Alex Shi wrote:
> 
> 
> On 9/2/24 3:21 PM, alexs@kernel.org wrote:
> > From: Alex Shi <alexs@kernel.org>
> > 
> ...
> 
> > 
> > This patchset abstracts the memory descriptor used in zsmalloc by zswap/zram.
> > The descriptor still overlays the struct page; nothing has changed
> > in that regard. What this patchset accomplishes is the use of folios in
> > to save some code size, and the introduction of a new concept, zpdesc. 
> > This patchset is just an initial step; it does not bias the potential 
> > changes to kmem_alloc or larger zspage modifications.
> > 
> ...
> > 
> > Thanks a lot for comments and suggestion from Yosry, Yoo, Sergey, Willy
> > and Vishal!
> > 
> 
> This patchset could save 6.3% code size, and it's a nice abstract of zsmalloc
> memory usage.
> Is there any more comments, or mind to give a reviewed-by?

Please CC me on future versions. Most of the zsmalloc conversions seem
ok, but I'd hold off on further iterations of the descriptor patches until
the maintainers decide on what/how this descriptor will be used
(i.e. our end goals).

> Thanks
> Alex

