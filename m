Return-Path: <linux-kernel+bounces-307257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418CC964AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558291C22FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41481B0127;
	Thu, 29 Aug 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SIsACQV+"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877B11A2C0A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947458; cv=none; b=U/HcpHzwPfcKRXfWk5sFqtjFwKYWtrWASCYsUsG6uGKIeor4bsezjpAtw8MqXWEWMzdOKdyHbzu0vv44QT+lhq5KCBZ9U74L6t76tk58huv0WFYj/xcH/YTMGmFyFU0LPH1wx2Z1n7T4GtGqbp5DTU1MIASxAzR8RRI6W/5r1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947458; c=relaxed/simple;
	bh=uG8e1j3GDf6842s7pA0TGeHGpKR4tg1nG2DlYSoxEWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/TuVD/erfwo2qtiYhk7dBQsSz179sKzWkGbsuNH854Qj95KQojGDrbHY0EzHkf69eJUZHje77dmzWye+Y/HyeQRCxcO504CLWeM++JuH2sfEaOO3ypE4trEpa6WMpKUnEPxikwU+7nYvSRAb/b/bZR7ftdZfdYeilZUoWlFsZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SIsACQV+; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a8049d4a40so51520685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724947455; x=1725552255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j21zmxbJDf4bu7f2ESz3fPyqSzdlXT+oYN+G3wNwqmw=;
        b=SIsACQV+IXKkDt6Gz274bzhtJ9xFQfwG2UC/6mUMed0uVf1nFOVxSYv28ttW5467eP
         C4yYvTcnTvVqSd+h2phvNPe3lO288HFHhk7hXOPaveXKY4M3s3G+YkomrrrN5W89iwbK
         cgXOFK2rx4pA100HzNwn+DiFy59SwNAUp6xtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724947455; x=1725552255;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j21zmxbJDf4bu7f2ESz3fPyqSzdlXT+oYN+G3wNwqmw=;
        b=EOrMxeBd0xVbR4nIM3IWDWMA7HAdCse+M8nzw+u5rBb0bITELqQfo4sfAtQwmbCy0/
         UiWc3tKDNxw5eJMtXdqvzq3wdnXv/Y8wSERa+y8h0CWj5QC0gjaptYuTOQQNxD5x6jHJ
         6BzZ3zZImUwFwSQk9pnHKfkd5Q6Oo77mwIVmyVuW6e6nOYYVph+UHQptzBFuBzb4rChc
         95L6chR07k19If/Vb2t0gzbLGL9wBRaj0xAfnRQfJrTHCkHALOvSxItAUEylaDtGSEIe
         GvMaSoYh0MW4tJaTzj1XWsBMhvYuAxnIGvfKg4oqDKFD+Nf1SFSKxCRNeDiFflVw0EFA
         KeqA==
X-Forwarded-Encrypted: i=1; AJvYcCVmpXyDoePJ89YjoTEtSLfASJhFsqQCm37/NaFRp6QladTmAnnVMIfz31Axby0JSHVVDf0g+udEMGIgVwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jSLRORhxc//4JDrrYvXCY2WuP9tQy8DiQBO40STG+ifuaFjv
	NwjokEnYMyj4SZn/tTAMPAMqI5IJ9JiMcJemK7MbhyB+uay9byWpW3h8OJnEbw==
X-Google-Smtp-Source: AGHT+IGFaz0t8R/+qfbE7U7RrCsvczvtSFGmlEqQvEx/u+mJxHvHuKU/SMyaZTIwLFmvH2gbGqL1QQ==
X-Received: by 2002:a05:620a:404a:b0:79f:1869:11fe with SMTP id af79cd13be357-7a8042631admr400132185a.52.1724947455020;
        Thu, 29 Aug 2024 09:04:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d61deesm62415185a.122.2024.08.29.09.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 09:04:14 -0700 (PDT)
Message-ID: <c0b22f29-be2f-4681-b963-ff80fbeeb4ff@broadcom.com>
Date: Thu, 29 Aug 2024 09:04:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] phy: broadcom: bcm-cygnus-pcie: Simplify with
 scoped for each OF child loop
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
References: <20240826-phy-of-node-scope-v1-0-5b4d82582644@linaro.org>
 <20240826-phy-of-node-scope-v1-1-5b4d82582644@linaro.org>
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
In-Reply-To: <20240826-phy-of-node-scope-v1-1-5b4d82582644@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/24 03:07, Krzysztof Kozlowski wrote:
> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


