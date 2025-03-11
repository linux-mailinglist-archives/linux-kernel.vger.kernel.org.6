Return-Path: <linux-kernel+bounces-556528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBF9A5CB23
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688C517B4E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FB325E804;
	Tue, 11 Mar 2025 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMHsoaI/"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3F425B691
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711808; cv=none; b=tcTcIk3r5kj4socX70nzPCW4GFc+t0oUQaV1AHrJxmJnZCksXrefO3cY5g4j2Xju5O9cY7pRXtfvS0AQHSbjla/9YuOwDTw/73dBl7ibSu5M5nANDFy88ZYmmeyS4rtE5gtptJPmFY12ZH5paQywFf+FQ8wkXaNMqwx6NF/t680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711808; c=relaxed/simple;
	bh=BvZCDeJlwxu4WFta5J0ZRVMripoIkagvhPtRakkbRB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhZS7y3WDWkouJZHkWKoYby+H0VYlF4q12JzOC60GN/QC+I0BoGzjDWdihPh1e/ZBK/BxJ1ElPwsk+EwjTOGXB3xHXb4c/mlSHMBQAR52/GPFhr/yI4+KaI0dAM9quiV0pdEow/T7npuRIxBIwQYXCIYbcq2EVpGrPHrL8K5mKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zMHsoaI/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2241053582dso16107775ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741711806; x=1742316606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=23iOwZdcqMnXiNfXwcY1/saA5o6I48TGQZAkJr6gmPk=;
        b=zMHsoaI/HU0TZAezkp5lp2C6GsQS2hCq4RzqsAYjkVwJvIbTNrFlHKwxeXHphTIZov
         EuMYhYTuRHNP8AJF6ZJmYJA6lF7enuwt/UpmvetYHUM8aJ6Q3XD1ESP7aHMiEORjQUY5
         7/8LpKlGfxZ+/u8u9mAE7LTVVThmMQiDzdtssAJNCAYBq4EgU5/vz7eewNe9e+9nLfVo
         ubcKLdhjPUuuq0aPLlO67yNKFvpGMxjiB0uKSayTq4V3xhDN8PBDRaHEO4Ns5wPKEDod
         I++GJrDLYdzzU05yhOBlb9evfd7wgOm1HEQ82uAw/H+rD1vtGEQsML/9tfReapckQ9rY
         WZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711806; x=1742316606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23iOwZdcqMnXiNfXwcY1/saA5o6I48TGQZAkJr6gmPk=;
        b=hEOTutnSt12vO5UYlkj9mU2X9GP0DI9wA5fTonDq/7py65dE5n4bRtexcc0vnCyjAj
         zoMwASVr2HpH7MM6TXd+Ma5rm3rYakHJESuE8irO/4sM6XFYF2ij3mnMwkmgvq60/R4I
         AZao+puDyE3ihmUt6IHqYTEdyh+niDy6Z59HRwdckbxsfqJQZ74717F+uCQ4gALtQBBy
         gA1vJADUJW+lfWNEmmvgTc8wstmeYYqF5BPf/C6htZq41fuf34+njn1VADdf+3ACQFF3
         0fHa1qk62kEAKG3m5CQUxFP0suvV3PdelgngkQJymf5tB3VUXTTqjTQ1ItNXnaZanfWc
         giyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrLUB/xDemo3l1JkoWGgV6ZrPe7qin5MZ3NixbYtiHPWZjbPWhfBF24JCBdDUxhadbNWYWyjgFWAISvfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0kcmPVmt6ZLXjwmXSI4zf/jgZSzG/fHEl/VYTWPtqT31fuZNU
	5mq5j6n69TGpSJgWSYn7NCK7BmZAPx9ggnIOe6gxVKLOa1eoRqVvS2wTtELXF/GmS6A4ClWQ3sv
	xDRCVv1ChJooauFvGFSZQpolBkGYhkFZquoPaWw==
X-Gm-Gg: ASbGncupOyqkBQvQJ0QIRFlefXybtl2WZVkwCNgHBYK7HwlNoJMWcRHinhXuHqdotJD
	aiJJSSwOnfaV3SszITUJdhX9k/gaqXi+dI005VQNRXEU/9OV9CBsiT8w/8lBS2XFpt3O4exk7rJ
	ny4JKVwk+OxF6bx7TQ5nLqxMVuZLGot6SknSVoqWjiHdwHjsARE1TtF0JabPU=
X-Google-Smtp-Source: AGHT+IGRlRimNoESSBKd69bPemttjguo2zF0mTvg+Kb5/5Fg9niMy5gNnw80TuZnQbl3lCDWzV9DtaMCXkkJcAmG5fQ=
X-Received: by 2002:a05:6a21:2d08:b0:1f3:47d6:aa05 with SMTP id
 adf61e73a8af0-1f5449336e0mr29284989637.0.1741711806206; Tue, 11 Mar 2025
 09:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310090407.2069489-1-quic_jiegan@quicinc.com> <20250310090407.2069489-2-quic_jiegan@quicinc.com>
In-Reply-To: <20250310090407.2069489-2-quic_jiegan@quicinc.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 11 Mar 2025 16:49:54 +0000
X-Gm-Features: AQ5f1Jq4RzUPjRD0-Pf4PVjALFGSYlNPIsAlLKRkK0wLgCzuiv55sOjf36seIGA
Message-ID: <CAJ9a7Vh7PmBBbvwnUETfCYrTSiXNzeiWpsz+XAGaUWt1Rq1aZw@mail.gmail.com>
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

Hi,

On Mon, 10 Mar 2025 at 09:04, Jie Gan <quic_jiegan@quicinc.com> wrote:
>
> The new functions calculate and return the offset to the write pointer of
> the ETR buffer based on whether the memory mode is SG, flat or reserved.
> The functions have the RWP offset can directly read data from ETR buffer,
> enabling the transfer of data to any required location.
>
> Signed-off-by: Jie Gan <quic_jiegan@quicinc.com>
> ---
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 40 +++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-tmc.h   |  1 +
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index eda7cdad0e2b..ec636ab1fd75 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -267,6 +267,46 @@ void tmc_free_sg_table(struct tmc_sg_table *sg_table)
>  }
>  EXPORT_SYMBOL_GPL(tmc_free_sg_table);
>
> +static long tmc_flat_resrv_get_rwp_offset(struct tmc_drvdata *drvdata)
> +{
> +       dma_addr_t paddr = drvdata->sysfs_buf->hwaddr;
> +       u64 rwp;
> +

It is not valid to read RWP if the TMC is running. It must be in the
stopped or disabled state - see the specifications for TMC /ETR

It is likely that CSUNLOCK / CSLOCK are needed here too,  along with
the spinlock that protects drvdata

See the code in coresight_tmc_etr.c :-

e.g. in

tmc_update_etr_buffer()

...
<take spinlock>
...
CS_UNLOCK(drvdata->base);
tmc_flush_and_stop(drvdata); // this ensures tmc is stopped and
flushed to memory - essential to ensure full formatted frame is in
memory.
tmc_sync_etr_buf(drvdata); // this function reads rwp.
CS_LOCK(drvdata->base);
<release spinlokc>

This type of program flow is common to both sysfs and perf handling of
TMC buffers.

> +       rwp = tmc_read_rwp(drvdata);
> +       return rwp - paddr;
> +}
> +
> +static long tmc_sg_get_rwp_offset(struct tmc_drvdata *drvdata)
> +{
> +       struct etr_buf *etr_buf = drvdata->sysfs_buf;
> +       struct etr_sg_table *etr_table = etr_buf->private;
> +       struct tmc_sg_table *table = etr_table->sg_table;
> +       long w_offset;
> +       u64 rwp;
> +

Same comments as above

> +       rwp = tmc_read_rwp(drvdata);
> +       w_offset = tmc_sg_get_data_page_offset(table, rwp);
> +
> +       return w_offset;
> +}
> +
> +/*
> + * Retrieve the offset to the write pointer of the ETR buffer based on whether
> + * the memory mode is SG, flat or reserved.
> + */
> +long tmc_get_rwp_offset(struct tmc_drvdata *drvdata)
> +{
> +       struct etr_buf *etr_buf = drvdata->sysfs_buf;
> +

As this is an exported function, please ensure that the inputs are
valid - check the pointers

Code to ensure TMC is flushed and stopped could be inserted here.

Regards

Mike

> +       if (etr_buf->mode == ETR_MODE_ETR_SG)
> +               return tmc_sg_get_rwp_offset(drvdata);
> +       else if (etr_buf->mode == ETR_MODE_FLAT || etr_buf->mode == ETR_MODE_RESRV)
> +               return tmc_flat_resrv_get_rwp_offset(drvdata);
> +       else
> +               return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(tmc_get_rwp_offset);
> +
>  /*
>   * Alloc pages for the table. Since this will be used by the device,
>   * allocate the pages closer to the device (i.e, dev_to_node(dev)
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index b48bc9a01cc0..baedb4dcfc3f 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -442,5 +442,6 @@ void tmc_etr_remove_catu_ops(void);
>  struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
>                                    enum cs_mode mode, void *data);
>  extern const struct attribute_group coresight_etr_group;
> +long tmc_get_rwp_offset(struct tmc_drvdata *drvdata);
>
>  #endif
> --
> 2.34.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

