Return-Path: <linux-kernel+bounces-430776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718429E3573
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C4C28165D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221F7194A43;
	Wed,  4 Dec 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MQHNxcjU"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6D18DF64
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301146; cv=none; b=UDMITeWtrAUF+YpjALqrtU3WEFITBc5Ji8a2riVQXnEasJKlPYW99LH1tPWD/rKpq2ALxeCBa12Bh4Qck82DelxUAigNO3YmVImPAJSHi0BJ5H9HqSWnVwjPhWawyeR/l2rKdDmuMGf9Wtme8CH+bS5uRg/p4Rm3u0/fQEVA368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301146; c=relaxed/simple;
	bh=zbB+QFCztPKtbAPO66u/b7Q6li5azbG20sPo396qa0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cu/bXh83GjKKXnKfo612sNFxOKJwHc3udQfGda+EMZbhiQYw2LkTHiTqVNHg0Lyo8nEv1MIrXk2+UIfnAO+b8ImdbEgeVDizoQNnRM/fPwkZLDFtY0FbTUEitb5wD2ZeHQDbqDcTaU/jDsfyc7lJw8rcK5YRyGlAW95cAHNhcDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MQHNxcjU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-215513ea198so4814025ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 00:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733301143; x=1733905943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnMW2t5LKUBnNbekkAf4LMt1K0EpQnTIYhACyHeiDCM=;
        b=MQHNxcjUcvcZf1hlA4AYvCZaLIuFky9vHwf5GB5JqJLbgdlYpmNGDfDzmqxGChUQJ5
         QF8t+tviUyF7k9B/BdOgByEMrYIcJ7mZsoTm/WqxPbPb9EF2oF4NFa7pCMYK8ScwOkGB
         HWIKsdRkJOxKDcKkPddKfdmNheM1OC6wOSxyFNuW3gVThAzh2fmtdtbovgGSeDMuzHIV
         WA+lxQuX+n8YLZc279Vtst/cW2Wq5FmgQuPVPBnPkbPf5fAh0bEP9EBazVeL5VPg8GtZ
         7UHJOyl4Qju6TX7+K7fbaW/zzfL7H8LNZNEuXj4ckm9oeIW2SZD9D9d6Bc/KsqzKqj9T
         SMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733301143; x=1733905943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnMW2t5LKUBnNbekkAf4LMt1K0EpQnTIYhACyHeiDCM=;
        b=ueE1gnVy7tvuXh3F5UNvVqcCl4s1h5G/IaTVSeGf0W4/GN3eyQdNPVeIXGXunajD4D
         o9r9fLNPpPy9cdyKmbG5TelotoQ0ZBB3fd2SOMkpWAtVTJsAcm+demGStED+DJlxCE9I
         XTWvl2hu5YVBLDJiDcuLmqIiI7P75O7LL7QlQ4wkjBoGptxWJ4MSYXP76Rl+YL5UPDkb
         LZmNUx7pKh6XPpGDYGduHSzaBZfxhUKLACgpSvP1dkZEfl/I0UTZZ6UlEylYsn5ponvh
         OHI9++aVshek+fT4JvONn2Z+X6hOE6QnonELuyEWi+HKg2sTdQIv3kX94Addersa5dGA
         BibQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwbP69wqScNdyu3ag4MvHp9b+PK9bM0EJvVFQkPdtuQR1ggf/FiyzjVS80TF0r0l9PSxMl9LxzjWrZRII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrYQdp1mAZSE2v80bIaO9YZotjbwmilIXBWHwad5fnzIYoFLbA
	Sr2EhGBn7UbPNy96BkciiTJ2p734oUKprnrRcrS4BUsl67JMfG9XQo5b8Bb5KB0=
X-Gm-Gg: ASbGncvBolvPUcaQyt915TRem3U70WJF/WXdE9UZEdJ4JuGn2k3kFc1cw65KbnumWFK
	XVIDDuqmWBeL8xcLEppV4TZJGFzSNtnvKPeoDTcYsx4gkTiFgncboXEUGAZ9MV+c/UgjAuWLzQg
	xFnsBPvv/MBsbufHJXje2EdF/1Jt22QpTcBHWL/YhAZRELuHGmKNweUUrvMMUxF0phpKmYFuEPT
	0ei2ilNMeC7HbxD4fz2axgYAtJTYdZNsTidSIEG1oaZadnrDf6TI0Qojs3JD1M=
X-Google-Smtp-Source: AGHT+IHOFXcLhAtgSKDz+uz5SjVYmgxi/mOoWfkRQ9WH7HYuhwNGn8YTjGrK+dNdYXbF9hcNvFh6FA==
X-Received: by 2002:a17:902:ccc5:b0:215:9d48:46f9 with SMTP id d9443c01a7336-2159d484a42mr160179695ad.21.1733301142748;
        Wed, 04 Dec 2024 00:32:22 -0800 (PST)
Received: from [10.255.194.25] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7259114e1b3sm675874b3a.25.2024.12.04.00.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 00:32:22 -0800 (PST)
Message-ID: <4d6adb42-81cf-4a8b-a8c5-4b322564430c@bytedance.com>
Date: Wed, 4 Dec 2024 16:32:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [RFC 03/12] perf event action: Add parsing const
 integer expr support
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 james.clark@arm.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241128133553.823722-1-yangjihong@bytedance.com>
 <20241128133553.823722-4-yangjihong@bytedance.com> <Z0jRvSlEZveQFVh7@x1>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <Z0jRvSlEZveQFVh7@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 11/29/24 04:25, Arnaldo Carvalho de Melo wrote:
> On Thu, Nov 28, 2024 at 09:35:44PM +0800, Yang Jihong wrote:
>> Support parsing of constant integer expression.
>>
>> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
>> ---
>>   tools/perf/util/parse-action.c | 52 ++++++++++++++++++++++++++++++++++
>>   tools/perf/util/parse-action.h |  1 +
>>   tools/perf/util/parse-action.l | 19 +++++++++++++
>>   tools/perf/util/parse-action.y | 13 ++++++++-
>>   4 files changed, 84 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
>> index 391546bf3d73..3b10cf9f99b3 100644
>> --- a/tools/perf/util/parse-action.c
>> +++ b/tools/perf/util/parse-action.c
>> @@ -7,6 +7,7 @@
>>    *
>>    * Supported expressions:
>>    *   - constant:
>> + *     - integer
> 
> And now there are alignment differences and no : ?
This indicates that integer expression is a subclass of constant 
expression, so integer is indented inside constant.
> 
>>    */
>>   
>>   #include "util/debug.h"
>> @@ -118,7 +119,58 @@ void event_actions__free(void)
>>   	(void)event_actions__for_each_expr_safe(do_action_free, NULL, false);
>>   }
>>   
>> +static int expr_const_int_new(struct evtact_expr *expr, void *data, int size)
>> +{
>> +	if (data == NULL ||
>> +	    (size != sizeof(int)
>> +	     && size != sizeof(long) && size != sizeof(long long))) {
> 
> && should be at the end of the previous line, just like you did with the
> || at the end of the first line
Okay, will fix in next version.

Thanks,
Yang

