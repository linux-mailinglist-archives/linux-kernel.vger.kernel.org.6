Return-Path: <linux-kernel+bounces-388975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E739B66CD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5C8282617
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6C41F7066;
	Wed, 30 Oct 2024 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Llu25byj";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dEF0jDsu"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8E11F706F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300500; cv=pass; b=d0KrpRxp+vUdaWG2Jzw9IbBbhYJAUkyeCNjZLNN0qCitZwYtJ/rDKHzNzasrRtQripr1Am03d4gQgUe2QiRacKBhjjEy38L7eqNxSWL3iX36/MGWb/zrYmCiQahz6JEsUVysfUrLNK3k1LaviPoQZhCNA+tDdtKkX8pbgXnnh/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300500; c=relaxed/simple;
	bh=PyAeVpPBnsiXwCMBexmbRjlJNDiwLXsvPIAp1at2+xs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YynREEfhG8hwkSldVraRlnMQRIoy4pJjo40WMDJeOt/zBklmj144w8e66KSe47JTkqUaH55x8fesLOqublurAp02VPvID92/q+PXJTF0UDjbB1y9AXe84McZDtXs5+CEV8DV/yCf8LEP2ecAzz8t8GoCL5mfcP/CLp9B0Q2Pc3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Llu25byj; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dEF0jDsu; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1730300489; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fRgfk+GMGq+rvcrC+gtBNRlklph+0eYESbf4XTtGgjvN3tXhcrvS3lUV1J6ncU8II6
    FD8cygUXBkT97RHvk5ymyQBthoCuQGT6NegIOCHcmvvSs1M9VjPtIQSieWqNBjOI27sD
    /GkfSeZUnTra/as+rWwvucHB/iKrFM2DBHWTjhCD1wriU4akTK+oKiknpV5LhO7QYqKk
    egzoiE+B0PNZQI1m2f7FflczFPuASrPez9L9H6NcXF4vpx5z+0gcp3YG2/uTt2R8miQC
    hCREVOjq08/hTnEyco/IWz3k77oMPorXHBe+DdgnwoBgOUI3zMKAz2i8RikncNt3JsH3
    r8sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1730300489;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3ZmPdH25HAB6tf0BjMLlYY3sE/tIU0ju1cgxYg17oI4=;
    b=Uasv0w1W2NdWbhrz8NeWIHRV5nDunh2mKdBqtPVBzDm2A2UXYl4rMvAKHYCsP7PG8L
    EKD9SZ8Is+yumv5dvtwUlNFrGFCI/fropqA5APYoHsbzJiV60gcYN7jdkgodaLL7lmyq
    wObHVibvhvBDBgfaeULWAnLNWO1rLd+Cnsyss7sT3gcrmgoUmfK8+fbB7CkqGldT9OfB
    iBrFa/3pxIemP+jkWH8F9f0O0P5U8wAIoFqAgUXVDl+h3DawaDo4MrJ0rQMhlAlLVWjF
    UbJlJjaTcGRk30zJUDSG2ALkQouLMRytxvczcRLHCBThN539bEoXpE7BYo2krSNcvrnF
    ySow==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1730300489;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3ZmPdH25HAB6tf0BjMLlYY3sE/tIU0ju1cgxYg17oI4=;
    b=Llu25byj/+qJVgdJMvFBOX3zloJ/Dvbn2UqIfiGlwcjM552okynwXzQ+Q1i2D+96CQ
    1y7CdrShZnNAMS4oHPUih/Tt7IiE+ac7Ax6juW9CJZv1qumo+a3AqvGwasog0pw1GRgv
    uYEP2vAcLLAnCKKDReYTl/9+lvbCPBHP0P+zVGUD3hCgTv9K72dJ/5G8euDCyf3LyRaD
    JEqy7pqmtVTlDVAGuFPxDJU77cf+Nd37n+RcMo1CezMhWMqxlKsJ8qcJ7AAa9e6qBc5/
    hhdVIkJCwLdkLJvzXycHKA7WOTYpvIYmU47B3pUAuohKhnN/yoWNe4mtD3yCyUG6agr3
    golg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1730300489;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3ZmPdH25HAB6tf0BjMLlYY3sE/tIU0ju1cgxYg17oI4=;
    b=dEF0jDsu7gYeMOKdNApzYUfeH+q1pG7EJ30GsqRi+Zuj3M04Inyfk5B6lhWokk4OR+
    nb4bxn67n6rjumpMnrDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id K63ada09UF1TLtG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 30 Oct 2024 16:01:29 +0100 (CET)
Message-ID: <09b130f2-740d-4e16-aaa2-8802d9c28277@hartkopp.net>
Date: Wed, 30 Oct 2024 16:01:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/21] can: bcm: Don't initialized an unused hrtimer
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <cover.1729864615.git.namcao@linutronix.de>
 <4e7dc11aa9ffb116678574889cda35b3cd5b7385.1729864615.git.namcao@linutronix.de>
 <203a1560-76c9-4c47-b1b8-b44ddf40cd16@hartkopp.net>
 <20241030121533.ioTNvYpX@linutronix.de>
 <d6055bd1-c0c6-42ad-bb21-7ffad98c9882@hartkopp.net>
Content-Language: en-US
In-Reply-To: <d6055bd1-c0c6-42ad-bb21-7ffad98c9882@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Just an additional idea:

Would it probably make sense to create a generic dummy function for all 
those cases like in the referenced rt2x00 driver?

E.g. as (inline?) function in hrtimer.h

enum hrtimer_restart hrtimer_nop_callback(struct hrtimer *timer)
{
	return HRTIMER_NORESTART;
}

??

Best regards,
Oliver

On 30.10.24 15:51, Oliver Hartkopp wrote:
> 
> 
> On 30.10.24 13:15, Nam Cao wrote:
>> On Wed, Oct 30, 2024 at 11:49:49AM +0100, Oliver Hartkopp wrote:
>>> On 28.10.24 08:29, Nam Cao wrote:
>>>> The hrtimer "thrtimer" is not used for TX. But this timer is 
>>>> initialized
>>>> regardless.
>>>>
>>>> Remove the hrtimer_init() for the unused hrtimer and change 
>>>> bcm_remove_op()
>>>> to make sure hrtimer_cancel() is not called with the uninitialized 
>>>> hrtimer.
>>>
>>> NAK.
>>>
>>> There are several other occurrences of thrtimer that are not covered by
>>> RX/TX distinction, where the second timer is canceled.
>>>
>>> This one-time init and cancel of an unused hrtimer costs nearly 
>>> nothing and
>>> is not even in any hot path.
>>>
>>> So this incomplete patch only adds complexity and potential error 
>>> cases in
>>> some 20 y/o code for nothing.
>>
>> The "real" motivation is preparing to use hrtimer_setup() instead of
>> hrtimer_init() [1] and deleting hrtimer_init() [2]. The new function
>> mandates a callback function, and since the TX thrtimer doesn't have a
>> callback function, hrtimer_setup() cannot be used.
>>
>> Your concerns are also valid. So I can drop this patch, and use a dummy
>> function to make hrtimer_setup() happy, like how it's done for the rt2x00
>> driver [3]. It will make the driver a bit ugly, but it's obvious that it
>> won't cause any regression.
> 
> Many thanks for your efforts!
> That's a good approach!
> 
> Best regards,
> Oliver
> 
>>
>> Best regards,
>> Nam
>>
>> [1] https://lore.kernel.org/lkml/ 
>> e4ce3a3a28625d54ef93e47bfb02f7ffb741758a.1729865232.git.namcao@linutronix.de/
>> [2] https://lore.kernel.org/ 
>> lkml/7bde2762d82d30dab184c7a747e76afc41208da0.1729865740.git.namcao@linutronix.de/
>> [3] https://lore.kernel.org/ 
>> lkml/49f2bce487f56eb2a3ff572ea6d7de0a43560c0f.1729865232.git.namcao@linutronix.de/
> 


