Return-Path: <linux-kernel+bounces-548033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FD8A53F09
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE4516D184
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6B64C8E;
	Thu,  6 Mar 2025 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0VVwErO"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13571C27
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220404; cv=none; b=hBeFjcRBHa4j1nR0FsDWZvSzJ/1RITmr/B7swEB4Upq3fW/1tvtps8GNA0SQmpWSfwVCpzbbtDZz8A5AhKR3DCgG3qOlRMTn/ZJzSAGrKF0Gu4PAEqFSxeCLVVEA5iqtm4kmcgKSpvyzlJRwOQNdKLSJUs6bFfKmA9K2yt36HPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220404; c=relaxed/simple;
	bh=c+Qb8SYlIxib12tobywhfbhnvFQNNSisxjjTISMtmlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPjWWte7Q52ZG66mN6NczUPV6l6R+9R/U/HtiqJiJufn1+KGLUq2+jhZulsDEn/GpxFhw5Q+f25IRqnaJemGddRERG1A9RCLL+uQSMKKxKlqrpNnQGLQzDkoHQgxdxPIEP+Ht1PoGTuut58xm9F2Sv6AngMkh1prJvUqoKtpS5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0VVwErO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2239f8646f6so603375ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 16:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741220402; x=1741825202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsXEOmwyrzFwv6a+p/KvUo6Xe5fRjBYf4SniCJf5WDA=;
        b=S0VVwErOdr+yf3cqsiE7QUQOI1SjEYZf1kSdTkRjeV9rzJ2/zftxAlC2l7Flw7KJEr
         cGGmOadTKe/fdFDV3gE3TmrTySwbL9U08k7tV7PBrhscMHl0g8V4OHpIrLm0c3XyzLHp
         m1MsTZmUtikQfcd7H/HuN+EisceezNxYNKxFokITlXGDgcdG2z9RHBkVx2oQccV/y+ZH
         L0s2GLO908j7y9UL/0azBmttuwXza2wrHr/8cVz3EblfmCXLXl53dyh7eArccXrqWvdF
         bF7jAYK4Y+pkapsVhg2RWwno60IZbZCS8//3dEUEcseVbZm9KH7LEnvTudG8224tDBoG
         unkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741220402; x=1741825202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsXEOmwyrzFwv6a+p/KvUo6Xe5fRjBYf4SniCJf5WDA=;
        b=L5J29yGl8IHiOML9WyFVPk18jiLdc8z4GVQlMMX1lD++0Wy0AAEX4j+Zy6o/CWd8XZ
         rZ37vHIetQdjz3V0VfMIjDo3kedufqsr4W4jFfLTRhWrCVXK6jDZinVxCAQzFz8lBDPK
         GU5HBW/fDOcIKedOWiAljgrPy7eLq0YOC2osmYr3KGzJA0pYOpvx9F5omezCutx+gZGN
         IQ4+VrIlo7SJodLunPuo0WEg69o2tjDma/JQQXO0126WNdlq2O0198iJ3TqhoHBNXnJK
         USWqNMPe0g3UlJemFoiBBkjzNVezVNw8oN07j6J94kDZT5s+P95RJehsSxmyzCJIPwBE
         kEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWA2qJPGR+i9lSo0FkzxWn6HUnCvLAOUoJQQ9p+YRZr9zCCeKLB9/nwmP/a3LCk2VY7MQJoe4+e3+XhgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA6SI7gVJL0Db45kh7+d1ixDM3axIOOz+QpRoBaiwIeyW5KzSB
	bCKHWb8+9dOYahODv1DkduIzOt0ca6u6y2VZzsec8cozk/11ga0Y
X-Gm-Gg: ASbGncsGt7wx7PhVJR+5HuHaL9iLtpG2akRXrHtEKdhp30UWvCV2Ni4K6u2sYIqU3gD
	q8XVLJL/yknbEJlIcyWPjfVtTMXgCfKm4ELwaRXWijtZyk5JZzt2cYWQmLheRbvhzmYHVac9BRn
	cmpBPr5tNvhFXbS3I0sM30rqsMgdNz+t/F0B8atU3c2HIam64qY2YMbQmG6ii7vn1qybpe0htEs
	mnzspPo0D7QGcvwG2V7CwE/Ohj4P+Oiy2aWM7tBlg/yrB8M48wwTV2ofYDPq926aLhQIhrQh0r8
	9nNvwb5DbYVVTqFGrOIGQbYOxCzxYNSzm5qYPvoJQ2QJXZTkPaO0bLE=
X-Google-Smtp-Source: AGHT+IEYcRS+bSTlNHX7Lwc6xucK9pJdJhdS4fx1Xlwd7Pv2zd7JO3G/4FC2I5W8zePt+tJKD3QkEw==
X-Received: by 2002:a17:902:d48a:b0:224:c47:b6c3 with SMTP id d9443c01a7336-2240c47bc11mr11604605ad.6.1741220401974;
        Wed, 05 Mar 2025 16:20:01 -0800 (PST)
Received: from [147.47.189.163] ([147.47.189.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91c8fsm130785ad.191.2025.03.05.16.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 16:20:01 -0800 (PST)
Message-ID: <77533f97-030a-487f-a265-afd2fafd3556@gmail.com>
Date: Thu, 6 Mar 2025 09:19:57 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] MMIO write access to an invalid page in
 i40e_clear_hw()
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ffc91764-1142-4ba2-91b6-8c773f6f7095@gmail.com>
 <SJ0PR11MB5866F240386177564F78E8AEE5CB2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Language: en-US
From: Kyungwook Boo <bookyungwook@gmail.com>
In-Reply-To: <SJ0PR11MB5866F240386177564F78E8AEE5CB2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25. 3. 5. 19:13, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>> Kyungwook Boo
>> Sent: Monday, March 3, 2025 11:20 AM
>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>
>> Cc: intel-wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org
>> Subject: [Intel-wired-lan] MMIO write access to an invalid page in
>> i40e_clear_hw()
>>
> Please start commit title with 'fix' to explicitly tell what your patch do i.e. :
> Ice: fix MMIO write access to an invalid page in  i40e_clear_hw
> 
> Please add Fixes: tag  https://www.kernel.org/doc/html/latest/process/submitting-patches.html


Thanks for the guidance. I'll follow your advice and send the patch accordingly.
I'll also read the linked documentation and will try the patch is properly
formatted.

