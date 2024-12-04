Return-Path: <linux-kernel+bounces-430782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838709E3587
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECB3169220
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB0F194089;
	Wed,  4 Dec 2024 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Sqr/6y2B"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2CF192D6B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301331; cv=none; b=fldnCVXnstndIhhZ7gT9vcUdw4eBLrMYjEVKyo79dLJ4zQiuwi6E8T3USmrIPQ753eAhFShn/PU5M1LU9BG2PQFJtEwY0ugJvVlrbP14AwUaeXXxeUm4M9WcBcej8fLcF1rk6Yim6dmx9I3gtF3jFEr9pOn7rP4aHqDqX1/90A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301331; c=relaxed/simple;
	bh=N8uMZFgG8IHSfB+xh9lOEEmCYexY5E4/rl/05Fq3mMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIDhVENTNasbH10w0RbmAkr8T/78uC9UwQJXl/klHzOKomM6W+L+GdDnoJzUwGDxgk4FzY1jgm97n+jijAVs5ORRZVlkRiXWzTOYhziIDBcUQBvGDgcCSkHD82hZEUBD1aytlasC83mwuwOwXxxDUJeJ2nZ9w94KUblcJyKpt6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Sqr/6y2B; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21572ca3cccso33333995ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 00:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733301329; x=1733906129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDQBqsq8re1syUGB3EUPVoBBUgfRGo2j82iuE5TLduw=;
        b=Sqr/6y2BnmYeYSMvr+994IlHKdbQMYTqlEe6uzQ683T2UpAFrEy8mZWsMh24wE8jmQ
         Bb/7efozcKuImY4mES0BuxQlHmhFK6ILv9NWmc0T8jz2puMOuxbRprzHduoLR/hBdyqN
         vr3NdByOxPb9ZOgNBJZ1e9y9L3oA82HSdQcXKFwJbE+oDmJdv1qWbfl05p9fh6nOSLAO
         22601U5WSFNR8SOGhwvypfCaA4eKzkmy8tp1bpDf2v5/jzAufp3jE/SYSB5ot4jb6sMK
         FO5MpPMIhpwjOKQC70lAZgiga9f/5i4lg7U8ZVfKSHAhHngNmjhzzaCccWk6WjP8hCoC
         jCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733301329; x=1733906129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDQBqsq8re1syUGB3EUPVoBBUgfRGo2j82iuE5TLduw=;
        b=ojNN1kOJHKqZ3S+vM2YCgS1qukLOtADqqEnacfa474bpdHUZWXRB07Rf493OZdIsIo
         tup6raU6IChmijGMFUr4fA6iIaSyi61xWXQP24IEbnBmPkYJOAYgRQXTmhjw6XTz0MTe
         7NRIrhnsRtul+YEJFyGh+HhO0J3dsIWQRs1trk9xWEv/GxxpbD2t4+6F9k9bjNjcM41H
         bh0XV/gmE6bKH7yEDnlRHmOMoWHZPv1Kgdyxk/91onmCUinKGRy0vgUcKpSVZLWJtAiY
         bzWxnD62JGKpmRTGqqg79DkMHFupRTIWVUyxqxhhDHQbvnVlYDIfgwiqfJOekqZUGb3h
         9cXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKnoDkxosTl8dExELt7U9uetPSSR+ajJICw09MjlG/DKycOjPZW68ywX45KPvQAu+BWvbqFlwHulGyBw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzttswLHisFuhBwZKiDTcuDLAZFjLyJCWz9KbA62xHwaGr05Au
	9am63d2IhDIZX3QX+zRzKq7XeFGsHx48pMyiHIlZAu2veW8XYONDIK5oyBdlypw=
X-Gm-Gg: ASbGncupqRgUKuSMvJZPWhtW0FHcyecxSNXuOBZEuj8+0gxQRsLacEAtqsr/7XiFHOE
	CmGiaUrK5mMcNGKxJOULJLT7YRD54iWcK2Hcw1qwFZ/SamA5ICVFSTIVFdq2bmi5Z5lntIxUbVM
	oMe5BJrr2BKSsRonMc+lvlXEzdvtskITQpJGMOc27OjbXgPZ3j3AXXrm2udv5yzF++r/NpTWdN5
	DIYhbx3vjU1tv/VL+qZiGWEZL938q5B2XGYEhN1CkcEM7A1OPD2ACmRcG9O0bg=
X-Google-Smtp-Source: AGHT+IHIl88GiRtSS5H37kVtzh2/vkqMLiMw9siwTdcB9OxC1muKop0oVW5neyOE9Pa/33e6ZIS/kQ==
X-Received: by 2002:a17:902:cec2:b0:215:b190:de6 with SMTP id d9443c01a7336-215bd1b44d4mr67634975ad.3.1733301328995;
        Wed, 04 Dec 2024 00:35:28 -0800 (PST)
Received: from [10.255.194.25] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2158394eb05sm55580675ad.82.2024.12.04.00.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 00:35:28 -0800 (PST)
Message-ID: <ff9bc82e-669b-44b7-a02c-f5c704c0cd9b@bytedance.com>
Date: Wed, 4 Dec 2024 16:35:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [RFC 00/12] perf record: Add event action support
Content-Language: en-US
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@arm.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128133553.823722-1-yangjihong@bytedance.com>
 <Z0jPPRA8JXSrwyaC@x1> <Z04qmNnt86zcGE5Q@google.com>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <Z04qmNnt86zcGE5Q@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 12/3/24 05:46, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Nov 28, 2024 at 05:14:53PM -0300, Arnaldo Carvalho de Melo wrote:
>> On Thu, Nov 28, 2024 at 09:35:41PM +0800, Yang Jihong wrote:
>>> In perf-record, when an event is triggered, default behavior is to
>>> save sample data to perf.data. Sometimes, we may just want to do
>>> some lightweight actions, such as printing a log.
>>
>>> Based on this requirement, add the --action option to the event to
>>> specify the behavior when the event occurs.
>>
>> 'perf record' is centered on saving data to disk without processing
>> events, while it has sideband events for some needs, like processing BPF
>> related events (PERF_RECORD_BPF_EVENT to catch PERF_BPF_EVENT_PROG_LOAD
>> and UNLOAD), doing things in a "live" way as your patchkit does seems
>> more appropriate to do in 'perf trace' :-)
> 
> Agreed, 'perf trace' looks like a better place as you seem to target
> tracepoint events mostly.
> 
Okay, will do it in 'perf trace'.

Attaching to a kprobe events will also be supported in the future.

Thanks,
Yang

