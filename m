Return-Path: <linux-kernel+bounces-337949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A959A98515C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB5D284F89
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1DF14A4D4;
	Wed, 25 Sep 2024 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2J5Nfg3W"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1FF14B07A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727234208; cv=none; b=dbUbSyd7LzHwDfIskVmnyA/rMFAvtViXslXy83QzSpjcjz2GDFUeskAQVCJu2G+BtscrjXE8f0ZRgc6v4xDlZ2jqw0CfT8tGGBc7Pu4UlyyIfbIG7N77syaF4JjYt5uXR0x8uie8ksEAH5Z/wcZRCbzANy8aRs3dr0aVm8I3gik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727234208; c=relaxed/simple;
	bh=WH3f1wEHTyRTJ7AT+c2IFOfTQMxKRPyA2AXtakgC6sg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d4jdRw0db+N9px9KcaYmyOlD592/mstDUb1XCK7gC7n5qB8mJsivtBgWM2/h/nUbZdG7zpIjJQ9f0wyKoPBYndXNFX3sze11x2qxK6KymCYyw8U4lorkgSNC2/nJh1xrtPHc1TArqavPwY97ZRu6DZN+98mrQHWemqU7hxVcKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2J5Nfg3W; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2da4ea59658so4964554a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727234206; x=1727839006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j/foBZ7L1xcE0uOYfjQY3pnhprf6ad5uc1MzhfvUezU=;
        b=2J5Nfg3Wlo1FqRRtbPbdRKFX5uQo2fWSeDO4xAJquR2w+XVOg7qVHJ+CYE3aZz+6PJ
         BIj+nFRb7jMB6F1o8P6AuVGFZYUxdlnrQSPDAY47a+z31gddVHoOD9E5uoVpjpjnJyiJ
         XvppiA4diX3kWPetnU9of5v2uwOJosbyp1obhCG8xxxER7qAg+/a2ZH68tHzDocpbElm
         OxH0u8OJM/MujOmSPrCl+eWBEb8LkrVpGsjus43w1vMIFQwas5cyJeBQ1r5l7qixzQDa
         nd2Smd9uxTbqeEKQu9PBVJ+is7mlhwIcFsFgoinlqPxt6m7A4sjBkFtUilYVKOnZyJFv
         ivBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727234206; x=1727839006;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/foBZ7L1xcE0uOYfjQY3pnhprf6ad5uc1MzhfvUezU=;
        b=Bbkg9OEaeHLoEKRKT3BCwr7yP688L7f3IRbwO4HjSOlWcqT5oA+F1OT3EMhncJ4kEw
         ERmt1K/uDr7V3zGREf6qOZiaWt//svLPLhbtR5Np5Ph+mF2VLXoi4c70fN3kfhQOhbQ7
         QyrNMXSk0NQWbj9h7Dph/8KU1dkSSa3mE/WuV1sg7VgqdU9h4XMuB/GVPK1wc9fFZPxd
         OVic6xZLuzLPJ5yFoh5S4nKs9J/nQVlwQaOddhP4Pxjx6DX203Jdvxeg9+04H+07Nt9h
         NwXZbYF5ELG5UPbD2jamBRtF02bPbKj1xqBwu7Hj5JQE5uV4MHVK9krle0DOd6w3FQBw
         E9JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWazTe1/Swq6l+f5r/QOMpxyLl73hjOAdIXSx0xxbAl9YkjT1hz4ahAii7s78mfGi1109OnGAAlTgrQuu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAKZvaSkITciKt+hsMXfQteF96rQXv/QvbN55js4UoFOS0tzqh
	oUVbZPwS97gb40fqxHHQvFNORT38VEuQiYXcUZ2hW61K2QsrtqHkl81MXcWMhA==
X-Google-Smtp-Source: AGHT+IHNTG/XEGwlf6r5ouS7N3mZHtb1iWq6Pcvw53rK4zJHPUQ1Ne1Ch54gGVnRgQVdpD3vSX+AvA==
X-Received: by 2002:a17:90a:17cb:b0:2e0:78a0:55c4 with SMTP id 98e67ed59e1d1-2e078a0572cmr194836a91.9.1727234206189;
        Tue, 24 Sep 2024 20:16:46 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:8:32ad:6c37:2d1:220a? ([2a00:79e0:2e14:8:32ad:6c37:2d1:220a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1a08fesm327560a91.5.2024.09.24.20.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 20:16:45 -0700 (PDT)
Message-ID: <66d9af81-d211-45c9-bc3e-8dec5a8f92e0@google.com>
Date: Tue, 24 Sep 2024 20:16:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 2/2] usb: typec: tcpm: Add support for parsing time dt
 properties
From: Amit Sunil Dhamne <amitsd@google.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, dmitry.baryshkov@linaro.org,
 badhri@google.com, kyletso@google.com, rdbabiera@google.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240923224059.3674414-1-amitsd@google.com>
 <20240923224059.3674414-3-amitsd@google.com>
 <ZvK2slBHR8PhzaMt@kuha.fi.intel.com>
 <d72cc89a-7f73-4294-927e-48e647e37310@google.com>
Content-Language: en-US
In-Reply-To: <d72cc89a-7f73-4294-927e-48e647e37310@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 9/24/24 7:44 PM, Amit Sunil Dhamne wrote:
> Hi Heikki,
>
> On 9/24/24 5:55 AM, Heikki Krogerus wrote:
>> Hi,
>>
>>> @@ -7611,10 +7650,13 @@ struct tcpm_port *tcpm_register_port(struct 
>>> device *dev, struct tcpc_dev *tcpc)
>>>       err = tcpm_fw_get_caps(port, tcpc->fwnode);
>>>       if (err < 0)
>>>           goto out_destroy_wq;
>>> +
>>
>> This extra newline is not relevant or necessary. Otherwise this LGTM:
>
> Thanks for reviewing! Please let me know if I should upload a new set 
> or this is alright at this time?


Uploaded a new patchset anyway: 
https://lore.kernel.org/all/20240925031135.1101048-3-amitsd@google.com/


Thanks!

>
> -- 
>
> Amit
>
>>
>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
>>>       err = tcpm_fw_get_snk_vdos(port, tcpc->fwnode);
>>>       if (err < 0)
>>>           goto out_destroy_wq;
>>>   +    tcpm_fw_get_timings(port, tcpc->fwnode);
>>> +
>>>       port->try_role = port->typec_caps.prefer_role;
>>>         port->typec_caps.revision = 0x0120;    /* Type-C spec 
>>> release 1.2 */
>> thanks,
>>

