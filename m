Return-Path: <linux-kernel+bounces-390030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297BF9B74B2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586DF1C22072
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA870146D6E;
	Thu, 31 Oct 2024 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMXSXAm8"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D2B282F0;
	Thu, 31 Oct 2024 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730357291; cv=none; b=Uojn/pOQvt8YqAUkRcw5dy13vDbdaSx9cDzDO58nGwxQ8y2J+UMTXVecIQWl4isUNxH+++v1S11DQs62faOejcU49ooNxeoUfyybYmub2XB5omuajNxosZSi5wpo5/vXcUULzEwZtVvFD7KYw9ELm3vlrowe0y+hi6szVE3+hDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730357291; c=relaxed/simple;
	bh=Kw8QFxFU1wEHbXD//dpZ7KV5ZDZYB/USspUlkMhmf2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AegpBJBHuYc7glF7Hdeq/4hRWyW4u7WdAUaHLHQ4lvr1PvH4be156LfFlXpFA7mOpMFvpWqMz/CMR2Elg5Hys1I/9frZVrNHf7BDMs+cH5llDG2GWul7Ygf0igh1MsmeCfLmgz51CSaUs6xWuxKOLUA7baQyC5zeqiC9aEjS6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMXSXAm8; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7181caa08a3so299057a34.0;
        Wed, 30 Oct 2024 23:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730357288; x=1730962088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIujQdPr/P3RSPSwz63VyOAHXFOS9a2kSi46SoQmK/s=;
        b=BMXSXAm8xMlZ3q/1FCiJRoq/RixHH4X+DQXbzuoiN6TPjfADDzYcJg99V/l+6wTmOl
         eq2E2Ca6FKIoEaYaTiw0WOLaQ3kVLTzPqpjFb4pMnEzC8bVNVKWfazYEjT2o64P+vOUu
         qxyVEDVU+rImsOetlGL+q+8V87r1hWIxdNizwk4iRlllXQ2ILKzcXBepTgJsgv/ZPIIe
         PzLX6Tvnvs6D0onMK0gE5ULBQnjZKgFTUWO+tc8KOPsRyhpEUKOqduuJBdMtIRjMSfD8
         4I3bKrYdTIOA6u4zxYyFmuOnSwCTCwKeZQohTjkw/kXcPBaTj15yZ/cQTiMZSY2oH20K
         AxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730357288; x=1730962088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIujQdPr/P3RSPSwz63VyOAHXFOS9a2kSi46SoQmK/s=;
        b=MGbCJkQ2aIe+fEKuPsYOadeRDZlraeJ6s600BTq1n5ecz+xod1Wv4UJ8lmcr813uoa
         TPkOIG0HUbov86P6vzUIIY7lHOHBdzeO+rL/qr7R7aZrIXhL246LSL7H3T6P7vWL/pH4
         yvVMpZHO7LXTwn7U/KYAEqnAZF6+C0xqHKfofYKiLhboox3+dzyul2AJtq2SapuDDcsg
         TTUsWOHmvcVr4iPaLpoMSfIsxFVOeUw94ISf0idCU+21N1lBIfo8ty62cBs+756yNwEi
         mQHtLzo4SgbTgVOeUgGNUnlykLayNE7dToyajJoneLDC2M+8F/SQwhbdHzLY8FHldGzZ
         8RYA==
X-Forwarded-Encrypted: i=1; AJvYcCUCndQg7wwDI/+neewFe+Tz1MwjKodgq4Fr0j9YMZHE782HydFLSE09Kke1tX3VqhcGzLoiDYYYPVFQSts=@vger.kernel.org, AJvYcCVB1JsV789wgqW0MXLINUl+Koq5X3RCjDvV4DzV37r4PEcHDM8teatb/xU1Hym0k5vdV0/hRLFCFTIGuQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbE/aPshv/63sqR1Dg/gYNrUejSQwe3F/tZjOMjNdMZ76QJC3Z
	Yyl5xzLuHWTkSFFmK0z6C9ZYcBTJDJCm0nqSEVPafIBLNHIGomAq
X-Google-Smtp-Source: AGHT+IFvZlgdjtoOCLMVGrmQDYsML8yIOrG+sCMD7cqOax3ZfTRL5E7MQV0NjvcEV2lUlLPT1b1h0w==
X-Received: by 2002:a05:6830:3786:b0:717:f666:9559 with SMTP id 46e09a7af769-718681188e9mr16500167a34.9.1730357288414;
        Wed, 30 Oct 2024 23:48:08 -0700 (PDT)
Received: from ?IPV6:2409:40f2:e:4b75:a7f4:68e1:fad8:f425? ([2409:40f2:e:4b75:a7f4:68e1:fad8:f425])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee455a73d2sm558031a12.46.2024.10.30.23.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 23:48:08 -0700 (PDT)
Message-ID: <a4039ca2-6c76-4431-8e27-caebe1a56deb@gmail.com>
Date: Thu, 31 Oct 2024 12:17:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sound: fix uninit-value in i2s_dma_isr
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241030170829.36161-1-surajsonawane0215@gmail.com>
 <635f1691-74e9-4e48-8ebf-8e7ce0c6d1e3@sirena.org.uk>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <635f1691-74e9-4e48-8ebf-8e7ce0c6d1e3@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/10/24 22:44, Mark Brown wrote:
> On Wed, Oct 30, 2024 at 10:38:29PM +0530, Suraj Sonawane wrote:
>> Fix an issue detected by the Smatch tool:
>>
>> sound/soc/bcm/bcm63xx-pcm-whistler.c:264 i2s_dma_isr()
>> error: uninitialized symbol 'val_1'.
>> sound/soc/bcm/bcm63xx-pcm-whistler.c:264 i2s_dma_isr()
>> error: uninitialized symbol 'val_2'.
>>
>> These errors occurred because the variables 'val_1' and 'val_2' are
>> declared but may not be assigned a value before they are used.
>> Specifically, if the loop that assigns values to 'val_1' and 'val_2'
>> does not execute (for example, when 'offlevel' is zero), these
>> variables remain uninitialized, leading to potential undefined
>> behavior.
>>
>> To resolve this issue, initialize 'val_1' and 'val_2' to 0 at the
>> point of declaration. This ensures that 'val_1' and 'val_2' have
>> defined values before they are used in subsequent calculations,
>> preventing any warnings or undefined behavior in cases where the
>> loop does not run.
> 
> This will shut the warning up, but why are these values valid?  Are we
> handling the cases where the loops do not execute properly?

Thank you for the feedback and your time.

The uninitialized warning for val_1 and val_2 arises because, in some 
cases, the offlevel value is zero, and as a result, the loop does not 
execute, leaving these variables potentially undefined. The subsequent 
code calculates prtd->dma_addr_next using val_1 + val_2, so it's 
necessary to have val_1 and val_2 initialized to a known value, even 
when the loop does not run.

Initializing them to zero ensures prtd->dma_addr_next has a defined 
value without triggering undefined behavior. However, if a zero 
initialization could cause unintended behavior in dma_addr_next, I could 
alternatively handle this case by setting dma_addr_next conditionally 
when offlevel is non-zero.

Let me know if there’s a preferred approach, or if you'd suggest a 
different initial value for these variables based on the expected use.

