Return-Path: <linux-kernel+bounces-262598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E542193C932
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCDA28421D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3895C7172F;
	Thu, 25 Jul 2024 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="cyYoj0xj"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F4552F9E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937233; cv=none; b=hspcOrsDn5LlisS7aLEXBLzhlIp3b5CKZodlYv0MxysZlp3SXTITOxSKiF2g0Vz65A5wfe2Q1GpAxT/ffKOqcB/4g/3gr/e7B6c7J1d7QVW6Hr96d9jlPtBG8ofvz+46K0A4Avvuo6xuB3/kgQ2LWVgFwdS23w1HitN9CPjUhkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937233; c=relaxed/simple;
	bh=dnFyLc8FMHnZh5Zqxhn8RCLKkasFxOnoPY0UClcTDhg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=sGQmmV7q7Wh6YmMjnjFiRsXYEVjGZc3aFlCD8EFDeZm6Xqa7SsM57oQdRn5tHCQD/IDfIdLzmsQPkdEulxQckhJMuuwBeGI2uHRb31CyR6cxMAHiszH+1nMFfOyI/ru/wILIXLiJBrTtj+MScl05/QNtfVaxd9HJ0IdSjmyPcAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=cyYoj0xj; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 2427 invoked from network); 25 Jul 2024 21:47:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1721936828; bh=T/C4WNEM/hpPM+iNtPmiVDuRbgLAxYRjShFb/5C0a9A=;
          h=Subject:From:To;
          b=cyYoj0xjk/Xj9HVhj5qn5T5BtkdkKISVwlZuRNmW+eqD2qd5fKJyklosIU4owQqn0
           OEEHvwAh6cTCIATiJKtrZahO/e2dnxLJCfOdCB6VE2c+kxBqos/4s5d1WT5dX/XeRU
           oxp+0yIwAO1Z3OPWnxqBnEnVHt1jgoyCwxOLhw6o=
Received: from 83.24.139.131.ipv4.supernova.orange.pl (HELO [192.168.3.100]) (olek2@wp.pl@[83.24.139.131])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <pabeni@redhat.com>; 25 Jul 2024 21:47:08 +0200
Message-ID: <569cd471-4fcb-49d1-b5b6-39e8ff7e72d0@wp.pl>
Date: Thu, 25 Jul 2024 21:47:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: lantiq_etop: fix memory disclosure
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shannon.nelson@amd.com,
 sd@queasysnail.net, u.kleine-koenig@pengutronix.de, john@phrozen.org,
 ralf@linux-mips.org, ralph.hempel@lantiq.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240713223357.2911169-1-olek2@wp.pl>
 <b5a2f43e-790f-475c-bb63-539af91513ac@redhat.com>
 <f198e784-119e-448c-8c72-a02075623809@wp.pl>
Content-Language: en-US
In-Reply-To: <f198e784-119e-448c-8c72-a02075623809@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: e64dec91a32aaba6b2d5d4ee6f95469b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [YZPk]                               


On 16.07.2024 21:27, Aleksander Jan Bajkowski wrote:
> Hi Paolo,
>
> On 16.07.2024 11:46, Paolo Abeni wrote:
>> On 7/14/24 00:33, Aleksander Jan Bajkowski wrote:
>>> diff --git a/drivers/net/ethernet/lantiq_etop.c 
>>> b/drivers/net/ethernet/lantiq_etop.c
>>> index 0b9982804370..196715d9ea43 100644
>>> --- a/drivers/net/ethernet/lantiq_etop.c
>>> +++ b/drivers/net/ethernet/lantiq_etop.c
>>> @@ -478,11 +478,11 @@ ltq_etop_tx(struct sk_buff *skb, struct 
>>> net_device *dev)
>>>       struct ltq_etop_priv *priv = netdev_priv(dev);
>>>       struct ltq_etop_chan *ch = &priv->ch[(queue << 1) | 1];
>>>       struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
>>> -    int len;
>>>       unsigned long flags;
>>>       u32 byte_offset;
>>>   -    len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
>>> +    if (skb_put_padto(skb, ETH_ZLEN))
>>
>> You may want to increment tx drop stats here.
>
> Statistics are on my TODO list. The current version of this driver
> does not support statistics, so I will add them then. I would first
> prefer to fix all the bugs present in the current version of the driver
> and then add new features.


Can this patch be merged? With the current form, it should be easy
to backport. I will add statistics to this driver in the future. I think it
doesn't make sense to increment only one statistic of dropped packets.

>
>
>>
>> Thanks,
>>
>> Paolo
>>
> Best regards,
> Aleksander
>
>

