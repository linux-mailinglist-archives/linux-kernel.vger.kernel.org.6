Return-Path: <linux-kernel+bounces-270947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D80944776
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C02285392
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F5C170A13;
	Thu,  1 Aug 2024 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBdubWV2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C28170A15
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503235; cv=none; b=ceddjD8Pfo6ZDDYDV2TvfPRkVC6dqd22JOLhq4V2pKMleFt4x2z91SBeYgrFigTaSyTl03wr9b2rq0Vs3ShtaH+fGipn9KUh70k26dFiqRnyY7VN71K7Xud2tKftVGvDRpngEIEpCiDwT3Z82dyn8HEQbr1JqH0M1/g2a2erjmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503235; c=relaxed/simple;
	bh=oz+f2ExRuhr8sgqTuD8RIIayx9QHr6/sG8gtOY5Vzws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOBeYP7sLBaV97RN2Z39Fc18USF/X80PU5AFwbJxiQBIHGvTNdhADmhgA1CgEXWdUtXTdy0k6x2SrCzcuoWRaiqTq/9YNFgGcFxNsuE/Xxy1r2HqnAx5Zr/kqOR8r4qZsAU9MXev3XKIrrX4X66ARX6Zmsv66MSjYksh7Ba8T3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBdubWV2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722503232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSKEfuB4n+/b+oxF1D4wGQsbWuy3r00dVzWZOwQpkNw=;
	b=FBdubWV2cVUH0G3578SyqyvPPGUhsIYBsZo4hy5LyLRw+Z28Hc/iGVElaJ5Y0AUCWXt3LG
	cUwkIBU8GiMsH6Z6getYR0WOHZdhNvD6cNiMtTqNxjxzv7YJT6tGj7z/CINV/VbFgb/bZv
	32yy53C3qZR1bWKG9zTiOQeCjbHo0Tg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-n98GteyNMaWvw1iSQuqjcg-1; Thu, 01 Aug 2024 05:07:11 -0400
X-MC-Unique: n98GteyNMaWvw1iSQuqjcg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428087d1ddfso10434465e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722503230; x=1723108030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSKEfuB4n+/b+oxF1D4wGQsbWuy3r00dVzWZOwQpkNw=;
        b=BenwWJz4DDNlkXvHIYuXDfeUfDVykMOTUk8/nnyNxXZbtKkZNra1mgzeJILU8XCHjJ
         yE218Wcy4An7mOk3N0yxtMETDEZe33jVjA5G0hB259/FgvW1GP12YPaiZErtpnuoJXRy
         BuMGFCtCHPr44B2NsCgnDeKWEXkTQQkZdP4sAygiulEzSVuS3Av6kkv+y1yGIjxKE/Wi
         bilvwVFv/1ooy4ZdxsPOV4W3S/MxuW5XDv0QYQ7B9iWXT1q9DHsuKzIfGmk1DYNM+S7r
         Yam+2nlxD8xf4y90GMkMJWyo4YewNQznPPbHGPfz4ajc3ZbP6HilqvlrcqsMHByr9oks
         pFJA==
X-Forwarded-Encrypted: i=1; AJvYcCWwTM021l9Ksl7esv9sMoL1Jhq4LODKYFTzYeb5QHXM1xMDZj9vxCUU9JELLH0M5Qtk28fxjhnqjIM5Fm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOKNs0AtEu8ViciVFEOhg882PztXeQ3zhurmkx+23usDBIe8TY
	Fn6sCT9Iq8HjfhshvI3I/JZGSzM+p5xOpZ/Ve1MGiPzeZNqYLhGkJHPsdfT0s8yrEyKMH5ZjUdl
	gze4oyj3Wx2kr9D/1FNE/CAhQmOf1lpaH9AOW9ZVPrfW+NRs/GGTXHrFWHwMh3w==
X-Received: by 2002:a05:600c:3546:b0:427:9f6f:9c00 with SMTP id 5b1f17b1804b1-428b4aed78dmr9025865e9.6.1722503229899;
        Thu, 01 Aug 2024 02:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ8Yo49UNfIIekEb+fzZKQGd2Ra6P+DX7ISYAX2XZE8+eSpcsrF+n5sZUOduN0j+FdCYDkzg==
X-Received: by 2002:a05:600c:3546:b0:427:9f6f:9c00 with SMTP id 5b1f17b1804b1-428b4aed78dmr9025705e9.6.1722503229351;
        Thu, 01 Aug 2024 02:07:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410:9110:ce28:b1de:d919? ([2a0d:3344:1712:4410:9110:ce28:b1de:d919])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baa9071sm49462285e9.13.2024.08.01.02.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 02:07:08 -0700 (PDT)
Message-ID: <9b084601-9d64-4737-8c32-4c295aafd3df@redhat.com>
Date: Thu, 1 Aug 2024 11:07:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: skbuff: Skip early return in skb_unref when
 debugging
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 leit@meta.com, Chris Mason <clm@fb.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240729104741.370327-1-leitao@debian.org>
 <e6b1f967-aaf4-47f4-be33-c981a7abc120@redhat.com>
 <Zqoe9/TiETNQmb7z@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Zqoe9/TiETNQmb7z@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/31/24 13:24, Breno Leitao wrote:
> Hello Paolo,
> 
> On Tue, Jul 30, 2024 at 11:38:38AM +0200, Paolo Abeni wrote:
>> Could you please benchmark such scenario before and after this patch?
> 
> I've tested it on a 18-core Xeon D-2191A host, and I haven't found any
> different in either TX/RX in TCP or UDP. At the same time, I must admit
> that I have very low confidence in my tests.
> 
> I run the following tests for 10x on the same machine, just changing my
> patch, and I getting the simple average of these 10 iterations. This is
> what I am doing for TCP and UDP:
> 
> TCP:
> 	# iperf -s &
> 	# iperf -u -c localhost
> 
> 	Output: 16.5 Gbits/sec
> 
> UDP:
> 	# iperf -s -u &
> 	# iperf -u -c localhost
> 
> 	Output: 1.05 Mbits/sec
> 
> I don't know how to explain why UDP numbers are so low. I am happy to
> run different tests, if you have any other recommendation.

Beyond the '-b 0' argument, as noted by Jason, you need to do manual CPU 
pinning of both the sender and the receiver. Additionally, to really 
flood the receiver you likely have to place the sender on a different host.

In any case, given all the prior discussion, I don't intend to block 
this patch.

Cheers,

Paolo


