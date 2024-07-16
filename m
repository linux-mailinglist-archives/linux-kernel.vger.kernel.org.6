Return-Path: <linux-kernel+bounces-253799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67975932726
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFFBBB2158C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1978319ADBB;
	Tue, 16 Jul 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyFCx8Hq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179F19AD6F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135431; cv=none; b=GiUY+erX8Q6mkaoq12mds5UBTnofhJhPmi5K1SqisG7+h61+k+vxGChwdFuoIKqRFaatrwKdmBTRMbX5zlSTAtzlwM/a2Xowluy+O6fKg+TFnLBn1UOgkt/MW17SDOKDz5qHPbDvfM2pvJTiVSfRlao/2IuH9WTDlAlOlfQzqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135431; c=relaxed/simple;
	bh=k+1RV5GCOT+tXPua6FJHUXMrykjI0VBKOpOtbCgIoYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9SHVRxiRDxxfIneDaXQ8kxA6RqNXl94pdLzDPdQADeDdRSL5scKgnyGcaZ4ahw/8JPjZg1EbJpcIeKVNtO8tOlaG08UT5nxuudRawpMLBEg+xq8LTsEskRMIg8eK8GK4j9YZxdgH5Y2b5sIzaajpa73eIgd2nV05Ri7NQvJAj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyFCx8Hq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721135428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1gOfjCAx0JVhYPMj4vGIbpwiWQL5RJ8uO9QhWtc93A=;
	b=YyFCx8Hqmti+EVjkVJ3tu5O1kShFs3y/RehqlK7x5sY+YU1Icq9C/Og4yxrurhMIy2bb7A
	TFQn/pSxUpf5J+zjNrOrQfn/HxBAcS5GCu8iZx1dM6ThgKjeE9HbuD1TtCP1oVLgIxsMyS
	WY7E98aQ2x8v69qtGt2UgMBwt8Uptuw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-fuWFhv2xMriD0Hrj7ZaDag-1; Tue, 16 Jul 2024 09:10:26 -0400
X-MC-Unique: fuWFhv2xMriD0Hrj7ZaDag-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42660e2e147so10246785e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721135425; x=1721740225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1gOfjCAx0JVhYPMj4vGIbpwiWQL5RJ8uO9QhWtc93A=;
        b=mKFutesl3WO+uVp+guNhNy3MJY4MoEhdIGQCwj/35sVRYeULIjhqIpgHyWUOiOknTU
         Y6HkW/221k1GVbEJjQvrNFc12KtZzOh1NZacm9sX0Ysz4b48Ha2nRNiaDf85gWXUktjd
         VnMs2uCLJuZHBY54IRa3rhyYfq6lTDj+YQPdnFlyyvvRFjVujjwlfTtO/NT1ThuUGL4Y
         mo2tBg8qskjMELjAXg73ub41G3sLPbJTzLR0zcsSelW01FvIzcaizMqVMUxzq2xvQCox
         BlOr5+V4zNrC8NOFPTf1knlKcZEKeUXcU0QUDqJUL5ot18W8qxdGNX/x0v9UqMbkCSFb
         x4Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVM5WzB9nKtBX1Q7tXFRv4DWiqHQHK1ZaL2VCCr+4C8SgagNT+s29wWQwgvkrpG49RxrWWBemzBUUxxqjX9euJQ2fO0r58FZJp2cRX7
X-Gm-Message-State: AOJu0YyR/+qWMYpBDv7XDS25+x/R8DIQJossti/EXSVPYLKQcQD2r0QD
	rWxLnqen6HZtwSkygq6uPR7cCyfQv9UIAuK0YGMJr+vxEQTTdtepF0cltVMjXXvYr09BfZbqoOg
	EwBR2yaM29ayqiI3WZIIJo7fACRiO2C+gJMuQkhs1hMbBwrIQcH9kyNSXw5QjHg==
X-Received: by 2002:a05:600c:3b93:b0:427:9f6c:e4bd with SMTP id 5b1f17b1804b1-427b8a559f1mr12081385e9.6.1721135425395;
        Tue, 16 Jul 2024 06:10:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+ZbyRm/fg6TpbsA1hJlGXyGgkBQ+2szmJWprS7Kts5UhI3RP5xWMTxQEtgatsEgKvIffHsw==
X-Received: by 2002:a05:600c:3b93:b0:427:9f6c:e4bd with SMTP id 5b1f17b1804b1-427b8a559f1mr12081225e9.6.1721135425043;
        Tue, 16 Jul 2024 06:10:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210::f71? ([2a0d:3344:1738:5210::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5ef44b4sm127311255e9.42.2024.07.16.06.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 06:10:24 -0700 (PDT)
Message-ID: <c87f411c-ad0e-4c14-b437-8191db438531@redhat.com>
Date: Tue, 16 Jul 2024 15:10:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str()
 on error
To: Tung Nguyen <tung.q.nguyen@endava.com>,
 Shigeru Yoshida <syoshida@redhat.com>
Cc: "jmaloy@redhat.com" <jmaloy@redhat.com>,
 "ying.xue@windriver.com" <ying.xue@windriver.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240716020905.291388-1-syoshida@redhat.com>
 <AS5PR06MB8752BF82AFB1C174C074547DDBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
 <20240716.164535.1952205982608398288.syoshida@redhat.com>
 <596fd758-11ad-46c0-b6f1-2c04aeba5e06@redhat.com>
 <AS5PR06MB875264DC53F4C10ACA87D227DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <AS5PR06MB875264DC53F4C10ACA87D227DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 13:43, Tung Nguyen wrote:
> 
>> I think that consistency with other tipc helpers here would be more
>> appropriate: IMHO no need to send a v2.
>>
> I do not think so. If you look at other helper functions for udp media, they use predefined error codes, for example:
> tipc_udp_msg2addr()
> {
>   ...
> return -EINVAL;
>   ...
> }

It's not a big deal really, but, as noted by Shigeru, all the other 
tipc_*_addr2str() callbacks return 1 on error and such callback is 
invoked via function pointer.

If only this one returns a negative error, modification to the function 
pointer callsite will become prone to errors (and stable backports more 
fragiles)

Cheers,

Paolo


