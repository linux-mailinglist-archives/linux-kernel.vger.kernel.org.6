Return-Path: <linux-kernel+bounces-288266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0147B95381C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C6A1F2548B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148FD1B4C44;
	Thu, 15 Aug 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9OSXTYE"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C91AAE34
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738656; cv=none; b=EnkZ7oogTpnC4B+JlJq8syVbr8zQvq61snLxVl1YJ1oX9tZImmLBAK3QoX9jZuU7lsxRZi/qwMP6vDOkHlBofxBWNqmf7z1CZ5LyTLMxApUUUwnAmjl1nCcCc4hMJE23qDsulVLvrwFApcUsl+HYiiWMypMf8LfLseGlCBsXr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738656; c=relaxed/simple;
	bh=ch0gsCNYQOMynpBENOSF85XS+ArOiHaWiv+clzji3uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQqZb/NS0+i+ZPFYnuEouYE/+DRf/L88fN68MNJJWE1EFthX3F15wAyxNlhBcgV32S8Sp+gjYFIsDyQ9PanVyVokuzIpYau8bq8qV9Rq1KK2wpdtsWpf55wuScIaS0uC5PLNsrPtp7yz3jdoGywcoiUNPwYmT+Fg6WO8hpanHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S9OSXTYE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-368440b073bso602446f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723738653; x=1724343453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hW92T01FcWfSoB3fp+6O6t1qTB3U1ClSBO9lOUWmw8=;
        b=S9OSXTYEkEy6kHkvzX0PWCbOMNOmeSgadzmq6Ra19SXEM52P0tmjxhXAc8SnTjH9o5
         OwLd55YzmlGAelwv6JiByhzEb59Zoy4zHuUTZbq0XBvhx+U2+1ng+lPn/btwz3Xp7HVb
         nv1tbIPsev3nN7XT7VJHbYxMfUo/5C/rWwIEWK9zrdUPiSiU7o0kE1XUORMsQSa6iioB
         0xVkxaYh7pAXMBbsNganGrsWMcxN2b2G17rGJbQCShRAwG/Qgb8Vh+By4yrP4+M91tc9
         HV8U+iliy0/CbUmNsKt5hkKAGCNspwENK/R3VEsIdKq0s0JVtvQ4MbYazv4yCNxeRWQx
         BxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723738653; x=1724343453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hW92T01FcWfSoB3fp+6O6t1qTB3U1ClSBO9lOUWmw8=;
        b=lMGn+dxt5KctR59gRN6JlsAuDMCWqrW9L9dkYq8QtatdS1pohF60k458Ak7jKxWc0p
         9yRHb+f+HyjFi0DBfJfP8NqZlCkc/vTzYCnJlxrIYPX9zujwlzgM2M6/54p3wDOK8B09
         Ujf6Y34tRrevuFgb71jv4VZ6msQXQVfKclhGzGQvcxeX5PJJf7KhhMg89bIucqKJ7XCz
         47OVA7218ssRWCpYYD6CG2cvN269qI+Pf2LUlhObBDP3pDjVRH7wW4rxQE7F7zcLh0YO
         r601KNunJSnj0/CZz/dvDt0FcvGhObZ8yglnUpisF4CZD2lGx3FEd+sKbX1ELQI9txYB
         yMKg==
X-Forwarded-Encrypted: i=1; AJvYcCU6C7tsbE2WIZMLm08pTt/YnC7Hl2Pb+Zwt5AGmHPBdkESUEhsAO+3ku6+YH3927yIzDsOHyMVJi5AxeKLeEmwC1wcxVeTss3j2gHWz
X-Gm-Message-State: AOJu0YwDmhIfe+XLvlN2BwkxueXtOE8OW8xyaxcktsYDIdBVA2RePbo0
	Ih7wKk0Rn8Gno9QRJIz7DhTDnVTdqRBdIFGOOJS56LWO6Nv5K0WV0BdzaCqviOk=
X-Google-Smtp-Source: AGHT+IHOOQxFcTUyQDe12F+tfGVl/ysCvLAsJZ3nvierP2793j1ord1DrqBYtqgug10FWIcgBgcpgA==
X-Received: by 2002:adf:9785:0:b0:371:6fb8:8fe3 with SMTP id ffacd0b85a97d-37186c05737mr2340402f8f.12.1723738652898;
        Thu, 15 Aug 2024 09:17:32 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189896a9csm1876781f8f.79.2024.08.15.09.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 09:17:32 -0700 (PDT)
Message-ID: <71acbe5a-d9f1-443b-adc6-4557cd2737fc@linaro.org>
Date: Thu, 15 Aug 2024 17:17:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] media: qcom: camss: Add support for VFE hardware
 version Titan 780
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, Yongsheng Li <quic_yon@quicinc.com>
References: <20240812144131.369378-1-quic_depengs@quicinc.com>
 <20240812144131.369378-14-quic_depengs@quicinc.com>
 <6ddaa41b-86cf-44e5-a671-fd70f266642b@linaro.org>
 <eb77972c-9c9a-48f9-b850-21e6c2df005a@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <eb77972c-9c9a-48f9-b850-21e6c2df005a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2024 15:21, Depeng Shao wrote:
> Thanks for catching this, I forget to add the rup irq, so this logic is 
> also missed. I have tried it just now, the logic works good, will add it 
> in next version patch.

Cool.

Thanks for sticking with this.

---
bod

