Return-Path: <linux-kernel+bounces-185362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576948CB3FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB2A1F232BC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BAB149DE4;
	Tue, 21 May 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmL96uLF"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC8B142910
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318263; cv=none; b=kcYbFaIPlzPJNKeN26YaXUP2Do6ifb+F4Kg5IOlV6iAlikpXg5x0MCECfq85v5LrgTPI9h8k+MeRNOJNsIzx7OlXB4z/275zLXn0f27pdyH4SNG7TTXcbEQdBzJAPR8Dt8/q+4y+LL2N+lHhLKd/J83EOeDePP7Nj0hu9UTTGaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318263; c=relaxed/simple;
	bh=ICGvHXx5Pi7B8c6ZI2iMxTPlw9FEC5JhgOAcp5rNuU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyX7OaotXQ+qCIrg/p0YeMe/RB71r2m/KiPrORF73XiHnJDGt50OopWW7sKecvRx6n1sQGzkwXNjM+3SThw9Qo+1W2p6GXP9rGyPi5TagopQERGafyMrsAHrTS2KoqerjTzQLJar0oyHfpVZf1wuTftssSCx3NgyiZoVI1ctYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmL96uLF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5751083afcdso1143657a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716318259; x=1716923059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7BbdMvzxHRPPnX9HXmTB+/r8rJ0cnISZJHlssmxst0=;
        b=UmL96uLFPhydU2im2uKaG7uwhx/qxOq/ceG01JLZUnOPt3gCBAAP06DHX+JoQt8HQF
         NuChyeMnNiHsj+uQt4dswdQiY7SKWB1+F89/dqR7ILAHVxFs1A1frYvMJQc7lVupf4EL
         hSmzV0n3sGz5JJCBYTKe07wDk1PazB1DnsQLXxVFDGsr771Zt/tbc8quiFiFLqdv5cft
         5gS6Qq029sK64A8pkdDxw5L5kZNxh+rXUIMhfer0UG2Df8ZihlTl24/UAj+ofu9ercMY
         TdlTCgpeKwKKuNMigeDFEoARDCv6zcXlK6BYVfCRDfRJnBFrl6djXAAdmjTktN1akdnL
         C8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318259; x=1716923059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7BbdMvzxHRPPnX9HXmTB+/r8rJ0cnISZJHlssmxst0=;
        b=BygNw51KbFhwGUrKZ9Lufc/ps8rojjPFpLCz3xvDdX4tFfZvoIa5v1oG5qevM+5tAm
         5racOoNPhtYMSl4Nfc+qu0JeP4jKdQyBp+AsimhZvnIgsYo/VytY7XzhH0KBlKwURNwb
         QzimXL71/nLTn1mUtswPzoTtVJlgp6/Yl+6vaRr0lpVFErP+Y7LHSo2/08efiL+qHvrd
         8hSUIvmdE5LGbcSUZUqGy+PjJUEm+Bng3taAvI+aiwhx/EQ9dzXzMW3tl2De55j1Ew9Q
         z0iHGQsFLjrAYKM4bD+oVqcgpjKahCQioGHMfS+WNWHRedXuKpCGcWJkx2Cyn6D8Z+rR
         aTZA==
X-Forwarded-Encrypted: i=1; AJvYcCWSILRZzcu9Dy5fBoS6NS0bs41B0JIhagRU0yGKLP9T9GV3YgbOrnHGU9k1OulPcV7exURZdp6uG3eT6TBiKCJ5/7sxCK4ywtL1BwHm
X-Gm-Message-State: AOJu0Yxh3W6P9GZ4loYMvbcsl8SkcWu33R9QrqNVgn3CXdFRIb/eZsrH
	fK/z0UAhEH572uYi7qcr2h9jFbQLamvG7vrpFsqL7R5HH49G4BFw
X-Google-Smtp-Source: AGHT+IHUac7tJmtKxXzHJ6SsIT21nq89zj38jGbFcbJJvWers0GZS/G0ZI/0eWleUKMHNwXD+rhd3g==
X-Received: by 2002:a17:906:a0c7:b0:a5a:580f:8e74 with SMTP id a640c23a62f3a-a5a580f9031mr1755816566b.5.1716318258510;
        Tue, 21 May 2024 12:04:18 -0700 (PDT)
Received: from [192.168.0.103] (p57935690.dip0.t-ipconnect.de. [87.147.86.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b0173asm1670478266b.179.2024.05.21.12.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 12:04:18 -0700 (PDT)
Message-ID: <faa1bcaa-0be2-4381-86fd-5f108a11869b@gmail.com>
Date: Tue, 21 May 2024 21:04:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8712: Fix spelling mistake in rtl8712_xmit.c
To: Roshan Khatri <topofeverest8848@gmail.com>, Larry.Finger@lwfinger.net,
 florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
 rcengland@gmail.com
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240521143617.53139-1-topofeverest8848@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240521143617.53139-1-topofeverest8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/24 16:36, Roshan Khatri wrote:
> codespell reported misspelled aggregation in rtl8712_xmit.c. This patch
> corrects the spelling to increase code readability and searching.
> 
> Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
> ---
>   drivers/staging/rtl8712/rtl8712_xmit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
> index d7d678b04ca8..12f2fdb1b3cb 100644
> --- a/drivers/staging/rtl8712/rtl8712_xmit.c
> +++ b/drivers/staging/rtl8712/rtl8712_xmit.c
> @@ -247,7 +247,7 @@ void r8712_construct_txaggr_cmd_desc(struct xmit_buf *pxmitbuf)
>   {
>   	struct tx_desc *ptx_desc = (struct tx_desc *)pxmitbuf->pbuf;
>   
> -	/* Fill up TxCmd Descriptor according as USB FW Tx Aaggregation info.*/
> +	/* Fill up TxCmd Descriptor according as USB FW Tx Aggregation info.*/
>   	/* dw0 */
>   	ptx_desc->txdw0 = cpu_to_le32(CMD_HDR_SZ & 0xffff);
>   	ptx_desc->txdw0 |=

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

