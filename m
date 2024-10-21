Return-Path: <linux-kernel+bounces-374142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365589A654C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C02B1C22352
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292B61E571E;
	Mon, 21 Oct 2024 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0jSKisC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54181E573A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507784; cv=none; b=r4E/FOrKqv0Rr6I1pTTvFEb8S8HJMvRhGLevD6VW3WRHYNZKNVV00xG+dXvKRPs9svqayG8e2IbNMYxHhC9+3dJN3qdwryydcQVhwTClb9q6lJkbNWUiiRG7N3zqnq42z6UI8lcQUIQ/YghmCfr6zrnaOR6aecd4Ee5fzA2eQMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507784; c=relaxed/simple;
	bh=f25VOJ4jl4EZ6U5b3xJzeqopBjiOxy3HcpyoNBkD144=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ccXLf+VUNF6EPKnivn4hwZlCyS9kplcyOnADYqdB4Xqoye9ommZ7LoL2f9bchqMGeYzM0/AqN3pAl08lX28zhFbtWy6PaQed1l6kaYVTWshoVIRJ4WKREZA29EjV//j0PTP2oBjYirP8+Yrk9S0cdd4u5tzDngd4GuwduwHQ49Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0jSKisC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729507781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl8NkxhsjOVprDoWW2Qzq8vxlGshkjvvdBctdUvmGdo=;
	b=H0jSKisC9yyRt7OQjMywdI98DZofpkSElVQYwVeVkKJFZbQtWW9MG8tnIYCGgiCsjdO+3/
	RXDYgtHIqmJQz4OZRqeE8wM3xsSqeTSbOJhMdayhZyvhyD3iTIakqgHVRSfO3W7apaGwkM
	ERAUr9rHEeFAIDnfa4KRqhwf8nHbgGQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-4PEDCWWOOlCaLI0yZ-QTfg-1; Mon, 21 Oct 2024 06:49:39 -0400
X-MC-Unique: 4PEDCWWOOlCaLI0yZ-QTfg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315afcae6cso22706455e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507778; x=1730112578;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zl8NkxhsjOVprDoWW2Qzq8vxlGshkjvvdBctdUvmGdo=;
        b=ru77BjLFhWUrIlDRyc9Qq2Fw9Ia6HEL6QNOR5zLujKcDOFocJdnQZuX2jmGYKphDYc
         rvZahOZPpKZU0Nd1LUdZmlrh/Nv+CkPK2G96GCDRV007aN70LLt0YPiLO7T7LI25O9sd
         vmn7+38ZFtYtIUQH4v2bz/PFnVWMbP3qBpdHj3D9x/V4FtBAPv9vqrOJkqHT3+I0qWbs
         LKn07y+vjkUu4EvGIC5Biow5EXSgzw72QXWomNQggIg0W0QCNurIc1iKdMEs/CzstF1M
         X6+VPufTbJ95FlSpuaXsCIeGFShDmReEwQZLyZhtQ8Edu72/L6ZI8y5ZJodD2As0aicD
         dYmw==
X-Forwarded-Encrypted: i=1; AJvYcCWMeEF913ICS/C+ouI452qF4wQMlq06igbYtcE1i5rBXM1FOlq+ZAzUAWYBCQPZ1sx2GmRwW7+/lZe/tYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhmnHoU5vHtYBN+NYMimDV4MKCl5vHzg/Oo48BjiaE0EbBv9+X
	8zoXTFFWfEqRD8qOtsxrjFSJH7pBgsbfxhRfGelzIt2wQGYSoESdX6iYj8G/YlZ2dkKS8d+JXYR
	HeUF2YvLCr+Phiu6bQ/pISA8va/IFQhk4lUZaOwrcfSScpVpTBRuKiseBEjAyrQ==
X-Received: by 2002:a05:600c:1d27:b0:431:44aa:ee2c with SMTP id 5b1f17b1804b1-4316163bb0bmr68211825e9.9.1729507778224;
        Mon, 21 Oct 2024 03:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPmc6ba7ssou9GTOtZg5r3s7a95KOOzPAX+9aC1kAiYD6uc9w3/zs/WO4t3sdTFuEXumAz/A==
X-Received: by 2002:a05:600c:1d27:b0:431:44aa:ee2c with SMTP id 5b1f17b1804b1-4316163bb0bmr68211595e9.9.1729507777852;
        Mon, 21 Oct 2024 03:49:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c2cb8sm53805945e9.31.2024.10.21.03.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:49:37 -0700 (PDT)
Message-ID: <f792a828-8a61-4a14-bef8-ff318b5a4ac3@redhat.com>
Date: Mon, 21 Oct 2024 12:49:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/10] net: ip: make ip_route_input_noref()
 return drop reasons
From: Paolo Abeni <pabeni@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com,
 bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-8-dongml2@chinatelecom.cn>
 <c6e8f053-32bb-4ebd-871b-af416d0b0531@redhat.com>
Content-Language: en-US
In-Reply-To: <c6e8f053-32bb-4ebd-871b-af416d0b0531@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/24 12:44, Paolo Abeni wrote:
> On 10/15/24 16:07, Menglong Dong wrote:
>> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
>> index e0ca24a58810..a4652f2a103a 100644
>> --- a/net/core/lwt_bpf.c
>> +++ b/net/core/lwt_bpf.c
>> @@ -98,6 +98,7 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
>>  		skb_dst_drop(skb);
>>  		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
>>  					   ip4h_dscp(iph), dev);
>> +		err = err ? -EINVAL : 0;
> 
> Please introduce and use a drop_reason variable here instead of 'err',
> to make it clear the type conversion.

Or even better, collapse the 2 statements:

		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
				   ip4h_dscp(iph), dev) ? -EINVAL : 0;

There are other places which could use a similar changes.

Thanks,

Paolo


