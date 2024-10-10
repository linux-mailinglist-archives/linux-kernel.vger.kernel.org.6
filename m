Return-Path: <linux-kernel+bounces-360169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122FE999570
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36369B21E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB031CF282;
	Thu, 10 Oct 2024 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bN34XDl/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE00714D6F9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728600473; cv=none; b=Vvmcjmkc0ehPuFSKSs7zD7WdvEXk6NLOehA4ofzwo4Ptg6YhY00E2IJrKVNmUAIw+x3qPT9pHRg1ls3ycSmR1ocIWABUy5zIbhFu6NvagN/gip1eG+jWHQsLimzPAVWpziKKaKIvHO1qxTMY4O+vybqm2WGcwl8pTDg74vCXJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728600473; c=relaxed/simple;
	bh=VXESll7Top6r9okWSbcZe3vpE3W+4Is4JWHa4s+JBDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9ZTgM5XbmtKgbgW9gjxQ0kAkNkT1qIpgI0djZolV2svR8D513Ovnulr0vQ+IHBLX0fZwpWquAzWfuiJ/ZPa8y1R5TnMWwJeY6s3xU6va/l8Dtf5/qKpfbWbXXF/JXNLVvz1h/Qg4tt/3vvnSzMAEbttUv3sYMhXsAUUh3nQfS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bN34XDl/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c803787abso10620505ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728600471; x=1729205271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fzno+5iofzs/QdGIvMAmQ8PVcytLfapyMyF4iPIIXqI=;
        b=bN34XDl/8qyZ2O4U/Nop6YM4yiLMB7RJpsowt9nlVZBfIf+mQf2XHsVoo7RN2RQho3
         LVdRVM2rVAEtq4d/pSqzXmmGRqoCXQbJ37Svd3u0i9I/m1JZWCqreN0YSP9XrfCjkDjb
         JvXfH+KaBbZSPMO/qCnX5GMfZ7jsrfmeC9npk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728600471; x=1729205271;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzno+5iofzs/QdGIvMAmQ8PVcytLfapyMyF4iPIIXqI=;
        b=DDGPZg0IzATIo2/B0zYTmUNxgB4QUercs8ranyz6EzjXQ5JF9DknCbiWlifi0Qh70l
         2WEMWb5XJiveDhRfAvXmt9lyeHVbS+fcV/FuUin2WTEGevLhv2ol1IOJ/8s4k/sHD4Kt
         VU00RZDB05+/TVGJnfjLtYKsBBDvkDy8Ft2ed3g26BSAMTJODWy2LELVilWXyLAylRtG
         Hsy3hjBXgtoQUnMch0w/y7FGP3CsfOn4j5kmn8ZgiLxQoptzqyXRJ63JQ0OzaEAqx+Ob
         Q21CmBQnkklNacEagO0VQtA1BolMoeahN39tTtyQ6XVWeDxLt1WGFYiS1C2Y1QXWTACV
         jDsg==
X-Forwarded-Encrypted: i=1; AJvYcCW3/DZb1ywja/8DV3VAKuwbdfH3KH6/Im0vyqmJ2zG6UcppTPzmkoSDDLbt7ujyScYaJ4rUMKdDYf77bps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNgsomKczbc/bF2PwpcuIMyGkQfXGJ+qL8R2j46G7Z2ph+aWu
	Y4nQO7NbS8AbXsuGP1yAbyIqwHfO+/frIavoM7UW0lkkZREjX0FAzD7G7KDmpQ==
X-Google-Smtp-Source: AGHT+IFyt7Kq7CorUTWz1ypxNha2hVHLtBUGIO+gf0HSDlWmOdDnuCsKDyWIscHyrwShxZNdHL5oqw==
X-Received: by 2002:a17:902:c403:b0:20b:c043:3873 with SMTP id d9443c01a7336-20ca03d6844mr10542305ad.21.1728600470902;
        Thu, 10 Oct 2024 15:47:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1c566sm14174295ad.114.2024.10.10.15.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:47:50 -0700 (PDT)
Message-ID: <4346e237-2dfa-4779-a6d9-99d747fad9c1@broadcom.com>
Date: Thu, 10 Oct 2024 15:47:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: bcm2835_defconfig: Enable SMP support
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Stefan Wahren <wahrenst@gmx.net>
Cc: Russell King <linux@armlinux.org.uk>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240707-raspi-config-v1-0-3e122f2122e9@gmx.net>
 <20240707-raspi-config-v1-2-3e122f2122e9@gmx.net>
 <a5c69147-c0fe-4cda-8996-e46698c5e9e8@gmx.net> <Zo2Qexs-J5_Lzbjm@probook>
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
In-Reply-To: <Zo2Qexs-J5_Lzbjm@probook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/9/24 12:33, J. Neuschäfer wrote:
> On Mon, Jul 08, 2024 at 05:54:25PM +0200, Stefan Wahren wrote:
>> Hi Jonathan,
>>
>> Am 07.07.24 um 23:48 schrieb Jonathan Neuschäfer:
>>> Since there is only one Raspberry Pi related defconfig in the mainline
>>> kernel, it's useful to have to work well on all 32-bit Raspberry Pis.
>> this wasn't intention of bcm2835_defconfig. It's more focused on BCM2835
>> SOC and kernel-ci (both non-SMP). If you want to use the BCM2836 &
>> BCM2837 (incl. SMP), please use multi_v7_defconfig instead. Applying
>> this change would decrease the test coverage.
> 
> Ah, fair enough.

It is fair that CONFIG_SMP_ON_UP is different from not enabling 
CONFIG_SMP, but if we care to test CONFIG_SMP disabled, should not there 
be a specific modification of multi_v7_defconfig or another 
configuration specifically for that purpose?
-- 
Florian

