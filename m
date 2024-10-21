Return-Path: <linux-kernel+bounces-374147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834019A658A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45343283252
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F521E882B;
	Mon, 21 Oct 2024 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJ3bezE2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7131E5709
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507977; cv=none; b=RuoVYgPkn7eNyaypGZbo/VVQD2WIiLqt1424tSj70ls9QtyQ313CJtLSLVu8s7WEs78V5JjHDfuO5rxJXNIq4RwrM+aQO+Yuxwnc1NkzzPTMwiZbMFcDqOrFHljS6oCE5AdWIBTLrU7IXWqTVdKEDexN9AbDSCayEl2r09J1EEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507977; c=relaxed/simple;
	bh=XV1S6Zw+g3mH55uWg3ccT7dNJYp0UXWhsGtCGN4+4GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoYpugA74S1RAl23APn810M9FA+hEWgnPFaeR2bH9BbA/tEaUDM6kE2dbJ7XqrCRn4Iv6UhG98pN6KKmUZiQrMnOKXyC6PN78tFnteWeCxG2tqoipODKa2hmA0auotJUx19M4oMJILXL8Sd/+osTgghVFSbX1t28rPfeaMNHWiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJ3bezE2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729507974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Io9Wjovsf8+IWCVdGDtutv8zva9MNZWk0eG1/vRQng0=;
	b=HJ3bezE2qJhLpENxlwvDobDODtHgQWFjLM/FW5w5YT+H9JINy31H70wO6wC3TejSN7K8BN
	DcMd1Fn43QSK4znLgdsh7I/hoYof660S2u2sc/B5itHYG0qFqo174CQzoBE0LwMjgW2aXw
	gfXFcL6MGVYLGJgrtY2zy/VYDDcdUvA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-xk2gl6pnMvaO_3jbIMoI5Q-1; Mon, 21 Oct 2024 06:52:51 -0400
X-MC-Unique: xk2gl6pnMvaO_3jbIMoI5Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5ca192b8so2290531f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507970; x=1730112770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Io9Wjovsf8+IWCVdGDtutv8zva9MNZWk0eG1/vRQng0=;
        b=KWop/sJolJrtXVdEugDBGBh60blbwIoORGwJgzlo4dQzVhHHkAkVYJHhAP7O93vQVV
         KU5Ct+i3rAf/A0lNxh6I+FU2LXwOCdzBW6OJFBkIUwIrpNbJeIhyfQLnBOfic+jOM7fE
         XrC2V50iO38xbjn1Q0IKyWkzEPZCRj847P2I4YiCPzk/nPG5o1aaMrDHe00YgH0EfPp0
         9M+Nm/DBwgqa6iEhFJkSj03flwtS/RHeUF8hgVBjUDWbSmysg1AO9xeuEDnCQFy2r1Sv
         eoS7xQzc7HeiZAjXnZduged/67cT29OM4Z/tmPxAZ2J8JxHISmAgrZZb8AM7oPpAbC83
         6z6A==
X-Forwarded-Encrypted: i=1; AJvYcCUSgkh0XAO7p+LOLzkvJHUN+uTk4f4P9srjhYhxE8dPzeu3gs01sKQGT8uPyxWAEYEa7GDjK1SMTrY3y3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9D7mZn8DMETOMLDGoD0C1aFIJR9y7IU3LMQhoXLHxwVFNe6lE
	7gNxhqNimxGCWVoPsqbnkXYRd2QJEzBfsUKRUvlv+3jwkLNDcIB5/i1WX5vOnFMG/4dRCjFF0Uk
	U4CmFwapZvlZKAY7ALBjp3fJVBWfr3atgNw7GyiGPOyjzGK0eD4/8tkuyWSt97Q==
X-Received: by 2002:a05:6000:183:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37ecf08650fmr7003028f8f.29.1729507969839;
        Mon, 21 Oct 2024 03:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdA0NxQjeMM/mp9d3cx0ocUBlXzwmAevgDKmJdOzzdQKq8l1oOAE/WjVMpBUAWAdDgbNEdlQ==
X-Received: by 2002:a05:6000:183:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37ecf08650fmr7003008f8f.29.1729507969505;
        Mon, 21 Oct 2024 03:52:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b07sm4065797f8f.1.2024.10.21.03.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:52:49 -0700 (PDT)
Message-ID: <20d9ed5f-abde-43ee-854f-48a9f69e9c04@redhat.com>
Date: Mon, 21 Oct 2024 12:52:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/10] net: ip: make ip_route_input_slow()
 return drop reasons
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com,
 bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-6-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241015140800.159466-6-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 16:07, Menglong Dong wrote:
> @@ -2316,19 +2327,25 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
>  		err = -EHOSTUNREACH;
>  		goto no_route;
>  	}
> -	if (res->type != RTN_UNICAST)
> +	if (res->type != RTN_UNICAST) {
> +		reason = SKB_DROP_REASON_IP_INVALID_DEST;
>  		goto martian_destination;
> +	}
>  
>  make_route:
>  	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp, flkeys);
> -out:	return err;
> +	if (!err)
> +		reason = SKB_NOT_DROPPED_YET;
> +
> +out:	return reason;

Since you are touching this line, please rewrite the code with a more
natural indentation:

out:
	return reason;

Thanks,

Paolo


