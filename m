Return-Path: <linux-kernel+bounces-430747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D849E3506
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF45B2F6CA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807AF18C03B;
	Wed,  4 Dec 2024 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZQtaeQkJ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025181FA4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299678; cv=none; b=bz7tFI8SvOPVGo6k4H37/sksVAJKVmP+4uWljF1maFcU4V1msenoqxXyhG4R2LjTXoTHqUtfH/ecSlof0pikImZ+TIHzn9xMW+lvUG76X7yxBN8ErV+pKfm/L2qWVKuDc/4ZiPdAO4/2iEUaADK6ydbEaCduqjeqbyXxyCRgwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299678; c=relaxed/simple;
	bh=aGXnP4As4Q8D2YGCYpvDboUqA/0JV/QAU1GfLgG0/js=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JAzl83MpNn6/I7Ml7/CCUtI+tB5EMEu1CMYMF6kXezMY2QbXYGUqnqvCflajc54yG+gJ2MozSJaIaA62dVh5EDAvcZ5jYW8dNZrQ0ipU02kB7bWFtDIPGDxyQuwF2XLVoAGhr1+/6cmtJrGXY9gZ9tJiWOtU0N02HkZrt0bexa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZQtaeQkJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215b13e9ccbso24478725ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 00:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733299676; x=1733904476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQLyVjn39GB0RJ5Jlf6NdEbky8z1gaSlOm3YTv1PuzM=;
        b=ZQtaeQkJNYl38GkKvQZkMZYtLm0PDXzAxpCJ2GFzSpjxsv2EwG8mghaIw11jVavdBx
         QynO6Qe8bLsrgxlJFExiYKU9Qu35BTHKGv/oUuh2z6N5qfjp5XmC+i8h44ql98UU4pgu
         by7rQkozY+SEvBUXFgudHS1U/cmnAkMXlBd+RPuvTMetGAVEug7Go2FkBuf6s0PEhYwf
         soE/mnCU8X1xinyzOvwVqRiScHkOCT8YRKfjWblDURm84NRhg003qKKzD6hhZEYKzAbW
         PQoexN8xMySa5wK8luf/oGde7tKtX9ZtVn5THoqYie1WpGScMo+vr8BeHTtY8wIptwVr
         6Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733299676; x=1733904476;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQLyVjn39GB0RJ5Jlf6NdEbky8z1gaSlOm3YTv1PuzM=;
        b=JoA/WZQv2jHaW0iFf2KVoTVf9J6QkX/OIf73kmz07ZvYIbCe51nGae0DfdPbBV6FYX
         XwydElB9POVNTdGupmFtEA0rdtSVe9mUJnKKjYVTP+NYDmV7uAovazmJco7u9r/uE6zW
         ZEKZ4PiZUQpSbrnK8py9T5Khk4+O+P1fjGHprZOStKlH7peL/r894TpJZX7hcamjRbdr
         Mc9nJP/a/RP29wDMiTXa3RHKUyQtcbykkxSqqc+mIs7cUrdj3Ln1D3m+BarZveEMzUNi
         mqyEDwSnD/GitkikNPe6lvICuqbT9eUO63mvdzeNje0h1Cb3fPQhuGGYSZ0pjBu014z2
         PxsA==
X-Forwarded-Encrypted: i=1; AJvYcCXribqv0QFYdCRRC/XyC5tlj6mDXP4H71a5pDWdf0jzEHiy89NxGlZ3b5mBZKEx2yuebv0olHEfcL8fVes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD4GKBuRAxC6H0DkcslZgSWcJbizNhFDku1CXv8SED+3tcdYJS
	ghD21g6XCjOIiiyCwsG31uoAWglT3vmDXuzRqeFTDCOUEdPUTmfuVFAgra2Vaq0=
X-Gm-Gg: ASbGncty04fVwtBySN5t3dzo8KExEeN34Gct1yc3wZ0r6CUa2TuhJ+xjLoBNwdP8m04
	1KnN6iz3KGguqX37Trvgm4aAmKl+1CHWaKH8QUGJPUOSM3VpWkNDH4Ib7C5buLYSmOp+w3ndyaE
	3+FtTZIqVVlB0Amqql11XqomMsW60vr6Lt5KYfVUXYfX07C+Proiz4Qg/GofE8J1rWaLyKZ+mFb
	eOjHwwtO5Ns1RdfnZe42Ae4vOU7AhEfBhfQaqMMlNnLclrO2NFSariOFUgHZmc=
X-Google-Smtp-Source: AGHT+IF17paEdGmDWae3eRLQCC4EhulVdZUuMeuv9MrhWfCyVw4yz9GlI8P8MlT5HDOyMkqNyPv4iA==
X-Received: by 2002:a17:902:e84c:b0:215:9642:4d6d with SMTP id d9443c01a7336-215bd0c4b0bmr63970865ad.17.1733299676332;
        Wed, 04 Dec 2024 00:07:56 -0800 (PST)
Received: from [10.255.194.25] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215411c3530sm89475575ad.54.2024.12.04.00.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 00:07:55 -0800 (PST)
Message-ID: <663c3133-12ea-4bc8-b30c-c925d7e86bf6@bytedance.com>
Date: Wed, 4 Dec 2024 16:07:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [RFC 00/12] perf record: Add event action support
Content-Language: en-US
To: Adrian Hunter <adrian.hunter@intel.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, kan.liang@linux.intel.com, james.clark@arm.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128133553.823722-1-yangjihong@bytedance.com>
 <0aecb442-ede7-44ce-824e-6fc0271207b7@intel.com>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <0aecb442-ede7-44ce-824e-6fc0271207b7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 11/28/24 21:53, Adrian Hunter wrote:
> On 28/11/24 15:35, Yang Jihong wrote:
>> In perf-record, when an event is triggered, default behavior is to
>> save sample data to perf.data. Sometimes, we may just want to do
>> some lightweight actions, such as printing a log.
> 
> Why not just pipe 'perf record' to 'perf script'?
> 
> # perf record -e sched:sched_switch | perf script | head
>              perf  768231 [000] 2318380.474267: sched:sched_switch: perf:768231 [120] R ==> migration/0:18 [0]
>       migration/0      18 [000] 2318380.474294: sched:sched_switch: migration/0:18 [0] S ==> swapper/0:0 [120]
>              perf  768231 [001] 2318380.474353: sched:sched_switch: perf:768231 [120] R ==> migration/1:23 [0]
>       migration/1      23 [001] 2318380.474382: sched:sched_switch: migration/1:23 [0] S ==> swapper/1:0 [120]
>              perf  768231 [002] 2318380.474477: sched:sched_switch: perf:768231 [120] R ==> migration/2:29 [0]
>       migration/2      29 [002] 2318380.474503: sched:sched_switch: migration/2:29 [0] S ==> swapper/2:0 [120]
>              perf  768231 [003] 2318380.474513: sched:sched_switch: perf:768231 [120] R ==> migration/3:35 [0]
>       migration/3      35 [003] 2318380.474523: sched:sched_switch: migration/3:35 [0] S ==> swapper/3:0 [120]
>              perf  768231 [004] 2318380.474534: sched:sched_switch: perf:768231 [120] R ==> migration/4:41 [0]
>       migration/4      41 [004] 2318380.474541: sched:sched_switch: migration/4:41 [0] S ==> swapper/4:0 [120]

pipe 'perf record' to 'perf script' has limited extensions.
We can use bpf prog to do more (such as saving user-defined data (such 
as registers, function parameters), and customizing the format of 
user-printed logs).

Now we only implement a simple print() call, and we can support more 
calls later.

Thanks,
Yang

