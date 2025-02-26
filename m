Return-Path: <linux-kernel+bounces-533346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B6CA458CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82306168877
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB9A20CCEA;
	Wed, 26 Feb 2025 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AInarJXT"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA73520C033
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559788; cv=none; b=bmsDcQ16zMhX4Fq7UH1d4CokuZKLDU6BPgz6/aFhfV8BCNTm3cTZ5oFWm9GGKRltB9yqeqwhJMv0J5ny80gJVu2xJ821jBB9Eln92l8xW3+ef4xuH2ANsjkaiuFdwfyfRXTK2NjipWdUSYYOFLnTNCAn8vQionXxXPVElrO7qRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559788; c=relaxed/simple;
	bh=gFxUO1ZJeey5NNh3RZFFk7xhQJI5Unus4snehkjECRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdXNI1QMLVUrt38cS+xN6hKjl1xJ/8lQlTWu4yMX9aU6x7MyZPJX9R254a1MeZHFaAknSoXshsjZL9zpxRZH+qE9edA0ol0j3hmWlUVEqkvyQeCRfPhhiggJ2u2MW6Jnl857fbUqhuRF7Xvl0o5DyvagcltSytfCrW8Pjx/t8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AInarJXT; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30a2d4b61e4so48021521fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740559784; x=1741164584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iBWsqS/whIX9PLa8T/uKhxlw/cCkygdxChh7NsPf6v4=;
        b=AInarJXTMZDxDBEo2U6x70mCtm7WS2qwMXaab7xlEhkpkixqPPBkLrm1yifdtnHhYr
         5QNqFigmaxtiBaJc+Ll7gKvPUlSmt5CfGCJV5B+jgbz57QH4PNguoYvNCQE3K4KaPLRY
         Yzxi/xICFTvH2zhvmU6tGHkP/5XN3VqMUBgF2gD+jEla/uqxevJC+xQpGQoiy6UH2Awo
         Vxj5Kt3GJOxscsQCvTYzXLE9xTppQ5nW9h3SHhaIEnV42wIk2i8G84p3qGWUrFSqtEHn
         QCOnbGjNKW6DWPA8bHcvrPR8ufG0fKeH1wWqxeN9/RBa1Ltrtkz5WzhBWjzE3NTavwd6
         W4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740559784; x=1741164584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBWsqS/whIX9PLa8T/uKhxlw/cCkygdxChh7NsPf6v4=;
        b=NVWCSvFgnDHqeStQIpFqibEKLMmWVUwrBmXDXIOZUte61Fy6weaUNq2Z8L5ly6eVd6
         K4V8UykV3pBqF8O/bX28LvW8ksWmREjSPt66n3ic9zw96TLYgPhvwTavtn2Ci5+sDBRM
         oJ1eaI4ifPophJS8PlrAeM6ihrBkRcNMYWG9c+/GzwJfM3BA42Qgckhm4dgqVGVGfKeI
         2AhWjqTNi0T+3VTb8/ugnNcRzqmi/jfwBRJoahBXpfHTxO47hzX6NX8YnGQ/8Rq0v+Zo
         rrdnQ/r4Fv2XFaQLPLB4a4JTyiJ/XbZq5Oqp7k0X2rCuLUOTw2q73JWbNfaEawUlUBlQ
         V0UQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9kAXORjssyQDkqupgPxb/wXXS9MoFf7bpV7A8Pu0tHtNBw0ow9wtMcj9yOkqCCKBiwqZbgtLQ5TbCgOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1AAg712rcm4brubAQ496pee5VaiXzBeJFbdJfMDyU0Z/iepQ7
	BSRvgj/KMydJerI81Uw32oZaHiMG0Zuc7QV8rSr4YBWWD3PomT1u69MnaUe8gL4=
X-Gm-Gg: ASbGncsyh+ffwZkda5N7/1aNDGA7717YfcO3pV38h07jB9W6PbQs5uGPz2oBZguPpvr
	hMl8zby+oIcYnqv+/gxU0G3j4bNl+RjejLBC3HFVaC5JMQXJi7OY2Xm5vXv74jnIyqy2Cq3ppQm
	olO4Pi4DGyPxq/3Pv48hgotAD3LKNRA1qz/Jj7zroBLNF2kNnUYOEJe6z9ODZ1xVh4gCvX8nsp0
	zJQrzU7zdQx8z4eOp58qzFOceraYpn30UBWOWiq8EpV5w6/ssH8dw8Y3EjFkb35dNJ4f47wlu7a
	XewtPUhMF3OIM5S3zyuqKDfWzeZ3t9Q3Dg+ei/oeuxbfaP2N5u60SLpDgUJY1UTfGyaoFpjne4J
	Z2Jk4jQ==
X-Google-Smtp-Source: AGHT+IFmNXDufx/J57BTLJkr+VSf9kHXFB6UwcnIhCd9d3vLZPOjvq5ZmG+p9/djmOEH4ULjuzqc/g==
X-Received: by 2002:a05:6512:39c9:b0:545:e2e:843a with SMTP id 2adb3069b0e04-5493c5b85e0mr2175585e87.38.1740559783671;
        Wed, 26 Feb 2025 00:49:43 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514f724csm380300e87.207.2025.02.26.00.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 00:49:42 -0800 (PST)
Date: Wed, 26 Feb 2025 10:49:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rudraksha Gupta <guptarud@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wctrl <wctrl@proton.me>
Subject: Re: [PATCH v2 2/2] ARM: dts: qcom: msm8960: Add tsens
Message-ID: <yuabzxapfn3xshnzicrgndcw4xnsgofpwfhqmzurhnfzeyjjbs@4awiletaxsna>
References: <20250226-expressatt-tsens-v2-0-7a4ce3a91f27@gmail.com>
 <20250226-expressatt-tsens-v2-2-7a4ce3a91f27@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-expressatt-tsens-v2-2-7a4ce3a91f27@gmail.com>

On Wed, Feb 26, 2025 at 12:11:09AM -0800, Rudraksha Gupta wrote:
> Copy tsens node from ap8064 and adjust some values

Which values?

> 
> Co-developed-by: wctrl <wctrl@proton.me>
> Signed-off-by: wctrl <wctrl@proton.me>

This doesn't look like a name.

> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8960.dtsi | 59 +++++++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry

