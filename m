Return-Path: <linux-kernel+bounces-294146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EDC9589F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7161F23BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727EE194A43;
	Tue, 20 Aug 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3Rlww/5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7061917E2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164761; cv=none; b=kzJi5axHCbltbbdhsuR7Z62N7ZGcgyEkgcaM3LhT38S/l6r7IqHB7OsSeyyM54EozjovQV7/J6wxXLtuXzwl3zOK8aaNCdQKSzZLSHMSBkCf3TNAVOQhnAwkC+lKntC/SEdCK+y8gAS0eeu4HnpU/q5nCjBn0FPZutloXm7wj04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164761; c=relaxed/simple;
	bh=/NdT42okpHOiqlIfJSqwHOmrwJED7voJb2U7yaSUO1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7PAuPsvugRHZEHKZdzpF8fMvNslt0FRMEHTjrVosGxEI7sReRjjU7F2oVRNZ+IOF4sCaafC7WZSQvHOsi3rn/MmEQyoXfCxmirl0cC1RTXp7qpz7KA1+9MVO/QrqTy8ZfQ8obp34RwNXX+qrOQcWN8MUHjYEVbPnr21rjGnuhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C3Rlww/5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724164758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9o2jO9JG8Ditg3waEPX+ydvCsxasOhVLSp9JM/887tc=;
	b=C3Rlww/5YLIab4WJsacTPxHaY+jAV0HprsrdaDKojlODJt3gDH6l66GWaGHBSbL2bJQbUS
	hoe3XHe8dbuh0eJPepiD7OaPrt+ykicroTtWE8B/J9mJLSFBQJgnNAcPoFvSqmbKSmfE/N
	mn7XRFkcSuq4DTWYuYixxXNk48maGYE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-bFm2CZCDOd6YsiyA1WYQ1Q-1; Tue, 20 Aug 2024 10:39:17 -0400
X-MC-Unique: bFm2CZCDOd6YsiyA1WYQ1Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42816aacabcso47576235e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164755; x=1724769555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9o2jO9JG8Ditg3waEPX+ydvCsxasOhVLSp9JM/887tc=;
        b=nUCdpqert2rWUOvmHHZcNbAvr+PTX9ETgnc95tBmiEOc1QRB9jxfWrnSIOH9d8tluE
         ZHJlaHHJDsfEFoagtTY12fqcAGo+Hp6QEDJlnUWDgdrzp5hBLuLFfNg/vtX8tLij6KlA
         2xy/FvxeBArN5nSdYAk/lO23F0fbhrlbLCxBLzFvH3HrjGtOBYcXNpWe/0sMyxCbJOn0
         xF1cV+HsN6moCqyVywsQxUuz1RukfMMCbgtfHXh3kCN/BoMj5hdjedbwhWCuinrWL0XS
         Vn/9X/8eKwv3n38tuPxUjocybjArNZiskKN1UaVRFJfm2XQXg1fG+oF7iD2G+3JQdCNP
         q/YA==
X-Forwarded-Encrypted: i=1; AJvYcCUoQxDBi9Lq393cP5dwKaMQ51o0I3xf+xgigJo1BgiOUS+Nwz0RfbrZUNF4rTi+j/Iy1IUYhMEoJwak9ehEpPiK+e9jSQRhsR/dF0Na
X-Gm-Message-State: AOJu0YxPL3CEnv1Pz/ddqIegxFV0aHcaX93yi4o11v+JPP+aW0XtbVrU
	Lxzn3I53VZPOQ+6cCTgQVq/z34p8wx8UNY3JtoX5wQDvGc4bdqEJkMStNqjRtM3S1LUer1y6MhQ
	LJOfayjcaa0kGegCSKdC6PSoUA9yTzSlhpJkkZiTqNPpfiPqjWWd1zeih98Oqk7UhaXonPb5X
X-Received: by 2002:a5d:6e43:0:b0:369:9358:4634 with SMTP id ffacd0b85a97d-371944494b7mr8476930f8f.19.1724164755486;
        Tue, 20 Aug 2024 07:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEALIHMDhUvuHOiCKTLB1vv4DrGvTyNghz205rQvOn1wlGGsHUURB8mAgaJLU083nu6KRBOAA==
X-Received: by 2002:a5d:6e43:0:b0:369:9358:4634 with SMTP id ffacd0b85a97d-371944494b7mr8476910f8f.19.1724164755057;
        Tue, 20 Aug 2024 07:39:15 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10::f71? ([2a0d:3344:1b51:3b10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded19839sm203922885e9.6.2024.08.20.07.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 07:39:14 -0700 (PDT)
Message-ID: <eb974002-efb7-46a7-9292-43dd91812b32@redhat.com>
Date: Tue, 20 Aug 2024 16:39:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] examples: Fix the wrong format specifier
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, edumazet@google.com
Cc: hawk@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
References: <20240820032644.3240-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240820032644.3240-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/24 05:26, Zhu Jun wrote:
> The format specifier of "unsigned int" in printf() should be "%u", not
> "%d".

You must CC the netdev ML for network related patch.

The interface index is constraint by the kernel to be a signed integer, 
(with non negative valid values), the '%d' format string is IMHO 
actually correct.

Cheers,

Paolo


