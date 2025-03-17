Return-Path: <linux-kernel+bounces-564583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8A4A657BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D88188DDB1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F353419D09C;
	Mon, 17 Mar 2025 16:19:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636338C1F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228340; cv=none; b=TdzvkJ66edmzKCOe8BLuJMbd8buTzjVV66Ze6ZrH5gJhu8V0Pldovr3GGjmC96LDXCTAvLes8UZppT4OfsouDM5//k8yYJm9cI+ZJk3hIeFu+Z1yT4DrZ9a7yXgHHB+IfM0PlouC+5bG0J6sE/9IMAjvm/hg/0/dLcbYWdgqPro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228340; c=relaxed/simple;
	bh=6rQeh550awBHYaCqL+6KVASX3lywQZMB/ygYf+frD1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxP7vtK/Gkp5E2UdcD4DlReVvCdhmt0MTWcI3YLp1ysoGSg9hYlbS+n4l4T/ctUial9mSKo5kNge+Sxmvji3wy3Xq5f3txJQedOHks/c5rnsgl+A1qDlEHOk9c71pzE7HW6WKlIR3Ei2X7oVSMHNlY48Y2T1AvH/WA4slUEh8o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4273713D5;
	Mon, 17 Mar 2025 09:19:06 -0700 (PDT)
Received: from [192.168.3.45] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 194A73F63F;
	Mon, 17 Mar 2025 09:18:51 -0700 (PDT)
Message-ID: <c357e638-d523-4cd2-a15f-ed3b0b41bd22@arm.com>
Date: Mon, 17 Mar 2025 17:18:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/4] arch_topology: Support SMT control for OF based
 system
To: Yicong Yang <yangyicong@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
 tglx@linutronix.de, peterz@infradead.org, mpe@ellerman.id.au,
 linux-arm-kernel@lists.infradead.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, pierre.gondois@arm.com,
 yangyicong@hisilicon.com, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, morten.rasmussen@arm.com, msuchanek@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, jonathan.cameron@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com, xuwei5@huawei.com,
 guohanjun@huawei.com, sshegde@linux.ibm.com
References: <20250311075143.61078-1-yangyicong@huawei.com>
 <20250311075143.61078-3-yangyicong@huawei.com>
 <2bd3aa0a-d700-46bf-81d1-a5fb0364d1e0@arm.com>
 <c88e5b78-37b7-3023-7842-56a93fe119d2@huawei.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <c88e5b78-37b7-3023-7842-56a93fe119d2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2025 12:29, Yicong Yang wrote:
> On 2025/3/17 17:56, Dietmar Eggemann wrote:
>> On 11/03/2025 08:51, Yicong Yang wrote:
>>> From: Yicong Yang <yangyicong@hisilicon.com>

[...]

>>> Both method support to completely disable/enable the SMT cores so both
>>> work correctly for symmetric SMT platform and asymmetric platform with
>>> non-SMT and one type SMT cores like:
>>> core A: 1 thread
>>> core B: X (X!=1) threads
>>>
>>> Note that for a theoretically possible multiple SMT-X (X>1) core
>>> platform the SMT control is also supported as expected but only
>>> by writing the "on/off" method.
>>
>> Here we still have a little misunderstanding. IMHO, even on such a
>> system 2) would work too.
>>
> 
> 
> yes but only by writing the max_thread_number. e.g. a system with SMT number
> of 1 (no SMT core), X, Y (Y > X), 1 works same as "off" and Y works same as
> "on", as you shown below. write X will be blocked by the CPU framework:
> estuary:/sys/devices/system/cpu/smt$ cat control
> off
> # emulated CPU 0-7,16-22 as SMT-2, CPU 8-11,24-27 as SMT-4
> estuary:/sys/devices/system/cpu/smt$ cat ../online
> 0,2,4,6,8,12-16,18,20,22,24,28-31
> estuary:/sys/devices/system/cpu/smt$ echo 2 > control
> bash: echo: write error: Invalid argument
> estuary:/sys/devices/system/cpu/smt$ echo 4 > control
> estuary:/sys/devices/system/cpu/smt$ cat ../online
> 0-31
> 
> so method 1) will always match the expectation to fully enable/disable the
> SMT on all cores, that's I mean here. But 2) won't work if user expected
> to write 2 to enable SMT-2 (I think it'll will work if we support
> CONFIG_SMT_NUM_THREADS_DYNAMIC on arm64 later).

OK, looks like you're aware of this then. Just saying that technically
'4' would be the max thread number of the system and not '2' so it still
looks OK from this perspective. But OK, we don't have those systems now
anyway.

[...]

