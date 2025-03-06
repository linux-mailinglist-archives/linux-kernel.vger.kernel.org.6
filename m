Return-Path: <linux-kernel+bounces-548732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4051A548AC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0985618966DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA5320AF62;
	Thu,  6 Mar 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbvSda/k"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A639F1FECB8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258905; cv=none; b=p3b/humoTDZgnO8kn/c1xVgbztl+YhmT9QIG6W9cgHBE/6MnRn9zRIzJjUcah2vd00PClaiWG78LjkqdiHBB6hBHSPuFeUEXu3wUFOBdFX+4IaUtevH4zQ8ww2+2c4bakGL9pdfMEF05vk2LSrO/cNhZwt8AbbrfKahVZeX/Bs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258905; c=relaxed/simple;
	bh=XiPSDKnf0aVbl7oxlyloFpQgF0EkfatRAdMzQ0/FZEg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VcwynbRKCiW/9Fe8aIRUD3UHuasAOeVN5nCT5+EjG2ZOCd/xymH4wwHVsFx1B9a0oPCXlAZGadbylRhhERHFhUlYzFhsyxQinbzLHpFSyJnokbGCvRlL8gm9356MsRqACZ20JSiPSQYL/MbI41d9qo3mpRGMxI9ZILOuHXm5caY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BbvSda/k; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf4802b242so102972566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741258902; x=1741863702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UUmhA52lOTzcBIdzLko57ah+XkpjqclccDf+VaS1kCw=;
        b=BbvSda/kRMUAtRizEWsnkTYIIsHtB2jVIbfcaIMb0mZl3T+PtQi1aIvVJ147JlaB3k
         XF+4X7vmGcKIQyl6NqyGEB4MsYMs78h0A1X78CLx1HvALNHU4aIqjdVbTwzFVRk0UWNr
         qC1zpqYfPZofAv4w1o27ky0mtR9E+pGaT71fsxptCI8Y+14WsYhaA8b7N+UcjXnCzOaV
         m6UbGmAWDYM4zDG5RrP5OfblwZKJtJScjaEpLqX2Ria5qqtVPMIP4kpVwSakQC10IyKj
         K8GCO9I/c0nh+jilwGghGR3DScMa8mL3uTBp5mt9ZDn6UsASlAUMjHe16h7IWsXZFjxG
         KJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258902; x=1741863702;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUmhA52lOTzcBIdzLko57ah+XkpjqclccDf+VaS1kCw=;
        b=uxR3kWyNxAZsKe/nkXIw9U+eQcZsgNHzndHqop3dQ08qDFrfWFSW9wYVIAle7/kaia
         fbVrb9F7OQqU8wjlaN/zPnqFXZhvva5obCSC7PERqfwJAoi8DxO2hnmmmyjihD9TieHO
         xE2yOZcAreGWw2XM6nL2Y9YxzJ1FvRBBCeuGm3+owcBpue6cUubu3bNLvVED7XPBlkwi
         JUsDGbX6+rbmbmwgIDgalgAlhW1sq4d2AuKgqaDSf/I1k8dKaKVPDSJ/fT5KnYV598oc
         kcq2cq4c+W6OaSFQgc0Gz/43SK9EdAHmeHcDG0tLbVE+b887qh211MaixPKs5e4e1C8n
         CURA==
X-Forwarded-Encrypted: i=1; AJvYcCVgTP626E4B4laI50+au30xJ/cc7MQS31maExACRYAZGMz3KasH4voeh5rO+1Ygp3Yci++WqKHCHpFHFvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy473B21RVzyJpcu0ygkpH8h3ikAdPPOF84cCcYdl+cQxJNjNkX
	GZtoAuQSjQfkOxCkOvLsbZk1jOzCOHykK+sRQXaFn/+1jNLj1gV8bU6V/MI1Qcg=
X-Gm-Gg: ASbGncv8bpEPmD3HpdFU7zCNSwvqhgHaqPq6CWlnnDYz1WPakwrGH1ca/a08f9zfLm4
	qsTCiF7qdFsJ4BvVq1Rqrv0mSk9YPvgaENyIz8uPg47eXW82AhdvD87qjjg1vCtSqmjwm0crHT9
	qwIdspSC+b9ccPpHSxaMpEi7QxSZB++ZAdcGQ0wGHZzG5sRSwWsq43UJ4JMNXArHTvKVWNwy++h
	UI6sE0UELre6V6USphhlsNQFXrJ7SqD3ZUlfF4YP4/TuCqxob4SZbWsmCiwuM8r1SYrKJBOhWBB
	KriS6EgPZvmUDlh5VEJestSgh01pf1XUb1U9thlfwlSjWCBbLI0KGA==
X-Google-Smtp-Source: AGHT+IF2zUnqQR0kmEKiLO0NiKX6jtbed3ednzGKFCGUxppoit2dZ2h9Q+wyUIlwRJrZDv5W8apVbw==
X-Received: by 2002:a17:907:9494:b0:ac1:f002:d840 with SMTP id a640c23a62f3a-ac20da862d9mr798884166b.45.1741258901804;
        Thu, 06 Mar 2025 03:01:41 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239483628sm77607166b.53.2025.03.06.03.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 03:01:41 -0800 (PST)
Message-ID: <bb9f8a80-4662-4ab1-b9ad-6899977c3827@linaro.org>
Date: Thu, 6 Mar 2025 11:01:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: macronix: Add post_sfdp fixups for
 Quad Input Page Program
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Cheng Ming Lin <linchengming884@gmail.com>, pratyush@kernel.org,
 mwalle@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: alvinzhou@mxic.com.tw, leoyu@mxic.com.tw,
 Cheng Ming Lin <chengminglin@mxic.com.tw>
References: <20250211063028.382169-1-linchengming884@gmail.com>
 <20250211063028.382169-2-linchengming884@gmail.com>
 <e5458a0e-528f-44ec-a0f0-543472ad3b85@linaro.org>
Content-Language: en-US
In-Reply-To: <e5458a0e-528f-44ec-a0f0-543472ad3b85@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 7:20 AM, Tudor Ambarus wrote:
> On 2/11/25 6:30 AM, Cheng Ming Lin wrote:
>>  		.fixup_flags = SPI_NOR_4B_OPCODES,
>> +		.fixups = &macronix_qpp4b_fixups,
> For your next patch that'll drop the redundant flash info fields, you
> can drop SPI_NOR_4B_OPCODES as well if these flashes define the 4bait
> sfdp table.

Any plan in doing this, please?

