Return-Path: <linux-kernel+bounces-511252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F69BA3285C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58B11889858
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6391210182;
	Wed, 12 Feb 2025 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6UQ+tFx"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4201209669;
	Wed, 12 Feb 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370432; cv=none; b=it8at9bPVhGDIW8o8nrtVmr4uGbjSRLzYRY/yv6MMH0eJvR7Ig9RdGjUMWuQw/INvJu9WT8Km7QmBiW4qDz+BOS76a4I6Z9JNIulLfP0YfrUNDTCarKTubrYJqf+rCc9SWre46zjt+TmJcgTZHieA6dtsoZcmYR93Gv9ZH0QD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370432; c=relaxed/simple;
	bh=G5aGh/z5cuZAAKzmU8Tp316oork2upuMCHWPHJKvovg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnmOmyYtTaYtCBuKbBRPr8IAEvlVavYuJLJ/gT/FoisOiLzZ6273g63/Av5S5s6m+qy0aw1CKvTEZsayZIlYkMApGmpFnjUK1X0WeuQVPSWtKQT26BibDF9AynNdHVERvIvwNHLBpxdgMgeE9JRK3GNmP2C4wZnB4qg0euWYutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6UQ+tFx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso1499644a91.0;
        Wed, 12 Feb 2025 06:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739370429; x=1739975229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLLFSTDiSu+HGCeHAI59YjqyuxW6/jqR1IPEHINh9UU=;
        b=O6UQ+tFxbNXi3up21pAyyeMqcEtMQ/7SPRo29IpjQThimzKPFfsRlCZIa2wlCWOuXO
         0Fx1+uCXutVwrXBOAm286xaDcCk5lNTidhqFzAKRpKqjSlQDMTUnt+HMvQRNJe3L6V28
         yAYOIIKD8MlwQFUG3WZJsyjsxeZUg7w4PT51PV6Uuh+vBuJaSt4TcnCZG5ikPBz5UIhp
         HWFdkouxjLMHSTNHZ2Corrg7wNpXRuuHQnT89QRYXrqRzWIVVOcPVfY5Zh3b2+wZv29K
         NTGYCAUgoRNQrwls0a4SIu46f4XPgy8wlXv/HlW+OvO2SqkjbxtwOZVkJ4sEEsV+tz+V
         blKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739370429; x=1739975229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLLFSTDiSu+HGCeHAI59YjqyuxW6/jqR1IPEHINh9UU=;
        b=v/3p+pmmKpB3Lc/g31c0TIYDPSzVzQ6fQyXZXUTnGuciSGzWrkjGQuogB6TXnPzdiu
         by/XwCx7/oQp63o4MT7YWw/FM53NZTipwE0jZLjCia8pWGJmnQfffQstS2YgE1lWNC1Z
         qvOEVuu6n0VDnS5etadIc7dyLg52NCwvi73f3OBrRjQEPjcCBEXDen5VTDFIvcUlP//T
         lcj79NHcnKrEW/63pufBe9iTA/zCbfkxC3xGgzpqKhZQ4So4qsHdvmgbr7RT4ATg7B3A
         +zuYl/TBvrLnbcAP3C57ZFF1KmZILD6U5C1K3wzizGtLH6yylaFZht6YgiQSpco7Xy3l
         +J2A==
X-Forwarded-Encrypted: i=1; AJvYcCVI/xy17HJyjGNpIK4w+3GrpJCbyUGl6MudMFaOVM81chWW8IHb41fRXqIj0xMKlBhffKeeyxqkXEan@vger.kernel.org, AJvYcCXRlmomxlLt0mvxOVJwomBEOFyPulCzQebbF2vU0ezIXWssyOz42mbtH5U67FTpB5HMdEp5xcEeRDMyaKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvWDBkNgX549iFgqGD0SB28T/6thP4ZnP0Ao97xFVdoI7QtaYc
	G1aOqYEqOkGlGWWL3ZXxdEELLGwBwAVBzSpVe7el0s952dUWuh9NF/K33A==
X-Gm-Gg: ASbGnctMRCBjFaz8AKIXdutcvVwGzPnWfZsIp1N/cjHetoD79zZbKJ/hQpHOmF9PB9l
	yuV5CV/iCqdcEFR8tE7Q/ZR+vvb2k36XAoud+okwPYX3Og9Ok/kWxygi2voaM3W4mdaZBW2x+QR
	y7C9aq5vqX0iYueCtVBwxq6U/4t54inCV1nm9zanpIKzTrrMLErLoTp8dyjv4pW8xnyR5QjRHoM
	B1fXIOo7MmvpMzhIud5Y8OEgxbaa1sPayMKme1NBI6Cb8CnXny1lKGxX2188HQOJ35HjKWTUMTM
	h6DxWu3vLGP6ckWnz++jNhuWwoHtBAPXvtD6Ya7y7qATSeSUq0KjeYNjR05GPw==
X-Google-Smtp-Source: AGHT+IHsBuRHC0w4yLYgopWWb29hm2Ux+wINxvdj4nJCX9zlDlvuHeA/vuU9gCNkpMplMusSJxp6FQ==
X-Received: by 2002:a17:90a:d88c:b0:2fa:2252:f436 with SMTP id 98e67ed59e1d1-2fbf5be094amr5150882a91.3.1739370429109;
        Wed, 12 Feb 2025 06:27:09 -0800 (PST)
Received: from ?IPV6:2409:40c0:2e:ea4:a251:12db:9bc4:5019? ([2409:40c0:2e:ea4:a251:12db:9bc4:5019])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9ab049fsm1536032a91.47.2025.02.12.06.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 06:27:08 -0800 (PST)
Message-ID: <85c3ef44-9be6-4264-bfb3-6017c46413c0@gmail.com>
Date: Wed, 12 Feb 2025 19:57:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Document nostream_work member in dwc3_ep
 struct
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250205202733.18611-1-purvayeshi550@gmail.com>
 <20250211032002.vhoewlv6bu65m7sl@synopsys.com>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <20250211032002.vhoewlv6bu65m7sl@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/02/25 08:50, Thinh Nguyen wrote:
> On Thu, Feb 06, 2025, Purva Yeshi wrote:
>> Added description for the 'nostream_work' member in struct dwc3_ep to
>> resolve the kerneldoc warning when running 'make htmldocs'.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>>   drivers/usb/dwc3/core.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index ac7c730f8..9095878d7 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -717,6 +717,7 @@ struct dwc3_event_buffer {
>>   /**
>>    * struct dwc3_ep - device side endpoint representation
>>    * @endpoint: usb endpoint
>> + * @nostream_work: delayed work structure for handling no-stream events
>>    * @cancelled_list: list of cancelled requests for this endpoint
>>    * @pending_list: list of pending requests for this endpoint
>>    * @started_list: list of started requests on this endpoint
>> -- 
>> 2.34.1
>>
> 
> I believe this fix was already added to Greg's usb-linus branch.
> 
> BR,
> Thinh

Thank you for the update. I was not aware that this fix had already been 
included.

Best regards,
Purva Yeshi

