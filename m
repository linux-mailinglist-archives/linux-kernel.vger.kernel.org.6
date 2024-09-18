Return-Path: <linux-kernel+bounces-332653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E711C97BC9F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E77B23B41
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA47189F5D;
	Wed, 18 Sep 2024 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="De46/YqL"
Received: from smtp103.iad3b.emailsrvr.com (smtp103.iad3b.emailsrvr.com [146.20.161.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD914409
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664199; cv=none; b=UuDGiwwlARU4pBhHmbDjV4+VXAhES1skE46nvd5HfD75V7/Qur2K5xL57RDLJqBc/PGwYnaNxkMiPoiqjylxTg4Y+NgRWliWzLZv6nWCS9mc1iJSikcF1Im929CRz8BoW+e8rM3nlPINMGYKo84EJqNl+IygJSbNfanxPo7hm68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664199; c=relaxed/simple;
	bh=swbAZGp8UeNGo9xKZhobTwGg6AWx2SX3Ix6yY+8Fvdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQUuemS7WkGCRg/19IlGKLI9MKOHi0nWHxt9GtjwzGF1ARdN8FERY9v/NoEA7k4WCxpzg9HgvMervce49rjws8jnZHQLvaKS9vamy3IJgkQg92/jBwTjRYKo4klbaZpoT4Ca+pJ4ReGaVTULSW9OJ+wB5J7s7ju7ypHmDm9RBBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=De46/YqL; arc=none smtp.client-ip=146.20.161.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1726659662;
	bh=swbAZGp8UeNGo9xKZhobTwGg6AWx2SX3Ix6yY+8Fvdw=;
	h=Date:Subject:To:From:From;
	b=De46/YqLq9FJeQLGhVQSjCApgBnFgJIvS0FUU3qA8rb7X5ICFhm+5VPdibUoRBj/A
	 pNDoTfYvkj+BbekNInwjthy52/63U/Nqq/8EcucvYjo/oFLT9WN73ww2ZON4DOwCgQ
	 +7SBBeJttRjc2Df0i/2hPitW1eTPJO7O9LlH1A50=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp21.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 5874320103;
	Wed, 18 Sep 2024 07:41:01 -0400 (EDT)
Message-ID: <4f46343a-a1f9-4082-8ef2-50cdb3d74f31@mev.co.uk>
Date: Wed, 18 Sep 2024 12:41:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: adl_pci9111: Fix possible division by zero in
 pci9111_ai_do_cmd_test()
To: Aleksandr Mishin <amishin@t-argos.ru>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240918104304.15772-1-amishin@t-argos.ru>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20240918104304.15772-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 6c29a785-62d1-41a1-a4d9-6a0662f318fb-1-1

On 18/09/2024 11:43, Aleksandr Mishin wrote:
> Division by zero is possible in pci9111_ai_do_cmd_test() in case of scan
> begin trigger source is TRIG_TIMER and either 'chanlist_len' or
> 'convert_arg' is zero.
> 
> Add zero value check to prevent division by zero.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: f1c51faabc4d ("staging: comedi: adl_pci9111: tidy up (*do_cmdtest) Step 4")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>   drivers/comedi/drivers/adl_pci9111.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/comedi/drivers/adl_pci9111.c b/drivers/comedi/drivers/adl_pci9111.c
> index 086d93f40cb9..ec1fb570b98c 100644
> --- a/drivers/comedi/drivers/adl_pci9111.c
> +++ b/drivers/comedi/drivers/adl_pci9111.c
> @@ -312,6 +312,8 @@ static int pci9111_ai_do_cmd_test(struct comedi_device *dev,
>   	 */
>   	if (cmd->scan_begin_src == TRIG_TIMER) {
>   		arg = cmd->chanlist_len * cmd->convert_arg;
> +		if (!arg)
> +			return 4;
>   
>   		if (arg < cmd->scan_begin_arg)
>   			arg *= (cmd->scan_begin_arg / arg);

Nice catch!  `cmd->convert_arg` will be non-zero due to earlier checks, 
but `cmd->chanlist_len` could be zero for the `COMEDI_CMDTEST` ioctl. 
(The function is called for the `COMEDI_CMDTEST` and `COMEDI_CMD` 
ioctls, but only `COMEDI_CMD` checks that `chanlist_len` is non-zero 
before calling the function.)

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-


