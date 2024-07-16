Return-Path: <linux-kernel+bounces-254330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A9A9331D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F13281C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E791A01B8;
	Tue, 16 Jul 2024 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="jJdfsX3Z"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415419FA89
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158089; cv=none; b=Bhf6TpGUdGRf8LJ6W1UnVLVbVgzVNdHkZzCQ5WgN/RgoXvGf2IowkecnfnDlfKY31iQhSp2SNp7bUhvjBVHqNCJh41fD6ZZ2XYAW5n7kDKyifgtTtc08j0xaCKIqOKObCFShmf+qQeVyTwVlW5AU91fTf3jv1rC2hoqI2rMFjN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158089; c=relaxed/simple;
	bh=Ygw1YCI4FrNNIFN2ejQviKt2q6IdYCHyUHmFYwY/BgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i/vBq7FglWgXTpNZgRpAaITPx/pCs82HCzmlSPI3VhbZwfdPQUweokB90KtjqhVPXaXV1GUsAtX68JDTPocmiPwxMOTrQcehyW7rXp8HGrEhm7j4H314tdzzEdFDPzhWLrwNbeWhQBpvvKrkS9B+rjcE7cNKD84fhO8JTe7vzq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=jJdfsX3Z; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 3845 invoked from network); 16 Jul 2024 21:27:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1721158078; bh=mqI4WkJLO0SZdBlyKqtx7TFzSQ+QeKWzatQeSw9Tnbk=;
          h=Subject:To:From;
          b=jJdfsX3ZBtrpnx58MMSfTjTiJ+jgjrSjOPdzUKDNJXf31ySFeS/iCjoZN6Lx15sts
           +Plt3UYAgcZzBkfOrkLO/EDAnBBc9BzrUt4CE9m05d8hX7z+FgoElz2oRJeYYPmJde
           v/s+ROc9AbAXxItPRdlEzE+AHkAXmps9f4g1kJXU=
Received: from 83.24.148.52.ipv4.supernova.orange.pl (HELO [192.168.3.181]) (olek2@wp.pl@[83.24.148.52])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <pabeni@redhat.com>; 16 Jul 2024 21:27:58 +0200
Message-ID: <f198e784-119e-448c-8c72-a02075623809@wp.pl>
Date: Tue, 16 Jul 2024 21:27:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: lantiq_etop: fix memory disclosure
To: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shannon.nelson@amd.com,
 sd@queasysnail.net, u.kleine-koenig@pengutronix.de, john@phrozen.org,
 ralf@linux-mips.org, ralph.hempel@lantiq.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240713223357.2911169-1-olek2@wp.pl>
 <b5a2f43e-790f-475c-bb63-539af91513ac@redhat.com>
Content-Language: en-US
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <b5a2f43e-790f-475c-bb63-539af91513ac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 59113f08fb7a744de72e5dd56bc95d41
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kcPU]                               

Hi Paolo,

On 16.07.2024 11:46, Paolo Abeni wrote:
> On 7/14/24 00:33, Aleksander Jan Bajkowski wrote:
>> diff --git a/drivers/net/ethernet/lantiq_etop.c 
>> b/drivers/net/ethernet/lantiq_etop.c
>> index 0b9982804370..196715d9ea43 100644
>> --- a/drivers/net/ethernet/lantiq_etop.c
>> +++ b/drivers/net/ethernet/lantiq_etop.c
>> @@ -478,11 +478,11 @@ ltq_etop_tx(struct sk_buff *skb, struct 
>> net_device *dev)
>>       struct ltq_etop_priv *priv = netdev_priv(dev);
>>       struct ltq_etop_chan *ch = &priv->ch[(queue << 1) | 1];
>>       struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
>> -    int len;
>>       unsigned long flags;
>>       u32 byte_offset;
>>   -    len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
>> +    if (skb_put_padto(skb, ETH_ZLEN))
>
> You may want to increment tx drop stats here.

Statistics are on my TODO list. The current version of this driver
does not support statistics, so I will add them then. I would first
prefer to fix all the bugs present in the current version of the driver
and then add new features.


>
> Thanks,
>
> Paolo
>
Best regards,
Aleksander



