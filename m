Return-Path: <linux-kernel+bounces-287824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74005952D36
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9D4FB2C7F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A0F1AD9CE;
	Thu, 15 Aug 2024 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwe+zvJC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657618D656
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718685; cv=none; b=mddLL7b0l7XTh0rx8WVxBFNl2ZZISJtb5heWzReBhxfPhOF3cXEVUSr5eC0ivh30V2JXm6B3hTBzc4HpHmDo9F5t9TzADldRbEowNEoj+6+7r98Ie4BHDMtDy6nhlWstyqDpzGX0u44yvrzbmOhSqGfsUcIMmGgktsUVn1wo9+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718685; c=relaxed/simple;
	bh=y5UiP2q8/9MJOQV1SrXwQK4fg18yzEWE8zm3Mmn67A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OR/Kr92T4u3LUBT+/Sj1GreUT+znurv0rdWOh/f3iAT9lPc3vZXQXm6Y7BTL7MkMcrTX95v5bd+VKNIlpJHqJemiMqyUDULSwjkazIQhVJaA3NV28rdlBsQOSRuauV+npdgZwdsCCFQZBgPj+4M4dz4MfPSMjEE3TaUsKx9NVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwe+zvJC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723718682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0lfhDcNSOUZAAV1h0MPWluOZzgmlLSz6RPmGbaRLpE=;
	b=fwe+zvJCiBdBX4MI5rPabq7ydH5fVMLx8Ip2t6kxstHIz3AuoP26iu3dsiLQpYKT+2cJPy
	RYz/tTbf3UgBB9+FAh4ZE6kuHnByV3fMiPFOhCYaRebxLUvq6NKteT5th2S4SyKIwR1bK/
	9hj4fq4Nie0MYkyKBFc2r4+bke+Kd/c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-zdCKp166MTqdzPSD9tPttg-1; Thu, 15 Aug 2024 06:44:41 -0400
X-MC-Unique: zdCKp166MTqdzPSD9tPttg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4281d62be91so273115e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723718680; x=1724323480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0lfhDcNSOUZAAV1h0MPWluOZzgmlLSz6RPmGbaRLpE=;
        b=CtCK0nFzY/8F9oFXn8OHalg2zw/L6D9FQ76HdsAXWqXEjojXNoe62CNJ4fAbd+x7eq
         k51vfbjiy6NUTOVMFqBd4moMh3kmRYDnWWKyYcQI/H4TkCJzbjrGBEjTDJgCaoTLhl7c
         MAae7cC4FsDxsMdGBoZ5GKgkbNvd1W4tBBUHly9FptlA+K3jFTfHxExKP8pIU6dJNSPu
         7qaYzj/1dCP15EzGDtkKtacRGWjAWX8xDjwMJb2tMdQIe/2ax0zdRjfj0CnYU7m2CAxx
         3EyYObgJH5yZwCAkPGDA2kOm8Bc4DV0TcZ1OoIl9YzbYKGlvStfu5ycxrVTEVzYDmYqd
         GhPw==
X-Forwarded-Encrypted: i=1; AJvYcCWbAfN8Qthyz7zvkfQdqptASqA4AmeNO+lY2cTBCwXV1jBr4sgSRA6yVep6XRU16JAJFDIvNTeUrf5S1ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pSl5BbpgTNi3zomkysfOm2WYYjZbBcXwcj37/bwkfmaIOm1p
	H7Ra4cLxmZjuV8L+cktH62H212T1gYpVkstynCtxUp1pr+3Nb8eVIKi75Z2V5blDcFsc7AnLd80
	nUtFEfEW1aXzr3fXDZ18cxB2S8CzzrG/tiQpRhMg3tdmuKezZcYITnm6GsAIZamPLMGFTYExz
X-Received: by 2002:a05:600c:5126:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-429e6a2f8femr8444045e9.3.1723718679616;
        Thu, 15 Aug 2024 03:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9899v2p/rMSnYmptDuAsIFHfYoVEHGtz5gijcac/bX7qsLvlsDYWzl9qlH11Q54Ph6ftl5w==
X-Received: by 2002:a05:600c:5126:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-429e6a2f8femr8443975e9.3.1723718679098;
        Thu, 15 Aug 2024 03:44:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010:5731:dfd4:b2ed:d824? ([2a0d:3344:1711:4010:5731:dfd4:b2ed:d824])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898970afsm1171164f8f.78.2024.08.15.03.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 03:44:38 -0700 (PDT)
Message-ID: <1df13327-377c-41b7-9637-c873f3c1ddeb@redhat.com>
Date: Thu, 15 Aug 2024 12:44:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ip6_tunnel: Fix broken GRO
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240813115910.87101-1-tbogendoerfer@suse.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240813115910.87101-1-tbogendoerfer@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/24 13:59, Thomas Bogendoerfer wrote:
> GRO code checks for matching layer 2 headers to see, if packet belongs
> to the same flow and because ip6 tunnel set dev->hard_header_len
> this check fails in cases, where it shouldn't. To fix this don't
> set hard_header_len, but use needed_headroom like ipv4/ip_tunnel.c
> does.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Please include a suitable fixes tag.

> @@ -1731,6 +1732,7 @@ ip6_tnl_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
>   int ip6_tnl_change_mtu(struct net_device *dev, int new_mtu)
>   {
>   	struct ip6_tnl *tnl = netdev_priv(dev);
> +	int t_hlen = tnl->hlen + sizeof(struct ipv6hdr);

Please respect the reverse xmas tree order above.
>   
>   	if (tnl->parms.proto == IPPROTO_IPV6) {
>   		if (new_mtu < IPV6_MIN_MTU
Side node: it would be nice to extend the existing self-tests to cover 
this kind of tunnels, too.

Thanks,

Paolo


