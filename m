Return-Path: <linux-kernel+bounces-274504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8A59478FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6B11F2228C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F13B154BE3;
	Mon,  5 Aug 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3TTsa+D"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C501547DC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852286; cv=none; b=ooB0FD8OSAh86fKVHJywi1zG4WVn1d51J92/ehrKAYG1YwR4FfYoqrp/af5Ln4xb7q5B4E7wyf/jEAGKQgOTh+yNka5yjxxfRU4AwU3sSIcnkYryTaLpAAZfL9Aha/OZzSk3H9AdnFATvzj8IaR3yMOvhBIJioHmP3vxjsLt2iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852286; c=relaxed/simple;
	bh=NrP89VFBY7rsx7EbXcSXKLeYzXolWV8BMUaTDdNiuIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJtCXjVzduqNJCff8nHl3o0yAJlRbqvw4AjLKPvGJ/lIqZ3bmv85oI/v9XyVDPVF7CsFhUCQLNOfIiqvbcH4dSUKltJul3Z/mNMpRyFGr/yPncv0SFd8n1RS2E+yoR87aNrGyf8/evS1liXI7xnIJMyJfAVCO8P3nYm9UcD3PDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O3TTsa+D; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e03caab48a2so4353433276.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 03:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722852284; x=1723457084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hSYGTPrpLH+BuhVL/Q/2E8uLKhl1KfRAsEdIshJ8Sjg=;
        b=O3TTsa+DOEhyRzwzJxdy1IBqByszFg6gCQwqgUQD/YS+eunwj3Okal63tnHQD3gFzS
         mklCASjot+6W+j97Q9xgl+oMyXSXffRPE8CpBS1WTM+6tDBfIZtqdT/xazSIL7wGnYi1
         z/lmgqcTj2hExLsPZ2dWUEHuNUmiVHEG1MlLjr0hxpxldcYNbiO+ACcjROcraZAdg8Av
         yEItCOtmHBCJCIez6ao8zHGxGWnbKuWU0un2VLkYOIVqKmybvzwzrIW6SvPANNZvR1v0
         Bn+AEWvutwS8jgZmVCDuKX0NDvqLA+PLLQDqsqk0KYPRn+J13KxhyrK/KuKNSL//s/tU
         kMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722852284; x=1723457084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSYGTPrpLH+BuhVL/Q/2E8uLKhl1KfRAsEdIshJ8Sjg=;
        b=sAPdw5WFKzM3PvdwDdQguLV3/PuJeBicilOMmp3ln9a7x2Oi3zwQoOFOdevACAwLMX
         ksrlUIi9rddtcDH3KlM+6GzF0CLhDVnNDh7J/JB5OI37d37oeA8BwMuliEj920SK8HZ5
         7k+j1Sj0dvecngchwcjG9r55wWXL2BiYV2LwiBhqlQFnShj6NCpx0i9n1MAx2ql6AoZq
         y8LufPmURtYv3Uqn1COK+k5uxYpGgHRkP3pxuplax9kLXwaOpQycKTOIXM+X9RYRq5lA
         Lf0LWpcxtXT3beOfCodEkOXQrtoin3Lfx1jetu5G9zN5S3HdaddCkzuXHbBY1WJYcnzs
         tmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1JDHTjflLVtQsVl44SjUqXHhsS+Y6+g5Djx6sk+JgFaTjrxqI506C+/8QIVRYHZHAvm8uQ5pYGBCQVZL8qhMHx1T7F++sn342/bVP
X-Gm-Message-State: AOJu0YwPRdxg1EsXg3zSljYaMRKd6RyaGaZIKrQEbIKzUd2J3BougLd8
	zEsDEgGm7A5x3xlUURfllhdvFgZz4TzU3FJjYPkKkcQMfo8dOBHsXiHdOTlef1e4dxPi7tbYGk+
	eXlT/Dt68UTScRXLQKNSgrSmcygmaqTQfSpjsww==
X-Google-Smtp-Source: AGHT+IE28QvjYWO5xF3nlYl96xgvVqGoKpL4LpWlRu2pROebD4A3WQjuKfY14W5cvKLlfjChMzAEUCdDmxnejwKRHho=
X-Received: by 2002:a05:6902:2b0d:b0:e0b:bf20:4fdd with SMTP id
 3f1490d57ef6-e0bde8ee6f3mr10631170276.1.1722852284031; Mon, 05 Aug 2024
 03:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805040131.450412-1-felix@kaechele.ca> <20240805040131.450412-2-felix@kaechele.ca>
In-Reply-To: <20240805040131.450412-2-felix@kaechele.ca>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Aug 2024 12:04:07 +0200
Message-ID: <CAPDyKFqyRevbmPy6h8BsiTLBi6=J+9uRmSib43bzzZHFEmDSVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: sdio: add Qualcomm QCA9379-3 SDIO id
To: Felix Kaechele <felix@kaechele.ca>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 06:01, Felix Kaechele <felix@kaechele.ca> wrote:
>
> Adds the id for Qualcomm QCA9379-3 SDIO based cards such as
> the LITEON WCBN3510A and Silex SX-SDMAC2.
>
> Signed-off-by: Felix Kaechele <felix@kaechele.ca>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  include/linux/mmc/sdio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 7cddfdac2f57..63000a8f4b13 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -52,6 +52,7 @@
>  #define SDIO_DEVICE_ID_ATHEROS_AR6004_19       0x0419
>  #define SDIO_DEVICE_ID_ATHEROS_AR6005          0x050A
>  #define SDIO_DEVICE_ID_ATHEROS_QCA9377         0x0701
> +#define SDIO_DEVICE_ID_ATHEROS_QCA9379         0x0801
>
>  #define SDIO_VENDOR_ID_BROADCOM                        0x02d0
>  #define SDIO_DEVICE_ID_BROADCOM_NINTENDO_WII   0x044b
> --
> 2.45.2
>

