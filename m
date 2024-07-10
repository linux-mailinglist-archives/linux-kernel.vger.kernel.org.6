Return-Path: <linux-kernel+bounces-248318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E54B92DBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBE41C2154D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EF41494B9;
	Wed, 10 Jul 2024 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yl6FgUvE"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B443B146017
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649444; cv=none; b=DS5zCjrmhtteu8qO4EP/6iOnxcYadLOHaScja6KwUasEubZAQfqgCjIzqXjc9nT8Byl+NPdvzINF+k+Ce9XxrrANhljQ0YhDZqbouReSNizRaRcV3BL+Gkyq59SODkrQcMv/EyNXmcIopyHq+rDrQJvattL3danGTkLuZr9ghGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649444; c=relaxed/simple;
	bh=QSjudhWjMHfYwAzqj8EyrEeW6mzfRI1kgAT7G1vdLmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsYgLR+MQ7LvZRUO9D0tSMdpWeUAf5svfV34uFp8JERdtWCmQg7tEgNkvSZIzRdJ68l3jFH4GJVUB5C3nl/el1c1XXn7jfpEyZQgu2lXBd8J4pS5U9UKCGdVuRCaQzVL6hL1j/p75XdUtjNF20xS75C9JyO02RCy8pcxti3TV2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yl6FgUvE; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6518f8bc182so10638827b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720649441; x=1721254241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ox3wZ5g8bv9fqPTyD5GfHZ00QVFUls5piDZiFLdQ1k=;
        b=yl6FgUvEMJfy6AUNwwgvM0HeQTK1mhABzcA9vuB2s6lFpH7v/kYJ7n0hYAU4e1u2wi
         V+MXs/FHicf9jtmHCupRlpCL8rFFzsktj2Fu/U0KuMEfcrYrUzJjltSGkjqUYSCIWbqA
         DFn03VjIDEOTnCbejnJRi2H7pdsi9yIADfQIuXU+rT1K2TbaXsfzoDosvnlMBsXVx2II
         OjGHdNG6yob+wEXoOYxJmEGjROwhUNUPhXeziXuA85PLjoI8aHehQlyIxC/ZFBJaVOsW
         QHfWZLc6R/eKemGHhhbiZfM3WY5tfz94WHn8Ufg11YWNB/9uchZDqdebxaiHEqnk5LPx
         d1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720649441; x=1721254241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ox3wZ5g8bv9fqPTyD5GfHZ00QVFUls5piDZiFLdQ1k=;
        b=qKdiGp6qkzZNFG87EBHmvYZX5Et9V6APE4VfViDl89voSRJANBMYwHlIr3QleesMXJ
         JNtVJSGJa4NFY0dO0cS5zo17/ovKlfE52zcYdMQFntF3mgJ9I1fSZ+6U82HNy9PHshxq
         olXY/aolcNOLeIp1y5pgYKnajS+hlL/kTZMur3esm7w2y0dWgNmaY3nRECD2gNHfqjes
         nrRoF8NrYHaK3jjcQ7SeoJNQfl8+ArR1mZHHYg5x/PwoZWRj22FBegGus8V6Lq6piRnf
         /iUF52CzT4kzpGVopLnse962mYmPNS+f2ATSupMJt3oTMDxQfVaBmmt/YWA27WX8E/j7
         LTeg==
X-Forwarded-Encrypted: i=1; AJvYcCXzZhZror/v87oipzuK/nJZNM/249dL3dEGWZVgFPgOATCJt64QeDMwSC8HFU4Un82GWZzOyQkdld2J0EUCUU3+hEc4aVab8VnEJ0oh
X-Gm-Message-State: AOJu0YymYYHmZlm/SuJbb0erEZ1GmcRuzD/N6L9ANLEghR+Q5+0zzU4b
	cl4LBHTM1YfD8KYUs08DDB4q2H57RoyL0+PY0rwumIEPIMm9MRPd4RZRwtROMfSWI80IHDrLEvM
	lxa9/tJsaK5GYXBXPPr0fZs54WukvC7O96vXrMg==
X-Google-Smtp-Source: AGHT+IG0R5rzOV7flXxv6z3tSdIvsh4oviHpRGXOo1mdeRmN1wkXxXA08BN2y+b7jDF2NxFpUF/ZmeV0mPTMfy3ddQ4=
X-Received: by 2002:a0d:c885:0:b0:62c:f782:ee1e with SMTP id
 00721157ae682-65ca1c27372mr9042047b3.11.1720649440675; Wed, 10 Jul 2024
 15:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-camcc-support-sm8150-v2-0-4baf54ec7333@quicinc.com>
 <20240702-camcc-support-sm8150-v2-5-4baf54ec7333@quicinc.com>
 <xbe7kmaxhfwy26qzxrmwgiijaaiap4kdkruaxjs6ymihaw5taf@hvj57wyncfea> <cc1957af-17bc-cd71-e6da-013e3a740014@quicinc.com>
In-Reply-To: <cc1957af-17bc-cd71-e6da-013e3a740014@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 11 Jul 2024 01:10:29 +0300
Message-ID: <CAA8EJpqmJZJfd2famarx-FKFb1_+-nZM3N+FwK_hiOurG8n9=A@mail.gmail.com>
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

On Tue, 9 Jul 2024 at 13:53, Satya Priya Kakitapalli (Temp)
<quic_skakitap@quicinc.com> wrote:
>
>
> On 7/3/2024 3:50 PM, Dmitry Baryshkov wrote:
> > On Tue, Jul 02, 2024 at 09:20:43PM GMT, Satya Priya Kakitapalli wrote:
> >> Add support for the camera clock controller for camera clients
> >> to be able to request for camcc clocks on SM8150 platform.
> >>
> >> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> >> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> >> ---
> >>   drivers/clk/qcom/Kconfig        |    9 +
> >>   drivers/clk/qcom/Makefile       |    1 +
> >>   drivers/clk/qcom/camcc-sm8150.c | 2159 +++++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 2169 insertions(+)
> > The patch mostly LGTM, several quesitons:
> >
> > - There are no cam_cc_sleep_clk and no cam_cc_xo_clk_src. Why?
>
>
> These are not required for camcc sm8150 hence not modelled.
>
>
> > - Why is cam_cc_gdsc_clk not modelled in the clock framework?
>
>
> This clock is kept enabled from probe, hence not required to be modelled
> explicitly.

Yes, I'm asking why it's kept up enabled from probe rather than via
clock framework?

> > - I see that most if not all RCG clocks use rcg2_shared ops instead of
> >    using simple rcg2 ops, could you please clarify that?
>
>
> As per the HW design recommendation, RCG needs to be parked at a safe
> clock source(XO) in the disable path, shared_ops is used to achieve the
> same.

Does it apply to SM8150? For example, on SM8250 RCG2s are not parked.

>
>
> > - RETAIN_FF_ENABLE has been used for GDSCs for sc7280, sc8280xp, sm8550,
> >    sm8650 and x1e8 platforms. Should it really be set for sm8150? If so,
> >    should it also be added to other camcc drivers (if so, for which
> >    platforms)?
>
>
> I have rechecked this in downstream and seems it is not really needed
> for sm8150, I'll drop in next post.
>


-- 
With best wishes
Dmitry

