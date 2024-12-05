Return-Path: <linux-kernel+bounces-433839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02839E5DC4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB315286A2D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F254218E98;
	Thu,  5 Dec 2024 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eX0DFtCY"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF01922FB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421435; cv=none; b=TgdJTpWWLStaCo/FHfOwZQOSTxWSFfO+/vTFxaE7wZDS86xFHYfAAMY9yOqCr40Y2/EI2QoQMHrP2uMIAtmxLI/8gvz2HmdOzRGCe1FM2SWOnCVtEALbDSo/ieDumQFgYNqSc2zeaubO3TvFIE19zv3NlgL7X8PKXlPxRdMQjZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421435; c=relaxed/simple;
	bh=ksjPyuTpDB+ZqsgyZdj4++u7fpg6HEpctnTyj0TXg4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HB2d3acI3qhjqf9T/ft09LLWkIiS3pSjdfzxpcii3uPkLfmclwXHk0EHBc5+DCpHovTifjOwwHVm0uQOq0/7ioONPUk/nsL8+zpplFnQ6Ecn20PaPCG7lW3ei3YztyEbvUDiGxT75g1mMFxZwK9KxjYfWJRrPfElqoLNIMYZSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eX0DFtCY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-215513ea198so19351265ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733421433; x=1734026233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=avMOWjy+c8T5RuO+LrVoekVtKB4YR0KJXvWTQ1odDyI=;
        b=eX0DFtCYyu+/gYg/gwtoi0oI1n+apiwf5GP4vd0Nj2LNtoBkRbJckHVKRUHvm10Ik3
         IgwUjqqN6Xm+TO1WMypgwYHIuYx4InlADTMnenRm5RR4jeSI0XUFwB5lkHwx8tjSdzzv
         IYwwirAKO+t3IHJ3A3M7+9jeBB37RcbqgjR2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733421433; x=1734026233;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avMOWjy+c8T5RuO+LrVoekVtKB4YR0KJXvWTQ1odDyI=;
        b=mi8wHXunafI4XKlpXQMMoA8sH5H0ykkpg2/CSwVocXARQRfCveqZn579bHy2kbwiqH
         lVCut9MRZg2EvDWaf3HuEiwhs9fH2qCfiUcmS8lmfzYgUXBXctlPN2NnI/BmHityHoQ5
         kZM1TLs5doQ6MxmfhrSmbVfpM+wtmXCiHaeQ16OZEQTpsUY7L2r9ViRPpWVhezK3GTzq
         1G+NP3762f+20FnVnDyxpko0ZQdo5cxFscz6TUlTojzMRdWsL3U4a4hD1qvdNXadDi32
         O4ZKjoGOg57Rof/HDpsToFs9lyEgX6zZU8dT+/VqLR96ItcF9NctsCEf0Cm8SYVU9SmM
         fQrw==
X-Forwarded-Encrypted: i=1; AJvYcCUa4AG8huki/a6EYO2Ff8DK5dK2TmtYkr5BQdn79nDhT7Asw6lLrrAYucLpJSrHcbfyUfdYguvAE9QnsnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwunGiAU8lkIb3uXz9VmsF/EACNB4iVMM6lfb4Sy8mq8MFuBWaT
	N6xG3TSAl/13Laxk1XR3FVzSunPhvLpypp+kYzTprzdUUkk66SO9TSy7WhXMDA==
X-Gm-Gg: ASbGncumI4CWa7s7FY9RHH6cqMCnTmnKuznXXQwpdZtS6G90E7op3fe/gDsVczDoMLK
	X4JGrQcyvKKmaUpcV/26WZGMHdNx6D1nu6wfrUtssbhm1awLkLqETP4ZpAOfaKNyPHt/gN4ZIcK
	zF8+4AOqT3bdO4QTJAHAHGf3wZctAv1P7OMI9j0Auhk4xTs5ydMnLwB/GgScs5epugoC+2xV53f
	Ewc0dS9b6lmfhwXaLJikpxozrNXEzK+cBtfSX06uaOHK5xBjrkH92ZAHxj8MSrrj5XUfX7ePdkI
	AflPm5VLp+C4Yg==
X-Google-Smtp-Source: AGHT+IFgsVVlPG9+Wn3hT1Hsyr7ao++zRisPnMNV+s/xngMMB1mTMRm+C+x9HzhPMusLqeLaGRVKNw==
X-Received: by 2002:a17:902:e80c:b0:215:58be:3349 with SMTP id d9443c01a7336-21611109e47mr3511825ad.14.1733421433481;
        Thu, 05 Dec 2024 09:57:13 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f09167sm14880245ad.200.2024.12.05.09.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 09:57:12 -0800 (PST)
Message-ID: <7c3c49e8-95fa-4382-a5bc-eccef6d89ed2@broadcom.com>
Date: Thu, 5 Dec 2024 09:57:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT PATCH] PM: sleep: Ignore device driver suspend()
 callback return values
To: Len Brown <lenb@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@google.com>
References: <08f3bd66d7fc8e218bb6958777f342786b2c3705.1731554471.git.len.brown@intel.com>
 <CAJZ5v0g1JwGRECd2JVKScWO9a=hmrY03YQx95JKZ+q5KisRb1w@mail.gmail.com>
 <f6621a09-d5e4-4d3b-9b5c-55294c22030f@rowland.harvard.edu>
 <CAPDyKFoJ45PZ_o6VdaCiyat+BC6XOZ5AMnxmsZVzk16cCxmDkw@mail.gmail.com>
 <CAJvTdKkqO5D8tZt3L_dbXkXftUOz+zijEjQiWHginn4t_o4gKQ@mail.gmail.com>
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
In-Reply-To: <CAJvTdKkqO5D8tZt3L_dbXkXftUOz+zijEjQiWHginn4t_o4gKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/5/24 09:36, Len Brown wrote:
> On Thu, Dec 5, 2024 at 10:33 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
>> ...I also think this looks a bit risky as the current behaviour
>> has really been there for a long time. Who knows what depends on this.
> 
> If everything were working 100% of the time, no risk would be justified
> because no improvement is possible.
 > > But we run over 1,000,000 suspend resume cycles per release in our lab,
> and this issue as a category, is the single most common failure.

But you are starting to enter the big number category here, eventually 
something is going to fail with that many iterations.

How was this 1 million iterations determined to be a good pass/fail 
criteria and just not an arbitrarily high number intended to shake off 
issues? Surely with such a big number you start getting an idea of which 
specific drivers within your test devices tend to fail to suspend?

FWIW, with the products I work with, which are mainly set-top-box 
devices, we just set a pass/fail criteria at 100k which is essentially 
assuming there will be 27 suspend/resume cycles per day for the next 10 
years, given the lifespan of the products, that seemed way overboard, 
realistically there is going to be more like 2-3 suspend/resume cycles 
per day.

> 
> Worse, there is a huge population of drivers, and we can't possibly test
> them all into correctness.  Every release this issue crops when another
> driver hiccups in response to some device specific transient issue.
> 
> The current implementation is not a viable design.

Neither is this approach because it assumes that drivers that need to 
abort the system suspend call pm_system_wakeup(), which most do not, 
they return -EBUSY or something like that. There is a total of 12 or so 
drivers calling pm_system_wakeup(), that's not the majority.

How about you flipped the logic around, introduce an option that lets 
you ignore the suspend callback return value gated by a Kconfig option?
-- 
Florian


