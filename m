Return-Path: <linux-kernel+bounces-366212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A51B99F23A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD1E1C22C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60B356446;
	Tue, 15 Oct 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BzoaOpGL"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD241581F3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008087; cv=none; b=E0EPui0cWJ/F4t3aZQKFPtDeQpV+HUfloI82N0NoVptREW4t461D8BZmlftnYiZ1nsfvcJgxvY8t6uIquNm9tzQrTx/3aIn3FMt2bsulCRvLFryB1ULFAa61lTMSLeO40S9YN3c21OuCa0oA6qP9G/tyBZeZ6l0sKbyWXp4pJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008087; c=relaxed/simple;
	bh=jqzuI1KjZlYwaYQXOMQWI/2ET4ZxgrRbs5jSZKisPNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewJxiEGG/oSWaEpQ2zpHanL5P9HtzXwYRDeb+awCvTLjBbxBt6RtXeNzdWNiPKbsHwqiWqMT+CdapDkL3axLCtsq9IPlMH7gBdXZk/OcDkNhF9cHb03DjhLivlG1eM2dBWw6xzYMSkU07fjfI+RBmvPceemYFwaA/yR/UGj/eOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BzoaOpGL; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-835464abfa7so187980739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729008084; x=1729612884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8s+7gsg2JYqPAfbKcYne9b3YpM+dhp+OYrhzHgGLomQ=;
        b=BzoaOpGL0slJy5/E7DS5kQEBQAX4IA3lgaExH0so1HwaF0Jf4AlJiFWPSgBjthRvG/
         DF+CKUE11bX5/kR+5cOz64j28HHiTRLQVcEgOd4PuC+IvCazVpndoDihdrNEIuGEpEnG
         ladE0LSk8h92Hf1j+ty++5QMsObcimaqy60KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729008084; x=1729612884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8s+7gsg2JYqPAfbKcYne9b3YpM+dhp+OYrhzHgGLomQ=;
        b=iPpp6lRW7x+RnAVlLtpWkLTC7o6SEx+BG7G0FaQtyRadq7IY8eHvouhSB18hen/E+8
         /TlKutAQeQWSJLmTWlKRciwkrkikI49hMjm+WTJLlVBH/jkLg1MqQJw1QPryz9fOVyQK
         yvFdgONNJ14BprnsIIQ07aAlGaJZuCmPYuMieRKE8WpYo1rgE8J/xm0zNaoUAoqEpKVC
         +oRsXH+NgoqbHHcTfxUfjSQm+QBiYLqw5nrtOP09JGx/xgEe+EzSxuWoo7li6kwxHP3U
         u+zQ7z5mfBW4c6wnKlV2g/03v91wU4y+/iieTRYaCJBUd5+qS8/W78rkF/k9FPEIql2z
         vGug==
X-Forwarded-Encrypted: i=1; AJvYcCV+LqHIm2pShKTq44As1FwgXHIIAcxDgJw5JZCwFSCDTgxXBN1lxUY4XngkA+QFNoV4xohZBKOuxZAeKoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPRZVLQmR4MDRGPp0Ae8AxGH7s7TvcrdZppQLQOYv5TbdEcyyo
	1odWREX5bfIzgm0H86qcE3h/0Z+WirBmPpCyHYbdpS+hiR1qzKG1I02yHugDx7M=
X-Google-Smtp-Source: AGHT+IGzELDMMYz4ZVvCQt2W2himwaElc8LWbYn6pi8ZJFv3gg5InzK/2HEeDQrXYkzZunPzolfDwg==
X-Received: by 2002:a05:6602:1503:b0:82b:40f:63c6 with SMTP id ca18e2360f4ac-83a64d161a3mr1396226739f.4.1729008084313;
        Tue, 15 Oct 2024 09:01:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83a96c7fee6sm6304139f.53.2024.10.15.09.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 09:01:23 -0700 (PDT)
Message-ID: <43eff9c9-9a23-46ac-9015-dbee35562848@linuxfoundation.org>
Date: Tue, 15 Oct 2024 10:01:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2][next] Bluetooth: btintel_pcie: Remove structually
 deadcode
To: Dan Carpenter <dan.carpenter@linaro.org>,
 "Everest K.C." <everestkc@everestkc.com.np>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 kernel-janitors@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241015045843.20134-1-everestkc@everestkc.com.np>
 <8a4a8915-d59a-407d-9f93-f047370cca62@stanley.mountain>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <8a4a8915-d59a-407d-9f93-f047370cca62@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 03:48, Dan Carpenter wrote:
> The subject has a typo.  s/structually/structurally/
> 
>> The intel bluetooth module was successfully built after the change
>> without any errors.
>>
> 
> Delete this sentence.  It should just be assumed that changes don't break the
> build.  You can put that code isn't tested under the --- cut off line, if you
> want to put a warning message.  But we don't need this in the permanent git log.
> 
> 
>> This issue was reported by Coverity Scan.
>> https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600709

Restating what I said in your other coverity patch, include
the coverity warning. This link requires login and no use
for people who don't have coverity account.

In the future don't include link that require login in the
commit logs.

>>
>> Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
>> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
>> ---
>    ^^^
> Cut off line.
> 
> regards,
> dan carpenter
> 

thanks,
-- Shuah

