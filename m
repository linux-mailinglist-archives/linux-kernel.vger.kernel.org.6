Return-Path: <linux-kernel+bounces-227741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 685D4915612
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A6E1F233EF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B80A19F47B;
	Mon, 24 Jun 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qQOgWDkh"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB831A00DE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251905; cv=none; b=jk0/z4atBflYsMao6y/xyhZbB856fg1mFZoOM3+WmPjb1scbvbf0wuvW2GQ0sdLNbW9gfUWLEqj4YlegYIpXzSuXNuz31vC/QJ7ybXcbYN0nQ/oq0IPx05lZHqqznONvejMv7V1YFgEyVK9JwGaV62D2PuNlviWXZFmwmeVYT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251905; c=relaxed/simple;
	bh=Q9SoZkWgGe3TT936PLJdlfBNYMWtnnjEPGQVgoEAP5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZw8Re2XOVapFqiDaK1ATH7rU7RBs/QDp3i6uiy70C+ZKuy59k395UcrZ5fy6QuV7FpoFMnaOrYAjL1nHCfttWbFMDxdL9g0G8QUv4lilHdGxm0KHb1IoWvOtz7QZg2LF/Xmbecc6q4dXMaBXlsIi2j4QM3/41CN8+8c6pZb7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qQOgWDkh; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: make24@iscas.ac.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719251901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0hGoRJyiAvM5+iKx7GYM3fO7xPFLMPv6AVjIFGqLYD8=;
	b=qQOgWDkhN9Ji8UIewm6XtbzAELuemkvdEWjO3KV2mpDN9Q5T3aarqO4gZm2UT7bo5wjvx6
	OJBmz4a0y1RFQNN2bY2v0PF5paodfVGqkljcxLQWjxfAGXWSziYFkKreOiws8Z3JhNao79
	VoRccq+NzXyDx5MWJcc9w4m+IcQwxng=
X-Envelope-To: hao.wu@intel.com
X-Envelope-To: trix@redhat.com
X-Envelope-To: mdf@kernel.org
X-Envelope-To: yilun.xu@intel.com
X-Envelope-To: linux-fpga@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 10:58:09 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Ma Ke <make24@iscas.ac.cn>
Cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: fix potential memory leak in
 vfio_intx_enable()
Message-ID: <20240624175809.kmub3gjg5awxjzyw@4VRSMR2-DT.corp.robot.car>
References: <20240623074019.2083481-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623074019.2083481-1-make24@iscas.ac.cn>
X-Migadu-Flow: FLOW_OUT


On Sun, Jun 23, 2024 at 03:40:19PM +0800, Ma Ke wrote:
> We should free 'feature->irq_ctx[idx].name' to avoid 'name'
> memory leak when request_irq() failed.
> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/fpga/dfl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 094ee97ea26c..c52ebece5aef 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1911,7 +1911,7 @@ static int do_set_irq_trigger(struct dfl_feature *feature, unsigned int idx,
>  			  feature->irq_ctx[idx].name, trigger);
>  	if (!ret) {
>  		feature->irq_ctx[idx].trigger = trigger;
> -		return ret;
> +		goto free_name;

I believe (!ret) represents the success case and that simply
returning is the right thing to do. In the case of an error,
eventfd_ctx_put() and kfree() are both called.

>  	}
>  
>  	eventfd_ctx_put(trigger);
> -- 
> 2.25.1
> 

