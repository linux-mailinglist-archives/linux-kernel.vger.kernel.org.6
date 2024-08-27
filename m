Return-Path: <linux-kernel+bounces-303925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0129616F9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4928F2895E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039771D2788;
	Tue, 27 Aug 2024 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="WB14IP9T"
Received: from mx06lb.world4you.com (mx06lb.world4you.com [81.19.149.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBAE1C688E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783247; cv=none; b=fCSB+VMAJSiAfggkMJa8ywXhTPydjfQkMEW/biaCGZvqE4SonTjB+XwvykLPXhYep4CSmAAjJ+AFpBdyDOOubgV4SseFeIbW0ZizCjAFvEXFQAsx4OYJlFeznXmX/mXRSTToPkz5TmRGwVBwt9DccRfIVEvyiIWzSbnUdcFD2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783247; c=relaxed/simple;
	bh=ZAue4A7tXoHZpzoTFkTssmp2o97g5N78hnspoGzb4HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSeDo4Wwd+ZI54lXtUKN/ptKoq4Fn+arf4paeZIJRdSgQFs1NZtZiAFFovEZDzI46SmvWuJoUCWWZhvggkwK8MiDSMbr3eEQq+iEWNJhRVQW0YcjJscvj8e44q6pZ97vscMiMHNSqGfaFFOovhSZriU2EMdBxwVt0yPDFL7rAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=WB14IP9T; arc=none smtp.client-ip=81.19.149.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RCngZdlVbmwTISzy1jta1sb8f2FBmsiJ64FzCFjQf08=; b=WB14IP9Tit38XPK7eWdw/k2OLM
	WhUlKfE7YzlNWeBxZlHm9bh/WuhCedbm7JMZxu4vgFb2DyTpk79t4YItRqIPMZ6G+MMvw3G8GqkEZ
	kdM3yAj/TWlssEeAFe5ebijVv5AxYgxER1rcETg/7N7qc6Rw8V2I+stemOa58R3NdjLU=;
Received: from [88.117.52.244] (helo=[10.0.0.160])
	by mx06lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1sj0uY-0008Tr-0m;
	Tue, 27 Aug 2024 20:27:22 +0200
Message-ID: <6630b70a-2383-46ad-b9e2-42454a537bad@engleder-embedded.com>
Date: Tue, 27 Aug 2024 20:27:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: keba: Fix sysfs group creation
Content-Language: en-US
To: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc: arnd@arndb.de, Gerhard Engleder <eg@keba.com>
References: <20240819192645.50171-1-gerhard@engleder-embedded.com>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20240819192645.50171-1-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 19.08.24 21:26, Gerhard Engleder wrote:
> From: Gerhard Engleder <eg@keba.com>
> 
> sysfs_create_group() races with userspace. Use dev_groups instead which
> prevents all the problems of sysfs_create_group().
> 
> Fixes: a1944676767e ("misc: keba: Add basic KEBA CP500 system FPGA support")
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Gerhard Engleder <eg@keba.com>
> ---
>   drivers/misc/keba/cp500.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/misc/keba/cp500.c b/drivers/misc/keba/cp500.c
> index 9ba46f0f9392..ae0922817881 100644
> --- a/drivers/misc/keba/cp500.c
> +++ b/drivers/misc/keba/cp500.c
> @@ -212,12 +212,12 @@ static ssize_t keep_cfg_store(struct device *dev, struct device_attribute *attr,
>   }
>   static DEVICE_ATTR_RW(keep_cfg);
>   
> -static struct attribute *attrs[] = {
> +static struct attribute *cp500_attrs[] = {
>   	&dev_attr_version.attr,
>   	&dev_attr_keep_cfg.attr,
>   	NULL
>   };
> -static const struct attribute_group attrs_group = { .attrs = attrs };
> +ATTRIBUTE_GROUPS(cp500);
>   
>   static void cp500_i2c_release(struct device *dev)
>   {
> @@ -396,20 +396,15 @@ static int cp500_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
>   
>   	pci_set_drvdata(pci_dev, cp500);
>   
> -	ret = sysfs_create_group(&pci_dev->dev.kobj, &attrs_group);
> -	if (ret != 0)
> -		goto out_free_irq;
>   
>   	ret = cp500_enable(cp500);
>   	if (ret != 0)
> -		goto out_remove_group;
> +		goto out_free_irq;
>   
>   	cp500_register_auxiliary_devs(cp500);
>   
>   	return 0;
>   
> -out_remove_group:
> -	sysfs_remove_group(&pci_dev->dev.kobj, &attrs_group);
>   out_free_irq:
>   	pci_free_irq_vectors(pci_dev);
>   out_disable:
> @@ -427,8 +422,6 @@ static void cp500_remove(struct pci_dev *pci_dev)
>   
>   	cp500_disable(cp500);
>   
> -	sysfs_remove_group(&pci_dev->dev.kobj, &attrs_group);
> -
>   	pci_set_drvdata(pci_dev, 0);
>   
>   	pci_free_irq_vectors(pci_dev);
> @@ -450,6 +443,7 @@ static struct pci_driver cp500_driver = {
>   	.id_table = cp500_ids,
>   	.probe = cp500_probe,
>   	.remove = cp500_remove,
> +	.dev_groups = cp500_groups,
>   };
>   module_pci_driver(cp500_driver);
>   

Hello Greg,

did I made some mistakes that keeps this patch from being merged?
I think it can be included to 6.11-rc6, but maybe I'm wrong.

Thanks,
Gerhard

