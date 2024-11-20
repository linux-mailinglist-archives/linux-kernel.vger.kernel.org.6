Return-Path: <linux-kernel+bounces-415557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F379D37E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C058728522A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF3719F41D;
	Wed, 20 Nov 2024 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xlt+4wX6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07419C54A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096943; cv=none; b=sU45OFYIHaPMcNdnvVYbKqhLuN++U8Mj6mrKDU+pchNNrsxCe1OkUAHTeHC9kPmL3eYoZ4vqcDBlw/r4nQf+yfp4NjI1CNNDIsudnOcNSGcarrD5iuf8h3m2ZCIGZHNHR2S+HzuDH14kjMAsXsnrol7X12TWe5pN838tGTzY6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096943; c=relaxed/simple;
	bh=WnTEXtZEqyDDz7fFBXbqrFdaitOHF4Gb/h2SPWe6guM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMSNBWJkQYVjT5LzbhADnAvG7ouC6+E3i8sJIg2nYiSaERoHBh+gF8mtuLeKEVnlA9QRtGuNWP3G0IwVuSq1Dfl4+tJuzVM4TSfN1Fx9qZ/7K7muMtPl9sHQS4WDimROEzr93rLdvuh41l8wdOWgZyLyYf2Jw78PPc/A92fQ6kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xlt+4wX6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732096940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRZSdKlHsQ9OLHnq7+esx3i440YtlBSJBdUXroQOduQ=;
	b=Xlt+4wX6x58lkJUGy64yiHmxchdefo2sK5/xKkK7a58SC9prc4V5ZTrKOBWJnJjeV0ncYP
	+wdL7rwA6+mTeQNVbFXH43x/4agQeoCcAttSIOlG0vGoHpCiwdJw4ZRtQGUSxhW145te7V
	OVV1wxNl6AADDobktBAV7lHcBYrg/L0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-qbioEr3ZPf6o9lfO2cIZXA-1; Wed, 20 Nov 2024 05:02:19 -0500
X-MC-Unique: qbioEr3ZPf6o9lfO2cIZXA-1
X-Mimecast-MFC-AGG-ID: qbioEr3ZPf6o9lfO2cIZXA
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e5a1eefeeso3138156b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732096938; x=1732701738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRZSdKlHsQ9OLHnq7+esx3i440YtlBSJBdUXroQOduQ=;
        b=eUtGGfjbNU3wW5Zi92wGn6ZdgDWyzSmKFYf5kT73ThsSJtIkRs+UqSgAmH10Ehgrze
         gJUqMyKbdnOrIagUSNaC/m+cLHwAZkiTJ4UDmNQTde00N4N6jGoHN8Hg8ppTDHSvOG6k
         mok7FF8tEEboP0bpV/matMJuX1jM+y0u4aW6bCnl2NP+ERt43/4xPwEXppsVI5wqevmc
         nhjtMp4qI1xT8xoXzCNAk67Tdl1rcpP28JFeVSfaDkGFYMrIZCB0t2+aNDeaFYTwlexr
         ytX5PipsnY117cOhpRwXSJYUYme4RegHbCC7fQWE3G9yEep/QUgdxD9caLTDaIDYiQPF
         Bcdw==
X-Forwarded-Encrypted: i=1; AJvYcCWvqVJtztK4JQfMt45GQUjDfRu7SIg0GC7aSbJn4rR2/oM1o+21aspU6y7R0vqw9QKVNtIDB13jMuDbcro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKbr+r2uL3Ew65hQRkcF2QzlEkAhFhtpKv1+KIWiDHcdHtEgam
	yba7zXLIBG0GJLVV68DQ4Jba5XhH8SC5KKZZ5YHb4P1sXIdPwEG67g8SVEl1k0r9vo6Y3JPU8gP
	F208e1Iya71BDbFYb+9VcECjbUfIfUabfdtmStP8kmDqT/XT9HtmDWg0ZLLqQrg==
X-Received: by 2002:a17:903:18b:b0:212:69dc:dfaf with SMTP id d9443c01a7336-2126a37f40bmr25831585ad.2.1732096938057;
        Wed, 20 Nov 2024 02:02:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAaBU51SY3Boqa8bG2Xb6gOymOvVKgEIvy+s4iqLlUXFYzuNzpBNEMSRlFzLEQ12NB5JCYEw==
X-Received: by 2002:a17:903:18b:b0:212:69dc:dfaf with SMTP id d9443c01a7336-2126a37f40bmr25831225ad.2.1732096937369;
        Wed, 20 Nov 2024 02:02:17 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2126e59294esm8291295ad.202.2024.11.20.02.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 02:02:16 -0800 (PST)
Message-ID: <5f969243-f14d-4264-b3be-bc4f4571bb30@redhat.com>
Date: Wed, 20 Nov 2024 20:02:12 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_balloon: Use outer variable 'page'
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, mst@redhat.com
Cc: david@redhat.com, jasowang@redhat.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241120054920.35291-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241120054920.35291-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/20/24 3:49 PM, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> There is no need to define a local variable 'page',
> just use outer variable 'page'.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>   drivers/virtio/virtio_balloon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


