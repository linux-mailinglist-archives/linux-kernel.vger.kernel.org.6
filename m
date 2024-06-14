Return-Path: <linux-kernel+bounces-215095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA438908E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B342896AA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBE51AC254;
	Fri, 14 Jun 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9UXk4/j"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC531AC248
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377361; cv=none; b=AiraayDldHFEV3YBZtN0aDYvAVT36vqWodg5Cv6EmRtTWh4mzcp/xgnb+UIZCG5omZl0WiZLdgAzDR+TsV7Xbgi4nEIz1L9dFJy9CyP49MsVkwm1KYlyAqNNYgMGldhS/QgZ2XWH0P2uF4cJmO6ckQZnCf59WgDOYewXEzsH/EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377361; c=relaxed/simple;
	bh=cLLeoh++naBGPQZLkDFcvWY+Rf/9V91jd3U2YZI8/HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IA7od/jVFX+JAzAPFuI5UXsy56ieJ834tfEpA4MjGB26LKeY0+SqSJ2VARtMHzZcTQauzR3L1yPyecrgMdeh1h9iCKUjSbPo6tlVCfRzn4ni+90hFiw9kzNgtqoJv3kCgYg9B3Ezn0S6ptSA+VfNXmcY0Xf4Z7I50AbaHKX2Als=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9UXk4/j; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35f1c209893so2560279f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718377358; x=1718982158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+iLuqVadCoqCg4bKDGvoLPKxtcgCGNFeClX6r1NiCA=;
        b=j9UXk4/jQBoaky4Q4W8MJHiBosrGanyfdvGgf4s/ebVn71PIGOA0QbkyUhoiLzhbv1
         viY78OgMszsmFESq2fVT06M9AKAyfYyvI/bVczfVn68aTmrR1EA2+9C/IEt0lW1UVOBC
         7u4G0wOqaN1w6f1p8brKrkMSzFcP1ko7z0uQPTP/v5VU6nKdnA/g19k1GMUgJkHQVp1d
         p0JN5DhYJ8NokQ+g29HntqNDgcDpCF5X+g78Us5RIWrQKWFfvHgw8TXd18nfW9Ir5tNa
         iQxmyLMxsOqUNf/GFVCyzCkthqAzh+gXMcK5MxVpD2zEPNSnjiyTASWXrdgTeGUehhyF
         GCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718377358; x=1718982158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+iLuqVadCoqCg4bKDGvoLPKxtcgCGNFeClX6r1NiCA=;
        b=opKGd71/OvFx+eRJsIqFRz2QHqq5oyOD4EqP6Qnizjkxub8ZaXdLq/RAerXZ80K8qB
         cHIkdo87H5iAsQMTwpbed1fiUnlNnUNbS6t3tUrpGLZNhXowRezlM2VMXy8yFyUTxUbc
         Acu9fJsJ1p25IxgJ8seakigk+DSINy53kb5Ug5WwRvWG7z+dshoKnuU7q27CIOxCOr0U
         khO83ImtenJF5YxmTKEMos+VoI6OMgRT7/uwQaXqXMtIFR8eKze1zbXCSLaeylxhU0+A
         rxMeia42sFUYzBLKOhGJPCMooMnkHMvzoAVSzNYc9WuimiH1OmQOEdPE5tY7BsHJLS/7
         sLkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3v7BhqT4HN7Aryf4xHNpo/ym+V3mSiVvFYZCQC3WS55QMzQr+hJuakwnmy9kaD4td2iHscM/5FhyKk/bFoSW2wv6yLRBfJUbcrHMK
X-Gm-Message-State: AOJu0YwzVy/7Jb5KoSgh0q0vct1U+4SP0kxGUuEmHL4+6TBc20bG0rHE
	bx6vDuS3abkoGtyTAdsNsfifOVbD0u+SAqicf/CxCheG6IZdSIeR
X-Google-Smtp-Source: AGHT+IFzg5ZaV3h9+rnTo/Q10KwFpqvLV0rc1MUvNPDARB1QJqORIaRjnRAvvLkrYvMMY508iWJ2yQ==
X-Received: by 2002:a5d:6650:0:b0:360:8636:7791 with SMTP id ffacd0b85a97d-36086367874mr1132004f8f.16.1718377358198;
        Fri, 14 Jun 2024 08:02:38 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b75d:0:64:3301:4710:ec21? ([2a02:6b6a:b75d:0:64:3301:4710:ec21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2489sm4630081f8f.69.2024.06.14.08.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 08:02:37 -0700 (PDT)
Message-ID: <ced7a67e-8db9-4422-889e-76ee4958a622@gmail.com>
Date: Fri, 14 Jun 2024 16:02:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] mm: store zero pages to be swapped out in a bitmap
To: Andi Kleen <ak@linux.intel.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 david@redhat.com, ying.huang@intel.com, hughd@google.com,
 willy@infradead.org, yosryahmed@google.com, nphamcs@gmail.com,
 chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20240614100902.3469724-1-usamaarif642@gmail.com>
 <20240614100902.3469724-2-usamaarif642@gmail.com>
 <87ed8zmvla.fsf@linux.intel.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <87ed8zmvla.fsf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 14/06/2024 15:45, Andi Kleen wrote:
> Usama Arif <usamaarif642@gmail.com> writes:
>
>> Approximately 10-20% of pages to be swapped out are zero pages [1].
>> Rather than reading/writing these pages to flash resulting
>> in increased I/O and flash wear, a bitmap can be used to mark these
>> pages as zero at write time, and the pages can be filled at
>> read time if the bit corresponding to the page is set.
>> With this patch, NVMe writes in Meta server fleet decreased
>> by almost 10% with conventional swap setup (zswap disabled).
>>
>> [1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
> But how much did the CPU time increase? Surely the new loop is not free?
>
> -Andi

It is negligible.

For a zero filled page, without zero-fill optimization, the CPU would 
have to do page compression in zswap or dispatch write to disk, so this 
optimization is just replacing the CPU usage for these tasks with CPU 
usage for checking if page is zero-filled. This is the reason why 
same-filled optimization was there in zswap. Zswap should focus on 
actual compression and this series is just moving the optimization to swap.

For a non-zero filled page, the loop quits the first instance you see 
non zero data and checks the last word first, so its likely going to 
quite very early on in the loop.


