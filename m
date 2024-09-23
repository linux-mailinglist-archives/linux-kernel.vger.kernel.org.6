Return-Path: <linux-kernel+bounces-336084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFBF97EEEA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F10282C40
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FBB19F107;
	Mon, 23 Sep 2024 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pz3WMEAN"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA819E986
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107778; cv=none; b=gX7oN8G/78E+cR5OrEQVNgNha8P74vYqjSd6gAJwO2j3G1XgJUAhOM6izkOaUH+kat/WwO+v0mDDNjX11547j4H499bunIGNIRjuCw70GJC2kUoHk/Lz3MzEvZNV1izg6b6nR4mQWpL+l+ZV5xdZbQtg9pGctJ5PAPpaUzxeQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107778; c=relaxed/simple;
	bh=ujielfHNXtojq291RgLrx2nGziORGAFNnHn2GrlXqUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q24lhChzGoXhUwKSqsFIY/kCFpCx+gIGQBqMvHc+E46oJ8virTch7D6i7RQIZyzYahH0MIP/fZ+eiL3DDI8cLbM1oxcLrNCim+tbNRrJtkRZ9atedFMpF+2gmGBjx8lPGG+iLvcR1sP/QhFf67MVGs1bLFj9XWjyfsp5XZyUYrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pz3WMEAN; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82cdc21b5d8so239643839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727107776; x=1727712576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1rpHAARkKJbXBxmINPTdHx4AuIw+fSypqo1QwwIV5w=;
        b=Pz3WMEANeYroqHC5kjqHTP2Urlg5asCcLnHkjo6rCrIXU/R2wKn26iNT4zkyYxTY8O
         NLub+7BQqioBVIDoZ1P56juQFTKNgWBX25RxbOP7eA1AVjGBXgOhep8wjVTWxu/ysHGH
         WShaMgHRH1INSI3imk5tGlOH0b/kXJxe4jfrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727107776; x=1727712576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1rpHAARkKJbXBxmINPTdHx4AuIw+fSypqo1QwwIV5w=;
        b=IJd4DbrWT0GfZwMkKosiNTjVJRhOLh8Q9ZMmB3mj3n6MS7ool0pJgXl1xgq55JUhu1
         Jm7mFZmcChSqsVTI0pCHosnEe3Ka3ruw7lBtlYJfeJWfpGanAjjTmGatAwm8tULSd9Zd
         qZDmcNHsOTixG+aWf0OzBn6CaUHVGsPSyrhUZ0EOoinstdmczS1bLlbxeazejP/uVVW6
         yQa5MHNfY1wuwhHm3ZFev8AnTX4rI7aGbPyCBKVdgK38qdMaJsneGOF4V9ng8Aq51YFh
         +4iqbSPoSV001k/1nx/0njbtw0o25nBSH1MYV/hXFoIA7SkCe5NtnLEAPV0G7hQdeHRb
         cgLg==
X-Forwarded-Encrypted: i=1; AJvYcCVVFYTariPvFBNeRtjlRU6ibxhpHDLpHOcVZar1elGHrvwZgoayTShDoBA4ycX9PtwfZ77aksvc2qlBYgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVNxTAMeuDaGx+g8E82LBYWSsXxsLH6//WIbfByGua+CKyKGps
	hNIzrdJorom1Ffwi9Wwd6BFHIYfUc/Wd6SSzMokettxvHnkYQPCv80y/MxjglHU=
X-Google-Smtp-Source: AGHT+IEQYJiN/ium1DVlmMEICT+uU3leLtICjhSviWJ7okFIi4gNJFpwbOVGUpmyI2WBgxrDA5HtZQ==
X-Received: by 2002:a05:6602:13c9:b0:82a:539b:9838 with SMTP id ca18e2360f4ac-8320b286da1mr1030095839f.5.1727107775908;
        Mon, 23 Sep 2024 09:09:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed34fd2sm5191057173.125.2024.09.23.09.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:09:35 -0700 (PDT)
Message-ID: <4a919535-dc5e-4b87-aa58-5e214553fd24@linuxfoundation.org>
Date: Mon, 23 Sep 2024 10:09:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] pm:cpupower: Add SWIG bindings files for
 libcpupower
To: "John B. Wyatt IV" <jwyatt@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Arnaldo Melo <acme@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "John B. Wyatt IV" <sageofredondo@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240905021916.15938-1-jwyatt@redhat.com>
 <20240905021916.15938-3-jwyatt@redhat.com>
 <0ff4937d-0e51-4d67-9b8a-d2bf1bebe1fb@roeck-us.net>
 <CAHk-=wjVpftmPF3SopywFgQ+uzgdScTPWTxmq7HwinVqwbue3w@mail.gmail.com>
 <ZvFtHM5465aOYX24@rhfedora>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZvFtHM5465aOYX24@rhfedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 07:29, John B. Wyatt IV wrote:
> On Sun, Sep 22, 2024 at 08:39:28AM -0700, Linus Torvalds wrote:
>> On Sat, 21 Sept 2024 at 14:23, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On Wed, Sep 04, 2024 at 10:19:09PM -0400, John B. Wyatt IV wrote:
>>>>
>>>>   .../bindings/python/raw_pylibcpupower.i       | 247 ++++++++++++++++++
>>>
>>> This file is deleted when running "make mrproper".
>>
>> Yes, please don't create files called '*.i", "*.s" or "*.o".  We
>> assume they are generated files (the result of the preprocessor, the
>> compiler, and the assembler respectively).
>>
>> And yeah, obviously "*.i" and "*.s" and not _usually_ seen, because
>> they are only steps on the way to "*.o", so maybe they aren't _quite_
>> as obvious as some "*.o" file would be, but they are very much
>> standard naming, and we have build rules for them (ie "make
>> kernel/exit.i" will create the pre-processed result of exit.c).
>>
> 
> My apologies. This was reported and fixed with this patch by renaming
> the file to '.swg'. '.swg' is the second filename extension used by
> SWIG.
> 
> https://lore.kernel.org/linux-pm/20240913201705.7764-1-minhuadotchen@gmail.com/
> 

It was quickly found and fixed. I will send this to Rafael to get this into rc1.

thanks,
-- Shuah

