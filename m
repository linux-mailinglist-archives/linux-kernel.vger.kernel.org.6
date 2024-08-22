Return-Path: <linux-kernel+bounces-296541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C478995ABDF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3111F2397A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E1A1CD2B;
	Thu, 22 Aug 2024 03:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IBMPYR+w"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406A71BC39
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297159; cv=none; b=cOSCCAnpIVedDbn8Q8lya8nQEbBL6vBLpP9BtGlP7X0ngl6F0dxBrC8HfBtLHbkmAnA4syZK7+uCQ3aBFx7jpcIsUujiE0D86611XZvhsNKIRTVljMaRs5VpD4lmuA4uiHA0N5EpJADZKL+u2OSUf9Jyrf0ku3mgCGLEc/dwas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297159; c=relaxed/simple;
	bh=hyKDjj4CJqAx5VGdmx/yJM4qAEXZNm60VYDVRGi2I2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iby9cZd79PIOKJuIGtEtwySA0bMTZnnG3RM4IkLIqmv3XrOsldTYBRVFFWDyno6SzZqGJxTc/8qofk4W9jSb1WrWJ8Pir5HxXNQn5p5skefr8A1iWgwW3TRxq2mTNqEwDU1dsdNdsP9aVpq/kIOsJccSVy3L6/qfcaSyoPZitC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IBMPYR+w; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3dd16257b87so150755b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 20:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724297156; x=1724901956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hyKDjj4CJqAx5VGdmx/yJM4qAEXZNm60VYDVRGi2I2c=;
        b=IBMPYR+wJwzUarBLB+S2ksEPZksgHmm5GPO92pPsInWm4So2siDUYql0NsFrt0Y1X1
         jfS6GCvxEYYdd1B4xji1hvhNhWUZ+FYzEnQey5aGDZT5vTKLKqXb+ES+uMbPAeKHkUOt
         yGb3U2C4Bs8MIYBlwNxNcMe/vSlP4H47isL2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724297156; x=1724901956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyKDjj4CJqAx5VGdmx/yJM4qAEXZNm60VYDVRGi2I2c=;
        b=j/D5KcVFWtG/k7cDkOfuHxql85BO5D0lZ/JDtiyESrX6jKtqFatLBVJEFLdqEsAvdP
         0yTJZrY4FOjUm4C/JoXBGtk2Et73oaD5FMqAZHt8kjfemlz5/tvto7ayS0EoEs0umwlw
         2bjRjxUHyLecg8LugVAAgMJpCUPGSo/DYkyhesbH0odnAUn+sudAEh3Fhf9NsNMjzzYJ
         Yw9XqRi3SO0AdJVAENP1svDGh8P2xsJlT1rZE4CBtImAwDh0e0gFu6QSXdx6OYEY5LWJ
         U45EmEBwvmrgtBHSjBDq+85RGctycQUqZP522bKCl3a5FOQylza21cx5Usga9/9yLQFe
         pt1A==
X-Forwarded-Encrypted: i=1; AJvYcCXXtUaasWe51h97sRN9FxPiMra9nKXFTivtEN477a+w9N0eKUUQClvBqBPcAM3fBHKtwg+EwJndsM1j0Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMtnj80hAI5Kl8pXupwnJwsnK4RC7+TI8OYPaB6/z83C4qBRgw
	obemw9kxgIPPRrUspN4OgvFfQYnSYE30kjvtH4mc5UMkaHMVMwQEUU5oAyQcso8=
X-Google-Smtp-Source: AGHT+IEIuEGCRRmhieJjBWHd6gs4O35qd+zZB2nQ4Ts+alXoKgwtX529u4Ots4uOQLOwdY/3cR1apQ==
X-Received: by 2002:a05:6808:1910:b0:3d6:5791:a378 with SMTP id 5614622812f47-3de194fee4bmr5282599b6e.17.1724297156263;
        Wed, 21 Aug 2024 20:25:56 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm346023a12.16.2024.08.21.20.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 20:25:55 -0700 (PDT)
Message-ID: <61b180e2-6c88-4047-bad9-4d712bd5072d@linuxfoundation.org>
Date: Wed, 21 Aug 2024 21:25:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2][RFC] Add SWIG Bindings to libcpupower
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Arnaldo Melo <acme@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240724221122.54601-1-jwyatt@redhat.com>
 <1f5c24b6-f3ee-4863-8b7a-49344a550206@linuxfoundation.org>
 <Zqv9BOjxLAgyNP5B@hatbackup> <2024080405-roundish-casket-2474@gregkh>
 <ZrKOCLYvYklsPg1K@fedora.redhat.com> <ZsQ6XKQ4pRFYkGoS@rhfedora>
 <c7259d79-4e66-48c2-922c-f6ab88b3af69@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <c7259d79-4e66-48c2-922c-f6ab88b3af69@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/24 01:08, Shuah Khan wrote:
> On 8/20/24 00:40, John B. Wyatt IV wrote:
>> I wanted to follow up on this since I am close to sending out the v2 of
>> this patchset.
>>

Here is more complete response after my quick response.

>> 3 points I wanted to raise:
>>
>> 1) Does everyone understand, is okay with the SWIG license, and wants to
>> proceed with me sending in a more complete version of this as a candidate for
>> upstreaming?
>>

Yes - send patch series without RFC tag.

>> 2) About maintainership: if I am to be the maintainer of this, how would
>> myself and John Kacur be listed? As a CPU POWER MONITORING SUBSYSTEM
>> maintainer, a separate category below it called CPU POWER MONITORING SUBSYSTEM
>> PYTHON BINDINGS maintainer, or is not needed to be listed at this time?
>>

Let's not add a new category at this time. You can add yourself and John Kacur
be Reviewers under CPU POWER MONITORING SUBSYSTEM for now. We can revisit as
we go forward.

>> A quick search for bindings shows what I believe to be all of them for device
>> tree. This may establish a new precedent.
>>

I don't fully understand the above. Will this patch series include device tree
changes? I didn't get that from the RFC.

>> If I was to be added, I assume it would be a separate commit in the v2
>> submission?
>>
>> 3) I had to comment out powercap_set_enabled
>>
>> SWIG reported this symbol not being found despite being in powercap.h. I did a
>> quick search and was not able to find it's implementation in powercap.c. The
>> get equivalent powercap_get_enabled is in powercap.c. Wanted to check on this
>> just in case it is a bug or part of future functionality. I am assuming the
>> latter; I would send it v2 with that declaration commented out with a note
>> explaining it for users if there is no objection.

Good find. It is missing functionality. For now you can define it in powercap.c to
simply return 0 with a TODO

thanks,
-- Shuah

