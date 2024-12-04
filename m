Return-Path: <linux-kernel+bounces-430770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653059E3550
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C8D16907A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7FE19309C;
	Wed,  4 Dec 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fKsLc0jm"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6A192D7E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300958; cv=none; b=i2BETOMJ29IL0vWOfb/zeb8pUZV8tqVaNu1CDvjrsfznCkd/Og7+hBQNC32isANcqIeOdN9hSiviToHR5mLyqQ9q6Zu8aadZjpAQjn6rrBhylGbqY28gFNvb9/1AEuoo8HC83JNDjMsx15a+RC/OfMlBdYYVrbBiSeJkG/AOUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300958; c=relaxed/simple;
	bh=TwY4nk/icnPo5syvDmlSy9YNyfE46kU0gZdmNxEOv8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KolAsC+pxBU4QfJKMJBMZHZ9YJ2myTnn9mCZh8lIB4pOFJ9vA0h8E4vN1FESQ2D1ILats2vJ/qcf2qq8ptL8F2/nN1pfw/VM9g4f5zp15R8GRI9FZFgHj3rG7ryrI/GWbltbqnw7vBWmacGsbBSkajlh3IkDhTj4ZHtB0niOOqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fKsLc0jm; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fbc65f6c72so6104317a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 00:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733300956; x=1733905756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLZSORcwDNCNRYfWTU+SMc0cTgQxpYSn4AIBkHM7H/Y=;
        b=fKsLc0jmrg4jovcOe13gTNq8gObfMT75mYsbjOHelZhi7mdoHw00T3DMqtDLdCO4Oj
         iOjNki18B4IPSNvSV9w2CnKHsQpIdYQZlhSNfITCiFigcz/ys/9TyAJdYdON1oERVcQK
         Ur4RyN2pHzGWBiznb32cJeamf0o+pe41Fb2GWfA+TUL+H6tkbj/NiTQ+cAnu2u4+zsAs
         piR9Jh8xkhy8dL5wASKroHohucMXvP/iKyHW6KdbKXNQofsQxAgoUId5b7uw2HPWgC5B
         GRBw3tFF2i/wB0JoxwCzGvY1r/MetztyFha1YVVZVfDnRQ3ckVZ20ydSb0IsKIyITzka
         xj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733300956; x=1733905756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLZSORcwDNCNRYfWTU+SMc0cTgQxpYSn4AIBkHM7H/Y=;
        b=EFYrZ6n/LA7FBYTP2azPVqCzG0B/fLkOFPgHhSPB2Z0TsLUhQ7DNOTATuZSVJS8lH6
         oCkYZwBssu8mTMnJlPyuUWYRMRnvkeT3nxchLArkldqjulQB5Nbydwd5YaE9RFR5zoSD
         E5O+fAF97SvtXfFB16s1FrWZZGWM3M4R+X9TItd8m7I8zXtRFV+qUh31VtfBe09FxVZI
         Px1efpwUm/2PRH9Dk2Ij5GmKPbYV1uEJSPrquj80EgqpSXViA2rHob1iNUt3+qkcIwpI
         asLp6bLWJZnKqx8qbxPAexoBgsu0Ur51LSzfCfQm8wMmGd0l8i6sT2N4bKmiZsxI6sdk
         ZWuA==
X-Forwarded-Encrypted: i=1; AJvYcCVKtcsnCUIAk6jgFojly8+7L+bDLIB5K9cUqVwfuxA2ycXydbTillb+Y7BqKJeL1n3fP2hb5SBRoo0XAN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy96gOaEJGI5Qotg99NFR2PjZZ4LheNOakWxp4Q/62ygwmy6iZZ
	1FBSs7TuV+3eSc/AJIac9YDKxo+65g2hlaHIJQqNPrmt/D5cpV9Q9gEeZocWIi8=
X-Gm-Gg: ASbGncsoO7llCiVU3JFnmy5K+/2G2dI5yWJ2MpHlb9cfnKaipwy4+TeE0bSdT9QtLLe
	Rf9Gqr0Jr8eQrQa3fd82LkiOn8bRhKn0fGPPC4C28dJjjEAenjUr/t9IxHr5eOw02vGYY8NSAUr
	Noup+zMyc0IPAAWu6HRhTE1mrNhlZyTuUlK5T+iKvEejW6Rijw449hzHaK+/abHyTyeJ/4mJfOE
	R8Kt0ujd+g8uFrl+F6Df/DsSA/tJeT0OminpJQfqeflRPkOSn12CLJ91ylmmX0=
X-Google-Smtp-Source: AGHT+IFfgyaV96mN6xSeoeVIL1qafBJc5PoZjODqeGEj7WEjbfKFLPUhTR9DWnVpffrfk4EUWg3uig==
X-Received: by 2002:a05:6a20:cfa9:b0:1e0:c9a9:a950 with SMTP id adf61e73a8af0-1e1654110a3mr8712061637.39.1733300956545;
        Wed, 04 Dec 2024 00:29:16 -0800 (PST)
Received: from [10.255.194.25] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2f7802sm10853498a12.27.2024.12.04.00.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 00:29:15 -0800 (PST)
Message-ID: <bbeba4c6-6c46-4708-9ce9-ff6037fe6449@bytedance.com>
Date: Wed, 4 Dec 2024 16:29:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [RFC 02/12] perf event action: Add parsing const
 expr support
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 james.clark@arm.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241128133553.823722-1-yangjihong@bytedance.com>
 <20241128133553.823722-3-yangjihong@bytedance.com> <Z0jROJ7JPTjmeZly@x1>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <Z0jROJ7JPTjmeZly@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 11/29/24 04:23, Arnaldo Carvalho de Melo wrote:
> On Thu, Nov 28, 2024 at 09:35:43PM +0800, Yang Jihong wrote:
>> Event action requires constant expression parsing support,
>> which include constant integer and constant string.
>>
>> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
>> ---
>>   tools/perf/util/parse-action.c | 27 +++++++++++++++++++++++++++
>>   tools/perf/util/parse-action.h |  5 +++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
>> index 01c8c7fdea59..391546bf3d73 100644
>> --- a/tools/perf/util/parse-action.c
>> +++ b/tools/perf/util/parse-action.c
>> @@ -4,6 +4,9 @@
>>    * Actions are the programs that run when the sampling event is triggered.
>>    * The action is a list of expressions separated by semicolons (;).
>>    * Each action is an expression, added to actions_head node as list_head node.
>> + *
>> + * Supported expressions:
>> + *   - constant:
> 
> This seems incomplete, what should come after the :?
> 
> the patch description, at the beginning of this message has more details
> than here.
This patch only implements a general constant expression category. The 
next patch will support parsing of specific string constant expressions 
and integer constant expressions.


> 
>>    */
>>   
>>   #include "util/debug.h"
>> @@ -115,7 +118,31 @@ void event_actions__free(void)
>>   	(void)event_actions__for_each_expr_safe(do_action_free, NULL, false);
>>   }
>>   
>> +static struct evtact_expr_ops *expr_const_ops_list[EVTACT_EXPR_CONST_TYPE_MAX] = {
>> +};
>> +
>> +static int expr_const_set_ops(struct evtact_expr *expr, u32 opcode)
>> +{
>> +	if (opcode >= EVTACT_EXPR_CONST_TYPE_MAX) {
>> +		pr_err("expr_const opcode invalid: %u\n", opcode);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (expr_const_ops_list[opcode] == NULL) {
>> +		pr_err("expr_const opcode not supported: %u\n", opcode);
>> +		return -ENOTSUP;
>> +	}
> 
> Since expr_const_ops_list[EVTACT_EXPR_TYPE_CONST] is NULL, this will
> always fail?
> 
Yes, this patch does not support specific constant expressions, so it is 
empty.

Thanks,
Yang.

