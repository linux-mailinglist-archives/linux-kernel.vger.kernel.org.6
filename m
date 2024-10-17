Return-Path: <linux-kernel+bounces-369448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E799A1D70
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933781F25AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107571D54EF;
	Thu, 17 Oct 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="JSyi44Gm"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB471C2447
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154544; cv=none; b=bO3SmLGgSxt+xl6Pc59acNR/yBpfFgNE6RY2qQxBw2+KBf9h1zlCpQDeKkbrPJz/vGcywz323Mok4au57m6sPZvbjN+ic8Tnipu50K12zG+Xe7KvkSmMvYY7uUmGkQSv3RifwK6F869f4LlN1BJTh2jgtLu54JL8IwsM9aYF3vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154544; c=relaxed/simple;
	bh=imPn2OPqQjFc9uR/Yy7wp5dlQvYjTRKKCHXGDkaSesc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asHrZ0N/ayR4MX2U1oKFZ+IGBPrHxb3FsI2h0hPZxHxMkolFm53oFsklyVxwJinQs4zflQ9q0qzUEByDjtnMXTj0+MGLtOPVTV/OU/x+5b2aiM60GDWOnSyvMsEuZ++POWmKR8mv4NE9o/zApgQ3egcq4VoRTnBB8Oq69jJf8bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=JSyi44Gm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so408517f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1729154538; x=1729759338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mWiM0Qenq6snzqlNmhPji/4J58MYPGrBoRLNt739ca4=;
        b=JSyi44GmLja+vBAWU983gSGJwijYIj+UzlPCRQy5XIIZmEowc8Gk02IcLN+FcQZmjS
         ro8eVp4bzqxBIXCgsJdHe0/NNIfo2pyaIEKxi8pDe8KGBrJdiE9UVIaHIKRLRzgt90lO
         gLSLp/lvUpJER+rAeARBvkivZB/LMaUM/9O54W8Dn2wznkdN06snSx1PcGQIO/ZcqhBZ
         PsuvwbVbhf00tKCRporihlF2VIiNptzbOcnniFh+pc5KRyf0jJVfyW+P6a4Edb+QZOCn
         0U8Og1ixmBfN+Djy5tdozOvO5TQE8lhHEZ7HCyjlDkAuK3RkM6iwVQh7avzTdpXvY+gf
         6iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729154538; x=1729759338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWiM0Qenq6snzqlNmhPji/4J58MYPGrBoRLNt739ca4=;
        b=sIRlvTAAyVJoLYyWzCfcQpT6hdMUYChtCnrkC457T2u423O+liknbax5aRIxI2cH28
         CUxI84btH24Fg8TEzglbkZkPjql4wp3v6w9uWoUvc9iOQNPPoWuRcXQCfFK/WpxMW/yu
         8JBoCfgLSbQ5yOIZHU0X3QFmXD4YpUSo8I2uXjPPzatCFTWfHO3d2+MTjrnikcCs06/c
         bAnFzJ4f+TGhX8PYIRpa1V2++HCzaCucN1dz1eentpPp6vk609I7R0NmFf04mG/0lSJD
         2/2a3AkKhyXRDyw1DaI1JBGDjbst13MA6QLCRDlaE0+bUsFHfOweI2P3LF/h04Zfw79o
         SJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX1gXr5Ohc0q13QD+6P1V5wLiimXnCjdnv8XurXt8yBz2mIDCtC/X3hm6lDJdU77UUII2gDH6aQazeYog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qn6FluHuZ59m4XnreT+PVjLUmg21YylL8gpoNQbnPMs75D9E
	PgblEvv6LXNGWu4qpWQkdSmxmZKHqS+/8iMishJ1t4Xa5pnIMGeDXlKv61np+cw=
X-Google-Smtp-Source: AGHT+IEVgiUhH7ucVS53sBlraWGR7a3R6U5x91liQX4kmZ9vX7R+oJ19gK4jpj1dZi0K4wFZR1FHNQ==
X-Received: by 2002:a5d:47c2:0:b0:37d:37e4:f904 with SMTP id ffacd0b85a97d-37d5ffb9976mr14581893f8f.36.1729154538508;
        Thu, 17 Oct 2024 01:42:18 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm6534498f8f.25.2024.10.17.01.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 01:42:18 -0700 (PDT)
Message-ID: <2b710dbe-3a61-4ec7-8205-73139b8a4170@blackwall.org>
Date: Thu, 17 Oct 2024 11:42:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 3/3] Documentation: bonding: add XDP support
 explanation
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
 Jussi Maki <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241017020638.6905-1-liuhangbin@gmail.com>
 <20241017020638.6905-4-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241017020638.6905-4-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2024 05:06, Hangbin Liu wrote:
> Add document about which modes have native XDP support.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  Documentation/networking/bonding.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
> index e774b48de9f5..5c4a83005025 100644
> --- a/Documentation/networking/bonding.rst
> +++ b/Documentation/networking/bonding.rst
> @@ -2916,6 +2916,18 @@ from the bond (``ifenslave -d bond0 eth0``). The bonding driver will
>  then restore the MAC addresses that the slaves had before they were
>  enslaved.
>  
> +9.  What bonding modes support native XDP?
> +------------------------------------------
> +
> +Currently, only the following bonding modes support native XDP:

If there's a new version please consider dropping this sentence.
It just repeats the title above in a different way.

> +  * balance-rr (0)
> +  * active-backup (1)
> +  * balance-xor (2)
> +  * 802.3ad (4)
> +
> +Note that the vlan+srcmac hash policy does not support native XDP.
> +For other bonding modes, the XDP program must be loaded with generic mode.
> +
>  16. Resources and Links
>  =======================
>  

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


