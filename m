Return-Path: <linux-kernel+bounces-257690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 913E7937D89
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415691F21E79
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F93148837;
	Fri, 19 Jul 2024 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="SK7ubIk3"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D54149C4B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721425201; cv=none; b=ateJdkx74lclGylKTmWSBD1Ya3Y2pQTfMWe6WF3BNnGqvM+lN8D0PYX89mwbfO57c6x62tJHq+7tdxmc/GP90OhBghAprA6m4H/spKo+Un/LWfG497df3OCw5EYPZ0NbO/d07MJwnqRtyFdskd6AlR5vOnqly6sOiy+qaL+g80Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721425201; c=relaxed/simple;
	bh=+rK727bJDKyDqHk+yxAz9jWW/4ivJjyJrvOfkoGOJ3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uf9cWnXYeB5LrxQ6SafNq7tpikt5NjNgGIB0YDA+4UIcNVuy+SQL+wn8oCDq4JzPyRoGmwtH7M5tlw2RCKMyM9mIMmBR9aK5hItcGvUZ5nvNBq9l742LaEhoIOTnKsJXnbYLODgKh7MmTFl0kDPX3D3jfvhgyCAR+uMNf7ZLIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=SK7ubIk3; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70445bb3811so1268357a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1721425198; x=1722029998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxURwrQjaWVMnPupTe3e2QhQiBnQCCXPKt1vU7CQERU=;
        b=SK7ubIk3EdYeBat73ZYGhPWdCbT3ai8kPz8OWyYooyZ3vcPRJtbuQd4znYkw9VEwGk
         c4o4HMJ6zT9ftno4l7GGQSAV+TMghyjUa8Uj405FT6GByEe0YImwqpLBHLhNN6Bu4DuQ
         Y7wPa3Gdt2k+PG29oLc6mHUDBVjHsUg2flwXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721425198; x=1722029998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxURwrQjaWVMnPupTe3e2QhQiBnQCCXPKt1vU7CQERU=;
        b=qLz+AKpLAb3bgDRWGe2rs4UB3cM6x9cEOmfGv3HmuoS0+xqF59Qptg7anMs/ci4sNr
         Iy2EFm5aj+uzJOn+hPi8kKmAg+Rj6TBKkfrG9YLCDS0WYcRoE/ypLD065lQjdlR9Eppa
         dVVU4qJ1hfikfY9xW9t8D7Mq4TE/bceH8HyMdKjtDvCmuAlRceholxIPcUzKYkmuZc+S
         jsZ/mlz3qyn3GaTNyWrDAt//HCekNQ5hVYGCA89Nh3My8q15tm4OVNOH1HS1FtdhN1wO
         K3TIRiMW97iRjpum4fan+7OlKKdqjD+Ai0bGpF4ulYAIDryZVAfHKCF5RvhfsSV7tXGA
         yFbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT83Lmt/eMWCnUJZ6Q4qtaYUBPbR4AGMIDhu4hGUOMuk2IiUIPBMq41vrtVGoUC4QKSCipSBDJmwk3mw1qw2nwiqHWmX7owyd6Qzf7
X-Gm-Message-State: AOJu0Yz6WGSgNoF+pZNIYDABSvxoh2j5wJAW2hGVxtAq9Bx7LORp+O1c
	tnQJDUjE7gy4dRPY1G9EpDo3/eynM42sCygLJvp4/qDBzGT7Ilp1q9PaFo9LTg==
X-Google-Smtp-Source: AGHT+IE74f2iNObwpJtxfcq8M2viSwuF/AsMKv4hekSdNy/d0euPZyuEg0mshxbk4LRUVX4+1T2w8Q==
X-Received: by 2002:a05:6830:418e:b0:703:7786:edab with SMTP id 46e09a7af769-708e379aa81mr11905980a34.4.1721425198123;
        Fri, 19 Jul 2024 14:39:58 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-708f6189bd5sm460642a34.65.2024.07.19.14.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 14:39:57 -0700 (PDT)
Message-ID: <e7e88268-a56b-447c-9d59-6a4eb8fcd25a@ieee.org>
Date: Fri, 19 Jul 2024 16:39:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] greybus: gb-beagleplay: Add firmware upload API
To: Andrew Lunn <andrew@lunn.ch>, Hariprasad Kelam <hkelam@marvell.com>
Cc: Ayush Singh <ayush@beagleboard.org>, jkridner@beagleboard.org,
 robertcnelson@beagleboard.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 greybus-dev@lists.linaro.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org>
 <20240719-beagleplay_fw_upgrade-v1-3-8664d4513252@beagleboard.org>
 <Zppeg3eKcKEifJNW@test-OptiPlex-Tower-Plus-7010>
 <b3269dc8-85ac-41d2-8691-0a70b630de50@lunn.ch>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <b3269dc8-85ac-41d2-8691-0a70b630de50@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/19/24 2:15 PM, Andrew Lunn wrote:
>>>   drivers/greybus/Kconfig         |   1 +
>>>   drivers/greybus/gb-beagleplay.c | 625 +++++++++++++++++++++++++++++++++++++++-
> 
>>> +static u8 csum8(const u8 *data, size_t size, u8 base)
>>> +{
>>> +	size_t i;
>>> +	u8 sum = base;
>> follow reverse x-mas tree
> 
> Since this is not networking, even thought it was posted to the netdev
> list, this comment might not be correct. I had a quick look at some
> greybus code and reverse x-mas tree is not strictly used.
> 
> Please see what the Graybus Maintainers say.

Andrew is correct.  The Greybus code does not strictly follow
the "reverse christmas tree" convention, so there is no need
to do that here.  Please understand that, while checkpatch.pl
offers good and well-intentioned advice, not everything it
warns about must be fixed, and in some cases it suggests things
certain maintainers don't agree with.

					-Alex

> 	Andrew


