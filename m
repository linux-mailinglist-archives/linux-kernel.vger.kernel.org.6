Return-Path: <linux-kernel+bounces-539927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5BEA4AAEE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D460C1897235
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CF71DED5B;
	Sat,  1 Mar 2025 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCbys6NZ"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A11E519;
	Sat,  1 Mar 2025 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740832338; cv=none; b=np+36HosLmf40U/tt+m8U5/t4vULf1FTxpvryHTSSM4Ly+IG74RnuVv8flMw58u5+oKl0qE/OldM+yp7G4GkDFaKDjbw1en16sXv/q5JuHdrydLqyxNo3e0D3EhOlImRnClLX9rmtK+kq2yNoHYnQwqV2fuuVPqSi6B1h0L01xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740832338; c=relaxed/simple;
	bh=ra8gIKFKFiVeUd/HquZVV+FuM2qhRTGX+65IuN5qPDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jp9CcG9ewnRRUGbyWevpLNwU82fUrgaldGjA7LccDbi/IePqLM+ATTCxqG2bBKEhmExNb7DQfrAPn7/R+TKRMaqAn1zcNjq236IVEUFI8ZHoNE4fDUvmzzw6edarzbG2xc5XfJkx9BjqwV3NoEX/MefVqZwmehtIabhnumKS1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCbys6NZ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fea795bafeso4560900a91.1;
        Sat, 01 Mar 2025 04:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740832335; x=1741437135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ra8gIKFKFiVeUd/HquZVV+FuM2qhRTGX+65IuN5qPDE=;
        b=BCbys6NZ5jNzNS/dH8lRQs/PfOyYNr4pCN6D0cMCc8YPMf8Unglr3tJv9b4xB7nl2i
         cnCZajqy4UZKnUoSAIcLIfDzEwJIAOdiPjTsQJ+P1g0upGmDSyhlobWs+ceIplP0ib+0
         uNTslGWhULzZQv/mcJWkqXUmOiSXJkDNAdKTqmw/41Xaq+hU5JWh78YLNn6K+p84yV40
         xwKM4vOxQiK30/5UBIheJ1J265xTdUHs50fTSqAK5DXffqyfmvWsuTrlxAPZZzS8jaQH
         smH63BNb2a0JKS4fsu4Rj5CTXuwab2RJWj3gpjmZSKlEAhwXej/1vwGJxstZoGej5F71
         ZOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740832335; x=1741437135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ra8gIKFKFiVeUd/HquZVV+FuM2qhRTGX+65IuN5qPDE=;
        b=DZ+GHphvl1Rqe4LpcmJcFcunqBBBkWSzY9tqG03El93D0U6+XtGlYIn+IjN3TfvHPP
         Jk4D6fnZdtt7yU0mbv19L9AcLyKf/wBaEHGeVOtdMWU4hdtIr7LK4aRutodlS0S9q2lT
         5IBJlZs8l+J9T9EV//X3fayAejcJONIfCP63nQWgfha9jt7+kvr20QBu9DisLr85OJ+4
         E+MRoQoZXFtJhdCvppxM+Drv9yb/WB9rFIbdXk1gViEC/quYF+rNOHiVHMV9GJvQbqNT
         eAslre0s49Oi4D4NXYn42mXbp4PRqftVddEW0x2SSpPVAYSLDJp0I6ZYHwG/l9tpTN8X
         WrkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+zRhZ5bvjIb5YyWLu/VQ8Epr7rS3V3FnCQW83n3oMJ+LUppaXb5MZIOgUusvxUSQ7TlZpx3cTAVYNrlWZ@vger.kernel.org, AJvYcCWflUayYWTytunxHR+p0pFnaS2Ehc8oazXqEM1LdMq9+pnGE+yWPLn7uyUPlk++/tfT/xY5yxJLpFVd@vger.kernel.org
X-Gm-Message-State: AOJu0YyNFVttTaQ7CVac8ro3uMN1rc/ode1YwBbi4qECcahwBq/R98My
	+UwKBwMmsAyTqqJBothCgImancn8nlDDZ32jnSQp0ceVo3Uq2Ytt
X-Gm-Gg: ASbGncsYe+Lor2rrZfIF6Fj961ZNtqDsQV9pU3tCdqL7eR/MjVVUOmYxME+IYJms1mu
	S90HOWn5uqwzXmDTmFRWgWMM3V8HSqTsi1mAFjITJlYmXnLinybuJC0kl+CnlsNIY3MHZgQ6OpL
	NIGPpHboeqVErbRhu8/SeJE85E5aT0RsTVFQj0L7huh9asm4ENu080obh7VwnzoUyq5oXaxtbQw
	vMXR9PrnVyZshH0ArVEidvHVVOUR+3He0xsfH2WCe7pXKAKf2Jv0Bb19475+gDN5gIutvZS7Yu/
	s++c5N+u4JflnTdxC8xSfdzynltpRIm9uUpWqD47FWOTh8Sjobn/dLZOYE5G40XL4wW9
X-Google-Smtp-Source: AGHT+IF1mhUuctMChazLjJnYgbLD4i8xF/OkaFyb4KVb61pxcTtGOZi+8D/BZaLS5+Cyjw+B2Dpcww==
X-Received: by 2002:a17:90b:1e51:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2feba92bfc9mr11663696a91.14.1740832334925;
        Sat, 01 Mar 2025 04:32:14 -0800 (PST)
Received: from [192.168.0.101] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825a99a7sm8346849a91.6.2025.03.01.04.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Mar 2025 04:32:14 -0800 (PST)
Message-ID: <83130117-509a-45ff-bf96-26beb77246e1@gmail.com>
Date: Sat, 1 Mar 2025 20:32:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] arm64: dts: apple: Add CPU cache information for
 Apple A7-A11, T2 SoCs
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220-caches-v1-0-2c7011097768@gmail.com>
 <4670e5f8-2a92-46bd-8faa-dd3774517f3e@app.fastmail.com>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <4670e5f8-2a92-46bd-8faa-dd3774517f3e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Sven Peter 於 2025/3/1 夜晚7:11 寫道:
> Hi,
>
> On Thu, Feb 20, 2025, at 13:21, Nick Chan wrote:
>> Add CPU cache information for Apple A7-A11, T2 SoCs. On Apple
>> A10 (T8010), A10X (T8011), T2 (T8012), only the caches in one of the
>> CPU clusters can be used due to the "Apple Fusion Architecture"
>> big.LITTLE switcher. The values for the P-cluster is used in this
>> case.
> So this means that the cache information will be "wrong" when the CPU
> is in the lower power states and only correct for the higher ones?
> I'm not familiar with how these values are used; are you and do you
> know if this will have any weird or unexpected effects?
> Would it be better to use the cache size for the lower rather than
> the higher states or does this not matter much?
The information in the device tree is only used for reporting cache sizes in /sys/devices/system/cpu.
It represents the physical cache size which may not be the same as the architecturally visible cache
size. Cache operations in the kernel consult ccsidr_el1 and csselr_el1, so it should be fine.
>
>
>
> Best,
>
>
> Sven
Nick Chan


