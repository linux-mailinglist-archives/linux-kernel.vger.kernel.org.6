Return-Path: <linux-kernel+bounces-318919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DDC96F510
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954421F2476C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CEE1CDA31;
	Fri,  6 Sep 2024 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="k8gSJ0zM"
Received: from smtp70.ord1d.emailsrvr.com (smtp70.ord1d.emailsrvr.com [184.106.54.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275B1E49B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725628298; cv=none; b=pLpI1zLZ3YcGUQk3BArx1vjY31CACH2avRoo03evBHlmiC91wfXdi25TrgmM0WZRmyx2ukQYMOdzPl7LV+FnCdD8NXEHxdfu8UDBY6SPm6VwJVrFOptbH5rqsEbDPly85/F+rdw8LkZgB0XEbXmnzgV/jxvNB++i26tboSEZq88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725628298; c=relaxed/simple;
	bh=tjT94ezGAjJuPSMvjyw3/ZrBgZOITPUQNpJLDPMGP/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQwn6fWvzxvX0pjAxuKl9x/l8bOZ/V3PI/GZnDUr+l7vR3yFuFFU/5XIe+ywnpFOtuZVwhUNabwVxJKbGuybc1KAzJJotKUjmqEbHRGCcbl70+XlP9ZINjMkV4GAUY6C7pcsgyFKG78T+cikY870pXGzIzHsPzd8+oMKD9jCQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=k8gSJ0zM; arc=none smtp.client-ip=184.106.54.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1725619412;
	bh=tjT94ezGAjJuPSMvjyw3/ZrBgZOITPUQNpJLDPMGP/c=;
	h=Date:Subject:To:From:From;
	b=k8gSJ0zM5cSsuovbx/uPnKaPyK9yJV6vDpuOjJMl9qlkfqlVyXvO6c5746hWPovID
	 QY75UX8D+9I8usWFkHC/SlC8+q9CInN+ma7yiSrj0qaORgA00bBepbKmoOlNvusZY0
	 u7pPm2Um96tcZeHUOuA3wHa7CT54BAyHe2Ly9FSM=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp9.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 92D5EC01BB;
	Fri,  6 Sep 2024 06:43:31 -0400 (EDT)
Message-ID: <b1265696-20f1-40dc-bf3a-5f81a429238b@mev.co.uk>
Date: Fri, 6 Sep 2024 11:43:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ni_routing: Check when the file could not be opened
To: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: linux-kernel@vger.kernel.org
References: <20240905144213.8954-1-RuffaloLavoisier@gmail.com>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20240905144213.8954-1-RuffaloLavoisier@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: b9f32b04-f707-4baa-885d-9af2505da232-1-1

On 05/09/2024 15:42, Ruffalo Lavoisier wrote:
> Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
> ---
>   drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
> index d55521b5bdcb..d0321a7565c5 100644
> --- a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
> +++ b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
> @@ -139,6 +139,10 @@ void device_write(const struct ni_device_routes *dR, FILE *fp)
>   int main(void)
>   {
>   	FILE *fp = fopen("ni_values.py", "w");
> +	if (fp == NULL) {
> +		fprintf(stderr, "Could not open file!");
> +		return -1;
> +	}
>   
>   	/* write route register values */
>   	fprintf(fp, "ni_route_values = {\n");

Looks good, but it could with some minimal description in addition to 
the patch header line.

The change is not urgent as the utility is only built manually and not 
part of the usual kernel build process. (It is only used to maintain a 
few source files, and not very often.)  Still, it's good to fix it.

Please could you add Greg Kroah-Hartman to the Cc list, as he is the 
person who normally commits comedi-related patches.

Thanks,

Ian

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-


