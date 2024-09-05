Return-Path: <linux-kernel+bounces-316635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8EB96D237
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ECD91C21555
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C27D194AEC;
	Thu,  5 Sep 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ky+j55qz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FE01946AA
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525210; cv=none; b=dqWmSQEcMHjwFDYftGOSfdlCbhYuIottz/El5/sqcO7gRTls5ZJVNX+NirzgEp9Qy1rsb0bJGxLVaZbq1PObfi9sVFn8cQnqsyp8ktVuwnUoMofc6f2lvddulN4XZpvV9J9lWJOpGV6dAs1wnufkUrrvFLAN/hHzLK8ocOuClo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525210; c=relaxed/simple;
	bh=imv8U08gHO+jhkWfKoa3G4FjFUXru6I5ky+OmAJv/sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QU9gfEHoUEWbVm6KRU4sA8eod4pmOJZ78fEzsSAfABVfwA6nw9d9tCillNNtIBCuwSGA+3jN2JHxJmD5Fu61tXoRieeLyXoOjzrdvKZhSN6JMnaudsKMCNlffy3rUrJeS8zZ3VAHTW8iGWYAypev/5u8GMY4npFAwrJ5OSkllvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ky+j55qz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725525207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDEdIC/fJh3s7WsAQenvIjI2Fjpnx/yCMstntJbdT3w=;
	b=Ky+j55qzCHSx/jHcbXBjo4QTx3rbyPHS8/8/HNrjPKjqH2Ssjeak3sFJCpcaNPSccSfZGz
	UR31J+ia0qsxXYRL6BHANdxNbsmiq+dVAQcVbLgsQmpJFXgoohVcZAT/lX+3RTykICle7u
	wQ2989CzvlXUWHxGz6K/rZfkwLZBxtA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-wtxLe6WdPcqlWlG8IRNZAQ-1; Thu, 05 Sep 2024 04:33:25 -0400
X-MC-Unique: wtxLe6WdPcqlWlG8IRNZAQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a868c4d16a6so53006566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725525204; x=1726130004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDEdIC/fJh3s7WsAQenvIjI2Fjpnx/yCMstntJbdT3w=;
        b=SnukiQ4wCizYiPUPZT1T5qekMLcxUCuJZLeAbG8B+g7rwg9wnj1uFccEJpu9/TtM+N
         OnOdTH6BW/UfTll3DUIIFnv3r4ue4JRxYs6Z25Y7ZpWlWqTCItz+6k6a0M8S4MQ5QqSA
         m5fn1AkcGAfv+hPUpPZq/MAO7jPIbuqKSkE7f0GQxwsPDAKS4Np29H/o5Tn3cL0e5BD8
         GK3Okewaz0Xb1Cu6K5P84Fph5jvKuR7dvS4NZ9HVWV4obZFAscgeazPNNmX0vuSjWE59
         X6SiecQMOUb4//wQhBrAAemQrTnmBlbXweKwbYLrH0XOk0NMYOQBa8XymAE+XAWZI4Gi
         01WA==
X-Forwarded-Encrypted: i=1; AJvYcCWHaVj8MIOjDsfn6zfzHFouQuksIL4IxckoBLE/v0eYodaMozIkrdTV8HUTIJcMQZuTC1U7xYCIA8Sko5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZE8CTGGEnHsSeSxshIfoRAH5D2Qie5lz28cT8wWTFNoTyCRfs
	OVbxmMEpNzYLbw98yytDU+wE26kD8ob6B0YhdXP18LpJQFWF+JI4+rkikKTGbnMlww3sJNgZipt
	IjAZVwCiCdLN3EwX6RD8wuAuId3I6zWZ+uEsruytaX/lO35C94WcYCU02yCcL6w==
X-Received: by 2002:a17:906:6189:b0:a8a:7a3d:64b2 with SMTP id a640c23a62f3a-a8a7a3d6573mr18501966b.17.1725525204596;
        Thu, 05 Sep 2024 01:33:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENHEGjwK07jNX9TXIrPYe4KiFmSpnjTi1k+HyH4mHnyAw95VjI3ZYYdR8iiWNH6/nno2rgGQ==
X-Received: by 2002:a17:906:6189:b0:a8a:7a3d:64b2 with SMTP id a640c23a62f3a-a8a7a3d6573mr18500066b.17.1725525204060;
        Thu, 05 Sep 2024 01:33:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d527sm102196466b.135.2024.09.05.01.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 01:33:23 -0700 (PDT)
Message-ID: <8d35db80-5bf3-40ca-b041-8a94e76739c7@redhat.com>
Date: Thu, 5 Sep 2024 10:33:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the
 scope_guard() clear of its scope
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Gergo Koteles <soyer@irl.hu>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ike Panhc <ike.pan@canonical.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, kernel test robot <lkp@intel.com>
References: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
 <8a106cfe-f7cd-4660-983a-feba627cdcab@redhat.com>
 <ZtjAmavK5tr4mvka@surfacebook.localdomain>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZtjAmavK5tr4mvka@surfacebook.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

On 9/4/24 10:18 PM, Andy Shevchenko wrote:
> Wed, Sep 04, 2024 at 08:14:53PM +0200, Hans de Goede kirjoitti:
>> Hi,
>>
>> On 8/29/24 6:50 PM, Andy Shevchenko wrote:
>>> First of all, it's a bit counterintuitive to have something like
>>>
>>> 	int err;
>>> 	...
>>> 	scoped_guard(...)
>>> 		err = foo(...);
>>> 	if (err)
>>> 		return err;
>>>
>>> Second, with a particular kernel configuration and compiler version in
>>> one of such cases the objtool is not happy:
>>>
>>>   ideapad-laptop.o: warning: objtool: .text.fan_mode_show: unexpected end of section
>>>
>>> I'm not an expert on all this, but the theory is that compiler and
>>> linker in this case can't understand that 'result' variable will be
>>> always initialized as long as no error has been returned. Assigning
>>> 'result' to a dummy value helps with this. Note, that fixing the
>>> scoped_guard() scope (as per above) does not make issue gone.
>>>
>>> That said, assign dummy value and make the scope_guard() clear of its scope.
>>> For the sake of consistency do it in the entire file.
>>>
>>> Fixes: 7cc06e729460 ("platform/x86: ideapad-laptop: add a mutex to synchronize VPC commands")
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202408290219.BrPO8twi-lkp@intel.com/
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
>> Thank you for your patch, I've applied this patch to my review-hans 
>> branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Have you had a chance to go through the discussion?

Yes I did read the entire discussion.

> TL;DR: please defer this. There is still no clear understanding of the root
> cause and the culprit.

My gist from the discussion was that this was good to have regardless of
the root cause.

IMHO the old construction where the scoped-guard only guards the function-call
and not the "if (ret)" on the return value of the guarded call was quite ugly /
convoluted / hard to read and this patch is an improvement regardless.

Regards,

Hans




