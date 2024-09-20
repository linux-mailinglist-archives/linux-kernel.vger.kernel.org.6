Return-Path: <linux-kernel+bounces-334003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3BE97D146
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B53F1C20BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F4042070;
	Fri, 20 Sep 2024 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="d2cyRI9D"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCD03BB22
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726814548; cv=none; b=NmYI/20ZuO1gHFn2jFxPprTlFVDgPh4R9SWk0uvbzqYdZvBnUjZRBEkj5mIj2J7M0zu22k0cETkmkG2sHRJsulyG45NLOHeywTh7xqkeo7D5nDZVnvGMCdH6PMfNwJXT6QpcG5yZ4xdePBXRXAgc7GrZPRTj+RJ8IbKi6CcWVB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726814548; c=relaxed/simple;
	bh=Hb2b/+q+hToRh61WxWnw+lJdABcYLPuii7nIFRD9qsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijc7yR4+4jWj/zbeo03h9n+3DR0a2aVXGLeNS0PO8ogCc5av42M4xRa0d3oBCKccDWsMndghUIZ0uUmvo2tVKeezb+PqJKdalB8NMI0sQbXekTJslVcMIxrHRA03UKuKIIxnkaPgfTy9cjI28qA6hWRYn6KIzD7DgOmX2NEepNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=d2cyRI9D; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso214579066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1726814545; x=1727419345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98uSNXWBdtIj2loX7w9P5NmjIJ5+wZsoyxlrEw5OdHs=;
        b=d2cyRI9DpNUsiiiwbwqNaVc8IDC83X/gjCOLiQYqWNOfpJvci0X1/KAomOY9kOfd5+
         xP7KuzxA+7cQ3QBc+ORnS71nq+y9/GP4JCe4aUqZ+vDAs5bju2hMhcuY4xXom+qR16NZ
         myoEudhNOGQ706QDUHhqorUZy9jFTyzi4694O/2BKJ3W0qtvyxwZ9Hml0HPgVSVXwEBn
         IIgxqHNTu+pth+nopXdxRvH9qq800ISDzG9yDp+gf0MlBE89l2jsEGjIhakAw0B4DbHI
         7lIpoOhrLDk0AAxCJczpd2vZE8BRuQHcAikU1dBFXZ/T1qX7syJeR/KQ/sDySYjX30+4
         PQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726814545; x=1727419345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98uSNXWBdtIj2loX7w9P5NmjIJ5+wZsoyxlrEw5OdHs=;
        b=qkpilyLGSPnA08hg0Ksny6yEOGpopha3gr2HCYtAU6hOn/YszAoJ8em0IM5i5vv+zj
         RcSro7o3khkhsRzcHuDULaDgpwJ6KrNnkTu2XADJoT/dotbPMQd4lJnxsPhUsJfdJDFg
         lhun/0IqLRrRMk0R3N7EA4p+qo4vpTeKBYHlDvpDYjGUfvyrNE88aOR4vaGimEwUqEqd
         Kl5qPaX6I+iMBqK6nExSdZufhqrL5QYS86maMdVjCkZYZsgF9uYCaPEuHWKp5YFsW9Ki
         3JOFZIUWipXjNKx0l4D3TE389qp8+eYX7QsD/BZBUZhqsdDnR3VUd/o2xboHwRQ26Ck+
         J49Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlqhUfxy7UGxw5CHyq+q7LEwJ2EA8ToHNE4XGcRYE40f/nGd4GULb5608M0VYUZ0oYcqzweecYH0RmT1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEGXdhhkElLu78Qqrh93JmMzCyEbFRvMIlC+hcjQwAIGVeq090
	bVFxUVnUfU5agoTE30GV0UPDL+1e227C+63wf8naMo5Y3hC4hEiSMgwSClmMowg=
X-Google-Smtp-Source: AGHT+IFK3LECOgNL2LQB34zytpe20wT+mFRQaW0BYumib9GiIXC7awb6RQOknCMw9j46sSiKv4IBmw==
X-Received: by 2002:a17:907:e6de:b0:a86:68a1:6a08 with SMTP id a640c23a62f3a-a90d56b44a3mr138829566b.29.1726814544477;
        Thu, 19 Sep 2024 23:42:24 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90d21bc502sm76613066b.25.2024.09.19.23.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 23:42:24 -0700 (PDT)
Message-ID: <34a42cfa-9f72-4a66-be63-e6179e04f86e@blackwall.org>
Date: Fri, 20 Sep 2024 09:42:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net: bridge: drop packets with a local
 source
To: Thomas Martitz <tmartitz-oss@avm.de>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Nixdorf <jnixdorf-oss@avm.de>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240919085803.105430-1-tmartitz-oss@avm.de>
 <934bf1f6-3f1c-4de4-be91-ba1913d1cb0e@blackwall.org>
 <7aa4c66e-d0dc-452f-aebd-eb02a1b15a44@avm.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <7aa4c66e-d0dc-452f-aebd-eb02a1b15a44@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/09/2024 14:13, Thomas Martitz wrote:
> Am 19.09.24 um 12:33 schrieb Nikolay Aleksandrov:
>> On 19/09/2024 11:58, Thomas Martitz wrote:
>>> Currently, there is only a warning if a packet enters the bridge
>>> that has the bridge's or one port's MAC address as source.
>>>
>>> Clearly this indicates a network loop (or even spoofing) so we
>>> generally do not want to process the packet. Therefore, move the check
>>> already done for 802.1x scenarios up and do it unconditionally.
>>>
>>> For example, a common scenario we see in the field:
>>> In a accidental network loop scenario, if an IGMP join
>>> loops back to us, it would cause mdb entries to stay indefinitely
>>> even if there's no actual join from the outside. Therefore
>>> this change can effectively prevent multicast storms, at least
>>> for simple loops.
>>>
>>> Signed-off-by: Thomas Martitz <tmartitz-oss@avm.de>
>>> ---
>>>   net/bridge/br_fdb.c   |  4 +---
>>>   net/bridge/br_input.c | 17 ++++++++++-------
>>>   2 files changed, 11 insertions(+), 10 deletions(-)
>>>
>>
>> Absolutely not, I'm sorry but we're not all going to take a performance hit
>> of an additional lookup because you want to filter src address. You can filter
>> it in many ways that won't affect others and don't require kernel changes
>> (ebpf, netfilter etc). To a lesser extent there is also the issue where we might
>> break some (admittedly weird) setup.
>>
> 
> Hello Nikolay,
> 
> thanks for taking a look at the patch. I expected concerns, therefore the RFC state.
> 
> So I understand that performance is your main concern. Some users might
> be willing to pay for that cost, however, in exchange for increased
> system robustness. May I suggest per-bridge or even per-port flags to
> opt-in to this behavior? We'd set this from our userspace. This would
> also address the concern to not break weird, existing setups.
> 

That is the usual way these things are added, as opt-in. A flag sounds good
to me, if you're going to make it per-bridge take a look at the bridge bool
opts, they were added for such cases.

> This would be analogous to the check added for MAB in 2022
> (commit a35ec8e38cdd "bridge: Add MAC Authentication Bypass (MAB) support").
> 
> While there are maybe other methods, only in the bridge code I may
> access the resulting FDB to test for the BR_FDB_LOCAL flag. There's
> typically not only a single MAC adress to check for, but such a local
> FDB is maintained for the enslaved port's MACs as well. Replicating
> the check outside of the bridge receive code would be orders more
> complex. For example, you need to update the filter each time a port is
> added or removed from the bridge.
> 

That is not entirely true, you can make a solution that dynamically compares
the mac addresses of net devices with src mac of incoming frames, you may need
to keep a list of the ports themselves or use ebpf though. It isn't complicated
at all, you just need to keep that list updated when adding/removing ports
you can even do it with a simple ip monitor and a bash script as a poc, there's nothing
complicated about it and we won't have to maintain another bridge option forever.

> Since a very similar check exists already using a per-port opt-in flag,
> would a similar approach acceptable for you? If yes, I'd send a
> follow-up shortly.
> 

Yeah, that would work although I try to limit the new options as the bridge
has already too many options.

> PS: I haven't spottet you, but in case you're at LPC in Vienna we can
> chat in person about it, I'm here.
> 

That would've been nice, but unfortunately I couldn't make it this year.

Cheers,
 Nik

> Best regards.
> 
> 
>> Cheers,
>>   Nik
>>
> 


