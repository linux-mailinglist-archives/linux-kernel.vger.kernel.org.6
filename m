Return-Path: <linux-kernel+bounces-517562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E1FA3827C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7743B6DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA52221A43D;
	Mon, 17 Feb 2025 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="QAClIXWv"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197FC2EF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793284; cv=none; b=qsjeUj4YOOAlxAdpyKwHHduFB7X1U5lXo1yG0r/+pp8a5pvLkHh9o5BPs0TtO2GMi0wicLY2jvt2eN279Nc3uf9YD+4fCUvtR9km6wuyT56C68DPGpBFG32IEUFJCr/Dq+3XZsp+cUB3nkBmiLaU4D2mYQYUOY0T/+LCdSAvQNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793284; c=relaxed/simple;
	bh=CNZT+25ePdrVoRVjO98eXznFTfieoFVKs8XN57JBj0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEzMJ1xOx2eesoJtaNaesrctc3aKrJnGHlL34oLSgUzA8saO6fj2NSLny5oye/gvjuBPySBL3K3COG59kZa+9iqrOujIr7MfRzx7zogNo3rtBOW0WlSFWzUlpByBEHohtz1Qbj295pfXbbroYGcswCWkyebdsS2ljW2x5N0+8n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=QAClIXWv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaec111762bso981464166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1739793280; x=1740398080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ODoUNIzhz8wbS9RlnqshxBZqUZSt9lnSSqoVHSSyPbo=;
        b=QAClIXWvVYY01roVLlcpb9TTJ86LJOq+KhJTDD2k/6ImP4iy7SZyLNBPkRBaigkkSr
         U4utWB2Diy9ewkOktgrDjUpHf7j5YLSavn1NquBdjaPHgtYiJpqv+49QQXP5qMg8mApU
         9eZjKzhr5JZgxON733sTMGNZcikGleNrP4kmjg4LNcV2zhyJGBoUBXGdkBIoR84WEzZQ
         /60jp5D5QEoyCsUrnimWYUS7fsA+ASbotSf+9yXvll5ehzTDP3kQhedo8r7DosQN5k0G
         z7m03Xdlv1ArqJvXwy9IRLIi4WV7wmi31FfXN1RnqaECNz25G5YjArUVRyK5bVZEri9B
         Dp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739793280; x=1740398080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODoUNIzhz8wbS9RlnqshxBZqUZSt9lnSSqoVHSSyPbo=;
        b=JSwdE2bUxIOxTxBvd429v5IxZ2uveGe0zfkRIguf841Od5vWQ0KuTkmZDMZkPlGUBq
         Tpa66hlA7a3dWLXa6O7Xh3R2bhvLGESNJWYQ2s52LnrXPHBdf2Dc+R/JwDpwrjrp8Fxo
         nqKC0B9LvNvycSWZgnSlwE4o0GajPqQ6r0L5NVFhcOVsu5yl05fhZ2Th6fv5Q4n0lXHa
         e0N9y6N71dAKW0xVmmzXNtIneEHldYOMLUI2luSSc6gE34IB5zRQ66V5X2AYJFgoSe5/
         qPsowwYpGKm0JmX+g3SCocICgUOPTBF2FylFHnXDRuiWQFp67EL42SfQoBWLFQMfmUxx
         oBKg==
X-Forwarded-Encrypted: i=1; AJvYcCWUvCw8lDOwef26bMc1U7FA90CKhvVirPY5NDMiYBo9YoS/AGn3f01ZcWzDiwg71pO5pQzWyU1X7m92A+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/cqcvdPlvqQxt/F5+s01M76gOhCNq7zwHyAftFvE7QzChIh/P
	WV+9mwsBi4VZ/9iGqxJasRP9xlgPuhjTAp3zDCKxzhpB88oTLD9jP6BOf3v5rv4=
X-Gm-Gg: ASbGnctIjPQtu4F41WtoosdtsgU6H96p/Ozv9P7SRaD2yR96Xg5YacHTBkxrz8CObXj
	QZWHaijkhVM5hSs1ekurJwFhndT88YlWGGIRT7mWcTxmk4Pan6ZjpN+uNfY5/poU+mhyLnvVXk5
	4EV/VGACm+varB2bD1n1/jxsGrl7poSN5zIdOaSli4kvue6AyxF9oQ01gg4cutEnn9DFx1hICB2
	+dCp5KrSWeZuU7qzSVQxeODAAWnP26JI9uPoV7TvhRWtOwCXhSaA82IM/hd3unXqPvh2uzdDVQf
	/NKc4VOd2k+UaeO8f6WQxIq1KfKXGmmPIiqGwe12juBThck=
X-Google-Smtp-Source: AGHT+IH5LYB6p/HXb8BGQs5I7Qwcm3npFyWcKGxO91RFb9WWl38/bVbziniG96GtqAkw2iimohL1RQ==
X-Received: by 2002:a17:907:72c8:b0:ab7:be66:792f with SMTP id a640c23a62f3a-abb7112e046mr1020984366b.49.1739793279612;
        Mon, 17 Feb 2025 03:54:39 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba9bd6e22sm71743666b.121.2025.02.17.03.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 03:54:39 -0800 (PST)
Message-ID: <37bf04ee-954e-461f-9e37-210a8c5a790a@blackwall.org>
Date: Mon, 17 Feb 2025 13:54:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: locally receive all multicast packets if
 IFF_ALLMULTI is set
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250217112621.66916-1-nbd@nbd.name>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250217112621.66916-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 13:26, Felix Fietkau wrote:
> If multicast snooping is enabled, multicast packets may not always end up on
> the local bridge interface, if the host is not a member of the multicast
> group. Similar to how IFF_PROMISC allows all packets to be received locally,
> let IFF_ALLMULTI allow all multicast packets to be received.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/bridge/br_input.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 232133a0fd21..7fa2da6985b5 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -155,6 +155,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  			pkt_type = BR_PKT_MULTICAST;
>  			if (br_multicast_rcv(&brmctx, &pmctx, vlan, skb, vid))
>  				goto drop;
> +			if (br->dev->flags & IFF_ALLMULTI)
> +				local_rcv = true;
>  		}
>  	}
>  

This doesn't look like a bug fix, IMO it should be for net-next.

Also you might miss a mcast stat increase, see the multicast code
below, the only case that this would cover is the missing "else"
branch of:
                       if ((mdst && mdst->host_joined) ||
                            br_multicast_is_router(brmctx, skb)) {
                                local_rcv = true;
                                DEV_STATS_INC(br->dev, multicast);
                        }

So I'd suggest to augment the condition and include this ALLMULTI check there,
maybe with a comment to mention that all other cases are covered by the current
code so people are not surprised.

By the way what is the motivation for supporting this flag? I mean you can
make the bridge mcast router and it will receive all mcast anyway.

Thanks,
 Nik


