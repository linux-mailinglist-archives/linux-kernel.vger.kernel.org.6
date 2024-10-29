Return-Path: <linux-kernel+bounces-387369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11C39B500A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258BFB21153
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5CC1D8E0D;
	Tue, 29 Oct 2024 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhCRkzXv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6E819DF95
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221425; cv=none; b=ris2xlhGwzaJgurbWcnlEwHdHrjlirtuF+Dv0WtXMlWunwvS6vlWQAfITPJSQs4zfUvmxWA1jQSkVowdTi4VfW03wVAMW3kYr31U+N9s0r/OFhon2EYdvMQevmV+o3pSqoQpFuSqwvBy+dCO8jYD0MbG+G+OxARScTCgGCasPg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221425; c=relaxed/simple;
	bh=cndgThwCRKYDmkJ4IOysDIvGRup4a8wjPzQR9TPE9IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ugj9oW66ow80Q6iPJWFBiDMNQD914oCT/QkAYq/6w5knYk3Lfo9yCVyyqspt7men2ZMgWRzVK96NI54bgt+T36FAvxhK5Cn9Q9QBeq2nyo1Xihf72Bjhr1Yd8Bjpj+ndjNDUIM2holRxOTnsVtYewd5BWelYL2OqfeXEfJgd4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhCRkzXv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730221422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgDDqHgwK2vnx9vpFandCAj8GwkYbm2fjxiXRjakfu0=;
	b=RhCRkzXv+gi+by0bVyhNafGKI2HrecRoWFi+y0dU5J+RdUwmXhina/VJRZ21Vj7uucbNFo
	nJDGWEz8y5A4TXiifvlwETBNvtM3/rMo4sAFycCUS8dHEPyzF85SyWMNvncjfEQ5fxaCmY
	9gLYIbco4XgP7iE8FW2ToFtvbOHVG3w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-o03g78OaP_edareGzHKA5A-1; Tue, 29 Oct 2024 13:03:41 -0400
X-MC-Unique: o03g78OaP_edareGzHKA5A-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbebfc1725so94943486d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730221421; x=1730826221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgDDqHgwK2vnx9vpFandCAj8GwkYbm2fjxiXRjakfu0=;
        b=a1kdu8Llezbap/weqwOv0wt60yRCuBJQsz4345kk2RagCKQFJI+JHpx7P/qYYbMoWD
         KCgOP9SrbG2Tdb2pHPo0oGARNb8IF9bfn21GQ8DlCe+8N3gfEQ7LnduXm3hqkBfb9JyY
         Brz7UQJeCq7X9rulDidkGBPfka6bok9WbwotvzWujph0lUr8KMl0gl+GQ4uSP7nLNrRR
         /0ahfhizh86cd+KgSoLn1yT1ViIHFD1fC91VElVLUhm/tPMST4jKSqL6SewDrBqiMq5o
         O5DgN6zCLsV9YQP9xSkq+p/2cN1nowtKSEBLwGVQonyy1BGvywc60I1/dm/it9mcO1mj
         CU5w==
X-Forwarded-Encrypted: i=1; AJvYcCX6+HUJJLe4IG23s6tAOfV9hKBB6Y7x9Oc3ay+HdKZubI5Q9v8RNXmRSXBNe8Te8L/oxLEZm8E22CrEX1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1I5ZAQGaiw8p1Bu8noHlQ27b/SmeJZkNQ2sA30nyLUnk7pHrT
	5bje1mZpeCirN7IpBqUuAnVZrqGaw3MS5aXgfe22aU1J0sUiP0P1uZEljogufCPCL3pUpWpB5MV
	GYNsqneabBIEqfUqpcbN34F1WoyDUNTl5Ic8qic4xgQw4dsEybDDtg/NOtvIklw==
X-Received: by 2002:a05:622a:199c:b0:460:9ec3:1b80 with SMTP id d75a77b69052e-4613c0305a2mr204013661cf.27.1730221419178;
        Tue, 29 Oct 2024 10:03:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFnEdmHELhucGC4RMoKvtlOdJj1FTZxMhoHHfkOL0T1MnusgnPAKgrKNr4PWgjCRPPI7Jvww==
X-Received: by 2002:a05:622a:199c:b0:460:9ec3:1b80 with SMTP id d75a77b69052e-4613c0305a2mr204012071cf.27.1730221417287;
        Tue, 29 Oct 2024 10:03:37 -0700 (PDT)
Received: from [192.168.1.165] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613213a2besm45942891cf.29.2024.10.29.10.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 10:03:37 -0700 (PDT)
Message-ID: <1c0beb9b-6b90-4c92-a4f3-f228dc0aa527@redhat.com>
Date: Tue, 29 Oct 2024 13:03:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/md/dm-vdo/data-vio.c:976 vdo_launch_bio() warn:
 inconsistent returns '&pool->lock'.
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Philip Li <philip.li@intel.com>
Cc: oe-kbuild@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <717e8949-55c4-4461-8951-3e582e9b77ef@stanley.mountain>
 <f074f848-5a26-473b-ae98-1932e9a8cbd1@redhat.com>
 <ZyBQa45RTWXiXJke@rli9-mobl> <ZyCLo51ZyjxX7eQK@rli9-mobl>
 <13937d22-46ac-480a-8956-f89a0fd295ac@stanley.mountain>
 <68866f17-f327-4df8-ae17-dfcc50362d4a@stanley.mountain>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <68866f17-f327-4df8-ae17-dfcc50362d4a@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Okay. Just to restate, what I took away from this thread is
1) The current code provokes a warning.
2) When bisecting, the bot found a (different) warning from the patch 
introducing this code, and so the mail points out that warning instead 
of the warning in newer code.
3) The warning is showing up now because new checking allows the bot to 
notice problems it didn't notice before.

The commit I cited fixed warning from sparse, but I don't think we 
looked at smatch. This particular code does not have a locking problem, 
but the way it's spelled makes it difficult for static tools to 
understand that there is not a problem. I'll take a look and see if 
there's anything further I can do address the actual current warning.

Thanks for your explanation. I think I have a much better understanding 
of what this bot it doing now, I'll keep it in mind when we get warning 
in the future.

Matt

On 10/29/24 4:19 AM, Dan Carpenter wrote:
> On Tue, Oct 29, 2024 at 11:07:07AM +0300, Dan Carpenter wrote:
>> 3) The kbuild bot detected the bug, but unfortunately the cross function DB
>>     doesn't scale well enough for the kbuild bot to use so it didn't detect the
>>     fix.
> 
> Aw crud.  It does still print a warning on linux-next actually.
> Smatch says that we lock "&pool->lock" and unlocked
> "&pool->discard_limiter->pool->lock".
> 
> Anyway.  Points 1 and 4 that we were running new checks on old code and that
> the code in the email did have a bug are correct.
> 
> regards,
> dan carpenter
> 


