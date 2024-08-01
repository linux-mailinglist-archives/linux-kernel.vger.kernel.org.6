Return-Path: <linux-kernel+bounces-271632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21889450F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DC7289236
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E488D1BB69E;
	Thu,  1 Aug 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QrgBotrv"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E0F13C9A3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530392; cv=none; b=RDqowCPwz7D2Aath7OmzSs2DhDSJVmPV7/6DE8nl66NM1m5P6edEvpvrRHZM6rVqRD+V889Ee0AgJPjVudMui+Xdkn8Diotwv5jmA0D4ElmVgJeZqWnsJ9Nm5hWgs+nf0LaH8d5PkR+biajg926sf4FAiRC+/ihV+bJn+h7ve0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530392; c=relaxed/simple;
	bh=aW+yw24QKP88WTD79MuAJZ7KUYCV+Xdm1MDXXAJ5l/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTiE1lo/JwFyAswdb5PmtzrgOH/+KzKvQ0b4mAX9xPPyslyJlWVD+W79tAYyCHirv/LBXMFIrAUCk9RhVFqG1uy+8QYLXvdtFqCmvbnHrIANPkygHJR9NWS9xcGALPO+17uXruzRHyimt64c5VrwLVgBo7oCvVUW2aX+MQubVE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QrgBotrv; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-70944e9ef03so2734780a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722530390; x=1723135190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BeRWGc49rA0cbsyfnYv2lqBGC7Ym0PaJzvtvRqlZSeE=;
        b=QrgBotrv2dTfknohvsKO9dCBJJkNCXPMzgI9YKxiitHJgk0jkLFJyFTp01DlOLwLWO
         e4N8PH9Pde7gPYEW/ozlrSAhp3YdneVmajmEXYhimEdXyJ11Zg/5YcUkgZ0M/c9r29TU
         gtu9v7dtCQXbB3/0BhYCgLa4RtOfQ6j8qhQug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722530390; x=1723135190;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeRWGc49rA0cbsyfnYv2lqBGC7Ym0PaJzvtvRqlZSeE=;
        b=IECvEohAwex0C6PnXcu71AP3z5sKTrYmyTFZveJ3VYP/FqCNGBg8MSGotkKdo46tHi
         tWCSQNSx/rdh6DvHd+RwOV++TdosxOmcy+5YbMHP7lYB6Yt9BUA1NATNtIUT+96glcmg
         cf20jQQJMnXAKVKiiAdudW9K4HOFx6Nk30VnQMQH1CrnJN6cRDrqurYVNIiTmcJXdsk5
         xYTArQMf2DTYYCCd2psPxNi+fwLrAtDu1c9OOhaNKQ40FmWlSaxh6JLXIc/gEEKAvck2
         +qCCc3k5RMmXlf7EEDygjPBfZKj9OJHK1X0hXAETIiCFVwiGuTuMR5Sov5grZD5rh2Qd
         AZmA==
X-Forwarded-Encrypted: i=1; AJvYcCXwN0KusqXBbXfnS+yNkDzYbTxy0ENudmxqfe9EntG39ZAaG0zk9xBqE1NDzlxMVVV0Zqlm9X3bwPArNK0P6NslGjgIchJgyoAWZErA
X-Gm-Message-State: AOJu0Ywe3SnQfy1xLcm+5DYO/6NOeZBk/anbY2Hy4AlIgOTJ8q1KPWzd
	Af1Pt0clN0Rw0CXE4ccvo5XHWf5nbGL7pQsZmZCxCcfCLMgj4ca0DbwPkNZr+A==
X-Google-Smtp-Source: AGHT+IHTLjSe4CM1bHyfWUSFEWK1u2FwUf2Nrg09R4P8bGlYpYia0doT5FCvFJ/hT3egJdz5sNRMIg==
X-Received: by 2002:a05:6830:620c:b0:709:427e:e383 with SMTP id 46e09a7af769-709b996de01mr940071a34.27.1722530389700;
        Thu, 01 Aug 2024 09:39:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb99b500e9sm206806d6.107.2024.08.01.09.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 09:39:49 -0700 (PDT)
Message-ID: <e80553a4-723d-4b97-a0dc-3335b3991fc5@broadcom.com>
Date: Thu, 1 Aug 2024 09:39:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] PCI: brcmstb: Refactor for chips with many
 regular inbound windows
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-10-james.quinlan@broadcom.com>
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
In-Reply-To: <20240731222831.14895-10-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 15:28, Jim Quinlan wrote:
> Provide support for new chips with multiple inbound windows while
> keeping the legacy support for the older chips.
> 
> In existing chips there are three inbound windows with fixed purposes: the
> first was for mapping SoC internal registers, the second was for memory,
> and the third was for memory but with the endian swapped.  Typically, only
> one window was used.
> 
> Complicating the inbound window usage was the fact that the PCIe HW would
> do a baroque internal mapping of system memory, and concatenate the regions
> of multiple memory controllers.
> 
> Newer chips such as the 7712 and Cable Modem SOCs take a step forward and
> drop the internal mapping while providing for multiple inbound windows.
> This works in concert with the dma-ranges property, where each provided
> range becomes an inbound window.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


