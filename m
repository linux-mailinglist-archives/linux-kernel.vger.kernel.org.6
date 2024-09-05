Return-Path: <linux-kernel+bounces-316845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511A296D611
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10532287BEE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2242F1991C9;
	Thu,  5 Sep 2024 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdKN1RKM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A35F197A76
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532071; cv=none; b=Wcmfp9t2nPRib26qRP8vE0PReVLRMIm3rM1qiX9BdHtb67b7Asukubjdxpp4GDb7DEsNmCNGzRRGDh9KhxutDOJKaMQXeEDGbVX+Tw6VfVcVhRz+MrVFUDkAQH8xxO9jBacrUr1dW07aX0wNKn/vB8QC2IPTjT7IHBAfWUFoxD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532071; c=relaxed/simple;
	bh=fLnaSEMwTToqbULVT0rbA5FWXK2jDlM8vTXItsk0pPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7zSsiGzQZppsiOOyvE8dmWuCaaYPE5y/Ib+/EVmCRzib4o43g0iyHfarc2RyXQ0zv/nzgNWcd5u+YZWkPxsuHRvrVZaOJn+UsthhnCwLtJf1dfOxGE7Xvo0pQd4nJU6bL7EbfwTh5fvHPnIOvTkzPjUudjF0/HmgTftveQBCtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdKN1RKM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725532068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPZY07hdzZVf0G40Y7mAQP+lGDT6ud+TjaZvwKM2DVk=;
	b=HdKN1RKMP1o5er+tInbkj/Pu4LvbJPU9g/3CJGFeF4OxhmjCrQC+ZCjwoADYRhXOIhVd98
	srL02x/e6XanIrJUgdHyFA4+6gv7D22AoTILVUUNoeuN7qT4coC3jdq3OZlpqFE0BU65eJ
	ILgkHOuzrU2E/qZGvgQs0r4IDbPvwuY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-Yh8Ecu-PMSyYUa0rkVA_Og-1; Thu, 05 Sep 2024 06:27:47 -0400
X-MC-Unique: Yh8Ecu-PMSyYUa0rkVA_Og-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c79bf194so418979f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725532066; x=1726136866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPZY07hdzZVf0G40Y7mAQP+lGDT6ud+TjaZvwKM2DVk=;
        b=DoLl43xrZQHHaU1xNVrcHc9tbHg1T2CqTRB/EhS+kalO0lluXXfidJZWHVLX31b6ve
         JYu4WtK2nrwMEXzuIOCczgu3Yr4I304O/93Rdod7zsXzZHMtfhByS8k2Gc+wKB7lrq45
         BX9GLgbtxlpfVj6EZlEBaIX7Bl0WE83RSjFvRZQvUkDJaOp0JuJJVfTLVWG9NgbT77EK
         aJseaylZPHf2W5vvDcWG16Y3RxbOl8Ou4TLfplSHHgqIyAJP5Tn3X4NqgDs1qVLSN2Vd
         nzDP490S6y1uRj3PBbQ/xDuVI+yfRvCQL4N6J5F2QGU8LxEcPfo2FzG6QcuF7YS7x7ib
         dEiA==
X-Forwarded-Encrypted: i=1; AJvYcCVcfPP177gzLP7n2vBuvl9GEaWW4D55yvWnNhyRfa8Su2uys8jQfsm2bWUoRcFv2VP/C98BzFf5LBUgC9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKIZ3+cLXdPGAHpcmg1jZdqvY50sWZaXJmgqYw4qhONwmCFTen
	38th/0kl4yGABOH1cJkwrh/LQV3r5bYUa5clReKTSqHyDZfx0xvIpTYd8M8VUb9BJBj+nuoGbwG
	l0ykssEdWJ9XYC1RtiFa7vygBO/qjzYKNqlnnO9nomsayMY8rxrpsd3Tu4D5Pmw==
X-Received: by 2002:adf:db4b:0:b0:371:9149:dc54 with SMTP id ffacd0b85a97d-374bce97a6emr11563795f8f.3.1725532066632;
        Thu, 05 Sep 2024 03:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELrkDTki7RK2Sj/ftb+YWjMBHGRyt5865Zm3SuZ0YuC1n53erV/zIV711siGKvaK8a5Qowxg==
X-Received: by 2002:adf:db4b:0:b0:371:9149:dc54 with SMTP id ffacd0b85a97d-374bce97a6emr11563768f8f.3.1725532066073;
        Thu, 05 Sep 2024 03:27:46 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374ba593876sm15319716f8f.5.2024.09.05.03.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 03:27:45 -0700 (PDT)
Message-ID: <8fe1d9da-40cc-4537-80ce-6a2855c2dec4@redhat.com>
Date: Thu, 5 Sep 2024 12:27:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 8/8] net: ibm: emac: remove all waiting code
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, jacob.e.keller@intel.com, horms@kernel.org,
 sd@queasysnail.net, chunkeey@gmail.com
References: <20240903194312.12718-1-rosenp@gmail.com>
 <20240903194312.12718-9-rosenp@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240903194312.12718-9-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 21:42, Rosen Penev wrote:
[...]
>   static int emac_wait_deps(struct emac_instance *dev)

Possibly rename the function to something else, as it does not wait anymore?

> @@ -2419,26 +2397,25 @@ static int emac_wait_deps(struct emac_instance *dev)
>   		deps[EMAC_DEP_MDIO_IDX].phandle = dev->mdio_ph;
>   	if (dev->blist && dev->blist > emac_boot_list)
>   		deps[EMAC_DEP_PREV_IDX].phandle = 0xffffffffu;
> -	bus_register_notifier(&platform_bus_type, &emac_of_bus_notifier);
> -	wait_event_timeout(emac_probe_wait,
> -			   emac_check_deps(dev, deps),
> -			   EMAC_PROBE_DEP_TIMEOUT);
> -	bus_unregister_notifier(&platform_bus_type, &emac_of_bus_notifier);
> -	err = emac_check_deps(dev, deps) ? 0 : -ENODEV;
> +
> +	err = emac_check_deps(dev, deps);
> +	if (err)
> +		return err;
> +
>   	for (i = 0; i < EMAC_DEP_COUNT; i++) {
>   		of_node_put(deps[i].node);
> -		if (err)
> -			platform_device_put(deps[i].ofdev);
> -	}
> -	if (err == 0) {
> -		dev->mal_dev = deps[EMAC_DEP_MAL_IDX].ofdev;
> -		dev->zmii_dev = deps[EMAC_DEP_ZMII_IDX].ofdev;
> -		dev->rgmii_dev = deps[EMAC_DEP_RGMII_IDX].ofdev;
> -		dev->tah_dev = deps[EMAC_DEP_TAH_IDX].ofdev;
> -		dev->mdio_dev = deps[EMAC_DEP_MDIO_IDX].ofdev;
> +		platform_device_put(deps[i].ofdev);

I'm likely lost, but AFAICS after the patch, on success 
platform_device_put() is invoked unconditionally on each deps[] entry, 
while before it was called only on failure?!?

/P


