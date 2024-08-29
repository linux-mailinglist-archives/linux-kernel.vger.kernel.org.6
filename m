Return-Path: <linux-kernel+bounces-306377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AFD963E28
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7A228318F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08B018A920;
	Thu, 29 Aug 2024 08:14:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AB118A6BA;
	Thu, 29 Aug 2024 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919289; cv=none; b=GJuaxpTlNymPUzZH8jedkNtX5ayIJbzahvFXlSSpZob0VCCXMEV8SRANgzv6nbvGLXudiQIglgxjkbj4OtCeStncV6FYOlb4kSDbEZmiVpyxJNb3PBrkrpPDZf7Xwiz20vqO9gVfN0TH9aL/rXPaWFrAH6xbOpuSYH8CRprMcM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919289; c=relaxed/simple;
	bh=5nbNt2FUh7dAfC17NuB68l1XTwn3A7VhERg/TR62njw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAnO/n+GdsXCxqg6WjuAwIBkm2WV1qaIjGSLOrRT8VSxx8D84vkWWbU2rtgtrLjVqOdV06QCdMCZCbmCucqi4Bhtblqzaz1kADKfuMHYKNcHoGsaN7aOrldssEiS2ADTwlkxIBuobL2uB+lfubzFW3DoQBdeq0C06z95+d2U8KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23FFDDA7;
	Thu, 29 Aug 2024 01:15:11 -0700 (PDT)
Received: from [10.162.41.23] (e116581.arm.com [10.162.41.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB3FE3F73B;
	Thu, 29 Aug 2024 01:14:42 -0700 (PDT)
Message-ID: <dd9faaa9-72ea-445d-b687-5005ede01b09@arm.com>
Date: Thu, 29 Aug 2024 13:44:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tools/mm: Use calloc and check the potential memory allocation
 failure
To: Markus Elfring <Markus.Elfring@web.de>,
 Zhu Jun <zhujun2@cmss.chinamobile.com>, linux-mm@kvack.org,
 kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240829055621.3890-1-zhujun2@cmss.chinamobile.com>
 <716f7466-562d-4bbe-a8ec-851a0b289db5@web.de>
 <37577635-89c9-4afe-a30d-add02c0eb896@arm.com>
 <22213ddd-90b3-4d33-aa80-4b3500a21a2e@web.de>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <22213ddd-90b3-4d33-aa80-4b3500a21a2e@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/29/24 13:25, Markus Elfring wrote:
>>>> Replace malloc with calloc and add memory allocating check
>>>                         memset(…, 0, …) call by calloc()?
>> Calloc returns zeroed-out memory.
> I propose to improve the change description considerably.
>
>
>>>> of comm_str before used.
>>> * Add also a null pointer check for the detection of a memory allocation failure.
>> Which is exactly what Zhu has done?
> Can the commit message become nicer anyhow?

I agree. The commit message should note two things, first that
a malloc followed by a memset to 0 can be reduced to single calloc,
and second that, "add memory allocating check" can be replaced by
"add null pointer check in case of allocation failure".

>
>
> …
>>> * How do you think about to omit the statement “fprintf(stderr, "Out of memory\n");”?
>> Why?
> I imagine that a returned null pointer can eventually be sufficient already.
> Would you get helpful background information from the variable “errno”?

In case of calloc failure, errno is always set to ENOMEM, so we are guaranteed
that any failure is an out of memory failure.

>
> Regards,
> Markus

