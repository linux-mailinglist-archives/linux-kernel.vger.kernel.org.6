Return-Path: <linux-kernel+bounces-287476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A0B95282B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9A1285D52
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D46C2C1A2;
	Thu, 15 Aug 2024 03:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ff8gZrmF"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CC51D545
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723691602; cv=none; b=D7QPMtpEs8+/Gm+pXmzGhqZgDRmylhuJoB5jp0ArRWa8XEJPfZxzJiNxmzc4//+k7mJ5RwpCb8M4Lm2SSUTdqbECYsOpLXNo7LLraf7hdBWKovAKMK0z1ipBw4ZBTuacZqpspAeB6ShDlt1YoaJ1CSRb/vWxi6UYswouvsmSH4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723691602; c=relaxed/simple;
	bh=nMMaWQiB0qYc73Kc9ZbapW7A2CkNeaOPs6WVx9G/B2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/eQvdvf6Inow+14vU+UyAcQMo5lHQWCcCViamWyu9QvJ5XpayhM2zTRNzEsarmGC9eDj4YX3lNj3uc96uwfq3EkaJSKuEuTRrdAHtchpP61whXMTZFQ3L3Os7uIuUx6Q8ax0wGiPUJcUs5hdKMT6glNJDE4K3VLoRj/t/5A9kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ff8gZrmF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd640a6454so5820195ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723691601; x=1724296401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/2QRNR8+6EF7fidSTwruEnZbFCDgCCEDKWmftPIjM40=;
        b=ff8gZrmF4/edUZCeSoahtrh+G+e/Yv3gxAHzfH5hBV4qxFMpdJzgT2Ue+k5PoL8W8n
         9V6VJVVTY5VwJp6+GOtWiPyqR0Zj2MbDO7CP7dptNTRIyiGE7gLZ5DGd0M6G3TJ456XX
         qJcj+OKgfhrAs0hTRhMNUQ1puG03zKVT22qDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723691601; x=1724296401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2QRNR8+6EF7fidSTwruEnZbFCDgCCEDKWmftPIjM40=;
        b=S3KF1f6KpbQZZQ8vMUv6nKFpYmlepW4oDo4++nWI3q42QbSsmNyP4kHeCorduTSDuA
         FKBgcEzdREuhh0BT4jxuHYxLqX0cw4imuYacDPNlf0/F9nXoVTQcfocS9xAKuxSkPOx/
         ivKGiMs+yq+8kXV8sNC/qd/1kuj5gAlGv6hcm0jhjujs2TSKZSssonmO6kWKn4wzbsAT
         OQ8XEhsUSYlEmncYT7bU+THoOsYtuBz0GA/LkZV+h9TUxJFuhG0FsZT0BIXBoqwJTlUo
         xOXohQ2ApDlL9JuKcvQkjaEOqUbXWkyOMcLGnGM/VInnjxWxOqUqHsWr6NT3V+wTZQlR
         eSyw==
X-Forwarded-Encrypted: i=1; AJvYcCX1f+ZS7RlYiT9fLtwAExJMUADBvglJ/6CMT2OiwIs+CdzD07zAr4Xe24/1Zg3OzJ6C7ywa6a+U4rcmfAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Y2rkvmJUANIXaMcwsmw3PJqI/KhmV89ge9xgFIAoEt63chyr
	2IgUiDOUeSTOkGdo96/vyPyFF/6OFmjrp9tKp72De16UAkoHadzVex6VTpKSAA==
X-Google-Smtp-Source: AGHT+IFcE+QAUw1Xb2q5oNbVpZ6CwP5UBZo74femXozM7V0Ikea9OYg6dkTadOCjjUnRZ5fms91pcg==
X-Received: by 2002:a17:903:35cf:b0:1fd:91b1:7883 with SMTP id d9443c01a7336-201d63abef6mr60223675ad.14.1723691600724;
        Wed, 14 Aug 2024 20:13:20 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7dc:2307:3c4b:963e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03a565bsm3116565ad.263.2024.08.14.20.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 20:13:20 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:13:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Alex Shi <seakeel@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, alexs@kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, minchan@kernel.org, david@redhat.com,
	42.hyeyoo@gmail.com, nphamcs@gmail.com
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
Message-ID: <20240815031314.GA12106@google.com>
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
 <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
 <20240807051754.GA428000@google.com>
 <ZrQ9lrZKWdPR7Zfu@casper.infradead.org>
 <c3f60e2d-8355-46ec-845e-0893dbe5e4f9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3f60e2d-8355-46ec-845e-0893dbe5e4f9@gmail.com>

On (24/08/09 10:32), Alex Shi wrote:
[..]
> >> and we "chain" zpdesc-s to form a zspage, and make each of them point to
> >> a corresponding struct page (memdesc -> *page), then it'll resemble current
> >> zsmalloc and should work for everyone? I also assume for zspdesc-s zsmalloc
> >> will need to maintain a dedicated kmem_cache?
> > Right, we could do that.  Each memdesc has to be a multiple of 16 bytes,
> > sp we'd be doing something like allocating 32 bytes for each page.
> > Is there really 32 bytes of information that we want to store for
> > each page?  Or could we store all of the information in (a somewhat
> > larger) zspage?  Assuming we allocate 3 pages per zspage, if we allocate
> > an extra 64 bytes in the zspage, we've saved 32 bytes per zspage.
> 
> Thanks for the suggestions! Yes, it's a good direction we could try after this
> patchset.

Alex, may I ask what exactly you will "try"?

