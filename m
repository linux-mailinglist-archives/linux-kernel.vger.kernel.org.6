Return-Path: <linux-kernel+bounces-536612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFBDA48213
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CFC164027
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507DC23F267;
	Thu, 27 Feb 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYdYQIzI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6A7239082
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667199; cv=none; b=TiJ8ot73rx/kCpc8njG0tPeChdaNLuZDT9fxyET5GFNoMMX2AutJVxsOnizsojYA63BN4iIhhHzWQ8zVvcjXpFo1pdh/ehyCT56jnyV4nxlvng3b80ijXsZsqPYvkd8npCiSHyzrVZgQAQCxCw9h2u8N9Q64PYdXcRyTM/phja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667199; c=relaxed/simple;
	bh=3HNj2lcv7MZvcwGA/FLxym27Q2rgYaCGFXQoXk1HxUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyxQ1CMNIYnjz5Vu0mFi3beN7PGp8lYRpg0yEK4z+ZRYw0WsPhg9//+J9zNt8kvxxZlb99EIy/x8/sXSXYuhgQtIsbfVLcUBTs+Zz0KkCpOl5nBNOn4box85kQwsBM9gCPtpyQD5l0AHGFjKdPRFzYwDOT/tgUy+cowGTVU1UuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYdYQIzI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740667197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyqUBZB6nKc/r+VKm621tlxSSaBd845l3542H86vZ7E=;
	b=AYdYQIzIu6gczQSz3f1wWqhXMQv1Fq6U8Fp+yVJfWtcw4JELv53h2bgYDGseVUydbbbT36
	ClUvy5y/CtYf6X2gA2J1zSsMtmmea4HiY+FwyOL6tdt92l+ZF9aggxViAgB+BN/vxNppDa
	Uxg4DjT7Hi2SkNpPxdvwIoETHzPxwgU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-uLiyrFC3OWyFmuO2vyFGKg-1; Thu, 27 Feb 2025 09:39:55 -0500
X-MC-Unique: uLiyrFC3OWyFmuO2vyFGKg-1
X-Mimecast-MFC-AGG-ID: uLiyrFC3OWyFmuO2vyFGKg_1740667194
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390d5f1e05cso393389f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:39:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740667194; x=1741271994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyqUBZB6nKc/r+VKm621tlxSSaBd845l3542H86vZ7E=;
        b=oIhHMTAZnGgFkyiY7gcR5o0s3ytbJJJbPBnBlKP4zkEqqKGGfMFglu59rrIvjKnKBX
         OWu+Fw3E3VGy1V044OH8cDmDLAW6FtUlgeUs37pUlAiygLJijb6YcwVr3PtCfESB2tSg
         uva5HdHTub/P3ozpXVxcA2A3utAHP8MVjrNlrOyynPL0lHOoZE6RWBjmH1byM2kNS5K+
         Acsr8Y7frNi8o0KUMnp7/6KtVMKA0+sHuQE7aIiRrXVsaOHa4ciya4ZrcaEJT/+5oaRn
         Y4lYFtgXuN/3TaUquVoT1nNAMx4/7vpfVBgsJWSERkFBeQODBjurs+vTVObCRDf7uJZ0
         4lLg==
X-Forwarded-Encrypted: i=1; AJvYcCUQar/H85712X0sdaOML35hYl94CWP0qfMBt5RRDMmnzPU2FXPewBWULVJb8MdN8jVlFxX+3JS2uE22Crg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXXCNqiGoxP7+edacS1FYRNWf3CPmcIFAKIe9x1y5L3tQfVM9E
	Sg0FIzEe9yvLg/+TOy0HrOxIa4SCGAYDt5FIaMAoAUClD4vzcq+aDJkyBtjXOkXwxb2GNsIUco7
	1EJV6gPqS+I/oIbVcf8zsrkprnWylvFzW+FcUlSWQ564A65dJ8ONVcR9bueMsm8GW0WT6qQ==
X-Gm-Gg: ASbGncvH+HXvWXb8aLAkjwyX0tfiP2Vii7jwS61xdbOOvfsUf7WHQaT/VP/5BEo4Ab8
	GDnUv6XIRl3tMNGc7uOdLFQBfzxITEhruq6EYwI8FWM3cthTR+Jg9mOeNUmO1G9JhBFxak4aXim
	q92Ysu/9ro76R3x+b9rA4AtbEiYHlSA3zIxTkvTBfb6hi2M7XDxhpaa2vI21cQ9lN+ZFwQ3QCxq
	1S3L2ry3LEGp0A/aRzeyTp501lHl/xKAA2EQyMQoCV09+G9fDkv4wOSXZ3jiDvvthZJRIOUa2O8
	i9q1B5EEKSQnuEXEnQoAAlnkj9s17ZHFKx4ajRM9kdhM/Q==
X-Received: by 2002:a5d:5886:0:b0:390:d6b2:c74d with SMTP id ffacd0b85a97d-390d6b2c8e2mr5688443f8f.35.1740667194116;
        Thu, 27 Feb 2025 06:39:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcWa/eBKcaZPmm9VXX7NkW/71dFoXSJxP3YfdCAmJI+JSIQx4UhJs1j3Idz3PrIeHcoy0Y2g==
X-Received: by 2002:a5d:5886:0:b0:390:d6b2:c74d with SMTP id ffacd0b85a97d-390d6b2c8e2mr5688418f8f.35.1740667193800;
        Thu, 27 Feb 2025 06:39:53 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7b6asm2336666f8f.51.2025.02.27.06.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 06:39:53 -0800 (PST)
Message-ID: <5913bf70-de74-4915-9ba1-9cd92dde6945@redhat.com>
Date: Thu, 27 Feb 2025 15:39:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pktgen: avoid unused-const-variable warning
To: Peter Seiderer <ps.report@gmx.net>
Cc: Arnd Bergmann <arnd@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250225085722.469868-1-arnd@kernel.org>
 <20250226191723.7891b393@gmx.net>
 <4c260b13-3b08-409d-a88a-e5bbb3c18e03@redhat.com>
 <20250227152154.4da61f2f@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250227152154.4da61f2f@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 3:21 PM, Peter Seiderer wrote:
> On Thu, 27 Feb 2025 12:35:45 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
>> I think the unused define is preferable; I think pre-processor defines
>> are cheaper than static const.
> 
> In which regards cheaper (out of interest)?
> 
> Both (with and without static) produce the same code see e.g.
> 
> 	https://godbolt.org/z/Tsr1jM45r
> 	https://godbolt.org/z/6sr1o8da3

I must admit I was unsure the compiler would always optimize out the
constant.

I guess the macro could still produce shorter build time (by a few clock
cycles, nothing measurable ;), so in the end it boils down again to a
personal preference.

Cheers,

Paolo



