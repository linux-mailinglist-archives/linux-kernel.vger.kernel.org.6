Return-Path: <linux-kernel+bounces-551177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3589EA56906
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABA9188C71B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096F2153CE;
	Fri,  7 Mar 2025 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OctnpHNx"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7071AA7BA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354432; cv=none; b=LqVlR88mvaHRDpx3et51/Qz2ziWe8xZwEvWbKoafwb94ty/eY3I30V+nWt6nzC8FrQbWrCeRxPsk4xephInbMsWeluMLkgA/Ij9wEnlNmyIyksYNzi8rxOr8+kmoHAyMQjLUjUIIrZyi0MqF7iZZze/Yz9cofY7+JAqJS0AQ7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354432; c=relaxed/simple;
	bh=c0EbQhriH0yeVpmDPzQfirvruWs73sJAmiu3cWiAa8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+TdEfbMFVoAgRc84u3IDdvX4lRXdHbMVSC6NdjFQQMIqGCxeD82XypdRGKDjdQhJaitcQxwkihwVrn4XGIiEOK3P2q1YDVPrajKqy5LxSEzMH1ldeBXbrjWIMrT6hl80YIMJ43jG1nqbjKyLIhcvy5cKBRGBA1M9jgHY3Puutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OctnpHNx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2241053582dso5724465ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 05:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741354430; x=1741959230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qefuz4/zXGnZQBriDiq772OSKh+NBl3pjLrowf6tFto=;
        b=OctnpHNx9gK9klkiJ9lLMk6wQEP9uyXV1//csgJbE+3FSKjDbugcUElD5WdaUHaG1x
         bY8kuFzFDvFBT+OoVuPhBfyHpIByajdw9qh2uzUbJI+hPeNQOxM+t3fasgD4vKj4wZnx
         Bwmn4z3gX95/VbbdqbPLSi36h8XVB84TcR7KfLHRd9AlAxidSZbst4l/1GhqpJEkbJAM
         ALFOyCU4ImH+vETAtZ0C+90Uei15gNPjwW3p/8Sq0x0Une8QjUGRzSYBRSMXZXmDaog7
         O+IOo2vaseth6n5oM3uZRBClibinWQiYzi3o5Gi884Kx7J9SpxNr3fqn4PZxgkjDxDq5
         NuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741354430; x=1741959230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qefuz4/zXGnZQBriDiq772OSKh+NBl3pjLrowf6tFto=;
        b=kndQmMV8YfU0D2FS+Y8SBB/zSCxGTeVGGKj+Htq3+e5rrGxa8lvoZecPKny+z+boHD
         zK+XG27T3FyMkGtVfYRYh3OVIi+hwnl1VwuU7p8HkNdJlBn+46CeOLBKVy59bq8Ov3fo
         I9a9lAxlFxyxh2wwRVHsBhZ8JpyUYYy9Ixtu8tq29m2OzoWQSUajM2IXrRkshHnoa5HX
         Sq34PYE7+nrqOhRvEAliKX+qR2lLYvTncYuQFSreVPKw/1bopWHbxuxzCk3vH0bAM3x/
         Hou4XeQS4LEqksvEZYx4bN45PxfZWMjz0+YnBKiXVfCxT7RZmcBpM/R8pn2g/RARzjRf
         e+zw==
X-Forwarded-Encrypted: i=1; AJvYcCUse3bqWGZwsd++UfAPVHGMNILEDcEpxaIVLd/miMpJfYdXUSL8IECaCr+C7ooIPNrOC8vuwX0KFt//cJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxuFq1NkvIAJGL7DcXadpRrsrnf+XEdfCCJySNzK4Mjw8gIVZG
	rzdhvD4kYkWSjRvOX4MaKpatTbdviZZw31MAu9pyX5vWtm7opVCE2yBUC0/eZPC2yLOV8ArGPLL
	bEkn+icw0EKGdHWN66XACgMvcwjOE88B8J0I/GQ==
X-Gm-Gg: ASbGncsYu+o+d12Rodc4zqEu5TqgwhH3exdnrhKrJ1S7UM7hRb5mUI8Zui+vuYoWcMF
	i24F60+U3ImdhlH67D8raViKzCy3VDzgdFtjBhChjptxL54AB49zXDxVcyQfknwXLD0R5/2JU9O
	Acxy8IHhzFEYEPP29TD4G/neU3eKc=
X-Google-Smtp-Source: AGHT+IHRGxC49ANZft/8x4Umwrvd3CXrktB6JJunoqMwcMyPwq3u1UK1JigVlbNzMjMBwBcmwlqKciC3HjjxVzAjDN0=
X-Received: by 2002:a05:6a20:4322:b0:1f1:a608:230b with SMTP id
 adf61e73a8af0-1f544c6869emr6393060637.26.1741354429780; Fri, 07 Mar 2025
 05:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227092640.2666894-1-quic_songchai@quicinc.com> <20250227092640.2666894-8-quic_songchai@quicinc.com>
In-Reply-To: <20250227092640.2666894-8-quic_songchai@quicinc.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 7 Mar 2025 13:33:38 +0000
X-Gm-Features: AQ5f1JrIaweQlcl4Gi_z5MPaMgCPO4piq25c6LCh0NkwnAfTW-agNeURPRb-cXk
Message-ID: <CAJ9a7Vh4OTZdbEygtwc7BxRJSLgkALoaNRPEiQLJQgZvFtnTtw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] coresight-tgu: add reset node to initialize
To: songchai <quic_songchai@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 27 Feb 2025 at 09:27, songchai <quic_songchai@quicinc.com> wrote:
>
> From: Songwei Chai <quic_songchai@quicinc.com>
>
> Add reset node to initialize the value of
> priority/condition_decode/condition_select/timer/counter nodes
>
> Signed-off-by: Songwei Chai <quic_songchai@quicinc.com>
> Signed-off-by: songchai <quic_songchai@quicinc.com>
> ---
>  .../testing/sysfs-bus-coresight-devices-tgu   |  7 ++
>  drivers/hwtracing/coresight/coresight-tgu.c   | 79 +++++++++++++++++++
>  2 files changed, 86 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
> index d88d05fbff43..8fb5afd7c655 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tgu
> @@ -42,3 +42,10 @@ KernelVersion   6.15
>  Contact:        Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Sam Chai (QUIC) <quic_songchai@quicinc.com>
>  Description:
>                  (RW) Set/Get the counter value with specific step for TGU.
> +
> +What:           /sys/bus/coresight/devices/<tgu-name>/reset_tgu
> +Date:           February 2025
> +KernelVersion   6.15
> +Contact:        Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Sam Chai (QUIC) <quic_songchai@quicinc.com>
> +Description:
> +                (Write) Reset the dataset for TGU.

Document the value needed to initiate the reset.

> diff --git a/drivers/hwtracing/coresight/coresight-tgu.c b/drivers/hwtracing/coresight/coresight-tgu.c
> index 693d632fb079..b36ced761c0d 100644
> --- a/drivers/hwtracing/coresight/coresight-tgu.c
> +++ b/drivers/hwtracing/coresight/coresight-tgu.c
> @@ -343,6 +343,84 @@ static ssize_t enable_tgu_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(enable_tgu);
>
> +/* reset_tgu_store - Reset Trace and Gating Unit (TGU) configuration. */
> +static ssize_t reset_tgu_store(struct device *dev,
> +                              struct device_attribute *attr, const char *buf,
> +                              size_t size)
> +{
> +       unsigned long value;
> +       struct tgu_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +       int i, j, ret;
> +
> +       if (kstrtoul(buf, 0, &value))
> +               return -EINVAL;
> +

Check "value" here and bail out with an error code if 0.

> +       if (!drvdata->enable) {
> +               ret = pm_runtime_get_sync(drvdata->dev);
> +               if (ret < 0) {
> +                       pm_runtime_put(drvdata->dev);
> +                       return ret;
> +               }
> +       }
> +
> +       spin_lock(&drvdata->spinlock);
> +       CS_UNLOCK(drvdata->base);
> +
> +       if (value) {
drop this line

> +               tgu_writel(drvdata, 0, TGU_CONTROL);
> +
> +               if (drvdata->value_table->priority)
> +                       memset(drvdata->value_table->priority, 0,
> +                              MAX_PRIORITY * drvdata->max_step *
> +                                      drvdata->max_reg * sizeof(unsigned int));
> +
> +               if (drvdata->value_table->condition_decode)
> +                       memset(drvdata->value_table->condition_decode, 0,
> +                              drvdata->max_condition_decode * drvdata->max_step *
> +                                      sizeof(unsigned int));
> +
> +               /* Initialize all condition registers to NOT(value=0x1000000) */
> +               for (i = 0; i < drvdata->max_step; i++) {
> +                       for (j = 0; j < drvdata->max_condition_decode; j++) {
> +                               drvdata->value_table
> +                                       ->condition_decode[calculate_array_location(
> +                                               drvdata, i, TGU_CONDITION_DECODE, j)] =
> +                                       0x1000000;
> +                       }
> +               }
> +
> +               if (drvdata->value_table->condition_select)
> +                       memset(drvdata->value_table->condition_select, 0,
> +                              drvdata->max_condition_select * drvdata->max_step *
> +                                      sizeof(unsigned int));
> +
> +               if (drvdata->value_table->timer)
> +                       memset(drvdata->value_table->timer, 0,
> +                              (drvdata->max_step) *
> +                                      (drvdata->max_timer_counter) *
> +                                      sizeof(unsigned int));
> +
> +               if (drvdata->value_table->counter)
> +                       memset(drvdata->value_table->counter, 0,
> +                              (drvdata->max_step) *
> +                                      (drvdata->max_timer_counter) *
> +                                      sizeof(unsigned int));
> +
> +               dev_dbg(dev, "Coresight-TGU reset complete\n");
> +       } else {
> +               dev_dbg(dev, "Coresight-TGU invalid input\n");

not needed if early exit on input errror

> +       }
> +
> +       CS_LOCK(drvdata->base);
> +
> +       drvdata->enable = false;
> +       spin_unlock(&drvdata->spinlock);
> +       pm_runtime_put(drvdata->dev);
> +
> +       return size;
> +}
> +static DEVICE_ATTR_WO(reset_tgu);
> +
>  static const struct coresight_ops_helper tgu_helper_ops = {
>         .enable = tgu_enable,
>         .disable = tgu_disable,
> @@ -354,6 +432,7 @@ static const struct coresight_ops tgu_ops = {
>
>  static struct attribute *tgu_common_attrs[] = {
>         &dev_attr_enable_tgu.attr,
> +       &dev_attr_reset_tgu.attr,
>         NULL,
>  };
>
>


Regards

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

