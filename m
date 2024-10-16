Return-Path: <linux-kernel+bounces-366959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944D699FCB2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582AC2869F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859273C2F;
	Wed, 16 Oct 2024 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QTTiflSB"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354E1DA4C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036971; cv=none; b=eMRll8Ni7E6ksVw3xIERk87nh5/g2NCDOVTzkfORYAKeTxsqRk8ic2SpAzXc+oqZ/8AyXb22xlT2MDDc+igCQoWjtirztJSPgWa9vTv7hCLKhXWgyB8MEdoKwygzIPe6lfi6mi6WUN1rLh+GIrHnPPfvEWqI8YuM/5g06QaA1qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036971; c=relaxed/simple;
	bh=pSVc7utcc/UhFpzSdysRar159gd5a7biUFgWT8rXLOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8hWrBBf/Q7tpTSycgZofZLZmeAyRDBfFXc5pHb5XRW2Zpipijdtk4BAeLzlnDYkK9WXL1cDk7ZhVyJwUEOSEtQSd7tVPoOoCifcBs9nHGZMd6ENfF5mASoSsSlGuBbkp9bTqo7OrxoOSSBk7P/04bZaLYcTdlKtFAh5wzzB/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QTTiflSB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20bb39d97d1so51564465ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729036970; x=1729641770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dF6f9apA9+My1N156mk4IWJfnLvdRkN/R/eAb7AsIns=;
        b=QTTiflSBlM0k2OPNpC/4V8Km8+Sc5EoxLS1J3buas/84AjguNu7dQx8LVg/PE4igNm
         FZP5tOTR4Xwnz1MmQLz5MatzbdQzOsCzEU/wb/OqMN5Qot+XfX+EonKxOYl+LmkarKnU
         pLZdy6+K99QTX72lBUw919O1yVQnP8pDSUC5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729036970; x=1729641770;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF6f9apA9+My1N156mk4IWJfnLvdRkN/R/eAb7AsIns=;
        b=uOIMqiJnF1HSTQnylTeNPq/nEUP/K3o5foA9pyjAF31o4gpdWVYNbe9Y6NQSRmO0u4
         PwYBrIUNJ2FgHdspef5SjgVF73fGOg999hhcX4uvH9LXX2hJIMvsaOdaUcmwNcIk1hjq
         OKAhhrMHDtlApwTJpHRNO5ZxU/0ViVDlLZnWYpRRvpzJQU1Xo7N4lq4aktt13S+RHzup
         A+uFFUWFG3Lfom85H13/PpS5YqEd3j5KF7xexyEcg6Wi1zO7l42bv5Elv+zRAZXNGxSD
         G6swpoQYOVT9IIO8bmlDk90wIkE4xvXUppPa6p8DZWgn2eyCkmYZIRBs9qG6WXwvPaAA
         Cklg==
X-Forwarded-Encrypted: i=1; AJvYcCUP0E+wCkbxCa1t4YsxQ1JzbVlbEpSpyaldBTMn5SuYazmUWwUJHYROLQCTKzGMDmdFaHvOjt0aJJmGyQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaTo0/NOzZZiMZpOhNn3BSuDPFUmQ4Zuyn7mJ3uJtUYQkqTGE6
	qeSO2V4ajrsMPnmgRKqdCPIZ3/rj69zc+HKlic2MwkrQp1KN6OYG+zx8c+OC9g==
X-Google-Smtp-Source: AGHT+IFEqDsvrvCpVMLlv3o2/g2HnaYZRPIC+afyz4ioZFd4qI40PzK/X5QorqRy4fHSbKcqhIM7VQ==
X-Received: by 2002:a17:90a:ee8f:b0:2d8:dd14:79ed with SMTP id 98e67ed59e1d1-2e2f0d7aa18mr19819337a91.31.1729036969871;
        Tue, 15 Oct 2024 17:02:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f039a5sm2583059a91.34.2024.10.15.17.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 17:02:49 -0700 (PDT)
Message-ID: <579e7722-5c97-4c63-a625-82e06697ca5d@broadcom.com>
Date: Tue, 15 Oct 2024 17:02:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmasp: fix potential memory leak in
 bcmasp_xmit()
To: Wang Hai <wanghai38@huawei.com>, justin.chen@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, zhangxiaoxu5@huawei.com
Cc: bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241014145901.48940-1-wanghai38@huawei.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20241014145901.48940-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 07:59, Wang Hai wrote:
> The bcmasp_xmit() returns NETDEV_TX_OK without freeing skb
> in case of mapping fails, add dev_kfree_skb() to fix it.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

