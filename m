Return-Path: <linux-kernel+bounces-279625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBCA94BFB4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2B2B217C7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D0818E74B;
	Thu,  8 Aug 2024 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsikmiK4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3542C0B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723127656; cv=none; b=rN5z1tmnZZC/ql0db84DTtdUWlY6HDIKR8JBYFoi/0CPXAfK00bE/IwcwIPA86dNGG0tkpUpZEgAr5L5w4NJav35ErF3dc14K8iXOVI1Vcgf73+pol4QJhZqLupZrK8e5gw0Jzrghu8/st19Js/vZUzCo12NW2QWMVMwagCX30I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723127656; c=relaxed/simple;
	bh=/aIJG1hVZZvu2F0Vp0fsC9VhKxCP9bBrw5jhrPk7xlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrqcpvpBJ1Jiq76D2plTMRNeyG6AvKDp7IL3cVIkwBCHbX0LzsbdHDicmmPf87Kac3dKkiUKYtsf3098+iuP9DbmRijOks+SjzRSE1WdQrapXwCebETjcLbQqM4H5VPrnw+i3lc2I5s1nL3EiYV0WYLEvfwtF+eeJMOdUvgqkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YsikmiK4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723127653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kNGFee3br1hjECiovXqSOfAESUmkPD9eLr9HZ2AG11Y=;
	b=YsikmiK4IiythBycMoyvukIgvHLtsRPYozCsKXo5BWKGCJwP8npqAw3z0ZPkS6Nw2Mx/3+
	GCC6imsAIUVSw6tZpg5FvEPdKWZM99+xJmHlTo8axI8H5E6C+/QtCeaL3riSrTL/yo5fqU
	AXxmbF9fvCTyxK7zCCjYI8w1B7WxIak=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-MZwYydRNO_yqB3pcSG5u7w-1; Thu, 08 Aug 2024 10:34:09 -0400
X-MC-Unique: MZwYydRNO_yqB3pcSG5u7w-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a1d5ee7762so780485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723127648; x=1723732448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNGFee3br1hjECiovXqSOfAESUmkPD9eLr9HZ2AG11Y=;
        b=Li6PkSTgHbzsGpF+Y+yLnp4pgP3GJD6vOdqrMREUrYCyMc5rZy1YO6mOMdx/CZXYG+
         0amtYeifZPG/QLHXF7x0hyWi3l98rRre7D7BC0+gQVUR6Z4AZhMVYpELROtMIm+FlMVZ
         /KFqW+acdRNuSCotnWSo26Qbi9KHpBZAQhALJuVtu4XptHVCgHisjhWsNxQBY8TLKKki
         EMBdymQyeNinwW7uCCAdHWl+ogEJm2e3B7Mtsx0v10z05jFyCDIiNTd3Ul9gy8/3g80z
         CJXPo3Buu52aq111I6/JnJa1h9yQ4KiLTQbBo+l03W3LKduXaI1vLpF6LWjIql45bIq5
         Ftrg==
X-Gm-Message-State: AOJu0Yz86kkZgDa48YvIewKtO9z0mTbh1EvgM8EM1FF2kp1X4NH9v8yj
	Z0FUt39jUZeUWF5DBlWeK69DBS0FARVX1UO2Cg+WWr6JFSvdTqwm1ZWZ+vas1qRZm8PcyQe2bFz
	NRE0ZCtb+Xl59g2WLddRS1r42oZV48vnRT+b5t9jx7xRCaGNhDz7JcqGqZRMSGA==
X-Received: by 2002:a05:620a:192a:b0:79d:595b:d4ea with SMTP id af79cd13be357-7a3817ee628mr147832485a.2.1723127648626;
        Thu, 08 Aug 2024 07:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkrMT/qf2Z1Zwec6CCoJX/CvM7BpTtL4mQOwgoVFYQ8j/2utHXaaQU95bCId/QVjyX8fpcMA==
X-Received: by 2002:a05:620a:192a:b0:79d:595b:d4ea with SMTP id af79cd13be357-7a3817ee628mr147830185a.2.1723127648196;
        Thu, 08 Aug 2024 07:34:08 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a378693d23sm164459085a.87.2024.08.08.07.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:34:07 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:34:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Oscar Salvador <osalvador@suse.de>,
	Dan Williams <dan.j.williams@intel.com>,
	James Houghton <jthoughton@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Rik van Riel <riel@surriel.com>, Dave Jiang <dave.jiang@intel.com>,
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	linuxppc-dev@lists.ozlabs.org,
	Mel Gorman <mgorman@techsingularity.net>,
	Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v4 0/7] mm/mprotect: Fix dax puds
Message-ID: <ZrTXXJ8r_WpPgcU4@x1n>
References: <20240807194812.819412-1-peterx@redhat.com>
 <20240807141703.d641001ee14177ccf80a31d8@linux-foundation.org>
 <ZrPoUgISLqlF-iEQ@x1n>
 <20240807144454.15a9668c23d05141ae777696@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807144454.15a9668c23d05141ae777696@linux-foundation.org>

On Wed, Aug 07, 2024 at 02:44:54PM -0700, Andrew Morton wrote:
> On Wed, 7 Aug 2024 17:34:10 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > The problem is mprotect() will skip the dax 1G PUD while it shouldn't;
> > meanwhile it'll dump some bad PUD in dmesg.  Both of them look like (corner
> > case) bugs to me.. where:
> > 
> >   - skipping the 1G pud means mprotect() will succeed even if the pud won't
> >     be updated with the correct permission specified. Logically that can
> >     cause e.g. in mprotect(RO) then write the page can cause data corrupt,
> >     as the pud page will still be writable.
> > 
> >   - the bad pud will generate a pr_err() into dmesg, with no limit so far I
> >     can see.  So I think it means an userspace can DoS the kernel log if it
> >     wants.. simply by creating the PUD and keep mprotect-ing it
> > 
> 
> I edited this important info into the [0/n] text, thanks.
> 
> So current kernels can be made to spew into the kernel logs?  That's

I suppose yes to this one.

> considered serious.  Can unprivileged userspace code do this?

AFAIU, /dev/dax* require root privilege by default, so looks not.  But
anyone more familiar with real life dax usages please correct me otherwise.

Thanks,

-- 
Peter Xu


