Return-Path: <linux-kernel+bounces-393402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7649BA012
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 13:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC08B1C21233
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8BB189F55;
	Sat,  2 Nov 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb0uEG1u"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80674189F2D;
	Sat,  2 Nov 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730551209; cv=none; b=A2fPoizBMlz81C+V88p7u8rYwPi2JQ4siFrb/iEZVED09Jhb0f9r61M4UvlJTiED71kxa3u9nJT5E2ZjLuePzFRPNCYZilY2Pdo5b1f8t+/6E9bDaVbB8TtqH1WzKdAutYh1L0bEJvv4D98fF7bCvJFEpNnoBCEwgX4zGp4YNB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730551209; c=relaxed/simple;
	bh=M3LoPgCVYqQCJptGDnW9YadgMjZnZMNBqhKDFrquiyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mce/IBvVUtYsCdJn2fJZf6LrzVLYmDuG7LOX7YXpAmEcyQYE4AegYdpoD1jJjr29TnTXghrB35IQC+PtwSipMIOKfHxLtA9Zy221rlcM5MDBphFbbD+dMciJFT9JdypvYYYbwDE0fio2iQEVcKfrJHvL7lp5iMEEzijLQe0dbSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb0uEG1u; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so2475295b3a.0;
        Sat, 02 Nov 2024 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730551208; x=1731156008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLO/hRq3GLq0gXyF7XmPt/4TWBAYlZbIy/wYTMBWnow=;
        b=Gb0uEG1uOqV2WdiKVua9R0/EYD7STlDKxPDb8GlGWeelz1HHiAzBJZPRHLyJjsA4KU
         fYEJkI+ceryEq/C9u3W1R/CmQY8AbCdrVjnOWgjg8rSeJsCbeYfs4tUXoUXRNe3iL3zt
         lEIEW6jZ8v1iKkn93KZ4YepQ8AZQFCPqVGB4VIG90FoyOF82lTv7ptQNhmTQ0uOIL9z4
         5E/PSK1x4prX1paT7Y22sKwIlpaqWj6u8JC8GlGLYaydtFVAL6zvYeTsOVktHDU+kxbV
         CtlEGfPJ066jAokoP7U5tmsQ1BM9ExnaF920bZzXZ5T8jzAkZWRTRokUNZsqRo6ua7qP
         EW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730551208; x=1731156008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLO/hRq3GLq0gXyF7XmPt/4TWBAYlZbIy/wYTMBWnow=;
        b=saydrzMNTvrqFwsZqjO1BXOewCBJRppQCzAIFvG2o9q8rDmiKhtdovz0d9L0m+x3K7
         d+drp7pwNKVh++/1MpwfuI3P/O9sB6JSlsaGPzhMgQJSO+XRYFbhLxgvQIh9PTs3ZN2R
         UtoorrKw6bl5oY8VAJmBiZglW1QJSmWqTmoVydQyySYygAizPL2J8ns1Ldk5oWRirDOT
         A1aNC3lYTa15ZpJbcGDHjqLIKnipz3hjnLbrW8WUTD2GjEdKi1grWRKooUn9yxqmcbI0
         fRervWyAxiYMB8ZAQw9JdHUhX8assgx4M0Ra7pl203hvbHTrv7B4UcyZRyBp70hOrm+y
         pzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF3jdRwPtChDCOfleQdsGK4Sk3fCgLA1UkvtWVHh9F3n9r5CokO+KKWgVCfD1TqD0LEjyssPqkGTO9I0E=@vger.kernel.org, AJvYcCVNmiJLeeQMWVXkZsaM4BbD4w/LvFMhqz6ZoqfRl6ci2U2W/AiFDN7zhFxXkI2fnAAcdSzAoa5SU3ZWsTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+sMaqKwFkFVp1z3q7bkKqovoXI3xIISLeKcugCwKKuEXrlWdq
	dcUosrlATzVw+d7YVKmfVXCyUp94+d9Vj5crw7O0J8xLdwh7xWyk
X-Google-Smtp-Source: AGHT+IHBsQIGIV2lh3b2yS13xKYfDbUPFmLEJUgWuyvqmCPHbR5t5yr3yqidmWwqz+8HVHMOe6msSA==
X-Received: by 2002:a17:902:ce83:b0:20c:d578:d712 with SMTP id d9443c01a7336-210f770832bmr183307455ad.59.1730551207611;
        Sat, 02 Nov 2024 05:40:07 -0700 (PDT)
Received: from ?IPV6:2409:40f2:1024:7af1:4d34:94b:fadb:48e? ([2409:40f2:1024:7af1:4d34:94b:fadb:48e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057e7a69sm33559785ad.290.2024.11.02.05.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 05:40:07 -0700 (PDT)
Message-ID: <5ec78b57-725e-4d64-8b3f-c16ead77dfb2@gmail.com>
Date: Sat, 2 Nov 2024 18:10:02 +0530
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
 <e8fe072a-e1b9-41b0-9382-6562139e31d3@gmail.com>
 <15f9733b-fe7a-4bf2-a6b9-7f7e04cf26f7@sirena.org.uk>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <15f9733b-fe7a-4bf2-a6b9-7f7e04cf26f7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/11/24 18:45, Mark Brown wrote:
> On Fri, Nov 01, 2024 at 02:32:43PM +0530, Suraj Sonawane wrote:
> 
>> I reviewed the context around val_1 and val_2 in dma_addr_next. These values
>> are expected to come from the registers when offlevel is non-zero,
>> representing the next DMA address and length information. If offlevel is
>> zero, it means there’s no offset data to process, and dma_addr_next might
>> not need updating in that case.
> 
>> A more precise solution would be to conditionally update prtd->dma_addr_next
>> only when offlevel is non-zero, as this would reflect the intended logic
>> without relying on an arbitrary initialization.
> 
>> Would it be better to revise the patch to conditionally update
>> prtd->dma_addr_next only when offlevel is non-zero?
> 
>> Let me know if this approach aligns better with the expected behavior.
> 
> That seems like a reasonable approach, just skip the update when we
> didn't read the values.
Thanks for the feedback.

I've updated the patch based on your suggestion to conditionally update 
prtd->dma_addr_next only when offlevel is non-zero, effectively skipping 
the update if values were not read. This approach aligns with the 
expected logic, as it ensures dma_addr_next is only updated when valid 
data is available, preventing any unintended updates.

I’ve just sent the revised patch. Please let me know if any additional 
adjustments are needed.

Best regards,
Suraj Sonawane

