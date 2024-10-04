Return-Path: <linux-kernel+bounces-351443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F4A991145
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812A11F23C54
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D935145B26;
	Fri,  4 Oct 2024 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+Tsf7Uk"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCF683CC7;
	Fri,  4 Oct 2024 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728076980; cv=none; b=u3bKv1pWlLCbRRQhVwNO2ahfWOrQf9klZNKRomRvfU/2+gqDRbfcIo10zZXDkvDr79BsOTjZEkU27in3k1gbhSGLif1t4XGCSozu7xkrlwLbqVm7NG0lGok0PkwTJszl3mYKnayqaifKIbyHVB9eLfnxvvzQKrTuvpPqOAHoGaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728076980; c=relaxed/simple;
	bh=/Bwgj2NiJEKINhHaCWqUgXYElRIXX06JKUWfNfW0aKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnQtUqJXBhrsaecSR79HZxw6U0aNnYMq6Hv0tHUzieLPr9LPdihRBaxymtwhGWuFZaq6cWJ+I3FLfj5YGMahFN9ySSbAOMyztez3qef8UPbRUVOxGRVmpPdhPZzuFxe/LidKhlRAqXcMzcBeUN/IMQ1YH7ZrqJUeeMPqYZyppwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+Tsf7Uk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71b0722f221so2027959b3a.3;
        Fri, 04 Oct 2024 14:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728076978; x=1728681778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zcyPwLQaZrfdH9oZC3GWPqmUbPa2QOQqEo2igl7O4f8=;
        b=m+Tsf7Uk1SKOUsSKYcJ2fUjdMooo97KRgo50Ru+woVELdb1IW2AHrv6SR4AmI80/Gs
         N0VIMZOFiSJZQGPWDUHTkbp23d/GcFb2AdJH9kbud95bv/iOAjp78JOD4pETqevTkEv6
         OmxI3kFrAKjJLO6hxv343Q9WMD+i9sAE9IiP2x8fwKE3DsxpQOlrBcl4BbLXeVgXBJNQ
         dJNuDF5/Gm9qMae6ViWrnsPVvtqbg5pe7N2m4e6JtvoVHLUL6tHqP7C3czhQ6kcP8mXH
         6T9n8zfG7cfEq0wkVvw0nm7Q1wnYe/SrTUiYcwwHjNsD93gOR4e5KgIf/kdPrxODfTXH
         lPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728076978; x=1728681778;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcyPwLQaZrfdH9oZC3GWPqmUbPa2QOQqEo2igl7O4f8=;
        b=UEeK2JL616+teFISusTJK1NiIJdrxO/FIR0bnwrZ487jtB36BdN47CL/OfqlIIV9Wr
         Cq7U7wfxUCVcHcLGW9Bz2PqyS0GMDfm5wN+bOUK2XpHas6U/BwKHGQpswpOVmcji5pJk
         bhuOYI287xy84quo7t4UZakkOojkTQFmjA4fuIuWPTNKX5skM+v1tSqtdNjZMqoECwO+
         p7iJSN6eY0B/jImYxBxYhU0zQSI3UecWbfr6lOWXBC8ubkC39cbe6pMAxBdBIbRtVIFz
         9lIuu9Z7LNeffV/i5WEW87QEAMsKV5oQgqUicR7xMsRB69lP+QFGorVGKWR38BXjYfYt
         R+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA4hi0mU3tzQg/hZ47wqvUPjZTZ9MEjgaLvpZxVwLMqZ+W0OsGVCkXAQfreX1I9aL5bHKosJrSMMUrjg==@vger.kernel.org, AJvYcCVPVGzCmRl7CvWaTjpNfQyfAFPZVI4/2OwJ6m1bR8xdFpuA3+/3j+Mepc/kiRMeFVHmh4jCaB6/3U5pmGOv@vger.kernel.org
X-Gm-Message-State: AOJu0YxYoHnRsaNglSBR0fOGKO1uJ7/VdMdTNRpLeSZf+OYct59GSYfu
	wFGzUu5Bh3uITTEHK8BpSnUhjFClFloA/T1pdmP3dXJWJWJ3D2eYvPa8Gw==
X-Google-Smtp-Source: AGHT+IGzNJRbeA0RJAZH0p6NXzLydsKCw+oV8UXo+pd20sR6ZvR1sVA1jeM1y4U42Cdl+Nj4UiVNlw==
X-Received: by 2002:a05:6a20:c909:b0:1d5:10d7:2020 with SMTP id adf61e73a8af0-1d6dfae315dmr4801378637.41.1728076978314;
        Fri, 04 Oct 2024 14:22:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4cdfdsm432789a12.87.2024.10.04.14.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 14:22:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d220f9d1-54df-4d4e-b90f-69bc5de5a22f@roeck-us.net>
Date: Fri, 4 Oct 2024 14:22:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hwmon: pmbus: Question about header files
To: Vasileios Amoiridis <vassilisamir@gmail.com>, jdelvare@suse.com
Cc: vasileios.amoiridis@cern.ch, federico.vaga@cern.ch,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241003223110.17166-1-vassilisamir@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241003223110.17166-1-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 15:31, Vasileios Amoiridis wrote:
> Hello hwmon and PMBUS community,
> 
> I am currently studying how the PMBUS subsystem works because I am trying to
> write a driver for a PSU and submit for review. I noticed that the subsystem is
> quite intelligent and it manages to do most of the stuff in the pmbus_core.c
> leaving a minimum amount of work to be done in the actual device driver!!
> 
> I have a question though, regarding the header files <include/linux/pmbus.h> and
> <drivers/hwmon/pmbus/pmbus.h>. With my limited experience in kernel development,
> I would expect that the drivers/hwmon/pmbus/pmbus.h file would include stuff
> that are used only by the pmbus_core.c/pmbus.c while anything that could be
> potentially used from the device drivers would go to the include/linux/pmbus.h.
> 
> Is my reasoning wrong? What was the reasoning behind the split between those 2
> files?
> 

Mostly historic. The original idea was to keep platform data in include/linux,
but at this point that has pretty much no value since all its users are (and
should be) in drivers/hwmon/pmbus/. Not worth doing anything about.

Guenter


