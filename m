Return-Path: <linux-kernel+bounces-386779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7909D9B47D0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E549AB2453E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D7020607A;
	Tue, 29 Oct 2024 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SMyY1FX5"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE120606B;
	Tue, 29 Oct 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199826; cv=none; b=CLnrCjYQxzg5G9/ey3YrScHYAbI2cfsXObjyTzbXW1+YA8sLg1W6MaC8EnPhovXzUx5ULfRmYU59ekugWn5A89LAfCQTeJMjRjE35K1u/vq5YS5v6zKLX3lHD8IGrFDPYZqRC3FcaUUswtqXG/uR1CUWb0GpHvR6OV5v4N1VdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199826; c=relaxed/simple;
	bh=WoBnGVVt6CyKgZYpepDo803Mqerb5sbRInXKA/I3q6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qm/+eDTi+jP+P34vBiQ17DD14GYWGmeuHqMlClMX0iOYl5mZ1ZS6OO+wZANvW4RoYubc/1IdJJQ2lgAtRtY2nuq8ywauG93Tk7m2WpjLMxiF7ODGN8HidmSSAqJH/oggk/FIPGYzNCwWkqDWyHF7ZKirjdb+nh36w/JtDurHKQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SMyY1FX5; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=psSewTcXqOY4Qf7bkmixNMW1kHT74PJEKuMsClxav4Q=; b=SMyY1FX57TshQVK9zxUZmMtaGt
	g1FpOidJFXvAYTMjmm4+lCGKOo77IfqNsvGO4Gmqvj8S5D6welpeo73FV/h+TOyqa9vIz09GbVJwx
	Aoqipwl2uY0+O99K3DK27ayoaCZX+EGhxrau8TZx2XBzs5NvcoOnSKqSaSlC61ZOQLDThwexnCYuO
	JzVfUJhOF7lGcYPqINDw3X5QjKop4duGnST7NU5Gj+7Lw9TbRH8YEbvE4CJgBOEoTs14askFNt5Eq
	7ZpFerswy5ijdOFCOdb9Y4T2FKbPtPK2Ya+6EmWkkXp8OU5xE5QN8GY1A8ejrzrbrRK3Q3/0MJsUY
	Vn1DrHsA==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t5k0R-00GaoS-Ov; Tue, 29 Oct 2024 12:03:24 +0100
Message-ID: <1f4f02ce-f61c-4346-a6b8-e9cb65cd9733@igalia.com>
Date: Tue, 29 Oct 2024 08:03:17 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm: fix docs for the kernel parameter
 ``thp_anon=``
To: Barry Song <baohua@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20241029002324.1062723-1-mcanal@igalia.com>
 <20241029002324.1062723-2-mcanal@igalia.com>
 <CAGsJ_4xEpk1dQFBWfkqGqiSV+Z5Qzyp1Rju1zEhErDRgBWeXtg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <CAGsJ_4xEpk1dQFBWfkqGqiSV+Z5Qzyp1Rju1zEhErDRgBWeXtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Barry,

On 28/10/24 22:03, Barry Song wrote:
> On Tue, Oct 29, 2024 at 8:24 AM Maíra Canal <mcanal@igalia.com> wrote:
>>
>> If we add ``thp_anon=32,64K:always`` to the kernel command line, we
>> will see the following error:
>>
>> [    0.000000] huge_memory: thp_anon=32,64K:always: error parsing string, ignoring setting
>>
>> This happens because the correct format isn't ``thp_anon=<size>,<size>[KMG]:<state>```,
>> as [KMG] must follow each number to especify its unit. So, the correct
>> format is ``thp_anon=<size>[KMG],<size>[KMG]:<state>```.
>>
>> Therefore, adjust the documentation to reflect the correct format of the
>> parameter ``thp_anon=``.
>>
>> Fixes: dd4d30d1cdbe ("mm: override mTHP "enabled" defaults at kernel cmdline")
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> Acked-by: Barry Song <baohua@kernel.org>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Can we separate this and apply it to v6.12-rc? If Andrew doesn't require a new
> version for the separation, can we extract it from this series and
> apply it to mm?

That's fine on my side.

Best Regards,
- Maíra

> 
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
> 
> Thanks
> Barry


