Return-Path: <linux-kernel+bounces-531242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF938A43E06
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A303B27FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F02268C47;
	Tue, 25 Feb 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIv0Xm8J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCC52686AF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483717; cv=none; b=rYiWEkUZ4FOFBF2Flo4dWIFMbnXxoYyiwl/jxaBjDJBkUDrDBRpOlw49HGfa6Y3JpKhsRTSgEoZ6aNhgxYsfXyge0UYE7vHwdoJeqnLLp74mJZze8szu7YQ1VkHvUL3tkHTtBghKoshASjKFPGr0I9FCZS6KJiqbch8bYf6NY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483717; c=relaxed/simple;
	bh=CKyOL0dq4XhTxXKNvgQCDaAmo0Z3lBdpUJRyRETK/1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVfvFCl+etQNwX0wD4S00WUu0X7psoR38I//UmkrsDdgrpLcVWIwbPbe6jygxXz7ZcL8XVbSNWBBKwJPkDwnLh/PCdwXVh9wgabeuGaR+6cVVQQUwjmvuZpJL1MhknEPLnkE86Tgv59ipYd2+ADme3P4T9iMeqO/yEFfr8KEph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIv0Xm8J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740483715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6ggdA4Yip2z1d3LHS7C+TUR3rF6w0Xoc1I30vx9XO4=;
	b=EIv0Xm8JUxTA0qTeRH5rmqQ8Dx9tuV46RTzQ/Qm642uHt2TewCsqlvmk8CKUJnhspcdkEy
	5VzZgnI7jWufT1F4k9U4rVmUWknbyTtpcoUF/C4sLXJGkzbNYw8ctBYGDbhnMa8fCsvIXb
	ssJVEdQiKexAZ0fFWbINY+aJv8qsVbI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-DdifgAluPmKz0riAvzVETw-1; Tue, 25 Feb 2025 06:41:53 -0500
X-MC-Unique: DdifgAluPmKz0riAvzVETw-1
X-Mimecast-MFC-AGG-ID: DdifgAluPmKz0riAvzVETw_1740483712
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43945f32e2dso52128965e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483712; x=1741088512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6ggdA4Yip2z1d3LHS7C+TUR3rF6w0Xoc1I30vx9XO4=;
        b=m5edVVUREi9e+7RTjvI2dt23Cn0GzBlSnZ4vKnLHYK6LhH9XBbnqX/piZ8Ebj0n2yh
         KK5lXFIzI3zdEbtv2U/tpf6Ri1eNdd5/IupwyTaIXgNxt1ZGSGgeumHuQxJHyIoJVyoi
         2c77JMCE9EJi4yRaQrOKVVInXjK+NzkQxoQR+9nUNbzoedI46KDJwzlYhSQ1gg1JLsY4
         nqqaSTPLf7c0/vnA8Qjg7FvVgX8usOsaEG6EWbYGEGVQ3RMfQ+CJ2nOAoAPGQQ02Lvet
         COPIzeJ6DEU1PQK0vti0jvQmqkswI9RkM9pE3PtgYmOMuBe0VVdquZSlVLjmHeDVaSny
         9OcA==
X-Forwarded-Encrypted: i=1; AJvYcCVktFSlyVKcT2wmOsisNZpDIeUWJ6wJgiKxF8QbcOZc6sPIvnMLrhjYdZ+YGdUlXV6RLP4FqivVa+p3QhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY2qblQAGNQ3nKe1+LBB+K3R9Ke6r8cvy4qBtWI9n5e/qLsZ69
	S5pAQExrKpI/4f/ucnPYw/UOTl17X7Tv37+kosCJShHjJ5MS1giXn/bgRjvJ2PNS9n9GcNYUGpw
	xciX0TZyiuzjR0NcDd4/5+9+GwjHrN/1tHUkB/LaYDjIoWlkOEarCbYyHzACWwA==
X-Gm-Gg: ASbGncvkDyprR+2kuRInzRQz507GmAzKPrLK3CfBnku3V5SwqYz3JHK4oi/v/68aEy4
	O5fxISBrtdEbjycoI9qcmryafWtgxRgrwrIZUQp1dWtSvaDWd4VXVsSUwNhSXigu+PjGaE3M4Yf
	Y7p0mmsGxr/KTfZMftdxVBFP6nEXinM21dMBbuK75GycxLk8C3KRwsIQbUpS6cEo0+R1gqQL/D0
	J+1W5EwY8HT7MxuWhOwlPPQjnXbrdg9wtfh74Q+3acunNteOAqTbLID+wckvadacen0OKd9L19k
	IVYwttxObrFaCGaXBNYSUGUaAILuE9vhPmM5ZdWE0oM=
X-Received: by 2002:a05:600c:468b:b0:439:9eba:93bb with SMTP id 5b1f17b1804b1-43ab0f42a24mr30046825e9.18.1740483712369;
        Tue, 25 Feb 2025 03:41:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhUzCsKXyrBcsIL02vOqLDaHj/LvRegxo7XAQO9jd0Q3JP7pHTLj0XRvx0x5fW0Mplj5/KsQ==
X-Received: by 2002:a05:600c:468b:b0:439:9eba:93bb with SMTP id 5b1f17b1804b1-43ab0f42a24mr30046415e9.18.1740483711879;
        Tue, 25 Feb 2025 03:41:51 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1569e84sm22373085e9.33.2025.02.25.03.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 03:41:51 -0800 (PST)
Message-ID: <7309e760-63b0-4b58-ad33-2fb8db361141@redhat.com>
Date: Tue, 25 Feb 2025 12:41:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/7] netconsole: add configfs controls for
 taskname sysdata feature
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-4-21c86ae8fc0d@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250221-netcons_current-v1-4-21c86ae8fc0d@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 2:52 PM, Breno Leitao wrote:
> Add configfs interface to enable/disable the taskname sysdata feature.
> This adds the following functionality:
> 
> The implementation follows the same pattern as the existing CPU number
> feature, ensuring consistent behavior and error handling across sysdata
> features.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 1b109f46512ffb7628c6b34c6efdfc301376dd53..5a29144ae37ee7b487b1a252b0f2ce8574f9cefa 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -426,6 +426,20 @@ static ssize_t sysdata_cpu_nr_enabled_show(struct config_item *item, char *buf)
>  	return sysfs_emit(buf, "%d\n", cpu_nr_enabled);
>  }
>  
> +/* configfs helper to display if taskname sysdata feature is enabled */
> +static ssize_t sysdata_taskname_enabled_show(struct config_item *item,
> +					     char *buf)
> +{
> +	struct netconsole_target *nt = to_target(item->ci_parent);
> +	bool taskname_enabled;
> +
> +	mutex_lock(&dynamic_netconsole_mutex);
> +	taskname_enabled = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
> +	mutex_unlock(&dynamic_netconsole_mutex);
> +
> +	return sysfs_emit(buf, "%d\n", taskname_enabled);
> +}
> +
>  /*
>   * This one is special -- targets created through the configfs interface
>   * are not enabled (and the corresponding netpoll activated) by default.
> @@ -841,6 +855,40 @@ static void disable_sysdata_feature(struct netconsole_target *nt,
>  	nt->extradata_complete[nt->userdata_length] = 0;
>  }
>  
> +static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
> +					      const char *buf, size_t count)
> +{
> +	struct netconsole_target *nt = to_target(item->ci_parent);
> +	bool taskname_enabled, curr;
> +	ssize_t ret;
> +
> +	ret = kstrtobool(buf, &taskname_enabled);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&dynamic_netconsole_mutex);
> +	curr = nt->sysdata_fields & SYSDATA_TASKNAME;

Minor nit:
	curr = !!(nt->sysdata_fields & SYSDATA_TASKNAME);

would be preferable, and more robust if later on other SYSDATA_ bits are
added, 'moving down' SYSDATA_TASKNAME definition.

Also it would be more consistent with previous usage in
`sysdata_taskname_enabled_show()`

Cheers,

Paolo


