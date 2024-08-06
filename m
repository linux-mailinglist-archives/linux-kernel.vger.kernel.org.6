Return-Path: <linux-kernel+bounces-276800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C0394988E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20275283148
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8254C14A091;
	Tue,  6 Aug 2024 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qyUEzKr+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D0B145FFE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973326; cv=none; b=QeAgspNxa99cyqHVvR7+xdLDNB18QF1p1UHGwqprpnclgcwJH7oa6uEC8gSdlFC9h5doAkexhD0S7bG3N+5IbMKaVu3rCLzibWytBsMtwLaUpnCOlyz0QfbP3/OA3cx5enrKfcmj9Fl0vWGGK68XmMK5rKv16EEixZsS1tSEEdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973326; c=relaxed/simple;
	bh=LpUrfQ3Nh+onJENyWi6oR67NsXEaMq6gG966WHlU6Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfYmOVs5JnkkuCDGcRSKuBgIZL97DGWvR0PmxkukdCZIX4dr3vQ1+BlWUAr71XLYbU1Qi0HNV8DOAqRaz+5SZ8l0i+ek45lf4rksb5yIuGsjzEqSupgYxOv4boBqe79hXdUS8RTUMrig9iRllsTA67INCCbfdI8Pwhb4YkzuwU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qyUEzKr+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OcfeDs1oh+IhD27f2oxJ/jS2LdWjksU5YFn4vfVo9qs=; b=qyUEzKr+xhbk/EDkrcn1DGnP9m
	g692dMdbXFCvxZwIO/FAgm50JA9CYEtiM2QhCZHBOAaB2bkrdfi7aKwvFNB6Yb0F969vx/jZo4vNR
	7TCWVoxV64Onxvk8P1Owgk8yqlBuBQIY79sqTcgVj5TvQ5C8V7ZT53LN/prk9DFHKshUEE6iW48pf
	vZaI10I3yY7NfG0Dii0bQrGRcZKntuQOd41WO+++/fJ+UCzO/j/mSvwsD3/YFdXQDjTzMVlQEIqL/
	yckitK9Rm46i+5ZO+B5/VlTV6a5/cYC7DG+sDVHmw2osfstxzhFy/lg8ob084VeiFFMNAIuepYigy
	VxpOzjFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbQ4F-00000006BXf-2Upr;
	Tue, 06 Aug 2024 19:41:59 +0000
Date: Tue, 6 Aug 2024 20:41:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, alexs@kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, minchan@kernel.org, senozhatsky@chromium.org,
	david@redhat.com, 42.hyeyoo@gmail.com, nphamcs@gmail.com
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
Message-ID: <ZrJ8hzC9z4NMYffr@casper.infradead.org>
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
 <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>

On Tue, Aug 06, 2024 at 12:34:25PM -0700, Yosry Ahmed wrote:
> Matthew asked an important question here that needs to be answered by
> zsmalloc experts:
> https://lore.kernel.org/lkml/Zq0zucMFsOwATsAC@casper.infradead.org/

Yes, and I said it needed to be answered before we had a v5.  So I'm
very disappointed that not 24 hours later we're seeing a v5.

