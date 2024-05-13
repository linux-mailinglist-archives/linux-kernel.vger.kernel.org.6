Return-Path: <linux-kernel+bounces-177781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC378C4490
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6FA282AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC6A15443F;
	Mon, 13 May 2024 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5Aj2sbc"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939A4148853
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615403; cv=none; b=KOJdNsdz/H5RkzjKCNapP7UFruS1dDO8WDTTaCqGvr8Gt/vcII7ZUxS93TWnqZkQlywzUipO7WDbPWYYgfruDlSm/QSpL3uyrvQMY1PMIBZ4l4EPz+OzyJPYFHw7u7uIASJg0p4tNPIU6tAR1T2sjJvymwCQmSw04hfR9zTptXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615403; c=relaxed/simple;
	bh=8+kw90wdwTNBsyLmS1ZTfIhHTy7nHaip3NEHKL+3n+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z56w/UyJiL27szG2RVYwGtSrCOfrCo1xCAItspt+NhKOfMlWo7M4kMKRCGfldjsT0qvOwjIn7yEPqU5bhh+BKLEfkDQgLpydW6TIa0jlDMYdgpJdOqB8nSRrfg0REBw+ro8MaF6WKRyiaqe0DqGtC3o/fK41NTJysYWeuLt5Qng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5Aj2sbc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ec486198b6so33463565ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715615402; x=1716220202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JYLIvICASvk+cAq8OmhwkQvEdjtLJQ/QOdrmtZV0OZA=;
        b=M5Aj2sbcBVvPPBOlFWsmD/KobfL1ElqtGu3oJo4K1Qsspro8VUcN0NuK6YaRGjifCz
         GaLMoMr8HBAlBHwb9JtYfQm6Tb+/u0h9jguZEjMCpz7bwTM1pNKs3N4kZAzxiICOjpbh
         ipXouX1GdvbxtMslLDfYjN0+cLVnMY07PJyp93oBz0GQBsD6R6LFNRHOlZiMoevAKKm0
         4BGCOd8Le2K7Rwv+vdyOfIqvB+DM66EY1siidVuvCpv9x4eP2+d51evKsjMEv+qZpHBA
         HX9n+CMPULfnTBOnKEBEpwwA7ldRVaOJ/EKZyLtOq5/CYr7coLYLlRHwPyE7PhPofoD5
         Pj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715615402; x=1716220202;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYLIvICASvk+cAq8OmhwkQvEdjtLJQ/QOdrmtZV0OZA=;
        b=ppEogqvSRM3PpnFUdXlm7Zc10VdfmCyn3A4zcqGQ+sURMBHtQr+uQBgWTNGk8mReS2
         1BGJ8UEefgCFFoPe50tA0FdFUAk3F1DhbtIhi8sBC2m/1Gj+D1L7JO2S0hNrWRBsGrXx
         HLMdKARDwrTtETteXn2q0tGWE6qYEEyLoWfAxdXjmY9hlH/3acqknKhZ51mmZrJxSzEK
         eMUAzoFvVr+W+iG1eJw6rzDVU2CuQfMrMsWhcLqduZoOvAkUg/Y3/sixwYPWe5NozGmg
         Qtfx85kWL7vKyZ2sihbExXQJ7LMOwrHQiaj7HjugbWBjTQryaLSYSAuJkkFw7wmeDlfh
         o1/A==
X-Forwarded-Encrypted: i=1; AJvYcCUquNRUCYZp0AihtgNB0mab1Krn6Kr3ZFGjGNNxyoCpylzsBvIobPNiYHLHvckl6NqAkYt5iwPlUkGYHPxAbUw2ulnlC3aTOopYYQbK
X-Gm-Message-State: AOJu0Yw5aBIytQbGNhEs33/0mhw0fELgbQxNyxx46xoJsIWvIiuvijBe
	fw7Ve7sXihiitXqDrtn4c91Vp4uwV3z4W+/ny099PKft9Lx/PguSi+FPAuPx
X-Google-Smtp-Source: AGHT+IGFsRNR6UX9KinPp2w9k8moljlEC/ySBJ/gXw76PsrneuzFAafhnAadnzQxv3aQfbbsdW061w==
X-Received: by 2002:a17:902:ea06:b0:1ed:6cfa:86ff with SMTP id d9443c01a7336-1ef441a7547mr111557165ad.63.1715615401808;
        Mon, 13 May 2024 08:50:01 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm81050795ad.254.2024.05.13.08.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 08:50:01 -0700 (PDT)
Message-ID: <212a9464-d52b-4730-95b9-5a0aebd38c91@gmail.com>
Date: Mon, 13 May 2024 08:50:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: Stephen Langstaff <stephenlangstaff1@gmail.com>
Cc: andrew@lunn.ch, linux-kernel@vger.kernel.org,
 "OlteanV@gmail.com" <OlteanV@gmail.com>
References: <CAHx5RXBfazB62qpbGGK3_YjwCFbiJbEXrgo88V6qHFdTW1CdRQ@mail.gmail.com>
 <338daebd-b4af-4a0c-951a-ad7f86dc4646@gmail.com>
 <CAHx5RXAOKBGXRgC8pqEyY3MZGXxj0-vrwnqg_WZqKreYp18dAg@mail.gmail.com>
 <7efffaa0-6330-4b01-b3d2-63eb063cbbb0@gmail.com>
 <CAHx5RXD8qFmbEytrPcd40Pj0VRo7uOvZjucrMj6Xxqw73YyS1Q@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <CAHx5RXD8qFmbEytrPcd40Pj0VRo7uOvZjucrMj6Xxqw73YyS1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/13/2024 8:45 AM, Stephen Langstaff wrote:
> On Mon, May 13, 2024 at 4:40 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>> The Makefile has this:
>>
>> obj-$(CONFIG_FIXED_PHY)         += dsa_loop_bdinfo.o
>>
>> so it follows the value of CONFIG_FIXED_PHY, what is this configuration
>> symbol is to in your kernel configuration?
> 
> CONFIG_FIXED_PHY=y

Then dsa_loop_bdinfo is going to be built into your kernel image, and it 
will register a mdio_board_info structure which will create fixed PHY 
devices and it will assume that the DSA conduit network device name is 
"eth0". If this is not correct for your system, that needs changing.

What are you trying to achieve? Can you be a tad more verbose about what 
you have tried and what is not working?
-- 
Florian

