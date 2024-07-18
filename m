Return-Path: <linux-kernel+bounces-256566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2826A935048
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A7BB2330E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1E814532B;
	Thu, 18 Jul 2024 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvRVKrVW"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F804144D3E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318267; cv=none; b=Rv0nb8id41Shjwwa2nrQwZ0xBtMtchdxJWkFhgV/NmXYQ9c7sPghigQ+YnUvEjPAJOfjkUFA7Zb4j28u5aJOoQCSiObkVU3m1hJS+x/7Sj/gZTpnjjI/3G+amh6COPqoplEXbeii7atwbNfSJcSTy0s6CeRKAjg7Oeu/VsIIxdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318267; c=relaxed/simple;
	bh=16fmhBnx+VjuzqSJhVynh6fThoOJBLLG3JzTtLr+Wzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gehlXkYp76f1YSI7dWddJ+cEx0mAyoNWoby0Xke3L/11Dxt8gfdiMwZM16rtuFAaTtF/zaDAPjC8AWcVIYvC4pm2LUf/EWYQGGdBR+SgumVQCzYs3GMmjqYbSSUAoenonTR7mEjIVGwIBNxQ978ghSX7XxbojcxPmrX03rl+dXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PvRVKrVW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b04cb28acso2688b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721318265; x=1721923065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aUOazNtZgahbZNIe1ko3EtaFbZsZJypf6FKKEyap+CA=;
        b=PvRVKrVWef7qb/oKCUuQtfMRj5EYg9TCJpp8axfvLMEkS7MZjMtYql5kSAxjU8wmZE
         Jm03uJJItS2p5WZ8W7Rio9l8U5yQLtllumfuG9xG/65NpEuKfvD2y0PRhahONm2wgId6
         FeL6NvxwRNAmg8kaUwO+/LAK3jU/Mk+oOzYmyy/yZ9PJIrhWEMBBWcjBSRAtm/1J3nvc
         h2O0UMm7uoU6YQ3jY3z8VmyxS1nFXkVH3QzNDYcMwtSDPFZvH1P5yD1BrNAnjgOOKprb
         gT3F0mkJ1V+uuRW7YfXASKXTrsGh5YpynzZDQ9TvoAGU2HR3wVYh9r1ktF6RyuL1MG/1
         5pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721318265; x=1721923065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUOazNtZgahbZNIe1ko3EtaFbZsZJypf6FKKEyap+CA=;
        b=dCWScFhpyly/mGC0/iMa2ToA4cJm4trqYVyoLKdZrnWSWs4J4K07A6wLtzlzpHyZgY
         qZq4XvFau/04iR1MawBQHv1iguXcw24QLnZYl0i901u/iigs0WaHjqa3iJs9qXSNsLMM
         kEQ6y3Ho3bDUHd7QfSic4A4fIiQSF0N7dq7Ys7La4IN/hdujo/SCuQ8KUpMjzXW3vjMr
         Djz/22gLi+Z/odM4qqeDca7nY7u4yCcejG3zUpEPkSoWHXCzJQ5g+Uzf4IuxBnsSbs0U
         LPehaLpg3YRhsNawShcgbhlaJE4LgczIPK3lEbLJiUomUO50b11lT0wLHJakBPoqKkJL
         NWDg==
X-Forwarded-Encrypted: i=1; AJvYcCXNL3mvjBXWBFWf0tpLDEOCbeTvBw8dYQ5FngglCIBGunKxklD7kXNCqgcLTGkocC5h2EyNt/C+OsFChJm+dyHnwrRko4XiaP92ljlj
X-Gm-Message-State: AOJu0Yy+fptay0uya3l1b04z2RSV3WDQitQhTYmRinAew4rdOLWFxDHc
	EKLty1sllZlvdjO2PeDfbIMKg2m+dlOwfklB7+IQugMNQCAwiIKt6RC16KLF4kQE5RUbl/4ytti
	jvdDNwPmVrv5q9podnE2SgFViekZB+XKeyvOIJQ==
X-Google-Smtp-Source: AGHT+IG8BxlqkGWqEeb+721jjFcIFxtCMvBNkuRDQHPWXpgXL4Mo9erFwADNMWLFeNyYDIxwkO/2RlwZIh37VMSzv5I=
X-Received: by 2002:a05:6a00:cd0:b0:70b:5368:a212 with SMTP id
 d2e1a72fcca58-70ceebb6d6dmr4399389b3a.15.1721318264694; Thu, 18 Jul 2024
 08:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626060724.28862-1-quic_jinlmao@quicinc.com>
In-Reply-To: <20240626060724.28862-1-quic_jinlmao@quicinc.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 18 Jul 2024 16:57:33 +0100
Message-ID: <CAJ9a7VhG4qNLnT87J7OiXpygbtMRZ8uAvNhZhcRCBxovMEPDEg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] coresight: Add preferred trace id support
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

I have detailed comments in the following patches but in summary we should:
1) consistently use the term "static trace id" for these devices where
the hardware sets a non-programmable trace ID
2) Simplify the patch set by introducing a new API function
int coresight_trace_id_get_system_static_id(int trace_id)
This would avoid having to change drivers which use the existing
function where no static ID is required.

Regards

Mike


On Wed, 26 Jun 2024 at 07:07, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Some HW has static trace id which cannot be changed via
> software programming. For this case, configure the trace id
> in device tree with "arm,trace-id = <xxx>", and
> call coresight_trace_id_get_system_id with the trace id value
> in device probe function. The id will be reserved for the HW
> all the time if the device is probed.
>
> Changes since V2:
> 1. Change "trace-id" to "arm,trace-id".
> 2. Add trace id flag for getting preferred id or ODD id.
>
> Changes since V1:
> 1. Add argument to coresight_trace_id_get_system_id for preferred id
> instead of adding new function coresight_trace_id_reserve_system_id.
> 2. Add constraint to trace-id in dt-binding file.
>
> Mao Jinlong (3):
>   dt-bindings: arm: Add arm,trace-id for coresight dummy source
>   coresight: Add support to get preferred id for system trace sources
>   coresight: dummy: Add reserve atid support for dummy source
>
>  .../sysfs-bus-coresight-devices-dummy-source  | 15 +++++
>  .../arm/arm,coresight-dummy-source.yaml       |  6 ++
>  drivers/hwtracing/coresight/coresight-dummy.c | 59 +++++++++++++++++--
>  .../hwtracing/coresight/coresight-platform.c  | 25 ++++++++
>  drivers/hwtracing/coresight/coresight-stm.c   |  2 +-
>  drivers/hwtracing/coresight/coresight-tpda.c  |  2 +-
>  .../hwtracing/coresight/coresight-trace-id.c  | 35 +++++++----
>  .../hwtracing/coresight/coresight-trace-id.h  | 11 +++-
>  include/linux/coresight.h                     |  1 +
>  9 files changed, 137 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-dummy-source
>
> --
> 2.41.0
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

