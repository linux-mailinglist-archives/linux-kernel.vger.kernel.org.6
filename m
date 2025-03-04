Return-Path: <linux-kernel+bounces-545034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9B5A4E848
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD3C4609BB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F77279323;
	Tue,  4 Mar 2025 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="La5b50ao"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B482BD5B5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107015; cv=none; b=Ddldv7csdr+ewpXT/DGIeyxeYy1/3GUmiagXgvN4ae3ZaHG+Ibf3bjXP3VN38BKTtldy3kNuc8E6/P6IIOSKps3Au3B2jduSWY4IWxeDGSn8vVSSUZgBY10lkFQdRsH6AkCpT8kBl+IbxMcBQ/mx4sNKTJHiijSoEVZKs4NunNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107015; c=relaxed/simple;
	bh=ERL98+XMhCBq0WKMSdxbiVgqP55a8peNWRl1nrEYVgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMxrVAbzfIoNg8BzwGlDiCauhEigUN+8SI3D4glNu6HaMdKIiZlMye7afIqxTtXwTc1oo4A1t+l33POHpD1M/CIGvgtit4xcEcLqyeRwCy4yYmpqkDtpXO9EhEsH4PfMZrZUPO4draLvUlXo0GoOvOitr3xExtj+rdhmJimoyIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=La5b50ao; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2a01bcd0143so4932514fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1741107012; x=1741711812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nlIbklXNCmcjeQcgQte8OZAzddo1rgx7AgL8en5NgHA=;
        b=La5b50aoPH0xeWXwkyTSX4jKTnUS8QRDAk3Xc0L8YlVHQXHuUkjUcw6xBqeqm9/XaF
         3wbiTi8gzZaGZg9cHkPqCLTZohyOP+XQiXCrWhPwUHl3kuaBd9EtstOSunb7uDs7WVaH
         meQRugRn0gK1Ml79b7Cp6kFNf9MXoHIPynA1FRb7346+qUfMiPtil5GXtElIsOKqJcxS
         y1ylzT4kbhhUBEIJAKKzaPIefIJPZXiEqa4lKKT1TYXZoAi8zHQYmuOsbaGFi2lCzWTS
         a5g9xN/Z5eqE29hXg65HGF6FSznRLxUWYgjzh/vo5NSoQhNRXNaaBOL4DBnrimWXL4L3
         pOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107012; x=1741711812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlIbklXNCmcjeQcgQte8OZAzddo1rgx7AgL8en5NgHA=;
        b=WYBanYZ4dFJJr0yu8urhPevfbAf0ymwuzJD8b9H0Z9gMHspGc4I/J8Y9wLgjtWVvgE
         qiO27YsaqdLA3id37DgpazeNdlqHA8n9m9OfZOGp/vW6RuzanEkdBAhtDQFOxQYzTXiV
         uZgxMKo/BkLcZbemsoK+Q5mDhnr7LXHMro2MKKIsBzWrUfRc9Sf05oc3mzEO2rFBO1va
         P0Pm4pROcTZlsU+dlkJ9KQdR/iST7kc2uKIswgD8z9vlgsaIAv+ufH5zoR/cAMjiBwPJ
         u81DAWuidhRbBmyojruWC9CZLC1jBM9FkYyhS/jVMXvKn+qlunZqfZykgLJWCHROnCaA
         Dj7A==
X-Forwarded-Encrypted: i=1; AJvYcCUXx1JYpn9wS2CO5RqYWqN3JUXREOB2LPC+cQPTJ3DW0w5KgHrNHTzLXrXFzU4unmwBY6C5kfnz9CVXa9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxixh+Jof+FV6P6NB66BosoFCD0Lg8Xn4nmTeu7Lk2kzrp2dVzw
	MGiCup0moB194u2AxEFmTU3ntB3HkRQexLF3lcu/g8z0WsqO3sOFZtet5v+9qyc=
X-Gm-Gg: ASbGncvD79wvYePZMYsQP6VN7DLsIQZUR4hgB7YkFketxLnmIW0udMEf9l1kwGfrFUH
	fhGjm5+rSPD9peCU/jkhiU5NVy/iRfI4x+qhT6oindQdBbUY8Mn72hMk2DFFmnqVquiR8/w/W1p
	7gPKthedtH+hrwI9SoZK9tJ374o5fguXMbootWSQa8SQTSZeiS1sNKFd2wte2ERPPm73vmUgJ2m
	uJcszBjDQALzGJbh2UfIB8oLUAeeLnsfiK6lcqCllwXcZa1+3EwHtC2YzQi29Aqix5NjTFZkX44
	PZJryjehKuYJg4ZRa43lN/utdVdAblOsJrvmFSJnUDx1F1XC6/F6QDL6iG67Hkhb1cqvDjIZp9W
	HG8/zi+5T
X-Google-Smtp-Source: AGHT+IF132mZL/5S2H3HBYE9POUMpakPzvAs82bnnnaYSOVaRfL5Z+1wdFvEGSjxOOUrEK5Dp2GhIg==
X-Received: by 2002:a05:6871:d10d:b0:296:a1fc:91b5 with SMTP id 586e51a60fabf-2c178341172mr10264433fac.8.1741107012166;
        Tue, 04 Mar 2025 08:50:12 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c15c45e81bsm2333459fac.50.2025.03.04.08.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:50:11 -0800 (PST)
Message-ID: <5b2c08d1-47fc-43f2-abcb-f5f54fad84e1@riscstar.com>
Date: Tue, 4 Mar 2025 10:50:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: ipa: Fix QSB data for v4.7
To: Luca Weiss <luca.weiss@fairphone.com>, Alex Elder <elder@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
 <20250227-ipa-v4-7-fixes-v1-2-a88dd8249d8a@fairphone.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250227-ipa-v4-7-fixes-v1-2-a88dd8249d8a@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/25 4:33 AM, Luca Weiss wrote:
> As per downstream reference, max_writes should be 12 and max_reads
> should be 13.
> 
> Fixes: b310de784bac ("net: ipa: add IPA v4.7 support")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Looks good.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/net/ipa/data/ipa_data-v4.7.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
> index 7e315779e66480c2a3f2473a068278ab5e513a3d..e63dcf8d45567b0851393c2cea7a0d630afa20cd 100644
> --- a/drivers/net/ipa/data/ipa_data-v4.7.c
> +++ b/drivers/net/ipa/data/ipa_data-v4.7.c
> @@ -38,8 +38,8 @@ enum ipa_rsrc_group_id {
>   /* QSB configuration data for an SoC having IPA v4.7 */
>   static const struct ipa_qsb_data ipa_qsb_data[] = {
>   	[IPA_QSB_MASTER_DDR] = {
> -		.max_writes		= 8,
> -		.max_reads		= 0,	/* no limit (hardware max) */
> +		.max_writes		= 12,
> +		.max_reads		= 13,
>   		.max_reads_beats	= 120,
>   	},
>   };
> 


