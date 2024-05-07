Return-Path: <linux-kernel+bounces-171207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E938BE11A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A19D1C219CD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45532152DE3;
	Tue,  7 May 2024 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBl2uF0W"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA5D152188
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715081996; cv=none; b=MDtTDJqVCQgHSlMa4pHyHimdX0CFsP+OIJESndnVWZPexQMtjoohi3K6ivy6nu3GFanZRhpH2OrQpTo1MFFWncSFAwmtjSpIgHecIe5xRw+zkvoLe2IGno+nT3AloMLy+R+Is511InOfaKkYSds7J8mnvTLDVGoAuPDSCaHw8Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715081996; c=relaxed/simple;
	bh=P5uLisXOuxBxifYghRn6YmN4fZZN3pN3vNnX6Ki7prY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btAPRbTdLfNSfJjpcvZ+jTXnXe7xLcv4ZRxKfBHDTSyfXAq4dWeBaBEFZbrJfO0NChXndTkgEf0iU+ZFJRoAMp09EQzx7uoeVwCGSQcv8qgKND8mcCF0aWSDJtk8WkN5OekW8uS6N7Ae0mF1CQrUHBwJUxHudMQi1PoSKw1U9wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qBl2uF0W; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f17ac14daso3269678e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715081993; x=1715686793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQc6eSsksX0o7pSNc/57Q6qum3aXB90lj21OWn/LIWY=;
        b=qBl2uF0WstfrsnI66bWBcYYLteYrKMeECLMfRN0cVEbGHN/21bu6ZKH3pvJAMyYcor
         CVO61eJNiKr/XKrooMSobCkEpoot+bSKxqCrtcMktry012Q2X9qxK5jBcHLcvH3MmwXB
         bPcRm62JetchpjOySjTa9VdZTADrvrRARmDvdv/Yv2JyUQV+J3ljkO6GOA3i4SYHKWhG
         x/3HBjhvctbz2TsGoHBN6gkf/vgPZAniue7F5dIEwMRm7/G5THlv/xHTPP5c2wEak3eS
         689TmALkXfpEIz7sHoqyzKkC3JesMbCD5W0BkImfnT30yud3fLyD2SNi8AcjkXJLS0JH
         CRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715081993; x=1715686793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQc6eSsksX0o7pSNc/57Q6qum3aXB90lj21OWn/LIWY=;
        b=rrrNAdqp/R/s7MxOT4FGajNS6PK0q76j9H1Et6IlpmrP7dkVsvaIu8af0DyVTZui/H
         3J6UUvCk/D2mfg8KpcR+qH0l3kOKcmozAThbz8OgG3nke+uiBuexUMOqjzihbCWTWmyT
         QFa7XkeH2YO9c6JsrF5N9satnhpQKqM8kaP7ULg3HOERSOe2PxdEZq9Glxmg9W0yzddq
         DzrzqH7bpQZZyOnBtmRp+rnro6WvbV+g+RRzxnrrXWbAM/dvmR200U3WkHFwDwlCx10M
         mVH0TWRm3u0MCQprOhNeOSZ80w6sRYYYphcXlr6HVy67fn0eo2Al2O7eDJkPhRZOOQrS
         yY5w==
X-Forwarded-Encrypted: i=1; AJvYcCWDZlqz6pf1jnKclEyVPdJqDB67BybfgpDU0rqi7O5iIBKwk40GPMDBrQqrJICv6IWLiWWEnSi8a/ZSxVFcA0XlWOWTI1EGJg2s4ooi
X-Gm-Message-State: AOJu0YwTGz9xMhkpIEhzg2ODFiTWJ40xtuLHDyj9jzw9pGVrKxrZxztH
	VyvjV3WNW3IF49XyFnfocSFiG/fhj+7dCX1XZe5hp64T/2V3xm4dfBpF/zPbU7c=
X-Google-Smtp-Source: AGHT+IEQl+GcEsxQFRjcV6Q20fwLgSVV2rorfeOoqBlHfFGwibG/eWjdLeSZi4NLB5VFWaqx9bzyBg==
X-Received: by 2002:ac2:434f:0:b0:51e:f68b:cc69 with SMTP id o15-20020ac2434f000000b0051ef68bcc69mr7614847lfl.5.1715081992635;
        Tue, 07 May 2024 04:39:52 -0700 (PDT)
Received: from [172.30.205.144] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a14-20020ac25e6e000000b0051f95499c06sm1772483lfr.285.2024.05.07.04.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 04:39:52 -0700 (PDT)
Message-ID: <247e4ce7-1ba2-43b8-8a11-ec70f99a4fc1@linaro.org>
Date: Tue, 7 May 2024 13:39:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] slimbus: qcom-ngd-ctrl: Add stream disable support
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>, andersson@kernel.org,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
 quic_anupkulk@quicinc.com, quic_cchiluve@quicinc.com
References: <20240507063004.21853-1-quic_vdadhani@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240507063004.21853-1-quic_vdadhani@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/24 08:30, Viken Dadhaniya wrote:
> Currently slimbus driver doesn't support stream disable
> callback, it only supports stream enable callback.
> 
> In slimbus usecase, client is switching to new frequency
> with same channel and calling enable stream callback for
> new frequency but DSP subsystem is crashing as we are switching
> to new frequency with same channel without disabling stream
> for older frequency.

This is very difficult to read

but AFAICU comes down to:
"Trying to switch frequencies without closing the channel results
in an attempt to re-enable the channel without a clean shutdown,
which then leads to a crash on the ADSP."

> 
> Ideally, before switching to another frequency, client should
> call disable stream callback and then enable stream for newer frequency.
> 
> Hence add support to disable stream via qcom_slim_ngd_disable_stream().
> 
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---
>   drivers/slimbus/qcom-ngd-ctrl.c | 70 +++++++++++++++++++++++++++++++++
>   drivers/slimbus/slimbus.h       | 13 ++++++
>   2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index e0b21f0f79c1..d952827d2e12 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   // Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
>   // Copyright (c) 2018, Linaro Limited
> +// Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   
>   #include <linux/irq.h>
>   #include <linux/kernel.h>
> @@ -1084,6 +1085,74 @@ static int qcom_slim_ngd_enable_stream(struct slim_stream_runtime *rt)
>   	return ret;
>   }
>   
> +static int qcom_slim_ngd_disable_stream(struct slim_stream_runtime *rt)
> +{
> +	struct slim_device *sdev = rt->dev;
> +	struct slim_controller *ctrl = sdev->ctrl;
> +	struct slim_val_inf msg =  {0};
> +	u8 wbuf[SLIM_MSGQ_BUF_LEN];
> +	u8 rbuf[SLIM_MSGQ_BUF_LEN];
> +	struct slim_msg_txn txn = {0,};
{ 0 } is enough

Also, reverse-Christmas-tre, please

> +	int i, ret;
> +
> +	txn.mt = SLIM_MSG_MT_DEST_REFERRED_USER;
> +	txn.dt = SLIM_MSG_DEST_LOGICALADDR;
> +	txn.la = SLIM_LA_MGR;
> +	txn.ec = 0;
> +	txn.msg = &msg;
> +	txn.msg->num_bytes = 0;
> +	txn.msg->wbuf = wbuf;
> +	txn.msg->rbuf = rbuf;
> +
> +	for (i = 0; i < rt->num_ports; i++) {
> +		struct slim_port *port = &rt->ports[i];
> +
> +		if (txn.msg->num_bytes == 0) {
> +			wbuf[txn.msg->num_bytes++] = (u8)(SLIM_CH_REMOVE << 6)
> +							| (sdev->laddr & 0x1f);

Add a #define and use FIELD_PREP

> +
> +			ret = slim_alloc_txn_tid(ctrl, &txn);
> +			if (ret) {
> +				dev_err(&sdev->dev, "Fail to allocate TID\n");
> +				return -ENXIO;
> +			}
> +			wbuf[txn.msg->num_bytes++] = txn.tid;
> +		}
> +		wbuf[txn.msg->num_bytes++] = port->ch.id;
> +	}
> +
> +	txn.mc = SLIM_USR_MC_CHAN_CTRL;
> +	txn.rl = txn.msg->num_bytes + 4;

Why +4?

> +	ret = qcom_slim_ngd_xfer_msg_sync(ctrl, &txn);
> +	if (ret) {
> +		slim_free_txn_tid(ctrl, &txn);
> +		dev_err(&sdev->dev, "TX timed out:MC:0x%x,mt:0x%x ret:%d\n",

Please clean this up, add commas to separate all three prints and a
space after each comma

[...]

>   
> +/*
> + * enum slim_ch_control: Channel control.
> + * Activate will schedule channel and/or group of channels in the TDM frame.
> + * Suspend will keep the schedule but data-transfer won't happen.
> + * Remove will remove the channel/group from the TDM frame.

"will" suggests these are not immediate.

Konrad

