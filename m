Return-Path: <linux-kernel+bounces-559037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF79A5EE9D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1A719C0647
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845DB262D19;
	Thu, 13 Mar 2025 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HeSB7Rqx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD681BDCF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856209; cv=none; b=inz/cONiLABWM8D7OSA2WV78dqsPuVika1iH38RsZy5aSUYdmb/xHZmlvxQ1A3N7cYbOENkE1jXbD3/50D5D5uxOQDkJSBMlUmIbr3BK71iuZDQof03NY6B7VIC08Jd7VP/PDGekHbUdEemyLiRQ6LgWfXrzYeziBE6WYRmLWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856209; c=relaxed/simple;
	bh=MN2o2MYobQJl9px7sHfTeadgYO6AsM8ahCPbVurX5dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMeVCWiDA6k+lXffG2Z+ZLUGaDxjm8+aG6GRQ4iRxg6fj/T3gjRozS8VdXIBhRFCcodu4FQdRB13Konr/AKJ78vQOiVkWg1gICbNHVns/RJDCxaAR01w3RB+ILSLOgdXkYTJ/3eDd530lhP2X91mXQFTvK7k5teJw5/ULB/7t8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HeSB7Rqx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741856206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oq+24fkQG9B36+j3ofSLg7Afq2zSvxuROfzYWAGMCrQ=;
	b=HeSB7RqxQu7w30M+KPY2XFNwI7/nBa8LgCWEGsSAzSq6XW4WFvjfM/9QRurxRewSjodaab
	tGJlpdh/DxDd0i/iSvVrvsRegjlRdVwWisaZAWktGyCqpkO3iDmxhVr7snaEDPty49Gi5t
	AsIARPuREs5DTv6dOW3UhUNlNhTcgpU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-mmocP6gOP52TFVWTol37YA-1; Thu, 13 Mar 2025 04:56:45 -0400
X-MC-Unique: mmocP6gOP52TFVWTol37YA-1
X-Mimecast-MFC-AGG-ID: mmocP6gOP52TFVWTol37YA_1741856204
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912539665cso776669f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856204; x=1742461004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oq+24fkQG9B36+j3ofSLg7Afq2zSvxuROfzYWAGMCrQ=;
        b=seWh5GsWuYTRlPbgzfTZWce+wWmL85an+g7IKudjh8SgYhA/0boyMtAgJvEk+Ak7aH
         r3ZIx4pQOkwNHVE/II6+6o4COdmF88jAgVfc/cvRzW7a5lIZkixA8VZLTsz/bStLiV0o
         VZt+3ifhk92pbPcNdE/QMVxkLSe0UqoQsX3MQULHtAOKf0KEXuNA5yklTyZdtQ6A/VCs
         uiLeaMFsg2xkbU/9QTiAOlHTyfM9nNWs6Y4yQnxUpAOeUybrm+0ArtAsNGiPCgOq2L6R
         vpWbSyq3XdDrf86WBelETGJMCy1mhTbSNir0omdDK1B1BpxAeT6HjN4qSgkysVRveUn4
         1H0A==
X-Forwarded-Encrypted: i=1; AJvYcCUfeZWSSJYudkXGy6S4GiF2vL/p/wvYds8bsFMZpqwtMdMidS7F23Hf1EEzHngzGZP+s1rHWby7nhTBEmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01vSysuPqZWuoosFZ1eugPoLbD1Z3JmPXQ/pP9RfwP+vOwKlG
	3GFGhEST2SDBcSS64xVnNSHNXUE/+R5/8xMgVhY7Qu/8NcmitJA5eWRgC/+rXx7KcOWNii8SPtN
	qspud7wV2e8OX0+dqy3REYDNCZZ9YgjPlEGJ0E4QhOChUqhDH+KwB/LKvnFNiXA==
X-Gm-Gg: ASbGnctwPsqS3CWvUpEQcMjs87UmcZ17ZqThD9DI7JzDDXE6w8G/p+3EHWYlV5MU09I
	TWwF5qEmtugMhP8iqc5gbSMzMUAmmZAdMep9rvLmQ466QeGUYB9D8nN8HbT/noEKDpbglS5u+pG
	+6L9L/oAUZkl1C3fZVY3b8nHdXjMkbpBMoe46SC5HTSeR+14ot2o2fujCUibOJ5tc2gDuIS5/jm
	aG/e7RVgbSFJswl1euVhBUqpSByGTblie2BN+MFUzj4S4pQALVf2FhNLpaQdCltUTA0eVuqTfDX
	xlb0NCkTFChsSmH3fVbg8bEywkjEhrydhN7JkSGuWDM=
X-Received: by 2002:a5d:59a3:0:b0:390:e904:63ee with SMTP id ffacd0b85a97d-395b954eb3fmr1140378f8f.17.1741856204168;
        Thu, 13 Mar 2025 01:56:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2waDP34RqXt0KBDw48jv4ij3ndaEJeyaWFw4ma7prQWIWMBKhbkdZzIvaLpui+87fLLt/Nw==
X-Received: by 2002:a5d:59a3:0:b0:390:e904:63ee with SMTP id ffacd0b85a97d-395b954eb3fmr1140348f8f.17.1741856203847;
        Thu, 13 Mar 2025 01:56:43 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-237.dyn.eolo.it. [146.241.7.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d188b0092sm13287825e9.5.2025.03.13.01.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 01:56:43 -0700 (PDT)
Message-ID: <2ff2d876-84b4-4f2f-a8cc-5eeb0affed2b@redhat.com>
Date: Thu, 13 Mar 2025 09:56:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pull-request] mlx5-next updates 2025-03-10
To: Tariq Toukan <ttoukan.linux@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, leon@kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, mbloch@nvidia.com, moshe@nvidia.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, leonro@nvidia.com, ychemla@nvidia.com,
 Tariq Toukan <tariqt@nvidia.com>
References: <1741608293-41436-1-git-send-email-tariqt@nvidia.com>
 <174168972325.3890771.16087738431627229920.git-patchwork-notify@kernel.org>
 <9960fce1-991e-4aa3-b2a9-b3b212a03631@gmail.com>
 <20250312212942.56d778e7@kernel.org>
 <f30ee793-6538-4ec8-b90d-90e7513a5b3c@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f30ee793-6538-4ec8-b90d-90e7513a5b3c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/25 9:07 AM, Tariq Toukan wrote:
> On 12/03/2025 22:29, Jakub Kicinski wrote:
>> On Tue, 11 Mar 2025 22:50:24 +0200 Tariq Toukan wrote:
>>>> This pull request was applied to bpf/bpf-next.git (net)
>>>
>>> Seems to be mistakenly applied to bpf-next instead of net-next.
>>
>> The bot gets confused. You should probably throw the date into the tag
>> to make its job a little easier.
> 
> It did not pull the intended patch in this PR:
> f550694e88b7 net/mlx5: Add IFC bits for PPCNT recovery counters group
> 
> Anything wrong with the PR itself?
> Or it is bot issue?
> 
>> In any case, the tag pulls 6 commits
>> for me now.. (I may have missed repost, I'm quite behind on the ML
>> traffic)
> 
> How do we get the patch pulled?

My [limited] understanding is as follow: nobody actually processed the
PR yet, the bot was just confused by the generic tag name.

I can pull the tag right now/soon, if you confirm that this tag:

https://web.git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next

is still valid/correct.

> It's necessary for my next feature in queue...

Please note that due to the concurrent NetDev conference we are
processing patches with limited capacity, please expect considerable delay.

Thanks,

Paolo


