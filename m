Return-Path: <linux-kernel+bounces-405463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7854C9C51B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300261F2120F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0A320CCFD;
	Tue, 12 Nov 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d97JSbzn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525F20CCFF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403074; cv=none; b=qM2wJnGFIVWe0TFSeleRlI5nG+WrJ8bIqUrk01JgQj7ylQZHJqbmp9XgIq8PaYnSGCdMj184VNWupImYCZLp/VYjKq6SCC9F/Qs/QwneAZvIl7gA9xMsuuCkF5lzZ86xDH6i8R7A3nYPGWM+myoFJgeTmfFMBFZNDD0nFC3f/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403074; c=relaxed/simple;
	bh=zNRRtlMozq1Ozj48r4nNeYVh9O6jV/fhcr+TQIMkblE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjDhguGkZAzoot5MlLUs5lEwOqsqisfe4nSTzgRsNgXjL+HJDQIWenLV9KYlxWp4bZCW+x0g3bXvzLy+r7caooFw7xln+rXA9fEO1XF6aNrcHWqM2oill5dDDLm8jJu+7qcAH5XnGxEsfyxxZDocVExq709Q3lNpPRRUc2ccFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d97JSbzn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731403069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUZmO2vrf7r83bzqg6GoPGcZR6uwpTYKCCT8l9l6ZYI=;
	b=d97JSbznkrRQeu4mdsCS9ndow34DXpm8W9cX3TEDExth7nKFyuYJGoetOzdL0KJd0y6Mw2
	CPAecFdoBslpvymg8wUMxNlGwAdZ360V0wiV34Plr/8Lw84ENJS8/Opgvy49r3EkaGvhMY
	LL20qvB1QhZVNmlEfOIa2tT/D4TlbXw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-euR8pDUCMdm9ze11rgUAFg-1; Tue, 12 Nov 2024 04:17:43 -0500
X-MC-Unique: euR8pDUCMdm9ze11rgUAFg-1
X-Mimecast-MFC-AGG-ID: euR8pDUCMdm9ze11rgUAFg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315cefda02so42139835e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731403063; x=1732007863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUZmO2vrf7r83bzqg6GoPGcZR6uwpTYKCCT8l9l6ZYI=;
        b=YGp3tHmjkV7r2hqRdvmqvxz2AxaCWFIc6RJo6fP6kN0yVFibNqAMLV3ZcToT+GBFPa
         biiyH8fiAzxDCX+B38PEl8XXghOVhHdOITm6fubN8YoGaXmUseE6VE7EOTb3Ix2cjB4N
         R8TMhTZYSJmAv6zWuXmKG1Qc3szBUgb1J7n2jrGt6OoS8IHKoVoYNUcGwsrawk34qUpz
         oO65Sr5Bbayk8OlGIwdrIb3sH9wCRZvbkw0CpWQcQCHELO/9X5sxp77fHY67qVJKsqza
         7ns9bJwsYpXZ2rMe1wwm5wzl4gT07X14s5LNt/GT29n8zR14uBrF2uJpxwxv7+lnGqpA
         b6xA==
X-Forwarded-Encrypted: i=1; AJvYcCUBw5u8FMd/Ko8lrd1Uv1Q9Bv/xkuQmD25EDzefq94qNiaznCo45rWUZRUFMIXtkA4alhAZMtW+Vv2GY/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz8OTKqaO6F1D26h71dZD4FrGhkNpDTfrlXKeusuC7btOVVW4j
	P+N/krX1vwFPeF8nRBOfLdlMRoev4hWKzLELlxKjV1JC9Y1T8jHzzbExh/MPxOOn56AQme4Qoqi
	m2ULLhdSvznjttWRPt/PdGreUU+u/e/lkTjQmGnRzGU4bWf+7S0z7ZWYd1PmvvA==
X-Received: by 2002:a05:600c:35cc:b0:431:1512:743b with SMTP id 5b1f17b1804b1-432b751b715mr124837145e9.21.1731403062708;
        Tue, 12 Nov 2024 01:17:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsEMbxjSuTsRJEpYPVXjdyVvt4My9F/LAOdJf0xB4KchwsKYoZbPB3oV8tuqhizUwJMdOXhg==
X-Received: by 2002:a05:600c:35cc:b0:431:1512:743b with SMTP id 5b1f17b1804b1-432b751b715mr124836865e9.21.1731403062360;
        Tue, 12 Nov 2024 01:17:42 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381edc1104asm15134228f8f.88.2024.11.12.01.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 01:17:41 -0800 (PST)
Message-ID: <719083c2-e277-447b-b6ea-ca3acb293a03@redhat.com>
Date: Tue, 12 Nov 2024 10:17:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v6 6/9] netdev-genl: Support setting per-NAPI config
 values
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
 bjorn@rivosinc.com, amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 willemdebruijn.kernel@gmail.com, edumazet@google.com,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Mina Almasry <almasrymina@google.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, open list <linux-kernel@vger.kernel.org>
References: <20241011184527.16393-1-jdamato@fastly.com>
 <20241011184527.16393-7-jdamato@fastly.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241011184527.16393-7-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/24 20:45, Joe Damato wrote:
> +int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct napi_struct *napi;
> +	unsigned int napi_id;
> +	int err;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_ID))
> +		return -EINVAL;
> +
> +	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
> +
> +	rtnl_lock();
> +
> +	napi = napi_by_id(napi_id);

AFAICS the above causes a RCU splat in the selftests:

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/856342/61-busy-poll-test-sh/stderr

because napi_by_id() only checks for the RCU lock.

Could you please have a look?

Thanks!

Paolo


