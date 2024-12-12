Return-Path: <linux-kernel+bounces-442550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11599EDE17
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 05:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7841887587
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 04:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E67A1531C4;
	Thu, 12 Dec 2024 04:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mADtc4lO"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99CA257D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 04:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733976376; cv=none; b=i4H1hQhQQ6fny1WZpnOdKMPSs7BX3XDGlpCNv439w/FnsulTRPQrLgKMUs8iVju2gKl3WV6P/ckXYNKaNWv0o3kl7ZPpFQWvGAcUcJTTXjNp3+R57Metm0TnENsjB+0g6l84HDB4IqLvF7h4HBRWJIQa468pKarZ+LR3c35SKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733976376; c=relaxed/simple;
	bh=4Z0n5+69/1zknpZsjrtjxxsopGI7TGI5zdu1wX4I+Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2Fle30p1aR8Qo9vAwMlZ6co9TeI91Xkyi7bK6ciZjSJR38uAFOKoqEi4Sf3Diot6lNQtoMdxlniqB+rRtOcf0fnY5YPs/26szTXFbVF82xekfKDOCclsVmAX+8+/SvintL6+uwYedxqn7F/k+x6tnvm7TFHDmaylwTgwJck8sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mADtc4lO; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3a26de697fso80174276.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1733976373; x=1734581173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNThN3xxJpDkX7zz4qNy+1XATIU8RpacmkG/vbjSArU=;
        b=mADtc4lOQkCJP+xJpqbt2HcR/c1Yd3CC2b4zxA8yEZV9ZH0LXK+CiY3hJJ50rBVmr1
         gzgIlpau8cJzGcbgpCEgU+C1pyy8N+QYVPiNiwLif4tM9N2CUO96RpFEMq7XKc19EU1l
         sMFtATiyJ6ij1WZWjzwXWJxvCcf4pRmqLQe4fbNdXwkftcPBjg6w/jRsRKhVp1B8Z8iE
         OY61O7pStNqFkLhhRISUSIHIRH803LrIH83rTAgfeZ4J/pC+m7VJg5PYjX3L/qj+ZprH
         CnkHHIXmQsl+T3eXtrZNkgieaKSpYSpNwc8hMid5Pv5f9ifYJ2RiWfAL41xCxw+Y1MhX
         xj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733976373; x=1734581173;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNThN3xxJpDkX7zz4qNy+1XATIU8RpacmkG/vbjSArU=;
        b=VRznwkU1F+q7RwifjV+aUHvGFrufzjssdXXW672YMH4CN+mRMnUqJ2tby7QkRDFNUM
         RLpgiS7eNdN91nWsOsAbnlDy1an/OLqkC1NQJz5X4WNzvO6E979qK5jRhaukO8/aytsp
         FI/R6vq4A+6dop9M+M+7GqgIjX2GHXtoiRlS6IUu5S4c4XACIHeMq0rxmEHrWKJoLXcE
         IYEiLugmqnDj9TvAQqJt36CiRfh6/c9Uld1dfuUpmFRXURwbMK6QHuci58CnU5dQKVZ7
         0FrGrvqh/JPiLQqx2PJ4y+WIVJD04TGR8eB+VIFX23GrHiCWlnqQWdYxlQe24hQcMUK0
         vfPw==
X-Forwarded-Encrypted: i=1; AJvYcCXDdTaTJyyRtXC0BjF95LCh8qbP2WeUPvupH86TwLG9qzNUzfphYFKOC5t4h1g8bPqO6mkE3oQUsJPS9lM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy5bXIodB1mNltagJuNkKQEtp+wCvDCUL8zR0STcZjHpL0FlOr
	fBDDbcf3rvh9nTVOMRl1SeOD4ubgWs6NpjJeymUG6uKv1TYrI0WwXyqVaKlLqX8=
X-Gm-Gg: ASbGncusuxGKTHkzGdlvhINx9U+3Fgs1P2dKOZ9vZJWtJ2vtmAIbtsj2gO4y5yCK+sG
	pDW8i1SKjmTKvRCO3IL7EuyKe7wwHWgoau6ovoExGXAwC3TqexgFQKmG6+0HG/MTnGPNbvG5WKw
	6Ko6Tosn8++RwxdQLIZxNEQtDGW3QTf3FfV2f+HnmDzVkyssoc6juuTi6PblbHBSStTmJ34FY5H
	FafV2gE1xSBIHawy7li3DkpvjO9Mamkr7d9kI8GODChZMJHKM62ZY/w9tQm++TwF/UD1p5yLatJ
X-Google-Smtp-Source: AGHT+IHcPuv7xP8p/G8hD+xO+jVNR9WpDxUxclJRB6GkxOcrKYUZNX7Zo+qKGKdD3FrAFu7J5lUVJQ==
X-Received: by 2002:a05:6902:2842:b0:e3a:386e:35b7 with SMTP id 3f1490d57ef6-e3da0c5ef71mr1594871276.28.1733976373656;
        Wed, 11 Dec 2024 20:06:13 -0800 (PST)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3c94a035c2sm600720276.26.2024.12.11.20.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 20:06:13 -0800 (PST)
Message-ID: <c094ae0b-ddf0-42fc-ad47-00fad84fb70d@sifive.com>
Date: Wed, 11 Dec 2024 22:06:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers/perf: riscv: Do not allow invalid raw event
 config
To: Atish Kumar Patra <atishp@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, atishp@atishpatra.org,
 anup@brainfault.org, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, mchitale@ventanamicro.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241209-pmu_event_fixes-v1-2-d9525e90072c@rivosinc.com>
 <mhng-1c6ec679-02bc-4aa3-9b23-bb4c5f5f9b81@palmer-ri-x1c9a>
 <CAHBxVyF445KnZfT9rPhTwKA76_GT0eT3+p=ot1oLQzUb7j7d7w@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CAHBxVyF445KnZfT9rPhTwKA76_GT0eT3+p=ot1oLQzUb7j7d7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Atish,

On 2024-12-11 3:10 PM, Atish Kumar Patra wrote:
> On Wed, Dec 11, 2024 at 11:46 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Mon, 09 Dec 2024 16:04:46 PST (-0800), Atish Patra wrote:
>>> The SBI specification allows only lower 48bits of hpmeventX to be
>>> configured via SBI PMU. Currently, the driver masks of the higher
>>> bits but doesn't return an error. This will lead to an additional
>>> SBI call for config matching which should return for an invalid
>>> event error in most of the cases.
>>>
>>> However, if a platform(i.e Rocket and sifive cores) implements a
>>> bitmap of all bits in the event encoding this will lead to an
>>> incorrect event being programmed leading to user confusion.
>>>
>>> Report the error to the user if higher bits are set during the
>>> event mapping itself to avoid the confusion and save an additional
>>> SBI call.
>>>
>>> Suggested-by: Samuel Holland <samuel.holland@sifive.com>
>>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>>> ---
>>>  drivers/perf/riscv_pmu_sbi.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>>> index 3473ba02abf3..fb6eda90f771 100644
>>> --- a/drivers/perf/riscv_pmu_sbi.c
>>> +++ b/drivers/perf/riscv_pmu_sbi.c
>>> @@ -507,7 +507,7 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
>>>  {
>>>       u32 type = event->attr.type;
>>>       u64 config = event->attr.config;
>>> -     int ret;
>>> +     int ret = -ENOENT;
>>>
>>>       /*
>>>        * Ensure we are finished checking standard hardware events for
>>> @@ -536,8 +536,11 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
>>>
>>>               switch (config >> 62) {
>>>               case 0:
>>> -                     ret = RISCV_PMU_RAW_EVENT_IDX;
>>> -                     *econfig = config & RISCV_PMU_RAW_EVENT_MASK;
>>> +                     /* Return error any bits [48-63] is set  as it is not allowed by the spec */
>>> +                     if (!(config & ~RISCV_PMU_RAW_EVENT_MASK)) {
>>> +                             *econfig = config & RISCV_PMU_RAW_EVENT_MASK;
>>> +                             ret = RISCV_PMU_RAW_EVENT_IDX;
>>> +                     }
>>>                       break;
>>>               case 2:
>>>                       ret = (config & 0xFFFF) | (SBI_PMU_EVENT_TYPE_FW << 16);
>>> @@ -554,7 +557,6 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
>>>               }
>>>               break;
>>>       default:
>>> -             ret = -ENOENT;
>>>               break;
>>>       }
>>
>> This doesn't have a Fixes, is it
>>
>>     Fixes: f0c9363db2dd ("perf/riscv-sbi: Add platform specific firmware event handling")
>>
> 
> I was not sure if a Fixes tag was worth it as the current
> behavior(masking off the higher bits) is there from the beginning of
> the driver.
> perf tool throws a warning as well if a user tries to set any of the
> upper 16 bits as event attributes is set to 0-47.
> 
> If it should be backported, this is the correct fixes tag.
> Fixes: e9991434596f ("RISC-V: Add perf platform driver based on SBI
> PMU extension")

I would agree the masking isn't a real issue before changing the event attribute
from 48 to 56 bits wide. However, this patch also does a drive-by fix of a
different bug introduced by f0c9363db2dd: there is no "case 1" or default case,
so the function would return an uninitialized value if the high bits are 01.
Maybe that should be a separate patch, with a Fixes tag?

Regards,
Samuel


