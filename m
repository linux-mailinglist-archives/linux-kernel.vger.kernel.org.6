Return-Path: <linux-kernel+bounces-262082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA57393C08F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F1B3B20ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF181991DA;
	Thu, 25 Jul 2024 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrEHCewf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8F1991A8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905597; cv=none; b=AQIYYgsXpAVduI0uzpB+2Kpxna7z2+GW1DafjtSnAwgDka2rmqk8JlzadnorDE4tZXT3dMz9x8MKbjmVnCrDI16dY7c2RCGPL05YcKRnCpKWyPqvjolhl5DCRGDi1fR0cPt4/cG5N/9tiLEOG2nP9YJ564u+nTGXoKieTmnNZb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905597; c=relaxed/simple;
	bh=Z+/cf+NofFzA35SddKTJMioN4/UdboRja1QQUFeoI2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vf2VA5dk4bZlInPz/awYhnJrvwoq1BZ+eGVw2OcY6hvD8fr060Ew57DfSA9dJpXXqb1T5l1bz4UjmdM3UZUL0eFIZADK816ZJ+1FfGiwmRzvi/A3JZ8K2uQpbp0q07VTQoR6BcDvKhqh89DzB1l0vi4cTfHIaZOERKgRtTWMUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XrEHCewf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721905594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WN1T7ImyHgIlrYMLiebMiQokg+VGDY2/N/KmNsun8Ek=;
	b=XrEHCewfXMZt5pyDHYzLdjC+FBjjVBe/gRZwojK4SX2XE2XjdX11ynzsqCm4p5saKEgzd8
	nKn859LJv6JhQvvkgufxiKa7LKm7JhzxEKHUBhP/scs4DXMTA4lmpBHh+x1Ai2l+WEAsbE
	r5mef35Zc1OSbGtlQo+x+fu3pbNsIKc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619--xXJJfcsPpOPZI1i_jiCPw-1; Thu, 25 Jul 2024 07:06:33 -0400
X-MC-Unique: -xXJJfcsPpOPZI1i_jiCPw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-427feed9c71so1476535e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721905592; x=1722510392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WN1T7ImyHgIlrYMLiebMiQokg+VGDY2/N/KmNsun8Ek=;
        b=Y7hvjyP+K+m+LAtK8bjCBBkmm5/s1mr9oGwbHflpmhg7S6hMF41du6YABlWsh73+Xa
         LSNJudAfl16SryUIo4wx2w/sTnBhIC74Naxy6HzB32viAM37FULn9tl0+a6j38Fe0nED
         On/6Z5+LiEdBLNqbyha3Xwc/3VrqBcLzNyayUSP9+Vd2gEW5Aior/9PKBCL5xGE+Np9R
         hfW9YaHpmFcoJVddhV6SnqUWLjdLPPaOiUucsaeAAXri6zIzmD/B60QzQyPjZhICkXGT
         tGFFkvm5VCJtikb1ovzKmHr5do0/OMhzlQ9mcszo4/rcovdhwmYC8jampNVOMunoH31x
         f3og==
X-Forwarded-Encrypted: i=1; AJvYcCUbEQaGEjPATIYuWPD37GxIHC2BOUDl9/Scp7fDw1H4IgVHZh3kotfeUrVsMbRy59yvWaA421JzrfGziazz1hMUATNYy+SAR7+wGpIO
X-Gm-Message-State: AOJu0Yx84ypoGHOb7rCv/LD15A9qttSxUmncOonRGIMJ06yh/GxrfHal
	FOZpYkBPMomiECKHC4jW8FKyAYf2WB5qJ+mCBfelbfbE5Y5gDPK89oWGKMqEjwiLHXnt/Z7aopc
	4DhzlT1fXelY7isTEDnAHSI/MhlhxuVwEXzB4yh0gUjSc5FDwwA/JGmRFX8KAoQ==
X-Received: by 2002:a05:600c:35ca:b0:427:9f71:16bb with SMTP id 5b1f17b1804b1-42805713a1emr8546005e9.6.1721905591986;
        Thu, 25 Jul 2024 04:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBatNBk5gs/dWyR7c2T51W0nIxSSE/Dn9TTMdkHW3H4iQrQEZARNdPQXiwOCI42zCxVqSW5A==
X-Received: by 2002:a05:600c:35ca:b0:427:9f71:16bb with SMTP id 5b1f17b1804b1-42805713a1emr8545885e9.6.1721905591458;
        Thu, 25 Jul 2024 04:06:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b231:be10::f71? ([2a0d:3341:b231:be10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574b21dsm29367305e9.27.2024.07.25.04.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 04:06:30 -0700 (PDT)
Message-ID: <b399e0bf-07fd-4da6-9ab4-19cd1ceaa456@redhat.com>
Date: Thu, 25 Jul 2024 13:06:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tcp: Expand goo.gl link
To: Simon Horman <horms@kernel.org>, linux@treblig.org
Cc: edumazet@google.com, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kennetkl@ifi.uio.no
References: <20240724172508.73466-1-linux@treblig.org>
 <20240724191215.GJ97837@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240724191215.GJ97837@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/24/24 21:12, Simon Horman wrote:
> On Wed, Jul 24, 2024 at 06:25:08PM +0100, linux@treblig.org wrote:
>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>
>> The goo.gl URL shortener is deprecated and is due to stop
>> expanding existing links in 2025.
>>
>> Expand the link in Kconfig.
>>
>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Both the motivation and updated link look correct to me.
> I also checked that there is no other usage of goo.gl in this file.
> 
> Not sure if this should be for net or net-next.

I also think this should go via net-next.

## Form letter - net-next-closed

The merge window for v6.11 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after July 29th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


