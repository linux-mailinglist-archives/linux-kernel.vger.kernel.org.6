Return-Path: <linux-kernel+bounces-243809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4B9929AF0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 04:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C20CB20C31
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 02:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EDA4C8D;
	Mon,  8 Jul 2024 02:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Uzbm57Xn"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16AC1C36
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720406789; cv=none; b=aM11cbI532Yj+AT0LcphheBQEG/LBb8oyESTAcCeFuGEQiPm1bQ24ev1SjSwuAXImaAuCEelgMLZfBNqHUe3VldvXqyae8ylqMncOqDhN/V4Zhj2GqSp9Ei6ptxgATulfcc3mzN9BxZQzhI1Qzqn7XFx7Jfs2oSBH4lGTYUCYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720406789; c=relaxed/simple;
	bh=jvWlI6H0WzHbB3vruWgcGdEKEnTqBXSXrtLsYjKuARw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPPMRChs2/4uAkyNX06narUbBu+HuWsxC2IcS6/PNqX556RyDaYWsFlTsIxZLGD3fqddpBUzzJJik0YrPBX6/iTby18oQmM+zPFVSLPA/6kYgLPwFNyVBJmQEft1E1eewgXBMQaneTZAFeH70un34DxVRivazSdKiwKyZbM75H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Uzbm57Xn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c2e736dfdeso262532a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 19:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720406787; x=1721011587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVpAXYgcvPfCEfmxtTavg7ve0TgKAAsQb7KIVF0qpyg=;
        b=Uzbm57Xnux24uGsLLmWk3seo4qqKsvORMpCjqANk8ewzgi3Hg5wval/2w+ZK74yXGJ
         ZYt9/uWtDy6zVN7iFbvAlDmyOMDIy8xsG+M0HwWNujWStXbrTItu9kmUmArasLUQIHcL
         7LkcMWHaN/W+L+WJo6RtmDVcpyV+jyWzxeM1h4Z62NmxFADMT13BsNjgYjTfpmQdajYM
         VmaiCOywYj5N8bhsv+WEIPlNMnakpB+ypOL32ckjJfJYHTuDlpFYMzKt927FaEUjjhwS
         VkCqE61yfKkLYrO8lHekpUPvkoA0JKryGRGEwDGFSSjuOpaj2pG+UioGOzo8Xd678yGd
         rs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720406787; x=1721011587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVpAXYgcvPfCEfmxtTavg7ve0TgKAAsQb7KIVF0qpyg=;
        b=IN1y1OTLKWOCheoEyIgiiCeS42ZO0grGc6Apc+xsHenW3i4PP+A9mWoDA79cdSNarl
         2MhE2QkOy+M19az3zpix4KKiMV3UiLaIcFl3E5okFUMJ/U5BuxntptSI9dIZDnugCWIe
         9ZhKfZn83I5UDYgV7k9lHIou+3wS6QO07k3n7LJTYiJh1xy3AEcqxZWfBUuT6wCvrNKV
         3AWJ/yAHBisRIpVeUfhPl+y5G/qTPEcc9ayn9uWL7t2l2KORw5mp8Tg2TmBsjfOT5swi
         veO9R0PK8FjEJfWRDxG9ID1am3h6A59RpELUj3gshsV8ejmStk8Q+J7E1jEbRhu01b8h
         3nhA==
X-Forwarded-Encrypted: i=1; AJvYcCUuiZX7Kzxzt3Uy1EETQRQkH4Kah3gxacdVKSIb/G6WPnVMyNH1qY6Wxax/uYLBnnh0VnRS3iI2hrJ+FEl8o+ZfSDAmOAolXw3CL+ss
X-Gm-Message-State: AOJu0YzqPfZh9QbZDZZ9fEdfqmHRxU0gDELBRGeDZr/wLe1TgJdM2n7r
	C9W1AklejzYBO0Fb6FipbLhgiY/LhIhtJ7EjR1Z2iNoUqDdWZmlihy/dn43EhQI=
X-Google-Smtp-Source: AGHT+IGn4ELA4XAuUfxMDlOqGohCBEVXdW9lZ2PIzjr8qX3CAkKoCnH/wR/ukKp1frR5S7cDNc2uCg==
X-Received: by 2002:a17:902:cec3:b0:1f9:b19b:4255 with SMTP id d9443c01a7336-1fb33feb2c7mr132780435ad.4.1720406787111;
        Sun, 07 Jul 2024 19:46:27 -0700 (PDT)
Received: from [10.255.188.228] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fafb9c3fbfsm107627395ad.12.2024.07.07.19.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 19:46:26 -0700 (PDT)
Message-ID: <722e3aba-e911-4a81-9c45-1111d706a279@bytedance.com>
Date: Mon, 8 Jul 2024 10:46:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] synchronously scan and reclaim empty user PTE
 pages
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, hughd@google.com,
 willy@infradead.org, mgorman@suse.de, muchun.song@linux.dev,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1719570849.git.zhengqi.arch@bytedance.com>
 <e7a8ddb2-52b5-4267-859b-e212644440b1@bytedance.com>
 <82ca055a-4b51-4db4-be7d-27b84aa70bd7@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <82ca055a-4b51-4db4-be7d-27b84aa70bd7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 2024/7/7 16:26, David Hildenbrand wrote:
> On 04.07.24 09:16, Qi Zheng wrote:
>> Add the x86 mailing list that I forgot to CC before.
> 
> Hi,
> 
> I'm planning on looking into this (again, I'm very interested!), but 
> I'll be a bit (understatement) busy the next 1.5 weeks.

Thank you very much! Looking forward to your feedback. :)

> 
> If I don't look into this within the next 3 weeks, an you please remind 
> me? Thanks!

My pleasure! ;)

Thanks,
Qi

> 

