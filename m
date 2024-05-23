Return-Path: <linux-kernel+bounces-186966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B798F8CCB4B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74051C20C80
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA0F33997;
	Thu, 23 May 2024 04:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H07uzoty"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFAB33EA
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716437402; cv=none; b=SJybN5f6YLRpfZNIUqepnhrrUOtEgT4FE2gxAnPn1WE9MbFjBsb79ObH71iYsPvFXIVOSqn9j8bRWOADt24ozkeK7h46s3bYYN7YTjhn0WuBDsiwPGwi+F2pkiuuXKkBdejDWIXna4CCK7vDHRpT/OyYxHNbbIRr3UnScqVxZbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716437402; c=relaxed/simple;
	bh=6Qsfgxn0ZtZxpVvIBFFX1mQlHeNqRm+EvO0tyESQalY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dndvmF8TfPPk3r5egfUvGOlA/axOl8XBohDcnhfvHAF1JeW9nnM+a7tK3nWxL2n6kSkQ9/zOAfsg8q3Cgc3o/qHocPkBUBnDDdkuYkBhkePsREZNoRiuolZ+DOYjAG8qxz8GTSl+cwW4taSs5LSarwVpoQ4ftWH8TIl/oC/NrOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H07uzoty; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f32a3b9491so9649995ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716437400; x=1717042200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKSyw6WGP8oc1c5/355QNnMu26FbGL5V8Gm62pHtX8U=;
        b=H07uzoty6tzz8ejyaKh1LYcRVNZ8LWVTsfq27Q8rBTNMX9HMwSYzoayz/0Ia8MPzWk
         uee5Srwx3IqYPmLhfWHG6Y2ivOQGXXrdUfh41WWosBM1cuHo2rXCcpnECczzy/leTw8r
         rmmOkD3OQqY+awnsa2kOZuTqmuz/Cjh4oEZj0gcpVvuTclmY8T9KSpqWS45VVKopCvll
         HTGHV1QEC5nz/zNSEXqtMUrsTGkyrnPN+oXU6UexawF3e8kYu6as6n+95xYvyFOIPL8R
         I5hgQpmzo+aHwGQo8UBOq/4Q2WQhhK+RwZjdBAsh3cRJMbxSOlzJMJHZxs0HBKyj/94D
         X/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716437400; x=1717042200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKSyw6WGP8oc1c5/355QNnMu26FbGL5V8Gm62pHtX8U=;
        b=nUwJakBo8P6A40ViVhaTCZei05d21kY7zQ+4gAiP1WJAh5gBmzi2ugzxfofi8GIRgJ
         Z5j2hbc3e+e8LfpVXhboi8kWjrGFdQ1OruvXRHbtXCblA4QtoP6dA/Kfp9SEOTs6TFd7
         a9I0sqKHjT94QRxv/ohYC+cPOCQVuEGgfuIhAhmXrVfTvJI//nLwYx/P9xVb5sttK0p2
         k+1hbxt8c9JACxWOswXKz0gAw/dVoP/IXsQsj+SfcpQR9yMyMFPRXcAof2cSrv5w9S2e
         RifUttNc/thEslmHSfSSaydiTHQ/fekUImOB6EpA/1hmfxMurySpjZ5JqW/Qag1RygG8
         Iapw==
X-Forwarded-Encrypted: i=1; AJvYcCXPSpAymJghlOl/8JB7lotfqNduilAYf2sGCKRCn6V/Im7hc1KZWnB5j24ypEaHgTPAnsYEDRJwAxuxxSHRAGIOLPoz/IijjyL7e6eb
X-Gm-Message-State: AOJu0YxKSnuO8Bk+lLjLbCRyMhzH+AFu3ET80hiS+KnPB2UY9C6zZI6o
	WTiFmi26lURSRpQOMiYnAMFhYwpMh5IyMip94KHvx8gueAkqfffA
X-Google-Smtp-Source: AGHT+IEQwG0Ah8JNIp+nts9Fmu4aOOHwzYGESz0lsmxX20hoewkxC9gHhtTDM/PwZ/pCJm20EjLhtQ==
X-Received: by 2002:a17:902:d4c3:b0:1f2:fab6:294 with SMTP id d9443c01a7336-1f31c9ea3e1mr42062845ad.56.1716437399762;
        Wed, 22 May 2024 21:09:59 -0700 (PDT)
Received: from [0.0.0.0] (42-3-109-144.ptr.netvigator.com. [42.3.109.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f3356bf498sm8083705ad.191.2024.05.22.21.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 21:09:59 -0700 (PDT)
Message-ID: <dd14e3ff-3ff7-426e-88e0-b16a49eafaf0@gmail.com>
Date: Thu, 23 May 2024 12:09:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] ASoC: qcom: display port changes
To: srinivas.kandagatla@linaro.org, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
Content-Language: en-US
From: Xilin Wu <wuxilin123@gmail.com>
In-Reply-To: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/22 21:43, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patchset adds support for.
> 	1. parse Display Port module tokens from ASoC topology
> 	2. add support to DP/HDMI Jack events.
> 	3. fixes a typo in function name in sm8250
> 
> Verified these patches on X13s along with changes to tplg in
> https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/tree/topic/x13s-dp?ref_type=heads
> and ucm changes from https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/topic/x13s-dp
> 
> Thanks,
> Srini
> 
> Changes since v1:
> 	- Fixed unused variable warning.
> 	- fixed warning 'break;' to avoid fall-through
> 
> Srinivas Kandagatla (4):
>    ASoC: qcom: q6dsp: parse Display port tokens
>    ASoC: qcom: common: add Display port Jack function
>    ASoC: qcom: sc8280xp: add Display port Jack
>    ASoC: qcom: sm8250: fix a typo in function name
> 
>   sound/soc/qcom/common.c         | 29 +++++++++++++++++++++++++++++
>   sound/soc/qcom/common.h         |  3 +++
>   sound/soc/qcom/qdsp6/topology.c | 26 ++++++++++++++++++++++++++
>   sound/soc/qcom/sc8280xp.c       | 14 ++++++++++++++
>   sound/soc/qcom/sm8250.c         |  4 ++--
>   5 files changed, 74 insertions(+), 2 deletions(-)
> 

Hi Srini,

I tested this series on SM8550 with tplg in [1] and ucm in [2]. But the 
kernel output errors attached below. Headphone does work properly 
without DisplayPort in the ucm.

What could be the possible cause of this? Is there any significant 
change from sc8280xp to sm8550?

-- 
Thanks,
Xilin Wu

[1] 
https://github.com/edk2-porting/audioreach-topology/blob/sakuramist/QCS8550-AYN-ODIN2.m4
[2] 
https://github.com/strongtz/alsa-ucm-conf/blob/odin2/ucm2/Qualcomm/sm8550/HiFi.conf

[ 1552.313713] qcom-apm gprsvc:service:2:1: Error (1) Processing 
0x01001000 cmd
[ 1552.313730] qcom-apm gprsvc:service:2:1: DSP returned error[1001000] 1
[ 1552.314455] qcom-apm gprsvc:service:2:1: Error (1) Processing 
0x01001006 cmd
[ 1552.314463] qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
[ 1552.315496] qcom-apm gprsvc:service:2:1: Error (1) Processing 
0x01001006 cmd
[ 1552.315506] qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
[ 1552.316033] qcom-apm gprsvc:service:2:1: Error (1) Processing 
0x01001001 cmd
[ 1552.316042] qcom-apm gprsvc:service:2:1: DSP returned error[1001001] 1
[ 1552.316045] q6apm-lpass-dais 
30000000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to prepare 
Graph -22
[ 1552.316047] q6apm-lpass-dais 
30000000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC: error at 
snd_soc_pcm_dai_prepare on DISPLAY_PORT_RX_0: -22


