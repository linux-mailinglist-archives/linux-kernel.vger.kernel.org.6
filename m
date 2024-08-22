Return-Path: <linux-kernel+bounces-297051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B02695B246
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417EF1F2464D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8228715C156;
	Thu, 22 Aug 2024 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2BfALIl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D113C9CB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320000; cv=none; b=OJ65Kvu7ur36fZ2uDB8nMMT/7LV9VVjMb+zdJswHvhkhpwnv+1ZlqXXPTtIKRDYxNZUlhkxkW424KnZ6VHdAefstTw5zsEpGe6ZoheWynqD0BdhlxyAWEStR9JEcI+eGogb/PHhHN51O2W0fjN7oCrrS3S8owvi9RiV9We8xXpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320000; c=relaxed/simple;
	bh=9LgryV2GQqe/l3lws3rfKC2TYYO9HW3gUt67U7qz7g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLpBLDSMFkQzUCgWTmyDy7KbtuMaWQ4Fk19AzrHFMoghF8WtvGmYvSzV0Iq/laNs8NaDn/1jAlM7sJt/uSpLIa1j2eGL3xyEBYRP8DkTKMcWc+3NQZPF8GoY9xkmrDfLHGf2vFS74JcU3ixe5UQ/T+TMQlLXQh2P1PaH1vzaLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2BfALIl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724319998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ggRp79wknNfn3alru8HeXa4AZlJP0k4bw1WSXsEJS38=;
	b=N2BfALIlS0BDHFT6SDxHdz16VrT3lZa84S2MVdu2Uw2QvD1MBovFQhfmJbHNKl0APPEjGf
	9eTBRYgW017SLzmH7fAwk5gaVMYiCmHX4TbHYQOTUjMTBReiAMSgSgqWh4arIFZrd/wTgu
	1uTWlkOTuJKOo7zN/RHvklk1uZnfxaI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-k2Pi9uwkPwagrQ0U2z57vA-1; Thu, 22 Aug 2024 05:46:36 -0400
X-MC-Unique: k2Pi9uwkPwagrQ0U2z57vA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f3f6a6e3e8so4588711fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724319995; x=1724924795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggRp79wknNfn3alru8HeXa4AZlJP0k4bw1WSXsEJS38=;
        b=tADQTo/baxFhw+WYC3NlctcAEGN6QD0Yhq14NQhJ3uOQpwYqdhW7/nHzTyLoUiMJgK
         p8ka/d6T77hzFji8Ec1bQjN/5tRSN4OntVqn7sEGmpGrsJ+TfpsgBzs5896aAM5ck2u3
         gfFXIHp8axFVm3JtiW+9I5zSBl4++Z6pi1EQ4izdrHW7VJBOlJc0kBDF1/vM51IGonoO
         LQusLbBECKGYRLWe9v5UHp9L9KeqBxfCbuPdaRrBNERE9Kfm8FEVqHXjWMTqSyLcV+Kw
         jIQLqFHDB3lvrEc3A6LlZZWbxEqs5GHNWAEOxlBFITtRBqbM4qf3nLf1uIh8P3IfqY+A
         286w==
X-Forwarded-Encrypted: i=1; AJvYcCVB3FVzcZ1ouqROebrEf8NX5gr4Qbxb5VkzHBZZxEp6g20yUpYw0854Z3oCNyqK4wLGTu3GUoLJax56feI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6GIgSikoed72/YKxeslS2sYnbXvT1R4aZZSkdH/4xWqnoYa3+
	mELVfeGWzhsur8FExa31hbniiq1DhYf8uK6VsangMz093QO9ZWMw1uQOTXjyzmQQe+I3STJ2zJz
	ImWPnLDpwvsLCo0+uivRIIWGGkWQLtmb/CkmpB6TIoU5mE0qD0QpXdGCKOJoaFQ==
X-Received: by 2002:a05:6512:3b8c:b0:52e:fa5f:b6a7 with SMTP id 2adb3069b0e04-5334fbe5954mr1009814e87.13.1724319994700;
        Thu, 22 Aug 2024 02:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9xW+dmd/gXKMsIZeDVEH8teo4GMrxkxKCOlqmTdl1N95CvydtAPbONpi1qEeEezfv8gue9Q==
X-Received: by 2002:a05:6512:3b8c:b0:52e:fa5f:b6a7 with SMTP id 2adb3069b0e04-5334fbe5954mr1009786e87.13.1724319994097;
        Thu, 22 Aug 2024 02:46:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2ca516sm93612966b.87.2024.08.22.02.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 02:46:33 -0700 (PDT)
Message-ID: <0923283f-0b7a-4dcf-8d22-b55595b1ba35@redhat.com>
Date: Thu, 22 Aug 2024 11:46:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/platform/geode: switch GPIO buttons and LEDs to
 software properties
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Gross <mgross@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Borislav Petkov <bp@alien8.de>,
 linux-geode@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <ZsV6MNS_tUPPSffJ@google.com>
 <a2366dcc-908e-41e9-875e-529610682dc1@redhat.com>
 <ZsYu0SEy8ZUKEJqP@google.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZsYu0SEy8ZUKEJqP@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/21/24 8:15 PM, Dmitry Torokhov wrote:
> On Wed, Aug 21, 2024 at 12:15:51PM +0200, Hans de Goede wrote:
>> Hi Dmitry,
>>
>> On 8/21/24 7:25 AM, Dmitry Torokhov wrote:
>>> Convert GPIO-connected buttons and LEDs in Geode boards to software
>>> nodes/properties, so that support for platform data can be removed from
>>> gpio-keys driver (which will rely purely on generic device properties
>>> for configuration).
>>>
>>> To avoid repeating the same data structures over and over and over
>>> factor them out into a new geode-common.c file.
>>>
>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> Thanks, patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Question has this been tested on at least 1 affected device ?
> 
> No unfortunately it has not been as I do not have the hardware. I am
> hoping folks on geode list could give this patch a spin.

Ok. I assume this is part of some bigger plan to remove platform_data
support from either LEDs and/or the GPIO buttons ?

I would rather not merge this untested, but if it is part of some
bigger plan, then I'm ok with merging this if still no-one has tested
this when the rest of the bits for the plan are ready.

IOW lets wait a bit to see if someone steps up to test and of not
then lets merge this before it becomes a blocker for further changes.

Regards,

Hans



