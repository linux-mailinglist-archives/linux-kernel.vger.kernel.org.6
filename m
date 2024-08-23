Return-Path: <linux-kernel+bounces-299631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D895D7DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA2C1F24A51
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BA01C7B8C;
	Fri, 23 Aug 2024 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cFTZss0A"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485231C6F7D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724445208; cv=none; b=C6eHCCHaHXqPYRt+f+8G+L5zBybaFoj9df4q9xlx9y5Giwc8MWAB6IZqIxm510qhb58n5TZAuwiWfFm4wPEEZMWwR5qh6X4htABIvuDe+/0Itq29gMT5r1aTWoM/mD3yJrlkb5dQ22Rib7cCI14wUUepGKm1ybFyHuqZHIhSZ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724445208; c=relaxed/simple;
	bh=MsOMxkYeIW9qydJzRqD0Ihv3BRacgITErjIgiRvw2KI=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8Ir4JQdQD3Eo/1lFWbZzYfaAh92gZyXRqiJeKw+ul/zvMqZd28XcdBqcBgpGIHQFh5SgsOWPNyzuJp5bIdnimuChJbzN2ra89h3whvigkFxtcxCgxxgNXlImG4u77VH1z64n2XylsUEF7DIDtluRTWgQiHxUpXxRXFo3jhhvkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cFTZss0A; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d42da3e9so152922185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724445205; x=1725050005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0Yyeee2Vf8r1D/wovFCOKuxZaGFv9fKeG3mfjxEVas=;
        b=cFTZss0AaAWpfKQeI8Idfc6fqkRGpIPKMJXs8fvEZraYzcmoJoA6hTJ0ThLIGiwNNr
         F30K72MKPjoT2g6KfmMBkTAFWbtAzmEoZbdYzgxKpYK5iHCSrUZOQDov+oWhG3O3YklN
         kVVUqJCL/yQJCif6Bv1AdisX4MGrx90wQGICg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724445205; x=1725050005;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0Yyeee2Vf8r1D/wovFCOKuxZaGFv9fKeG3mfjxEVas=;
        b=qe8oQYN0MfT+v5KJcy3H43bnyfLrzEe06baypESobYl/JL6YeeRO5SfqRNg0k0DiHF
         P4raEWfhClGpZ5hjQeDN68XYjkI0tEvyjYmvn68XMKX6wdtAAeh9YMKe1VKNpGplE/rP
         PihiJD5RUdaHNJVXOhVHNv7t8ElvNc/Y+4zeFhigDYI0z6rFVR6XtOKC2Tu2k/DZzuGu
         dtv+F5kPosOztSRGyO2gBX9hTe7phmGKdCvz81SGyfLN8DCZdsmOc0ZeTTN7pnpV3Kcr
         ZRRDuktt4jwvARRIDVBzkO3kLlgAc405rizwSms2Xn/DEXiE0SnduVp+6LWu70Rk4bca
         W41Q==
X-Gm-Message-State: AOJu0YyKEh0DwnLC/awSneqbJsPRRLkHw8Pjv9SKrXW6wvlylrGLHR5w
	PiXYTcXVgWf/kZWtR094DTc1pECztnxbLp5pfYOK7OrEDUC4Qno6Hfpz2gfcRBJ1iz2YTphWd4Q
	iEXgQ1+yjdIql0MTVDhSo6oLo+9LHH/Qzz1ND
X-Google-Smtp-Source: AGHT+IGW/VO5LDbH2qUnWbdRuqhhtG11KOFQeC4peX75Dv4BIQ4AXaDFfDgoU0VrJw72vzH9xwkXBWdGeZo2zOTAGgE=
X-Received: by 2002:a05:620a:461e:b0:79f:dce:76c7 with SMTP id
 af79cd13be357-7a6897c444dmr460409785a.68.1724445205109; Fri, 23 Aug 2024
 13:33:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Aug 2024 13:33:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d03d5425-bd7c-4c20-a54e-5708ffd059e0@linaro.org>
References: <20240819233628.2074654-1-swboyd@chromium.org> <d03d5425-bd7c-4c20-a54e-5708ffd059e0@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Fri, 23 Aug 2024 13:33:24 -0700
Message-ID: <CAE-0n52=kQzEx76D5AmZfui_X0jqejQ+ENz+VQunY_ovph65Hw@mail.gmail.com>
Subject: Re: [PATCH 0/2] clk: qcom: gcc-sm8550: Fix shared clk parking breakage
To: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	neil.armstrong@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	patches@lists.linux.dev, linux-clk@vger.kernel.org, 
	Amit Pundir <amit.pundir@linaro.org>, Taniya Das <quic_tdas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

Quoting neil.armstrong@linaro.org (2024-08-21 08:44:00)
> Hi,
>
> On 20/08/2024 01:36, Stephen Boyd wrote:
> > Amit Pundir reported[1] that a recent commit 01a0a6cc8cfd ("clk: qcom:
> > Park shared RCGs upon registration") broke USB and audio on sm8550-hdk.
> > These two patches fix the issue by skipping the parking bit of the
> > shared RCGs for devices that can't run so slow.
> >
> > [1] https://lore.kernel.org/CAMi1Hd1KQBE4kKUdAn8E5FV+BiKzuv+8FoyWQrrTHPDoYTuhgA@mail.gmail.com/
> >
> > Stephen Boyd (2):
> >    clk: qcom: gcc-sm8550: Don't use parking clk_ops for QUPs
> >    clk: qcom: gcc-sm8550: Don't park the USB RCG at registration time
> >
> >   drivers/clk/qcom/clk-rcg.h    |  1 +
> >   drivers/clk/qcom/clk-rcg2.c   | 30 +++++++++++++++++++
> >   drivers/clk/qcom/gcc-sm8550.c | 54 +++++++++++++++++------------------
> >   3 files changed, 58 insertions(+), 27 deletions(-)
> >
> >
> > base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
>
> I'm pretty sure sm8450 & sm8650 (and probably other SoCs) could be also affected, could you check ?

Does someone have the hardware to test? It looks like sm8450 isn't using
the shared ops, but sm8650 is, likely incorrectly.

