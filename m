Return-Path: <linux-kernel+bounces-390731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9EE9B7DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5207F1F2145E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92CC1B3B28;
	Thu, 31 Oct 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KirEsZq+"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F941AFB35
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387581; cv=none; b=H4WIVNjHvnQvh6LbZ1gHsMdv16CMIfsZwHm5j7o61UKR3+jPn2UKGnU2ku1Xh/CZRu7lSeaWu5dp47frBPzLOGhDGcGjwZTWetYHQa23BiPR2r5UjtLAeDF/CFW5JUw6QRj7lYejBYzzuXRcfprUY4UkYj83UlSap/2gvCorRRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387581; c=relaxed/simple;
	bh=kr02wbYSWNCkbF9WCD3f3jrehlBz4QKbygRTAdCmEHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1his6SQ4CqRLG2Nmn/7kBdFp6jRwm6h8HPPsLty18Igifbg3fsgR197LAcf6NYvC0SP4eRXmZwgyLFhh0cnVLNnj4rub7OtqK8f89sOcnnVZsjWInmdOlDW+cc9SZ68xtEWql78E0krsM49L2JaloC/H+oIB5GcGZp7vtVZMLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KirEsZq+; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e38fc62b9fso8901627b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730387578; x=1730992378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3kq/ZfQo178WpGnp7avIFwOb49kRFsd7BrjOS/dXjIo=;
        b=KirEsZq+exLGPoyML4/+40BDpyFtnLYUgF7jco3Fe1XYI/0jgKqasZapXuRrWGVnmA
         KJ5fL0x6RzbYwNUhd+bXV0a7IfNYnYd+p7M5iz0p4fzPVCdf0zdB1hZIvXbIRNPktaFm
         sxgoKbelcctcSVYKGiXMJE0Mzm3Wa413MqdepmZK0BmhKYd3IsvvuDIuJLXNugYfen6x
         3rJhwSztP3HEpKLMdSKfucGYwDDynmj2VAoGJI7y3eTywcWvtJzKKdi6RY/OxZ4nxBd+
         /tYiVel0cV9Su+jLvN3iyyPQQjIZ0+mzeZ35EJe8psIQLCocH2msX/gpeMz3Cwoet5is
         ChCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730387578; x=1730992378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kq/ZfQo178WpGnp7avIFwOb49kRFsd7BrjOS/dXjIo=;
        b=KiQUb9WzV+4AgIIJfrPtWNfvcWD3TzpzVD7NbIrLBBd/1aO7JnIXQjikbhWRapOsKS
         IbAJdwZQH+naJuUXn9fQzXfNQv+/8W31fm8t8PoaWtWBo/XPbaCevz+vUur58O2RFSfs
         wmkGNbGbRp167HDvOhWB9rSjR3XLuvArTSTWkhG7gV3ufMbXFAM7+Yg97b8nz7nIKqD2
         IJIS6vQ+XnrktycLBXC4UHbGoy07zj5xjT1RvWAhgC6TJiST/ZcLMbEOo8X/pqdvSvpG
         Gxqy/7I5zXvie7fUsZwPg2jMJP0E0OfCNBIBw0V8PkM8ceea3mD5bnFDE3OxWd4OK3kD
         omtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTwQkWouiVvVZ3N7E1XkfUL3VEMF46AAd67r4mWg+MXJ/CPPybgd2/ONTcuqJ63LpM89mlkOksg2BwYM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykoRF+1Gz98OmnGMzgm7AYnbzzsk6sF4NVf7c+Q+dntzthUa+B
	tW1WE6UCuZR5/TbtleKNsc8qohKVNO6juATVl/oZSd8EPAxj1l8JPDOUgob6f9IRkIE5FMhz8Xu
	nxENC440DC3VhH6tbPVdg+r7ij+jJ8Ox928f/2A==
X-Google-Smtp-Source: AGHT+IGlMNJu4DDdD/Y1Axdwvh3uw+1T8q9MjgGCDRsqTJLHxT7tV2PbJ7zg2vq/LGfZxClDt4ZTbCxoj+EvkACSNbE=
X-Received: by 2002:a05:690c:380a:b0:6ea:4d3f:df9d with SMTP id
 00721157ae682-6ea64a8d45bmr3072217b3.4.1730387577820; Thu, 31 Oct 2024
 08:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019-qcs615-mm-clockcontroller-v1-0-4cfb96d779ae@quicinc.com>
 <20241019-qcs615-mm-clockcontroller-v1-6-4cfb96d779ae@quicinc.com>
 <zsgdwc6klccdbytdysgl342zllgmb7ttatjh4tnug3unyl7vl3@tlptei23yozn> <1eaa1fc6-721c-46fd-bcc8-9b575d083dea@quicinc.com>
In-Reply-To: <1eaa1fc6-721c-46fd-bcc8-9b575d083dea@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 31 Oct 2024 17:12:53 +0200
Message-ID: <CAA8EJprhyBpEyQYjCPopgEUVGF3ztGZ_6zo-QUPJ6=4VffEzZQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] clk: qcom: dispcc-qcs615: Add QCS615 display clock
 controller driver
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Stephen Boyd <sboyd@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 19:59, Taniya Das <quic_tdas@quicinc.com> wrote:
>
>
>
> On 10/19/2024 1:55 AM, Dmitry Baryshkov wrote:
> >> #include "common.h"
> >> +#include "gdsc.h"
> >> +#include "reset.h"
> >> +
> >> +enum {
> >> +    DT_BI_TCXO,
> >> +    DT_GPLL0,
> >> +    DT_DSI0_PHY_PLL_OUT_BYTECLK,
> >> +    DT_DSI0_PHY_PLL_OUT_DSICLK,
> >> +    DT_DSI1_PHY_PLL_OUT_DSICLK,
> > Is there a DSI 1 PLL on this platform?
>
> As per the design of the clock controller it has a DSI1 port.

It's just surprising to have the DSI1 DSICLK and not the BYTECLK. But
if you say so, it's fine.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

