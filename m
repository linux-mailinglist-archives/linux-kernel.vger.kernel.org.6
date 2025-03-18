Return-Path: <linux-kernel+bounces-566180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75681A6745A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CED17BD5A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138C720C48D;
	Tue, 18 Mar 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FspfQtNy"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF73F9D5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302423; cv=none; b=A15sKJyJehbSmClMa7MYiQsnnlTK6kM0fWfbCrUMVrlQUKRzp4BAQHI335+Ic6dyFW4vCZth8yr1zbV9T0S6FMfr0f7OSs6aGThZiBBwVHNmZKx+0gXEfXi6zjiyr6tj3VSOW2WALDf2BAdlahtucg0SDWqbQAzuCEuFBhRXTG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302423; c=relaxed/simple;
	bh=Lu1DvnGNwVfIe8fl/pwODSF/9bUtOfACnC/DXL4nJmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGA9LtMCwrhHPZjoAWFM8mN+uhMG2lZ9ZYGc5s5d8qj26mqyAgd5+snv2Baw/wKPSDKHnEQQEAmwsS8IROsFERZRXjCKXK8B7x5wdf7tIvpyMubRNRkMDICaNfUjwMpxnEGxwDydpIAllT6WK6fMUBitioDgqEfq9bW3h+n8pmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FspfQtNy; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso1143929a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742302416; x=1742907216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhzANKisZhHd2hAcWJRLrRLq1GDpqDcD9VnDP57M2gs=;
        b=FspfQtNyQ7jORXmRHB92pigd86LuKSJBAee28/BkzEoHudIbAYEgOy8bY//40LLJi8
         +JpAMD8H4BlamswC1KDHeNbrlmjUNaBfhWCj77UNJuEeZLmF8bqqyyBRy3OvWMS4aw4G
         vYZGL9HYzbsZIywOQyhP5ih8i9MdmM14WAqiJS0d60u+/0in1wzlDaMDl0AYUGiRfdtV
         S2bdB5Rnrbg/WR0cSZRKthOSdt1mmXOCRba0ybHj2UKm9ErKmfqhT9khXWCRISnvXa5J
         Dxik+v4TQ9pPLPJpJuV8vilu3TME2n+BqBgLvZHPmO44ThI9cdK3yr52Fho1+cuMQg3I
         oV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742302416; x=1742907216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhzANKisZhHd2hAcWJRLrRLq1GDpqDcD9VnDP57M2gs=;
        b=EAL3lcmXGbOBdMoI/RjvjU6lT2dRGYRto7aYAGK9t/lG3QYHLMs9uCEpD7vhDZ45in
         a9BJBdb/Vq4rlgZtUEJXMG6CwVOrD8xNdT87nKFHX6sXbR+VurQV2zxkF/Gp7IRRb6vN
         dlEH0rb46ljX2ZUGRVEz9P0yxc69il2yWvjeYMg+maY5xPss4BIGCeALSw0RYa9Pfels
         uvZNztfBVMdorqmaDGcyfjibR4MafuTQMf0D6rTk/PPnr22b+rPjcUYQiZKmeJG7IAIu
         ECNhvtVOIATcPdpLZaKUuyu/GddF7ycFC0ewMPIWWDqaDlfTSgU8aO5e53Plqhct0FLu
         Mjsg==
X-Forwarded-Encrypted: i=1; AJvYcCVQyG5IsGk0s0TJuWMDbzOlTkc87iLN+XcVXg2f4GI+mcb/nOifuLsoersyIx7MnoomFL4uiv/hERFkuqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCH51kpYh9oTp7DyLc3l8x2d1A2+lmQ/vtcwx5uZ3WmMvBBOg
	vLb/WoNOJWRPVQ1R8jR5Gkdv1rltlUb/i+OlDsZuAZMP+xtcxPXpILlB5QK5KyY=
X-Gm-Gg: ASbGncvwxAcfArTdVoDJPvqDmgKpKc61ZX8mE6JkYpIypF9lx/xdAt9kfZI7EWkLZah
	2BjHFORvnpChqOu5x/U+SS+WPggjL8q2hKxZ75QIxqoljL2pSE5DmE6640Aka5cT2TjXgZH6Xm3
	Eb1nVQcaumyv4UtHTAaUR+B90ZOcsHTXMzL6SZohLC8jLvvwKZKBXkOLn+exEHylzkCoCHbo30A
	ZrQpXbK4Deo0wXeyw/37+AJyHUoG6tmz/YzwGgoxRB38p3enZesF8olZUOuZxrreXqDCJbG8wU5
	9wZ/OlHDgm7Jht9wgL0q6HY9fVfdwoiCbdIsoU8UoH2VhTGd41RIpfu8CNrq5XP9c0RkyHMEpWZ
	6aa//Wvo=
X-Google-Smtp-Source: AGHT+IEBCfLCqus3d0tcafDgPUq39lgi2xGioB5A0XeuOXf4DfkKor+o5UGRfhbyhM/0BaCyzhLxUg==
X-Received: by 2002:a05:6402:27cc:b0:5e6:1352:c53d with SMTP id 4fb4d7f45d1cf-5e8a0bf1f19mr17593137a12.28.1742302415819;
        Tue, 18 Mar 2025 05:53:35 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.143.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad38b4sm7932248a12.60.2025.03.18.05.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 05:53:35 -0700 (PDT)
Message-ID: <b6d132a7-b259-46f4-8bde-fc517bd9d294@suse.com>
Date: Tue, 18 Mar 2025 14:53:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] /dev/mem: Disable /dev/mem under TDX guest
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, x86@kernel.org,
 linux-kernel@vger.kernel.org, vannapurve@google.com,
 Elena Reshetova <elena.reshetova@intel.com>
References: <20250318113604.297726-1-nik.borisov@suse.com>
 <guatjzjzipzjzvj4oou2gktxmzileawshxmxj22hsa5kmet5g4@2rhf7tzaiytw>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <guatjzjzipzjzvj4oou2gktxmzileawshxmxj22hsa5kmet5g4@2rhf7tzaiytw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18.03.25 г. 14:23 ч., Kirill A. Shutemov wrote:
> On Tue, Mar 18, 2025 at 01:36:04PM +0200, Nikolay Borisov wrote:
>> If a piece of memory is read from /dev/mem that falls outside of the
>> System Ram region i.e bios data region the kernel creates a shared
>> mapping via xlate_dev_mem_ptr() (this behavior was introduced by
>> 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()"). This results
>> in a region having both a shared and a private mapping.
>>
>> Subsequent accesses to this region via the private mapping induce a
>> SEPT violation and a crash of the VMM.
> 
> Crash of VMM or TD termination? If VMM crashes in this case, it has to be
> fixed.

Went back through the bug reports and it seems this causes a SEPT 
violation inside the guest, which crashes, and is then re-created by 
GCP. So it would seem this causes an SEPT violation, rather than a VMM 
crash, my bad for mixing up the symptoms.

> 
>> In this particular case the
>> scenario was a userspace process reading something from the bios data
>> area at address 0x497 which creates a shared mapping, and a followup
>> reboot accessing __va(0x472) which access pfn 0 via the private mapping
>> causing mayhem.
> 
> I think it should lead to unrecoverable EPT-violation, but not VMM crash.

<nod> You are correct.

> 
>> Fix this by simply forbidding access to /dev/mem when running as an TDX
>> guest.
> 
> I think we need to think wider. What about applying a subset of LOCKDOWN_*
> in all coco guests by default. Many of them are relevant for the guest security.

How do you envision this to work, by introducing another 
CONFIG_LOCK_DOWN_KERNEL_FORCE_COCO or some such ? Will it be opt-in or 
mandatory?

Should we decide to follow the lockdown route this means the owner of 
the coco guest will have the ability to disable it and a misbehaving 
userspace process will still be able to induce an EPT violation.


> 




