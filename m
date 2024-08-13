Return-Path: <linux-kernel+bounces-284451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A22E8950115
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D33F1F2222B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31DB17C21C;
	Tue, 13 Aug 2024 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uyms0AtV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B2F14D42C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540659; cv=none; b=F7RUN6Ow6d6lOqZsY/huET8blL6IUusAG8pmKXdhATxuNwQznT+QhSuD5vOU9wjCWtFVk6f8Kdi6HnNdPgqmwh6AwcDg7tR21xwrFHxibDnzzTDvGOrYL5SgzUrYSxghS5YWOFwngUIh/ih4IkNEZtEAFVK3sLU/0zgmfDx/bOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540659; c=relaxed/simple;
	bh=bHcSBH53me3jZ/SRVl010Nt6paHTzAX/fUg+cXtaz34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGMdLHyhrCjvQFh/Rj9iEaNPzjqjbJT+ElvbYpaixOJ4/0ncPTAi4GMVdavH8pvI4xsaRuGJekQGayVJ3sG+XXenbYrsvQNo+X6ts0wrn/iH0V/Jw+HYvjT+hQEPTpEcHiAHxeeENH/tx+5frKkJwNhD1e24dTwl1ZldViRMbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uyms0AtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54F1C4AF0B;
	Tue, 13 Aug 2024 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723540658;
	bh=bHcSBH53me3jZ/SRVl010Nt6paHTzAX/fUg+cXtaz34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uyms0AtVG6k7vQnjHdMRX9auni8/8IvldYp0yitmVVeguTmnY5ZViCXkpQv+sfEtr
	 OtpP/kIwJpPdlRLC/v0cyeZAkPz74MSYAUzVTGrawsK7f0fv4wWAJzlGDyD8wlF7Os
	 GuUKSsI+dhh+3EhERRVH4cDbSKU+cOHwgkpUDsu0=
Date: Tue, 13 Aug 2024 11:17:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] linux/container_of.h: Remove redundant type cast in
 container_of_const()
Message-ID: <2024081349-anchovy-scratch-c7c9@gregkh>
References: <20240802-container_of_const_fix-v1-1-90e7a5b624f9@quicinc.com>
 <ZrX9G2Ol2jt4o-s7@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrX9G2Ol2jt4o-s7@smile.fi.intel.com>

On Fri, Aug 09, 2024 at 02:27:23PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 02, 2024 at 11:15:15PM +0800, Zijun Hu wrote:
> > From: Zijun Hu <quic_zijuhu@quicinc.com>
> > 
> > Remove redundant (type *) cast for default branch in container_of_const()
> > since the cast has been done by container_of().
> 
> While it might have same effect, the below is explicitly clear about both
> cases. With your patch it will become inconsistent.

Which is why I did it this way.  It's safe to keep as-is, so let's do so
please.

Remember, we write code for people first, compilers second.  There's
nothing wrong with the code as-is and it makes it more obvious what is
happening when someone reads it.

thanks,

greg k-h

