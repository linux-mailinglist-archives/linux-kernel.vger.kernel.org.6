Return-Path: <linux-kernel+bounces-376041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419929A9F26
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6229B1C244EA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B3196DA2;
	Tue, 22 Oct 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJkm1B1t"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882461991B6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590596; cv=none; b=EtRSrGs3TmI+YfM1bxuYmBiOZx5rqkjK1Ic7t2Jmm17VAyr5gwYR13davPLiOoFI9A/mrM7qGa0B9C4Zcse/Q4UfXW8fsJ3BVLvl7eomxovK2Fxl5q1yIBazSYz8KvQttsdwQTxFiih7kl0dY+gJfULK0AvmWkg7KrrL2YNICE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590596; c=relaxed/simple;
	bh=ucPxv8v8063nhyvHkY26XrVe11xBeay7vWd4UaefvoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AW8Hh9kH+XKMZQIT5W0CqRNszkwl/OU27qDjugPi8LFOSAfkOaCd9g7ctrCHc79n/yHbE9N3WSR8Gg7tYTi7/zrVSwGLMnQokyRac6an20/bMamzgcz5PZKZQsGXyuFEz98kSBP66JqWEuIvuVX+XziKvuJeFbZymt++2lCfZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJkm1B1t; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea16c7759cso2883637a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729590594; x=1730195394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fRj9OXTql8TyVlExpaWtvY5+P9nZhBqC5DIwNAggGns=;
        b=HJkm1B1tsymwVAQmxgMlGelN6XZuRiwaq/KxTjg8qKenZr7B98Ltv0GmFjS9K0lND9
         y2dgc6AefLHtWasbrcPf+cG6+XotSdXV2kKIhJYryUBj2zYuu9TcV3DRh6+3jD0p6yEs
         QS8GF/oI4wIQoUvtFkJWRNtjoBsqpXnZvKeEa+2s6uPOOyGVWsxTcQXo1QABdJijMH5y
         fqoUPgw8ASxPufJ2S0nfs6uWm4I1IDooKG5DYuf1/hbxnJle0yNLk+PczRtaXa4jdInN
         7R4lq6TEFdCaL7BeIJdayFeG7ls9TqRubknDETG23ZmpG4ZdBpJttq3xVlPZLE+ay/uR
         pgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590594; x=1730195394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRj9OXTql8TyVlExpaWtvY5+P9nZhBqC5DIwNAggGns=;
        b=oFJGk+wD/fUiAwYEMfCVhaa5CVmGzdQViPrgW0CJsZDbWA+mjVUCJFGYrf4KPKqNEH
         QX/sIVXCUaDeaZ8GQAY0ynCETLx9m7vw4TWQzOKRGUfKq1wmiN2+BPTf7YcWQX77ryGO
         08+ZD1Hi2yjvSSdBD7l5hriM4LM3jARECKPjDXf5ELT8nhmV5SDc8COf/rE0Mn1duS4p
         FKrfbB9R1oPNgcN7qKn+M/cCKyHAQsDRV6Hr3HdOugz4k1EE3ylLwDY81q2VL8NcgjvZ
         fmPQcxlyFKWwazMOgwUdMjDxBXRoEcont4+wwxAFbtbw4Elr/eMYqNathBKTTBRB2znN
         S6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMoMkMyS4KMg3hIz16TkhPdhcl1YQYtwbx6c209mmaWiTA5DtT1wtIjnVCILvFF94yMBOE+1rnC45nUmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAgjQ0JxQI37VQD27EidXXb3J3Q/kOvlaaelFFznNvOdeuGXgJ
	XiVZQbWjLSjzzuNbA3q9wL+5pTS3QFq4mF/FLpgNzK5OYNKmGjTYPj0AtjrP+1yz8jCy28QRWm2
	ltl3VALBOTIeJdWLr2tClMDbaed0C6suiqxDieA==
X-Google-Smtp-Source: AGHT+IEPl8TvCF4WHMkzmV6+C+089KSglwEosAUtKdVvP3kM20qYnQAdlYOhAKr/lEnlRi0DAeAxzTVKxy3L2gEvDpE=
X-Received: by 2002:a05:6a21:e88:b0:1c4:9f31:ac9e with SMTP id
 adf61e73a8af0-1d96df3bf9bmr1994876637.42.1729590593804; Tue, 22 Oct 2024
 02:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018032217.39728-1-quic_jinlmao@quicinc.com> <20241018032217.39728-2-quic_jinlmao@quicinc.com>
In-Reply-To: <20241018032217.39728-2-quic_jinlmao@quicinc.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 22 Oct 2024 10:49:41 +0100
Message-ID: <CAJ9a7VhkGrr10hT8-5r6Zp8SZj5hJjos8ZdPeOhuPqenMht_xw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: arm: Add arm,static-trace-id for
 coresight dummy source
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 04:22, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Some dummy source HW has static trace id which cannot be changed via
> software programming. Add arm,static-trace-id for static id support to
> coresight dummy source.
>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/arm,coresight-dummy-source.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
> index 04a8c37b4aff..742dc4e25d3b 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
> @@ -38,6 +38,12 @@ properties:
>      enum:
>        - arm,coresight-dummy-source
>
> +  arm,static-trace-id:
> +    description: If dummy source needs static id support, use this to set trace id.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 111
> +
>    out-ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>
> --
> 2.17.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

