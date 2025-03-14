Return-Path: <linux-kernel+bounces-561997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EC4A61A11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF41A4637A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81992204C18;
	Fri, 14 Mar 2025 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GNNSxyCF"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AD2204875
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741979127; cv=none; b=Pc6roHqgnzJ3mjGl/VA14eS6EHNFbZqd2moNykKRapGzKJb5vHu1k8creh+OWE8DNTWioto6/t0QQyrwvtwBkm7h8MrUU6ZeT8F+E9nrj7awea+C0FXgFi+0/GCMLIEMuJbbEEhnZMncWbyjKEWuof+NzzTPQEXcUIdfNjCdQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741979127; c=relaxed/simple;
	bh=mNbAchN1lXxcQc1ZqEfr3YObwWcpu2VRpWedwwzGL68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEL6B6X0LRyLQFZI16WaE/Q5EAI8UDt2DPR9FW6zRWc9N6NObhxl87V0lKqHKryQvJ8qKP06+7UwGnjxOx9v5XJf40I4uKQ3EJPARTgIRBnWx/4HDNkPJvooqnvOOpAnq0zG/sOKpwm11Vzsr5vwf/ArH+XgS2OAlVc2yHpjL0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GNNSxyCF; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0bd7d8ff-dcc4-43a5-862f-52e23106565c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741979112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yO7hrg04c2brk4CRwpEawF3Xt7L9HsDayWH+Cn7fBl8=;
	b=GNNSxyCFGZt8rvhwBcDdH+Ogew7IVN+7VO1xe6SYtWv6ZhiZsSYYEqR8q/6TKhIwSwtNrM
	9yMlvNXkz2FVfpMLWdZ4VP26aKWY0PoiIiVog/ma5Vug5eNeXTnpnPQ5fvMQ6cO0rhe2EL
	NiV3INkL1AUeNDXYXBY9IdsdNklVTcI=
Date: Fri, 14 Mar 2025 20:05:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] inifiniband: ucaps: avoid format-security warning
To: Arnd Bergmann <arnd@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Yishai Hadas <yishaih@nvidia.com>,
 Chiara Meiohas <cmeiohas@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250314155721.264083-1-arnd@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250314155721.264083-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/3/14 16:57, Arnd Bergmann 写道:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Passing a non-constant format string to dev_set_name causes a warning:
>
> drivers/infiniband/core/ucaps.c:173:33: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>    173 |         ret = dev_set_name(&ucap->dev, ucap_names[type]);
>        |                                        ^~~~~~~~~~~~~~~~
> drivers/infiniband/core/ucaps.c:173:33: note: treat the string as an argument to avoid this
>    173 |         ret = dev_set_name(&ucap->dev, ucap_names[type]);
>        |                                        ^
>        |                                        "%s",
>
> Turn the name into thet %s argument as suggested by gcc.
>
> Fixes: 61e51682816d ("RDMA/uverbs: Introduce UCAP (User CAPabilities) API")

This patch should be for linux-next. In the subject, linux-next should 
be added.

Except the above, I am fine with this commit.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/infiniband/core/ucaps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/core/ucaps.c b/drivers/infiniband/core/ucaps.c
> index 6853c6d078f9..de5cb8bf0a61 100644
> --- a/drivers/infiniband/core/ucaps.c
> +++ b/drivers/infiniband/core/ucaps.c
> @@ -170,7 +170,7 @@ int ib_create_ucap(enum rdma_user_cap type)
>   	ucap->dev.class = &ucaps_class;
>   	ucap->dev.devt = MKDEV(MAJOR(ucaps_base_dev), type);
>   	ucap->dev.release = ucap_dev_release;
> -	ret = dev_set_name(&ucap->dev, ucap_names[type]);
> +	ret = dev_set_name(&ucap->dev, "%s", ucap_names[type]);
>   	if (ret)
>   		goto err_device;
>   

-- 
Best Regards,
Yanjun.Zhu


