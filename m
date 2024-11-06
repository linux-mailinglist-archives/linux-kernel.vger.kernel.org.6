Return-Path: <linux-kernel+bounces-397811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 073D29BE0EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F90F1C231B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8D51D6DB7;
	Wed,  6 Nov 2024 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHBA8V6z"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C311D45E5;
	Wed,  6 Nov 2024 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881479; cv=none; b=hbWcSRa2crCNdAV4nM4j/jQ08pAiSt50vajPvsIJT60AkE6s//9a5590yN7SqRZUSWsrRDlflisL1Nq2bu5PtWuU0faxxtnil/oxFm2EQnjX7iJicO2Jgsdketisi+CrN9QxecDX7y75uOhHwrXRMzXM96Zl5VjNwjHWqi53Lw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881479; c=relaxed/simple;
	bh=70TNB67i/4vGiSdV65fcAHRWW3YvbmS1a2GR9IcDfSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvz3XPp+6NZJ19+bTJn93e26qMcI+kWCCC6OdP+Te/6w2cCS2ByfPPDTbf78cmvGiXf+c2miOwlPRBRuZfmA6PI4drGAfQuZdzWkDUjjgNtWQea0qQuWqtmjtXE8U8v70GHreOIkSZqsTp/yc/9x3tpAWb9GUAO3ypJP9Y0w7O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHBA8V6z; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso5151695b3a.3;
        Wed, 06 Nov 2024 00:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730881477; x=1731486277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m9AlUen4etafeVDesBqGlqaujx7WAhjF705iLRbdbNI=;
        b=nHBA8V6z+Su6wJ/I3ZboozA+F+HrH5Ix8kMh/40epsIZ/tyvTmRGJvuus1sdnVPXoS
         Uv6WbLjDIsEz99DYDMzOmrzhNpbsImCZG9IiWVQ7BlJP9Ar8J8rWg4RkO+Xx+kDzwBFx
         nrwrJdjDQ72QW+8hrFdfbiGCLrDe7jgNAo1kM+1k6qL7e2SIRDTSUdyoZNMTS3YY6MTR
         WApjYjzZhMGQbHeVO77Qy/DNc9XFS1dg8N2ATAuS1VZlGKyF/wG4Dg/1IEIBNxmgK4Kc
         EPHrsImwt+Adyfq1bgrK14jOiGGCXvBtzIuMI2d6Zc0XjJxSok/If+QIHxMe3w72tJsx
         rjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730881477; x=1731486277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9AlUen4etafeVDesBqGlqaujx7WAhjF705iLRbdbNI=;
        b=aK1eqVADrIYUDj+Az1IXghBMnaocR2cI5zue59Yc9y15yFF937li16C2QV28ieZ9t9
         oiVOEXWeZ4NQrj0N4Vd8Bl4XSmr37QvKk9A+rFgqVX9HyngD7axaFmzpkSX/QteYCbPG
         PsBZ+8C5p4zzfgiTNmkB3GgVp40i2EGl9SQ57lvtfrLF5+c/lRY0tmVthdXB3X6/4FAP
         tsXPDySXuc5HyLw9f3uZy5IeE+K2ecsEumqANkbQtbleTIcL6DfBtYSfD+tVhg1JezwF
         zUuIM3zBjSGjcZkgohPLRKnInLFNvnsiL5+z5x+Xml3mx9wAiGyEqJkTT5G48ZX0RcP9
         j1Ag==
X-Forwarded-Encrypted: i=1; AJvYcCU/5+GwcB7HV4em+XeFrwnX6zZHu/shV8Tvg5FSa7Y7NKA+WQ9/sxnIaaltIYxv67o7uuI1S6b9azEqQBg=@vger.kernel.org, AJvYcCV2UHVbPArw0yAxUhaQAPiUol42aG/8VQByUMjTGERCboEn62zishZzU+9p0762UpeFbaahi1T5ODFhXYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuFilsUzolpVii4WjcdxfKxzL9rbO6oyS0bDPlPidbBGg34TE7
	RN+wxupR/t6z86quDym9dGugWT7zvtNFHWBTlgaebFlnTQZ8O2EO
X-Google-Smtp-Source: AGHT+IE0C3IjB5cnCZO5bUPq1U+O1pTwAG9hu5h5Hh6gYw58o1bR9aGru2DrQ3ptSZ98sisTgOONHA==
X-Received: by 2002:a05:6a00:a2a:b0:71d:f64d:ec60 with SMTP id d2e1a72fcca58-720c98a3d45mr25262336b3a.7.1730881476835;
        Wed, 06 Nov 2024 00:24:36 -0800 (PST)
Received: from [192.168.0.116] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2eb5adsm11045530b3a.163.2024.11.06.00.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 00:24:36 -0800 (PST)
Message-ID: <8e7cc882-3299-44ab-8ad6-48e0faa9d3d4@gmail.com>
Date: Wed, 6 Nov 2024 13:54:30 +0530
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
 <173082470610.77847.10440868668572486122.b4-ty@kernel.org>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <173082470610.77847.10440868668572486122.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/11/24 22:08, Mark Brown wrote:
> On Sat, 02 Nov 2024 18:06:30 +0530, Suraj Sonawane wrote:
>> Fix an issue detected by the Smatch tool:
>>
>> sound/soc/bcm/bcm63xx-pcm-whistler.c:264 i2s_dma_isr()
>> error: uninitialized symbol 'val_1'.
>> sound/soc/bcm/bcm63xx-pcm-whistler.c:264 i2s_dma_isr()
>> error: uninitialized symbol 'val_2'.
>>
>> [...]
> 
> Applied to
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] sound: fix uninit-value in i2s_dma_isr
>        commit: 28f7aa0c015036db260adbec37891984a31ed4c2
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
Thank you so much!
I appreciate the update.
I’ll monitor for any follow-up feedback.

Best regards,
Suraj Sonawane

