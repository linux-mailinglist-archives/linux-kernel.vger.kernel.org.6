Return-Path: <linux-kernel+bounces-267701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DC3941489
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D6B1C23154
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C7F19DF41;
	Tue, 30 Jul 2024 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOnRZsl6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971861A00CB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350240; cv=none; b=Jbp5MI+KiCkw8GTNjFea5Coylvm+g5VKtC+ksycM7YwxWlaD8S/toGBWxwYR5To1zSeJyazrGCHef3R35nHYkf7D3AuIeeVL0uaTx8MyACzHDcOG2jgXm9zAjMLmak2AbC3fw24QseY1vUW4+NYn5mfEfuaASR2rJVbpssApU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350240; c=relaxed/simple;
	bh=2220mRmsBdPbnrlH0O3ngRVroC/gqpFoARwG7spPtF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TESNiAc8E1RZKyv8ZnA6D8lhS2Elhu9HMYUXFsRBfRl/nLw/5Pha/jZRQUTjNlfaZx+tEYcjBK3+3SwCkGtkdmUIRK7R8ytDLwdQUClrC00cmPhMuZOBOJ6i+gEOcMp8NPYTecU5CDEcfQPa3ruPCRzqweBiCpTUgs3jvCp2JuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOnRZsl6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722350237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikljcTHexIDBMyNR92pUQ/YO+yhTveDLqi0ZIqDt33w=;
	b=AOnRZsl6mFC0Aj5Z3c/g8HqEYidrhik3/5KDeKgnfPKg/cWu+UFHfuWAo8itRZ65mhvuYF
	yalDzvXDtTIi3YGjh8HfE+AL+wu2OTlKe/LtU6G+ezbu3k/RZ/j81bEe+NCs2w45RzDIxZ
	sCnM3VA12dRi8mGeNlIVUv1mB1aYdkg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-CpUN3kbVNc2K_Km6_3WP2g-1; Tue, 30 Jul 2024 10:37:15 -0400
X-MC-Unique: CpUN3kbVNc2K_Km6_3WP2g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42818ae1a68so5239775e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722350234; x=1722955034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikljcTHexIDBMyNR92pUQ/YO+yhTveDLqi0ZIqDt33w=;
        b=Gt1LgJ7C0du9nGczQ34PK037jsD9FrAcsGjqUrDsPZu6cN0z/rwGkng8a35lZ7BCyJ
         V2f0NxYaTldhQH6E9n/uSmcld2pY+Lhp/bKJ2hc4oGNGrGdAofyHPpUtvRDHzxdMToEA
         2ozqrJVBS70TaQ77B6mmKeHi9uJuIc0txSaho0HnHu1MKkG1Yfv89sTI/TS+cXmkQAjk
         yk3EdivF+O4jgVAGj9dHn+2AFRCeuFDEdT3EJ0eaE2ltQYQDIDwOjo4rFGxUzUajImIC
         /3sYn1t6jOn9wAe+ei38fm+NrLAnuCnQiKGuA4/gtuOBNkGZKXbnBAqlP+fkHADyy+UI
         GzyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi2eG3UXmr3LacZOI3eu/P6iSpI63Q/Ain4LzplsjiTy8O0JsQqnme2sXqywj5avtD0MOPbTI1oUolhus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZevDp0PCScMIeCfK4AmUew+8+mXkt9N6H9c5cgZvq039fNS+F
	Ftspv4VFeN1fk6l9l2tg3tjHCLqbTR/JvOq3u1+ZaA2PHRXtSdiTs6eBmEOIcCjuKLb5dOSTK8H
	AXq+zWMeDjshscmRFiGx3rXn40pZiU+8kVRr4WkFPzKn+BZMmtMy/LTAt8KjEIw==
X-Received: by 2002:a05:600c:1c2a:b0:427:f1a9:cb06 with SMTP id 5b1f17b1804b1-428053c9004mr79505695e9.0.1722350234008;
        Tue, 30 Jul 2024 07:37:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGjutbFZQsLRkFpS+PdV2H7EJeGf8aKRgk1uyh7gUQm72atjOR+MfaZHQlc7AFes2qCJ6LPw==
X-Received: by 2002:a05:600c:1c2a:b0:427:f1a9:cb06 with SMTP id 5b1f17b1804b1-428053c9004mr79505595e9.0.1722350233418;
        Tue, 30 Jul 2024 07:37:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410::f71? ([2a0d:3344:1712:4410::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42817d2d29esm107198425e9.35.2024.07.30.07.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 07:37:12 -0700 (PDT)
Message-ID: <16add5c4-b1c2-4242-8b71-51332c3bae44@redhat.com>
Date: Tue, 30 Jul 2024 16:37:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: skbuff: Skip early return in skb_unref when
 debugging
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, Breno Leitao <leitao@debian.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 leit@meta.com, Chris Mason <clm@fb.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240729104741.370327-1-leitao@debian.org>
 <e6b1f967-aaf4-47f4-be33-c981a7abc120@redhat.com>
 <20240730105012.GA1809@breakpoint.cc>
 <c61c4921-0ddc-42cf-881d-4302ff599053@redhat.com>
 <20240730071033.24c9127c@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240730071033.24c9127c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 16:10, Jakub Kicinski wrote:
> On Tue, 30 Jul 2024 13:15:57 +0200 Paolo Abeni wrote:
>>> I was under impression that entire reason for CONFIG_DEBUG_NET was
>>> to enable more checks for fuzzers and the like, i.e. NOT for production
>>> kernels.
>>
>> I feel like I already had this discussion and I forgot the outcome, if
>> so I'm sorry. To me the "but is safe to select." part in the knob
>> description means this could be enabled in production, and AFAICS the
>> CONFIG_DEBUG_NET-enabled code so far respects that assumption.
> 
> I believe the previous discussion was page pool specific and there
> wasn't as much of a conclusion as an acquiescence (read: we had more
> important things on our minds than that argument ;)).
> 
> Should we set a bar for how much perf impact is okay?

I think that better specifying the general guidance/expectation should 
be enough. What about extending the knob description with something alike:
---
diff --git a/net/Kconfig.debug b/net/Kconfig.debug
index 5e3fffe707dd..058cf031913b 100644
--- a/net/Kconfig.debug
+++ b/net/Kconfig.debug
@@ -24,3 +24,5 @@ config DEBUG_NET
         help
           Enable extra sanity checks in networking.
           This is mostly used by fuzzers, but is safe to select.
+         This could introduce some very minimal overhead and
+         is not suggested for production systems.



