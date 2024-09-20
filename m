Return-Path: <linux-kernel+bounces-334243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850B797D477
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071991F25092
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35D513D510;
	Fri, 20 Sep 2024 10:49:44 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297313CA99
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726829384; cv=none; b=WyroGIfp9Lj1DUI+eZv2z79tLzC5orCU49/ZCKzo4/viHx7FhsLhWi3vAkZT0s1MdlPt8dOELa6GzXX1xNf+8miVgJWk40hUZH7V25h7CGrsE5sY0M0uBN3N1KCbiHdq5ST91o0nGY/amywkBjMPhra2Uk4cYlGYkhEdhyXREE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726829384; c=relaxed/simple;
	bh=FhnVQ9t52weOI2lk47kSvZ4bEeuV4rdXlQM9xfgGN54=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aBM0n4Xb4re75JqQa1lSs+0V2ezWY7Ax9gIIftbZxNOmB2R3qbndSjG9rjr61qzaEx8ihci2238cbGstnwoCXV77pHqzguxpypeHM0k1NHjxKhadZCfecbHz9sSDVx4WnchO1jA/LGTChqxrbKuL5X2/+siGK0aiF2OHNGNJ5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1726829360-1eb14e31a7113cb0001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id DjhYEw5aHz0JQR6p (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 20 Sep 2024 18:49:20 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Sep
 2024 18:49:20 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Fri, 20 Sep 2024 18:49:20 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from [10.32.65.165] (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Sep
 2024 18:41:58 +0800
Message-ID: <662a0c91-2f84-4091-b971-0219a1c8a3d9@zhaoxin.com>
Date: Fri, 20 Sep 2024 18:41:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] x86/mce: Add centaur vendor to support Zhaoxin MCA
To: Yazen Ghannam <yazen.ghannam@amd.com>
X-ASG-Orig-Subj: Re: [PATCH v3 1/3] x86/mce: Add centaur vendor to support Zhaoxin MCA
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
	<LeoLiu-oc@zhaoxin.com>, Lyle Li <LyleLi@zhaoxin.com>
References: <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-2-TonyWWang-oc@zhaoxin.com>
 <20240919135518.GA3717@yaz-khff2.amd.com>
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20240919135518.GA3717@yaz-khff2.amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/20/2024 6:49:19 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1726829360
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3422
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130712
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



On 2024/9/19 21:55, Yazen Ghannam wrote:
> 
> On Wed, Sep 18, 2024 at 01:54:34PM +0800, Tony W Wang-oc wrote:
>> From: Lyle Li <LyleLi@zhaoxin.com>
>>
>> Zhaoxin consists of two vendors, X86_VENDOR_ZHAOXIN and
>> X86_VENDOR_CENTAUR, so add the centaur vendor to support
>> Zhaoxin MCA in mce/core.c and mce/intel.c.
>>
>> Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>> ---
>>   arch/x86/kernel/cpu/mce/core.c  | 12 +++++++++---
>>   arch/x86/kernel/cpu/mce/intel.c |  3 ++-
>>   2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index ad0623b65..7f79d900f 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -496,6 +496,7 @@ bool mce_usable_address(struct mce *m)
>>
>>        case X86_VENDOR_INTEL:
>>        case X86_VENDOR_ZHAOXIN:
>> +     case X86_VENDOR_CENTAUR:
>>                return intel_mce_usable_address(m);
>>
>>        default:
>> @@ -513,6 +514,7 @@ bool mce_is_memory_error(struct mce *m)
>>
>>        case X86_VENDOR_INTEL:
>>        case X86_VENDOR_ZHAOXIN:
>> +     case X86_VENDOR_CENTAUR:
>>                /*
>>                 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
>>                 *
>> @@ -1247,7 +1249,8 @@ static noinstr bool mce_check_crashing_cpu(void)
>>
>>                mcgstatus = __rdmsr(MSR_IA32_MCG_STATUS);
>>
>> -             if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
>> +             if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN ||
>> +                 boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR) {
>>                        if (mcgstatus & MCG_STATUS_LMCES)
>>                                return false;
>>                }
>> @@ -1521,7 +1524,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
>>         * on Intel, Zhaoxin only.
>>         */
>>        if (m.cpuvendor == X86_VENDOR_INTEL ||
>> -         m.cpuvendor == X86_VENDOR_ZHAOXIN)
>> +         m.cpuvendor == X86_VENDOR_ZHAOXIN ||
>> +         m.cpuvendor == X86_VENDOR_CENTAUR)
>>                lmce = m.mcgstatus & MCG_STATUS_LMCES;
>>
>>        /*
>> @@ -2092,6 +2096,7 @@ static void __mcheck_cpu_clear_vendor(struct cpuinfo_x86 *c)
>>                break;
>>
>>        case X86_VENDOR_ZHAOXIN:
>> +     case X86_VENDOR_CENTAUR:
>>                mce_zhaoxin_feature_clear(c);
>>                break;
>>
>> @@ -2401,7 +2406,8 @@ static void vendor_disable_error_reporting(void)
>>        if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
>>            boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
>>            boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>> -         boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN)
>> +         boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN ||
>> +         boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR)
>>                return;
>>
>>        mce_disable_error_reporting();
> 
> At this point, should we even do this? It seems all major vendors want
> to *not* disable MCA_CTL after init.
> 
> This, and related functions, can be deleted. Unless there's a compelling
> reason to keep them.
> 

 From the current code implementation, your suggestion is reasonable.
Will delete the related functions in the next version.

Sincerely
TonyWWang-oc

