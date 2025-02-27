Return-Path: <linux-kernel+bounces-536256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 418B9A47D55
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A8B3A92E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3141722F176;
	Thu, 27 Feb 2025 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3eS6c5X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D622C32D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658422; cv=none; b=Qgrrmmws3sa8+khHIzQSpaPAU0v9dQi/TKOasmd9PUK9ne+bGYptqc54CXuwpxBC613HTHktJTRxxHTHtLNeIPx3SbpsCcTAR8PUerPvzJRQGcqeY7arbD9sB8bT3AXe/QuaoVsMfCD3WDNzoOl/kyNCXeSY8WjbiuVPr7xUxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658422; c=relaxed/simple;
	bh=zu5zZyBnN3ry9IQ+Jn6HYG0wRqc9j641WfB32TvRN88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PI0Mbfk+CK1OgqJSzI0zCCDyPl6KF7C/IIRf54HO/fQn5OtWIqiGxhiyg03JsOzyHkpWQyd/OYwvOr382HaIKj2CXwlB1bAUx+LWlQpggH5jyGMhal+/4h+45Xxx1W+Ujx6xFFcEFa3jQl1PwxbNikYqW7P4b4wZS9iP54xZxjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I3eS6c5X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740658419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MXJ/yo/wY9z4Kh8ojEu/aUMRrlN5xvGKyO57GV+hi4=;
	b=I3eS6c5Xm0QFqAdAQDHsHtH/te8I8jrEctjXIl1sSWTIqmtWsHn+mmp+ZJ8bEXuYbKCVAP
	2Z8/HnRKZByYbZBoFmvY8+bdkRU9hqLA3ctWmDm1bCe4b8IQah6erOZDkMlRjZjsPg/Q0+
	y+EMgXX+8aDIAlZrgx88j6d8xAGi6Sg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-UKJymi2oN7egH7kiwnq5WQ-1; Thu, 27 Feb 2025 07:13:38 -0500
X-MC-Unique: UKJymi2oN7egH7kiwnq5WQ-1
X-Mimecast-MFC-AGG-ID: UKJymi2oN7egH7kiwnq5WQ_1740658417
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390ddebcbd1so497504f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658417; x=1741263217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+MXJ/yo/wY9z4Kh8ojEu/aUMRrlN5xvGKyO57GV+hi4=;
        b=f/jlOksddryUuVQTXq0TRFFwU9K2sioNaa8gzoExXKjWq2xO0vmdq6QF1ztb7hRPBA
         vubMhtYmEC9JLRq9gdxf6YG43/trPUZmdDk/6QIG4IQnZ4FlpanIFYOPD6yMDFSw5JLV
         hhRZCYqJ3C0BUvD/BIE3x3HR9Hs8JOm3cVkcwSb8xth67F9pXSwdLPhuVy3NAtFC+2gE
         HGbfZk8CStrXjY/jttF7saXaHL2JEMZO5Q0ueK0JaIWdXYNdfYvYpOjHrraiBiDJ3EaJ
         qT+lyWpvftUKQ9lsxbPllHIlccArQsEsw88q08AMUBpdcKzLPX+wTgPfzHFBXJGgUc8I
         a56A==
X-Forwarded-Encrypted: i=1; AJvYcCUAWe0vyev1Deo5UD9WOApdGvS6NTyT9XIlQN7Lqaro3J9xtzgaePXh9lo5lk4vpFaWAmmZVgaQ1XztmbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwefV6HIDZMk4fqaXOaA9tfLx5op+QIup8/siVW8+TLdK8Yjt0y
	9RCcdtB8hoQzHGg+XH2fCJg4iRVbt4hr9ZVMPkURROlkw+YVCn4A+SGqOCsEqWmES+BV1/FAFUN
	COiMUPnPThABv166Jp5QKE+SgBWgqPuaJUbzvZ1IYoiAyzOZaeJl31iHb+3/Mvw==
X-Gm-Gg: ASbGncuIV9IuOo3F5i1Ctx7BtshC4oT1ONEFqX93Ggl9rnoLNUAhucBdssKIWFWOFge
	luybU1Pcsh4UJ+tWfxxyCAnHd6UYEkFdQ2aTjq5cqkjSsfEmsAEINzw8ACzg176lqi8kckFjqNg
	9cjsUKL6N+Hk6Xg8KSZ8Mqpmwu88t8dsvnfyhO5aYXFgTOqvRm4qgUo6H4h1st0a9ek2v4jlVd9
	fR4hXxw5FMTFGKlBr50SpKCWBg6ZwQzo5aC7xx/h94i49WDxqtOY1lLUn/YaJal7IHOA+3gyTDs
	jBVW0NtjuTx7C2P0TzPBUzETrcTHdbrrngv23UyIt7XDFA==
X-Received: by 2002:a05:6000:1a88:b0:390:e7d7:9669 with SMTP id ffacd0b85a97d-390e7d7991emr1408591f8f.21.1740658416782;
        Thu, 27 Feb 2025 04:13:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGl4hPeu0HygbnTFHg+/9ohJ4IMxJNzWuCdzZ5zOQx0HggSdzuuB4mlslYm75dEMyalE9ssA==
X-Received: by 2002:a05:6000:1a88:b0:390:e7d7:9669 with SMTP id ffacd0b85a97d-390e7d7991emr1408572f8f.21.1740658416421;
        Thu, 27 Feb 2025 04:13:36 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d1dsm1865163f8f.56.2025.02.27.04.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 04:13:35 -0800 (PST)
Message-ID: <d33b1587-f401-4400-9205-01e45d0f41a8@redhat.com>
Date: Thu, 27 Feb 2025 13:13:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: 802: enforce underlying device type for GARP
 and MRP
To: Oscar Maes <oscmaes92@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, viro@zeniv.linux.org.uk, jiri@resnulli.us,
 linux-kernel@vger.kernel.org, security@kernel.org, stable@kernel.org,
 idosch@idosch.org,
 syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
References: <20250225141709.5961-1-oscmaes92@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250225141709.5961-1-oscmaes92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 3:17 PM, Oscar Maes wrote:
> When creating a VLAN device, we initialize GARP (garp_init_applicant)
> and MRP (mrp_init_applicant) for the underlying device.
> 
> As part of the initialization process, we add the multicast address of
> each applicant to the underlying device, by calling dev_mc_add.
> 
> __dev_mc_add uses dev->addr_len to determine the length of the new
> multicast address.
> 
> This causes an out-of-bounds read if dev->addr_len is greater than 6,
> since the multicast addresses provided by GARP and MRP are only 6 bytes
> long.
> 
> This behaviour can be reproduced using the following commands:
> 
> ip tunnel add gretest mode ip6gre local ::1 remote ::2 dev lo
> ip l set up dev gretest
> ip link add link gretest name vlantest type vlan id 100
> 
> Then, the following command will display the address of garp_pdu_rcv:
> 
> ip maddr show | grep 01:80:c2:00:00:21
> 
> Fix this by enforcing the type of the underlying device during GARP
> and MRP initialization.
> 
> Fixes: 22bedad3ce11 ("net: convert multicast list to list_head")
> Reported-by: syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
> Closes: https://lore.kernel.org/netdev/000000000000ca9a81061a01ec20@google.com/
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> ---
>  net/802/garp.c | 5 +++++
>  net/802/mrp.c  | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/net/802/garp.c b/net/802/garp.c
> index 27f0ab146..32ab7df0e 100644
> --- a/net/802/garp.c
> +++ b/net/802/garp.c
> @@ -9,6 +9,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
> +#include <linux/if_arp.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/llc.h>
>  #include <linux/slab.h>
> @@ -574,6 +575,10 @@ int garp_init_applicant(struct net_device *dev, struct garp_application *appl)
>  
>  	ASSERT_RTNL();
>  
> +	err = -EINVAL;
> +	if (dev->type != ARPHRD_ETHER)
> +		goto err1;

I agree with Ido's comment on v1, I think this belongs to
vlan_check_real_dev(). The fact that you have to write the same check
multiple times is a IMHO good argument against placing the check here.

Please move the check in vlan_check_real_dev().

Thanks,

Paolo


