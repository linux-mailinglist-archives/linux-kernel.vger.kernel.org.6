Return-Path: <linux-kernel+bounces-396304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B539BCB36
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5461C22726
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647151D2F64;
	Tue,  5 Nov 2024 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMBs/RBG"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D92B9B7;
	Tue,  5 Nov 2024 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804644; cv=none; b=UdFxW72YSfMF9CCRVfCwd7uLWllpzlCRzuzKWFq+lKqBC5bmsxapwBKuFySriP9kNLX4KaBXPbHxVuLvZDd/6pRDHFHCI1BlkHjRVZSjg5CYp6hLXfjCixmUZf22YZuoSmeSIk2Pk5AW7ahd0J15068LEB/gh5Pfzy7cBSa0Yo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804644; c=relaxed/simple;
	bh=nan3RQi5wxFVEr0Ad/m1dJyKlkrKoStwQ9P+1WrCK7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jfar3DDNgDYUNJGHZBj0GDovyRXXmdvh7ptOfPQCLa6rupd1wOCh3TmNQzVsPtUijlafSBL2z9VahH0emHsMbQYFVxEB86M8YGWnRbB+SUfFCOjBbW2le7mLM8OsPMQAds3qCG7JILFb2L6txt/7iZrhUT70+hYYlilOLgUPc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMBs/RBG; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso3710461a12.2;
        Tue, 05 Nov 2024 03:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730804643; x=1731409443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7s6RNjn6/q+9OR08Z/JWJC3mHOHawh3a7YswG2NdSWo=;
        b=fMBs/RBGag9BNA5dEk+x7iT+wuzMmwnE0IOZ+dwwn9IeiX5sn1w8mJJcYZ0OGeB7hn
         QoRLGfSSYS6TtuRNh+V1GmNa6JxwB3WJqazPk+Ab3KrB4MauxiSlU3Dwy5msxL0ZohF4
         7mEBp0O2sRhFSdeMo+sNvnWinZ4aUv9h4DlYhjC/sbt96QMBiJvg7IwFG+t5++9Dns3i
         ZLo/biHIOuvVMH9zylknlDVH2GJE6WZy53MSP6A6h3WvHVDmO+ZlpPzcZs7uN2gkC+i3
         hwPugP2fhbpMCSje7LWJKmNSOGYCZ1i+xqz399dtWdf+2Pja2wYm8qlHS7kj6A8d2l62
         l80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730804643; x=1731409443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7s6RNjn6/q+9OR08Z/JWJC3mHOHawh3a7YswG2NdSWo=;
        b=dAdpDVATZqPWXisCYYeT81xgykpuY0im6uhM1LYQjQBmuibfP6Xpi0xdWqxAPkCWqB
         O7cbzOyiAYiLILBiVH8qpybjFJkmMamDtX79JOEBNOinze2bbS2Mb+DZzXMkQ8v3Q6l0
         ODZ/18qZhXYMNH4Nxp/okyyPCmUccFTTgJJ28GK/581fBblsbYo+OW0yD28AGfwuCwLp
         ZuNA23MHNfge7BX+C59t3cOFUKMzg//DpcU8oo48hj/4zK/XrwXiBmqWhWAxbPmQxglL
         Rf8D3PbTFnqlsLQsEWbR2tIp1CQqZzZtS/uukadnUHEAqFw9fNpKMkk2q2+J3Lrvk2Cw
         Ejlg==
X-Forwarded-Encrypted: i=1; AJvYcCXTiAbSTnE+UOSzV9ErdA71pW+9RG8jjg4SU+uzz/VOuvNrWtn4mmWd7DmD3BQ3zqWs2CTYOML9tgncE+M=@vger.kernel.org, AJvYcCXWnCBKj42vmd5ZHnW6E3W9Br9mODHm4xE44q4TPF2DVMvxvh3Cgl2v6D5zpQ2KTW3uyThdmkC2cG5Mvjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+pfHx0lt52SkHMl1AQSZLxqhGg4VNOjHn5P4s4kx5zCgMPqt
	f2Tk4gfdimJsCa5pSz+SrPLnycsYIwOCq/YZSdYkBiYbiCpIwwKb
X-Google-Smtp-Source: AGHT+IGLaIX6/Mm5wEzSjKEyolmNm1nGJYF5ZIFbXSCGeKeeUa41Z9NWp5erk9Jd7QNTdpAzM4Oj9Q==
X-Received: by 2002:a05:6a21:999f:b0:1d9:c5ad:c995 with SMTP id adf61e73a8af0-1d9eeb06e38mr34491449637.9.1730804642739;
        Tue, 05 Nov 2024 03:04:02 -0800 (PST)
Received: from ?IPV6:2409:40c0:1049:499a:fd64:be8:ad93:9d2? ([2409:40c0:1049:499a:fd64:be8:ad93:9d2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee44bf470dsm8863095a12.0.2024.11.05.03.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 03:04:01 -0800 (PST)
Message-ID: <f9fa484f-b7fb-4a32-9958-be41ed67504c@gmail.com>
Date: Tue, 5 Nov 2024 16:33:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sound: fix uninit-value in i2s_dma_isr
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, perex@perex.cz, tiwai@suse.com
References: <20241030170829.36161-1-surajsonawane0215@gmail.com>
 <20241102123630.25446-1-surajsonawane0215@gmail.com>
 <d1710182-b4e0-4bb9-bebf-1fa7c48c77fd@sirena.org.uk>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <d1710182-b4e0-4bb9-bebf-1fa7c48c77fd@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/11/24 18:11, Mark Brown wrote:
> On Sat, Nov 02, 2024 at 06:06:30PM +0530, Suraj Sonawane wrote:
>> Fix an issue detected by the Smatch tool:
>>
>> sound/soc/bcm/bcm63xx-pcm-whistler.c:264 i2s_dma_isr()
>> error: uninitialized symbol 'val_1'.
>> sound/soc/bcm/bcm63xx-pcm-whistler.c:264 i2s_dma_isr()
>> error: uninitialized symbol 'val_2'.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
> 
> Please don't send new patches in reply to old patches or serieses, this
> makes it harder for both people and tools to understand what is going
> on - it can bury things in mailboxes and make it difficult to keep track
> of what current patches are, both for the new patches and the old ones.

Thank you for the guidance. I understand the importance of following the 
existing format for subject lines to maintain consistency within the 
subsystem. When I submitted the v2 patch earlier, I had been considering 
this, but I mistakenly thought that switching subject lines between v1 
and v2 wasn’t necessary. Moving forward, I'll make sure my patches align 
with the the style for the subsystem and will submit them as new threads 
to avoid confusion.

Thank you again for your feedback.

