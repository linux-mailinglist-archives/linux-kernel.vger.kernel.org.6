Return-Path: <linux-kernel+bounces-406124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E127E9C5CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA96BB4497E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AC72010F1;
	Tue, 12 Nov 2024 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DewdC1Hl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC911FF7DE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423495; cv=none; b=lMQRTed1TSMhQjFRHy8uH1lRDKALe0mpKUzUOdQvNOs6ffQLG32gX6DuXrMr5wnnW8sWr/q8N7Md3tqQ8l5FwAjOVYBOebZPos2ixyNlfvNktg8oj/0fmeArGZavZbnPMN48oGmeEi+kmK80mi2Ufm11cPf3dCGpIwi6AfkhLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423495; c=relaxed/simple;
	bh=CbesPWMcsq/ixaskCqwH9NH18vggZMMy8Pa9VlaZJqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/XTK8UVNZpqXRGKVr1hp1KgOILtIxrlbN5NtGBNAoUiHpXHagfPWfpkJ/EJQO8FP6hMG2/UFMjUsAuabg3rsjcdQ/tdXL3Vm7trItk2ljJjyL0qfG974z8Yv/R6fxzpmPq2Bllm64lJIjFjxdAuByTR3FsTQ3beQlAp+VApRls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DewdC1Hl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731423492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/ex2PqhS3gmrriCvN8i7mPF+UeH9EkfP/orKGyBxxQ=;
	b=DewdC1HlDF8Puxi2ONCXe8lBYz099AQ2xaoUHGFhZ5TctlzaI62y1gwWEX7GqRCLXAEZdt
	ciztfDxrCfdLRwZrcyNC/IJJVAkFNMthRr4ryijWWeOswtOTWVafVC1syrjoGWm/8wUfAW
	MEGjZZOEgLByCimjjWRSPKSaTXsSzcM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-qczV_iJVMYasUHmnEfBpaA-1; Tue, 12 Nov 2024 09:58:10 -0500
X-MC-Unique: qczV_iJVMYasUHmnEfBpaA-1
X-Mimecast-MFC-AGG-ID: qczV_iJVMYasUHmnEfBpaA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43152cd2843so38626055e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 06:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731423489; x=1732028289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/ex2PqhS3gmrriCvN8i7mPF+UeH9EkfP/orKGyBxxQ=;
        b=Ikg4wZzZv18FRqHK9wWFKO0jS2LTQ2a/R2X/n1lgYe6CsxtSewM03+J8rBCm9bDOE8
         0XAGHkXjjwsLBVr3kKorlrCXY7T6c4Fxy4qqMeATcHemCV9HAMJqZr/IkSEBCP4ymG20
         bb8OFGR8DvV1HLvaXQ6WojXLZpF6wyAmIhGrGaE/aWXBgD22BINNiMDXkd3rBe+i6wul
         nJXbLCA8DquxmC8uJb3EI9vl/Od2MUZwx926fVzmlRjZVKRnYIqpcK/mkCXBD5M2Bt1g
         NbWXIixvnASXawJzAgfclPxBEaZRqpWqKQynmGPTUSsZQYmdvYY3Eb5jQ8zgPVHDkxV9
         D/XA==
X-Forwarded-Encrypted: i=1; AJvYcCXBi1Nav0PJBTrpGGrcVPIbrjRrim95BN5EnpUhh7Ofr81FXqjwe0VI5o9RuVbdPQjYU6C19Fi39dQqIPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQL59kB5FZXr3ZAaPNF9gByGP5lLNa9B15zDVvowLXy89OCp97
	aAfmOeu79rVqy5XVU5FqPKICNjqx8gtWRk6eutryfFFfMHhrD15ySaQxsSQJRPybfkbBhcfqTTi
	hhFvN/yv88PjLCtodpU6TqjEfXClv07vapwXDA8FnznFMZlSSPc3GB2dQpWdqOQ==
X-Received: by 2002:a05:600c:4e8b:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-432ccdff4bamr27706515e9.0.1731423489504;
        Tue, 12 Nov 2024 06:58:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4W6oYaMTaJeOn4kBkprHQNJ23knllUmAOMJdom3aC6xdXU5F+gTN51CL2IahIO02N5TPyrg==
X-Received: by 2002:a05:600c:4e8b:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-432ccdff4bamr27706015e9.0.1731423488308;
        Tue, 12 Nov 2024 06:58:08 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5fb1sm257523955e9.8.2024.11.12.06.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:58:07 -0800 (PST)
Message-ID: <a1db0c11-38ee-4932-86bc-a397a0ecf963@redhat.com>
Date: Tue, 12 Nov 2024 15:58:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 3/4] ipv4/udp: Add 4-tuple hash for connected
 socket
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org, horms@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241108054836.123484-1-lulie@linux.alibaba.com>
 <20241108054836.123484-4-lulie@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241108054836.123484-4-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 06:48, Philo Lu wrote:
[...]
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
> Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
> Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>

[...]
> @@ -2937,7 +3128,7 @@ struct proto udp_prot = {
>  	.owner			= THIS_MODULE,
>  	.close			= udp_lib_close,
>  	.pre_connect		= udp_pre_connect,
> -	.connect		= ip4_datagram_connect,
> +	.connect		= udp_connect,
>  	.disconnect		= udp_disconnect,
>  	.ioctl			= udp_ioctl,
>  	.init			= udp_init_sock,

2 minor notes, possibly not needing a repost:

- The SoB chain looks strange, do you mean co-developed-by actually?
- udplite is not touched. AFAICS should not be a problem - just the
feature will not be available for udplite. I'm wondering if syzbot could
prove me wrong about "not being a problem" (usually it's able to do that;)

/P



