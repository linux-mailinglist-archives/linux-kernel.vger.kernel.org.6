Return-Path: <linux-kernel+bounces-266496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0669400A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0BBB224C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61C318E763;
	Mon, 29 Jul 2024 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hdljJCHi"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7978C98
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290098; cv=none; b=ZGrHTX8dPzF4qOTzu+oU0/gyavPJZEe9OpMCEpYovSJudYmvJXerxKMGhFyevpVAoIA2xx2nFDY3fu+eJRvsO2uN6Job4mEcCkoiPK4pXaeCCXKJl2hypSUhk0bw1xneVHjIv2FRDVIsIUH6YG23w5oVraStQXlNX8oIMrqIGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290098; c=relaxed/simple;
	bh=ou2HId9eEET5KQJz+vIgoB2cqGgJmRo6+ZA7pU6JWAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKDI7qCAwYBkSvveumKld3w8XjaNgUqnF/7OKRpC60m9XNb5Sm8oJFAlSj1oaQjxMLtgNJz13EtIOZpU4UG1BVaZzWz2WLSHFTB0Ljv1MhzVlZ11r6Uud2V/8JDISmXGzYCqxV4nhLNohtSsl+WpONZPui+vb2o83JuIErNLT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hdljJCHi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fee6435a34so22160025ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722290096; x=1722894896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CLEF9d8xAX1MYB85c5r2l7pCfzF7tcIHk0yYFDkfLrU=;
        b=hdljJCHios6I2sT5+we/lMABH84joZWNxaE4KDA25kyQgq1DsIv6enbWd8/gEQ/IvS
         i/oWa76Eg7y+ukElqMBfT7NxA1/D2Z53NwDWRRwU1iMB06Kr2pi0tdevUfKF7bEaFxvk
         UkaPmxcZ2kBUwaDcrFC3U21Mygk71nQLRv9fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722290096; x=1722894896;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLEF9d8xAX1MYB85c5r2l7pCfzF7tcIHk0yYFDkfLrU=;
        b=YB+f/QJ/4hlU3qfCJIz4pV9LBhwFe+MmJe+YvX7ueQC5nM8jNq97B1diXphU/Hb1x3
         WSSlhR3OsQIWWjv8JB+b06uuombjXUVNk2nn59Y7VDP6ia2K1Z7kll8n6alsulJIfZcg
         AeHgG3arQRKKkH3VUtohRWpLPB40/2G+U54lIdbQpn5O0GKldezMnCiZ+UNocCjnk/wJ
         J8MUAS11Dn/ea3bYFrpRnQEIoBiK0Rl8Oh+cZmx7ThJg+xa3Pfv5xb7CGaZqJ4uQPw2m
         BrW5U5NUag4qngRff+02t+5ceeOM+X5NfCfP2DRK/H4KMVntSP4iy4nuwpP3F0BntL3/
         50SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq3VgRDzs85aoeLN5O9lo9juITxFPvIUEsF6aEB2FKjcCoI0roh1YgSI8S/u/iHVeHxroxkBqb8j9CpjLXLcTyQa0tRUCb50Ry/x22
X-Gm-Message-State: AOJu0Yw5YZ+Uk6Ko/VhYGiyTEQnIC2GnsA2Wqzeczgt9tO9IaqoFmnkz
	hlxl5xLDIMBhfmRtYsPSiOmN0jeoED0j85GPekScabfTnJ4ai3Nrf982I1eqwg==
X-Google-Smtp-Source: AGHT+IG/r9zkhLpaEuYpl4ECkb/cO2Gkb/pSusN7fazWiVKfz5BsWm6LEI0GDKDirNg9aTDhjqym8Q==
X-Received: by 2002:a17:903:32c7:b0:1fb:1500:17e0 with SMTP id d9443c01a7336-1ff04842412mr69538385ad.28.1722290096018;
        Mon, 29 Jul 2024 14:54:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ce0e50sm88021845ad.79.2024.07.29.14.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 14:54:55 -0700 (PDT)
Message-ID: <86f77c9b-83f9-4338-a172-b2d75fdd6f3d@broadcom.com>
Date: Mon, 29 Jul 2024 14:54:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v1 1/8] thermal: broadcom: Use
 thermal_zone_get_crit_temp() in bcm2835_thermal_probe()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
References: <2211925.irdbgypaU6@rjwysocki.net>
 <3322893.aeNJFYEL58@rjwysocki.net>
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
In-Reply-To: <3322893.aeNJFYEL58@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/24 08:53, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify the bcm2835 thermal driver to use thermal_zone_get_crit_temp() in
> bcm2835_thermal_probe() instead of relying on the assumption that the
> critical trip index will always be 0.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


