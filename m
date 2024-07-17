Return-Path: <linux-kernel+bounces-255404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6EF934063
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096FC1C21834
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6EE181CFF;
	Wed, 17 Jul 2024 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQE8MiJg"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679F1180A67;
	Wed, 17 Jul 2024 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233597; cv=none; b=opi1s3bfS+CJuZSZP7TAYYaV2JMo0y4SHAnM92/EaIOhukksDncdbygRN04X4njNGOYPT/xSnbaqdp+kT0lInb74gL+TnmAFmWlqn4fiHddPk+4f7chLehDRj3e64jbSHUh6sIeUXhNIPS09xrKmHTKWbAialsP09IficUKHxKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233597; c=relaxed/simple;
	bh=I2eGsjFhX70XBcnNVF+/czALV8y44WdUsYs50JL3l4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9M55mhj8FWeOBTMnXKq+fkixNNujuHf67e3AOx2xruyDRstKWU1PFLNJMmJ3M1nod8JkRdet+0t/yige0OJ3Z3zXRU5M3h4iGnOstfHlpyIjpo1WjGmhfXFDbIESbZf4mIQ4W5k4zRy5obtDRkrGd9NAks8Q335Qg29xdNtCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQE8MiJg; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70360eeb7d2so230513a34.1;
        Wed, 17 Jul 2024 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721233594; x=1721838394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PRqnKCtfj6g6rjCE6KHBQ+SuSmEcX2d5CkGn30mc4Dk=;
        b=FQE8MiJgIYbYHaHMx1LiIeMVkX2JCEaGOXC/FIcgKhBPBhk9vFh9KNBfXaF/wlMgq1
         JpzBgvp2lnFQX+yKEo4UxoPaRhi6dv1da/NfH7Q3+2WzcG56jASK0Elw7JRWbZCZ227v
         NqayGT56/GoP72UctBkSa5cp30pgomkaIMu49NLwGb6N8Al2l7L6lAb5YQFclv24kiXa
         bGKtJ5AuN15DoDtuYqxWgR9Pn4gxx5rtcb/tUfffwfuSbmI+rwPVDSoyqn6YaxIac4e2
         NBYTi/83AVsQv+0oQwGU0e9NRqb3BAOezaRP9aSh+ycPqCs+dVWyF8jLgJH4cbUm+WiQ
         Txmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721233594; x=1721838394;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRqnKCtfj6g6rjCE6KHBQ+SuSmEcX2d5CkGn30mc4Dk=;
        b=d+P8Rqglp69F8ziJFshw2AHZyeGpuIZpNdEgDP76IqoXAClQvArUi0QavRKNTp3G7g
         wqg4TEhZBbYy6Vx2wNrSyjlxBoxZJK+PNiYKIazjQcHnxDClol4q0KqSiGGM77rh4hzc
         c2WM3S0s9H2tQCE4OAdVqGimfd1AQfzx8UmXdIzAgoVlgHKKlSQvHQkovucQSSe32yZI
         8CR7HzoquTU+vefdzpvq+3MZr2PDen+bj6rWj9gRMsGehdKq3ciRPgBjazTeMwCTD1N+
         Xd730Bf/4mj4M5Q6wijGnDEjN63sG8a6G8vhs8UXbdAOqgQq4MuMAQDw76NEl0u2Bn+m
         k+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGaGtRXSmQLzsyjJMVZC/xruwMMLK01IA9nM8lVAs20Yuc4nGahXoB8iMp1mFlWw0+VRp88cXxTJN11hszBTaxxJiTBtj0URa71gCBoDKujbu6hBFLfXs8+Ja8ZptL9er5VuKcV07zXho=
X-Gm-Message-State: AOJu0Yxks0xY8VisdkWjMub+Jd/Aob5gep9epc8VbrdB3+n7yZMIn0l/
	x7Fjhag5SF8WhNss5nZ8jrTklTxb0QOzTZb85JaiCXt9q+TxVJkQ
X-Google-Smtp-Source: AGHT+IFs6Nd6U9feGVZuPjVusY5QIze7IvbR0Hq0eU5ifsPkAZeyAweB11hHaqOBU2XL++f7dwwGVQ==
X-Received: by 2002:a05:6870:353:b0:24e:8987:6f34 with SMTP id 586e51a60fabf-260d8fe84b7mr1671024fac.3.1721233594046;
        Wed, 17 Jul 2024 09:26:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9dee7sm8620113b3a.16.2024.07.17.09.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 09:26:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6e8245d5-8c39-491e-9fd0-1be88be7b00a@roeck-us.net>
Date: Wed, 17 Jul 2024 09:26:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hwmon/misc: amd-sbi: Move core sbrmi from hwmon to
 misc
To: Akshay Gupta <akshay.gupta@amd.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
References: <20240717081027.2079549-1-akshay.gupta@amd.com>
 <20240717081027.2079549-2-akshay.gupta@amd.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240717081027.2079549-2-akshay.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/24 01:10, Akshay Gupta wrote:
> This is done to support other functionality provided by the SBRMI, which
> does not fit in the hwmon subsystem.
> 
> - Move the SBRMI core functionality and I2C device probing part to misc.
> - Move hwmon device sensor to misc as only power is reported through
>    hwmon sensor.
> 

I fail to see the logic here. Why would the supported sensor types
be a reason or an argument for moving the hwmon code out of hwmon ?

Guenter


