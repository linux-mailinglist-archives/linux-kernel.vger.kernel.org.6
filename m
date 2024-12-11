Return-Path: <linux-kernel+bounces-441116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65259EC9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33E4282BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC1C1EC4ED;
	Wed, 11 Dec 2024 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="J/3p/nYM"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95911DFE26
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911168; cv=none; b=uFG2iQwUWsluceU8EQPMPit+7Q5+Bcma6NLRqKtFtiUGlafwbsx7qTxCSMfhA0RkedKBE9PHYN0u6Tfs+r9sbqs35JHdCDmQItwUlo25O6ygSshHFmbd3YngkKcGph9dxLfpD1PqLVowYp5Ud19c7pdBIYJaaEFrDR9PJcoPaRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911168; c=relaxed/simple;
	bh=ZlvieSYp+lFfKY9C2R6v2jjPfDG1Vm3fAT60s2bT+4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKu/o9J4+4y0MzcGqUaHND9GHBfhMlFU79pb6fTULjIa7TI652IYT/viycQy10WQ6ZM+66CZj3U5mWoO+vLAH3yQiNdJ3VAhilcPapKr85DLrzDI9jg632X8j+HnRMaFbaAN9cAJvb5njPuO14xC2DjO9D3IzgL1EgT0v83GtJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=J/3p/nYM; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862f32a33eso2175646f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733911163; x=1734515963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IoRCfObFE/0dbWPiqsJpx6TV+b8TV5eKkwKSHj1b0P4=;
        b=J/3p/nYMAUjjA50H6ie+/f54NJteXu6jYS/mZ7+SX+bbIYNBZq5MDCYQ1U1owNZVtC
         o4p1xPDaZynehJi487CELDGjtKh1Vu2UAuJqiROITCD9mGPdNXFU3jwlkK4ciG8AcRZN
         IRxoqX6XRkEEaaW8pgYB6xm5tCnDZb1aZ7YezzdZZ6LvS5D6zc2ffgCuzzPMQn5Sb25n
         3o+QWX7gRjJvgKU0eJHPK4XZIBqH5NFgpfMlhhYh4VmLdgPCpEKYurdNcdzOkgWMJgUV
         LvZJG469PQ7sZP3HJFwwrnciWWSEjDNDoZi5chR7OvGt/rWmTzJH3ng6SJ8AlaxnUJES
         JCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911163; x=1734515963;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoRCfObFE/0dbWPiqsJpx6TV+b8TV5eKkwKSHj1b0P4=;
        b=kn9QaEWJVYRRoBWOQXf0L5Svi5pGXzJcvCwMn76MjR2M5VF5qWDYotVzv2K3IVcyH0
         Z2e0phP9NBKZawnGT6D8j90iyFTOzLNMuWsNmqrFXF6nKVUMGh9lpsuO+hSuL2wXH5ww
         ieeqvHqbwYPw014nRkYLW3eDR6g2awKxP05fVXe8apHvYHwV1QXuaoZ8r6aOgJjbpLJ6
         l9+pFBF+922McTbfmiKrFjdk4X+WcChMND8aBY1+Fe6xez9EaeAXyGYXq+VEhJUd6J2G
         s6XGMklAeDVfxyV9b01tDxEYMBUlAmf7eww51MyNoticaRVg7sSkGNOc4B4UjW/1ciLb
         pXGw==
X-Forwarded-Encrypted: i=1; AJvYcCVuyG4CnN+Qhy9AYTUz+9B4geWd3kuk5mAJq0X+6jOvIMs7+OrtzpRZz7sPhL+KRLe2Q6ubo1KcneIAit0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQhUdSwK0oZB8v6pUNanqt5vTadxH8YF7d17IoQyU3zwo07R7R
	NzeDHsqA0N5T3rdq8hKmOCCzXoujNekxhwv0S18bsBO5FwRiLmnbUxBpVbbjAD0=
X-Gm-Gg: ASbGncvSx3z+l3DnW+cQ8ExNcxPid62hafNkm9fhj0Zr7xTENZf+MCjsPGJzbrBE7+7
	7RnAjoldHw0wpi4qzPkMSQnQu16Inv614TQuuzrm9rOcTE4q4Hs3ub3NAkvC3B5/EkUfo3odSzt
	CEHX0PGjoVUlq/4DbpalR/f9vXF5UTpMnjm+6rHyAnO0CSzE9Bn6l0b+ISdMda9P1OkzCRSEXox
	UjTm8uiqkdhXafLi3ziQHZEizXqsf9UvdUM5HIhjVyMsayGBmqluFsILWcfUWv5w8lmEwg37Hli
	rbGiyqz4/qx3OQ==
X-Google-Smtp-Source: AGHT+IEHjbE4dsJ5tzTwee49t2ek+qPtaomPRduw7MRABYyFDxJIbdcKf+79ZqnixjCxHDteXJKqUw==
X-Received: by 2002:a05:6000:1547:b0:385:f66c:a4b with SMTP id ffacd0b85a97d-3864cec5712mr1635635f8f.47.1733911163223;
        Wed, 11 Dec 2024 01:59:23 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:f6e8:f722:d96d:abb? ([2001:67c:2fbc:1:f6e8:f722:d96d:abb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251e12esm886242f8f.95.2024.12.11.01.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 01:59:22 -0800 (PST)
Message-ID: <7d986843-d184-4ed7-930f-d30ae2bc4923@openvpn.net>
Date: Wed, 11 Dec 2024 11:00:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 08/22] ovpn: implement basic RX path (UDP)
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
 <20241209-b4-ovpn-v14-8-ea243cf16417@openvpn.net>
 <20241210164417.GA6554@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20241210164417.GA6554@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/2024 17:44, Simon Horman wrote:
> On Mon, Dec 09, 2024 at 09:53:17AM +0100, Antonio Quartulli wrote:
>> Packets received over the socket are forwarded to the user device.
>>
>> Implementation is UDP only. TCP will be added by a later patch.
>>
>> Note: no decryption/decapsulation exists yet, packets are forwarded as
>> they arrive without much processing.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> 
> ...
> 
>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
>> index c0e7aa289ad3345fcd91e7c890f70961300c356f..975392fc39bc4c0107a07a53795afecd88d72c53 100644
>> --- a/drivers/net/ovpn/udp.c
>> +++ b/drivers/net/ovpn/udp.c
>> @@ -23,9 +23,83 @@
>>   #include "bind.h"
>>   #include "io.h"
>>   #include "peer.h"
>> +#include "proto.h"
>>   #include "socket.h"
>>   #include "udp.h"
>>   
>> +/**
>> + * ovpn_udp_encap_recv - Start processing a received UDP packet.
>> + * @sk: socket over which the packet was received
>> + * @skb: the received packet
>> + *
>> + * If the first byte of the payload is DATA_V2, the packet is further processed,
>> + * otherwise it is forwarded to the UDP stack for delivery to user space.
>> + *
>> + * Return:
>> + *  0 if skb was consumed or dropped
>> + * >0 if skb should be passed up to userspace as UDP (packet not consumed)
>> + * <0 if skb should be resubmitted as proto -N (packet not consumed)
>> + */
>> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>> +{
>> +	struct ovpn_priv *ovpn;
>> +	struct ovpn_peer *peer;
>> +	u32 peer_id;
>> +	u8 opcode;
>> +
>> +	ovpn = ovpn_from_udp_sock(sk);
>> +	if (unlikely(!ovpn)) {
>> +		net_err_ratelimited("%s: cannot obtain ovpn object from UDP socket\n",
>> +				    netdev_name(ovpn->dev));
> 
> Hi Antonio,
> 
> If we reach here then ovpn is NULL.
> But the like above dereferences it.
> 
> Flagged by Smatch.

Hi Simon,
Thanks for pointing this out. I will get this fixed and add smatch to my 
test battery.

Regards,

> 
>> +		goto drop_noovpn;
>> +	}
> 
> ...
> 

-- 
Antonio Quartulli
OpenVPN Inc.


