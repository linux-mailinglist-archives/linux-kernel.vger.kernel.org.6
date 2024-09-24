Return-Path: <linux-kernel+bounces-337419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EF09849DA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C47D284CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351B21ABEB8;
	Tue, 24 Sep 2024 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImJy5K2r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B5A1ABEDC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727196109; cv=none; b=Q1OaFnb+hqCg6u/1MGIlSvB/HFXAERJgZB6EQHXxdDEAgKl9eIIIfLmXdv/KCXQd3geTY6Oa+7fDeM7H+ZrMuWglSO0gwEIXk6KUfPUgON2/7vRg4Fp3Ic6MXs/G/RHZYWfMkdQi4CWREra//sFAnY4hJwfjaSS3TXxAjGgZiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727196109; c=relaxed/simple;
	bh=Ddebs7NiJQxxst74sSF3DERS4MlxE/1zlrBSLxUAn5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mSbvDan72b75U7XZVeuO6tQMkGtvauFtQKAtzos78zLUaAkxx5VxWAKl+rJwdGjk2//5jJY8oP7onM0AnJBBtH3dquKCK275IBaqXtSSttJYLpdUZwNQFK/JCRK8dsGJj2USD0eI/b3ovT8cQdtUWL0u5gfqRu6XMNWLQyYtpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ImJy5K2r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727196106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly6sJLgbwXipZpoZxAj2N1Oadc6oFWef+44LVvkEXgM=;
	b=ImJy5K2rFep2AUupyjgL2VjyV7UESOW5p3iyYrRDTbHiswS7WdYNwKRNPjxE7kQ/zWxNDx
	wf4AvtRENfk/N+WwJlIJH922VT0z99B9O/EGxh+IbhmVL3eHc4NWHVoQnss2weExSC04Eo
	XJW1uXVOuQTO+qlhnTeBIslAylRo0hY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-_cIe7GUbPWOO_yQLZmiYSg-1; Tue, 24 Sep 2024 12:41:45 -0400
X-MC-Unique: _cIe7GUbPWOO_yQLZmiYSg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f759001cb1so46542041fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727196104; x=1727800904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly6sJLgbwXipZpoZxAj2N1Oadc6oFWef+44LVvkEXgM=;
        b=vcBwxDB8qMp1VmvsIjYlzBYcvC45ajn617327K/svj3Vwu93Sl+hvM0Z3DEWq6nZAF
         DfWw1JeriKasWn01rv0ONBSMTjG6ps18LFKOOotB0srWL9CSgB9NLC7TMJAFzYtllX4x
         BdDLPHpYo02nOQYr1COqdCie6zXTZKbMvvTTxPIjQ/xb40Mov5Dqh6rjrBNk6EPbO8x/
         CmRoxeCQsgTOTN6uWZOsfiA4lrI8HWlB8G51mSOsfMY0KXCaMmnf0xXlQyWKlIMWHrxp
         Vtr1WV4zx6Wk4+ii+gM/XJNU73sT0RWuH+zKDZ1yjqdLb81L7vrn4DzfKwBtYFJB+0rY
         ZQHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPF4/O00/fJWYjWPTPcrG3tRkgHXb0CwPsP54ZadefNbrlfgSEt4kecJpulOhiN3NePof9IqwbN0Ohla0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjAq5+4hnvOgWUDCJY4v19iJl/VgxjBQLwCy6DfuUJmJXAGre5
	c9SMpoqYmmNBBRSgqLb01um1UOx1aVMhYsXXIblemky+z9Y5yJcDX7el2nHtsdbcsfvWwcbz/d8
	OU4NrGOXfmHg9aodm/wAD4Qvbck3wfgOC4a6SGCFZ/mSqM5U6ID6tnmrEhN37XA==
X-Received: by 2002:a05:6512:3b14:b0:535:6925:7a82 with SMTP id 2adb3069b0e04-536ac32e437mr10881529e87.41.1727196104058;
        Tue, 24 Sep 2024 09:41:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp83+kSWaKLfEgQ7J8wYrL7FxZHdLIv4s6kY4OvSQk+f18+aZtTWcoz4Bg4yNpb81w2ZyG6g==
X-Received: by 2002:a05:6512:3b14:b0:535:6925:7a82 with SMTP id 2adb3069b0e04-536ac32e437mr10881497e87.41.1727196103612;
        Tue, 24 Sep 2024 09:41:43 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a8648dd7sm273486e87.200.2024.09.24.09.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 09:41:43 -0700 (PDT)
Message-ID: <ab460ce5-c635-4fe5-99e6-04d889021b2c@redhat.com>
Date: Tue, 24 Sep 2024 18:41:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test: Be more tolerant of metricgroup failures
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240502223115.2357499-1-irogers@google.com>
 <CAP-5=fXGaLsnqd2DdEx-+9V8tO6Wi_HNFgzrGdhdFo5nFSCb9w@mail.gmail.com>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <CAP-5=fXGaLsnqd2DdEx-+9V8tO6Wi_HNFgzrGdhdFo5nFSCb9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/23/24 20:51, Ian Rogers wrote:
> On Thu, May 2, 2024 at 3:31 PM Ian Rogers <irogers@google.com> wrote:
>>
>> Previously "set -e" meant any non-zero exit code from perf stat would
>> cause a test failure. As a non-zero exit happens when there aren't
>> sufficient permissions, check for this case and make the exit code
>> 2/skip for it.
>>
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>> v2. Add skip if event mode isn't valid in per-thread mode. Suggested
>>     by Veronika Molnarova <vmolnaro@redhat.com>.
> 
> Ping.
> 
> Thanks,
> Ian
> 
>> ---
>>  .../perf/tests/shell/stat_all_metricgroups.sh | 36 +++++++++++++++----
>>  1 file changed, 30 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
>> index 55ef9c9ded2d..c6d61a4ac3e7 100755
>> --- a/tools/perf/tests/shell/stat_all_metricgroups.sh
>> +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
>> @@ -1,9 +1,7 @@
>> -#!/bin/sh
>> +#!/bin/bash
>>  # perf all metricgroups test
>>  # SPDX-License-Identifier: GPL-2.0
>>
>> -set -e
>> -
>>  ParanoidAndNotRoot()
>>  {
>>    [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
>> @@ -14,11 +12,37 @@ if ParanoidAndNotRoot 0
>>  then
>>    system_wide_flag=""
>>  fi
>> -
>> +err=0
>>  for m in $(perf list --raw-dump metricgroups)
>>  do
>>    echo "Testing $m"
>> -  perf stat -M "$m" $system_wide_flag sleep 0.01
>> +  result=$(perf stat -M "$m" $system_wide_flag sleep 0.01 2>&1)
>> +  result_err=$?
>> +  if [[ $result_err -gt 0 ]]
>> +  then
>> +    if [[ "$result" =~ \
>> +          "Access to performance monitoring and observability operations is limited" ]]
>> +    then
>> +      echo "Permission failure"
>> +      echo $result
>> +      if [[ $err -eq 0 ]]
>> +      then
>> +        err=2 # Skip
>> +      fi
>> +    elif [[ "$result" =~ "in per-thread mode, enable system wide" ]]
>> +    then
>> +      echo "Permissions - need system wide mode"
>> +      echo $result
>> +      if [[ $err -eq 0 ]]
>> +      then
>> +        err=2 # Skip
>> +      fi
>> +    else
>> +      echo "Metric group $m failed"
>> +      echo $result
>> +      err=1 # Fail
>> +    fi
>> +  fi
>>  done
>>
>> -exit 0
>> +exit $err
>> --
>> 2.45.0.rc1.225.g2a3ae87e7f-goog
>>
> 

Acked-by: Veronika Molnarova <vmolnaro@redhat.com>

Thanks,
Veronika


