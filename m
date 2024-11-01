Return-Path: <linux-kernel+bounces-391925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB629B8D69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FC21F23CF4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DFF157E6B;
	Fri,  1 Nov 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITsE46Gv"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8814F121;
	Fri,  1 Nov 2024 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730451772; cv=none; b=NJAWiq2X2OU/3ufQ/P1SxDSL5pfo9TvJN2ABc5fIrdDHh59dn8ro9OM4yR+sqy+jjD6mFaj3UcIshVSmXR3hSe+AgVPJDPDEjzlGOoRz7302SXfO8S3PJG+aS29jyHezEa5BjiqoZMo8j59bwPsr8luhlPEmVDjqr7QOa+ajQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730451772; c=relaxed/simple;
	bh=jpX64miZjSicPCvHWFljeurBNjrKOA7kXE/Kum3w00A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEAI8DVPJdh6PNoGA7HZYV+xqeZB53qvHXGiwTuiwCdg5B2uzxsifX7O3t4jBXdlDdmcwi1lgBDms3WJf1BB4W4szrN8UQ8AtYlPbQyh31eNYuY2ggKwOlwKUxYsbSLSa2YAfVJsEG8fj3Mtg2yvFGYyfi/gvtKnB9tsFGGUmac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITsE46Gv; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso1352918a12.0;
        Fri, 01 Nov 2024 02:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730451770; x=1731056570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K5wIpO3UePnQeHMidc8/MfjJKyjpUxm9tMd6myVja94=;
        b=ITsE46GvhnA8HB5pkGtle5ndsoDgKQIr8/3OXCg46CWgjbnEU4WvXMgjL0v+QHB+JB
         85OFRjy8OCIMcC48jvN3PjSwq61Lqlgc7RIiIkutbc9gLXidp6zTfSp/9FlftwVMOT33
         c0AOIf8rsyPoW1e81b6oddPht/VWLy5QDCegcrKsd8lbs/4a3YdtK1JZpv65ow6OT8XK
         4I5RFhTWGMKatOV1q7QZ+mMME221IwIvv52u6iJyCg2v3I0VMDzG6IXRpQZbaZPtns/5
         8zLNzhMI/SP40b+q6caZR+h99YdcldBSOTIOkiJQcDKUVqh0spqVe6r2QeAb1C/o/0dT
         SexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730451770; x=1731056570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5wIpO3UePnQeHMidc8/MfjJKyjpUxm9tMd6myVja94=;
        b=nxpInAHmqExymme9fk5bzvol9slnxWdpYGXwguA6GpNKQ5E3f6+zPmHtMA4fGDsCgG
         xUdCX+Cl/d7s229/x+3CdWHcAZTHkiHVzoptG9YlUhe2RFZxzNHyKntlKjj+kvJIefPR
         1FmsRx1n8GMCrFlrs2Hi02quenTBE4jGfI7SjZeVsdHJBBSktMV7ZAchZ35NCANEIDem
         xATXQV+U/4w1ucmyHvTPluC0kmRltOmymbRNIR2tndqSB/FG+IMCYhLe3upixDwwyZds
         hnniSV3CrvQ56doef0bw/6CX3pVSEygZfluEzGDFqIgEUP7Y9Vs8ALccyRPOi0q0QOlX
         jR6g==
X-Forwarded-Encrypted: i=1; AJvYcCW6yK68IZqwRnm3X4Zrgmu1x2vRHOYo9p8hNnoUZc5m918waXO2zdbtwBW24sL7NtKr2u1K772Bw8fFgjQ=@vger.kernel.org, AJvYcCWR1FlW5KWtp3dXgK8cxsu464LGtcngVs6y45QUTuarh9ccoXZvtjG+9oC/ARPQXn3hROlatJgBEgAE2Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzRN+zwZiqYkGlBjF4FpzAkPK1BTKgTATdS3KkTdu1+MUbRWxU
	LzyFwgXMxEOGO2g/VSXeu5/OFKAtTKFcRTVadtpjNPYkztxh4RHf
X-Google-Smtp-Source: AGHT+IHTtQ/wgMIUcwz+wAKo34+msM4cr405X+Z9eZtrm4KWfXxpkr2F4pbmroM2VK4G3qvTGyr8pA==
X-Received: by 2002:a17:902:e741:b0:20c:cf39:fe2d with SMTP id d9443c01a7336-210f74f48e4mr123100245ad.5.1730451769676;
        Fri, 01 Nov 2024 02:02:49 -0700 (PDT)
Received: from ?IPV6:2409:40f2:1005:5df4:82b4:ad58:ba20:9155? ([2409:40f2:1005:5df4:82b4:ad58:ba20:9155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edec1sm18466215ad.50.2024.11.01.02.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 02:02:49 -0700 (PDT)
Message-ID: <e8fe072a-e1b9-41b0-9382-6562139e31d3@gmail.com>
Date: Fri, 1 Nov 2024 14:32:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sound: fix uninit-value in i2s_dma_isr
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241030170829.36161-1-surajsonawane0215@gmail.com>
 <635f1691-74e9-4e48-8ebf-8e7ce0c6d1e3@sirena.org.uk>
 <a4039ca2-6c76-4431-8e27-caebe1a56deb@gmail.com>
 <d97a58c7-347b-48f9-aa69-d4ff5a4038e3@sirena.org.uk>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <d97a58c7-347b-48f9-aa69-d4ff5a4038e3@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/10/24 21:47, Mark Brown wrote:
> On Thu, Oct 31, 2024 at 12:17:56PM +0530, Suraj Sonawane wrote:
>> On 30/10/24 22:44, Mark Brown wrote:
> 
>>> This will shut the warning up, but why are these values valid?  Are we
>>> handling the cases where the loops do not execute properly?
> 
>> Thank you for the feedback and your time.
> 
>> The uninitialized warning for val_1 and val_2 arises because, in some cases,
>> the offlevel value is zero, and as a result, the loop does not execute,
>> leaving these variables potentially undefined. The subsequent code
>> calculates prtd->dma_addr_next using val_1 + val_2, so it's necessary to
>> have val_1 and val_2 initialized to a known value, even when the loop does
>> not run.
> 
>> Initializing them to zero ensures prtd->dma_addr_next has a defined value
>> without triggering undefined behavior. However, if a zero initialization
>> could cause unintended behavior in dma_addr_next, I could alternatively
>> handle this case by setting dma_addr_next conditionally when offlevel is
>> non-zero.
> 
> This is describing again what the patch does, which basically just boils
> down to shutting up the warning.
> 
>> Let me know if there’s a preferred approach, or if you'd suggest a different
>> initial value for these variables based on the expected use.
> 
> We need to understand what the change is doing - what do the values
> mean, is the real issue that we're missing some error handling for the
> case that lets us fall through without initialisation?
Thank you for clarifying.

I reviewed the context around val_1 and val_2 in dma_addr_next. These 
values are expected to come from the registers when offlevel is 
non-zero, representing the next DMA address and length information. If 
offlevel is zero, it means there’s no offset data to process, and 
dma_addr_next might not need updating in that case.

A more precise solution would be to conditionally update 
prtd->dma_addr_next only when offlevel is non-zero, as this would 
reflect the intended logic without relying on an arbitrary initialization.

Would it be better to revise the patch to conditionally update 
prtd->dma_addr_next only when offlevel is non-zero?

Let me know if this approach aligns better with the expected behavior.

Thank you again for your time.

Thanks,
Suraj

