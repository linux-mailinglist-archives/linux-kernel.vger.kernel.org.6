Return-Path: <linux-kernel+bounces-308341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D50A5965A88
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC321F24850
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F234A16F26E;
	Fri, 30 Aug 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="vJLcx0aX"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3BB16726E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007066; cv=none; b=FgmW8xyY3oq7spdJGImiloQBP5eQV+x4MGvn1x4P30iNk3dRTLk5g9JyiPFh9KsagZKw4V2FOwAObAwJM1wU1HwwvNsHO1KG8xe+b3SV8a75w0+kksLzw/7kgLF/0JBINQUUVpmt9RmgecMl0hxC8F7JYfSBV8WnRef4AbjA7YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007066; c=relaxed/simple;
	bh=ghVIUx9TaJyMm4SETqSo3lqEOUOm5837gqrdXGcmX9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEEPxt78NTSqkkhRsXEmzKHdMpdBexa3XbOpNk6T/8XmD6ixmtx1o3mRN3g7OAzqF3pGglXHh2264D9fWVIshLf6i6jtOJfokk2Z22bUmjVTXAjTL5fWyHWEgrHhRgp9LjXSZnl3ZwaKpGAPJ/5GYM5jUR3LZef2WL96ZhrDd/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=vJLcx0aX; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c218866849so1861742a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1725007062; x=1725611862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tz5xgDVzbjElSEwTue+4JQ6a6tFd6FbY1QoSeaQ1ceo=;
        b=vJLcx0aX1ng52gTR8fxVouBeYaI7CRVJ+/pM53CpY/zwa68XMNfj5y8042L1mdruyw
         9r3zhrGeUqm8oYxln9dDEtZfUNlBlMcjLyF8fBCLuoloct6Zxow6HdMl3PQh4hOv3R0P
         CfvJfCWkLzFOiwNMay04j9z+9Pr6LUjlpX/nzJ9cH7tBxOnuMXwFEGVvmMpEyf3euHaL
         CSS2rd3MAcWvqdQAdDYU+yfEm0xnxo3Mghnd/Wooywt3jvB0g+11s5mPTNXchm8AXZ+J
         lZ4mqSQWGK6L4bFazyzwycvJMJz1T1WHhcYKgDvd8OPAm5Xz1O6dqYJ7yBah3xLmS1pb
         zjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725007062; x=1725611862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tz5xgDVzbjElSEwTue+4JQ6a6tFd6FbY1QoSeaQ1ceo=;
        b=KKc9eqBtW3cfi2DuoZZ/8CdDtLfmQVmfG7aiL48LIRVPPbid8BLI7aJTEevL4EdrOT
         uxEx/r7G+XYjYhprw1LB3OBEqyTCoOE5nJROZ6GcxyDSpazsTzphN4FeDI+97RuJSZ2z
         8s3xOk1a8ny7WYMxIXfliLMNqzSmhiqCHoF/l1CsKBa31TQ0uouPkmCusSysHh7NPZQP
         fmb3FwAmc2l08OFZuP58hbcdl0I+FSeFFv/ZWqvKBYB1QCTMVoyya4sdegVaHwjWu9wH
         2yLw9KuDqeltMI1/ux8ZwWLVK686fsNR7LWeWw8fZUo/FHZiYD+yfhGRhPAFM/p9Qo0F
         G4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1J+5Una2LM+F7eWAXaQkWr8sn7Q9ffKSIT2/KQ6WNCkBEB8j+N/QDkvFcIUSC8PNRdzKwA+6OODubvMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeU2fNLSbwSsTdPsFHjOuHphHPjFfNcL2pSEY2a5Ok51FwY4Rk
	fIdHOBGot+YC8y+vI8MBILhI3E7lVL0Nju1IqnJChrfiA3fjyTiu+m3YMQYh9R4=
X-Google-Smtp-Source: AGHT+IHoWfq/90PKtaBCC6Uhi6DqQ09Ism7NBj8fzh8R+arnT/DKgjvjTl/SHIkJT75B9ohmJj4xBw==
X-Received: by 2002:a05:6402:3493:b0:5c2:2b1f:f757 with SMTP id 4fb4d7f45d1cf-5c22b1ff81dmr2599958a12.17.1725007061676;
        Fri, 30 Aug 2024 01:37:41 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c7bf90sm1674423a12.43.2024.08.30.01.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 01:37:40 -0700 (PDT)
Message-ID: <0fcd3421-8086-44bc-b24f-7fb2262a675c@nexus-software.ie>
Date: Fri, 30 Aug 2024 09:37:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: codecs: lpass-va-macro: set the default codec
 version for sm8250
To: srinivas.kandagatla@linaro.org, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, amit.pundir@linaro.org,
 dmitry.baryshkov@linaro.org
References: <20240816091210.50172-1-srinivas.kandagatla@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20240816091210.50172-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2024 10:12, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> sm8250 and sc7280 have lpass codec version 1.0, as these are very old
> platforms, they do not have a reliable way to get the codec version
> from core_id registers.
> 
> On codec versions below 2.0, even though the core_id registers are
> available to read, the values of these registers are not unique to be
> able to determine the version of the codec dynamically.
> 
> Add the version info into of_data, so that driver does not need to use
> core_id registers to get version number for such situations.
> 
> Fixes: 378918d59181 ("ASoC: codecs: lpass-macro: add helpers to get codec version")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Seems to be fixing the reset I've been seeing on rb5

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


