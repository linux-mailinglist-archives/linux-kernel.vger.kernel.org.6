Return-Path: <linux-kernel+bounces-433623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EDB9E5ABD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A659188383D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC9021CA1E;
	Thu,  5 Dec 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornersoftsolutions.com header.i=@cornersoftsolutions.com header.b="KssXXnKL"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9C19342F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414853; cv=none; b=e04r61inGz5/Q5LhvdapTL92d0V0tmT+1z+uikdm1gRAKDllDjW/i7M5ezSlaWF/k7QzpzjvNWGDU2Z/otCl6r0DPQEkJ9bEkU1BvN/E/qbpMI/VsV2Nfl6mylrbqRYMR2uIj+7LknRZ4eemzCG4pUa+5AojDu8Vx/8yiNf2Qyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414853; c=relaxed/simple;
	bh=KOckcNe8W3RQKx65UzBFy6XStXAxVc8nCNjDX8cXNw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8vc5KCl3ozvqa0l8YFaE0A43bQzZYzwf2zwcrCk7O+h8KC3M2SWkKdjOMu+9tBsxM8wHg1NQqLtWQ/q2LjHEYQu8ceYGpfrOfkrBY+ihW+qo6S+n88ZLpXCTHOfiLHiKT7ReV6a4aacmw4GNOz6CnTkNsSBXcwFoJf9Ojk/Bbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornersoftsolutions.com; spf=pass smtp.mailfrom=cornersoftsolutions.com; dkim=pass (2048-bit key) header.d=cornersoftsolutions.com header.i=@cornersoftsolutions.com header.b=KssXXnKL; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornersoftsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornersoftsolutions.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-288fa5ce8f0so331260fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cornersoftsolutions.com; s=google; t=1733414851; x=1734019651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOckcNe8W3RQKx65UzBFy6XStXAxVc8nCNjDX8cXNw0=;
        b=KssXXnKLjSzDbkwDi6QArPLrpHMWryNsr44YocM3Djj7WjuPgnFEqHG3srma7I6SY9
         Tp8nOrHwRgaPnegnVODTpNBjJgoDc/kqWcG9j3bfKem4uEORtABqgMRiTLS1CQMcqrQB
         BMVKw4kTvbTuCRwc2TkePE2i1+O8FtmxzCTMJKsD/aA58oWK7sa6uGXNyL+3GnkcRz5Z
         jkPVLkNpamltrB95eX2/hOnsUXqI25KCLqfBfB+oKSPQzWNdOZTjbZHnFgSC6oQSdFfg
         RLdUwRPFmVQ/4BPYCx9xReHRqkRREvGLmnpttkKPPXsTDX8p1mYYjVe2VwxfixnxbPDj
         l04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733414851; x=1734019651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOckcNe8W3RQKx65UzBFy6XStXAxVc8nCNjDX8cXNw0=;
        b=lLr5AkIyv6/ej++dZUKqGMUh3Ok6eY0KQAF/Drg5z77S+Nw4usIj65hWPzfa4KH0kT
         GtdQkL/tENynCF15AxeIFzC5oI3vAT1hv+0KiVAnorZucrMkHrlxGZyGygEHR6D488RW
         OGwQRwuw/OBUkioRuBrldTQbz41ffyKEyFKt30ayeDlf6W1KcH6ZwSHNMJF7nDXTjKtO
         Pe23BddSeCcRf/TEqP23IAWLeaEuN74x3NvUQOl9gRTu5eFXzQ6lQVgZtElmCyKoPNWa
         RRtMQKL2IVthaM2m7q1XRiB7nDUbiisAKpgkMbi5tQ/twybFM1V48npNSN2l3lm/2sRm
         qpWg==
X-Gm-Message-State: AOJu0YwNzA7bIvdzTltgCPWPEWqRxcoVRkHbfmif01wo6Y/IK22fmdhy
	5/yZ7K65luhLf2gQ/Hs1fiRb66yn3CwMf76tCtfeISQYQ7Xra6c/+m7U7Nd3rE/B06DP8U4WI7x
	B/UAp52GYe4hESwaNHS44fLPyntEB5TppnTfCyg==
X-Gm-Gg: ASbGncsIShrqfZozn8bTnd89kZ1QbY2ziW5QCq+1y6edkx4aOGQXdaEe9t3xzcQjn/0
	1vBVWAs1nWQdbOsasv7aUQUXxKlV/4usK
X-Google-Smtp-Source: AGHT+IFc4uqMYZT0SxPqLKcDtYnZCPI05fbA21AsNVCAy81bsUwRL7Rs+7Wfd6hN5qQc+lT4SQo91gDOIfd4QY1CTs0=
X-Received: by 2002:a05:6871:4b83:b0:29d:c832:840d with SMTP id
 586e51a60fabf-29e8890d522mr10222701fac.35.1733414850886; Thu, 05 Dec 2024
 08:07:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADRqkYAaCYvo3ybGdKO1F_y9jFEcwTBxZzRN-Av-adq_4fVu6g@mail.gmail.com>
 <d53538ea-f846-4a6a-bc14-22ec7ee57e53@kernel.org>
In-Reply-To: <d53538ea-f846-4a6a-bc14-22ec7ee57e53@kernel.org>
From: Ken Sloat <ksloat@cornersoftsolutions.com>
Date: Thu, 5 Dec 2024 11:07:20 -0500
Message-ID: <CADRqkYDnDNL_H2CzxjsPOdM++iYp-9Ak3PVFBw2qcjR_M=GeBA@mail.gmail.com>
Subject: Re: [PATCH v1] dt-bindings: dma: st-stm32-dmamux: Add description for
 dma-cell values
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	dmaengine@vger.kernel.org, alexandre.torgue@foss.st.com, 
	mcoquelin.stm32@gmail.com, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, vkoul@kernel.org, amelie.delaunay@foss.st.com, 
	Ken Sloat <ksloat@cornersoftsolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thanks for reviewing

On Thu, Dec 5, 2024 at 10:59=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 05/12/2024 16:32, Ken Sloat wrote:
> > The dma-cell values for the stm32-dmamux are used to craft the DMA spec
> > for the actual controller. These values are currently undocumented
> > leaving the user to reverse engineer the driver in order to determine
> > their meaning. Add a basic description, while avoiding duplicating
> > information by pointing the user to the associated DMA docs that
> > describe the fields in depth.
> >
> > Signed-off-by: Ken Sloat <ksloat@cornersoftsolutions.com>
> > ---
> > .../bindings/dma/stm32/st,stm32-dmamux.yaml | 11 +++++++++++
> > 1 file changed, 11 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamu=
x.yaml
> > b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
> > index f26c914a3a9a..aa2e52027ee6 100644
> > --- a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
> > +++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
> > @@ -15,6 +15,17 @@ allOf:
> > properties:
> > "#dma-cells":
> > const: 3
>
> Your patch is corrupted. Please use git send-email or b4 or b4+relay.

Sorry about that, I will do that. I will wait for any additional
comments and then re-submit.

>
> > + description: |
> > + Should be set to <3> with each cell representing the following:
>
> Drop this part, const says this.

Ok

>
> > + 1. The mux input number/line for the request
> > + 2. Bitfield representing DMA channel configuration that is passed
> > + to the real DMA controller
> > + 3. Bitfield representing device dependent DMA features passed to
> > + the real DMA controller
> > +
> > + For bitfield definitions of cells 2 and 3, see the associated
> > + bindings doc for the actual DMA controller the mux is connected
>
> This does not sound right. This is the binding for DMA controller, so
> you are saying "please look at itself". I suggest to drop this as well.
>

While logically it is the DMA controller, this doc is specifically for
the mux - the DMA controller has its own driver and binding docs in
Documentation/devicetree/bindings/dma/stm32/st,stm32-dma.yaml

I can reference st,stm32-dma.yaml directly, but I was unsure if this
mux IP was used with another DMA controller from ST on a different
SoC.

What do you suggest here?

>
> Best regards,
> Krzysztof

--=20
Sincerely,
Ken Sloat

