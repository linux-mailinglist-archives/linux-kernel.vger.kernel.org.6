Return-Path: <linux-kernel+bounces-397820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DB79BE109
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54ADE1C2321B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F111D5171;
	Wed,  6 Nov 2024 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIXCFwJW"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE552199243;
	Wed,  6 Nov 2024 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882062; cv=none; b=b5KWAakCcawr7N3eh8t/uccDhuLltvPXZMKv+NqgVgO1vSAr8rbY3V40SN0sBovKLEatilPHid6Aoj5SFCqBsKDXuBu0BSgfkrU8NSW+X2cvvA23U2cyhcBCn8pt+EZfAbxee+fcGMqImR/GCqt3V+lm1MYIEVgr+B2KIxt1lIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882062; c=relaxed/simple;
	bh=Ll0cc7YGGgOI4XpTwHp+3j6I/rcO4Y+t0Ah1lHLeex0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dX2QuLF9sNpe32UPkV2eaLFDfTfICIA4lBwmQt/64LJIbijMFsBaXe2mpqzhm90UMrK1XbKxy/IvQrxtT9+CEkwqRWuIdadpToMGh4HRVZHMnQ+w0RSKPU4w6JQW+/iImYnsKRvHfVT2Y7r1hH9TrMbHemkTqzLAe5Ls7kIWQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIXCFwJW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c8b557f91so65956405ad.2;
        Wed, 06 Nov 2024 00:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730882060; x=1731486860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uhYrLpKnm3Tu52gO6lAUWmTkzd/jjfJtwMUHBNetRdU=;
        b=WIXCFwJWeujptiXg6QkGAzHiEwkEy7jckmK3kco+JFwVhjbsSIVp5oXUcZSJvGslMg
         zJ6ftbmpv9AndCyjnOBKTTQtMzy/qNByZ3bPE/I83ZrDDSB7XBEPYeVWAjnGghoLRJmE
         ZDmhs6QjmW3pgxYvhyNF7PzLUkvuwSOGLrL0eQQ/ihADbiA/TAsiskqCo1JEaHIeTYCr
         YQPaVIDlhQpmIi9IhbxqK/9nIQtJt7XqUuHF2W2verGwTiePlAdw4QgeIwK7IUf7j2Ky
         ZEgFlcWbvzTz4tkA5scOEPV3R1W+FBV/3gdRUmSMXGYEN4sS/M3N4uTx4xpkCgVC8XTd
         tKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730882060; x=1731486860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uhYrLpKnm3Tu52gO6lAUWmTkzd/jjfJtwMUHBNetRdU=;
        b=d2oTtbje/bDXuNBhGaEdlWvUeHOZdsUsQbfmnBFeKitMwyWpKw4BQ/mgRCBzQIMv56
         Z40mfy5W5dyadfi/03m/en6EVnMnjOtAfVENuj5engThj8WawMZYY6QYH6gi0k+FO6z0
         nFYRi8yw5gLHsWa7aKcoFmNHp90V+ApyQI1bn80Igi4M/q4OcVxiH0vhioh9snxrB6VP
         vxze2Y5Hj5wDVZ0Eb48VTE+6R6KWqXbrEg3bEWtAmB445IKaHk85C2XsAy4ACczqB5Ip
         caVoj0uYJwNwl2P52dw1dXhmIX1f1cJbdP2VCaTATNY/w9MCQbNbPu6SpO8pgMLQyGjn
         CgtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyQ6Re/wgBCMLjkoHjZiEXIRZtLqoLOE2PKgbWz7Cf2qPGix7I8r/XDQmTTukYskAl/s0Y/8wEJhYvKKU=@vger.kernel.org, AJvYcCXTqcSb093Kqw9whQfl7Hfc5H7UfaDpHH8EG0cdxE/NycfsT9IoCzfgmDbPkVeP1pNnROzFrS2VBx8Lwtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3kui9e1Ob54a+Ys4okOUbpkOVEv9DLpk0mRshyhc9K6tu7HMt
	02Vt9sCEVD7T4UIGhLN/feTN+oy9hkkMkPpYpeUL5UVMadzT9Yzt
X-Google-Smtp-Source: AGHT+IGCIx6tt9vUNII/cL/xBvoWTTb1SAwqBpyvk7kH5Q6LPfS8iVUQ/4QuB1H6nCWh55UkqrgndA==
X-Received: by 2002:a17:903:2b03:b0:20c:5e86:9b68 with SMTP id d9443c01a7336-210c68a1a99mr552402995ad.4.1730882060167;
        Wed, 06 Nov 2024 00:34:20 -0800 (PST)
Received: from [192.168.0.116] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edc41sm90919835ad.12.2024.11.06.00.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 00:34:19 -0800 (PST)
Message-ID: <a45cacbe-5bf2-4bfa-ba6a-e4602a7689e4@gmail.com>
Date: Wed, 6 Nov 2024 14:04:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sound: fix uninit-value in
 sof_ipc4_pcm_dai_link_fixup_rate
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz,
 pierre-louis.bossart@linux.dev, ranjani.sridharan@linux.intel.com,
 sound-open-firmware@alsa-project.org, tiwai@suse.com,
 yung-chuan.liao@linux.intel.com
References: <20241030155705.31327-1-surajsonawane0215@gmail.com>
 <20241103113702.27673-1-surajsonawane0215@gmail.com>
 <09d8462d-d305-4b83-ade9-747a88aedc38@linux.intel.com>
 <d19b77e2-496b-4633-a69c-576cc79c004a@sirena.org.uk>
 <1611f678-edaf-4588-8455-61eed32b2baa@gmail.com>
 <7016fcb5-329d-44f1-967b-3059e059aeb9@sirena.org.uk>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <7016fcb5-329d-44f1-967b-3059e059aeb9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/11/24 00:37, Mark Brown wrote:
> On Tue, Nov 05, 2024 at 04:20:23PM +0530, Suraj Sonawane wrote:
> 
>> Thank you, Mark and Péter, for the guidance. I understand now that, while
>> the copier should always have at least one input format, static analysis
>> tools can’t detect this. Based on your suggestions, I’ve considered the
>> following possible solutions to address the issue:
> 
>> 1. Add a WARN_ON_ONCE(!num_input_formats) check: This would issue a warning
>> and return an error if num_input_formats is unexpectedly zero, ensuring we
>> handle any edge cases explicitly.
> 
>> 2. Return an error if no input formats are available: Implementing the
>> following check could provide immediate feedback if num_input_formats is
>> zero:
>>      if (num_input_formats <= 0) {
>>          dev_err(sdev->dev, "No input formats available\n");
>>          return -EINVAL; // Return an error if there are no formats
>>      }
> 
>> Would it be preferable to proceed with the WARN_ON_ONCE(!num_input_formats)
>> approach, or is there a preferred alternative from the options above?
> 
> I don't have a super strong preference between the two options.
Thank you for the clarification. I’ll study the best approach in more 
detail and will send the patch in a while.

Thanks again for your time and feedback!

