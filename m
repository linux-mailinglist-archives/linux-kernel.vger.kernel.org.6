Return-Path: <linux-kernel+bounces-326995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1E6976F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFB31C23E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993E11B9850;
	Thu, 12 Sep 2024 17:36:30 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054C17837A;
	Thu, 12 Sep 2024 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162590; cv=none; b=gqTUE9ExYd899IppjxGDQou5fQFGLtaYB7ehERELKYoUkL0cDYQjwWG9AAfxKLBZ6+OyIMxCiWcpySosMm2dd29NB9sOCsEko3a1kFDSh7A3HhnDs0ZeI+2OEZRMx1s2Lu0cCZggCEBjgT/ukG9h/H4x6Rw51R67y3xHA1PhduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162590; c=relaxed/simple;
	bh=+FlbC/3U714LtmseffHdvybFIBJGuTjQcO+84rTczl0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WBISU5GQ8+RMMfI4fFrfdJnPbBCDYq2qosbkg3nm4LqzOIAI20lRY4k3a3vWhTDQl/uavzQocwI2D9JSRAafACBzSnYodqk4qTereKltjPJAzGtq1XFJlf9e72KzkuGlS0kLVZ4bGesnPXBuGVLvOf25YEQm3MtNop/K+eN2fso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.106] (178.176.74.114) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 12 Sep
 2024 20:36:10 +0300
Subject: Re: [PATCH v2] KEYS: prevent NULL pointer dereference in
 find_asymmetric_key()
To: Jarkko Sakkinen <jarkko@kernel.org>, Roman Smirnov <r.smirnov@omp.ru>,
	David Howells <dhowells@redhat.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	Andrew Zaborowski <andrew.zaborowski@intel.com>
CC: <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20240910111806.65945-1-r.smirnov@omp.ru>
 <D42N9ASJJSUD.EG094MFWZA4Q@kernel.org>
 <84d6b0fa-4948-fe58-c766-17f87c2a2dba@omp.ru>
 <D43HG3PEBR4I.2INNPVZIT19ZZ@kernel.org>
 <8774f6a2-9bec-b699-6b68-63a26019c5b3@omp.ru>
 <D44DK087Y80R.25CNND6WHJ7EE@kernel.org>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <dbc7249a-7bf5-7e5f-7204-d368c052023c@omp.ru>
Date: Thu, 12 Sep 2024 20:36:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <D44DK087Y80R.25CNND6WHJ7EE@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/12/2024 17:17:50
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187714 [Sep 12 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.114 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.114
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/12/2024 17:20:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/12/2024 1:09:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/12/24 5:27 PM, Jarkko Sakkinen wrote:
[...]

>>>>>> In find_asymmetric_key(), if all NULLs are passed in id_{0,1,2} parameters
>>>>>> the kernel will first emit WARN and then have an oops because id_2 gets
>>>>>> dereferenced anyway.
>>>>>>
>>>>>> Found by Linux Verification Center (linuxtesting.org) with Svace static
>>>>>> analysis tool.
>>>>>
>>>>> Weird, I recall that I've either sent a patch to address the same site
>>>>> OR have commented a patch with similar reasoning. Well, it does not
>>>>> matter, I think it this makes sense to me.
>>>>>
>>>>> You could further add to the motivation that given the panic_on_warn
>>>>> kernel command-line parameter, it is for the best limit the scope and
>>>>> use of the WARN-macro.
>>>>
>>>>    I don't understand what you mean -- this version of the patch keeps
>>>> the WARN_ON() call, it just moves that call, so that the duplicate id_{0,1,2}
>>>> checks are avoided...
>>>
>>> I overlooked the code change (my bad sorry). Here's a better version of
>>> the first paragraph:
>>>
>>> "find_asymmetric_keys() has nullity checks of id_0 and id_1 but ignores
>>> validation for id_2. Check nullity also for id_2."
>>
>>    Hm, what about WARN_ON(!id_0 && !id_1 && !id_2) -- it used to check all
>> the pointers, right? I think our variant was closer to reality... :-)
> 
> Right (lazy validation, first null ignores rest)

   No, contrariwise: since we use && and !, first non-NULL would ignore the rest.

> BR, Jarkko

MBR, Sergey

