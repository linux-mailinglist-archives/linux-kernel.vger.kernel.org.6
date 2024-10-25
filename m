Return-Path: <linux-kernel+bounces-381609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDA19B0184
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A581F2299F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94879201012;
	Fri, 25 Oct 2024 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCrU+ewX"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1773E1B2188
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856592; cv=none; b=MTAKGIrzWB0tFmlDFOs+tGU7jE0Gq+k3GPJB9AK6Szn5ssBJYArtbpISu3oE6PTSrUjlqC/OoiF1Xx2AypqJw06/z541v8eiWVFVKl+3jnfx/cMvOd1Sk33NeU/6ZjwBd7nwE4neeBQaRDtLhjTuyv3qHNYopiWGY6FiG/erEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856592; c=relaxed/simple;
	bh=dLL4ahqzUKxR6agX8+HFa6SShQuUowH/qJPqMkAE9A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTod3EFmnlC6Frbla3aiLHCOh7zY63p1gpJsqYArQH4FOVoRZ3iY2td1yVmcAbySmCuAz/vHCvaQWJB6kJA/7vH2KeO0D51e4Z1yUajlAhz6HOcD5quoE1JQ/bRnTWtqe5lqmauSY4+dy5FoNvceOvl2kgAIB2hS2yeBf4OVAd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PCrU+ewX; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so2771829e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729856588; x=1730461388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lkwa/uwgAWWaLzii09tP4AKS7OhoCI/F52eSmD068CA=;
        b=PCrU+ewXo2X8n8QDZ0+oLrciI8Wf6w6WCavlKuF3RTQTd/pogNXJ2rBs9nY/SLxXcY
         es+ye/qwl92exQnFDqr97s7RfqJCB2kee+/3M73SYOXRsv695IZ0MnENJxPCwD9+IbSq
         D48xMeaWKv7SevISKNr+LA0smKNXmcKc9X6nvWGd+e9pwq9960doWGlCX9WJMhNGifUV
         zlfA+700iJ6yNaxmsY1MAO2N2q6wmKWp01ckp0aKkJ8c+Dts7dCibXzIAlsRCEql0Wm4
         A2wUsfR1arpcgc5yS/3An9BHMyPX55STD3P5syhE8HYYA6tNTcovEqUnCipm5BgnRIfy
         T6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729856588; x=1730461388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lkwa/uwgAWWaLzii09tP4AKS7OhoCI/F52eSmD068CA=;
        b=SNpxyicPMuhNLhTXTw4xDnX4pr9XI5eUKWU82MRhMjkfOAYsp++T+vzzikVEBtSxEs
         /TUcxxB92muvdh9in36PHX2p8d8FGGXsKE5QTSefeolxQlUWJDubnPOOGg1X4ouNNFKx
         wumeE8wh6G+WK864ADrp6RGRS0tsCIU+MR7UKyZhfHwnDz4+M8UBxF7p0kOWEyLYsQUV
         TohnQuY4X1Ny+3FsppWq+mPWvLNQW9Evyj4TISotdWH7RYVRNJqYDrUWtJTxi31XlyW8
         21NsyzDtQbyFBKagEZRvULXbGmIR6PdFE5z/xotJdLAvcJKGoswJqs4q664Tns/B45QM
         CT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXun+NPsQDs987NuDeXNt749qTQ09Wz69hZrOWHpfmQnRdxTa+zzdKzlN7DLZplcT9ebrnaKYTuETIFpkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyM2g4p0H7TaiHniAu2ku97xb1h1o/9lBqiZZ2AAlBvlgTKsQC
	Gvnskl0dCIOOAgvI4whkTH7WhE0JWveKI126Qm9ngjvdyEoowKkZYoLX7Z+LUEw=
X-Google-Smtp-Source: AGHT+IGO2B2RlrXi4ESPDHZX/+LkdhTMKvGo4OGC8L/poqoUjErvBRXR7tgvLlkobft4kOBMEr1vMw==
X-Received: by 2002:a05:6512:689:b0:534:543e:1895 with SMTP id 2adb3069b0e04-53b23e85245mr3020933e87.39.1729856588217;
        Fri, 25 Oct 2024 04:43:08 -0700 (PDT)
Received: from [192.168.0.87] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f50csm45402555e9.17.2024.10.25.04.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 04:43:07 -0700 (PDT)
Message-ID: <f5a8c042-53f5-43e2-bf76-82243ec77ee2@linaro.org>
Date: Fri, 25 Oct 2024 12:43:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 3/3] media: venus: factor out inst destruction routine
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241025105104.723764-1-senozhatsky@chromium.org>
 <20241025105104.723764-4-senozhatsky@chromium.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241025105104.723764-4-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/10/2024 11:50, Sergey Senozhatsky wrote:
> -	venc_ctrl_deinit(inst);

Shouldn't you be dropping venc_ctrl_deinit as you have done with 
vdec_ctrl_deinit ?

---
bod

