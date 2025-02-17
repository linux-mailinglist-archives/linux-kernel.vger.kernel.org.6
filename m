Return-Path: <linux-kernel+bounces-518262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCE1A38C86
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C91723E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B5B236445;
	Mon, 17 Feb 2025 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8cFHcE6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E2D1624F9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820811; cv=none; b=G9AQvrHK7M9FxwZM77901VYycmtmOcyUdejr9gTOtloQY9WbYRxtq9tnQXh4/ewW4gfA/l+zI5ZbQ7f2Fem/1+DE3f0jj73T8Ebi77UlI02tMDtGF5dbfD+0re9fkWLQWSOTymg3va0/opNdn9z6R1gD+6kX3SPbDtt0w2pqkM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820811; c=relaxed/simple;
	bh=ucDT6GBoStqHJkT20mNRRHWAgRMK5N5IVHD1p8ta3UI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXijn+i9U04MgUeGI3UOA9UknoWqkozwsD069pFwdEQeYiU6kypG+pfcrIXLIXTLXrfCUFhLtrKrLJ8p/xUCpnJHLPttVISDFtZr7op7XWv9oM5Y7TLgH258l/u72nYlYEVylZZLxVq3jkPp8JIOXeeuIJcxWjg1+95ZKgSxwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8cFHcE6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739820808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZtNzwN6oYPBtUXvcoMEcoLIKVzDBplhjbvzZSyIho0=;
	b=O8cFHcE6aMKRnjHouJOzKWgmSx/bSEp3P6i5yGm2K/qocmPOYlkFWnOmHEYbtBXyIHBSFq
	Jvb3s4uCzXf6xJqEOE9vhXns4waohaE78IG3TzjQhHdw39yROMqBKRWXR+I0rgYATGDcBz
	vBFM48ucK+V0QccitGzrbC0m+Iq+O0k=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-blARMLR9N9OakPaMyStJIA-1; Mon, 17 Feb 2025 14:33:27 -0500
X-MC-Unique: blARMLR9N9OakPaMyStJIA-1
X-Mimecast-MFC-AGG-ID: blARMLR9N9OakPaMyStJIA_1739820806
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8558f34d430so4735239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739820806; x=1740425606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZtNzwN6oYPBtUXvcoMEcoLIKVzDBplhjbvzZSyIho0=;
        b=h3VARg+PUHkWs8y1CQ7duPkAtR57ijwN+lSXvHcCdvXsXEspZnc8Ahk1fYZ1YYKzVW
         UbmkuZQHDQD+761BA9kBKIMk9YRHnJrtIC/9eMjW1QWi3INrdv3zarGxEzcNzH3gpewv
         6TbP1JFh81LQN93Lgf/D77A7flw3qDxIMDOtHxBSZP0hQOR2otoGBA7L9tqguQxDQ4ek
         yH7p59L54WNqR8hTFvAociAU1EIiarTmnbu91WgNFfRUzzJNgIS0GZNrtQ1ptMnQzJh7
         322PgBuMjrWmTiPX/eiZ/zXyI/7gGvHP9CuqNtyHMwcy3MjoHtSsUAcok1jmOers2LQ1
         sxcA==
X-Forwarded-Encrypted: i=1; AJvYcCV6hi3eusYfJl6/f41A0Ppe3HUWEH3Dr8VLQZ/hiuveg3dJSa0CXD1wQFu+dE5vWTOipDFBLFXVORjSqJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFu2Vk9EdilPSa+am0VgLcqSDiWr09aA9ytaBESnZoJryXDDK9
	zkAa4o1fBuxh737fWgrxOHo+sdk6JblpDUtFvmcb3qL8FnV4yr4slGPrqHXlqwCmhUtaLG7sJrs
	g5g6uZ4FQGpiIRGPDMydqOLzgMSGxLJvBwHiz0xmaE5pfve/qVC+8bvrKs6rBnQ==
X-Gm-Gg: ASbGncvY119KiQzwv8GeJnWdnLqTFV+OVABxdws2d0usAwsw3jmvtO7J1JfVYM/xTyy
	dcVMErjEGPAO6DCxGZS82KsQVeyflqSANFMxvHE/O33uP7Wso0Mf/7TUVGgTGnj8sOcGfSuDsBf
	VCy7RwMazEk+7rJsGZIaaYFH2u73RQSe5HGwJV9xyXMY4KgPlszMHMv84ePDV04suWijYf6whmA
	XiQMgwAgNUgKoMlkUuMQizYML3DecI2LUtjyGYcKIcGMLC5QFnd2Jq9j4tATosyonKsj6kMsGJ3
	lHwf8K95
X-Received: by 2002:a05:6602:6408:b0:855:505:e2c5 with SMTP id ca18e2360f4ac-8557a0c198emr258971139f.2.1739820806426;
        Mon, 17 Feb 2025 11:33:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFf69rFpHRBRUkpc6IQnX+RrUwLEtxZ5WL2tBVyd6sRG7DiWOFIsmQLCd6imqOjjp0RP03prA==
X-Received: by 2002:a05:6602:6408:b0:855:505:e2c5 with SMTP id ca18e2360f4ac-8557a0c198emr258969839f.2.1739820806146;
        Mon, 17 Feb 2025 11:33:26 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85566f8f7f6sm203761239f.42.2025.02.17.11.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:33:24 -0800 (PST)
Date: Mon, 17 Feb 2025 12:33:20 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterx@redhat.com,
 mitchell.augustin@canonical.com, clg@redhat.com, akpm@linux-foundation.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 5/5] vfio/type1: Use mapping page mask for pfnmaps
Message-ID: <20250217123320.051fad67.alex.williamson@redhat.com>
In-Reply-To: <Z6-djlOXYTDU12mc@casper.infradead.org>
References: <20250205231728.2527186-1-alex.williamson@redhat.com>
	<20250205231728.2527186-6-alex.williamson@redhat.com>
	<Z6-djlOXYTDU12mc@casper.infradead.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 19:46:22 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Feb 05, 2025 at 04:17:21PM -0700, Alex Williamson wrote:
> > +			if (is_invalid_reserved_pfn(*pfn)) {
> > +				unsigned long epfn;
> > +
> > +				epfn = (((*pfn << PAGE_SHIFT) + ~pgmask + 1)
> > +					& pgmask) >> PAGE_SHIFT;
> > +				ret = min_t(int, npages, epfn - *pfn);  
> 
> You've really made life hard for yourself by passing around a page mask
> instead of an order (ie 0/PMD_ORDER/PUD_ORDER).  Why not:
> 
> 				epfn = round_up(*pfn + 1, 1 << order);
> 
> Although if you insist on passing around a mask, this could be:
> 
> 				unsigned long sz = (~pgmask >> PAGE_SHIFT) + 1;
> 				unsigned long epfn = round_up(*pfn + 1, sz)
> 

Hey Willy!

I was wishing I had an order, but I didn't want to mangle
follow_pfnmap_start() and follow_pfnmap_setup() too much.  Currently
the latter is doing:

	args->pfn = pfn_base + ((args->address & ~addr_mask) >> PAGE_SHIFT);

If follow_pfnmap_start() passed an order, this would need to change to
something equivalent to:

	args->pfn = pfn_base + ((args->address >> PAGE_SHIFT) & ((1UL << order) - 1));

Looks pretty ugly as well, so maybe I'm just shifting the ugliness
around, or maybe someone can spot a more elegant representation.
Thanks,

Alex


