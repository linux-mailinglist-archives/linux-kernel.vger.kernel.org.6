Return-Path: <linux-kernel+bounces-244491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B315492A4F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BEA1C21352
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BEB13DDBF;
	Mon,  8 Jul 2024 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfVRk9jo"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E91C06;
	Mon,  8 Jul 2024 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449808; cv=none; b=nyedgPm6bhL3eAVvCvM3BhLkeT+/S69UYlVSFwKDCEpDJeZWQfHQuYuA6abmVnraaneQHYB2Jvo5RIHwqaBLv53TVjrp43nEiV3K0Tx5zAInvr1y0f0wgQFmd29xMyU0BLwhpVqfEJp8Cbx/zEb5+ZXCxjTjl2Q9IVbe7q7+iI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449808; c=relaxed/simple;
	bh=CHWqoIV9RCwtCwzWQhYtMQfO1WmPimGp7WMmqX2bbI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxwo6p4xXz6es+rVG6qoASvwbHKzDUeunp5C6AdIM+TRCgIW+aWPaRc/AAB4MkOoFGxPYuFMT93FHpLJwUawL/dH5svl8D2AC0WfvQWS0zlPnAV58GHLptvrXuM6Mk/IkI2/9knokruvXO4Uj5dkE4moI1Q/ctlDuvmFARYDD08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfVRk9jo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb0d7e4ee9so26012685ad.3;
        Mon, 08 Jul 2024 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720449806; x=1721054606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OR72EgiGejdHn+1BiHKQnjBsdzjCQp49d2Jtk5/6u/k=;
        b=KfVRk9jogkoQ1jDNLWYfNF/gKNd7cZALK+opFz93ilXNyjG9XZLiBFh8fB9p8CnVqn
         qugJwiwv0nS+h/SS/VKFihRoK7NfjRa21mpuC8AtHXIh5XThvcON+lT23TUSZ+mgYvCE
         JjVHpEb5syh9lP7I9kdaaOh4SLczRlJ1oz9Vl/aewBM4JCHWCqNlrxYNvwyX9vfPq2r5
         QotO2bSjAl+Vg5H4zZSf8Bng4tctxBKQG8ZT7n2jBGr4VbhWP5LD/Xno12SOVkI1S8Cf
         Muh1pT4QZl9o1rZkYENEW8ryCho/sa3ER2maQUnvcyfmtfdzTsc0BESwNda/JTJBKKA4
         juCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720449806; x=1721054606;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OR72EgiGejdHn+1BiHKQnjBsdzjCQp49d2Jtk5/6u/k=;
        b=Dbg14my7aYD28bzUVrpbzd2B5OeeUbFp7yFRGO02irWIvpcBFbSWQKqQLMAw/gF2Rw
         9AfnDQyrQPqPDvbYyvdOfamH9lBjFzLTy5sBFZ0j6BpM3QK4MTjsgIwL34DgP04i0NvP
         O6/T8PAQJmkyFSJRXn/7zTyJ87TzqNEPdQ0mlXv+bq8sWJbSvLJ4oQNMxcnUaJxOPFAB
         +xAKvRMY8R00hIaE1StCSc6TrW44mnq4mJOvagRbIBLIHsXMV+UIx1bYyRyByuO1LrYW
         hqUFF/bWLW29RT5r2p8AY9/HfKN6aLlZ0dQTDTeO4DvCGb7s5IJBSXNsMSbg3FcC1qoq
         RnSg==
X-Forwarded-Encrypted: i=1; AJvYcCVdM1YjQpCx+AraQ8P3z/o3vht5+DjRYhYE/x4P8uWxOhCmxRIFd0UiTtcV5KHRjD8BdKi6AMvypcZdZzhJVmn94teKFxs7WTfN5sE=
X-Gm-Message-State: AOJu0YxIe4spkswnzQneHBYGikzG+bId9pMcG6rlf8oGR2aO6pcwby4j
	lB3JH07lvYIyzi5+J5osOMbhM3+tKB2OkadMr28eY5puj/T8/Q/H
X-Google-Smtp-Source: AGHT+IFgHiNaL7yJfpctkH7CTVXFOojbuEkw1n7xgVIs0z64cnq5x6HNe58jAX+ZIwjpot0A9TZFHA==
X-Received: by 2002:a17:902:fc45:b0:1fb:7de2:8dc4 with SMTP id d9443c01a7336-1fb7de29030mr48477755ad.57.1720449805635;
        Mon, 08 Jul 2024 07:43:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb5bcbaff1sm49027515ad.8.2024.07.08.07.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 07:43:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e2c378a1-0137-4c31-aa38-34e808406f36@roeck-us.net>
Date: Mon, 8 Jul 2024 07:43:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] hwmon: (amc6821) Convert to use regmap
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240705213547.1155690-1-linux@roeck-us.net>
 <20240705213547.1155690-10-linux@roeck-us.net>
 <e38ceaf9-c904-41f1-a32d-14a150c92f30@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <e38ceaf9-c904-41f1-a32d-14a150c92f30@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Quentin.On 7/8/24 03:58, Quentin Schulz wrote:

>> +    regval = BIT(5) >> FIELD_GET(AMC6821_TEMP_SLOPE_MASK, regval);
> 
> BIT(5) doesn't have real meaning in the datasheet, what is in the datasheet though is that the slope is 32 / L-SLP[2:0] (well, you can more easily guess it from the datasheet than 0x20 or BIT(5) IMO).
> 

Good point, though it is 32 >> L-SLP[2:0]. I'll make it 32 and add a comment,
but I won't send another version.

>> +        ret = amc6821_get_auto_point_temps(data->regmap, 1 - nr, otemps);
> 
> I would have been more comfortable with
> nr ? 0 : 1
> 

No, because that is a conditional and 1 - nr isn't.

> Only nitpicks, so:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 

Thanks for the detailed reviews!

Guenter



