Return-Path: <linux-kernel+bounces-292298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB446956DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F3528463B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC8116CD22;
	Mon, 19 Aug 2024 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="v2KO+MwT"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE416BE3F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078597; cv=none; b=Y1xcZAOjMuoejqzDSDkAxpaSnYNhDUJmIymBO6gk27RjSTWx0QUA+U9NT1qG3JXG+wM2laE19J2+Ne15pAxfy3tWwKx65cNdUvC7j8HDq95Dco3f/uIaRho8koUCxWmyMUNTTqJS0bINnca+Gf+UQZBKKzeZB55YnVcwbjkF4r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078597; c=relaxed/simple;
	bh=/xoBCeiiKFOFoOkVoKKQH25ru50XonwYCOUEC4HPU84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j431XwswYl+ndyeRcGX8c/QU1NhMLR3FTmIkvcWHBrzkYWSQ3dS02JHueyqWzdcoqi8HNwAsrMLcqkpxvDGZ89V5AOFYtzlczmDUG8ZGKp9lT7W0Ckb8HAwXFx+hMcszBskUe65URrPsU4RMycOwEDW57yz7dSpDwvb2eArUOHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=v2KO+MwT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3d486d8bdso620421a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724078591; x=1724683391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=whxCGLMimPF/OQqC4c0uQrCB4wdEAv43WcnAqSWBF8U=;
        b=v2KO+MwTHKrFUAvgBDAHc1rfKTNslSvuiMPv5f1ZebBd9Bl4BxsYsim+srP4TwI1g+
         mva5LU2cV4mdR5LlB3Hsp1Isthqj7RxyfrqHuA49rW2x76OiOloCs5fLKgOFMoTfL7mi
         0U3EqXQNXIaxRFbDa8hF6/B0CglkHBzPd2QAnxGWNqWJuSEBg4+c6OnpvYIn82vb/Na9
         vTPrK8k18YJf6dgGLn8OIZIqCahVxanR21/kqVdReIjaTAWpYsDTOawG+EWxlkvUwiq/
         qYeYoHtbNfYHlS/d9j7fO0uBqHE77opIqRzvxRPuMRsa1xogy1WgOtsgrCl4wuLrNp+s
         SVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724078591; x=1724683391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whxCGLMimPF/OQqC4c0uQrCB4wdEAv43WcnAqSWBF8U=;
        b=o9rCv/W8jcTp6UHtmM02J9YQcSPLrVOQ7ZWdAVScBsp0z6A1UDNq0065wUBq77uROo
         X2qaC1x7gbpncSPDQ+v/+l0Ien/n1Vli4N/lTa1dsKRSC23g2OMwmzCYacmD7vCr8xac
         F+IAe+YQNd9Eymm3yWc97KL+OhvemheE16DDGgV4ZdojsTXaLLqczkA1GYRAyQeZ5Z3G
         6iEM0NUO9O5DXZgrAcWiAqVV6jx9bW3Jq+Gts4N+TpVsfKnS74B7lwRcGczxkj3LUwPV
         eFnNt5h/6ZMcU7qUUqvCy6cXdEYEkifjT3jdVKgLTlauAvmZaY4dI4+n5wrttz61ggSi
         GsHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5rftESVAnoGG8iAiJrIdrUJYlkxhEhBL9s2HaStf/1B/NXFJy/F9cFRWq0LzlbPxRCXxNhwPlSiOETp2qf73NVtWBLpzd2wZ9aN2
X-Gm-Message-State: AOJu0YzicyiWowEw3XjczYmHLjL3L+FpgLZgWlBTiSQn0qV/jbqbW2Fr
	IrWof2GuP8oBCX2GkCeypZF9kiRU+ia2oqtzd6B+JSJ1phB2Mhq5OFim8oYP3RRoDSjyFOetFsw
	E
X-Google-Smtp-Source: AGHT+IGJTTCDIyCLLLrPUZvuIT5s8nxVkr0OTjnmhcISR/gn2tMHtIAHzBXIonPENvOEWMlnN+elmA==
X-Received: by 2002:a17:90a:c20b:b0:2c2:f501:20f8 with SMTP id 98e67ed59e1d1-2d3dfac9a3cmr7518708a91.0.1724078591374;
        Mon, 19 Aug 2024 07:43:11 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3bc1b86casm9898632a91.1.2024.08.19.07.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 07:43:10 -0700 (PDT)
Message-ID: <0d2ff3a0-868d-48ea-8e88-9123e57aecca@kernel.dk>
Date: Mon, 19 Aug 2024 08:43:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] sched/core: change rq->nr_iowait type to
 atomic_long_t on 64-bit
To: Zhang Qiao <zhangqiao22@huawei.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de
References: <20240817204639.132794-1-axboe@kernel.dk>
 <20240817204639.132794-3-axboe@kernel.dk>
 <004e1d6a-64ed-4024-b7f7-3f8ed1010e36@huawei.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <004e1d6a-64ed-4024-b7f7-3f8ed1010e36@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/24 12:30 AM, Zhang Qiao wrote:
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index b6b3b565bcb1..6a90c2da1eb3 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1082,7 +1082,11 @@ struct rq {
>>  	u64			clock_idle_copy;
>>  #endif
>>  
>> +#ifdef CONFIG_64BIT
>> +	atomic_long_t		nr_iowait;
>> +#else
>>  	atomic_t		nr_iowait;
>> +#endif
> 
> When CONFIG_64BIT is not set, the type atomic_long_t as a synonym of
> the type atomic_t. Can you directly use atomic_long_t, is right?

Ah indeed, thanks! Yeah we can just use atomic_long_t unconditionally,
and that'd kill the ifdefs in sched/core/core.c as well as we can just
define the shift to be half the atomic_long_t size, 4 *
sizeof(atomic_long_t).

I'll respin with that.

-- 
Jens Axboe


