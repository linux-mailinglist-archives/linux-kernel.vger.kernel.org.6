Return-Path: <linux-kernel+bounces-537567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EDEA48D92
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE9A3B4009
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D32748F;
	Fri, 28 Feb 2025 00:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFrOYCGR"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED52276D34
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740703887; cv=none; b=dToY5++k3DIAkK9BghGnrIVcsLqVKaUxoHG61Ar5vh69Wxd2h3xo7KD/aXcNBCxI2kTmlSceGgGhlTK7/6Hy7PtzoQDSIoVbM9uMS551e398q0B7lBE2c1phV2HbwwxDKgfSOzRB7FFksHDUXUxdBOWRcpTWnAeboq6xlaz1Dlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740703887; c=relaxed/simple;
	bh=mbWvNzOAlIydbE1Inz7ynKIk+hgmCs4Yk1OknKRyGN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvTNn2RJj2jL9Bvc6EkIloMtYByJZqCOF6Qlg+pyUpQfo9WBS4NiWoFPtsqqr147wgQZ48fBSwBAwsrD+M/Ey6HygP8jungqHwmZrl6O4Evt3p095Q0JMMjjyhVCFCbUrtHQxqi69EfCTW2+/QHWccpLq9YezWfVYDJWrfViolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFrOYCGR; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-438a39e659cso10908185e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740703884; x=1741308684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYYhVBJMV/KkTWkQqY+F3s+lGTl4si7QLi3D5XzPjGg=;
        b=SFrOYCGRA2FPGdpa4lGIiSSQ1ZSv3rwPftZHzNmqbXP+uhBWxNxsZjAsQPwCL0Rgka
         0kJ3cEOekHfSPuZBZm0A1YV3d1Z42F7jxX0gz9HvosyI8sbv206asfn4p2EBXkkIz/lh
         T98epqm+K6+DwkDg2D/eG8RuL8oajL1FrztWCvcloI+e8RtYg4vXioJlwU0qm8Yhu5iz
         2KusaLYoCqGsWmeS0OP9jm9UEytQnlm/bHiZVWKaP5qtS4q9dd8JpA+C6kNXbHWqdIJM
         xMbtrwTr0U18UxQOBv46lvQ+l+gkJdluFcyQdXI84A2Z8wJsPL4A0DoWUbnDXqio/P8R
         JVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740703884; x=1741308684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYYhVBJMV/KkTWkQqY+F3s+lGTl4si7QLi3D5XzPjGg=;
        b=Iu7m73pOMyq6kC+NT6t/buBLUxl/scfTDOBSfcCSrwggSnNYXNkTdCw1M775OHWAVP
         wEzEEJz0l7pD+RinT8InjTfqdj6rRhzses0QlhzJ35tfNchBvJWiXYLRVKbr5HzDQXM1
         fHwySpp8Y0XrhOu7jQg7dVEhU/VwfnzQYD6imDuF0pVYJ1e7ZsOAMVjLPDoaPDHc/Tun
         xGTpoge9mAwrk8kcV6c3h+3sqgjBuKq2fa4yVs5OOK+N0sslLrBJCD0hpvf56mUpHPHb
         dKIZpvjQSp9ZKe2qWpOvXnMoqXF2l2lf9qsVUc5eY/aH7mYJZ6VBg70J6zufib7GI4Oq
         e8VA==
X-Forwarded-Encrypted: i=1; AJvYcCW595LPFKKr4wa3vYe35F+baW71iWlZU/b8BvGECtDDb5jiKAyhgES4h3pjaa+plv7ZZl9FEOku9ugzzcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp2u9S/n8XIzC0vQVHqaOFWzC1vGVef0aVf05gTbxrKR2VZ/Mv
	kdzs+BZxjKNXFKkrJwT2eqSN/AlBieD3Obm4YGiIzUymJACaG+IZ
X-Gm-Gg: ASbGncs08+m/7FPNbIc3+y4MdWV3YUiEpSJ0tTCu+bLIFPjDffzdRnBkmuLdN5w+ZwR
	NiNIWmEUGxGzFMupFPOU6satRVfjGpsA0cy0QAqlv/4cqMI0/d6ReCKRD/1twlKjckmzBk1uwKt
	aZerlOxOjxtZPv5+oc1edgsV09OGH2gm4I9far/9pjWaE3MWz9MoWS8j1m4zMO0GqgMHQ8tXKeg
	YEe9CtYNzczh9NL2bziOrYwXbr3BxeS5u5bNNj/5z+FH+4kD5PUs49WP+Tvnst33XHxt014TBzz
	yqWZj2+TkFYYGUPDsGf0QY9ZaIsXxlPzH1WV2V+nzX3zA1cIman/Oj3snlZACFT4382AspatTRS
	QEsgqGBkq0F4CUhse3//1oCHzRqkH5ZNlRVPLEFsYvg==
X-Google-Smtp-Source: AGHT+IGEwAvaRf/47+Awx+9/XO+1Ue4pwdfkjzEFVpRwXK5AT2/emQX0Zv8uZLBVyVlvheJHe51FBA==
X-Received: by 2002:a05:600c:4ecf:b0:439:9a40:aa03 with SMTP id 5b1f17b1804b1-43ba66da2b9mr8992775e9.2.1740703884240;
        Thu, 27 Feb 2025 16:51:24 -0800 (PST)
Received: from [26.26.26.1] (ec2-63-176-201-248.eu-central-1.compute.amazonaws.com. [63.176.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717171sm38100555e9.18.2025.02.27.16.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 16:51:23 -0800 (PST)
Message-ID: <7bafd132-6a82-4313-b25f-92fc16faf917@gmail.com>
Date: Fri, 28 Feb 2025 08:51:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 dwmw2@infradead.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca>
 <888f41b7-dac6-4faf-9f71-4d7bea050e41@linux.intel.com>
 <33c4755d-6a0f-4734-88e0-84f0de67b652@linux.intel.com>
 <83039906-77f7-4318-94bf-4c98bb3f0e32@linux.intel.com>
 <20250226130423.GF5011@ziepe.ca>
 <f29818dc-a0a7-46c4-b541-1b469a6b3304@gmail.com>
 <20250227203855.GI5011@ziepe.ca>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250227203855.GI5011@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/28/2025 4:38 AM, Jason Gunthorpe wrote:
> On Thu, Feb 27, 2025 at 08:40:31AM +0800, Ethan Zhao wrote:
>> On 2/26/2025 9:04 PM, Jason Gunthorpe wrote:
>>> On Wed, Feb 26, 2025 at 01:55:28PM +0800, Ethan Zhao wrote:
>>>>> Provided the system does not respond to those events when this function
>>>>> is called, it's fine to remove the lock.
>>>> I agree.
>>> I think it is running the destruction of the iommu far too late in the
>>> process. IMHO it should be done after all the drivers have been
>>> shutdown, before the CPUs go single threaded.
>> Hmm... so far it is fine, the iommu_shutdown only has a little work to
>> do, disable the translation, the PMR disabling is just backward compatible,
>> was deprecated already. if we move it to one position where all CPUs are
>> cycling, we don't know what kind of user-land tasks left there (i.e. reboot -f
>> case), it would be hard to full-fill the requirement of Intel VT-d, no ongoing
>> transaction there on hardware when issue the translation disabling command.
> There is no guarentee device dma is halted anyhow at this point either.

The -f option to reboot command, suggests data corruption possibility.although

the IOMMU strives not to cross the transaction boundaries of its address 
translation.

over all, we should make the reboot -f function works. not to hang 
there. meanwhile

it doesn't break anything else so far.

Thanks,

Ethan

>
> Jason

