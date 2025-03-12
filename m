Return-Path: <linux-kernel+bounces-558093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3623A5E196
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15FC189816C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623BF1CDFD4;
	Wed, 12 Mar 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGaXHurs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F501ADC98
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796068; cv=none; b=Cx8L5VP2OexUVGxkRjzkiBMII/OR80z2RRTmutPo9iQP4AreC/veRp2eO/cRXwJIjD++5DxK62r/Pu7b0DmC/NmQlafu7LabxMoGYBa9oVvjOa5lm+lN3FJp17J6D8zTK1kPEuSCgTTumh4lEdHQo7UcOMx3J7fV4kl2MM998ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796068; c=relaxed/simple;
	bh=+Q8FJLEc/wPqO/B2liJt5338+n1p3oYveSEAcS0Q17k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sa6X5r0BNJi/viK3aKwevsvxis+jx+YNFkg/pnJqxUJgFYAGMPeF53L3QY37aCpYIU1i7kSqg+wxozUYTpaqj8CDgLwJonJdy+VGFK+jQCbKHyiRn4i9Na4mc9KLZjFPzAlb5mJG1aRDJY4tU8d74bk2hOMGyGNj+QrtEP3h2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGaXHurs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741796066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pEyG5Mxc0jKLdEJ3OuRdni2VEk2vhW/ID4tTAR/EGKU=;
	b=gGaXHursk0QUN8Uqjw/T3RtXCnjV1/Y/2q8iiKAbFcAnaQV+qEHce8IwSEQRs6oyQJvIhP
	hYFE5rM7qOg+0q4bltNZ4sw3WfimP78f44Wuq9v2/YQV/5imGRDSoW6OK5CQ2THjcCV1B5
	VhUD4TctuyMHvMHaSSoCo3N204Ollpo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-VbsWspzNM6irAak4g75EIg-1; Wed, 12 Mar 2025 12:14:24 -0400
X-MC-Unique: VbsWspzNM6irAak4g75EIg-1
X-Mimecast-MFC-AGG-ID: VbsWspzNM6irAak4g75EIg_1741796064
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43947979ce8so32288605e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741796063; x=1742400863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEyG5Mxc0jKLdEJ3OuRdni2VEk2vhW/ID4tTAR/EGKU=;
        b=e3cq8107Gu940regsD9PPssYnzP2Ad+XZ8lLToFk06D0baX35ZiMEQNc+baar59w6U
         l6JT10e4aZONF5Vr1OEyskJOmKPihZTvoOiAUFaQp2GLwT/+bWOFtT3+AmP+62aqwtun
         gykdKr8fk0OmYTlKnKGMYRQH+DXf6N59TYasH8eEQjkp1JbmaaB6ThC1mphWz/KusK3S
         ia6CzY8j2bXLtV1QhPUX+9KZgtXqo87Yfusi/1apWADyJj/wOu7eyeyZnw71hS/FbJjP
         o8HIQ86BnnGX1v2TB1Udjg6irhzZUXt/NZ7z29WdDGgtXQwnm4bbzuIu/6XQXShZ0hGU
         qghQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHUM36qoi8/5pa+DklVXBavKk25GrPLEdXY9n+aOwFZ04yCAXFnpABqwJL2CaXPLEr1crqxmMmszGCCD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMQEABoJ9n6YsXjsp9Pp7AdN/nSppUB76KplRwzmT8+syeEx6M
	hHt1qvUD+wyGxljDYtIkuqOjHM77HC2h7I1PRS0gfHk7eZvlMwu9sssFPifw3CSGAsArjZCBGme
	42Ri2azPOFhQUa0xwZViZ+vif3f+FObveLKcQtCGlWgjxFgbzIaufgj5sI18EcA==
X-Gm-Gg: ASbGncvnEiwzuIFh3jkZMfDOtuocPa3Yh2BGQ4QCxj6rnvHPXaZ9B0pBPCbQUV/0kk4
	vyGRKhh4bttL4R6OxIQ0rBYkylmdmTXI0vTsxM24uZrTvJqCOoEU53Atqz0C0wiZhbr0aKb1SpN
	/guBjXo3qlVy3KI1l43B89obECTCEKyLR9wQfo4L1IDXp4jsPDUc9yw4FtGi9eZMDL1mFAZbJlp
	oNkdp6PeLGLspbIBlZTth3SeVs3gDM2HRowjg5+qBBj+nZSpo+JtJxMFeXNNzcoS+8teE5cU/n4
	g8nAIKL0H5eAsQdN70qMpcWrFOJijb2WmQZDBaMRAF8=
X-Received: by 2002:a05:600c:3b91:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-43d01be6394mr97601795e9.14.1741796063617;
        Wed, 12 Mar 2025 09:14:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECYcAcLHlbX9xrFOI2TA005+2AV9F0TRMF2ShumfHr5Inuga9Bh7rrpQaOGh8z/bhmcrxkdQ==
X-Received: by 2002:a05:600c:3b91:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-43d01be6394mr97601565e9.14.1741796063267;
        Wed, 12 Mar 2025 09:14:23 -0700 (PDT)
Received: from [192.168.88.253] (146-241-6-210.dyn.eolo.it. [146.241.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d031d1438sm30002395e9.0.2025.03.12.09.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 09:14:22 -0700 (PDT)
Message-ID: <0b1cdac7-662a-4e27-b8b0-836cdba1d460@redhat.com>
Date: Wed, 12 Mar 2025 17:14:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net: Modify CSUM capability check for USO
To: Radharapu Rakesh <rakesh.radharapu@amd.com>, git@amd.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 kuniyu@amazon.com, bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 harini.katakam@amd.com, radhey.shyam.pandey@amd.com, michal.simek@amd.com
References: <20250312115400.773516-1-rakesh.radharapu@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250312115400.773516-1-rakesh.radharapu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 12:54 PM, Radharapu Rakesh wrote:
>  net/core/dev.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1cb134ff7327..a22f8f6e2ed1 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10465,11 +10465,13 @@ static void netdev_sync_lower_features(struct net_device *upper,
>  
>  static bool netdev_has_ip_or_hw_csum(netdev_features_t features)
>  {
> -	netdev_features_t ip_csum_mask = NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
> -	bool ip_csum = (features & ip_csum_mask) == ip_csum_mask;
> +	netdev_features_t ipv4_csum_mask = NETIF_F_IP_CSUM;
> +	netdev_features_t ipv6_csum_mask = NETIF_F_IPV6_CSUM;
> +	bool ipv4_csum = (features & ipv4_csum_mask) == ipv4_csum_mask;
> +	bool ipv6_csum = (features & ipv6_csum_mask) == ipv6_csum_mask;
>  	bool hw_csum = features & NETIF_F_HW_CSUM;
>  
> -	return ip_csum || hw_csum;
> +	return ipv4_csum || ipv6_csum || hw_csum;
>  }

The above will additionally affect TLS offload, and will likely break
i.e. USO over IPv6 traffic landing on devices supporting only USO over
IPv4, unless such devices additionally implement a suitable
ndo_features_check().

Such situation will be quite bug prone, I'm unsure we want this kind of
change - even without looking at the TLS side of it.

/P


