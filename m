Return-Path: <linux-kernel+bounces-320540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07734970BBE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A30AB2194B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D6B134A8;
	Mon,  9 Sep 2024 02:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Rf3qmMp6"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93F88475
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725848137; cv=none; b=iCvJ/7mBUsVcG/cr7aTCQs6SLTJa+nM9MSD63i6RRB2lQh14h/54Fd/pMWajRx96eA9fMKRnGBAIUjEd55FWjJKuwedkWGIeMKzVR/4SiJLpfxlk4MfYu3O8RsKSnuoZu0i1cr7p6nLQaxeUvVUall2TegKHP32YxZIA7OfARkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725848137; c=relaxed/simple;
	bh=/LOorNelw5K6LsGZAXAl2ZaE2Att8l88gdP9meKzMgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MYNejCiNFXvr/b41wCVc1WEeOlXMshjRyXC/xMd8lZAfxHPywH99My4ZQe+542ltc4cpY0um2Yy2Bp+dmrd2Qbon45HAgk3G4D8g8b93wwvaY6iYRoCTlSAIyydeODYGWsTADw5sF4tulw+sYLtMfZr6Pp4iEkUtuAUhWoWRFqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Rf3qmMp6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20543fdb7acso26353375ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 19:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725848134; x=1726452934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kycz822BWcHQgVzQmfVOMENr3RqEtpWbF7qRzT1Ov4o=;
        b=Rf3qmMp65n3WMXtub55essnUzQoVif6CV5y7xa13Dev5TCdku+9P95WWxNM1p2arVr
         iHNenU99sooNWPNITvwvUUck1aU/5znNT0AiSjaWdodc0YCS0LaeBsrawn5TZDSE2yNh
         rN6XVj8PdsQ4FZ95XbcYaBKmodLG7kdYfGrPfcaTyw3I+EgoNWYrSy28ESEgv+20QyJ0
         NvIZrYaTzZ7+twQbqpTJB1FWnoMis5Uz/HmyFwXOitUf/PB81UHk+xbR/N7FDtHmWxez
         pSZdR4Ag7cJcKXLz6FB3+52VS3TArGb8VdCSuZUXGLUgtx1WJddQdt3J4Er74etyr2Ye
         3Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725848134; x=1726452934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kycz822BWcHQgVzQmfVOMENr3RqEtpWbF7qRzT1Ov4o=;
        b=cXAtcUE8rLxHM00FM/5cs0M6+09yv9TOZj89k+rDc2/sbI5pQRwhr3W6NrL6SovAmb
         HYLlt/dv+d+ohRHb1WgMe9rDS8Oo+5yDjSJUVPVZzEXcSzafYjBTtc+hs/qIiEIstdJ0
         f8w8P3WiskHPPZLb2kd0LDKw7DujAFRGFtRr26Qk0Db59mYzXAlOSnmMznQiVfonS0m6
         az/ThEZPu3EFbdUuwo0HQgryBZ7TFzTvlkEF3XsQjx+OaJA5GCst8S8nt3vgx2ePfQ5o
         OjYpPuYMdt09B+UY8r23k+qmhbWt0RV7gtilTG7RTk6Yq4kIk7JwZpbiWfuyt6SlUhkK
         YDPw==
X-Forwarded-Encrypted: i=1; AJvYcCX4BAgkbh1RNzXM7de5wmrDQMpr74LMg/n6yVino8nCdW1yew+Tn5Kn685n3nNGvzUJwD4wIuxjbrdhvl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJIsYVEgs+hVJOGlx1d+fBjY/I0IJUue6Kl2HqyNslH+srCola
	ewY2lFu3dnm9tVMcySxN+tdmNFKWr7r4gDIRkoEt8F3XKpDjYkw1krfwDplblhY=
X-Google-Smtp-Source: AGHT+IEXDdNuaMBdc+/KkajIoBKOQjSXV7wV6wsKWkfirg+ejF8mkgtn4hEdz4bBVIWxseb/r+4QeA==
X-Received: by 2002:a17:902:da92:b0:206:93e7:5845 with SMTP id d9443c01a7336-206f065bb9cmr70776625ad.59.1725848133817;
        Sun, 08 Sep 2024 19:15:33 -0700 (PDT)
Received: from [10.70.146.105] ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20716f1005esm22477885ad.305.2024.09.08.19.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 19:15:33 -0700 (PDT)
Message-ID: <32df3e10-994d-4966-9f8f-e9b736140ded@bytedance.com>
Date: Mon, 9 Sep 2024 10:15:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v3 0/3] perf: build: Minor fixes for build
 failures
To: Leo Yan <leo.yan@arm.com>, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240807032019.1828674-1-yangjihong@bytedance.com>
 <b5688d4a-9389-4998-8031-3f002302311e@arm.com>
Content-Language: en-US
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <b5688d4a-9389-4998-8031-3f002302311e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

PING.

Are there any other issues with this patchset?

Thanks,
Yang.

On 8/7/24 15:49, Leo Yan wrote:
> On 8/7/2024 4:20 AM, Yang Jihong wrote:
>> Changes since v2:
>>   - patch1: change LIBDW_VERSION to follow up the style of
>>     LIBTRACEEVENT_VERSION. (by Leo's suggestion)
>>   - patch2: Use a new line for the -ldl dependency and with comment,
>>     synchronize tools/perf/Makefile.config. (by Leo's suggestion)
>>   - patch3: include header files in alphabetical order,
>>     add reviewed-by tag from Leo. (by Leo's suggestion)
> 
> For this series:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

