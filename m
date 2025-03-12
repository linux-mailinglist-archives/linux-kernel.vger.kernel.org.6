Return-Path: <linux-kernel+bounces-557743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF95A5DD22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C066189C7D4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E1824339D;
	Wed, 12 Mar 2025 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abIqVSFX"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677327083C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784095; cv=none; b=HFuVbK3nSa2zKlyTL18M6ezV7saM68K+BpKXWrwLXkDyptKVu8D6BhY/Lri27cseQ46WXnFm6Ea/xwZ5k8SVZAH2aj/64prg9jI590ViGaF6IdvubjR0oMtBweD/MUgGHtog4Ar3Yr5mTWS3Zlg3ChFIcB2CFTI3r3qUUQSGl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784095; c=relaxed/simple;
	bh=V1MjBxHePlfd7OLavw5mLEK5UEgp+wteGLzbglgAMlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H972iECA50ODJxEbJxBKObsfQ0G+WNy/7nnR2zSBe7Jp3x+JrfPkvTMAbUpf1+9Rjy01Rhh+ITNg4WcfTIuhlod09PFrHferby4bUr535B9XLaR4xnJm1EMtFu5/Zj0DKAmWIXr/hLq3109PcoSYC9x9f6BvTkndhPRe63xWI4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=abIqVSFX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2232aead377so32874995ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741784093; x=1742388893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P41L4c+Opb1IQnEi9LDyI8HBaw91mzMN/9HEGsnySy8=;
        b=abIqVSFXD2SL83szo8/TjIP8+hTuz5O5fbhAVUHqiKyZMLPal0mtAz2/ZBlzZbZYGZ
         M60ZsuhLoemKVeab5RAFO9xVrroWJVuixXgFAeVXHvdrTP5e85xfXWoWtHUty6A0Qe86
         9uwbHJb0tgEYDJ+orcjNyAMtMgg/5DLna8Tvx+izWj58S0vs0XVKPdCvQ0zWC1wJVm9/
         1FxHgAi4wmVOKxVgk2ODwm6LItFIrlH/PNtdpNm4WI3JU3xkmpLujhDJp+I3UtfriuU8
         wUC5HJ1vHMtIS7iAP0pMje9UYOQNe4RqHlhmzKtEW4A20WDUklq+kqDQ0+PDctMwFmq2
         ullg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784093; x=1742388893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P41L4c+Opb1IQnEi9LDyI8HBaw91mzMN/9HEGsnySy8=;
        b=H6VNEQfvvRobPBYuNq6WndPrxbY/brIQXSWikmkVNOjKbEFswZh8OEGzkxbkqUyaA8
         VoGxE47uMxAIg6wFvUn8NpcJdQfCDIVIVFSRdcDPyCzpY8VSkGLpLxWnYjOQYEcFize+
         oQwJoa86SQ6qm/m1uAL8974hCfQ/XdMJ/lINr5kfhauMAZkz7b/2vx5ypHT4qDIhDqcv
         fZwfF1V/8J92v3anYC1Kzx7YXHl7B86SEZmv+bNFLd6OhepDh4rpZzJm/sE5THrjGQyF
         d8pNtcn7sL3AxK73zAHCWN9lUGVp7qLj8Pcjq/Q/iUF7xnWCv2gEvzr7Y1VQBpUJ0JjB
         yPgg==
X-Forwarded-Encrypted: i=1; AJvYcCUZPWewrywsecKwlsLWIFypKbYizPBmiZq6Iw2X73WIC5lLKSUlXT3uwiFeH8SzY3ti+x2V3NCIems8VZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzarSSo/P9VRNZxUG+oAZnNy+CfuuwDxSaE/bOU2JuMSU68nOR
	zOvgVy0y+hWlBvJX0Ol3vsPQFtVgpRqwu831nDt8gCS0Sza6Ds+vlenMsX2URviFtA2qkU841cp
	KwUVPg106kR4lO6UDYE4wPsYQytP+Cuhb2KZ3ww==
X-Gm-Gg: ASbGncvMLR4cArAkwxkm/QyEfV906c1birJe2VBg757idreyuOJ9nsGljOy1UAry78Y
	dotauXnIhVbt+WwLuXCNfxO4vDGXJx0lQACTMtrvkSL+6LKH2Z3BFQz9RF7TA97TVAjzWtQ2rXf
	2RlyxF7OAMNRWoO+FLbBZeRRR+fNE=
X-Google-Smtp-Source: AGHT+IEmvzgsrnWJ3LS9iuiefnI5/Y1q51JDiJPKEl1YavKMn2nS0Mp6TQ/OYLWI5gnSPzE5ELMRM9TgS5WSMkJCuv0=
X-Received: by 2002:a05:6a00:194b:b0:736:5e6f:295b with SMTP id
 d2e1a72fcca58-736aaa5d6c4mr32299739b3a.12.1741784092687; Wed, 12 Mar 2025
 05:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310090407.2069489-1-quic_jiegan@quicinc.com>
 <20250310090407.2069489-2-quic_jiegan@quicinc.com> <CAJ9a7Vh7PmBBbvwnUETfCYrTSiXNzeiWpsz+XAGaUWt1Rq1aZw@mail.gmail.com>
 <cef984d5-f369-4892-b970-a71285c2ebc5@quicinc.com>
In-Reply-To: <cef984d5-f369-4892-b970-a71285c2ebc5@quicinc.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 12 Mar 2025 12:54:41 +0000
X-Gm-Features: AQ5f1JrjHjNAhBmSqhZ9QdvfeDjrNBtawx-M2q_IwgCWoudUHO1tG95UqLFNpqQ
Message-ID: <CAJ9a7VhDD3813LtH_5AYyM-2mhCNP+vRmqXn4RWqg5F8FEe-Mg@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] coresight: tmc: Introduce new APIs to get the RWP
 offset of ETR buffer
To: Jie Gan <quic_jiegan@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Tingwei Zhang <quic_tingweiz@quicinc.com>, Jinlong Mao <quic_jinlmao@quicinc.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"

Hi Jie,

On Wed, 12 Mar 2025 at 01:21, Jie Gan <quic_jiegan@quicinc.com> wrote:
>
>
>
> On 3/12/2025 12:49 AM, Mike Leach wrote:
> > Hi,
> >
> > On Mon, 10 Mar 2025 at 09:04, Jie Gan <quic_jiegan@quicinc.com> wrote:
> >>
> >> The new functions calculate and return the offset to the write pointer of
> >> the ETR buffer based on whether the memory mode is SG, flat or reserved.
> >> The functions have the RWP offset can directly read data from ETR buffer,
> >> enabling the transfer of data to any required location.
> >>
> >> Signed-off-by: Jie Gan <quic_jiegan@quicinc.com>
> >> ---
> >>   .../hwtracing/coresight/coresight-tmc-etr.c   | 40 +++++++++++++++++++
> >>   drivers/hwtracing/coresight/coresight-tmc.h   |  1 +
> >>   2 files changed, 41 insertions(+)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> >> index eda7cdad0e2b..ec636ab1fd75 100644
> >> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> >> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> >> @@ -267,6 +267,46 @@ void tmc_free_sg_table(struct tmc_sg_table *sg_table)
> >>   }
> >>   EXPORT_SYMBOL_GPL(tmc_free_sg_table);
> >>
> >> +static long tmc_flat_resrv_get_rwp_offset(struct tmc_drvdata *drvdata)
> >> +{
> >> +       dma_addr_t paddr = drvdata->sysfs_buf->hwaddr;
> >> +       u64 rwp;
> >> +
> >
> > It is not valid to read RWP if the TMC is running. It must be in the
> > stopped or disabled state - see the specifications for TMC /ETR
> >
> > It is likely that CSUNLOCK / CSLOCK are needed here too,  along with
> > the spinlock that protects drvdata
> >
> > See the code in coresight_tmc_etr.c :-
> >
> > e.g. in
> >
> > tmc_update_etr_buffer()
> >
> > ...
> > <take spinlock>
> > ...
> > CS_UNLOCK(drvdata->base);
> > tmc_flush_and_stop(drvdata); // this ensures tmc is stopped and
> > flushed to memory - essential to ensure full formatted frame is in
> > memory.
> > tmc_sync_etr_buf(drvdata); // this function reads rwp.
> > CS_LOCK(drvdata->base);
> > <release spinlokc>
> >
> > This type of program flow is common to both sysfs and perf handling of
> > TMC buffers.
>
> Hi Mike,
>
> I am fully understood your point here.
>
> The function is designed this way to read the w_offset (which may not be
> entirely accurate because the etr buffer is not synced) when the

Why would you ever base memory access on a pointer that is not
entirely accurate?

The manuals for TMC/ETR all state that reads to both RWP and RRP when
the ETR is running return unknown values. These cannot be used to
access the buffer, or determine how much of the buffer has been used
on a running ETR.

The ETR specification specifically states that it is not permitted to
read the buffer data while the ETR is running, when configured in
circular buffer mode - which is the mode used in the TMC-ETR linux
drivers.

Reading the buffer while ETR is running is only permitted if
configured in Software FIFO mode 2 - were the ETR will stop on full
and stall incoming trace until some data is read out, signalled to the
ETR via the RURP.

I also note that you are reading back the etr_buf data without doing
any dma_sync operations that the perf and sysfs methods in the driver
do, after stopping the tmc.

> byte-cntr devnode is opened, aiming to reduce the length of redundant
> trace data. In this case, we cannot ensure the TMC is stopped or
> disabled.

The specification requires that you must ensure the TMC is stopped to
read these registers.


>The byte-cntr only requires an offset to know where it can
> start before the expected trace data gets into ETR buffer.
>
> The w_offset is also read when the byte-cntr function stops, which
> occurs after the TMC is disabled.
>
> Maybe this is not a good idea and I should read r_offset upon open?
> The primary goal for byte-cntr is trying to transfer useful trace data
> from the ETR buffer to the userspace, if we start from r_offset, a large
> number of redundant trace data which the user does not expect will be
> transferred simultaneously.
>
>

It is difficult to justify adding code to a driver that does not
correspond to the specification of the hardware device.

Regards

Mike

> >
> >> +       rwp = tmc_read_rwp(drvdata);
> >> +       return rwp - paddr;
> >> +}
> >> +
> >> +static long tmc_sg_get_rwp_offset(struct tmc_drvdata *drvdata)
> >> +{
> >> +       struct etr_buf *etr_buf = drvdata->sysfs_buf;
> >> +       struct etr_sg_table *etr_table = etr_buf->private;
> >> +       struct tmc_sg_table *table = etr_table->sg_table;
> >> +       long w_offset;
> >> +       u64 rwp;
> >> +
> >
> > Same comments as above
> >
> >> +       rwp = tmc_read_rwp(drvdata);
> >> +       w_offset = tmc_sg_get_data_page_offset(table, rwp);
> >> +
> >> +       return w_offset;
> >> +}
> >> +
> >> +/*
> >> + * Retrieve the offset to the write pointer of the ETR buffer based on whether
> >> + * the memory mode is SG, flat or reserved.
> >> + */
> >> +long tmc_get_rwp_offset(struct tmc_drvdata *drvdata)
> >> +{
> >> +       struct etr_buf *etr_buf = drvdata->sysfs_buf;
> >> +
> >
> > As this is an exported function, please ensure that the inputs are
> > valid - check the pointers
>
> Sure, will do.
>
> Thanks,
> Jie
>
> >
> > Code to ensure TMC is flushed and stopped could be inserted here.
> >
> > Regards
> >
> > Mike
> >
> >> +       if (etr_buf->mode == ETR_MODE_ETR_SG)
> >> +               return tmc_sg_get_rwp_offset(drvdata);
> >> +       else if (etr_buf->mode == ETR_MODE_FLAT || etr_buf->mode == ETR_MODE_RESRV)
> >> +               return tmc_flat_resrv_get_rwp_offset(drvdata);
> >> +       else
> >> +               return -EINVAL;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tmc_get_rwp_offset);
> >> +
> >>   /*
> >>    * Alloc pages for the table. Since this will be used by the device,
> >>    * allocate the pages closer to the device (i.e, dev_to_node(dev)
> >> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> >> index b48bc9a01cc0..baedb4dcfc3f 100644
> >> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> >> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> >> @@ -442,5 +442,6 @@ void tmc_etr_remove_catu_ops(void);
> >>   struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
> >>                                     enum cs_mode mode, void *data);
> >>   extern const struct attribute_group coresight_etr_group;
> >> +long tmc_get_rwp_offset(struct tmc_drvdata *drvdata);
> >>
> >>   #endif
> >> --
> >> 2.34.1
> >>
> >
> >
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

