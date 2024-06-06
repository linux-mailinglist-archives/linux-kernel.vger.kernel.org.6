Return-Path: <linux-kernel+bounces-204335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947D38FE75D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D896B23FCB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1E5196450;
	Thu,  6 Jun 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUJRY/qS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF0195B07
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679653; cv=none; b=WBeuJxeazTAHvm/6vwMszHvW1CF3Y2YDYX7jJsftSYDvoppQGgRmSDDtKGmiDkeuquS+OXWJvkepWSxk6j80bwHqbCoVyC0oN9wR2paXlCyxvC7QN1Szsaz/FixRk+awOqbDNHkN+4eeVNTeSelSWZ8V2uo7UhVaOgTOWbVVIvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679653; c=relaxed/simple;
	bh=lfT8JPB4EPm7jxr8JpU0YG0ocWc9/9yGGGGFE8+4XY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3iw7MMTfuHz5RSzborPrYD+/fgGC26y4FkFdTgx5jO+AKaRys1BgMZpWkVZnGiFrhBXBruxBUEElCmt9RuGvKEzplp3IIX3fhaRYZMWiksISuZYDePCjW7NUTkNmzY6Bhxv8ZHtWmdZsuF2qXIfcCrNXi+477EeRuXSQXmxcbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUJRY/qS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717679650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3sv8BP20qLzYNDYwYiUPNVzPr3CjiidPi2llEU3NezI=;
	b=OUJRY/qS7ZSjw0TzdB3omBtbT0eCpsbK/ZCIK2DmC5MOL9aUpyzdGcP3HRbgXt2Y1Wu1cl
	R+9PYaQJfGLxtQJmWk8d84G1rpnaDqrMoJAL8roCCnM85qv9z+wIF5xFMVzMOAbrODPG+D
	mNgETbImuV6IAjFXQb6ww5TyUWhIsig=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-1h53aZBQNXmSqM6C9Ryh9w-1; Thu, 06 Jun 2024 09:14:06 -0400
X-MC-Unique: 1h53aZBQNXmSqM6C9Ryh9w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6ad77c0aa3dso566226d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679645; x=1718284445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sv8BP20qLzYNDYwYiUPNVzPr3CjiidPi2llEU3NezI=;
        b=upK2uLGNm8vruWQnbW+FMJoJp0JhMAlBacE2xdxLI40lDTM4fm1aUcfYPocpPYa0wC
         DFRANPktggcD3G1F1l0unRVg31bjYm3AD7KqwJ4eXwN2OmFzulXLzKut0WSaW1L75Law
         brl1RW07M1GNPeQq4kaLJXv0SsabbiuOy2tl1N0+W7JP/FjqAE3ml8DI+XmwsSsJzzRs
         ktCG3fLFYJj0cWJ/eHy21p9eUi3eHnfuLkkwQhJBXPCnDL+GqXFvELsg1EcQVocOfQNa
         /fv3Io46pB2oFsC9xBDbeQWiqBM5TGUgVfy30p3PSyXINR+lnZsbADsOWnHcDE+wWknw
         1+GQ==
X-Gm-Message-State: AOJu0YzvUOVEUjDRgD/5+RzkZFmukp2PghaB8vvGkQy97xZrlrmacImG
	ni3XgiCDeJAkxGTtz4VKdbNKm5e2l0pscXAPge+pvC7iLLHHmnb0ih7HlR6mot2xfvU1egTPtgl
	HUeZ269vwpGma8Qlf2XM5GnvosdDb6Pa9IVoT24KntFC/cC3g+LLwlcU1/H1Q7w==
X-Received: by 2002:ad4:5d6e:0:b0:6a0:a4eb:bcdc with SMTP id 6a1803df08f44-6b030a7e3e9mr57081076d6.3.1717679645349;
        Thu, 06 Jun 2024 06:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0c6hpgSWYYwXOOmcrAHLoDdT34ON7mNLV662Q3lKDSB8ab5uSZaStQg0NJ8IsQpIZHyk+AA==
X-Received: by 2002:ad4:5d6e:0:b0:6a0:a4eb:bcdc with SMTP id 6a1803df08f44-6b030a7e3e9mr57080496d6.3.1717679644489;
        Thu, 06 Jun 2024 06:14:04 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f9f8343sm5986836d6.126.2024.06.06.06.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:14:04 -0700 (PDT)
Date: Thu, 6 Jun 2024 09:14:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Dan Williams <dan.j.williams@intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] mm/page_table_check: Fix crash on ZONE_DEVICE
Message-ID: <ZmG2GciaQRTk-Yam@x1n>
References: <20240605212146.994486-1-peterx@redhat.com>
 <20240605150543.87c81189fa7cb562e73fa0b8@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240605150543.87c81189fa7cb562e73fa0b8@linux-foundation.org>

On Wed, Jun 05, 2024 at 03:05:43PM -0700, Andrew Morton wrote:
> On Wed,  5 Jun 2024 17:21:46 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > Not all pages may apply to pgtable check.  One example is ZONE_DEVICE
> > pages: they map PFNs directly, and they don't allocate page_ext at all even
> > if there's struct page around.  One may reference devm_memremap_pages().
> > 
> > When both ZONE_DEVICE and page-table-check enabled, then try to map some
> > dax memories, one can trigger kernel bug constantly now when the kernel was
> > trying to inject some pfn maps on the dax device:
> > 
> >  kernel BUG at mm/page_table_check.c:55!
> > 
> > While it's pretty legal to use set_pxx_at() for ZONE_DEVICE pages for page
> > fault resolutions, skip all the checks if page_ext doesn't even exist in
> > pgtable checker, which applies to ZONE_DEVICE but maybe more.
> 
> Do we have a Reported-by: for this one?

Nop, I just hit that when I started to look at the dax issues.

> 
> And a Fixes?  It looks like df4e817b7108?

Yes that commit should be proper.

Thanks,

-- 
Peter Xu


