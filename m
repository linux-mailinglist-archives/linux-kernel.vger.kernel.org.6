Return-Path: <linux-kernel+bounces-395235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B429BBAAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74644B21DBB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8E21C32E2;
	Mon,  4 Nov 2024 16:55:29 +0000 (UTC)
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F11C07EA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.160.28.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739329; cv=none; b=DJ481Ce7XMbJsbGSMrIrAzoIs1QMZml0wHbo+NUQ+2YCAjfF43bWQxzf9rFgALPqLCn19PGchsoj0fPOpkxBPJ18mPnznNQ4ZXRIT2U3wob1lldnxP/qQl7NqqzzjwQwwoR9RqtJPFGiWIE5/9Pok6KkEwfKZhSLd5C+zLyjiz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739329; c=relaxed/simple;
	bh=hTCgUswcNy/SRwlsOKmRja9tnUyteY+2dBFLHIX4a94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMlzynkybxptRe7ozKPJV5plo/iZu/Wn9zGzFQ9IpqBnmnDqK2U7XJ8SykFZeJNu48mZBBc6BuhlYNbg5rFDVTdZGKOCvdJT8/zEBn1w08BRKFPuolsWAZE1N3rtx5tgfQdIuW5Qw+NV0JjECxJS0CISrfu2lqx+iAIemZvXyDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com; spf=pass smtp.mailfrom=cambridgegreys.com; arc=none smtp.client-ip=217.160.28.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cambridgegreys.com
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1t80MF-00Dwhu-Vt; Mon, 04 Nov 2024 16:55:16 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1t80MD-00C1ZX-0k;
	Mon, 04 Nov 2024 16:55:15 +0000
Message-ID: <8b4f592c-bdc9-4a2b-bf97-afe11b840d4b@cambridgegreys.com>
Date: Mon, 4 Nov 2024 16:55:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] um: ubd: Initialize ubd's disk pointer in ubd_add
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at,
 johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241104163203.435515-1-tiwei.btw@antgroup.com>
 <20241104163203.435515-2-tiwei.btw@antgroup.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20241104163203.435515-2-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett



On 04/11/2024 16:32, Tiwei Bie wrote:
> Currently, the initialization of the disk pointer in the ubd structure
> is missing. It should be initialized with the allocated gendisk pointer
> in ubd_add().
> 
> Fixes: 32621ad7a7ea ("ubd: remove the ubd_gendisk array")
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
>   arch/um/drivers/ubd_kern.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 2b8d04e67600..f19173da64d8 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -898,6 +898,8 @@ static int ubd_add(int n, char **error_out)
>   	if (err)
>   		goto out_cleanup_disk;
>   
> +	ubd_dev->disk = disk;
> +
>   	return 0;
>   
>   out_cleanup_disk:

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

