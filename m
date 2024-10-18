Return-Path: <linux-kernel+bounces-372339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 880619A475E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23FA1C22DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77AF206E85;
	Fri, 18 Oct 2024 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MSO/RmjZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB85D205E3B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280820; cv=none; b=qsRfgff43IwoAaIcUTMaZYkurqibH6uwZ6wdaOusnoFt7Z1QLep0dGMMvPvb0dnavYzpkNMYJ2O91c+J25xyXqG0JCxQ1vmhct77Z4BWyDVViuZD5POrSR+OySxrDsNFC+FXL9qM50jJM8+K079AG7FVVBaRaKcts5BrmpkDqNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280820; c=relaxed/simple;
	bh=hHBuVpG/NK3K94q+q1dgCwzmjlvmZ6FGKW67Ar1jef0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FORSFZ2+RRR2ztpBdy/ym6CKYHnlz9axN0mwLlkb3j5VEU2WC8Uwyfhdm6Bh7nedr2IquugNBhoty114J0LfCiW/fidYlr369g7wAGXeQeJFpp9m0tx5rbj5zsyo5Ij+8aT5rL1OXRljsvv+jG41FUiCSVL8rNgC6+pXQIOznoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MSO/RmjZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+VepyXiZbx9uJ8aegzhYRA4ICpuwx3cagiAD2SqI8CE=; b=MSO/RmjZ+PMCZR1NX0HIi2Ojmf
	2Ht9l87B9J3ICbjuh/j9YXg0Odsrih/GKYTGy/trXKYhRjZHtYhmsAw/7ii/n5JpWzmCml0ypXSuA
	piDB23ud9Ktr6deNfhGSWQ8ZypbvAfRIDZrNH5Dil5D68vHRwymZDf2Jd9jHIsbRzSXQXen0wu5SL
	2g7FAACSQ4Kw/OTdtiHP+LYQc7Eg5Fs0P3WOOeh++BWyYizQobL6wA7qrrQxCSvzhZkjBtOmzNbNZ
	hBUAY2C8jPsK/pPqdF5Aq1LgNkQSYL/NIbHOr/jp2x9VftcoTXlv9WuBjGijEs3ZelxfvGPvtB9cP
	JlF1Nphw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1svj-0000000DXBu-41oR;
	Fri, 18 Oct 2024 19:46:35 +0000
Date: Fri, 18 Oct 2024 20:46:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, zswap: don't touch the XArray lock if there is no
 entry to free
Message-ID: <ZxK7G3S0N42ejJMh@casper.infradead.org>
References: <20241018192525.95862-1-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018192525.95862-1-ryncsn@gmail.com>

On Sat, Oct 19, 2024 at 03:25:25AM +0800, Kairui Song wrote:
>  	if (xa_empty(tree))
>  		return;
>  
> -	entry = xa_erase(tree, offset);
> -	if (entry)
> +	rcu_read_lock();
> +	entry = xas_load(&xas);
> +	if (entry) {

You should call xas_reset() here.  And I'm not sure it's a great idea to
spin waiting for the xa lock while holding the RCU read lock?  Probably
not awful but I could easily be wrong.

> +		xas_lock(&xas);
> +		WARN_ON_ONCE(xas_reload(&xas) != entry);
> +		xas_store(&xas, NULL);
> +		xas_unlock(&xas);
>  		zswap_entry_free(entry);
> +	}
> +	rcu_read_unlock();
>  }
>  
>  int zswap_swapon(int type, unsigned long nr_pages)
> -- 
> 2.47.0
> 
> 

