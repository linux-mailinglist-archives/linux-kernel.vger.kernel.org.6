Return-Path: <linux-kernel+bounces-330701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 591D397A2E4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23B31F23B89
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B60F155741;
	Mon, 16 Sep 2024 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUxhvWx/"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C31514C6
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493130; cv=none; b=hm4NP/7JXN/vasJ2/PE+jrjU3Asxk08xeTYR49I94FhjznYSXE03/W+Umm7GvzxOel/WlCULQHYQ26w+2idIiLKOd/EbIM+MFYFs2V0TfjTx9aZJUefPZin3Y98kBYKTAte+Tj7GPUmBDRygEfRzjbB9y+y9T4ZhVwLvKEYchNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493130; c=relaxed/simple;
	bh=ZanOQ7fxVG2v5lnmIvjWTUPTsKGJpUbNU8ioyEFy5/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yxrp4Sezm60TzWg6MqMAqE0mydUQrH54yUXi3FK/3r47I3wYE7F5zSLTUOYmrsaJ1oBz6rMjN2y6PXv2vyfKBtcSXx1GIhY9CUwoaM4pya2+UyxDTP7HDWqhfiN3GX0CI5Py+uSJlClS9E3OA9BBNFmgSaYVkkkh0kWgmd/lvC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MUxhvWx/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so28536335e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726493127; x=1727097927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amijeL/TCbPsHkmGl+LwlZVIAn7Sx+a74wDY8RvXPq8=;
        b=MUxhvWx/vhZGYi3H+TknMJZlToPnPNz+hh1dK+AD5kbg4WJFcHoKO0k0tBRlgy75QK
         UWcuVo0RV+mW8/15+jHdwE7o0w3b0uWiLTKdNQLZP2T5kmT8aPgczWQ6OoEZpa++ZFIj
         BV6sruVCUo63k3IFWEXI2wsPkQKLcVXWtb0dKFPZNy9ebMU0MTMX7g/8JZbbnzt5PCv4
         ZVXkWUfMnpgBez5DfHpnM4PGl/uKwI3TynnGilop/Loss8VOnYBPBuJhQXFi0lBXWz8v
         0iFBWSRa/c3tFhod0Qg6zgM1FUqIhRpnZHIwZ7mP7tuR/ZiDGIudhqbcfN08IiRytI7x
         RocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726493127; x=1727097927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amijeL/TCbPsHkmGl+LwlZVIAn7Sx+a74wDY8RvXPq8=;
        b=T1uPr13/hUfWeGiTfcOPfwWBJvhUI3mASEd0gcrBTAWabH3KdSFdDyPvhao0li6xK8
         8Cl/nqLSHXRvfSxNm1FLm0nYERbD7bhCOOwtI8NksrDmglRLsMMhlms5zx3h0sJersQc
         mu45bxVdIC7ryHGJfKxYiiUfk+9gEco3uofwy0fljbUQ5JhXRH3A4nk0K4o6Hsy646V0
         6GpM1qmqBhwRq9hak5WWTxMWDclo+eKHnEOCO6s9q/JNaKM6tJay7HJlaHRqA45SEhqH
         ZbQxhgJJMjPidjsA1VeZrhkiCYvPUOOvDUx7nY5X0CU/LEKbl/VCaS3qa9jY+Ri5B9Ge
         1m4w==
X-Forwarded-Encrypted: i=1; AJvYcCXoFWk45GkHQJmh/gl7J4RZcAhb3/derDA+5fbWFZIW+1TGjwSKnPtFlk5v+iMv+DH3I3OEX8o5y3auCCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFj3pbx5qGIR4RuftF1HJUV1O6xEKO2p5GQA5jr/1nn4Z8fAvr
	pJLuF+nw5RWfXFc/sDXoPLxaBwQvCT6fUh+84o5EiV88qmdqRjSnptjFLAvRz4w=
X-Google-Smtp-Source: AGHT+IF5WAZRXrYe5Pw+AJJxBDVICVTt/E7UBZ3F1B2MctTYbKsQaRqIAZGCV0D8+zd824FShZfWlw==
X-Received: by 2002:a05:600c:1c25:b0:42c:ae1d:ea4b with SMTP id 5b1f17b1804b1-42cbde1a51emr128680565e9.13.1726493126628;
        Mon, 16 Sep 2024 06:25:26 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22bd30esm77377355e9.10.2024.09.16.06.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 06:25:26 -0700 (PDT)
Message-ID: <f3f143f2-408c-4632-991a-ff0de53349d8@linaro.org>
Date: Mon, 16 Sep 2024 14:25:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] perf test: cs-etm: Test Coresight disassembly
 script
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Ben Gainey <ben.gainey@arm.com>, Ruidong Tian
 <tianruidong@linux.alibaba.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, coresight@lists.linaro.org,
 scclevenger@os.amperecomputing.com
References: <20240912151143.1264483-1-james.clark@linaro.org>
 <20240912151143.1264483-8-james.clark@linaro.org>
 <42bfbda0-3b4a-496f-a96a-8f16d3e108f7@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <42bfbda0-3b4a-496f-a96a-8f16d3e108f7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/09/2024 14:35, Leo Yan wrote:
> 
> 
> On 9/12/24 16:11, James Clark wrote:
>>
>> Run a few samples through the disassembly script and check to see that
>> at least one branch instruction is printed.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   .../tests/shell/test_arm_coresight_disasm.sh  | 63 +++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>   create mode 100755 tools/perf/tests/shell/test_arm_coresight_disasm.sh
>>
>> diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh 
>> b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
>> new file mode 100755
>> index 000000000000..6d004bf29f80
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
>> @@ -0,0 +1,63 @@
>> +#!/bin/sh
>> +# Check Arm CoreSight disassembly script completes without errors
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +# The disassembly script reconstructs ranges of instructions and 
>> gives these to objdump to
>> +# decode. objdump doesn't like ranges that go backwards, but these 
>> are a good indication
>> +# that decoding has gone wrong either in OpenCSD, Perf or in the 
>> range reconstruction in
>> +# the script. Test all 3 parts are working correctly by running the 
>> script.
>> +
>> +skip_if_no_cs_etm_event() {
>> +       perf list | grep -q 'cs_etm//' && return 0
>> +
>> +       # cs_etm event doesn't exist
>> +       return 2
>> +}
>> +
>> +skip_if_no_cs_etm_event || exit 2
>> +
>> +# Assume an error unless we reach the very end
>> +set -e
>> +glb_err=1
>> +
>> +perfdata_dir=$(mktemp -d /tmp/__perf_test.perf.data.XXXXX)
>> +perfdata=${perfdata_dir}/perf.data
>> +file=$(mktemp /tmp/temporary_file.XXXXX)
>> +
>> +cleanup_files()
>> +{
>> +       set +e
>> +       rm -rf ${perfdata_dir}
>> +       rm -f ${file}
>> +       trap - EXIT TERM INT
>> +       exit $glb_err
>> +}
>> +
>> +trap cleanup_files EXIT TERM INT
>> +
>> +# Ranges start and end on branches, so check for some likely branch 
>> instructions
>> +sep="\s\|\s"
>> +branch_search="\sbl${sep}b${sep}b.ne${sep}b.eq${sep}cbz\s"
>> +
>> +## Test kernel ##
>> +if [ -e /proc/kcore ]; then
>> +       echo "Testing kernel disassembly"
>> +       perf record -o ${perfdata} -e cs_etm//k --kcore -- touch $file 
>> > /dev/null 2>&1
>> +       perf script -i ${perfdata} -s 
>> python:tools/perf/scripts/python/arm-cs-trace-disasm.py -- \
>> +               -d --stop-sample=30 2> /dev/null > ${file}
> 
> This is fine for self test. But for a CI test in a distro, will it fail to
> find script with prefix 'tools/perf/...'?
> 
> Thanks,
> Leo
> 

Nice catch, it should be this:

   # Relative path works whether it's installed or running from repo
   script_path=$(dirname "$0")/../../scripts/python/arm-cs-trace\
     -disasm.py

