Return-Path: <linux-kernel+bounces-388930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C7A9B6657
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F81D1F21A05
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA7B1F4282;
	Wed, 30 Oct 2024 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m5ngOjel"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8026AD4
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299670; cv=none; b=cYPjmspFMwHhlTJlt4oBEZiXf+yefbRiUXiw6tEklAJTistIlaug0Qe662dzQkc3TtywHc0jhNB/lviO5/g/umW3AmSfsRdPibXO4v83zfXdhwYgOGgChP1T1Q1GGCy+7EtaAjmOZ2nH/rnHDeZlT89Yl5KTM3SwuXcwKlbIhX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299670; c=relaxed/simple;
	bh=FV1CBGoW/dTrs4uMJ7wuHbCz2njs7kZhU47rS11uxZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrTZi3vOB0TK9+lvdeC0YXIH1OujS+yjkMwex/a2B4Mr/MHgWCYOmjPgyI66Xog066hEwvKdXo1JkA0etX5uLNrlqyS6vjfSfCnl0yzxQpVID4ppG16uQgwqo948+dlVHPyfvi2h3zyIc1PkszD1KOUu5pIJp7AJfufFm22Ngbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m5ngOjel; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso721432b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730299667; x=1730904467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A66QRbAmerrW6V7sGjQr/c1N9bxUtMh8x/uKuirbyvM=;
        b=m5ngOjelB5ikefm/+x4Kv7parUiWXiRvxRp/JMYV/aR7ozNNoVko9HiskfTMYQj6h/
         ifO5/G8oFE1IfLb3UGp785UUYiWsYFR75B9k898fpvwkCbHsCttZH1snryWXJjf/2P6T
         kwJG9/TAjK2ZKQdaChJYT4/WDY4FHzLYN5XR42QaOasoaHCOUtbjf5Hy6Z2YSHe92TE5
         xwwbI2XFSX/V8kYCGpJehBYj3BJYAtO4Q/8ZTG1DS7/t6osykmbb0eEbLjTkmnRrk2lu
         aKQtZfHfY1a7T7J0m66iKbSC8ZMx9e0W0sw3GgIwqR+K9Y6xYavjE3a0CNjV02Nrrxt1
         zAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730299667; x=1730904467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A66QRbAmerrW6V7sGjQr/c1N9bxUtMh8x/uKuirbyvM=;
        b=WAjqAK5qayXKj/uwNBIDFZaT8JHV+8qBoysuFJJuE+vsbGQwt0btjGklicduYETjQk
         NOVV4BpkG4+OWQf+vn1ay6QMaGAkzHBar+Tb4EDJsvMFea0pBEmZtbn81njdCU2Prbde
         TNJYwmrKnUJ7/Qph/2UV/4O5CwppEghwwUvuXYF3j1CSPChKP5AHUni9IFHailYDMUGT
         4C7c68wVo/Z+W5hTDjO59nUahtabu+dXpSv8oVIPeVHWqEAlI+o4TjeTLjcwT/gL1TXc
         /9Rl4CY8RXQUPQSV9393XWaGUok7OJkrF9oZYA94KFz+adV/x/OqQlH1osPiD+qV1Ggf
         4vXw==
X-Forwarded-Encrypted: i=1; AJvYcCUHo2tWtwT1hafoICeJL11vIyVdZATS0NSVrcQoFh1uJKb307nGTC7QdnVbJEBPd9G8Vc/B1Dh7HN0Nfa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBsMGLX+b1QBI1sX36Luy/HnM9c3v148Mr0QZWTSXiRr7swep3
	oLbAZrvR3jvgEJHcuGFxyRj12lVz+V2ZvzlJUs5k+dYt3JZTO8uV6bGXOYLqrvyAwrykCoinc74
	tuy4Hzb4MhTmXLycRchSMTxejloiedGDG6VRGCA==
X-Google-Smtp-Source: AGHT+IGE7SsUIQK43Z4vZS5EhJTyoCpTtVo7W6Nv8yrAqHUH5kel+pZdVCezqU0Hw/lsMKcRpIyDLKIrU3G5mxocaNI=
X-Received: by 2002:a05:6a00:3c85:b0:71e:5252:2412 with SMTP id
 d2e1a72fcca58-720ad14b1cdmr4375376b3a.2.1730299666657; Wed, 30 Oct 2024
 07:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030133133.2932722-1-quic_sibis@quicinc.com> <20241030133133.2932722-2-quic_sibis@quicinc.com>
In-Reply-To: <20241030133133.2932722-2-quic_sibis@quicinc.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 30 Oct 2024 15:47:35 +0100
Message-ID: <CAKfTPtDY965+8wbF-fgFyD4Br-2obQQjJTONwJoPpyYBrdN_VA@mail.gmail.com>
Subject: Re: [PATCH V6 1/1] cpufreq: scmi: Register for limit change notifications
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org, 
	viresh.kumar@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, 
	lukasz.luba@arm.com, pierre.gondois@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 14:32, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> Register for limit change notifications if supported and use the throttled
> frequency from the notification to apply HW pressure.
>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Tested-by: Mike Tipton <quic_mdtipton@quicinc.com>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>
> v6:
> * Unregister the notifier in the exit path to make sure
>   the cpus work across suspend/resume cycles.
>
>  drivers/cpufreq/scmi-cpufreq.c | 38 ++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 5892c73e129d..fb3534eae722 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -16,6 +16,7 @@
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pm_qos.h>
>  #include <linux/slab.h>
>  #include <linux/scmi_protocol.h>
>  #include <linux/types.h>
> @@ -25,7 +26,9 @@ struct scmi_data {
>         int domain_id;
>         int nr_opp;
>         struct device *cpu_dev;
> +       struct cpufreq_policy *policy;
>         cpumask_var_t opp_shared_cpus;
> +       struct notifier_block limit_notify_nb;
>  };
>
>  static struct scmi_protocol_handle *ph;
> @@ -174,6 +177,25 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
>         NULL,
>  };
>
> +static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
> +{
> +       struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
> +       struct scmi_perf_limits_report *limit_notify = data;
> +       struct cpufreq_policy *policy = priv->policy;
> +       unsigned int limit_freq_khz;
> +       int ret;
> +
> +       limit_freq_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
> +
> +       policy->max = clamp(limit_freq_khz, policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
> +
> +       ret = freq_qos_update_request(policy->max_freq_req, policy->max);

If I don't get it wrong, you are using policy->max_freq_req which is
also used by the sysfs scaling_max_freq

This means that your request will be overwritten by the next write
into scaling_max_freq and/or you will overwrite a constraint set by
userspace.

You have to create your own freq_qos_request and add it to the list of
cpufreq qos request



> +       if (ret < 0)
> +               pr_warn("failed to update freq constraint: %d\n", ret);
> +
> +       return NOTIFY_OK;
> +}
> +
>  static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  {
>         int ret, nr_opp, domain;
> @@ -181,6 +203,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>         struct device *cpu_dev;
>         struct scmi_data *priv;
>         struct cpufreq_frequency_table *freq_table;
> +       struct scmi_device *sdev = cpufreq_get_driver_data();
>
>         cpu_dev = get_cpu_device(policy->cpu);
>         if (!cpu_dev) {
> @@ -294,6 +317,17 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>                 }
>         }
>
> +       priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
> +       ret = sdev->handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_PERF,
> +                                                       SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
> +                                                       &domain,
> +                                                       &priv->limit_notify_nb);
> +       if (ret)
> +               dev_warn(&sdev->dev,
> +                        "failed to register for limits change notifier for domain %d\n", domain);
> +
> +       priv->policy = policy;
> +
>         return 0;
>
>  out_free_opp:
> @@ -310,8 +344,10 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>
>  static void scmi_cpufreq_exit(struct cpufreq_policy *policy)
>  {
> +       struct scmi_device *sdev = cpufreq_get_driver_data();
>         struct scmi_data *priv = policy->driver_data;
>
> +       sdev->handle->notify_ops->devm_event_notifier_unregister(sdev, &priv->limit_notify_nb);
>         dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>         dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
>         free_cpumask_var(priv->opp_shared_cpus);
> @@ -370,6 +406,8 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>         if (!handle)
>                 return -ENODEV;
>
> +       scmi_cpufreq_driver.driver_data = sdev;
> +
>         perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
>         if (IS_ERR(perf_ops))
>                 return PTR_ERR(perf_ops);
> --
> 2.34.1
>

