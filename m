Return-Path: <linux-kernel+bounces-323491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B99D8973DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481AC1F270D8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C191A0B16;
	Tue, 10 Sep 2024 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JHEB+Ngm"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B219E7E0
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987570; cv=none; b=m4jrMjWG+LKtux1XiA8d6ybmOGs8q//fc0HZOBkiYRAje250hu7ycvCVLqUp1OcxBc5LuDFGnOhMgdxZovoYmuy/LNl8dbeH5UO+DNiL7W0UKFfqqBpLD9Hmc7cTm4AyZ+b8JK3Rrw34ZLsv1joaSf4FhlZ+mv4wbD6vtciO1fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987570; c=relaxed/simple;
	bh=CV/+Xsvud6NgAwF9/16qZCiWRnmYLavG4/G69hQhyac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7Zp3JfDgEFtaaGxXxyrJe3udSu58wLHsFcS2JNEAkVj+i/BcjEpslW7yuTVPq1vr6if3BIwmj0BFsfpAkqmeueBFJBYlF6m8HFku9ZmlkRIkCgOAnPytPpYLWwBVzv3r1rTCBqkznYusS4STbPRR5dzxlv+Yo9LlJR2JQvxKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JHEB+Ngm; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6d6e2b2fbc4so55765647b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725987568; x=1726592368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U/6PuAoHVqwJAn9H3E/ApoOgwWszRBjm1/LVCy6+Tvk=;
        b=JHEB+Ngm8k0inM/GRD81oVFuzlyPPlH6DdefJYEDSKJcsEFxMJPFW5a95cXg7FGNA8
         1siubzLEqiz+PhCzCncWpR3Ofx07hdXqSI3yrvHC9X/NHR+JA/dgvuMluoZK6LapCq37
         nfA3gr3QZ9bJVTGiaXJSw3K2uQ0Ziu6ooFWqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725987568; x=1726592368;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/6PuAoHVqwJAn9H3E/ApoOgwWszRBjm1/LVCy6+Tvk=;
        b=QW132M93va1Vr1QnC5gfcVaQuEfhClMoS1qjRsln320vMk+eSUtCc8w4vASpktVlzE
         LjdiRgRLye/07PEr32cFg7CQDI8Brpq4vvlDCt8ZBHkEErvN/+w1aMyv4jVOWkrDGS9z
         Dc8gS07Thc83JtyspLbI/Ba8ZLCNEqJVUvFLpLKcLdaW+bovDDU9ctistyRekad962Zj
         +jTS8dZlxGvuzza0cRAuXEnTW7VVW8pGIhhH+lInBC4xbtAnN1b/zh7Z+lq1Cz84/N27
         sKYQcuqOp4/oU3+u4wIoIojZd9g06fl7uumYnGVWreVU7JivN8Kk+SpWQSwQHHV1CWjv
         0CpA==
X-Forwarded-Encrypted: i=1; AJvYcCV66Gf2PP7iiOOFo1LrX0QEqHM0zK4WaExoE75oHNgV9gQD7Mrcm7xiR7fi8opyVG9YwG5FKPqD+PBkjeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdVHVXxFoy3e/n1Ry2ik6WkeQgZl065Q2Svgc31I2Lq3QwTB1A
	gCJBZKe7mB18H9gWWl1Ig/7zbIHhphVTKvXoa3P6IUoRid0VRSjyj2IIM5z67w==
X-Google-Smtp-Source: AGHT+IFvOdcW30wX0d70oj+1ll0GHS5mjd10vuBsPBd87hScoQyIYWMaCVt44EOZ8QoHtMQsNNIIPQ==
X-Received: by 2002:a05:690c:4982:b0:6db:2d71:916 with SMTP id 00721157ae682-6db44df3824mr193377797b3.14.1725987568340;
        Tue, 10 Sep 2024 09:59:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d6a2sm31678716d6.90.2024.09.10.09.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 09:59:27 -0700 (PDT)
Message-ID: <9de505c5-d9a2-44b7-8db1-0686c61a0fb4@broadcom.com>
Date: Tue, 10 Sep 2024 09:59:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 05/11] PCI: brcmstb: Restore CRS in RootCtl after
 prstn_n
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20240910151845.17308-1-svarbanov@suse.de>
 <20240910151845.17308-6-svarbanov@suse.de>
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
In-Reply-To: <20240910151845.17308-6-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 08:18, Stanimir Varbanov wrote:
> RootCtl bits might reset by perst_n during probe, re-enable
> CRS SVE here in pcie_start_link.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

This looks like a bug fix, and we should explain what is the user 
visible effect of that, if any.
-- 
Florian

