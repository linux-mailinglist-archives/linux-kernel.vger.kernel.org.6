Return-Path: <linux-kernel+bounces-376040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D429A9F22
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB6F1C240B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F9919922E;
	Tue, 22 Oct 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ec+JUy4C"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E667198E91
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590586; cv=none; b=knl9qeiMM5Fo/xCvtlMEefhp91bifqsjhLDxHr3pGjT/RbzkvOsXCHkZ4+wJdrkIWjtb4e9wWdWolj7OPL1N9TTVbtrOGWD0eFQImJuwf4MI5w+tNxp+WsnNUPFf7coIYlB6Oqn+Y4htvsYRdW0MyIPGt1huHq9syd1h+/bZeMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590586; c=relaxed/simple;
	bh=hukhZ0JdkxZMUnts7W1+np8Vaq1LaRi3J50G2AUQ/LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYByzva3a/pXwanZUvuZpMKT5llRgUKblMJjBdBnZ3iLv4Ke41RJ32yegJyc5fKnigWcaZh+ttDzhf114GZJOQ+yfS+T/K+NiLIwDg4QvG4zXcEqjtZ1C9AzcCs4JZHUbvWwySSs6/cv95W3v7LKxA4iLrRgUYgbgLeNuY2TL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ec+JUy4C; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e7086c231so4088229b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729590584; x=1730195384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ufXLjONP873xK2SyCedwjtY2SS+lr/2DtUSUzSEgF4=;
        b=ec+JUy4CazgPj040El3prGctOuo5DuRSah52hKVJuhQwneQ/4bFpiaC5miqp1TVFUM
         JrzMeqZfbBIa89zCrPmfcRHK/QoMKOnVfGDqVumr1sNyTrbA1YFNLLuLUTShtaCV/jx6
         JTdcbv3yvw7zn3TaCA4JYAHNA/OBDN1GzcmPAq5fvL84V8/Hc205hmOLcx3Tg+0Kv07N
         gJTiP2msfqYskBZ+o0jLyd6PXTNsMfsQNr0fJUQgIMpstwXUJI7tjM8R6hHMSQcyPpps
         tDP2Ck4lP5YZYTtdRd/tIkkQzJTI2fJnwK2fO/RzIXB8qDaLmnjwjQkx1oixi420Lc7E
         0fAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590584; x=1730195384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ufXLjONP873xK2SyCedwjtY2SS+lr/2DtUSUzSEgF4=;
        b=SgPIuUuKHrTaXmkJNPa1Q6/0EvuuuyHdiJ/O5vW650rJUyTTnK3kO0IMEm9d1J1YFR
         UNe09ncq6A87Kra94SVWwjk+uaFmAt+d5NyYpPD9sNllHFtHK5VgXVRPd2VNOdbSYY+Q
         Fpdq9osTNppKbCTraTIFwAptTGCHytYQOrSN38SZcwb60sF8E5CQjJ+6dmtAJT7vjSIi
         MLRtuE5fRQlGUhpN9ZtfVKIR/3ABoP/Lwh9Pv5Fb4RgK7JtVEAF6zVxN1JdhFCSQFvWt
         X81REDXE6BDieP+KYYkuF0lGeTXW8EM1dscHnQviA2Cp9qfQctA/oExGiFHKzzMpfUyw
         OqqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSgYER0cNdntxtrVvMGhElGJIWqTFwtPXAYG+VxS53UsYP6DknG/Hc3eUu/xRpf+wR5v4LGUhcP1Qv1Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLi8QkBcsaqWTe6oP4++HEmia7yySUFl7C2ryZIK0/RdqMNJOM
	ytQQuA6JS0oaw4IfiNUub5e6TlKGt3VqPwQ5Su5jhhBwd7W0dQ1nkv/I3txiu91gauhJzgm6yH/
	iIhcJceSfgfh4rgQdgkk+m9xRVjKtgOpMCWtQBQ==
X-Google-Smtp-Source: AGHT+IGliJYiVq1k4ZNGo00dxGyPgZaVg7h0N1CABZQjyJ7rDlHgwHHA9dsjGpSi8AHVLg33D12YdwzucwzvLxY8H/k=
X-Received: by 2002:a05:6a21:1693:b0:1d8:a49b:ee71 with SMTP id
 adf61e73a8af0-1d92c51e66dmr21535610637.29.1729590583690; Tue, 22 Oct 2024
 02:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018032217.39728-1-quic_jinlmao@quicinc.com>
 <20241018032217.39728-4-quic_jinlmao@quicinc.com> <b2f9aa93-a50a-4bfd-9df0-9e3a170404f8@arm.com>
 <4ddc9078-1059-45a2-8f44-c904d62c854f@arm.com>
In-Reply-To: <4ddc9078-1059-45a2-8f44-c904d62c854f@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 22 Oct 2024 10:49:32 +0100
Message-ID: <CAJ9a7VgJu4mzcbTpd=TytQnu0vPFZeS8uyNb9swamTpNXxnBew@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] coresight: dummy: Add static trace id support for
 dummy source
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mao Jinlong <quic_jinlmao@quicinc.com>, James Clark <james.clark@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 13:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 21/10/2024 13:31, Suzuki K Poulose wrote:
> > On 18/10/2024 04:22, Mao Jinlong wrote:
> >> Some dummy source has static trace id configured in HW and it cannot
> >> be changed via software programming. Configure the trace id in device
> >> tree and reserve the id when device probe.
> >>
> >> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> >> ---
> >>   .../sysfs-bus-coresight-devices-dummy-source  | 15 +++++
> >>   drivers/hwtracing/coresight/coresight-dummy.c | 59 +++++++++++++++++--
> >>   2 files changed, 70 insertions(+), 4 deletions(-)
> >>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-
> >> devices-dummy-source
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-
> >> dummy-source b/Documentation/ABI/testing/sysfs-bus-coresight-devices-
> >> dummy-source
> >> new file mode 100644
> >> index 000000000000..c7d975e75d85
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-dummy-source
> >> @@ -0,0 +1,15 @@
> >> +What:        /sys/bus/coresight/devices/dummy_source<N>/enable_source
> >> +Date:        Oct 2024
> >> +KernelVersion:    6.13
> >> +Contact:    Mao Jinlong <quic_jinlmao@quicinc.com>
> >> +Description:    (RW) Enable/disable tracing of dummy source. A sink
> >> should be activated
> >> +        before enabling the source. The path of coresight components
> >> linking
> >> +        the source to the sink is configured and managed
> >> automatically by the
> >> +        coresight framework.
> >> +
> >> +What:        /sys/bus/coresight/devices/dummy_source<N>/traceid
> >> +Date:        Oct 2024
> >> +KernelVersion:    6.13
> >> +Contact:    Mao Jinlong <quic_jinlmao@quicinc.com>
> >> +Description:    (R) Show the trace ID that will appear in the trace
> >> stream
> >> +        coming from this trace entity.
> >> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/
> >> hwtracing/coresight/coresight-dummy.c
> >> index bb85fa663ffc..602a7e89e311 100644
> >> --- a/drivers/hwtracing/coresight/coresight-dummy.c
> >> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
> >> @@ -11,10 +11,12 @@
> >>   #include <linux/pm_runtime.h>
> >>   #include "coresight-priv.h"
> >> +#include "coresight-trace-id.h"
> >>   struct dummy_drvdata {
> >>       struct device            *dev;
> >>       struct coresight_device        *csdev;
> >> +    u8                traceid;
> >>   };
> >>   DEFINE_CORESIGHT_DEVLIST(source_devs, "dummy_source");
> >> @@ -72,6 +74,32 @@ static const struct coresight_ops dummy_sink_cs_ops
> >> = {
> >>       .sink_ops = &dummy_sink_ops,
> >>   };
> >> +/* User can get the trace id of dummy source from this node. */
> >> +static ssize_t traceid_show(struct device *dev,
> >> +                struct device_attribute *attr, char *buf)
> >> +{
> >> +    unsigned long val;
> >> +    struct dummy_drvdata *drvdata = dev_get_drvdata(dev->parent);
> >> +
> >> +    val = drvdata->traceid;
> >> +    return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);

sysfs_emit() is the convention moving forwards - this handles all the
PAGE_SIZE issues automatically

> >> +}
> >> +static DEVICE_ATTR_RO(traceid);
> >> +
> >> +static struct attribute *coresight_dummy_attrs[] = {
> >> +    &dev_attr_traceid.attr,
> >> +    NULL,
> >> +};
> >> +
> >> +static const struct attribute_group coresight_dummy_group = {
> >> +    .attrs = coresight_dummy_attrs,
> >> +};
> >> +
> >> +static const struct attribute_group *coresight_dummy_groups[] = {
> >> +    &coresight_dummy_group,
> >> +    NULL,
> >> +};
> >> +
> >>   static int dummy_probe(struct platform_device *pdev)
> >>   {
> >>       struct device *dev = &pdev->dev;
> >> @@ -79,6 +107,11 @@ static int dummy_probe(struct platform_device *pdev)
> >>       struct coresight_platform_data *pdata;
> >>       struct dummy_drvdata *drvdata;
> >>       struct coresight_desc desc = { 0 };
> >> +    int ret, trace_id;
> >> +
> >> +    drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> >> +    if (!drvdata)
> >> +        return -ENOMEM;
> >>       if (of_device_is_compatible(node, "arm,coresight-dummy-source")) {
> >> @@ -90,6 +123,25 @@ static int dummy_probe(struct platform_device *pdev)
> >>           desc.subtype.source_subtype =
> >>                       CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS;
> >>           desc.ops = &dummy_source_cs_ops;
> >> +        desc.groups = coresight_dummy_groups;
> >> +
> >> +        ret = coresight_get_static_trace_id(dev, &trace_id);
> >> +        if (!ret) {
> >> +            /* Get the static id if id is set in device tree. */
> >> +            ret = coresight_trace_id_get_static_system_id(trace_id);
>
> This may be worth an error message, it is a rare one. Othewise, there is
> no clue on what caused the failure. Or have a specific error code as a
> result ?
>

The called function does actually emit an error message - but a
comment to that effect would clarify this.

> >> +            if (ret < 0)
> >> +                return ret;
>
> e.g., return -EBUSY ? /* Device or resource not available */
>
> >> +
> >> +        } else {
> >> +            /* Get next available id if id is not set in device tree. */
> >> +            trace_id = coresight_trace_id_get_system_id();
> >> +            if (trace_id < 0) {
> >> +                ret = trace_id;
> >> +                return ret;
> >> +            }
> >> +        }
> >> +        drvdata->traceid = (u8)trace_id;
> >> +
> >>       } else if (of_device_is_compatible(node, "arm,coresight-dummy-
> >> sink")) {
> >>           desc.name = coresight_alloc_device_name(&sink_devs, dev);
> >>           if (!desc.name)
> >> @@ -108,10 +160,6 @@ static int dummy_probe(struct platform_device *pdev)
> >>           return PTR_ERR(pdata);
> >>       pdev->dev.platform_data = pdata;
> >> -    drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> >> -    if (!drvdata)
> >> -        return -ENOMEM;
> >> -
> >>       drvdata->dev = &pdev->dev;
> >>       platform_set_drvdata(pdev, drvdata);
>
> Additionally we should drop the system_id if registering the coresight
> device fails.
>
>
> Suzuki
>
> >> @@ -131,7 +179,10 @@ static void dummy_remove(struct platform_device
> >> *pdev)
> >>   {
> >>       struct dummy_drvdata *drvdata = platform_get_drvdata(pdev);
> >>       struct device *dev = &pdev->dev;
> >> +    struct device_node *node = dev->of_node;
> >
> > ^^ Why is this needed ? The rest looks fine to me
> >
> >> +    if (IS_VALID_CS_TRACE_ID(drvdata->traceid))
> >> +        coresight_trace_id_put_system_id(drvdata->traceid);
> >>       pm_runtime_disable(dev);
> >>       coresight_unregister(drvdata->csdev);
> >>   }
> >
>

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

