Return-Path: <linux-kernel+bounces-396290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EC89BCAFB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 819BBB22B4A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EC11D359A;
	Tue,  5 Nov 2024 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4sUWLls"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DC21D0950;
	Tue,  5 Nov 2024 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803833; cv=none; b=MkAOMvtp2PRoRzz1IOjHDvOTd8znmc1QPoUnWeWsO80ISiUql5qgtK6HDOVmFQLH9Qaw3j1ISaFLnG//PjpVOv7BYDhT29FSHnlFJcthv0asSYISE1HNt4uyA5p+LdBbOm9JU1XBeAI4J/J4Asi4hbI5FIIJEmkadBtXOzDK4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803833; c=relaxed/simple;
	bh=wdbzHeucxH8KiTmxZLVyAq/7hTzym91al/phX1kYZhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ugL3oNO82hQuhkLJANRRoT4Tc9jS93C78tOTY15wo4xu6zZs718EU2NGxfa+4fgpdWSNnt8Pc5KyXwQXOrw7cwJCKFhfsAd/TY2ksHRKBr5wmccVEE5r5ag6QsjszgOqXc6zC9uZj8iPo51jlf3PZpOLNIkCUkQoEGpEWB+eppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4sUWLls; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cdda5cfb6so51540945ad.3;
        Tue, 05 Nov 2024 02:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730803832; x=1731408632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBOd4KFuE2qtGYMLxYEhz8EY5N1d435kQ0uWLQtvfN4=;
        b=k4sUWLlsjSoD1Bx7j/FK76tWpez4zu+0ysOyvHstVrpKU8Q2bgH/JFWE/tJn3PQ4/u
         zG3Ea96U+kdUR/hYTKCN7bdjQrxqH5dD38PrN0R4pb4ggaIs9BFopWz5qtSar8N2SGDw
         +F1Qy8lthw6Q+3dWsYQEFL7zb/HYdH0bUeRZeKxehX8kAsEZFRZsLMpEL6o3ahCo0O3L
         avH2Z6uD4AMJUZ285ixaAJdPMldS8UZSih6RAKlsSnAik1NcfOY3Jsolq5enpDDksYPK
         rVPntDHBXzcFOc3XoyiKvHgZInAnFkFJ+ZIZ7PGc+qtB0MEQvfHUT7FwkeHyGmlQGskX
         7Neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730803832; x=1731408632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBOd4KFuE2qtGYMLxYEhz8EY5N1d435kQ0uWLQtvfN4=;
        b=mui7Qbpi1maGg8SyF52bG+PRie4FN25+5UAPUfE4bvtSkJHiFaEda4RBb2Rll4gAR7
         1Ecl6ARITXlu38LVGsBS4ixla/TxJ1l1QCZ+jsW5FLWfJMQIY4swOKG2Gq0AFpL8A4Mk
         Y4r6YZ9wmsjhZCA6aIfC85vQEhBppWiUhnBMxcGYXrQab8mWL1qsHLSZCuIpOXWfczc5
         Qj4OymP3Nnn5PAwV2dPkBSoZ3iEXho+gfrdqaJKADw6Yttk48um9KgXgCCghMrJ7/FNq
         koQ/iHg7MQf5NvwooC4vVSrsHw61Nc5HzJzNppbZdddradfwtKghVo93Y/xvzt156ie6
         bU8w==
X-Forwarded-Encrypted: i=1; AJvYcCUE5D43mR7QuLVhmPcrnaept92UDG60Etu0Z78pgeawWaReb6ArXMrn0MbvytjobvLGsGcdEpWRHu/T3W0=@vger.kernel.org, AJvYcCXkUrsF6ywJKb32sJMrf2uBJkbZIZHg0BQw5vTW5LqktjjaNgYaGfzIr/OwONkerFjpt/kHtX/nRwbOJBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkw3JOkk7F1xthKfqwZXVSC+HvAZP6GzCyJCTLH5m/IGU1OfUc
	EByoasMb6eKQJbTlcpcXelfRec8Gr3or9DkCwYQ42epV4VGS40Ex
X-Google-Smtp-Source: AGHT+IEkeviM35CAL15SKwpw6/oISbAjNPFuRNwPkzNM+uBoLG7NQB7jdmQgCa1t1v9okNraB8Qx0Q==
X-Received: by 2002:a17:902:c409:b0:20b:707c:d688 with SMTP id d9443c01a7336-21103ace797mr251523075ad.18.1730803831558;
        Tue, 05 Nov 2024 02:50:31 -0800 (PST)
Received: from ?IPV6:2409:40c0:1049:499a:fd64:be8:ad93:9d2? ([2409:40c0:1049:499a:fd64:be8:ad93:9d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d533dsm74679565ad.272.2024.11.05.02.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 02:50:31 -0800 (PST)
Message-ID: <1611f678-edaf-4588-8455-61eed32b2baa@gmail.com>
Date: Tue, 5 Nov 2024 16:20:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sound: fix uninit-value in
 sof_ipc4_pcm_dai_link_fixup_rate
To: Mark Brown <broonie@kernel.org>,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc: daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz,
 pierre-louis.bossart@linux.dev, ranjani.sridharan@linux.intel.com,
 sound-open-firmware@alsa-project.org, tiwai@suse.com,
 yung-chuan.liao@linux.intel.com
References: <20241030155705.31327-1-surajsonawane0215@gmail.com>
 <20241103113702.27673-1-surajsonawane0215@gmail.com>
 <09d8462d-d305-4b83-ade9-747a88aedc38@linux.intel.com>
 <d19b77e2-496b-4633-a69c-576cc79c004a@sirena.org.uk>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <d19b77e2-496b-4633-a69c-576cc79c004a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/11/24 23:57, Mark Brown wrote:
> On Mon, Nov 04, 2024 at 12:52:09PM +0200, Péter Ujfalusi wrote:
>> On 03/11/2024 13:37, Suraj Sonawane wrote:
> 
>>> Fix an issue detected by the Smatch tool:
>>>
>>> sound/soc/sof/ipc4-pcm.c: sof_ipc4_pcm_dai_link_fixup_rate()
>>> error: uninitialized symbol 'be_rate'.
>>>
>>> This issue occurred because the variable 'be_rate' could remain
>>> uninitialized if num_input_formats is zero. In such cases, the
>>> loop that assigns a value to 'be_rate' would not execute,
>>> potentially leading to undefined behavior when rate->min and
>>> rate->max are set with an uninitialized 'be_rate'.
>>>
>>> To resolve this, an additional check for num_input_formats > 0
>>> was added before setting rate->min and rate->max with 'be_rate'.
>>> This ensures that 'be_rate' is assigned only when there are valid
>>> input formats, preventing any use of uninitialized data.
> 
>>> -		rate->min = be_rate;
>>> -		rate->max = rate->min;
>>> +		/* Set rate only if be_rate was assigned */
>>> +		if (num_input_formats > 0) {
> 
>> By definition the copier must have at least one input and one output
>> format, this check is going to be always true.
> 
> Static analysis of the code can't reasonably tell that, we need
> something that ensures that it doesn't detect a spuriously uninitialised
> variable here.  Possibly a
> 
> 	if (WARN_ON_ONCE(!num_input_formats))
> 		return -EINVAL;
> 
> or similar?

Thank you, Mark and Péter, for the guidance. I understand now that, 
while the copier should always have at least one input format, static 
analysis tools can’t detect this. Based on your suggestions, I’ve 
considered the following possible solutions to address the issue:

1. Add a WARN_ON_ONCE(!num_input_formats) check: This would issue a 
warning and return an error if num_input_formats is unexpectedly zero, 
ensuring we handle any edge cases explicitly.

2. Return an error if no input formats are available: Implementing the 
following check could provide immediate feedback if num_input_formats is 
zero:
     if (num_input_formats <= 0) {
         dev_err(sdev->dev, "No input formats available\n");
         return -EINVAL; // Return an error if there are no formats
     }

Would it be preferable to proceed with the 
WARN_ON_ONCE(!num_input_formats) approach, or is there a preferred 
alternative from the options above?

Thank you again

