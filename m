Return-Path: <linux-kernel+bounces-360585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7220999CED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514BE1F20F44
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ECF209676;
	Fri, 11 Oct 2024 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="UHvyBYuf"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1222B1E9095
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629183; cv=none; b=CtIteIxCszJjzALvSTTaf4m2cbf+HLqCCTRtUho6whe2JTUdU/DlFkBZAaqnXwDSR7ubenGdTcsG9mbhsYVdxfWkhNu/5NwyPpCddiuYdDHg9AhkzzhLRM3khMwL2vsLnuXPQvS5U3uUzZWGxRxjcSpCOXxe7VasKnRyhpYgvcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629183; c=relaxed/simple;
	bh=AEJZCH5SmAg2ybzZzH0bZgBAbTh2RrGU19StDW8noJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRfgjwUKj0zYw6g1gAgHxFJJhCIT8dI0fs43TDsjpTEw4aInTszdMLVQVhO7IONbLzVYGe0Y2ul6iO/wP+cwPyUtUFgbO1tr9XkW9XY5KDxrHKPwg7edKdraomkwRibdYzlbwT2uQsd6J9mMkYh3Z4bySJzYMJYXOjJl5dKJGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=UHvyBYuf; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99650da839so288536166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 23:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728629179; x=1729233979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GOWm4Ez93j7w3ubgDJn8cAypKzj1qTyE1Gp4WKBx7g=;
        b=UHvyBYufCIbhK3/5DlqALKL5wO45k5LhWs78oas2SUHGE8TU3F1LKctknbJwSJGGv8
         XJ4Z1XgGdy4RcQNa9C7k1oaeqUs51y4IuuGQHfQjVZsH1Uxiik6iB3ZuzH/0K5eqO3YT
         Q8eMPP/OKmmNaGp999DvQ7Q13Zwpm7Yd+4aWRioPy6+Itm27ky33WlE7pv03kO3roeJ2
         k2sxHPn8+XlIoN+esXVmeTttyfEXNVyxkCul/J9uuo4qMzQmirbd3Y8l89yOp/Hz8vs1
         wJHHucL19yWCDd6tWfSVO5hq9wnhW/vp8myBnYtbvhTTly8PnFnaZvD1mrsqd/d4sHhf
         cWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728629179; x=1729233979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GOWm4Ez93j7w3ubgDJn8cAypKzj1qTyE1Gp4WKBx7g=;
        b=gDUcjXGx/6nrCk67H7nYLUMLadXb9OC1gM03WLtZTZv1E1j4CyGGSZ1bnSso2l9Mu0
         QniegV/Yds6Zoa4pU53NH6dRZjg0kxn2dVzXkMeIEJOi71YgmgV0m8kMr7BGhV6dZpSD
         Zlk0D9AVMYiKUU2MdIQhVA55vTxCgm6GEjkbTMWNKZeBTkyA6rRid5+Fi8oGs5+b91UA
         A/zTc+zDiqTbs0B5ftSrfwzl0mok55Ysbdslwp6JtKuRb3SSWBmGSVp7hsp6BbwjSzMu
         OuGumr0kqshCp7VMygF2d3pNG8G+RQYXf+Fzt04hCGIkPEkrDkzvQQOIYxMDxGv94j4L
         8iSg==
X-Forwarded-Encrypted: i=1; AJvYcCV+syIA3SypzraeQJ54DTHQZLypMJzW7+okGVCm9K5sYmlXSdw97/A7cizf7540AJuyzTvDmbvRrYwgjy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLKufgIdYg08u+taiHSKXwTKqznPMyyb2/qts3TMpA4WAoZYzf
	E9HDMAceWHmjbukBdLbDKBApCwa79qC2xqfYggSsEE8U99Ctx8Q30i0ARFPY860=
X-Google-Smtp-Source: AGHT+IEzuJ8la1znR5wLTnUyCcTrPupabLqIjUuyNTVH+msXYchYUvqgyfXMo/4f3fgzmWTAWOExYQ==
X-Received: by 2002:a17:907:d599:b0:a99:5773:3612 with SMTP id a640c23a62f3a-a99b93d4235mr119056166b.36.1728629179096;
        Thu, 10 Oct 2024 23:46:19 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7edde0fsm176951666b.40.2024.10.10.23.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 23:46:18 -0700 (PDT)
Message-ID: <de96919b-c4c2-4ee3-b114-a575fe61701b@blackwall.org>
Date: Fri, 11 Oct 2024 09:46:17 +0300
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
 <8f285237-757b-4637-a76d-a35f27e4e748@blackwall.org>
 <ZwVTUt_ie0sMsjbk@calendula>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZwVTUt_ie0sMsjbk@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/10/2024 18:44, Pablo Neira Ayuso wrote:
> On Tue, Oct 08, 2024 at 05:45:44PM +0300, Nikolay Aleksandrov wrote:
>> On 08/10/2024 17:30, Pablo Neira Ayuso wrote:
>>> Hi Nikolay,
>>>
>>> On Sat, Oct 05, 2024 at 05:06:56PM +0300, Nikolay Aleksandrov wrote:
>>>> On 05/10/2024 04:44, Amedeo Baragiola wrote:
>>>>> Since commit 751de2012eaf ("netfilter: br_netfilter: skip conntrack input hook for promisc packets")
>>>>> a second argument (promisc) has been added to br_pass_frame_up which
>>>>> represents whether the interface is in promiscuous mode. However,
>>>>> internally - in one remaining case - br_pass_frame_up checks the device
>>>>> flags derived from skb instead of the argument being passed in.
>>>>> This one-line changes addresses this inconsistency.
>>>>>
>>>>> Signed-off-by: Amedeo Baragiola <ingamedeo@gmail.com>
>>>>> ---
>>>>>  net/bridge/br_input.c | 3 +--
>>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>>>>> index ceaa5a89b947..156c18f42fa3 100644
>>>>> --- a/net/bridge/br_input.c
>>>>> +++ b/net/bridge/br_input.c
>>>>> @@ -50,8 +50,7 @@ static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
>>>>>  	 * packet is allowed except in promisc mode when someone
>>>>>  	 * may be running packet capture.
>>>>>  	 */
>>>>> -	if (!(brdev->flags & IFF_PROMISC) &&
>>>>> -	    !br_allowed_egress(vg, skb)) {
>>>>> +	if (!promisc && !br_allowed_egress(vg, skb)) {
>>>>>  		kfree_skb(skb);
>>>>>  		return NET_RX_DROP;
>>>>>  	}
>>>>
>>>> This is subtle, but it does change behaviour when a BR_FDB_LOCAL dst
>>>> is found it will always drop the traffic after this patch (w/ promisc) if it
>>>> doesn't pass br_allowed_egress(). It would've been allowed before, but current
>>>> situation does make the patch promisc bit inconsistent, i.e. we get
>>>> there because of BR_FDB_LOCAL regardless of the promisc flag.
>>>>
>>>> Because we can have a BR_FDB_LOCAL dst and still pass up such skb because of
>>>> the flag instead of local_rcv (see br_br_handle_frame_finish()).
>>>>
>>>> CCing also Pablo for a second pair of eyes and as the original patch
>>>> author. :)
>>>>
>>>> Pablo WDYT?
>>>>
>>>> Just FYI we definitely want to see all traffic if promisc is set, so
>>>> this patch is a no-go.
>>>
>>> promisc is always _false_ for BR_FDB_LOCAL dst:
>>>
>>>         if (dst) {
>>>                 unsigned long now = jiffies;
>>>
>>>                 if (test_bit(BR_FDB_LOCAL, &dst->flags))
>>>                         return br_pass_frame_up(skb, false);
>>>
>>>                 ...
>>>         }
>>>
>>>         if (local_rcv)
>>>                 return br_pass_frame_up(skb, promisc);
>>>
>>>>> -	if (!(brdev->flags & IFF_PROMISC) &&
>>>>> -	    !br_allowed_egress(vg, skb)) {
>>>>> +	if (!promisc && !br_allowed_egress(vg, skb)) {
>>>
>>> Then, this is not equivalent.
>>>
>>> But, why is br_allowed_egress() skipped depending on brdev->flags & IFF_PROMISC?
>>>
>>> I mean, how does this combination work?
>>>
>>> BR_FDB_LOCAL dst AND (brdev->flags & IFF_PROMISC) AND BR_INPUT_SKB_CB(skb)->vlan_filtered
>>
>> The bridge should see all packets come up if promisc flag is set, regardless if the
>> vlan exists or not, so br_allowed_egress() is skipped entirely.
> 
> I see, but does this defeat the purpose of the vlan bridge filtering
> for BR_FDB_LOCAL dst while IFF_PROMISC is on?
> 

Yes, it does, but it is expected behaviour with promisc on.

>> As I commented separately the patch changes that behaviour and
>> suddenly these packets (BR_FDB_LOCAL fdb + promisc bit set on the
>> bridge dev) won't be sent up to the bridge.
> 
> I agree this proposed patch does not improve the situation.
> 
>> I think the current code should stay as-is, but wanted to get your
>> opinion if we can still hit the warning that was fixed because we
>> can still hit that code with a BR_FDB_LOCAL dst with promisc flag
>> set and the promisc flag will be == false in that case.
> 
> Packets with BR_FDB_LOCAL dst are unicast packets but
> skb->pkt_type != PACKET_HOST?

BR_FDB_LOCAL just marks the skb to be passed up the stack (terminated
locally) with the bridge device set in skb->dev, it may or may not be PACKET_HOST.



