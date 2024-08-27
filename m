Return-Path: <linux-kernel+bounces-302826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1803C9603E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36432837B7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82185197556;
	Tue, 27 Aug 2024 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WSGKO7lo"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA0719581F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745788; cv=none; b=TEcz3GeEXtqBSwzsB14bPQOKUa0DjHV5g4wOrDH9M1ssF123FXHtMOCMIJJ7q2Klymn/OJXZIw8RdJDoKCJUXcOVrh9202Y6S+NLpTSmQMIo25mJCmW8VGu3ntGWDRoquFxgWmYG6m39Pa9WK7d6E/zo7poDKdIpLMMSRZM88PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745788; c=relaxed/simple;
	bh=dnoHKm2yvxPH3VTkgPHnEhhPPekUB87k1C9//rmT6Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAWc8/WE6oLjhBUyPMjSbEzOUdVaC2nQHS6rkOUlD2xKwH/mq9Ky47CCyhsd46wozJ8nNC+Hz0DTPB/KKCjztrVGLtvC/OhT4uHyHKeNcSQCHf9PslQbRukSqdgzG/ppYHaqGlPIJiwFAJEwijieDgZuEf/q9E0JHr2gNrKCRpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WSGKO7lo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20202df1c2fso40221585ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724745786; x=1725350586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STq2SksYEpeE5OUyyw6K3VOvxFlLjRrHwh+2IswLxOg=;
        b=WSGKO7loWDL1iJpVlAaNTr75V7Ghhm1S+6eJGP9RVUtqg1U0ygzvq7lXrzhsGGKG8d
         uYJBGBn+9uI5QFXVyWy/8RO5SFSca6ctHfvFHnqh1gtHwvUfrA9dqgq+pUcKwp8+nqpD
         4sRrK7HwlcDBfqQpZ1Tx22AW7pRGedNCLfrsazQ2w/Dd0+8GvDZBTwIsQySQ7f4jKzIo
         ku1qxydULGm4U6MnnpsPttRXhcRuB67XM8G2ZXPk8aRiWFE8hx3HdN9RKXpl81A8WjUI
         +bfThRSPxG27PKjemVifCISmmpxZTZEQiG+pRA4kCm7le3th048kqhUYdwc0M7cAmL9X
         tZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724745786; x=1725350586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=STq2SksYEpeE5OUyyw6K3VOvxFlLjRrHwh+2IswLxOg=;
        b=OGkHxVBZ+FGGTtokpneb55o2xT1ER+Nian9W6V+ykEll73Q4imQTP3w25ovAUf9qFB
         KZjEHjvJkNRnnQr4C19EgDFvqZdBxS3jkYAUEV26wnbxyrW6rF0W+MXyjCjA/229FKJK
         3LS5iRKksXSoiAcRuCvMy9dbm+gC1iBLnWpQ2xiCCeRGTB4fzshGho+q996L5KIRdQ9x
         N2sulkPukf8Dpi76TnLoOgnQWkyvnJ1HV0ybnOMdiRPQ70+8QcjsfqXs3vUorBzyMx8y
         YT6pzODokdS4dAMRRMmeLX2Om3lRgjK5QNDxcjvOrHv9Cn86V2Y4OSubWLRWXGtF5oh1
         ZYKg==
X-Forwarded-Encrypted: i=1; AJvYcCXVSKIS6czVEemzu4vg8eAVUJvzh98Tsvn1eUqTw41edpcpHwaj141A8B5EbT8W4NinvIJhfkzyMipJSs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBzPMOUakeD4Ss8yBS1fPgZb+rR21cNxPF3TuxFqGtoPq3KVZq
	AwoeEfOf4TEbLq1dpnkCZ4qJpL3wPbq1bJAHW+3dZLidRZjIrtA+1ontsK20waI=
X-Google-Smtp-Source: AGHT+IFragTajUnyMQOrCKm363S7w2u729C+2OQ5oQm9xpWjQFoR7pFUfYmaEOZUaiOLr9UG0AFueg==
X-Received: by 2002:a17:903:1104:b0:1f9:d6bf:a67c with SMTP id d9443c01a7336-204ddcba2eamr40232545ad.5.1724745785897;
        Tue, 27 Aug 2024 01:03:05 -0700 (PDT)
Received: from [10.68.121.74] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385567907sm78912905ad.12.2024.08.27.01.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 01:03:05 -0700 (PDT)
Message-ID: <c63f8752-527a-4960-a58c-87b6685ac074@bytedance.com>
Date: Tue, 27 Aug 2024 16:02:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH bpf-next v2] net: Don't allow to attach xdp
 if bond slave device's upper already has a program
To: Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, bigeasy@linutronix.de, lorenzo@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
References: <20240823084204.67812-1-zhoufeng.zf@bytedance.com>
 <Zsh4vPAPBKdRUq8H@nanopsycho.orion>
 <6d38eaf5-0a13-9f85-3a5d-0ca354bc45d5@iogearbox.net>
 <ZsiOxkd5KbbIIB6k@nanopsycho.orion>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <ZsiOxkd5KbbIIB6k@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/8/23 21:29, Jiri Pirko 写道:
> Fri, Aug 23, 2024 at 02:07:45PM CEST, daniel@iogearbox.net wrote:
>> On 8/23/24 1:55 PM, Jiri Pirko wrote:
>>> Fri, Aug 23, 2024 at 10:42:04AM CEST, zhoufeng.zf@bytedance.com wrote:
>>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>>
>>>> Cannot attach when an upper device already has a program, This
>>>> restriction is only for bond's slave devices or team port, and
>>>> should not be accidentally injured for devices like eth0 and vxlan0.
>>>
>>> What if I attach xdp program to solo netdev and then I enslave it
>>> to bond/team netdev that already has xdp program attached?
>>> What prevents me from doing that?
>>
>> In that case the enslaving of the device to bond(/team) must fail as
>> otherwise the latter won't be able to propagate the XDP prog downwards.
> 
> Yep, I don't see that in the code though.
> 
> 

Thanks for your suggestion, I will complete it.

>>
>> Feng, did you double check if we have net or BPF selftest coverage for
>> that? If not might be good to add.
>>
>>>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>> ---
>>>> Changelog:
>>>> v1->v2: Addressed comments from Paolo Abeni, Jiri Pirko
>>>> - Use "netif_is_lag_port" relace of "netif_is_bond_slave"
>>>> Details in here:
>>>> https://lore.kernel.org/netdev/3bf84d23-a561-47ae-84a4-e99488fc762b@bytedance.com/T/
>>>>
>>>> net/core/dev.c | 10 ++++++----
>>>> 1 file changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>> index f66e61407883..49144e62172e 100644
>>>> --- a/net/core/dev.c
>>>> +++ b/net/core/dev.c
>>>> @@ -9502,10 +9502,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>>>> 	}
>>>>
>>>> 	/* don't allow if an upper device already has a program */
>>>> -	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>>>> -		if (dev_xdp_prog_count(upper) > 0) {
>>>> -			NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>>>> -			return -EEXIST;
>>>> +	if (netif_is_lag_port(dev)) {
>>>> +		netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>>>> +			if (dev_xdp_prog_count(upper) > 0) {
>>>> +				NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>>>> +				return -EEXIST;
>>>> +			}
>>>> 		}
>>>> 	}
>>>>
>>>> -- 
>>>> 2.30.2
>>>>
>>>
>>


