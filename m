Return-Path: <linux-kernel+bounces-263122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D993D153
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC85281B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3650178CC8;
	Fri, 26 Jul 2024 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmrMoLFH"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7045178390
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721990648; cv=none; b=U0heCwUh6i8pB5w+q+22lQYIEgphPa21ks5q6Cld0l110QmO5WDYAPUllTh/5qsFFKp5OqwlVjxDP6lg1cr8j5FxlgxmKv/thRpdnz+96yXOBe2iFFAohZtQASCDvG+SW/46Gg+HxCTcvO6CdbvMDkYE4FzoqYUzSii9iCmF3eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721990648; c=relaxed/simple;
	bh=gmcvBh8tAxM7U4muCR4NnBCWSdONDoqi+ah/t3fRe7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqIIEYfpdbfg+ll6tJLpoGmUFjp/A2UnDk/nb2xQrPWSKRLo+2GdklssBkCVW1xjasmXLXOuTFdK3fVhG2Sonb5cXjxmqQxIvAvurzC/NhxmGxahUQ9net616Qz6j8I5oalsGq+Zg9MKwD8X0SLs3wdiWqMm0jP/Q/4bvdDklPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XmrMoLFH; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso1863157276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 03:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721990646; x=1722595446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RN8ATHGy693sEWHqxL7yZGVaFgF60XWH6I6eHMXS/Kw=;
        b=XmrMoLFH1HoXwj7ELHd3mGqFCCSqwXnKueKik1ObjVNTP+CaKfrPZY8tBnpTcmC37A
         30BVdO5/Csr9bFtJ+EPGG0A/G1grTLlJkmCbGe3WDLL/VXEgH487at+oPHF6vfHN7bhe
         //M6j3w/j6uOOuB8koWClfGpk8knujLz4DHJi+5doWLz7dtsNBTf6084YLuH5gJAZbmA
         dsqoI429VmlsvEYs+RIA0i/yoHlw1uyg6aHkmuVpb8gEmhO8LRW2pv6F4BHbOSecft+S
         SODqmUzH/iG30/tFkdxfqsmU/gLBMcSl+6A5VYYUkqM0EM4nfrs2vslPmLji9bqKSG7v
         JYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721990646; x=1722595446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RN8ATHGy693sEWHqxL7yZGVaFgF60XWH6I6eHMXS/Kw=;
        b=N5vpT4oZDt4rGCH3DWTjXwj//nJg8qs0U/gPkmCCp8uV10Ua9ntC1fapmzuDxD+dk7
         3exgekhQpiqjysXkcBBH3BQGmCSW45JBbZqY3U2P01Lyv9T23FROQ/O++/indARhYqeJ
         moub0PthOQol1no2KXJQEUmQOKfbskcC6h47aCNJ1cxxS6qkHkC3gKPx/y/w2v8hW2XF
         RI9W4wqy268fJIkAXlayYW2Y6+OOBFKcW6UQv0sOXSkyHc2itb5JmTJFJIdxZyajQ/ns
         Z31UwOznAXVinoqBatDA2dK1dWyTWDu93s5vGeJWOS525JF0fcLMJ0TYGo/K1hE+mvy9
         16Lw==
X-Forwarded-Encrypted: i=1; AJvYcCX3PLjMl8fBzZM0qVf1hc6OkcV0G0wQ90W2dsob0Ogu0H0WSafzmCjKEa76qAJdWVCo6f12Fv6ZRUswZK3B5JyH5tUXyFdmUR7tCqh1
X-Gm-Message-State: AOJu0YwvTv2ROuO5qlAJ7L9oM1Z+5rsA6AquwM7nzhqmazzuNRGeusUG
	CaEdkAps5774/E7YwXdQjamvjuok/bUNrk72at1zFwpcbnYD/VFcp1D3DA0HSQ+9jUlfzTiWPBg
	oxpwUCXG+nzLJRjHjPO+mHvqYePZbLvIEZpvtJw==
X-Google-Smtp-Source: AGHT+IHb3A9j5z62UT6v6zQ6mW1WzMgmZNVqDkZSftx/n6W05QEmmC+a/Z/IWs5gAqZ401gu+abgWbO02bBNZXq3SLc=
X-Received: by 2002:a05:6902:c0b:b0:e03:5f40:1ecf with SMTP id
 3f1490d57ef6-e0b23233e44mr7064004276.44.1721990645837; Fri, 26 Jul 2024
 03:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-camcc-support-sm8150-v2-0-4baf54ec7333@quicinc.com>
 <20240702-camcc-support-sm8150-v2-5-4baf54ec7333@quicinc.com>
 <xbe7kmaxhfwy26qzxrmwgiijaaiap4kdkruaxjs6ymihaw5taf@hvj57wyncfea>
 <cc1957af-17bc-cd71-e6da-013e3a740014@quicinc.com> <CAA8EJpqmJZJfd2famarx-FKFb1_+-nZM3N+FwK_hiOurG8n9=A@mail.gmail.com>
 <e235f19f-26b5-2cf7-ebb7-36e4dabe9b9b@quicinc.com> <CAA8EJpob5Qov78JfNN5BE+c1WyvnuBcQLYENHL0c1GTS+PPfSQ@mail.gmail.com>
 <7ecfe568-6897-6dc5-fda7-50d6424298d9@quicinc.com>
In-Reply-To: <7ecfe568-6897-6dc5-fda7-50d6424298d9@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 26 Jul 2024 13:43:55 +0300
Message-ID: <CAA8EJpovn=eAj21R=Q7mDXcb1SmHpRhYNnNpHpx+YHyaT7S0tw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] clk: qcom: Add camera clock controller driver for SM8150
To: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Abhishek Sahu <absahu@codeaurora.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 11:26, Satya Priya Kakitapalli (Temp)
<quic_skakitap@quicinc.com> wrote:
>
>
> >>>>> - I see that most if not all RCG clocks use rcg2_shared ops instead of
> >>>>>      using simple rcg2 ops, could you please clarify that?
> >>>> As per the HW design recommendation, RCG needs to be parked at a safe
> >>>> clock source(XO) in the disable path, shared_ops is used to achieve the
> >>>> same.
> >>> Does it apply to SM8150? For example, on SM8250 RCG2s are not parked.
> >>
> >> Yes, it applies to SM8150.
> > Should the same logic be applied to other chipsets supported upstream?
> > If this is the case, which chipsets?
>
>
> I will evaluate for what all chipsets it is applicable and post a series
> to fix it.

Thanks a lot!


-- 
With best wishes
Dmitry

