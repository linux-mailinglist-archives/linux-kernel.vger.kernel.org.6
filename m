Return-Path: <linux-kernel+bounces-212350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63900905EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074AC1F23191
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BAA12CD8E;
	Wed, 12 Jun 2024 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TWfvLOSP"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C15A93B;
	Wed, 12 Jun 2024 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718233839; cv=none; b=F60vLwhw3TnBI03fccWFoNLRsShkRiTyM6XjGp3UPcccy4r6mnOoeTAThb8VZwQ8EzLEHEjVzM2ZeYZuICuRhPwuID59rbuyzNx2B9XRCPYScA6trc1LVx91oK4yxT7EPXbqLu7WtGgE04djSIcYoviN8eBhTMwRV38qtEMa8Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718233839; c=relaxed/simple;
	bh=wFRcfl5izoN53PayD4VasF50BNwsy4jXG6sO4PEktxQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mv9cEGYZkAEfyrwj+G1gQ+/j9QckgV7MmJim3yHqDiblpjVfOcmPyO8uiP8K9if1ZC+Ilwpvg+qiG8qZsZ3aZRgwNX0xMz5eldLi564SL4piA9YpJ7H0tC7gFc2nUPqWwcUoxgqm60kaPoXDScZ0OXqs4PkZQrzHG3l9P+l2bFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TWfvLOSP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=eoigYPYZGAExw8JxZs0CQo5GQsUUfdY3ezYuFzbyK0I=; b=TWfvLOSPfIL8qK98bxX9QtItq2
	QllwxAbiaRDuwYW7vjT69l2FPFBQRGyNHiPmsHelvbl5+gXh7YFaKZjmaGEMQ4/F3M2cVgdtlc4zj
	LsudIe9imLOM+86FVesLMHE9XOdn4Q1HOXgX4XFJ1j/0va/42yoR/t7rcsdCly+MRUc19KGa//4ex
	M0DSTj6W563PxaxQ6K8/UMTs1we3lFGnlXdZhUVR+ONkfNVp76JWN81vqEVtTEHC6pgrkO/sLdiun
	Kf3Ry4QTiTsUkHRVP2shqxCVCBSRQlKS5cFHwqeHDhvUk0F8Kl8l+BYSLD8Qlxyznb5BeT+cmVmWe
	TdUkSDtQ==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHX6w-0000000EQXc-0E5e;
	Wed, 12 Jun 2024 23:10:34 +0000
Message-ID: <9179dbe6-d865-492f-a8e9-da91626c095d@infradead.org>
Date: Wed, 12 Jun 2024 16:10:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Extend and refactor index of further kernel docs
From: Randy Dunlap <rdunlap@infradead.org>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, bilbao@vt.edu
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <fdf68be7-875a-421d-8bc3-034a21990679@gmail.com>
 <87ikyvccwc.fsf@meer.lwn.net>
 <2acd884f-2f04-4d39-b559-aac99f9ae35e@gmail.com>
 <53bd3bbf-0410-425e-84e7-1d34cac60412@infradead.org>
 <5a2389c8-f64a-47c1-8924-c603628c52fb@infradead.org>
Content-Language: en-US
In-Reply-To: <5a2389c8-f64a-47c1-8924-c603628c52fb@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/12/24 4:07 PM, Randy Dunlap wrote:
> 
> 
> On 6/12/24 3:17 PM, Randy Dunlap wrote:
>>
>>
>> On 6/1/24 8:03 AM, Carlos Bilbao wrote:
>>> Extend the Index of Further Kernel Documentation by adding entries for the
>>> Rust for Linux website, the Linux Foundation's YouTube channel, and notes
>>> on the second edition of Billimoria's kernel programming book. Also,
>>> perform some refactoring: format the text to 75 characters per line and
>>> sort per-section content in chronological order of publication.
>>>
>>> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
>>> ---
>>>  Documentation/process/kernel-docs.rst | 68 +++++++++++++++++----------
>>>  1 file changed, 44 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/Documentation/process/kernel-docs.rst
>>> b/Documentation/process/kernel-docs.rst
>>
>> The 2 lines above should be on one line, but fixing that doesn't fix everything.
>> 'patch' still says that it's a malformed patch.
>>
>> Carlos, please check Documentation/process/email-clients.rst section on
>> Thunderbird, especially for line length and line wrap.
>>
>> I'm still looking...
> 
> I don't know what is causing it, but there are a bunch of non-ASCII characters
> in the patch file. Specifically 0xc2 at the beginning of many lines. E.g., when
> I copy/paste only the "Index of Further" & ===== lines into a small text file:
> 
>> hd docs-chars.txt 
> 000000 c2 a0 49 6e 64 65 78 20 6f 66 20 46 75 72 74 68  >..Index of Furth<
> 000010 65 72 20 4b 65 72 6e 65 6c 20 44 6f 63 75 6d 65  >er Kernel Docume<
> 000020 6e 74 61 74 69 6f 6e 0a c2 a0 3d 3d 3d 3d 3d 3d  >ntation...======<
> 000030 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d  >================<
> 000040 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 0a  >===============.<
> 

Ah, C2 A0 is a non-break space. My guess is that Thunderbird
is doing something here.

> 
>>
>>> index 8660493b91d0..6f3e290abd22 100644
>>> --- a/Documentation/process/kernel-docs.rst
>>> +++ b/Documentation/process/kernel-docs.rst
>>> @@ -3,27 +3,27 @@
>>>  Index of Further Kernel Documentation
>>>  =====================================
>>
>>
> 

-- 
~Randy

