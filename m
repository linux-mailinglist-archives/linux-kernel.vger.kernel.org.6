Return-Path: <linux-kernel+bounces-351883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6D3991734
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D57282BFE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5DA153838;
	Sat,  5 Oct 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="XMXsH7UB"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64715AF6
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728137222; cv=none; b=W1k7dc7RmmjV5doDBsCojJ02NixMwGDBlgtEYLgUV03AGNmXS/8kFA/6EJzPPgWAMyGqxDqEvh9Eh0+nZh260Lnwj3rvJYt+EPHuj6KTsGK3nj16678VwyEsdjr+Guz6Z9gqb51FFRmVV5avD+DmGIgXbgiCPOcbrwh/DybHEmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728137222; c=relaxed/simple;
	bh=w7hv67Bv4jGJL1OIuMDm5zDOxYIxf51jzM1/fXgu7r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWYeycgMfBbxGb2ODsEdZfmnXUB/JCWcsc4zKJhU+cxOUPIGeQJEqp9vplLo32UHhzUEYq1c9xFof2voQ3/4/rZASiVEyZTCA1RDfhB1EPWGQzJBpt3eOzEZJ2Vjx9g+Ev5DnwFfySSBTYK96Ml3i41UK6B493GYZiCCjiyfjfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=XMXsH7UB; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37cd831ab06so1755685f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 07:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728137218; x=1728742018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73RXbNvNBQEszJaut+1wcFfhljNaK/Kf2dgm13KEtRw=;
        b=XMXsH7UByCws1GjGhVTsm4xVSbrtuARNZNX+4XQnnWbHxxcjXhgITx3qX6+FltINkU
         jj8q1x2enmHTZXVkTEnjXQjAol43OjXUvWWU1zCb8urywlqWljA6JS1k4U50K5I4aVv5
         DvbRNwvsZ5Kmyocb2iktmfGem6EhNYa93ARFmPSXQG6z56BxELrMTGBjgtpoxyUNzi6o
         +P2Y0Hd/pxWM3L+3kVxYy8MozCnFXS4Z1KcZPTpu+XOY63IUWuF2WNRPi4WEJAXPAJE2
         TNATzig3ocfvOGFVpsVfwZEKxcrq/Rdkz2djJmFQRtukaL2kz772z/EH898InaB5WA3J
         ZlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728137218; x=1728742018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73RXbNvNBQEszJaut+1wcFfhljNaK/Kf2dgm13KEtRw=;
        b=N6/rdrz9i/+sQfZbUwwgUqbx9zi7oB1h73Nj8GAKc1wKBTrSqdK30q9oTznHFsutIg
         ygHbX9CQLHQpWHCfEfQjxTw8da0Uw3haRvHm+jK78Ml7fchihXxWnSJtFf8vCYbbEAKg
         xakpTuK9Oxd2TaHEYWpGAFU4oHyjoA6XlIt0yDZihVeLICSqt5wJ6ujyw3U5KRIYm0s5
         QII74ab4C2hoog0lLvXTCJGFmr+yZgahsyScxBO9u+rifI9VZ6mx+ImoykZdq3h4czPZ
         zAJoE24GQwSR64q2AvQ5A2LJE3Lkya3mbyOOppLglHNAkdp+vTfCqBWKeIFfkAXMq6KE
         C3ew==
X-Forwarded-Encrypted: i=1; AJvYcCVHv02jaWxID2LbKzQRMR+6eOOxIbajHUoI7+h4aiFJ59FcM1J9AMkG7tamF7n1mQApRFBnfYQK1YYrm0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXO5SdeGUbs7DzAYRHqgIIoymWAeE05XDRXWuE/40CLYELdDjk
	tMjw2COuX067mkcjV6UGKwUH9aNlOiO17Uim6BiiNp4Y78TZGr0fYmUZkMWwvWo=
X-Google-Smtp-Source: AGHT+IEop7QV/LQ0/ci7yuPRtnBcGOvevIn7tuDVlQ8/zdMwhtTaLfoE32mNc8E+fIIZYTUwqHvxHg==
X-Received: by 2002:a5d:510e:0:b0:374:af19:7992 with SMTP id ffacd0b85a97d-37d0e6f361bmr3281936f8f.7.1728137217667;
        Sat, 05 Oct 2024 07:06:57 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920cc7sm1838947f8f.61.2024.10.05.07.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 07:06:57 -0700 (PDT)
Message-ID: <c06d9227-dcac-4131-9c2d-83dace086a5d@blackwall.org>
Date: Sat, 5 Oct 2024 17:06:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: use promisc arg instead of skb flags
To: Amedeo Baragiola <ingamedeo@gmail.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>
References: <20241005014514.1541240-1-ingamedeo@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241005014514.1541240-1-ingamedeo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/10/2024 04:44, Amedeo Baragiola wrote:
> Since commit 751de2012eaf ("netfilter: br_netfilter: skip conntrack input hook for promisc packets")
> a second argument (promisc) has been added to br_pass_frame_up which
> represents whether the interface is in promiscuous mode. However,
> internally - in one remaining case - br_pass_frame_up checks the device
> flags derived from skb instead of the argument being passed in.
> This one-line changes addresses this inconsistency.
> 
> Signed-off-by: Amedeo Baragiola <ingamedeo@gmail.com>
> ---
>  net/bridge/br_input.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index ceaa5a89b947..156c18f42fa3 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -50,8 +50,7 @@ static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
>  	 * packet is allowed except in promisc mode when someone
>  	 * may be running packet capture.
>  	 */
> -	if (!(brdev->flags & IFF_PROMISC) &&
> -	    !br_allowed_egress(vg, skb)) {
> +	if (!promisc && !br_allowed_egress(vg, skb)) {
>  		kfree_skb(skb);
>  		return NET_RX_DROP;
>  	}

This is subtle, but it does change behaviour when a BR_FDB_LOCAL dst
is found it will always drop the traffic after this patch (w/ promisc) if it
doesn't pass br_allowed_egress(). It would've been allowed before, but current
situation does make the patch promisc bit inconsistent, i.e. we get
there because of BR_FDB_LOCAL regardless of the promisc flag. 

Because we can have a BR_FDB_LOCAL dst and still pass up such skb because of
the flag instead of local_rcv (see br_br_handle_frame_finish()).

CCing also Pablo for a second pair of eyes and as the original patch
author. :)

Pablo WDYT?

Just FYI we definitely want to see all traffic if promisc is set, so
this patch is a no-go.

Cheers,
 Nik

