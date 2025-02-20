Return-Path: <linux-kernel+bounces-524266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F414A3E14A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C857A9282
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D79220D4EA;
	Thu, 20 Feb 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FGFxLouZ"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99C91FF60B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069979; cv=none; b=XbGPPS/gk9U3rmCCloW3MPoPiUIdPiNsDrVwrOl2NGmh4I9Vvo3cXdbZ5sIBU7WixRxX6Brke1rgvcgvc+OtJA1xO57dQLXlc1BNvIr2DM/ywTYHrYzhJu5UGTYmFLBA/XknS2KABOQHhv+uwEYxvdZ68dLHyf0FSGETI8K0tq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069979; c=relaxed/simple;
	bh=Q96fH2ufnyrRSkdVqFWpIfJckWGdN24HBgnQJQFk4P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huSAL8lPSSDF8xuYPFyzn83f1W26F95aMeBFi79F0AETho7kTDa7/tH/wAU77RK4+odTgkNGf7VJFPnQOscZ3W9OpI5AAKRVbx0WsBy4P5Z+wBd7MZb3v4HL4OjMwHcOpVlGURKGIhA5p4HrZT10DbqOqnI65ICh85s74LQOiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FGFxLouZ; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5fcd811d939so1301365eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740069976; x=1740674776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rh4eTXTu+c11RkR0T9DFkG9ZleZyfYRGduufAwusFKE=;
        b=FGFxLouZGl2ZLZWqdYnsnUJhzUlf60op0SLfHJqzZ6NYM8I+VuHW2a3Rwx5N6GKwct
         4BPBAqzoLfrVJXo2orBJ9ocY6NSuiGyIhHP8D34XKTfVjV+rL/zH1gZRAM3l9zHGrSwH
         gopJRsIz1xc+Rs1PPPzZGsnRYC0Vcs6cPixpO3Xr2uNLdST8crs94e1tkxBFN9gQz3RZ
         5LkLkDZN1ttE7eDowRZOXQsgrLPjbE2C6ta2zkP6HjOLXh9qtP0yTAVU3Ycwp2oIq+jR
         dznYTHwkzHUBVkX9R+OimkMF08CRlAxmJslSaoDqJsJaYfS83mzPrNyoTAhCf2drqNsj
         XbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069976; x=1740674776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rh4eTXTu+c11RkR0T9DFkG9ZleZyfYRGduufAwusFKE=;
        b=uxGft3G0TzEWilyuKsze+zeS3T+QQjE6IFF0Yj6wvNt2nAcPOzuz8/VHHUMAPCq75j
         LnnhU7ueMkdKOQgIOPdny0yIPQ2i9evK78/bitdqv6R3F6kRC5xkle8wJjmILMu/7w1E
         fBVynl9HmOfkrRvGhdsdJ0tBdI4cmQCWDTMvBHTQ48pBeXfdZ21OKGmQRimCw8HjtA5V
         KrUl+2iC4E09MvCxMBDUC4y/MnivZD9uwyfWO7hNctxhSIVvSPjWIn19ENBtzmunTsev
         GqK2CimdVJtZQGO8uleusf6rOz917AX3lItmHf1JTJqU7XHokrueC9RCvx/n4WiP+lFN
         BJ2w==
X-Forwarded-Encrypted: i=1; AJvYcCXzKjXc5U/nLlnotqPKLRBV3PC3SMCbuNTwDmjCB/1Il19aIlKN3iDbivFTzh2RHJiFd3XkKM6FlLkcPCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLY6krE3vHVQwBNnelQ/5B0FcgTLxwpi8fzBPBqfGUCeA/hPi
	fnHt6uyiuTN0vxEApwPrSALnCeYAYqPjfyjGNUvLamnh/uj1TIB0ztT5DRnhTH5+YdhFyndHdgu
	F
X-Gm-Gg: ASbGncu613nCZKQPHrrMgAekdYOW967uqJaHiUMPUXt0NaGRWFtfV5SmwOq7ydhYZ6k
	/ayg/oCM0DdONnATz+ibXLwO8h0jr+1eOgOpjMKiU8H9rxfbE1lz959Nxpb9eaijpW+DvH31ld/
	dCFtXNmHCWqqxt+ghoZ0Uy7sABIEuT+dQ8okaYDLxH18cuHaqPUxeDLr/2S9W1anGvw7BNWOqjX
	1fTJ+/tiBIod6KpRqzSmVBEJPuQ9NZqFwzzSklGl5VZo+ngRFQU16Pk6FeVaz4DNiMQm6fdHlaq
	Y6F1Nf8t5+U=
X-Google-Smtp-Source: AGHT+IG+EYLLqM6THWYE8hAauMhRAcU2Nk6bktOc2WtjLtNwvqYq1DbYMyEayXYWgyo4XXN/dzNAHg==
X-Received: by 2002:a05:6e02:12e8:b0:3d0:26a5:b2c with SMTP id e9e14a558f8ab-3d2c01cbd32mr32793245ab.8.1740069966144;
        Thu, 20 Feb 2025 08:46:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee9f935135sm1841325173.42.2025.02.20.08.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:46:04 -0800 (PST)
Message-ID: <d178e65f-0168-4046-b516-1304db75820d@kernel.dk>
Date: Thu, 20 Feb 2025 09:46:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250218: arm64 LTP pids kernel panic loop_free_idle_workers
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 linux-block <linux-block@vger.kernel.org>, Cgroups
 <cgroups@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-mm <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Roman Gushchin <roman.gushchin@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYuVngeOP_t063LbiJ+8yf-f+5tRt-A3-Hj=_X9XmZ108w@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+G9fYuVngeOP_t063LbiJ+8yf-f+5tRt-A3-Hj=_X9XmZ108w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/25 9:13 AM, Naresh Kamboju wrote:
> Regression on qemu-arm64 the kernel panic noticed while running the
> LTP controllers pids.sh test cases on Linux next 20250218 and started
> from the next-20250214
> 
> Test regression: arm64 LTP pids kernel panic loop_free_idle_workers
> 
> Started noticing from next-20250214.
> Good: next-20250213
> Bad: next-20250213..next-20250218
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Should already be fixed in the current tree.

-- 
Jens Axboe


