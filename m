Return-Path: <linux-kernel+bounces-256565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F861935045
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321C01C20E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ABA144D1E;
	Thu, 18 Jul 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJT+bzOi"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E6113B7AF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318260; cv=none; b=e4mah33vgKowSH8LvrSgVC78LeKh+H2uz2hh4G60xMeEPj8PJkjUZeh28DjjWbRA+52iutvkj8ks/ZcwxHji/qRmAu8VEo0PYqk4Q+Zp/FfPxLk7KD7emFJpp31gDsd4kBV/KRjJ9JL5Rzbr35Xiy8J26E1JKNrBlXvUeUhVjas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318260; c=relaxed/simple;
	bh=sl2oiMooUMCsWoNkqPbfasyYma43SDKzi9XVVqT4ees=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7Z7wFhQRXXdgVWU2+Igtp8DzG7NrmMLra8eCC/79gGdD0/AWquJK2Fjfn+DXeiShrQgInEliTR6n3WmXhuGOGi5eF06QVBNm8H730AYP7gl9Tyd9O3okU367AMn7fLpVjjL4fYas4FqizhsDoHP3TUNW8AEYoUDIMGx7bhzsCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EJT+bzOi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc587361b6so9965825ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721318258; x=1721923058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ofpb1acQLPPapQsKk29WrwkJyQ4QlooroHX/LncNk8=;
        b=EJT+bzOiWP70WKN3gC4bPeLk02n5vAYhwC5mbaW53hq5/cU1QgeZw4/aRPUKDBXpOF
         zC4jByOKr2n1FM9zhxO0r7DfStQHBlAW/V5HKWpHdtWtZJU5Rx6iDWpmH83Hpfyelsci
         HzrZ7TNcaKJCOAqHkrHMEgJhpGmnmJI5fN8lOHYa29gqyq0HW7J3VpFO1dstjnrHS3zB
         2vzPf2p4lUAGQlou9R2uQ/G7SkDaPZ0dYkxTzMzGK6IsH5mhfN3mLG9PiQN0FmOiej0I
         CvyxJtpq2/cqpj/P6Y8Z9EtCEXnCGIUy4QRTVWGW4OYx8TlZbEsCRtphZ+0ggybggNS+
         fmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721318258; x=1721923058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ofpb1acQLPPapQsKk29WrwkJyQ4QlooroHX/LncNk8=;
        b=ubdKoqNV1a6IeG3nVEg0LvB3mOipsIT6nyWunyd1SztskCcOeP93Xa14S2EP66NMKa
         F0NiDni4EJikRCnA9chItPgk95rzVU7MU7HAxOFNRzd6oagFn0WjgBCs1UgjM/EAaX2k
         L5ElvsWF+XxQLyFepBIqD8mwczTs78jFwUStlaGt5X4dC2nk++lPqRrFmHD33cXCyOxI
         Cyj1UV7haoqclorLcyDlwpChKGjHFXNdJt+BiWFm66M9n4MDT9mRD8PkA6yh4OK72ohJ
         nVnCRcpodEArQIGashYlaqpykpcKBmoH9CDSSYLnt6QpVbh/Q746Rxd+mH6lG0BvcSgu
         pndg==
X-Forwarded-Encrypted: i=1; AJvYcCXEZC2Cj0QT/sBAaEF5HlW70utl2WNqcXmRhn6K+0/3m6gX9vV9VlbND+ssaaE+GPSoj16YHktCVeSoNl+2Ne03q77TMSPBCgHEdVvG
X-Gm-Message-State: AOJu0YxLctcPDdyX+lz3RZRqO8RIyvAhHH8lYnzq/wBXTEjbkfRcxSY5
	S61a2T7YSE25lpyMXoDO/dH2AqE4bVgoJVAOO6bBoy0ujv5nJSPn5PE7yT2YUCReNR9CMR76gsA
	OuOarLNVqavyLMrg0OhQc16gaKBgNtjtdFiOP8A==
X-Google-Smtp-Source: AGHT+IGbdfGXPO7hQ91Vsor93o1jCzZy+QtCw+WCkF/HJmGy/VuDHRrY6xUrccW6dwxFPcKAOkKuD45Jqge2sKBipkU=
X-Received: by 2002:a17:90a:514f:b0:2c9:7e9d:8424 with SMTP id
 98e67ed59e1d1-2cb52931aa8mr4312618a91.30.1721318257799; Thu, 18 Jul 2024
 08:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626060724.28862-1-quic_jinlmao@quicinc.com> <20240626060724.28862-3-quic_jinlmao@quicinc.com>
In-Reply-To: <20240626060724.28862-3-quic_jinlmao@quicinc.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 18 Jul 2024 16:57:26 +0100
Message-ID: <CAJ9a7Vi8yE9mEbP3pPoE4xXxgomiqz6N_vz35PmFEH2tYcv=xw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] coresight: Add support to get preferred id for
 system trace sources
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Tingwei Zhang <quic_tingweiz@quicinc.com>, Yuanfang Zhang <quic_yuanfang@quicinc.com>, 
	Tao Zhang <quic_taozha@quicinc.com>, songchai <quic_songchai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, 26 Jun 2024 at 07:07, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Dynamic trace id was introduced in coresight subsystem, so trace id is
> allocated dynamically. However, some hardware ATB source has static trace
> id and it cannot be changed via software programming. For such source,
> it can call coresight_get_source_traceid to get the fixed trace id from
> device node and pass id to coresight_trace_id_get_system_id to reserve
> the id.
>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../hwtracing/coresight/coresight-platform.c  | 25 +++++++++++++
>  drivers/hwtracing/coresight/coresight-stm.c   |  2 +-
>  drivers/hwtracing/coresight/coresight-tpda.c  |  2 +-
>  .../hwtracing/coresight/coresight-trace-id.c  | 35 ++++++++++++-------
>  .../hwtracing/coresight/coresight-trace-id.h  | 11 +++++-
>  include/linux/coresight.h                     |  1 +
>  6 files changed, 61 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 9d550f5697fa..df169f3f367e 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -183,6 +183,17 @@ static int of_coresight_get_cpu(struct device *dev)
>         return cpu;
>  }
>
> +/*
> + * of_coresight_get_trace_id: Get the atid of a source device.
> + *
> + * Returns 0 on success.
> + */
> +static int of_coresight_get_trace_id(struct device *dev, u32 *id)

name this "of_coresight_get_static_trace_id"

> +{
> +
> +       return of_property_read_u32(dev->of_node, "arm,trace-id", id);

should be "arm,static-trace-id" for consistency.

> +}
> +
>  /*
>   * of_coresight_parse_endpoint : Parse the given output endpoint @ep
>   * and fill the connection information in @pdata->out_conns
> @@ -315,6 +326,11 @@ static inline int of_coresight_get_cpu(struct device *dev)
>  {
>         return -ENODEV;
>  }
> +
> +static inline int of_coresight_get_trace_id(struct device *dev, u32 *id)
> +{
> +       return -ENODEV;
> +}
>  #endif
>
>  #ifdef CONFIG_ACPI
> @@ -794,6 +810,15 @@ int coresight_get_cpu(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(coresight_get_cpu);
>
> +int coresight_get_source_traceid(struct device *dev, u32 *id)

This should be coresight_get_static_traceid.

> +{
> +       if (!is_of_node(dev->fwnode))
> +               return -EINVAL;
> +
> +       return of_coresight_get_trace_id(dev, id);
> +}
> +EXPORT_SYMBOL_GPL(coresight_get_source_traceid);
> +
>  struct coresight_platform_data *
>  coresight_get_platform_data(struct device *dev)
>  {
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index e1c62820dfda..34fab2ce9a76 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -901,7 +901,7 @@ static int __stm_probe(struct device *dev, struct resource *res)
>                 goto stm_unregister;
>         }
>
> -       trace_id = coresight_trace_id_get_system_id();
> +       trace_id = coresight_trace_id_get_system_id(TRACE_ID_ANY);

implement a coresight_trace_id_get_static_system_id() function and
drop this change

>         if (trace_id < 0) {
>                 ret = trace_id;
>                 goto cs_unregister;
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index 7739bc7adc44..46161cadb9e5 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -251,7 +251,7 @@ static int tpda_init_default_data(struct tpda_drvdata *drvdata)
>          * same trace-id. When TPDA does packetization, different
>          * port will have unique channel number for decoding.
>          */
> -       atid = coresight_trace_id_get_system_id();
> +       atid = coresight_trace_id_get_system_id(TRACE_ID_ANY);

and here

>         if (atid < 0)
>                 return atid;
>
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> index af5b4ef59cea..59194f60362c 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -75,21 +75,26 @@ static int coresight_trace_id_find_odd_id(struct coresight_trace_id_map *id_map)
>   * Allocate new ID and set in use
>   *
>   * if @preferred_id is a valid id then try to use that value if available.
> - * if @preferred_id is not valid and @prefer_odd_id is true, try for odd id.
> + * if TRACE_ID_WANT_PREFERRED is set, @preferred_id must be free, otherwise return
> + * error -EINVAL.
> + * if @preferred_id is not valid and TRACE_ID_WANT_ODD is true, try for odd id.
>   *
>   * Otherwise allocate next available ID.
>   */
>  static int coresight_trace_id_alloc_new_id(struct coresight_trace_id_map *id_map,
> -                                          int preferred_id, bool prefer_odd_id)
> +                          int preferred_id, unsigned int flags)
>  {
>         int id = 0;
>
>         /* for backwards compatibility, cpu IDs may use preferred value */
> -       if (IS_VALID_CS_TRACE_ID(preferred_id) &&
> -           !test_bit(preferred_id, id_map->used_ids)) {
> -               id = preferred_id;
> -               goto trace_id_allocated;
> -       } else if (prefer_odd_id) {
> +       if (IS_VALID_CS_TRACE_ID(preferred_id)) {
> +               if (!test_bit(preferred_id, id_map->used_ids)) {
> +                       id = preferred_id;
> +                       goto trace_id_allocated;
> +               } else if (WARN((flags & TRACE_ID_WANT_PREFERRED), "Trace ID %d is used.\n",
> +                                       preferred_id))
> +                       return -EINVAL;
> +       } else if (flags & TRACE_ID_WANT_ODD) {
>         /* may use odd ids to avoid preferred legacy cpu IDs */
>                 id = coresight_trace_id_find_odd_id(id_map);
>                 if (id)
> @@ -175,7 +180,7 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
>          */
>         id = coresight_trace_id_alloc_new_id(id_map,
>                                              CORESIGHT_LEGACY_CPU_TRACE_ID(cpu),
> -                                            false);
> +                                            TRACE_ID_ANY);
>         if (!IS_VALID_CS_TRACE_ID(id))
>                 goto get_cpu_id_out_unlock;
>
> @@ -222,14 +227,20 @@ static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id
>         DUMP_ID_MAP(id_map);
>  }
>
> -static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
> +static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map,
> +                               int preferred_id)

Add a trace_id flags parameter here and call in with flags already set

>  {
>         unsigned long flags;
>         int id;
> +       unsigned int traceid_flags = 0;
>
>         spin_lock_irqsave(&id_map_lock, flags);
> +
>         /* prefer odd IDs for system components to avoid legacy CPU IDS */
> -       id = coresight_trace_id_alloc_new_id(id_map, 0, true);
> +       traceid_flags = TRACE_ID_WANT_ODD;
> +       traceid_flags |= preferred_id > 0 ? TRACE_ID_WANT_PREFERRED : 0;
> +

move the flags calculations to the calling functions

> +       id = coresight_trace_id_alloc_new_id(id_map, preferred_id, traceid_flags);
>         spin_unlock_irqrestore(&id_map_lock, flags);
>
>         DUMP_ID(id);
> @@ -269,9 +280,9 @@ int coresight_trace_id_read_cpu_id(int cpu)
>  }
>  EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id);
>
> -int coresight_trace_id_get_system_id(void)
> +int coresight_trace_id_get_system_id(int id)
>  {
> -       return coresight_trace_id_map_get_system_id(&id_map_default);

drop the change to this function header and the call becomes
trace_id_map_get_system_id(&id_map_default, 0, TRACE_ID_PREFER_ODD)

> +       return coresight_trace_id_map_get_system_id(&id_map_default, id);
>  }
>  EXPORT_SYMBOL_GPL(coresight_trace_id_get_system_id);
>

Add in a  coresight_trace_id_get_system_static_id(int trace_id) API
function and call
trace_id_map_get_system_id(&id_map_default, trace_id, TRACE_ID_REQ_STATIC)

> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
> index 3797777d367e..a236cf87c169 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.h
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.h
> @@ -61,6 +61,12 @@ struct coresight_trace_id_map {
>         DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
>  };
>
> +enum trace_id_flags {
> +       TRACE_ID_ANY = 0x0,
> +       TRACE_ID_WANT_ODD = 0x1,
TRACE_ID_PREFER_ODD

> +       TRACE_ID_WANT_PREFERRED = 0x2,

TRACE_ID_REQ_STATIC

> +};

These flags can move to the coresight-trace-id.c file.

>  /* Allocate and release IDs for a single default trace ID map */
>
>  /**
> @@ -118,9 +124,12 @@ int coresight_trace_id_read_cpu_id(int cpu);
>   *
>   * Used to allocate IDs for system trace sources such as STM.
>   *
> + * @id: Preferred id value. If id is TRACE_ID_ANY, get a free id from id map.
> + * If id is greater than TRACE_ID_ANY, get a preferred id.
> + *
>   * return: Trace ID or -EINVAL if allocation is impossible.
>   */
> -int coresight_trace_id_get_system_id(void);
> +int coresight_trace_id_get_system_id(int id);
>
>  /**
>   * Release an allocated system trace ID.
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index f09ace92176e..0599303be326 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -643,6 +643,7 @@ void coresight_relaxed_write64(struct coresight_device *csdev,
>  void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset);
>
>  extern int coresight_get_cpu(struct device *dev);
> +extern int coresight_get_source_traceid(struct device *dev, u32 *id);
>
>  struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
>  struct coresight_connection *
> --
> 2.41.0
>

Regards

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

