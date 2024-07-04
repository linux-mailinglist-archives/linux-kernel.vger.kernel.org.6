Return-Path: <linux-kernel+bounces-240692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A292710E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680811C232ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB811A4F06;
	Thu,  4 Jul 2024 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MwsV5FcE"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E41A38E8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079881; cv=none; b=uwLvjwcaeDkr1ZUg5zKXyootMpSlmjTsu4X38Wyb1s1NyYAmq/nPsBqvsj2oNIzI+wy2ck3IXNT33kX7ybgqKcHmKvJ3W47F8+zAKvugWYJQ2Xdz3LsOvcTfMKU7irPpBVXNEL9uaMlA3wLjkP/apPUwNgmVKIbJVYSBMcQm3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079881; c=relaxed/simple;
	bh=UGMJ44RQRK5L7aXCmLcCVD3t3Ew+7rZXgNHMCelmG4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCwnz7auCXG6jkRhj4YYGgZ1+GJNnN7Z/c2Fl9RdNFT44ICet20YyRsop6bCPEOFnBP3aRk4nj7Zjn7l/ptodX5zKLAqcIXpeENfTsX3i36f0gW8h8Q8HIta8pej2eMK6kn+YOuLFuItAAexQoQtFHCPAfyw9nL/yVNWpedpXVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MwsV5FcE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f06861ae6so212580f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 00:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720079878; x=1720684678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yh+wWDEWyvWxK+Dc2ccAVMOd+nezcfUI+rK+tEbS35s=;
        b=MwsV5FcExI5ZVPlVgKEcePwkYok+WfzdvNtwPkvHmvo8Z+xoG5hA0cs3BpRVw1xuf5
         88D23HyHCcn0PQyC9/wmqqdsgajtk2eTfHIV+CltYNUZFWurZrvOkY+ZlmdWgNKpp+7F
         iSvDtJeXNbB7vU7VZEH2PPLxGec8wUo0X2saav5lpatRJXqPj85sw5EN4wsFNOCYt3ya
         h/UBgy+x0fuSij329hqJcgWBau2BLi3ZPX/D7gZxChtCo8L/9MXlLPUZnIlRjnT6Gxmj
         4Nk2sY/Ts2XexPX3v7t1Z/KjkZbPsMo8aA4Ca3PsKoT04ijKZd9L6Dxk8JZFdb1DkxJ2
         HEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720079878; x=1720684678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yh+wWDEWyvWxK+Dc2ccAVMOd+nezcfUI+rK+tEbS35s=;
        b=nghDKMvLvT2FvlkPnBwPdTwNOAQE11Jx5NzWlIQuehvKjOPhNnSZYmfsmh3MQSf5R5
         jqKhDJKcsCMcPgGwvyHoFeLukLBjYqdJTAd7QjLGe7cxf3cRRvpDE+Op9tFRtLM/IHWY
         iBbP97C9mXnJRaTRHnsho/V8HowKJm2ixrzcDTRJAoWVqM6cMnlcBnt2TVkY9HtpDY3e
         cljJ21F2/Bl+yaRj+e4MyAb8sLVXKV0nNqtjFasrfgV7yK2U7/GccZjNe+rEFn1GTHNf
         p1By1BUZb/LTnGLBlR/VYHw+nmRZqG80Y7m/b6CptdLA9wVGLxHUKtDjrcC4cuKsulbF
         1A3w==
X-Gm-Message-State: AOJu0YzfwMLwVCsEW4z1U/SbRZObUjLBt38RdcenJdc7yDPYUMrbn2HB
	K+DENzZBiPs0ThwsfWHYBomqe23wgTPCbUD+h5Y40XfypDk66rPXTmDggQpxOomWX15aDdJ/I9g
	C
X-Google-Smtp-Source: AGHT+IHfWjqPwEJhWwd/bHs46j5WWXDlgt+XZ6rBtRnO7nRiiCBSFw8hpTuo6iaafsU3L46ZlgLJCA==
X-Received: by 2002:a5d:5489:0:b0:367:911b:ff6f with SMTP id ffacd0b85a97d-3679dd29485mr583989f8f.18.1720079877647;
        Thu, 04 Jul 2024 00:57:57 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3678ec6ff64sm4952189f8f.3.2024.07.04.00.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 00:57:55 -0700 (PDT)
Message-ID: <50390ee7-20df-4be1-9cda-639981bf4ca7@linaro.org>
Date: Thu, 4 Jul 2024 09:57:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: neil.armstrong@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <2764814.mvXUDI8C0e@rjwysocki.net>
 <2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org>
 <8d91a3c1-018f-495b-83be-979b795b5548@linaro.org>
 <12c5c133-9519-4a26-b9a3-2da1d3466e94@linaro.org>
 <15b67ce6-3238-435d-ad28-7c06efbe9153@linaro.org>
 <ce6c2e8a-65a7-4cb2-a91d-fbcaeef6edc1@linaro.org>
 <0c4b401e-86b8-4169-af88-475433012d67@linaro.org>
 <636922b4-96d4-49cb-9020-2359e7497f56@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <636922b4-96d4-49cb-9020-2359e7497f56@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/07/2024 09:39, neil.armstrong@linaro.org wrote:

[ ... ]

> OK I just found out, it's the `qcom-battmgr-bat` thermal zone, and in CI 
> we do not have the firmwares so the
> temperature is never available, this is why it fails in a loop.
> 
> Before this patch it would fail silently, but would be useless if we 
> start the firmware too late.
> 
> So since it's firmware based, valid data could arrive very late in the 
> boot stage, and sending an
> error message in a loop until the firmware isn't started doesn't seem 
> right.

Yeah, there was a similar bug with iwlwifi. They fixed it by registering 
the thermal zone after the firmware was successfully loaded.

Is that possible to do the same ?

> I think Rafael's new patch is good, but perhaps it should send an error 
> when it finally stops monitoring.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


