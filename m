Return-Path: <linux-kernel+bounces-560359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4992CA602FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D4A19C2A88
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DAE1F4634;
	Thu, 13 Mar 2025 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaZXZbKU"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04311F3FF1;
	Thu, 13 Mar 2025 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898976; cv=none; b=M5R8AwaqO6Y+g0Bsv4D8j14Ljd/07afMQRSmC9A+BKEt9O2tZtIHDan7k6FSkbmdJq34y5h9P82TIvaqv5LqEtHgN1AvMGRcs4L9BjPzUsnFxRrEz+/fk/AQGcjRciji5yqBho3iltXpm9m6K1X23ljnuvS7bgeCWRX8uce7CXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898976; c=relaxed/simple;
	bh=utdsEU5rR3jj5uhVBxeK6JXJy2lz+au+ixF7Kj06GV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0yMpDAsiuWFZvSoD6ge4OOQXws1eq6QJ8CimxzokQrRsjqTi9ASzB1fpB3dUMC6vr49mbsyMEuKOVWNrvvr/u+1U6J2IJkUpg9fCZpvsrvcY+fndA/38c5olzyqqe8twhtAJuoWzYlObA8JDmpYfuWTPFVSIgi2zEcVq48miBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaZXZbKU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaec111762bso297086266b.2;
        Thu, 13 Mar 2025 13:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741898973; x=1742503773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOSmqPxIDrKqjeBpEW6dlza06ScebCb+hLamX5awbSQ=;
        b=AaZXZbKURmSExk8uGG0NSYl4Xth0Uoqfs2gMZwrN82JvxZ0iHjQekG6ABw4N6wULpf
         FHGwpJxTx0+4aHWcBnS08k1YjpjYAEA6ZQf1ufDDwev+aKoGBqx8hy0UqRSEckHpc1ay
         9XyK7Ehc3faj6yjBeK1cl9b0UUP89Hl78y9q031f+7LnnqbmrLAgzozMOAeXmpsJtnw6
         rBe87JI1F4gKo8K1SpfJQlhz5vqEX/Sg1OEyUXXblfoTiIZ/cZpgFnl34NtwjyxEFIFl
         Xx9GwI6vISOthbuSokKimoXKaKoEl2XDWEFBWjIabHSRAsqaeDPBvM8MiQE6pJYOAuJe
         OJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741898973; x=1742503773;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOSmqPxIDrKqjeBpEW6dlza06ScebCb+hLamX5awbSQ=;
        b=tUxF+yGIOQ8e3Hbjwpq+EgKM9CtogWGRo9Qg7K5cPqDGUwJju4oehJdPXvY/mpHzjy
         5QsPrpGRhC1obloJ58jU+mJJswbzXAFTx9Nu2pvdjo2lmWcTw+IpWy7vsqTKGXeAu1Kl
         91nFOBPHq3HhJB4Mi4+u50WotG3a87w4e6nQ36k3W/tt9NdtblumSk9d7CoYW6PXjzzm
         5iAaS31QbxmIIw3WlzQK8PhBXf06hhMysm14UdrShoiZNZLso2WKm/XzEWnSHaNGrJ6E
         vJFQfOaayT02xR3UUChtqRDRHNyu1PurJN6t3+t6+J6mKQN0hQiYQD0wU49alswZ5Bc5
         mc0w==
X-Forwarded-Encrypted: i=1; AJvYcCU2h+zQ/ZDUe50CInGtM8MmZkfO5oSGFOsDoUKwEkZ6QTSDfDNE+bhq19MLmxRdvcsFOUfRe3Dm895K@vger.kernel.org, AJvYcCVBNsF4g8/oYhbXRaeXmmp0+/2QKGVaDPEDnSRgmEIR8aURA9wLccbdn71NUGOGrjExgszuI+C8/Ckxp5Cs@vger.kernel.org
X-Gm-Message-State: AOJu0YxPuAjzMU4KK/21YW3QZDqXSHwBEEAN2F6ND57m16Zm4RM/gqYa
	R22sisZXlHARbV8QXRxxQJCtH1fTU6PMY1bNQueC909Sv+iZDf+7
X-Gm-Gg: ASbGncum44ejYh5r+/geosRTpe5D4+H8KDBiqFSsYeB1EPpStvUg81lCR+x7hxsfmWV
	ebC3IvtilulJsh7EKDluzhnEhlT7TPlyYWo5ReTUXwvUr1PHQXml5vz33TOIcAP7WJe/vrcr6D6
	z+6rYLPOsiboXTOzQFIRSY8McA3a97LWQVVXQY5mSdOqSd8+u+74wH5OT5Dg4XjBC6QQITme1J/
	v31f/r/sqdGkq9FuamsmFoIjCOCOvV4XEjpj9k9dsxbszdt0ssTF3mtvzGU+/ydPBj58lW7pypZ
	IHmfud8YQFS0iZFB0V+r8s9oELOGLGelel7TGrtfdwxuQYVvOPLfH8ELEJ/x47Sb5JrhCWAkT55
	SqdbAPtxX3UukYMw0B9yymg==
X-Google-Smtp-Source: AGHT+IFmBSCQydVfCelVM6XzdMkt8DVaqTYnfbXEg6vlGdFQDGaNADtO3TQmZb6W9wNLpy48kbZXHA==
X-Received: by 2002:a17:907:6d06:b0:ac1:e31e:de0a with SMTP id a640c23a62f3a-ac329290a1fmr100133266b.12.1741898972904;
        Thu, 13 Mar 2025 13:49:32 -0700 (PDT)
Received: from [192.168.50.244] (83.11.221.132.ipv4.supernova.orange.pl. [83.11.221.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9bc6sm122154066b.49.2025.03.13.13.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 13:49:31 -0700 (PDT)
Message-ID: <3a235d3c-0d23-4b19-a286-637e710b534e@gmail.com>
Date: Thu, 13 Mar 2025 21:49:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] mfd: bcm590xx: Add support for BCM59054
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Stanislav Jakubek <stano.jakubek@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
 <20250313132136.GC3616286@google.com>
From: Artur Weber <aweber.kernel@gmail.com>
Content-Language: en-US
In-Reply-To: <20250313132136.GC3616286@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.03.2025 14:21, Lee Jones wrote:
> 
> Besides my one comment, the MFD side looks okay.
> 
> So you still need ACKs from Mark and to rework Rob's suggestion.
> 

As far as I can tell, Rob retracted his suggestion and left his
Reviewed-By tag[1].

[1] https://lore.kernel.org/lkml/CAL_Jsq+Qsu-6Z72uXYKwc62idq2K169S1t0nUrrgNOyezgfYsA@mail.gmail.com/

Best regards
Artur

