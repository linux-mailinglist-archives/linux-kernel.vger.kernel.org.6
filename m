Return-Path: <linux-kernel+bounces-284444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10709950105
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06EC286EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB851946C1;
	Tue, 13 Aug 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yBW6Eldv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA1F17C21C;
	Tue, 13 Aug 2024 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540286; cv=none; b=GIYfB6FejXm2+rhWJtZ6CwGRga7SE6fLJLXqInuJxHeh8eMIFVdKVv7FOTiFbgMc+gnFSKRChCuJSXx7gwQQfW8RAX8eES/D1D3VfZm88PktdeDjOMndz/JXNlBcuvpTI/fT72mFmU51zjnwtCYaTXeLKjBTzjcGjf63dC9Ez+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540286; c=relaxed/simple;
	bh=3170JaPRIKXZZLAfKRhqR5tUWqhTRBY0uB9PjHRJxCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPonAeraxAxolPZX2P17SID6uIEnrnzUmWDo9RcOouGqLnFiWCMDx357uMv03CF3D9PhH1FRnq1d8YUuvrofCJhol0tkn2J6icDIkwwwZJ0B9xtVwnooZfYrmbRag8SSOlew2sT8OcBteP2thOaJmEfndtwMnh3H6oxwL+MX2gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yBW6Eldv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E991EC4AF09;
	Tue, 13 Aug 2024 09:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723540286;
	bh=3170JaPRIKXZZLAfKRhqR5tUWqhTRBY0uB9PjHRJxCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yBW6EldvXwchpyt4mH5oLYrG1U2PYE76VNaTTIeNMRsuOjB/VrLtkhxkihTH1LB3Y
	 sBIrEsp1NPg3GCniO0d0YxEoiPMCDMcTVnuPCJK1vvGmW3+fNxaSMh7E7Tj2SkSMOV
	 +aYTg5lymMyR5Z5NMyjYrZYWoffHc+vtmjY7Gu1E=
Date: Tue, 13 Aug 2024 11:11:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: giometti@enneenne.com, christophe.jaillet@wanadoo.fr, linux@treblig.org,
	sudipm.mukherjee@gmail.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pps: add an error check in parport_attach
Message-ID: <2024081336-escapable-anemia-87cb@gregkh>
References: <20240813030800.3949400-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813030800.3949400-1-make24@iscas.ac.cn>

On Tue, Aug 13, 2024 at 11:08:00AM +0800, Ma Ke wrote:
> In parport_attach, the return value of ida_alloc is unchecked, witch leads
> to the use of an invalid index value.
> 
> To address this issue, index should be checked. When the index value is
> abnormal, the device should be freed.
> 
> Found by code review, compile tested only.
> 
> Cc: stable@vger.kernel.org
> Fixes: 55dbc5b5174d ("pps: remove usage of the deprecated ida_simple_xx() API")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/pps/clients/pps_parport.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
> index 63d03a0df5cc..9ab7f6961e42 100644
> --- a/drivers/pps/clients/pps_parport.c
> +++ b/drivers/pps/clients/pps_parport.c
> @@ -149,6 +149,11 @@ static void parport_attach(struct parport *port)
>  	}
>  
>  	index = ida_alloc(&pps_client_index, GFP_KERNEL);
> +	if (index < 0) {
> +		pr_err("failed to get index\n");

No need to be noisy, right?

thanks,

greg k-h

