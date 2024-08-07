Return-Path: <linux-kernel+bounces-277232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD7C949E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877A5283ED2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B1317AE0C;
	Wed,  7 Aug 2024 03:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DCBPyk7j"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B822119
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 03:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000760; cv=none; b=SkjyLqUMLf8D4XU47QjjYrKXKEM5HJd6dbAfHxJaVqykRPqbKRR7Dz8Sl0Eejni2sV8n6O/WYFJBBpKOh/6br0edwPzP5pOEVmxc+QsTFYnNxoggJ/gpZ5nXon63zVtsTpK/wUiVa6VcpH9v10sLMuMu1prECtENKywbgBmX9tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000760; c=relaxed/simple;
	bh=EUPZ31D7U+7j2+2ndr9TbTCGuEHdUOhxfNtD+5VbDrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=oeD6xRzDsxrMS9iahBBC5ifVrBMK+n62WkVgXCxbCXTqPLn+PmRZ/WswrTCDtb2y8YEqK1NKIvf8sdlkNRDQk9ziI3iAuxn3y2VEgIIpLDbl+E1iykF4L0H9pvft5lZD1bs2TjT0NoyV555B0DWbmIvzVltDxH7ruiLa5b6VHA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DCBPyk7j; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2681941eae0so697085fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 20:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723000758; x=1723605558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/mLuVdd5+pFlHQ/4T8cyFKawoHtMBnWpMcQuFXnIww=;
        b=DCBPyk7jVUjiq9Vc1jw5GnMuDqy71EZpcCsu4Sc3J+W/BpFvL1pf7MxQErZJUOocGy
         9V96G1E6qYe6na+RMxG/cbaFcqBa7Vgr8npCReync/HVsKWgmp7vU9Ss4tYXyiwDP3zp
         WYbTgi5nQW/XhW/Jo1ZZUcz6lTnbT/gkbTxkPVIzxkkKfop/qY2iEh941joCyN0w7Vou
         xdX3lS5z0Mmro+EpUWu28bNFM9/VkEBqio3cE+ONSg6f57TisFQJluQXS6Mdu3ONlLKA
         GKdll2sX1x4dfF7tvpPrZrzLYwwi6PagGnzeQ757n9yaMtBiSxInn/sx/MUAU47fc+c+
         wWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000758; x=1723605558;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/mLuVdd5+pFlHQ/4T8cyFKawoHtMBnWpMcQuFXnIww=;
        b=Gyh+ytGtpL8wh8dIgi+37BNAp62XplgHTywS38zX0/OebAHLhUTeiSjmzugew5Bvz2
         p1Iq1Wg4SCUy8eqysSQJgTuv1BDnIn7ywuFyKnLcDsQpPeJYgst4yThP3tTAPE3T9ks4
         Hqt6WETxmU24JrVlITn8/RwVD2AfLSH0FPHcXcvILe60eUWdo33OQwNdLibkGBHkrodJ
         GqOoBc4MGGokBbnSmqil/8kYA3X72uBT0jYclp351T/oCXLha8InNQOaz3fgX4NBRkJF
         cQszZlQYkqIcfNb0tIAsGS4gErxhpglCyVbFTRLwyy28Oi7t8KIJCvWdrpaECeFVatcZ
         l2mg==
X-Forwarded-Encrypted: i=1; AJvYcCXOM1BD3DTc0wdUq767CkmmmuyHiZt3fpUmb9BjmPgcD3SRvbP19JQn5VYtHVQYLGkK5ckXWcy1EZNmPR4JvPSgS+dbgzEGkIZaWtcA
X-Gm-Message-State: AOJu0YwcVu5yn2fgo4eU4mTBZyApCnkV91lef1CSVAWXDJqisnYwuFtI
	CePIkC6vciiJsHHAhnjDAdNBM8/1JkhmdQwyyDfSyqIJJiliKKga5weN7TMqMOQ=
X-Google-Smtp-Source: AGHT+IE8FFu+fZfH5z2rhx9vZCV6x7fIVYm+sXxRCO7riqTEhiO77VEUU+dW1maCGpqbYD1McV06Ag==
X-Received: by 2002:a05:6870:1644:b0:261:22a4:9235 with SMTP id 586e51a60fabf-26891e9303fmr17263216fac.32.1723000757739;
        Tue, 06 Aug 2024 20:19:17 -0700 (PDT)
Received: from [10.70.146.105] ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed3389bsm7543742b3a.213.2024.08.06.20.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 20:19:17 -0700 (PDT)
Message-ID: <47e26358-86c3-485d-9de4-1b492ba5641e@bytedance.com>
Date: Wed, 7 Aug 2024 11:19:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] perf dwarf-aux: Fix build fail when
 HAVE_DWARF_GETLOCATIONS_SUPPORT undefined
Content-Language: en-US
To: Leo Yan <leo.yan@arm.com>
References: <20240806114801.1652417-1-yangjihong@bytedance.com>
 <20240806114801.1652417-4-yangjihong@bytedance.com>
 <a3699fc9-059f-4192-b522-918952c4b264@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <a3699fc9-059f-4192-b522-918952c4b264@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 8/7/24 05:34, Leo Yan wrote:
> On 8/6/2024 12:48 PM, Yang Jihong wrote:
>> commit 3796eba7c137 move #else block of #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
>> code from dwarf-aux.c to dwarf-aux.h, in which die_get_var_range() used ENOTSUP
>> macro, but dwarf-aux.h was not self-contained and did not include file errno.h.
>>
>> As a result, the build failed when HAVE_DWARF_GETLOCATIONS_SUPPORT macro was not
>> defined, and the error log is as follows:
>>
>>    In file included from util/disasm.h:8,
>>                     from util/annotate.h:16,
>>                     from builtin-top.c:23:
>>    util/dwarf-aux.h: In function 'die_get_var_range':
>>    util/dwarf-aux.h:184:10: error: 'ENOTSUP' undeclared (first use in this function)
>>      184 |  return -ENOTSUP;
>>          |          ^~~~~~~
>>    util/dwarf-aux.h:184:10: note: each undeclared identifier is reported only once for each function it appears
>>
>> Fixes: 3796eba7c137 ("perf dwarf-aux: Move #else block of #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT code to the header file")
>> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
>> ---
>>   tools/perf/util/dwarf-aux.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
>> index 24446412b869..d2903894538e 100644
>> --- a/tools/perf/util/dwarf-aux.h
>> +++ b/tools/perf/util/dwarf-aux.h
>> @@ -5,6 +5,7 @@
>>    * dwarf-aux.h : libdw auxiliary interfaces
>>    */
>>
>> +#include <errno.h>
>>   #include <dwarf.h>
> 
> Please alphabet ordering. With it:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
Okay, will change in next version.

Thanks,
Yang

