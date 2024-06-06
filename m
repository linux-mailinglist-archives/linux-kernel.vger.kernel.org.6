Return-Path: <linux-kernel+bounces-204865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B838FF46B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21394B250CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E12C198E74;
	Thu,  6 Jun 2024 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SoqiDdeP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A211990A2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697566; cv=none; b=ICY0cbM3OqcVCJcXtUTckPf7579RazmDz6mKkET8XuX2JWKx+Q4CNjDefHPPplLrXpVAmJDhUrLipf3cyQBEr4zMZu1N0ZkujOrQai2z1rqWZ9N3hTMTDgOk5hh4Bm6hVpUXD9vnku7MU2ObTyx716tcY+YH9m2drGaCjW7aQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697566; c=relaxed/simple;
	bh=g18wcZ4Vrm3OPpEKR5GaSFXC3qL8zJOqLvXNZzYFeuM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dkznaFOfagoCVCaUq8VxEuNJuC4GRQGfaFv5H2uZ6aJHbo/T1zesutGtZGqFYhshpFvQLbkAoysCwFajib57wecvBVNJjACJDRB5UExGJKVRrBUm9eyES6CE6wLBjh2Z7hvXeLccgv7nOBM8vq6gOctvjPEqu5UYvvMcOihLU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SoqiDdeP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717697563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KeMRLeH8AVI7a9rTTiY6E9/CXZa2WPt/Gto/LcU6z5E=;
	b=SoqiDdePkvNH0uu7KcxzL1hr51Px56KeKd7hbdojySVWqGHeAcDXrMBBf9JbL92rRsm5rF
	97Su1htbKADhpuSa2ykMQffSXgkoq7gDsQlsNze1f7Q2Yj7z3xuzMVFMtmZtF1AdXJNS6e
	ABEkvz08mFCx/bKK9MIT9dxOhnq0m4M=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-H8eWDcY8PdG71auT7GSR9A-1; Thu, 06 Jun 2024 14:12:41 -0400
X-MC-Unique: H8eWDcY8PdG71auT7GSR9A-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2eab0fe8a7eso10956891fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 11:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717697560; x=1718302360;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeMRLeH8AVI7a9rTTiY6E9/CXZa2WPt/Gto/LcU6z5E=;
        b=YN1vxDTgeiDQbjbN2VyhrpuGR5h/Gx8T/r1q+WM48rea11We+d5zGb5YT9abcQEGz+
         K8fh2cdhJVexaB5nLtefV8jWeGL0vxhMQSC1o4gcqgTt1vWZ8ubRZW5oXZpg7UyocLsL
         rMl8eVBOVM3llVywtXI8y8z+PKV9S6DoUsu6xVu8T+MmnghUreiIwKFISjwbCW0q7U8D
         uYJ/qRSWVF2TF/A37/d805jFtB/641Zk1ixkVeVt05y+67GIHLD5gfs+wR/Ly2ys/pK7
         t5RMXA55Rto5zxohZIow8HMbwVCL5+MEj/sdiTzxvsbD4Q51Fq1g28TycPwh62TFMP13
         Kd7g==
X-Gm-Message-State: AOJu0Yzu9kBjNhA3Q0+FelNJ40komejsSDV0/YooBoFIL9cZrULsqXMZ
	qgiwa/gIPhSu5eGHh7HYRh+6RTl2GDARUQZfxrXqIOCRKQtcc0dPTTXiycElmiyqOeYyIvtFx3l
	ndMbiEC6c7ix9+He0Jix/PLs+tu5IZUgWp13tu2PVHKkme5cCTRI1oI8sGF8tTA==
X-Received: by 2002:a2e:be0d:0:b0:2ea:bc04:9876 with SMTP id 38308e7fff4ca-2eadce712d0mr3648071fa.38.1717697560061;
        Thu, 06 Jun 2024 11:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA8ZzHNP1/hcWkbYv2OrPty7pGVWuhlHWVUFyoEu0CW/LdPcqaEzki1tsMBhjPdaeTrSwq3Q==
X-Received: by 2002:a2e:be0d:0:b0:2ea:bc04:9876 with SMTP id 38308e7fff4ca-2eadce712d0mr3647841fa.38.1717697559679;
        Thu, 06 Jun 2024 11:12:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae13dc46sm1465248a12.52.2024.06.06.11.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 11:12:38 -0700 (PDT)
Message-ID: <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
Date: Thu, 6 Jun 2024 20:12:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
From: Hans de Goede <hdegoede@redhat.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Genes Lists <lists@sapience.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
 wentong.wu@intel.com, linux-media@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
 <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
 <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

+To: Rafael since this was Cc-ed to linux-acpi but never send
to Rafael directly.

Rafael this fixes a crash in 6.10-rc1 for some users and is necessary
to make the cameras work on the Dell XPS 13 plus 9320 .

On 5/28/24 7:09 PM, Hans de Goede wrote:
> Hi Sakari,
> 
> On 5/28/24 10:44 AM, Sakari Ailus wrote:
>> Ignore camera related graph port nodes on Dell XPS 9320. They data in BIOS
>> is buggy, just like it is for Dell XPS 9315. The corresponding software
>> nodes are created by the ipu-bridge.
>>
>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> ---
>> Hi,
>>
>> Could you test this and see whether it fixes the warning?
>>
>> The camera might work with this change, too.
> 
> Thank you I just received a Dell XPS 13 plus 9320 myself to use
> for VSC testing and I can confirm that with this patch 6.10.0-rc1
> works, including giving a picture with the libcamera software ISP +
> 3 small libcamera patches.

I forgot to add:

Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




>>  drivers/acpi/mipi-disco-img.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
>> index d05413a0672a..bf9a5cee32ac 100644
>> --- a/drivers/acpi/mipi-disco-img.c
>> +++ b/drivers/acpi/mipi-disco-img.c
>> @@ -732,6 +732,12 @@ static const struct dmi_system_id dmi_ignore_port_nodes[] = {
>>  			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
>>  		},
>>  	},
>> +	{
>> +		.matches = {
>> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9320"),
>> +		},
>> +	},
>>  	{ }
>>  };
>>  


