Return-Path: <linux-kernel+bounces-355432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F644995230
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE14A1F233EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FE11DFE11;
	Tue,  8 Oct 2024 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="mqbEA6uk"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B1617578
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398749; cv=none; b=G8jcedycxiWKYUGFwBxtfXlvPhVBZ4h7qtpWBAmspcKaPqYfQZ73tEDqeHzlKwiqh1ELq5Kv10D+GyTW/2HQRubrywmzViThHjIceo8CVcAZFKD5ClopPZI4ZJOChSqYusQa1FbPDSR6C55Ch9FAWaIq2Vhq78SHZQpN1q5u3DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398749; c=relaxed/simple;
	bh=OEPIoOSafXbHth2X0cZbo48ef5bM+/sWgUUWroovlLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrJDLz71qRNWLZw+ViiMlRXfZJuiLjaulNi7KemEU7ZOL4RWXzVtbwmb3KxsIY5wqBXbdwllbl69X1dxp2OlX07aYT0wa0QkAbIrZ6/CGZ/718PGFPT2FVAyCdnFcaX4Xs100JcAgcguDCePyTa4aBJTc2ftjb41H/7Vr8JLtno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=mqbEA6uk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d375ddfc0so261446f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728398746; x=1729003546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyA0o4MkgtBHEt4wv5eC/jzDocCl8Fg8KhFwA03Dsp8=;
        b=mqbEA6ukgwRZPTNdc2kPHjiM9uSGj1BnQSJjJ1K9EDj06ZEMlXAtW3i/zQYdOyaeZm
         5uPWd4ykWGei3+M78ZBoXtT4vGcaalVQz+BD6badABHDCF6fSUDailtzXq5WMJ3K/AJ/
         8DQVk2z9jlEt+axc3MMyCwvPXNlOqMwFtTgjmHneJWgKPByhOIAEsMxk6yTIsEgkz3LW
         F9FBxbfEq4hUkuiGCKpN+Tc+fby099a+oJJBFrC4AmNVMMlka3GF4rsCMeq/ozMtoRTy
         NxOz1G5aAWDt3IpCSbahgtNoptgssqDgzvzAdJWJ0/ppNP8a3fY4vYR1bs+m5+jl6rvs
         7gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398746; x=1729003546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyA0o4MkgtBHEt4wv5eC/jzDocCl8Fg8KhFwA03Dsp8=;
        b=ayliv19LMfiqcVHxBEN+b9uxkXs813Z9X6P55LGlZ37FA05Imhj2YerBrmre01hXmO
         ADRR6F7zeP7+UG/jT8qQkzdsUO8lj+nZ41wqwX7b41Fpepd/58BGdXEY0OFm+ZXq05WT
         w5FF3/FUotHXIZQR9yN6qRp5s1kzt8AownXswuVUF+jl+Nb/4pnSzi9qhhU+bPeXFziT
         yczzewfwXY5MBnnAtAKeoMSrLiVimglLGPEk5KuH6ICRBvIOAK+/6Tl/VBiNFOfjlApR
         K8zINrZZIqQy6tX1Mb2YdGRiozrtPOZIA8KK87QbrJw4vRP9SoOuEUdmFqJWx+VT4NcJ
         kXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIZsBFXstI82UMnaE1+R+GQQiURgXdA4ThfpNLD9lRUr+ckc3CgHPGxFWJsL7iw3MUFSWCTUaCXA0AyL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhpUwb3jEGsHyCmGXkod74cZFejSiZeBiwj6tGFJM8fMRxD62T
	mgK7b93pTdqqptFh8kwEUKiEmKHWp62o8DmrBx28f/ZuDoVgSA5UQNb2a+eX9gY=
X-Google-Smtp-Source: AGHT+IHnpqRbMJPQQ/KRJ6k8Ul3NfjlAwYMFqUBQC1j92wKGfsiXs0AaFgp4Y7hJhUm28QP/eeU1yQ==
X-Received: by 2002:a5d:5c88:0:b0:37d:370a:5248 with SMTP id ffacd0b85a97d-37d370a5384mr837280f8f.39.1728398746139;
        Tue, 08 Oct 2024 07:45:46 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1697024fsm8246403f8f.95.2024.10.08.07.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:45:45 -0700 (PDT)
Message-ID: <8f285237-757b-4637-a76d-a35f27e4e748@blackwall.org>
Date: Tue, 8 Oct 2024 17:45:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: use promisc arg instead of skb flags
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Amedeo Baragiola <ingamedeo@gmail.com>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241005014514.1541240-1-ingamedeo@gmail.com>
 <c06d9227-dcac-4131-9c2d-83dace086a5d@blackwall.org>
 <ZwVCC3DYWw0aiOcJ@calendula>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZwVCC3DYWw0aiOcJ@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/10/2024 17:30, Pablo Neira Ayuso wrote:
> Hi Nikolay,
> 
> On Sat, Oct 05, 2024 at 05:06:56PM +0300, Nikolay Aleksandrov wrote:
>> On 05/10/2024 04:44, Amedeo Baragiola wrote:
>>> Since commit 751de2012eaf ("netfilter: br_netfilter: skip conntrack input hook for promisc packets")
>>> a second argument (promisc) has been added to br_pass_frame_up which
>>> represents whether the interface is in promiscuous mode. However,
>>> internally - in one remaining case - br_pass_frame_up checks the device
>>> flags derived from skb instead of the argument being passed in.
>>> This one-line changes addresses this inconsistency.
>>>
>>> Signed-off-by: Amedeo Baragiola <ingamedeo@gmail.com>
>>> ---
>>>  net/bridge/br_input.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>>> index ceaa5a89b947..156c18f42fa3 100644
>>> --- a/net/bridge/br_input.c
>>> +++ b/net/bridge/br_input.c
>>> @@ -50,8 +50,7 @@ static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
>>>  	 * packet is allowed except in promisc mode when someone
>>>  	 * may be running packet capture.
>>>  	 */
>>> -	if (!(brdev->flags & IFF_PROMISC) &&
>>> -	    !br_allowed_egress(vg, skb)) {
>>> +	if (!promisc && !br_allowed_egress(vg, skb)) {
>>>  		kfree_skb(skb);
>>>  		return NET_RX_DROP;
>>>  	}
>>
>> This is subtle, but it does change behaviour when a BR_FDB_LOCAL dst
>> is found it will always drop the traffic after this patch (w/ promisc) if it
>> doesn't pass br_allowed_egress(). It would've been allowed before, but current
>> situation does make the patch promisc bit inconsistent, i.e. we get
>> there because of BR_FDB_LOCAL regardless of the promisc flag.
>>
>> Because we can have a BR_FDB_LOCAL dst and still pass up such skb because of
>> the flag instead of local_rcv (see br_br_handle_frame_finish()).
>>
>> CCing also Pablo for a second pair of eyes and as the original patch
>> author. :)
>>
>> Pablo WDYT?
>>
>> Just FYI we definitely want to see all traffic if promisc is set, so
>> this patch is a no-go.
> 
> promisc is always _false_ for BR_FDB_LOCAL dst:
> 
>         if (dst) {
>                 unsigned long now = jiffies;
> 
>                 if (test_bit(BR_FDB_LOCAL, &dst->flags))
>                         return br_pass_frame_up(skb, false);
> 
>                 ...
>         }
> 
>         if (local_rcv)
>                 return br_pass_frame_up(skb, promisc);
> 
>>> -	if (!(brdev->flags & IFF_PROMISC) &&
>>> -	    !br_allowed_egress(vg, skb)) {
>>> +	if (!promisc && !br_allowed_egress(vg, skb)) {
> 
> Then, this is not equivalent.
> 
> But, why is br_allowed_egress() skipped depending on brdev->flags & IFF_PROMISC?
> 
> I mean, how does this combination work?
> 
> BR_FDB_LOCAL dst AND (brdev->flags & IFF_PROMISC) AND BR_INPUT_SKB_CB(skb)->vlan_filtered

The bridge should see all packets come up if promisc flag is set, regardless if the
vlan exists or not, so br_allowed_egress() is skipped entirely. As I commented
separately the patch changes that behaviour and suddenly these packets
(BR_FDB_LOCAL fdb + promisc bit set on the bridge dev) won't be sent up to
the bridge. I think the current code should stay as-is, but wanted to get
your opinion if we can still hit the warning that was fixed because we can
still hit that code with a BR_FDB_LOCAL dst with promisc flag set and
the promisc flag will be == false in that case.







