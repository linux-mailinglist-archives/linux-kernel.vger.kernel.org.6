Return-Path: <linux-kernel+bounces-259905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF9D939F88
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87391F23095
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E881214E2FB;
	Tue, 23 Jul 2024 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ShTUViwz"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56631B960
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733332; cv=none; b=qJ4JT1pYticRkUsbMHyYFTx3A8VNI9rx2uKPp/yg7PgRpnUpSVEFmvysXXc/cy0mFP5iLekgIOw69U4SFg6PWiT6NVy2lbZbq8Pe7ef8HJnw+0p/aUzTWNIf12euoDzbA7s1SQoLVxl9vaDjXd92g4mRv7ALC+DEGn0cGLyC5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733332; c=relaxed/simple;
	bh=K9wM4j8YlfFJqMQ5wQVlibqExzRm27i+9PimN/mfbt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TaGzlOs0rsMFSDUxyVUGQnLvj4IW1qKqRfmRhC5pk17CcAIUONjS8yLKRWiPQ/1Vo1N9tJp4M+Eqw7ty/PjuVS5IH396E5pk21GfIELhmV75guGt8yke5sF7KXMR+njmSeZbkWdYI+4uI2Ap6Cgbv6Qm2YALhpBlkMFv3SGtCRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ShTUViwz; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-65f880c56b1so53955067b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721733330; x=1722338130; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rRFHDv0XLvI63BDNDAb/9+mEEITchZiLb03oqBqQ10E=;
        b=ShTUViwzcaT3nUDoQfEXVjuNRlGkKzFU2xAgPXcFTVxooD3SW2KIyHOYz9VE+eMcOG
         KvJwiR0awEaWTqC8RI02mQ90FR/TQ6X+q6WkJDMdh/UlSpVnsLNixYA6A+grJkCPMfDy
         sbPOELn/d9icd4Fef392kxkVCELdXVYht4Bc2UQxL2Uiz/XmtXUcidJlGHt5eVQeUX0d
         hoz5Cn5gqx+wQzEhApo3zw8JyoySOyMfaFtJh3UQDx8Vi4F1q5g3elCij+qfu60FtPBl
         i8iLmKUbiq+qJG8XOMidBHF3lCoQpfUUIBZg3ZNfvX+0w4hxC0xPTD+qaT4E73IxbnKK
         XKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721733330; x=1722338130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRFHDv0XLvI63BDNDAb/9+mEEITchZiLb03oqBqQ10E=;
        b=V6WlqFTkygWpmaAzTr03gc/s5qVAyN0Uf4bEeug6EYdyS45gcg4kdAxClsSkR8ygkq
         0rsLE3czb/jmETGrVYxvSs1a3jEaO7QuQ5zkbiRGYpHm5KDj6Ej5rXSnUxlVSY4v8z15
         8oOTwhhRELFxmLSzAf0SgSkoP1sBmfot/ynzL7p+a/wMV0ZONHdmF3j+uZzwVfGIugDP
         YV9d7F0jLx69NO5RmkN+hu7CVRFyjImyB1xZsEfwcF+uMtm6ZTLNgKEsWohIhp9g7LMY
         Oj4k9D4gefnXjFfFiYqKs/IcsbyL/myonbELyP3N4PHYokJJUPNvuLms115or+BQJ3aP
         t2EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVduzZFZSg88polu9r8hEmnYu8bmOYyaKkLlyYXG72C00hjz568TdxID0fXvWCR4zJX87vSQIx4w012tyxfMKiXTOLxYIKeQyN/xLiR
X-Gm-Message-State: AOJu0YwzX0Vfr30N0b4apAPdFc3fcqyzt5A5oFmg9+TVlpxHJ623w6q1
	W7h3reAvK4XGArtBov3uW9jBMW1hXLw0AyV6HpJp8oSqhxFZhInukz4t5TJA0tDfH0apXy1Xs4n
	gdCvJZodmYQqJENXaEka5Sc9gAfaTOvK4685+QA==
X-Google-Smtp-Source: AGHT+IHm3baNo2+1Gq1+OTlkkgIdaB3nZkpHkAXBXv54my6/+osPfPlCcucGcfXK1L4Fhnq5gfd/w/33iqAfDwg6mrc=
X-Received: by 2002:a81:c941:0:b0:650:a1cb:b122 with SMTP id
 00721157ae682-66ad94ba0d2mr96488357b3.27.1721733329722; Tue, 23 Jul 2024
 04:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722-miix630-support-v1-0-a6483cfe8674@linaro.org>
 <20240722-miix630-support-v1-3-a6483cfe8674@linaro.org> <3a257754-2118-4a7f-9753-f1a2392f9279@linaro.org>
 <CAA8EJppvwXEiNs-6orVMSkkjJu4nYY4ZNdshbB1sUM=z4ouYXg@mail.gmail.com>
In-Reply-To: <CAA8EJppvwXEiNs-6orVMSkkjJu4nYY4ZNdshbB1sUM=z4ouYXg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jul 2024 14:15:19 +0300
Message-ID: <CAA8EJppLz89YCpDvTxaVuRsdb_zvX+FMWi5s5nnmz9sOnf-LpA@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: msm8998-lenovo-miix-630: enable
 VolumeUp button
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 14:11, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 23 Jul 2024 at 02:24, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >
> > On 22.07.2024 1:57 PM, Dmitry Baryshkov wrote:
> > > Add gpio-keys device, responsible for a single button: Volume Up.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  .../boot/dts/qcom/msm8998-lenovo-miix-630.dts      | 25 ++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
> > > index f585bc8ba2ce..bca309ac0cb8 100644
> > > --- a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
> > > +++ b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
> > > +
> > > +             key-vol-up {
> > > +                     label = "Volume Up";
> > > +                     linux,code = <KEY_VOLUMEUP>;
> > > +                     gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
> >
> > No debounce-interval?
>
> Strangely enough, no. See existing defines.

After more digging I see it being used. Let's use it too.

-- 
With best wishes
Dmitry

