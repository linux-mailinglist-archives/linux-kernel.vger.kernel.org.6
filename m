Return-Path: <linux-kernel+bounces-333399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD89997C800
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD1BB258ED
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F32199EBB;
	Thu, 19 Sep 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="mZsO4AGi"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B709D3C0C
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742008; cv=none; b=PywUVOHqQOIgy26JYwodU7SGm/wUBPYhTQBtjl0P5GV0IgwGje8Bu230TEHWzND4och2ma2VkiCzP4MtATpbQYQ/k7zjj/ixK5KsEc+XiJSoxF1C7Z48PtBlj37haqBDUKF6BeckNuGmX4oGSYh9y1LuAIhvT1Zi3KSNlaM3TwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742008; c=relaxed/simple;
	bh=V1YPdfqmajIEnriwvuftpiMyY/DSrs4cUIhXE5P3RNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXtFMXhW7L3sQ0+XhCHWzsssh58zfOTNlZpbV7nEhnyR+BFngKWBHYAZMZKyBv/i73RNFG2SDEir8PT5FzSx7CZPssz2fFrfletgrNiZ/vpajbzTW/BUTg/xq8mT6tzGY+UAI4VgPfZll8zJHoialqcXqt1FALEGx6ERe1mwK/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=mZsO4AGi; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c42384c517so945175a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1726742005; x=1727346805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ElPw2rkqJxy3GrSWwEzcQxJQL1TZQOW7P03usn2dqU=;
        b=mZsO4AGinb40OfWru/ps8zvUfk+S+Sv18uHs3qO9gXqbkfZo6jyvxT/Re/ywXFoZxH
         mOU4itu+K9yI6guIlP54rl5nsTVEjlTf+PBJsy+Pp0775yFdo/YdmDaEE6FEYJp0zzGb
         L4tjX/8QrNrhZB833AZSgYQaJ5r3jqpMyU8m/gXYyl0ovs0orSbAfqDCyGr2m5qZMWp6
         bD5uQGmmXt3cjmloTyigVPG6KgjLmdAV4LpG/8tr7cGBE6Jv4bKhG+pj3wCKFXKuodIV
         otjD0mgd+IxlBI12HGph2/UyYiYjhPodkuup+KdgTKf25eP5W3QJwWX/1o9at5TXgoZ7
         hwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726742005; x=1727346805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ElPw2rkqJxy3GrSWwEzcQxJQL1TZQOW7P03usn2dqU=;
        b=wwr0qXrHKtEF6LzbliXpTQ38LVmEHXQPsHXkFyWUrbEJ4rII7/TIzu+e+Io+cqbFb4
         A31KLs52N/iW87OHRpbg4FzZBxiPc9skIo6MGWZ6N/bwwdv1+uCz+lMvO56+D0fXYES2
         Lm0Z3EzOF6k6uzkfzp0MmB9fF/Stv+tjWacKa5d988bU995NDPSIKi4g83pYLh/CE6Dk
         8YsqZ5v8TqtuoJQekozu74fO0W3wDxVN9paRcPqs/ysiJQ8ZVQpaBdgjW7gufBw00Mmv
         xvjTAxRnPwgglR3od8lcy5yTOVhuZ0Zq2bOYrknISaZ8Be786r05JeAJazLikLqzijSY
         7OrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4sxQK+AFpeASy1js/G5gkQHipdml3Q5hp4+SuHafe8zu2hjtLtKQY9ijJ2XRhr1L4IcgYxbgYbrmnVcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ3Xxw6MITHmpCRVUqPBLAFYTBMZaIklioGT14PzkjYYWkemfK
	my9yQLaVH89aFacgeo0CzgoAvFCOwjmABpFvahj/MRL80BZe4qkE+aDb8+AlPyo=
X-Google-Smtp-Source: AGHT+IH5FaHwIy/HpPwgYVmO7IWOIFZ4wz7dkZfK70jhdOMRpGV6GaHoSjwhSDN9QfGUWFQLWu83lA==
X-Received: by 2002:a17:907:efde:b0:a8a:8d81:97a8 with SMTP id a640c23a62f3a-a902941ff90mr2191026166b.1.1726742004941;
        Thu, 19 Sep 2024 03:33:24 -0700 (PDT)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e5696sm710812966b.172.2024.09.19.03.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 03:33:24 -0700 (PDT)
Message-ID: <934bf1f6-3f1c-4de4-be91-ba1913d1cb0e@blackwall.org>
Date: Thu, 19 Sep 2024 13:33:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net: bridge: drop packets with a local
 source
To: 20240911125820.471469-1-tmartitz-oss@avm.de,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Nixdorf <jnixdorf-oss@avm.de>,
 Thomas Martitz <tmartitz-oss@avm.de>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240919085803.105430-1-tmartitz-oss@avm.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240919085803.105430-1-tmartitz-oss@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/09/2024 11:58, Thomas Martitz wrote:
> Currently, there is only a warning if a packet enters the bridge
> that has the bridge's or one port's MAC address as source.
> 
> Clearly this indicates a network loop (or even spoofing) so we
> generally do not want to process the packet. Therefore, move the check
> already done for 802.1x scenarios up and do it unconditionally.
> 
> For example, a common scenario we see in the field:
> In a accidental network loop scenario, if an IGMP join
> loops back to us, it would cause mdb entries to stay indefinitely
> even if there's no actual join from the outside. Therefore
> this change can effectively prevent multicast storms, at least
> for simple loops.
> 
> Signed-off-by: Thomas Martitz <tmartitz-oss@avm.de>
> ---
>   net/bridge/br_fdb.c   |  4 +---
>   net/bridge/br_input.c | 17 ++++++++++-------
>   2 files changed, 11 insertions(+), 10 deletions(-)
> 

Absolutely not, I'm sorry but we're not all going to take a performance hit
of an additional lookup because you want to filter src address. You can filter
it in many ways that won't affect others and don't require kernel changes
(ebpf, netfilter etc). To a lesser extent there is also the issue where we might
break some (admittedly weird) setup.

Cheers,
  Nik


