Return-Path: <linux-kernel+bounces-446477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D5F9F24CB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 17:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC935164CD2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90381925AE;
	Sun, 15 Dec 2024 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pnr2ixp1"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC218E76B;
	Sun, 15 Dec 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734280513; cv=none; b=N71UmUtRU5UgTERpJPONkf+iknhCFLYAJLK83yS8SNcSs+aGXvNWCqx1c9MCEvbXVQs61e7lWpX0nRT1zetESFHmmsRaaiitG0vAoe78fAGu2QI7y1VvihPp3796CxhcNhocbXZc997tLUxWw7VMqajuE4jUhDNgPgVFZ9NTDpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734280513; c=relaxed/simple;
	bh=2WWMG3hCqRj2epNPb3LmM6UwhjcyP8o4SHRgqX1Ghfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIeGVMaT/XfPS5B08lgjpiCCPnV9Cf42l/fvDgRMiqRp2pyCvz8l4IRlnrWZemmCpyw5CbppqPRIIFo+bQGy76ym/lV8D6gliVqAxDQi8PFk3JFCrowATWgcbZYSHegrjTPMaMBqZOfm6GOV10r/TculJFWVE9vv0cri/ymMtVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pnr2ixp1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725ed193c9eso2636680b3a.1;
        Sun, 15 Dec 2024 08:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734280511; x=1734885311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=f7FYHvjv2Ayj1wLQGPwvKTpgF4xjZvHcE8k+JPVmzJw=;
        b=Pnr2ixp12trLfc9YU/Tgp0dquf0SC8icdHq+q/D4sf3VZcA/lknzWMeURMWc5msGgq
         7eRZtTF/WG5UN8VLh+hYVCF93qa+EZ/dLmfARwRRbcaoDDD7NxohP0JkfOK65bFuMbyD
         0oUFEX2qnkjIhuTrJOvhnGNwwqFoPHYXZsW76vGWrIugTvj8nbVHoHqQ+IpryCw8OrX3
         XuZmAydY39Xr92symnZauFqd3byownNY7vpKjnl7LBYRY5k2ed7uWBzBtjAGRuFGFooj
         XYVwaPfCwb3Ps1BQoVZinWkqS4hjY7PE/D/Gu5B/t6fJpjdsHIaDNnLhcx/23cql5Yf3
         RGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734280511; x=1734885311;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7FYHvjv2Ayj1wLQGPwvKTpgF4xjZvHcE8k+JPVmzJw=;
        b=gkgT8l7JNleyMyzJUQG3nJZ1G9T2gI5GAh9b1Up+AHzQ0kXlgAqQ06J3lu+5hu3i6y
         BiSlp1JFYzb7wob7nsltlR2kCh3iIlcLz9/8qUet/+fZfiBmp+yCiR3z5lbnjI8QZueL
         VLvQo9QI+NyrfzgWq1YojDPsR0yX+PX1pHAZeznIpxoUFrol6Gogn3u+JX8xEljB7uDH
         AY05Sz29Ti+1ch1hP0yYpSVCDhGNnjnVyIlmc8o4pjaehLU5TBkeYu9DkMlB23XcBtOC
         3/s+VCYO/ZpQUnPx0wT5lU1awzCKTv0QG1FYtmat6Tm8fVSrtBw2vJ1pPgYSWBlg2I3V
         Naqw==
X-Forwarded-Encrypted: i=1; AJvYcCUzHFcPR03taiXrMb21synFGrGhFhnarmMKb1EL1elETtzSqYT9lV1Za2/EQWo6BhKP+2VWTaAq7ZVI8EQ=@vger.kernel.org, AJvYcCVhZMBJDX+5ZqcTVtEEPutef9qnxxykWDu342Ky7zi9ICUq8CoemES0I1gkInT5iKaZpNwDiMClUBIwDoBBTO7sbR9lLA==@vger.kernel.org, AJvYcCXbcT3+AqHmUZ5YIZphE66sjHLF1Q2U6xPqBvrYHZ8RG4ZFB8WF1eLP+SyMWYLTXwrzgk83JQKhmmKzftLV@vger.kernel.org, AJvYcCXjqStJYHC4OLmQmImjH9T+ZgsjK/PKiEtzc/O6l+9u9PORsl+sNZ5jkDRN/c0DG1JZ2jXUQvRuuyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhSxWcCRCd/1bEHGvbPea9+M7MkzfnoaVm52Sl+HRsFSOTxE5Q
	ruW5iH+FIHVylP9YUEwpQ4GWo9MU3n01OVhiznEvbpendxtX8VYx
X-Gm-Gg: ASbGnctl4X1eGbTAWfZsNj7PxtaULjt7ieytVjRYnMH2eUUviVUj3dPvzsdHkr77lqm
	hvCVEvBub4hZtK182YqOs/moOmclYVhKzMdt4Fjqk4V3e1JX9x5KHo8dAmYYVHDFfTRdlwByh6Q
	sK6ddQwGfbXh77kqBlNXd3nR67Jne3sO0iWbY1bRAtYvSScACV7bSxkR6XgZ6oJj82X8w9uNmqN
	MCmheTy/Z/U6cHJSKxQpYDm6gNVMBxNKpXcfKnsk1139uAP2y+5wTyH3+GwkSAAkQvobt9+CCsJ
	eEOlWA93/RRy0ANYiHXnYbmBlJOi9g==
X-Google-Smtp-Source: AGHT+IEDhUogukUEOopKc40uTMG7A9qSrqFBr45CzfNwYoQHgzirMBL+UeqOhffkgJu3U87atco0fg==
X-Received: by 2002:a62:e30d:0:b0:729:1b8f:9645 with SMTP id d2e1a72fcca58-7291b8f9a5bmr6615925b3a.24.1734280510957;
        Sun, 15 Dec 2024 08:35:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bcfecbsm3098854b3a.195.2024.12.15.08.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 08:35:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <90e6a8f6-666b-45cc-ae66-4ccbee0ba08e@roeck-us.net>
Date: Sun, 15 Dec 2024 08:35:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: samsung-galaxybook: Add samsung-galaxybook
 driver
To: Joshua Grisham <josh@joshuagrisham.com>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
 platform-driver-x86@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209163720.17597-1-josh@joshuagrisham.com>
 <797b248c-7542-43fd-8e44-f2c7d650ccff@infradead.org>
 <CAMF+Keb0cXc8t8J_T39WJUKydpD2EME92ZWT7SFr_taiCXfvww@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMF+Keb0cXc8t8J_T39WJUKydpD2EME92ZWT7SFr_taiCXfvww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/15/24 08:09, Joshua Grisham wrote:
> Den mån 9 dec. 2024 kl 18:04 skrev Randy Dunlap <rdunlap@infradead.org>:
>>
>> Also needs <linux/sysfs.h>.
>> Maybe <linux/printk.h>.
>> Maybe <linux/err.h>.
>>
>> --
>> ~Randy
>>
> 
> Also done in v2 of the patch, thanks Randy! (though no printk.h
> anymore as I removed all pr_* functions.. maybe I should explicitly
> add <linux/dev_printk.h> though? or is it good enough to get it via
> platform_device.h <= device.h <= dev_printk.h  ?)
> 
> Joshua
> 

Your v2 is highly unusual. The patch description is the change log,
and the patch itself seems to be a diff against v1. Did someone ask you
to do that ? Just wondering.

Guenter


