Return-Path: <linux-kernel+bounces-428317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39229E0CC3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CAF1655B4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC94D1DE893;
	Mon,  2 Dec 2024 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2iH3h+D"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B651DE4C3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169959; cv=none; b=VWIIy13gV3DRqgk4WGCHZWM+EjEr0wWEn+EVKXFYMSgnUj9jn7q7kr5TuCmQvQUFgMeN2OrGLbLs5UYvLV0bAtZ/kQ/a+nDDhJ8RllWHlZZqbWZ9f/actL3uv4WcnzhtQVyZviiFgKdLgZNRcGGlDr8NSHuKpGWehkSbzq2u12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169959; c=relaxed/simple;
	bh=tvI0fMppZP5TdDg3FrEaG3Djn2HFR3FR3ICXDxVWJXA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1iU3p6tsCGU/Mr8tyPMJZkUFDgSv5ugvRReFwNEQk0PSGyHWsfRx+NVDksCHZaCNgLg4qgmf6sNzH1A/jDEdambgByzbYYNam0ljn/Mq+cSZberu770J2lE1KFNqTtZ+WEokVwCI1oBGsz+I7qFS7YLFVvYHJR7KZmRXfkHrok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2iH3h+D; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2156e078563so15605045ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 12:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733169957; x=1733774757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lKx+wsSbW4y7aQytDu/WL7bD2GcTIJk5vN6zES4YuJo=;
        b=a2iH3h+D8M58nzxkQD0y4zRabFuainynChjVBNNrSy6WulfjpnT3aKfoOtAXsDrwdN
         Jmj1GpcZeE/l4mr60WosvQf69Es83wxuNMXwDalbeCgp6/zSDbkguJ5ULIxPRJERr5QO
         ZVczHHVVax29ytJOxbtOXvr0YgV6DZTldd0o87pbWs/wbdFA7NEGnjaIDxfTjIvl7tOn
         3pAGFYPB2X3780aLSCmhV1Jm/Jf8K4zSciEgqdVFny1UpEuIenoiHnBqwKMTEEI7khWv
         AME8c4WLBRdSJ4WA3Wkkj/y5k4bYXOwuEgoK6UlGHdY+JaW6faVX4FD2Tf0ionmjohmF
         x0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733169957; x=1733774757;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKx+wsSbW4y7aQytDu/WL7bD2GcTIJk5vN6zES4YuJo=;
        b=RAD/kxTJpZqzO4U/+bOOT9XjJ8Ve97T4KHVlWlfi57QZIV5KFqogsDtzSKMUSShuB9
         8gD/Vy3GBtXij8EftlOANwnErAKbjQQszqouQV0axCrBTF4+41b9/m6ejFqGSdWm07y9
         dk9T/6/3eKJ6ieWnbulrquzkOKIXus1TmwdenXMp8uLZlE8v2xOkqUYae1cKYdTdMItY
         dvzZjtDkJmb/mBoiIDLYsUoRyq8QZLgCK2ki1wCuf7dyVllMCESEGQHlPK84Z3faP3lS
         R3D5UBRkKPrnSka2WIh6rodzmUGDnf/NBUwampn77/xOEPHpeUa04Eauw8wunXFfRqLt
         kD9A==
X-Forwarded-Encrypted: i=1; AJvYcCVMe2lTLXybAMV4GIhgHQLS2/WedA8kAKt1HybZlLggYzZwAzFvkwiOER9tK8b46C61dlwleq9OFRHPpGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXOzswuN3AJ4iMX+mRxVDmkfvzTCOflv1/51O1VY+tuzE1Z5fk
	nBFlXNLabkwLIPQLX8U660k6AeHbzCtuhdZiKGGibXKoZKL7iL+5
X-Gm-Gg: ASbGncuN3VMkAHMXjsTgW8O1xQsrBNAexbleGHHnRg0sMr2qNwhuzE7FRh0o58/ulIJ
	J2p3k98OvQgDEteKRGg6GgHcosVuUkZt9LHB2ZjVgC57Sylstmp0saWH1oiaKjXaWoZ4v2Se6BB
	j6M301EWejXbYWBGc1LLwsuZEGTWzB4WHbWwGtHZM/ueFMem5fCKHwFK71YQxZXK0YYiPKaq4S0
	SBR5zjj0//H363WgCAVB9hVvaivz0ufxFAwIzUYrDFDX03q/ZWLWUYO9axqZJo5FiHyxVXAs/Og
	4jeHyFaVuKbd13LflqQ=
X-Google-Smtp-Source: AGHT+IHgaAEKCXY5HI8a0IxqQxM5vzXaBrFUcDO6dGPdmTBNiQThrPNt4i4vMbWEm24Og5PKbD/Hyg==
X-Received: by 2002:a17:903:32cc:b0:215:7ce8:1364 with SMTP id d9443c01a7336-2157ce8163fmr93345985ad.13.1733169956992;
        Mon, 02 Dec 2024 12:05:56 -0800 (PST)
Received: from DESKTOP-DUKSS9G. (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2154be15034sm56304035ad.205.2024.12.02.12.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 12:05:56 -0800 (PST)
Message-ID: <674e1324.170a0220.377d6f.b6ed@mx.google.com>
X-Google-Original-Message-ID: <Z04TIUPJQe3Vdu_L@DESKTOP-DUKSS9G.>
Date: Mon, 2 Dec 2024 12:05:53 -0800
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
 <66d8bd3e.170a0220.18832.0206@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d8bd3e.170a0220.18832.0206@mx.google.com>

On Wed, Sep 04, 2024 at 01:04:11PM -0700, Vishal Moola wrote:
> On Wed, Sep 04, 2024 at 02:54:14PM +0800, Alex Shi wrote:
> > 
> > 
> > On 9/2/24 3:21 PM, alexs@kernel.org wrote:
> > > From: Alex Shi <alexs@kernel.org>
> > > 
> > ...
> > 
> > > 
> > > This patchset abstracts the memory descriptor used in zsmalloc by zswap/zram.
> > > The descriptor still overlays the struct page; nothing has changed
> > > in that regard. What this patchset accomplishes is the use of folios in
> > > to save some code size, and the introduction of a new concept, zpdesc. 
> > > This patchset is just an initial step; it does not bias the potential 
> > > changes to kmem_alloc or larger zspage modifications.
> > > 
> > ...
> > > 
> > > Thanks a lot for comments and suggestion from Yosry, Yoo, Sergey, Willy
> > > and Vishal!
> > > 
> > 
> > This patchset could save 6.3% code size, and it's a nice abstract of zsmalloc
> > memory usage.
> > Is there any more comments, or mind to give a reviewed-by?
> 
> Please CC me on future versions. Most of the zsmalloc conversions seem
> ok, but I'd hold off on further iterations of the descriptor patches until
> the maintainers decide on what/how this descriptor will be used
> (i.e. our end goals).

I apologize for leaving this in limbo for this long. This patchset is a
prerequisite to shrinking struct page, so we should get this memdesc in.

I think it's safe to assume (since we've heard no definitive goal from
the maintainers) that in our memdesc world we want zsmalloc + zspage to be
similar to how it currently looks today.

Would you like to rebase this on the current mm-unstable? I'll re-review
it in case anything changed (and can then give you my reviewed-by).

> > Thanks
> > Alex

