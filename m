Return-Path: <linux-kernel+bounces-358442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C82997F75
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406BA1F24B01
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310081EABB5;
	Thu, 10 Oct 2024 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="UjJUKCqM"
Received: from smtpcmd11117.aruba.it (smtpcmd11117.aruba.it [62.149.156.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DB719AD73
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545353; cv=none; b=ESboDl3PC94whFOKPF2eJFINyWY15I8oJlOBigC4XQUxMCcX6kBbk05SuwqLI74nJOwAY2MYeqoBz0CsmYlbBjsFdaYpRIolRGU4+6jYlbRvfmKrbuU/vh0/MdIqxRksX2xp3ODSPTsApfXUjN0bA2wEgSvS0zGGn6W1jg/Qddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545353; c=relaxed/simple;
	bh=bQ1iSUwJzTr3VrEef8bPG0Zt6AQ6fVnnO+sar11PSgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RInoQE27212D2uQE2TWWRpkkAKsAUnwNKgcmDpLd4kX/BK8g6RzWH0blCQMtbP0lLN2diaAESiQV+ovCf9rchugKKhBzUdLzHxjPAUXOr1VgFJLo8SuFJq/9iFnTQ2AdLpUfli9vvoBPn1bESsM6Y3RmR0vf+tAjK21u4VKuQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=UjJUKCqM; arc=none smtp.client-ip=62.149.156.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id ynYdsm3VA7AmWynYdsLL4v; Thu, 10 Oct 2024 09:26:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1728545160; bh=bQ1iSUwJzTr3VrEef8bPG0Zt6AQ6fVnnO+sar11PSgY=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=UjJUKCqMeAa0MwXs3t0mx3oLtXGfiRm0USiGCvjP8Y6linHoj0fH6lWHQzv0JeWd1
	 8bfIpd1tCASizMTD/VnfWE9YNjhP4nwVt23jyrDUz9kuFPE6o1xTVCNqsYzVCp5Hws
	 U8q6EXOHUlcoFW0lSVKdtxhcev+gELnnLOQTsWx38YQNHcTaZ6d6Dk7iH3ercaOcZR
	 hD/vXXCwcDcptMbYfcFoAAE/c+luXKVllqTmxP8vHzzRclxCe6ySuZMXZJ5UaxJM8r
	 iB/UnJvAR0TMXqaE/J3LmEyTUMyec4BLiM7umNnLgFNUmh7TMFSEDxk1S+433ALlQW
	 NP1AFAQ33/8sg==
Message-ID: <7158028e-e516-4eb6-b207-eb8c2d92fd39@enneenne.com>
Date: Thu, 10 Oct 2024 09:25:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] drivers pps: add PPS generators support
To: Greg KH <greg@kroah.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net,
 Hall Christopher S <christopher.s.hall@intel.com>,
 Mohan Subramanian <subramanian.mohan@intel.com>, tglx@linutronix.de,
 andriy.shevchenko@linux.intel.com, Dong Eddie <eddie.dong@intel.com>,
 N Pandith <pandith.n@intel.com>,
 T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
 Zage David <david.zage@intel.com>,
 Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>
References: <20241008135033.3171915-1-giometti@enneenne.com>
 <20241008135033.3171915-2-giometti@enneenne.com>
 <2024100855-unsecured-mammogram-001a@gregkh>
 <541eb5c6-5546-4170-9e8b-d421d55822a1@enneenne.com>
 <2024100917-daybed-suffering-7367@gregkh>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <2024100917-daybed-suffering-7367@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMovEkJirDeIFPRfqGHWgUK1T7K7szP+CmR0YPO1yusObFLFvawUZjIdqY8KMkBQCoAElOj4d6SclKPyisnDeXEZRclrFcAvaqZaBaJkNvqsyVNiySEt
 KCJb5GtJXlpj/SYO/3nAF1OKbpV2yN4idgA95kRZPRKJm8Jo/opvuyNVmC60w46+vdgKMLj2cfeAgDZNYOqLiCj7BQvco9dr3RA0Kc0txrMbv/6tZ43Rmukh
 qVEKIjJNrqvXB7tEDETbmEsf9MUTd7fOGjhuM57PIofIKrqtwWk7BpM0y2TGqdUW2gj3j+waqrluIMTpLoD6CSV2Omx8EBGyqDRUcSH/T32x/1hCav5SomsX
 f58qUDT6Un0RFWYDbDxyHuOXtNeMGj+Fv70Vk9zOSrjqpE0qvyMvtEXzBdYvcUmksK3uoLGSdccwtgf+psrJHOjFu7jj5rZ6sPf/gnrn8ixUpxPnqm7/NS9M
 clNUA2NP65OJcs7h0KiO/AwFZPLNvLl7sdat2WSeSotGBNpMSDTzz+BUAlE3B263pokXsl3ioeJI6WzMzMoRG/onkjW+5YRWBY36sY9uHzZdqNrnOMSKxiKq
 5qLL3s6Ym3Vo2YGo5gm1Hl1ic5cLHiF0WXl4/KQcrCBjTYh1EmcEoHNkX3k8xhnkwhGuYYx2+LjqNMHkjcY/yYTp

On 09/10/24 11:19, Greg KH wrote:
> On Wed, Oct 09, 2024 at 10:48:14AM +0200, Rodolfo Giometti wrote:
>>>> +	kobject_put(&pps_gen->dev->kobj);
>>>
>>> Messing with a kobject reference directly from a device feels wrong and
>>> should never be done.
>>
>> I followed the suggestions in this patch whose look sane to me:
>>
>> https://lore.kernel.org/lkml/fc5fe55c-422d-4e63-a5bd-8b6b2d3e6c62@enneenne.com/T/
> 
> That patch is wrong.

:(

>>>   Please use the proper apis.
>>
>> Which API are you talking about? Can you please provide some advice?
> 
> get_device()
> 
> You are working on devices, NOT a raw kobject, no driver should EVER be
> calling into a kobject function or a sysfs function, there should be
> driver core functions for everything you need to do.

OK, I'm going to provide a new RFC taking in account what you suggest.

Thanks,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


