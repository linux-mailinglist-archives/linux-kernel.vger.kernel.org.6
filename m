Return-Path: <linux-kernel+bounces-276265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B3A949169
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8B11C23A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D5F1C9EA5;
	Tue,  6 Aug 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b="H0P8aAsJ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C01CB333
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950910; cv=none; b=Yv43k+2nsRhaij3jreAbFhcE3mh/l6w5mBU2TtDERYCOHVYBhkfwlZzkLLaiuSuBAU7CAJbWYgL9QCZTL36Ax8OBCo9+rtnsWyXmmtxz+tyX4IUgpIM8FrGaGXMJWM/oc1js6qO8vLX9OU2MzEAALGnHGUynBqkICHvXHJzefBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950910; c=relaxed/simple;
	bh=XIXeoplviRBsx4FDUrgl0jeSr9ymw+IkAm0Dqy/gRkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3TANsSG1rZmubMkWkwrRRXVWFpF61VYI2FSdr971o4+ZnExG//wTvwvI/J1U8BNz0/cIivADrkrWOwyiIav1aM2sEJKCw6X2UzM9AM9Smuu7OUqF/IwddQkxfYcqUX1RIwzJJVOCcUXFHU7NJAutphvFUmM0KY8VoshsSDKWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org; spf=pass smtp.mailfrom=cryptogams.org; dkim=pass (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b=H0P8aAsJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptogams.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52fc4388a64so818359e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cryptogams.org; s=gmail; t=1722950907; x=1723555707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1gTQV75z05aFjlmSn47s1I5BerUz7g47J8jMh8qrQk=;
        b=H0P8aAsJW6ku6OCv8/96uemG9AYlN1GtuQUBd87n2Od4tpBDtdqJV5d95wdT2yjh8j
         +c2uvebHIGcahhzBeT+29n3R8Cpu2dcXfwLddbCaXZHEXhdNuc9KOzWSYSMmZs5ofx1P
         lWJqD+dKuD1MrXSmmq+UiYlmwBDeRcAEHPVR8XX3ULuBcfdE9sCJk0GZ7VEbUTnr+Eb8
         qgDgJO6D370Jnx81JM0NsYJTeIiRLW20Ojkq04LVqKzvSJMNlJu5TD3xB4v5owpqbb0B
         7aB5lMgQtlHcA+fulSIFohx+PH3yfl4tfeXq3hDZIjM4FAhrgVuYit5+LEC10Q4YRNMQ
         pMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950907; x=1723555707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1gTQV75z05aFjlmSn47s1I5BerUz7g47J8jMh8qrQk=;
        b=mZPOE2fYh6W7SOGkNsZd1Iplz0qbD2mGajVzXgLUs4NPXirxxD7XVez3OMcYqoQUCO
         jG37gVtYE8hr7BnCnSc1KJ0JZV2XAd20E3fhirRny6p1YcCaDxhA67KWAjwqm/+swzjj
         gE0NW5U9YmQzHlP9EoAcEVR18eCyso6Rf9ipnB3cmCv9aX42/c9GWjwB7NGBwBjjmA2m
         EYBcli+UYXvtkKnwZgYo+CBreTUDukjj8H7lAI6fa7xq2EoZy+2WPATRg646qwv8gMwn
         QLEjZFUcr6zc1NgDUV+pSXfVGTxrCXb+thArEMzC2ubm3RMoaNWMHRmOGyby9ZMUlAgU
         vh7A==
X-Forwarded-Encrypted: i=1; AJvYcCXJJ5+J212CC1dhg+9Fl+hhihz/dtMBDZEekspa0gofxJNRiEDs1XvTh7wfv0hT7PaWFLMUneCj/3V8CB6c8agGfSsQIyw2Ov9sSVbT
X-Gm-Message-State: AOJu0YwwiFMTg4nxnS4MXfp2mLQH0Ou3j6hlip36tjlOxvxCq8I/a22N
	m+ikPTPdYyPuWp1E2iCzBtiQXFILJAYvJEdK6HeMJS3u+bccIzBefjMDltslfiE=
X-Google-Smtp-Source: AGHT+IGMQ8JfOHl635uR3bJj0fGzEiK2G0lKNTBalGys534yYdOwHnOoKJEwN5+mGDIZUQrkU9tB4Q==
X-Received: by 2002:a05:6512:118a:b0:52f:1ef:bafe with SMTP id 2adb3069b0e04-530bb374640mr11975325e87.22.1722950906853;
        Tue, 06 Aug 2024 06:28:26 -0700 (PDT)
Received: from [10.0.1.129] (c-a9fa205c.012-252-67626723.bbcust.telenor.se. [92.32.250.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba3ce26sm1475902e87.267.2024.08.06.06.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 06:28:26 -0700 (PDT)
Message-ID: <ab440f8d-c947-4621-89e2-f348510896a9@cryptogams.org>
Date: Tue, 6 Aug 2024 15:28:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] crypto: arm64/poly1305 - move data to rodata section
To: Daniel Gomez <da.gomez@samsung.com>, Jia He <justin.he@arm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240806055444.528932-1-justin.he@arm.com>
 <CGME20240806125547eucas1p2016c788b38c2bc55e6b7614c3b0cf381@eucas1p2.samsung.com>
 <qd2jxjle5zf6u4vyu5x32wjhzj4t5cxrc7dbi46inhlhjxhw4s@llhfvho4l2e6>
Content-Language: en-US
From: Andy Polyakov <appro@cryptogams.org>
In-Reply-To: <qd2jxjle5zf6u4vyu5x32wjhzj4t5cxrc7dbi46inhlhjxhw4s@llhfvho4l2e6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> I'm getting the following error with next-20240806
> 
> make LLVM=1 ARCH=arm64 allyesconfig
> make LLVM=1 ARCH=arm64 -j$(nproc)
> 
> ld.lld: error: vmlinux.a(arch/arm64/crypto/poly1305-core.o):(function poly1305_blocks_neon: .text+0x3d4): relocation R_AARCH64_ADR_PREL_LO21 out of range: 269166444 is not in [-1048576, 1048575]

This looks like the original version of the path. At the very least the 
R_AARCH64_ADR_PREL_LO21 relocation is generated for the adr instruction. 
The v2 has adrp and add pair for which the relocations are 
R_AARCH64_ADR_PREL_PG_HI21 and R_AARCH64_ADD_ABS_LO12_NC.


