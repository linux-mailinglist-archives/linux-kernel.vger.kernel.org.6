Return-Path: <linux-kernel+bounces-417492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739B79D54B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE508B211D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9851D79BE;
	Thu, 21 Nov 2024 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Y5fSMwl+"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16B1581F3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224438; cv=none; b=mDQ6rpVOGXPSSdage0R46AHdQ1vyDQiRN0jYOvc/7QzDlb4mTgjMMMiHMp8rNsj25xlsDo67HJpaARZ3A+I5JEsu7Up6PSRJGvWmSdowYe93liE0MUvwv3OMVpBPc6FKpFeXfCfFmODUTRkiRBZ45R4kE86ssE59eIPEqim+SRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224438; c=relaxed/simple;
	bh=2eWElEfrTCGKD5F3MaiAr7R22Qq5qHMY2jig2yeRMgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlveyWol0Ddpssxk2WQlx7wLXZbCQCbNqjTAHWao3LdHPldz2vxY/4rRHNpqTJl8czT2c2Z2DbYMUi0SA0BCfN3iZ+DQW36gG1fom0zAsCtS0Sg58dMs+ISkwt91LUZayhjOxatpljfMmcWD/dxWVicpJkqvLdSI4UBsEfz3N0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Y5fSMwl+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso234792266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732224434; x=1732829234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3N3cNvZxYGfFi8BC4QP/enz5CUoEew1JUx4+OK38v00=;
        b=Y5fSMwl+HFtdMohoXqWxPaDSVUyAwgeQORjlCful081VFH+bwxCr7WlvasdKp/iRjl
         j+6ctaDIyHup0NgYxj7NtqOHRjbIKi7qrQNAjemIzdOZCKAwg+b4BKyrxP8adZLGwWGH
         v31XzMVuMUMsfva9QVVuXV3Ra9oX6UXGY6CQZN9Mj0gkKL7S+HqtLJBrlLXs1tFNUPgZ
         akFbolZFJY/LXvrR7Nt6h9SQJ5Dj74z+OguSbQwFe8bSUF6Jiwln34Yo4gCSRTLSfvbP
         SU/fZFkWpxUJ9zCL+mub0+vbis0yvo1wfdl0at7Msxdvd7kmMy6pHqgqs5wsSU5LOmyQ
         tVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732224434; x=1732829234;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N3cNvZxYGfFi8BC4QP/enz5CUoEew1JUx4+OK38v00=;
        b=w0ZKy0/ZFHocD/Ke03lQnC4qaD7DSjhcQLXaPZBk/wSFNiqM81mEISp7HpEGeudTJL
         qlgsN7uf5h9SyZ6nKNX90Ypw80rm3IxN1FlVqsSIJrlrAyAlY3JrcuXcYGrQ05sASNiH
         dLY4L2w5rYk8dvHEoz2cyUuoe7JojK8qnFRIf5b8evdIF2ozMkYuxJiwjFwS7TNtA9ZP
         8zwWpuScjckH+nXf8/rRTBheMN7Zx7Wk1VyVDjtTP3GMUsrZ1FioIOpvOdxDrH/1LVKd
         ON5MKoxXz82vRuwrTqeeI6VB8zw/8ly16x8juemLW7soG1xoExcyEkbajQoP/iPIf5Ob
         0rhw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Udf97BKCMV5AkkrblAA77og0XVTYUd0i7A7h1eN9ob2LSmTXDWj7n6RjpcJ3lztnMP72Xq0dqt1ZZzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx91N00S9oQtfKjNZp81I0q9BEFtH4/vVkPiJkKdqxNAIKv1IuV
	kyjCEdjysp9DDhDIXxps/yr5QouKCKDgAw68j/THe5JQa5Y24+fxV0s5bbw164s=
X-Gm-Gg: ASbGncumevfhhM69HN5q/9+2iYi46K3Vp5YOxgNuzY8wPn+WUVjs4t7U7jfFbznEsnl
	QPfT8nZmx9ljBMJG5U8BcIzwpVoRUmzFQvWkSIaxlOjSi1RHgga5uGXh+Jxa7sEXDwviVOQyqkU
	Ito7LIAU3jeEdhRIWvR7ox7+hHQUK3BlOad9NCW0OTv4O/ayAlKoihKiWuHg1/84OAPKVc1FB6b
	Bzn/+MmSs31Vpy9h9q8j+TF2De4hRfmDXxRJdcagNr6ZO9KFam01yGzR/av6JWNZUfrImupvUOT
	qpYa3s1HPA==
X-Google-Smtp-Source: AGHT+IEx7KHV4aEd+7KlGkFdOZ3fATEt7JOWlLRnEZ/tZra37ssVJi3nJI6HaH4c2630vOJ5vV/9JA==
X-Received: by 2002:a17:907:7706:b0:a99:fb75:3ed7 with SMTP id a640c23a62f3a-aa5099bded0mr60882266b.17.1732224434612;
        Thu, 21 Nov 2024 13:27:14 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:f55:fe70:5486:7392? ([2001:67c:2fbc:1:f55:fe70:5486:7392])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2eff9asm16057066b.43.2024.11.21.13.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 13:27:14 -0800 (PST)
Message-ID: <2bb5beb5-3d24-4725-92bd-8a7bf16e37b9@openvpn.net>
Date: Thu, 21 Nov 2024 22:27:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 06/23] ovpn: introduce the ovpn_peer object
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net> <Zz3OhFzo2ve6cKAr@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zz3OhFzo2ve6cKAr@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/11/2024 12:56, Sabrina Dubroca wrote:
> 2024-10-29, 11:47:19 +0100, Antonio Quartulli wrote:
>> +/**
>> + * struct ovpn_peer - the main remote peer object
>> + * @ovpn: main openvpn instance this peer belongs to
>> + * @id: unique identifier
>> + * @vpn_addrs: IP addresses assigned over the tunnel
>> + * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
>> + * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
>> + * @dst_cache: cache for dst_entry used to send to peer
>> + * @bind: remote peer binding
>> + * @halt: true if ovpn_peer_mark_delete was called
> 
> nit: It's initialized to false in ovpn_peer_new, but then never set to
> true nor read. Drop it?

argh. leftover from some older version. Thanks

> 
>> + * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
>> + * @lock: protects binding to peer (bind)
> 
> nit: as well as the keepalive values that are introduced later?
> (I guess the comment should be fixed up in patch 15 when the keepalive
> mechanism is added)

ACK

> 

-- 
Antonio Quartulli
OpenVPN Inc.


