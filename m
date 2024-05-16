Return-Path: <linux-kernel+bounces-180870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C058C7433
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F331F2457B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DFF14387A;
	Thu, 16 May 2024 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPKyMEX8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C714386F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853306; cv=none; b=htVKpaHCuu0wdUR72mIErw9lh3zBTaW9YikrTDg8FrpJbfpVzt6U+BNiOwpX8X69Iwf4FTOKfb0uG1b2tgzeMwD6vr7NdRG7XdvJayEj4fy/pBti/iYtCu7ZZ72YX3WyE/zaYtwNZeNeHaC9sAOV8YgIuSKjgVIGveWqFfs0gCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853306; c=relaxed/simple;
	bh=XwF9aQslGRS3Qj6N+bpXalGzW3AZ50RGxLLO3j7uIwo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ekl5E36VE3LKPYfaYNQh2AEMk4rLtalJ1giouBuEok7Jez7AsnYOF7JlVmlDVNNGzTKmS6r6vPsx93May6KFr7BF4BuDsl0pbcv5ZIay1aAOTHdHv/vhIm7LkCQIE+sZzi7BRGir8HVPtP6CZR9QNENgjqbHB9tuFJKVgr1hH9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPKyMEX8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715853303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCLlRn0O7TcoEywJNo4KTsygfUnn9t9neEyPiTqepkk=;
	b=NPKyMEX8uMbzX6VXKgh8R40HPUJLsSPBn+qn4xplKlffn1EVlhpQaczPUZ3QCwNFpj0giy
	8q9gDL7D3MF3IHUpfKV41crO8JM3Qztd6FlLx9v9U8ZMkBsHI1TTc6A4rpqm/gaaozvcfd
	0rcBaVmwFyJ2DCG4hocnaIeYV8WVXEw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-2m9Qa3GKMAK8up0UScXrQA-1; Thu, 16 May 2024 05:55:00 -0400
X-MC-Unique: 2m9Qa3GKMAK8up0UScXrQA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a59a63a1f78so476043166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 02:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715853300; x=1716458100;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCLlRn0O7TcoEywJNo4KTsygfUnn9t9neEyPiTqepkk=;
        b=VSHDWnIYOoNNhn56nmY7Cb19aRTSMa8gYohdKW0aHRD09ajjqjMAV0nNXrw6gvXx2P
         hCVh71BTYzLrZVmOIfoilSNgPdd7eg0osX1GGte7ry5sT9HzwxaXP84WvP5PdJZoIfQD
         QKigkDYJzF7TQrVFeSK/aOQbx8+nrU/Nx/2a4bqvrkTcU5dhS3osaTbet0BtgKLh0m71
         VOdAZuHzx5qG1tol+FzleeTCD770wn9UmR7dkhYpdLaRx7j7Lgq/hwOtfpxBqULj2J6G
         B+6/YBO+QLtryxrs8xt/xOm1sfZM1wIHGweqM6jP3vjJ7+UhiGH+VqSDNJ+lLnYTeze+
         myZw==
X-Forwarded-Encrypted: i=1; AJvYcCXHmmadUkmrK+vmXtpLwp5ooOfYWEdZiUO41J8NoSDMNbI1WFH9ftDDXizIkmMUv+5t49Ta0j/duaTB7Sp47kPsxfy3wgukZVCJZ4yC
X-Gm-Message-State: AOJu0YzQKaroexjQdOKNtJ0AjGxSVn+aBLTA5o3acq8VH7JHrv4Tnvi8
	htksHRokL92wQwzZDtGioBGhr/Tn96cc4nl1S1/MPc4tm/tY7fDA2AI8GgmStd07tR4F9IL29K8
	WVLQ8+azqzkcqiVfd6nliNDlk/jn2EVyeXCtxnO2INV9mJnRLM9FAnLFj9Vs1QA==
X-Received: by 2002:a17:906:5394:b0:a52:2441:99c with SMTP id a640c23a62f3a-a5a2d67f8c0mr1312589666b.69.1715853299872;
        Thu, 16 May 2024 02:54:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGAj7Y0Agk/yxlpgG6wGjr+FCkPj7ADMJB7nw62J/hGeL4ZAm5mAOCLdhW9sSlzNX6lSHAtw==
X-Received: by 2002:a17:906:5394:b0:a52:2441:99c with SMTP id a640c23a62f3a-a5a2d67f8c0mr1312588766b.69.1715853299499;
        Thu, 16 May 2024 02:54:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57509a90101sm695433a12.79.2024.05.16.02.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 02:54:59 -0700 (PDT)
Message-ID: <74dc970b-32a1-4baf-b51e-80e766912ed9@redhat.com>
Date: Thu, 16 May 2024 11:54:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ACPI: EC: Install EC address space handler at the
 namespace root
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <w_armin@gmx.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <12437901.O9o76ZdvQC@kreacher>
 <5161bd95-d51e-49cc-bcbd-523fbb747e4b@redhat.com>
 <CAJZ5v0gf-oLcjT8dxnpjAyVfpUep5ST2mHDJy2dySBGCJwjMxg@mail.gmail.com>
 <b53b4fe4-e3b7-4939-a8ea-9eb55f0bece6@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <b53b4fe4-e3b7-4939-a8ea-9eb55f0bece6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/16/24 11:50 AM, Hans de Goede wrote:
> Hi,
> 
> On 5/16/24 10:37 AM, Rafael J. Wysocki wrote:
>> On Thu, May 16, 2024 at 10:35 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On 5/15/24 9:39 PM, Rafael J. Wysocki wrote:
>>>> Hi Everyone,
>>>>
>>>> This is an update of
>>>>
>>>> https://lore.kernel.org/linux-acpi/5787281.DvuYhMxLoT@kreacher/
>>>>
>>>> which was a follow up for the discussion in:
>>>>
>>>> https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com/T/#t
>>>>
>>>> Patch [1/2] has been updated to avoid possible issues related to
>>>> systems with defective platform firmware and patch [2/2] is a resend
>>>> with a couple of tags added.
>>>
>>> Thanks, the series looks good to me:
>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> for the series.
>>>
>>> I assume you are going to send this in as a fix for 6.10 ?
>>
>> Yes, I am.
>>
>>> In that case feel free to merge both patches through the
>>> linux-pm tree.
>>
>> Thank you!
> 
> Hmm, I just realized that this:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=c663b26972eae7d2a614f584c92a266fe9a2d44c
> 
> Is part of the main pdx86 pull-request for 6.10 which I'm going to
> send to Linus in the next 10 minutes or so. So that is going to
> conflict with your 2/2.
> 
> Options:
> 
> a) You only send 1/2 upstream as a fix and I'll then send a rebased
> 2/2 upstream as part of the first pdx86 pull-request.

That should be "as part of the first pdx86 fixes pull-request" (for 6.10).

> b) You merge the git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
> platform-drivers-x86-v6.10-1 tag (which is the tag for the pull-request
> I'm about to send to Linus) and rebase on top of that before sending
> a pull-request for both to Linus.
> 
> Either way works for me.

Regards,
 
Hans




