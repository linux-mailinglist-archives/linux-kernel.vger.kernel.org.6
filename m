Return-Path: <linux-kernel+bounces-510733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E450A32135
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB2D1618EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B62A2054FC;
	Wed, 12 Feb 2025 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BPF300yc"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31EB2B9BC;
	Wed, 12 Feb 2025 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739349267; cv=none; b=jHHVFg88O9bCY10gmkDdvlNrdGHe8QoZyuzK47S/hgW+2sOXAgzeB2SaIEjzXkrnCnf9hqHl0Hrf9nLJAB4KNzbApA7Pc17obIhJ2G+UQKSlS5J/7Cbe6enmlCR7vJ93nzLJdCZi4NUBdzszB1SDXRIivE5aZvj999PBSMbctvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739349267; c=relaxed/simple;
	bh=oN4wDfG0GCXLZlEghGqHoPoOAn745GrM6wHHXMvRvNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ixa90Nq/sdK0bYWIlnOnFjfBSJfFcPf8t/L2Rl8nuW7szbEdDMzoj/TqqLwjWgbxDzGYA4j6JQHrq0lbZHx+zbzbQ6GJg65WPjR6V75ONB9CgGGjda3mNEWko7zUNGwmlakhBrNp46QsCroCNXu6Zzs07D7c+dsiXQLQlRLbpBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=BPF300yc; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51C8X7Gp2936430
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 12 Feb 2025 00:33:07 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51C8X7Gp2936430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025011701; t=1739349193;
	bh=Na/XKn5Mxm4koLwTUC27XoL6JofpQapGRJrJHnMbv3Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BPF300yctVWoLPyajY/1eckOE/YPyOmy73M8lcze7widDDtFsyVEEAA9T55Op/ncD
	 bhdVuIouPtzCVpbex3DajbZqolsIGgogwFuIV59IakOpDzCHf61il3tCGTjCnMOxba
	 NQRu5+qgd4RT0a0hjSz9uWDrmPtHoBKueR3fAJWbjE0iC04O6ogIfeRbixtxipR2pT
	 5Y/Rf1EYtttg/sI7tBkpH1Iwm3ZNHm5Br8JaC37o1a0c2SWyVlzTAUqov5xX6Mkrbj
	 F8yCB6ja+JO1GgcEhM9NvbesIveOtCXuLcDVTWpZuI5JKoNeFB4l22ksS4s5krIK+P
	 KYkL8rbH+lzHg==
Message-ID: <449bd407-0f54-47dc-bb3c-034e92a5145b@zytor.com>
Date: Wed, 12 Feb 2025 00:33:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/23] x86/resctrl: Remove MSR reading of event
 configuration value
To: babu.moger@amd.com, Reinette Chatre <reinette.chatre@intel.com>,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, tony.luck@intel.com,
        peternewman@google.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
        akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
        xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
        daniel.sneddon@linux.intel.com, jpoimboe@kernel.org,
        perry.yuan@amd.com, sandipan.das@amd.com, kai.huang@intel.com,
        xiaoyao.li@intel.com, seanjc@google.com, xin3.li@intel.com,
        andrew.cooper3@citrix.com, ebiggers@google.com,
        mario.limonciello@amd.com, james.morse@arm.com,
        tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
        eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <b4298186c0be8db76be4eb74e1d948fbe5c1de7d.1737577229.git.babu.moger@amd.com>
 <ead5a097-44f7-4eaa-8e98-08450b4d51f6@zytor.com>
 <ffb74a45-ca63-46a4-9047-d55c9f51375a@intel.com>
 <0fc8dbd4-07d8-40bd-8eec-402b48762807@zytor.com>
 <b09e5829-6192-47f0-aed4-93116c33f4a0@amd.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <b09e5829-6192-47f0-aed4-93116c33f4a0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/11/2025 11:44 AM, Moger, Babu wrote:
> Hi Xin,
> 
> On 2/7/25 04:07, Xin Li wrote:
>> On 2/6/2025 8:17 AM, Reinette Chatre wrote:
>>>>> +    wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
>>>> This is the existing code, however it would be better to use wrmsrl()
>>>> when the higher 32-bit are all 0s:
>>>>
>>>>       wrmsrl(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config);
>>>>
>>> Could you please elaborate what makes this change better?
>>
>> In short, it takes one less argument, and doesn't pass an argument of 0.
>>
>> The longer story is that hpa and I are refactoring the MSR access APIs
>> to accommodate the immediate form of MSR access instructions.  And we
>> are not happy about that there are too many MSR access APIs and their
>> uses are *random*.  The native wrmsr() and wrmsrl() are essentially the
>> same and the only difference is that wrmsr() passes a 64-bit value to be
>> written into a MSR in *2* u32 arguments.  But we already have struct msr
>> defined in asm/shared/msr.h as:
>>      struct msr {
>>              union {
>>                      struct {
>>                              u32 l;
>>                              u32 h;
>>                      };
>>                      u64 q;
>>              };
>>      };
>>
>> it's more natural to do the same job with this data structure in most
>> cases.  And we want to remove wrmsr() and only keep wrmsrl(), thus a
>> developer won't have to figure out which one is better to use :-P.
>>
>> For that to happen, one cleanup is to replace wrmsr(msr, low, 0) with
>> wrmsrl(msr, low) (low is automatically converted to u64 from u32).
>>
>> However, I'm fine if Babu wants to keep it as-is.
> 
> Thanks for the explanation.  Changed it to use wrmsrl().
> 

You're welcome.  And thanks for making the change.

