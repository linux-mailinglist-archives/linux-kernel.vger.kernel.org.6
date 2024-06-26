Return-Path: <linux-kernel+bounces-230027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B7F91777A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85CE8B2134E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62CE13AD28;
	Wed, 26 Jun 2024 04:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oVzZ8Fhr"
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B9A6AB8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376890; cv=none; b=uhpGk3YBYGvktB46B2iEJozOlAU9i4TTyuSXVVoVw+8yRhPDho0ou5bu6jKrOrUPUfTGRpdcDQtBHQVOJzE++cF3o9Iz4hBBqlhG/8cdZWTreiZAQn2ED+ApPYyddOsOxPkcsXqH3DWmNTc76/b+8QWawJlrLqJn0cXUiumNhtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376890; c=relaxed/simple;
	bh=kcLGBd65//0k48gsXv0ghNdgpoOWqAcMh2IHH22i4eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwCSMPZl5czb6kTVlTyA4eSd6zHyeXG/w65QOjBONwR9YxnVThR2ZvoKCUiglHTXReqNhNcZKli3QYXOOiGk+faHjDb923j3soRSpByqF8FFWkkgpdNfeoU2KeErplfPujTYt9L46a9gKQVbiOXM4z6BhKufKPS1g02c+Gu6GGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oVzZ8Fhr; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-3c9cc66c649so3112321b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719376888; x=1719981688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5SN5g9dZXd4jHj1UDwEbPoCj2yPZWkE/B6mLbVsHgM=;
        b=oVzZ8Fhr8kN2z5WnCIspjnKF+OfXosMETYdnu/qQ+1inHRa6tAre0FUfO4yqKXWFfL
         CdPDxrO01jsRhUSbPVb1OhopMpyafUB88e0Vy0trP1JQfiRaguZj5cpkhReT7QDBQaxW
         h+Ads6+etu8pdjqAnTloa7hNfcofEICOV6bMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719376888; x=1719981688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5SN5g9dZXd4jHj1UDwEbPoCj2yPZWkE/B6mLbVsHgM=;
        b=wUdrShgU/0O+H3/5bzyr+EWe0g79DOpiayUlaq4GatmyFk/ttidnT/FDTwO1QIBJsU
         SUFeeCNQkGtptDnUrev/byFoU91758HcVe9+IWxk+BDFYT5zjynLQi/M4EeWLjiRrr1K
         6ZNgv/5U0mrbwpwmqDTLimklcKjfmXpA4O2lOwB5qdShrDMILEveTTMTdsoi9VSpJI/g
         0Y/bHovJ5ninrAgIWG0iHsKSp6yZ3kG1wNdpLkFLIJSh+2lz1UVbErzLzeCaYkWweSZC
         bB+BxcAstww7hcj8vPMCmZqliTULjCAMvow1FfZE0FbDNK/PkatbBspRxRgnRDnGvZzm
         7mDg==
X-Forwarded-Encrypted: i=1; AJvYcCUPwKWhXY+upZ/Mtqqt16p+7gaqc6nOVAxyXzX9iy9ZuwdtlW/q2f3RVRO+sckwBn+CrH8QabQhROr8DB5HtUxAjdM1EW94gJcIbiwX
X-Gm-Message-State: AOJu0Yxuk8sWa5t2M+u6CNYHWyrWma1BY3ucHvwvqVzXlUb2QEHYt3Dm
	p3+nxiawSrHtV2Ym740dXEzK0RZ8Pj8T4jcmJH7v7uMcpbVtZf2tcPlcqniMUQ==
X-Google-Smtp-Source: AGHT+IHghuf3tkdv3+yfXxzpfwWFh16zBggDrPPrf7ANaGPxxHHsNrKgPM67fFuG8SW/r2HDYZAv6Q==
X-Received: by 2002:a05:6808:210e:b0:3d5:5fbe:b31a with SMTP id 5614622812f47-3d55fbebea0mr1866075b6e.51.1719376886966;
        Tue, 25 Jun 2024 21:41:26 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:d7ad:9c6b:494:edc0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7069d59dce1sm1970557b3a.169.2024.06.25.21.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 21:41:26 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:41:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@kernel.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH v2 3/6] mm/zsmalloc: use a proper page type
Message-ID: <20240626044122.GA15925@google.com>
References: <20240529111904.2069608-1-david@redhat.com>
 <20240529111904.2069608-4-david@redhat.com>
 <20240530050123.GA8400@google.com>
 <ZlnebQ0dRUvx2SgP@casper.infradead.org>
 <345161ac-3b42-48aa-ab3d-3b183316479a@redhat.com>
 <20240625153338.8a4d049857d59e692a0d31e6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625153338.8a4d049857d59e692a0d31e6@linux-foundation.org>

On (24/06/25 15:33), Andrew Morton wrote:
> On Fri, 31 May 2024 16:32:04 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
> > On 31.05.24 16:27, Matthew Wilcox wrote:
> > > On Thu, May 30, 2024 at 02:01:23PM +0900, Sergey Senozhatsky wrote:
> > >      1409:       83 c0 01                add    $0x1,%eax
> > >                  if (mapcount < PAGE_MAPCOUNT_RESERVE + 1)
> > >      140c:       83 f8 81                cmp    $0xffffff81,%eax
> > >      140f:       7d 63                   jge    1474 <filemap_unaccount_folio+0x8
> > > 4>
> > >          if (folio_test_hugetlb(folio))
> > >      1411:       80 7b 33 84             cmpb   $0x84,0x33(%rbx)
> > >      1415:       74 4e                   je     1465 <filemap_unaccount_folio+0x75>
> > > 
> > > so we go from "mov, and, cmp, je" to just "cmpb, je", which must surely
> > > be faster to execute as well as being more compact in the I$ (6 bytes vs 15).
> > > 
> > > Anyway, not tested but this is the patch I used to generate the above.
> > > More for comment than application.
> > 
> > Right, it's likely very similar to my previous proposal to use 8 bit 
> > (uint8_t) for the type.
> > 
> > https://lore.kernel.org/all/00ba1dff-7c05-46e8-b0d9-a78ac1cfc198@redhat.com/
> > 
> > I would prefer if we would do that separately; unless someone is able to 
> > raise why we care about zram + 256KiB that much right now. (claim: we don't)
> > 
> 
> iow, "this is ok for now", yes?

Perhaps.  I'm not in position to claim that zram + 256KiB PAGE_SIZE is
irrelevant, but I'm also not in position to claim the opposite.

Matthew and David have ideas/proposals/patches to fix it should 256KiB
PAGE_SIZE become an issue.

