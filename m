Return-Path: <linux-kernel+bounces-383807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E09B206B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E581F2162D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E516A17DFEB;
	Sun, 27 Oct 2024 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KIbiAX9f"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C38B538A;
	Sun, 27 Oct 2024 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730061409; cv=none; b=m6DwQ2QZSgzjEGTrnlN60g5gteffV4+YyOsij+UBz6x815x8UhKagFg+sGh6magQu+9+pjmAH/pfeZJyOM9GnPTcehZVjJ7KrAruabxFUpoxGaSLu3zegauidupCOTbayxFdYfoIImE7vK3a4GavFAeqF/QZds+h7f7XGjtdw88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730061409; c=relaxed/simple;
	bh=Fv3t6WtdreydPQC2HvlJ+b/VMr25i1rzEb8oZDgJwSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgcZtHs+a010H+ye1M2hzQXNecG8b91JyFecUTIrW1eXIWwJGcpt24aKucYX+kUl+ujYAPxRknw8kVCjcTpqFsQB1RA+Rrp9r1Km5cmvsYpnWB5BboK/DDHaY7If6tj87DWVRtYAce4siozQTVbsFR+xUlMkcg1eKERbIF3aidA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KIbiAX9f; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rFAltSKG1m2oenqtoIabRWHZoL/IV/CzYGCkbW9DGGU=; b=KIbiAX9fAQ/YFzvM8+wTx/P3b4
	Ft5w5WMfk+Cr2xtrmibLZ0c84Ans8HICq0Aut6t9EQiBXAE3uMO4u9rSh1mCYoBCwa1/uIZHxQgJT
	4GIkGcNTmXxe7N4dr54dCqTjZVj+aUTvO82LxeZT/rT3CWMJdJD7ygzgnFRUOCkwZSl4SvoWY9+6n
	WWdEX+Kmw7bxcB1WXftoCCKCvAiLDB6LqjfNL+3DE6802oEstsLX/Emq46J48Iyl43u5zeq6I5Ceq
	vKTrn3CHYOE+7bjBfzEfie7LM9riVe+0W00gMRmxbLWz+MWispVbngD9PE4Z5GvWXH5V9LVJt98qy
	jXkNabUg==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t59zt-00Fprx-DZ; Sun, 27 Oct 2024 21:36:25 +0100
Message-ID: <9126583d-5865-4dcb-afe5-e846cccbea4c@igalia.com>
Date: Sun, 27 Oct 2024 17:36:19 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: fix the format of the kernel parameter
 ``thp_anon=``
To: Barry Song <baohua@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20241027175743.1056710-1-mcanal@igalia.com>
 <20241027175743.1056710-2-mcanal@igalia.com>
 <CAGsJ_4xPr3X_EXh73c4gN-cUSxaXZ-XR=_VNE750zNH61nyR-Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <CAGsJ_4xPr3X_EXh73c4gN-cUSxaXZ-XR=_VNE750zNH61nyR-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Barry,

On 27/10/24 16:52, Barry Song wrote:
> On Mon, Oct 28, 2024 at 1:58 AM Maíra Canal <mcanal@igalia.com> wrote:
>>
>> If we add ``thp_anon=32,64KB:always`` to the kernel command line, we
>> will see the following error:
>>
>> [    0.000000] huge_memory: thp_anon=32,64K:always: error parsing string, ignoring setting
>>
>> This happens because the correct format isn't ``thp_anon=<size>,<size>[KMG]:<state>```,
>> as [KMG] must follow each number to especify its unit. So, the correct
>> format is ``thp_anon=<size>[KMG],<size>[KMG]:<state>```.
> 
> what if 32768,64K: always?

``32768,64K:always`` works. From the kernel parameters documentation, I
see that:

"Finally, the [KMG] suffix is commonly described after a number of
kernel parameter values. These ‘K’, ‘M’, and ‘G’ letters represent the
_binary_ multipliers ‘Kilo’, ‘Mega’, and ‘Giga’, equaling 2^10, 2^20,
and 2^30 bytes respectively. Such letter suffixes can also be entirely
omitted"

AFAIU this means that [KMG] can be omitted if we use bytes. But if we
don't use bytes, it cannot be omitted.

Best Regards,
- Maíra

> 
>>
>> Therefore, adjust the documentation to reflect the correct format of the
>> parameter ``thp_anon=``.
>>
>> Fixes: dd4d30d1cdbe ("mm: override mTHP "enabled" defaults at kernel cmdline")
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 2 +-
>>   Documentation/admin-guide/mm/transhuge.rst      | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 1518343bbe22..1666576acc0e 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -6688,7 +6688,7 @@
>>                          0: no polling (default)
>>
>>          thp_anon=       [KNL]
>> -                       Format: <size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<state>
>> +                       Format: <size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<size>[KMG]:<state>
>>                          state is one of "always", "madvise", "never" or "inherit".
>>                          Control the default behavior of the system with respect
>>                          to anonymous transparent hugepages.
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>> index 203ba7aaf5fc..745055c3dc09 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -303,7 +303,7 @@ control by passing the parameter ``transparent_hugepage=always`` or
>>   kernel command line.
>>
>>   Alternatively, each supported anonymous THP size can be controlled by
>> -passing ``thp_anon=<size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<state>``,
>> +passing ``thp_anon=<size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<size>[KMG]:<state>``,
>>   where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE and
>>   supported anonymous THP)  and ``<state>`` is one of ``always``, ``madvise``,
>>   ``never`` or ``inherit``.
>> --
>> 2.46.2
>>


