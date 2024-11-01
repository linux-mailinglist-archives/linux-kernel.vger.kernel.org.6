Return-Path: <linux-kernel+bounces-392088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D13C69B8F89
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62667B24F02
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C421A0AFE;
	Fri,  1 Nov 2024 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSsNuvOC"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8271A0724
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457582; cv=none; b=rbyLYVf00MzjyxotSzqMybB1oL3oO/3V+L0lVtkqOdu31jPSRAAz71gQjHMgjfJlWum6NU3TKvd1BRD2NTMhO1NTpNWGHUd859fsst7evqgvyZF6pD4+WcS2Zzkx1QJFacl7AbhiYA+Ci5L5bfn2RRapCVaAxczRJCrdaHXDG1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457582; c=relaxed/simple;
	bh=nIWiBwHnkqzLYf7olD7gqFwtSd6ENgt+tj/vqI3johw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShjZFK32XaaiwDYVw7518//UF21Me2eEqELlk8dkoygtIfzdJ+Cq4x5wymUX5034s4jC3a++w2Qrjul3e+XjrySTcNvB9Nx9qbk4BudY4CA+ALwMUVcn99aEEWBL3VR6iB+bvRsXAbdX3isOrVqFB0CfcVF3KvmHyLJ4jDCeOsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CSsNuvOC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43152b79d25so16418535e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 03:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730457577; x=1731062377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpA6oZQuCmloruRIu239MJgRSbmWeTtcRHZ1zdEpTxc=;
        b=CSsNuvOCZphaHsCblUXB52RgpMZi9QtIGqkIAw3dtKWBpk/mSu5RQXaBGn1SbCCMof
         JVR47iAiQg8xMtHs38rpZ9pffcmH6V+G3tbZ21cBnRo8vZnYBB6ayfCGRHKBqSCjdwuV
         kAavmya0nZ5l/BkMOQnzRcB4Ev+wvDWFkW0QvvdxRPl8QJcVfz19ME8oLFI9jG+n848X
         b1TXClTSyAtM1neeqfchTGYtsqt6M/TaaIAQ5G3XV2wG2FNZ/sMdPLbkJ31RqtdVmRuX
         uBC4HQDEU3Xp4ht/PdbDiCbl2a/h4yEeRMg/jlp/prRLiGdFii6DVHiN1qu7Zw/JNUOI
         se/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730457577; x=1731062377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpA6oZQuCmloruRIu239MJgRSbmWeTtcRHZ1zdEpTxc=;
        b=qYw5SsaHtRB93vvGqZSktP4yq5IxZaaealQBY6dol2AdjDmULopI61MegxG256uc/P
         lgAzG513OAHhwh7KXY/i55S6tfAIpucbzaX4nmlJu+lFrX8Ywrx+hV8z705q7zCtBo4+
         2cCC422nVYRYxNhPCOgNWxWfPEeSYa2o00/Mpbp5ZpiwshP9SWJ+sYYTPlbHxUyAa+XV
         KH+ypvG8IrV/37s1W9fTRl9+6FJglXo2V/ZUt9iOX/sxdHG0YSWwV3Q+FDlT8g0kdnV1
         FpLXHytvR2jhdY3X5CGbjIvIr4274uwDk0r40uh60M0tjbTpNJiM/sO7Dyg6IGctTLIK
         Icxw==
X-Forwarded-Encrypted: i=1; AJvYcCVNiHUgJ1OV87nyVY/EERzS4gg/Cz5OKH2AfHqmTNQVmVz4+mQIKwXau8APcEfw4VAeuN9FrFqsf10uiRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1EAG4GYs1J4ey95LqlD+QsFW2M4/jerl6Nb7x4/2NeXgJFnxh
	0dhBD8vI6ow4YQBKObehcbPOJK80z9heBFcFQ7ALl8TwPt7sv7rAjQfw7LB1uI8=
X-Google-Smtp-Source: AGHT+IGUUeraI2AHPHyOxMnlI92HlBbXuqTgbdxId0qtgQfqlUmT1WHhFGv8dsxR7gHrSyAPOAzU8Q==
X-Received: by 2002:a05:600c:3c8d:b0:431:508a:1a7b with SMTP id 5b1f17b1804b1-4327b801250mr57559765e9.34.1730457577384;
        Fri, 01 Nov 2024 03:39:37 -0700 (PDT)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5ab305sm55854545e9.7.2024.11.01.03.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 03:39:37 -0700 (PDT)
Message-ID: <a2c7d55b-bdaf-4cc1-a653-b398952219f2@linaro.org>
Date: Fri, 1 Nov 2024 10:39:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] media: amphion: Fix pm_runtime_set_suspended()
 with runtime pm enabled
To: Jinjie Ruan <ruanjinjie@huawei.com>, sakari.ailus@linux.intel.com,
 mchehab@kernel.org, ming.qian@nxp.com, eagle.zhou@nxp.com,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
 shijie.qin@nxp.com, hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: chenridong@huawei.com
References: <20241101094050.2421038-1-ruanjinjie@huawei.com>
 <20241101094050.2421038-3-ruanjinjie@huawei.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241101094050.2421038-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/11/2024 09:40, Jinjie Ruan wrote:
> It is not valid to call pm_runtime_set_suspended() for devices
> with runtime PM enabled because it returns -EAGAIN if it is enabled
> already and working. So, call pm_runtime_disable() before to fix it.
> 
> Cc: stable@vger.kernel.org
> Fixes: b50a64fc54af ("media: amphion: add amphion vpu device driver")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Add fix tag.
> - Add Cc stable.
> ---
>   drivers/media/platform/amphion/vpu_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/amphion/vpu_drv.c b/drivers/media/platform/amphion/vpu_drv.c
> index 2bf70aafd2ba..51d5234869f5 100644
> --- a/drivers/media/platform/amphion/vpu_drv.c
> +++ b/drivers/media/platform/amphion/vpu_drv.c
> @@ -151,8 +151,8 @@ static int vpu_probe(struct platform_device *pdev)
>   	media_device_cleanup(&vpu->mdev);
>   	v4l2_device_unregister(&vpu->v4l2_dev);
>   err_vpu_deinit:
> -	pm_runtime_set_suspended(dev);
>   	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
>   
>   	return ret;
>   }
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

