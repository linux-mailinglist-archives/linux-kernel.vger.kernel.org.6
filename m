Return-Path: <linux-kernel+bounces-293725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295C99583A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B081F246B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72A218CC10;
	Tue, 20 Aug 2024 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WktwnWSl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF93B18C924
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148491; cv=none; b=jVHZm01WSad78wHrYiL9uJ/49ntLqwm2zxmQSBvtn4A0YK5+gG/qMoNvhf7MbuUYyaZxApvwjfm5dyLrr0SKbjR+pRbDjR59ET6Oqfnoil1VH38lhmN0Aew59oQrrmaTOYrFYZaZgP3eLONF+J0GU344GJ7yUzhp0nUaSXmBL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148491; c=relaxed/simple;
	bh=xUNoB3mnoowLOxfgP9COqnZISq2/PEpJliW8VCfKfAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBApmAUCYRBfH8mzAScauq5tBuhcR6XHg5WzKn5w0Eaof2qxB5IlXOjwdNWjl1lyhvLcrTsl+3fSBtxnaHSjAECXuahJgfBj98PzId/NL0hUlmZ5XP4yvn9f9eu6NTsgCCRRPcHVmkF4POUBLqs9JVbKJUzch4mmBUd8TX3NqbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WktwnWSl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724148487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kg6MBJLuAz1F5H33Agwi+o2BMA7KI9dO6oIsDSYPZds=;
	b=WktwnWSlfsBHUK3qB1pwPu8I/EiiWy1oZfaQZpC73GqNlaUyquV87qJDc1omdkIC7m0Pgt
	82Pwqb6Fdm/TESYVbYj85nhAlyAaZHA+cLUm74P++gUHdhxWpt9yvCqoo05OhnFNg4vCuT
	9g8UZISO1gCUumPLEiq11tfrEkVsJvc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-RgW3qhQpOjml4wiRGgFqQg-1; Tue, 20 Aug 2024 06:08:06 -0400
X-MC-Unique: RgW3qhQpOjml4wiRGgFqQg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428fb085cc3so10001915e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724148485; x=1724753285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kg6MBJLuAz1F5H33Agwi+o2BMA7KI9dO6oIsDSYPZds=;
        b=kBl1rsOcEYWSdHB6HfAciWeAdZ6QEccG+ze3r+2M2SauyOa3YR11SOB8WluUp53ssS
         5B33oHMcezM0ORSuKDZRr1yn5VILkq7jkJHy9l+ClxMfKFJpNcdeI3+qraEZIs4RLLKH
         HTB8L8H8kFrfVHq66CgvtcvsPYbN5xgYLmlK90+Wk7ZOHyL/L7VdoOGiyT1aP53x+S2K
         V20K4bMYA3EVGgYhzC6XX+io5ZbAJH8L2sko0MRdDixGxPDgKcqzME05MDyqB+W8HS4p
         ZX0kcwQen9ToRMmECxe8vzfui6tSv1cVSr/CKGZ5wmXjrDfY8D3uCjlKlJReusfCbV/2
         er7g==
X-Forwarded-Encrypted: i=1; AJvYcCXxabq80s3YW/bRJeuZQWwz3IpuwWXbLW2NEFymqF3OnXjcuXs0gqxgG0h+cliSvsb9BkJrOogPQw/MfUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuNlelnjYWslZ1el77FGackGn+YCYtKwAf5OBvr4DQSZFibRaC
	CDUIl47cCk7JlyR9dtir4VrRxg3Es6L4wXlXd3n1NRJ8Yfz8Z4ssB40Fewv1gZnZeO5TBquG+pF
	F538LvfapWlDltYCNrZcxn7UMcouQZM8PH7J4ykZPw+oYjZPwzJTk/q+wrIjDZg==
X-Received: by 2002:a5d:5888:0:b0:368:4c5:b69 with SMTP id ffacd0b85a97d-371946cb74fmr4807591f8f.10.1724148485253;
        Tue, 20 Aug 2024 03:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxNLeZFO1Uv/pPE3b9y321MUVwgdiGoYWbFgv6tEkAM4vtfLJhOrQdUw8dyfK8ViRkHxbB8g==
X-Received: by 2002:a5d:5888:0:b0:368:4c5:b69 with SMTP id ffacd0b85a97d-371946cb74fmr4807580f8f.10.1724148484763;
        Tue, 20 Aug 2024 03:08:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5? ([2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a6ddsm12723699f8f.58.2024.08.20.03.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 03:08:04 -0700 (PDT)
Message-ID: <9bd573ff-af83-4f93-a591-aab541d9faac@redhat.com>
Date: Tue, 20 Aug 2024 12:08:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
To: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240815022014.55275-1-Tristram.Ha@microchip.com>
 <20240815022014.55275-3-Tristram.Ha@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240815022014.55275-3-Tristram.Ha@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 04:20, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> KSZ8895/KSZ8864 is a switch family between KSZ8863/73 and KSZ8795, so it
> shares some registers and functions in those switches already
> implemented in the KSZ DSA driver.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

I usually wait for an explicit ack from the DSA crew on this kind of 
patches, but this one and it really looks really unlikely to indroduce 
any regression for the already supported chips and it's lingering since 
a bit, so I'm applying it now.

Thanks,

Paolo


