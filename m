Return-Path: <linux-kernel+bounces-256210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5630D934AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123A8286DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3968172A;
	Thu, 18 Jul 2024 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeWX1Mb8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDA828DD1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294265; cv=none; b=sygqJ54XptZrlyfOWkN+yNum8n+f2ci/nc/XJvFwgyFUA9LRzFRU62EzNDvv9im45H1a41VGiPFkwxIj2Is+wKknHdG20GeDWsVdhauk/TTfLkFI50p0NRG3VPR6MYghmAUyDRqrlL3bo+TXyA0PWje5prgFIRi+0j71/kbZFLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294265; c=relaxed/simple;
	bh=vPy/nMMk1C76qqZRHaFBx0D6uZVQfOEera0mnUKS1Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LoOJkfw854AzJbSybgPXijUk/n8cvPmhB9MCpNbTvPrq8Nxckwni7YnCNVyjOOEqMdD5I8TjijDHQ1jBeZY+IpwiaXcEvYRHzlelic3690VwvtyoiLG2ljsJL5zGY2I8whKKhp3Ftibl6uOScGUUXrlgKrUd+j5K78Mfx0isndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MeWX1Mb8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721294262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZwV4xC2XIy0bnRWnXbVpRjb1sT4l2/9bWUdXm5/n8k=;
	b=MeWX1Mb8yh5YIZtGWHo9aD4J4ejblza2xC+B2GizmTF1Dgz7cwBQIiAyINBxZd+HgCiipY
	DiBc3jvVFjJMkOdFGntY1oNBP7T91pdzejAY9GzGqoZWO2yJagKJbcnzJJOVlO/xCp3zZG
	xwhzv1IwXnMv6CZChIjAPZOAxuZq9o0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-65uwaXIFN3aUH9SroG_EZg-1; Thu, 18 Jul 2024 05:17:41 -0400
X-MC-Unique: 65uwaXIFN3aUH9SroG_EZg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee9cd9b5fdso466301fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721294260; x=1721899060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZwV4xC2XIy0bnRWnXbVpRjb1sT4l2/9bWUdXm5/n8k=;
        b=STXeL+eRiwj/tGtSMmmzJ+wI4Ljz/tm5LGwe86ADY2R7Ki4NXc8H0jlRIQUIw2Dd0G
         ooodCiaop0U6GVICV64jFj7qgIeWF1XDj+fQGvfGqJhRjZyo4T3Gp98SVE7B5f9jbobI
         SujurwtPQ7iqnP8bgaPIAphmLPWAZVeXm4lP3BqEyE7cfNYCKLEKtJofxbH7bcGO8yNK
         NroCXXYXVVAFIoJE3hzDuycDCqX354a5Xw7odQ8G2QRbIYNlohAH+e1fRPcShTJYjIKG
         bXn6+zlI1YEYnaT/aFRhFyvKU4DU0xCLKMszNcJip58JavwbaDbumIKCbDtH6FOUiQ7V
         ko/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1jcHpAgUerjYklguu30HALjvQSh1R077qjLOM6Lmw1uKlVKasRinqkqZyYoMv2oD850kAyYrV2o7g/2aDliUZyWeD7bF2nTtvtpa2
X-Gm-Message-State: AOJu0YwLBhGK9czEwv+61ttYLimWy86gdEvHc/vcmoXLoVLWyq2DwPq7
	h8ONZQC8RJI5jZovqMIcenNgnlBkzwF4tYFXxMLt2k4VD13eoRl70V1iVoihqR0UCSSdVyOvgUe
	RPUHqqvhe4nfLObnNP6rTsder2qjy9o+sCh1ehgMCmIX/+wTGofXKq15RIS5CvA==
X-Received: by 2002:a2e:8396:0:b0:2ee:8071:5f03 with SMTP id 38308e7fff4ca-2ef05d33113mr7422771fa.5.1721294259910;
        Thu, 18 Jul 2024 02:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC7SAChnVTkqMThBZ6Thcv9r82ds9BHgKpNdZmhfu9sRo1Nqg7wv+mY+GC+hLh5U6SiIVSmw==
X-Received: by 2002:a2e:8396:0:b0:2ee:8071:5f03 with SMTP id 38308e7fff4ca-2ef05d33113mr7422601fa.5.1721294259439;
        Thu, 18 Jul 2024 02:17:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24? ([2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2920313sm2848755e9.0.2024.07.18.02.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 02:17:38 -0700 (PDT)
Message-ID: <cfc3ba0a-4c91-4c58-9c98-6285720473c8@redhat.com>
Date: Thu, 18 Jul 2024 11:17:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: process the 3rd ACK with sk_socket for for
 TFO/MPTCP
To: Matthieu Baerts <matttbe@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org>
 <CANn89iKrHnzuHpRn0fi6+2WB_wxi5r-HpZ2jrkhrZEPyhBe0HQ@mail.gmail.com>
 <310de142-e263-4bcd-b499-69e0640de51e@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <310de142-e263-4bcd-b499-69e0640de51e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/24 17:09, Matthieu Baerts wrote:
> On 17/07/2024 16:57, Eric Dumazet wrote:
>> I had no time yet to run all our packetdrill tests with Kuniyuki patch
>> because of the ongoing netdev conference.
>>
>> Is it ok for you if we hold your patch for about 5 days ?
> 
> Sure, no problem, take your time!
> 
>> I would like to make sure we did not miss anything else.
> 
> I understand!
> 
>> I am CCing Neal, perhaps he can help to expedite the testing part
>> while I am busy.
> 
> Thank you, no urgency here.
> 
> If it's OK with you, I can send a v2 using Kuniyuki's suggestion --
> simply limiting the bypass to SYN+ACK only -- because it is simpler and
> ready to be sent, but also to please the CI because my v1 was rejected
> by the CI because I sent it just before the sync with Linus tree. We can
> choose later to pick the v2, the previous one, or a future one.

I think it would be better to have this patch going through the netdev 
CI, so a repost would be appreciated. I also thing Kuniyuki's suggestion 
should be preferred, so I would say go for it :)

@Neal could you please run the pktdrill tests on the new, upcoming 
version, instead?

Thanks,

Paolo


