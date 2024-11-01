Return-Path: <linux-kernel+bounces-392497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEAD9B94DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE2628323D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5221C82E2;
	Fri,  1 Nov 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ozuLuz9U"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3B1DA53;
	Fri,  1 Nov 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730476975; cv=none; b=N5PiKm731E3YGBL33vbPHcvr/iAfWhjecgpOwAXtg0WpwtPNV+zS7Wne3gZ6yiBi8vg0/OWSdrvRKAAgj8CUwiYFB+yGtOiP1KG3H5v3+lSLjS/eCyHpkHDetUwPx4flONHHXfm9VBnrSI7gf9YvLU1u2mhwCyiNcJS17gcht/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730476975; c=relaxed/simple;
	bh=RP8uuQxxz+diREH7RaCpYN2LCPYmDcWWIYKVOO9nU+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6rgeIZp2RdgKfOIxwKmdXBsohYbVH/KnKJI+EWy22c2+r/2jNTE4lwZb0Ut3Te+IGYpf+lTHX+SfcP+MZCRhDAD3B/geT0CkimUXyiHXf7TplnaRGmH4YAOr56WINdL2Hz1sQNTGyU4OEJmGh1XQncA7lht84gJSdVSMoFCZh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ozuLuz9U; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GD62pfQjRrsZlDEczFo93jALZqsvhobxeSA9hEQIen0=; b=ozuLuz9UdvmQPT1bNuge8+sBqe
	GUZ116LCrEU41ysC74jaRIuvvicsrtWR4JhKKia/aFCKMbjWnKt+IRfuuwHMQf4KJgTOWI9iqHpwU
	WpS2+nmlsyaSbcHYsmJxq+RsCpJWmJDld/koEo0n2iQo3AVzMPrJtOkPSNQojruQvxwRd/E5wIH66
	M1t5/hx55D9XkigFPqH9OK3wyKsD+NCgTHiq5WK3KeT1m1DLpOT0CbKG7FAnt/IPJqteC2ymFFn7s
	6NQD26V0bBZzvWJEQtYyM7jDMSROijkWTQPzGbCgazdlN21hpcZRtcmB6F4m8JKdENneM6ULKVIc2
	KPYaeFMw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t6u6s-0000000G0Tx-063T;
	Fri, 01 Nov 2024 16:02:50 +0000
Date: Fri, 1 Nov 2024 16:02:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] Xarray: skip unneeded xas_store() and
 xas_clear_mark() in __xa_alloc()
Message-ID: <ZyT7qRhtqGDe_AuO@casper.infradead.org>
References: <20241101155028.11702-1-shikemeng@huaweicloud.com>
 <20241101155028.11702-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101155028.11702-5-shikemeng@huaweicloud.com>

On Fri, Nov 01, 2024 at 11:50:26PM +0800, Kemeng Shi wrote:
> If xas_find_marked() failed, there is no need to call xas_store() and
> xas_clear_mark(). Just call xas_store() and xas_clear_mark() if
> xas_find_marked() succeed.

No.  The point of the xas interfaces is that they turn into no-ops once
an error has occurred.

> -		else
> +		else {
>  			*id = xas.xa_index;
> -		xas_store(&xas, entry);
> -		xas_clear_mark(&xas, XA_FREE_MARK);
> +			xas_store(&xas, entry);
> +			xas_clear_mark(&xas, XA_FREE_MARK);
> +		}
>  	} while (__xas_nomem(&xas, gfp));
>  
>  	return xas_error(&xas);
> -- 
> 2.30.0
> 

