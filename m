Return-Path: <linux-kernel+bounces-230429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0461C917CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8071C22216
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6277416CD12;
	Wed, 26 Jun 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DR8oqrTR"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5090016A930
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394893; cv=none; b=DZHDjji1nLHIrmQuIDksET9QmjfTIo/cwpFwNT6xrb7d2jtEuc/c3lBP0I8Spy1jat6zVt3gqBxlIHJ+DOUQl9uEtk+3dCOkZtp/i0cRGarGFQK4erNGscs3KqZeTzFY3ytGktGMwBsXq2QM2eyGVJYtbSU057Nea226xc5SYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394893; c=relaxed/simple;
	bh=rAi8qWvLGUjfPNObkbt1FS51k5c7kFTbL44EQ54v/so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+I1EDwZ+uSbWE+m6PVd7lpm7of+jWtJqnBSm0gyi7X3TXWiaVXTmiPcuQgtMUqpRK0pv8r3I3MBdeZA1TsyyQLhhlwAVRrnpxJNUYw94JSiWrAxU6KU8xAq93xN3jErKm/jOwRZM0LnBu43mu/bPWkPQ99Letn4R+pGbhDsYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DR8oqrTR; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-63bce128c70so2941637b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719394891; x=1719999691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3D1uEZ7yDMJQpAzPHDTpqijG7botuCb/3+xVwtXeK20=;
        b=DR8oqrTRlxbWYmaH98GFS1fFN8IxQVBmsIQZXCdClgSVu4fA12WkUY/UUZmm3I28Lw
         dpHW7KJE1sirdB2CbJ6QX+k0rEX6TfHsbukI8YaWtxALaDrTVBBvXS6BxeIAPeWwSrQ3
         qwnWhBCY8OSwGOhCRPlzzlc/iitlbi9ETVkG1SgLAWljlrq3TqR9mWxlVsnWDf1QQDhF
         2XMwJ7Qyn7FIzrNqjaFMmvo9U8xwsnxdBnVOffZqWu8FDGJcEmBsdx1rkUKTy/VhIm0z
         Qv2YWEfKIVHNWgL9iNfy94FOIacZDKl+FCN5vq/k+4Tiev2p1j7dM03EJ9bTTRW5IDRG
         r2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719394891; x=1719999691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3D1uEZ7yDMJQpAzPHDTpqijG7botuCb/3+xVwtXeK20=;
        b=DxwuE1P4ZHpwMSBFHGkEq9EhIHz24Cqd0JT9Bz0kzaKeAeHn623lLvc2PWHkvo3bTV
         Zjx9Ac2aiCEhR6HVqDKZawoP9owfTC8AP++IKQQC7RWiP3G25FMkNsr/Nm39i07Hf7jR
         yMr9aH8Be1saUpJ+2pNtle8HyPtCpBlpzVuYbUEsYBKWkoVwkYNSklLJ+wpBYGnLZ55n
         9SyihilrqZXogWK9P/vAqbUHcg0lmuz9486I1E6/ncXbhOKCVV6TRz6Pow06PYwSGZjs
         2eSzBPWll7DrpL76xdW+d1g0GlfbVVnk6s5jiIWK0okCTR3iQQKYdLHLkn8OpUYuLFoM
         T7Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXZwlZvgzllOgWv38YMph9hhWv1OrzfbxLuJkzMKGy0EBnxnTEvCdlIUIs14TMmf4SI161kFMEXkRjpFCB4LjQQ76ZP+acnyHM/197O
X-Gm-Message-State: AOJu0Yw2DlS6hm+Dl6KmklSLohHO+OVVv9uganCDgZ4KR1ZrWxByEJ+2
	fL9WLX4VHozl0sCag+y92FVnWwHm7RKuLWFWj/AT38b7w4W4aAEVd6W2Wo+iCtePN/B8KCFedTe
	ef3snCYN8wv/AgpZ09GgT9glWh8s1gmrfPozrKg==
X-Google-Smtp-Source: AGHT+IGFtI1Yu/G+tNmb5mf0Qqj9/Bd2JZr2+OgHviJF5LW0auUzYGFFKOol+aUhRJ3nRI/my/M9CM/QFT1YwdlLRhE=
X-Received: by 2002:a05:690c:4905:b0:62c:ffb9:bb87 with SMTP id
 00721157ae682-6462df2b681mr50366767b3.4.1719394890962; Wed, 26 Jun 2024
 02:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625-pm8916-tz-v1-1-a4c1f61e92dd@linaro.org> <61070233-5f51-4cac-bf30-816a8bcf58dc@linaro.org>
In-Reply-To: <61070233-5f51-4cac-bf30-816a8bcf58dc@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 26 Jun 2024 12:41:03 +0300
Message-ID: <CAA8EJpq_1wj_1TATJBoEB6d6JCuFY0jz8EP3YQp5Us7pwU5B3A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: pm8916: add temp-alarm thermal zone
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Jun 2024 at 12:40, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 25.06.2024 10:16 PM, Dmitry Baryshkov wrote:
> > Define the themal zones using the temperature values in stage1 for this
> > platform so that the spmi-temp-alarm driver becomes active.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/pm8916.dtsi | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
> > index 4b2e8fb47d2d..2def48f2d101 100644
> > --- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
>
> hmm
>
> > @@ -4,8 +4,37 @@
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/spmi/spmi.h>
> >
> > -&spmi_bus {
> > +/ {
> > +     thermal-zones {
> > +             pm8150-thermal {
>
> hmm

Will fix in v2..

>
> Konrad



-- 
With best wishes
Dmitry

