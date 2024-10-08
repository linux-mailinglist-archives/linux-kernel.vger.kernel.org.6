Return-Path: <linux-kernel+bounces-355001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49949945CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3D5B258B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695991C3034;
	Tue,  8 Oct 2024 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ap1jF8aO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215B2CA8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384672; cv=none; b=Ux+7DkJrnmloxEV/KvOX28HVIT5gzxDRXzVouW7Zn4YEDCBeYrZ/6gYG/PvPFbBCCMlKNDAL+6Rs4CAvRakHwJUC5oBUS1L68T/zVXvWMHLq6cE0SVeZCcetK+eO2xcdLxDnfjm5m1G0sKE8G67+X1UaVgBR6N3+yQzWzdXuGxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384672; c=relaxed/simple;
	bh=K2eI7VLs1QwCKUwVCe/SF9rbDimJu9vF1Ntg7JdRiqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bc1NYp/wDjujqXOnVbbaZNqUo6ddQST3hc/laZOTheA3LX9W2SXPNqt6I/aXZ45jSyXZiJ+EGQLaj552daHouEPoTaZ0wjn2Hx5diiuHDugiRtvBzKpMFZ+sj6Mvf3VrOj8deY/BNxTKRmyGGjrbNsGn70SLLEhXPwRhrJ/PZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ap1jF8aO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728384670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/bllPgROt4dgWOVN55N8Je8Kc5/Fl4GKeADneLPLXw=;
	b=ap1jF8aO/dals0eKAKgRSwgOS69AGgoIwV8Qulma6FYA193yDDSTQsRCzHp2HgQoLHBCec
	mdZU4uPsUVAQgy8ehZvzHaWzwpx23+2z4LP/eEGiadWFE2votdwQ5CjohlpBuL0lrvVe8d
	VNLdO3GnPKKCq1wrZzqVpvW4lZ0q7m0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-jpR7iXghMx-0OSIo5EjvhQ-1; Tue, 08 Oct 2024 06:51:09 -0400
X-MC-Unique: jpR7iXghMx-0OSIo5EjvhQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d37157e4dso103240f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 03:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728384668; x=1728989468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/bllPgROt4dgWOVN55N8Je8Kc5/Fl4GKeADneLPLXw=;
        b=NBS+xMiHgLTuNU3EelUr4oKj+oWGSafUgDaOz96paYB0FIWIXJrrYv7WEJRsyNMEcJ
         qPKjn3xrNzhWPy4rN9kWRXu9Vn9O3yhc24MN0u19pZZKCvK5dmlaFXGK4s+JX4NZzwxV
         ofX5OqoD/qZnygmkc88Vfov8UxksjLCVB/Jgf7hYq51mkc84JhDqEJfei1Kyud6It6+x
         ks1f0ZkBEBNLet1hGuAyfYk4S6FJQB9c58M09ZebCYJYMYFE8Tn1ZIc2na9ktppsnwKT
         bEs0jVlFdoNHwwwWhFLXCvrASltP+4ZLpHcrONYbr8kXGB0UqQlzq0TgFOHn0uujV1ut
         DymQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUVC1DkF4N+JFAW7CpbMnusnwcjoCiOvRuaWstlIoX346BkI2VKMkesbneGEJGnH/9ogom6z3Su0oJwI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYLe0aMdT45Awvs3aErLXYJ6I+CWoJXpCjfIVhW7JfAFGQhKep
	mH/WdE4htslqC1S5QSJJJGkZSXGUDM+BpW0eE7aZPAY/37APFhjcpgM/YUdXIJ21giCcajgYn7N
	aq0piKi3jeSX5NNDpbaHAwcfA2lkTjz03gJ4jzReIK/4/j75kTSOTaFAlnVQQ1Q==
X-Received: by 2002:a5d:640d:0:b0:37d:3780:31d2 with SMTP id ffacd0b85a97d-37d3780328cmr145565f8f.15.1728384667756;
        Tue, 08 Oct 2024 03:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfrv2xL3WlwcAd589eP2yopR9qQBfam67gPSrfC3CswEBDuLW7+dQ3bgINNVveArek5PDpGw==
X-Received: by 2002:a5d:640d:0:b0:37d:3780:31d2 with SMTP id ffacd0b85a97d-37d3780328cmr145550f8f.15.1728384667255;
        Tue, 08 Oct 2024 03:51:07 -0700 (PDT)
Received: from [192.168.88.248] (146-241-82-174.dyn.eolo.it. [146.241.82.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a541sm7819474f8f.34.2024.10.08.03.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 03:51:06 -0700 (PDT)
Message-ID: <759f82f0-0498-466c-a4c2-a87a86e06315@redhat.com>
Date: Tue, 8 Oct 2024 12:51:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Optimize IPv6 path in ip_neigh_for_gw()
To: Breno Leitao <leitao@debian.org>, David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 rmikey@meta.com, kernel-team@meta.com, horms@kernel.org,
 "open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241004162720.66649-1-leitao@debian.org>
 <2234f445-848b-4edc-9d6d-9216af9f93a3@kernel.org>
 <20241004-straight-prompt-auk-ada09a@leitao>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241004-straight-prompt-auk-ada09a@leitao>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/24 19:37, Breno Leitao wrote:
> On Fri, Oct 04, 2024 at 11:01:29AM -0600, David Ahern wrote:
>> On 10/4/24 10:27 AM, Breno Leitao wrote:
>>> Branch annotation traces from approximately 200 IPv6-enabled hosts
>>> revealed that the 'likely' branch in ip_neigh_for_gw() was consistently
>>> mispredicted. Given the increasing prevalence of IPv6 in modern networks,
>>> this commit adjusts the function to favor the IPv6 path.
>>>
>>> Swap the order of the conditional statements and move the 'likely'
>>> annotation to the IPv6 case. This change aims to improve performance in
>>> IPv6-dominant environments by reducing branch mispredictions.
>>>
>>> This optimization aligns with the trend of IPv6 becoming the default IP
>>> version in many deployments, and should benefit modern network
>>> configurations.
>>>
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>> ---
>>>   include/net/route.h | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/net/route.h b/include/net/route.h
>>> index 1789f1e6640b..b90b7b1effb8 100644
>>> --- a/include/net/route.h
>>> +++ b/include/net/route.h
>>> @@ -389,11 +389,11 @@ static inline struct neighbour *ip_neigh_for_gw(struct rtable *rt,
>>>   	struct net_device *dev = rt->dst.dev;
>>>   	struct neighbour *neigh;
>>>   
>>> -	if (likely(rt->rt_gw_family == AF_INET)) {
>>> -		neigh = ip_neigh_gw4(dev, rt->rt_gw4);
>>> -	} else if (rt->rt_gw_family == AF_INET6) {
>>> +	if (likely(rt->rt_gw_family == AF_INET6)) {
>>>   		neigh = ip_neigh_gw6(dev, &rt->rt_gw6);
>>>   		*is_v6gw = true;
>>> +	} else if (rt->rt_gw_family == AF_INET) {
>>> +		neigh = ip_neigh_gw4(dev, rt->rt_gw4);
>>>   	} else {
>>>   		neigh = ip_neigh_gw4(dev, ip_hdr(skb)->daddr);
>>>   	}
>>
>> This is an IPv4 function allowing support for IPv6 addresses as a
>> nexthop. It is appropriate for IPv4 family checks to be first.
> 
> Right. In which case is this called on IPv6 only systems?
> 
> On my IPv6-only 200 systems, the annotated branch predictor is showing
> it is mispredicted 100% of the time.

perf probe -a ip_neigh_for_gw; perf record -e probe:ip_neigh_for_gw -ag; 
perf script

should give you an hint.

Cheers,

Paolo


