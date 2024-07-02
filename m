Return-Path: <linux-kernel+bounces-237673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07720923C7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE811C225E1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F0B15B14B;
	Tue,  2 Jul 2024 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x0frbTE9"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC99914A0A0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719919932; cv=none; b=d0mzrpV+ezLsoqc4B6X5CjvZIY9XxjVf97bbWHvNppf7/U2hf7jf2ff3osnK0z/XLFjiBF2FIJ7WeJ3vpdoRrSbjzZN9sDHOVLteh4Akm3YKwcSkfM2XyB+4fKHIecHEfxcXAktXnHdnYMLd4CeuYKCF4wwO0i2M/9c0sQlPT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719919932; c=relaxed/simple;
	bh=LBVcgvFsJch237tejdKimLdtCtiJYaVTKGi5dUPVMjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyQWOICLq7icYEJ642n4t4z7gb3VjIfBGm3nZt22UUheYEIOR9CEqXTQugMuKGCLMGmKmdYxB18+y480a64S03IxQ5llN+LllLYOzRBfeLRmY5VDQ3YwfRaBLeGan+W+Ehpwy73Mzwpk0zNZFxFUGxrrcnKQyUOMsdTLXK2UMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x0frbTE9; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ee75ffce77so7864531fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 04:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719919929; x=1720524729; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MSXoHkGA1DU1EMI9T5lLVnQCkK0LuT27soBVnNuZYko=;
        b=x0frbTE9M1Qw6uyZH/eVuqQ1uFaANpkWY1itES9Cgqd5vOmsS1nulJeDe4T6J6SrvK
         D4xgtr32jQ6jCC9ts13x/DWApa3+Dc3t4YGlxhTBRmnKushwx8GIv8dkL7p/M+7M7Toi
         m55y7UyKo0qUsC/w92jzn73T4nDkoLV1gramOm5bkMUIwru/l2EYUkRcPpamFw3HfmtT
         n2Y+ZqYHX5+ZwRAk66dnxFxu2X/5QbxzY3ijattsM3p3CuyUkkHfVAEscAYG/PsEdCkH
         OjB5SfFC9imnchpyq9WJ/o7UnDK5Dn5ytA4FVyscC3E2NQUQrauSSSR0fLDedEnPClHb
         65uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719919929; x=1720524729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSXoHkGA1DU1EMI9T5lLVnQCkK0LuT27soBVnNuZYko=;
        b=BdvyjLD7wd13/I2hpWamy+eUMnJPmDIRWifFwEeAX3AmrV+ZOVE0qRcIaJH9lySYQu
         U5zH+53IY1YnkCtMp0vgZDqIGePtUbmm9f6iEpkT5UOdmjo2+ygwJbwBEMa5JV+sWCCi
         Y/W3dc6RawPMiPPYXp4BZgL1i7FmW5So/bf0moefC+miCTWJ69zpltIqesBMN5cJbu3y
         auU1mDgIKM1UH7ASfIVb78R5/LtMGR3ntZqXqvcGZTq29ccjRTbszRZxJQmnRcq698zT
         3oJW1sUYAK2WHzrA1vnrs59+tBbzrMd/vSEtM1/whuhfgxJSvlnQ+nxf0FhrbxeN4n3R
         g4JA==
X-Forwarded-Encrypted: i=1; AJvYcCVR4fnAWVjc/t498+JZh0VblXnJX6Z/OnrY/FDoaFIb7ezNC3OW++V5prEQ33MVMG5DOguAwcjTsWvjk4KBi1y7QYllyslHDeBHgpQF
X-Gm-Message-State: AOJu0Yz4xDVqB95jOtLdrnzU9vk+bGI5eq6PHdsYTvw0cbk3Xh9Yqrux
	mMOPqc2D6CMikRMZfTAUaYRBR8ItEDusc4+HTqaYFJZHbpkfPoFDCuneWiiVeDY=
X-Google-Smtp-Source: AGHT+IFAdzMwRbV78/433AlK5zgIZCy4qqRs0hIvh7bFbT2gSLGjHOaaKZTsy/GGmd70uGng579VEw==
X-Received: by 2002:a2e:9997:0:b0:2ec:5430:7f7c with SMTP id 38308e7fff4ca-2ee5e707c8fmr59877361fa.53.1719919928001;
        Tue, 02 Jul 2024 04:32:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee51695ec8sm16560371fa.130.2024.07.02.04.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 04:32:05 -0700 (PDT)
Date: Tue, 2 Jul 2024 14:32:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Amit Pundir <amit.pundir@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, dt <devicetree@vger.kernel.org>, 
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8550-hdk: add the Wifi node
Message-ID: <j2pvpoxrw7swutchmpgkzsacbwjcpdickmhprpxzedvcqxqx4o@6gyaqv4a35if>
References: <20240702091655.278974-1-amit.pundir@linaro.org>
 <8ba07bbf-e8b1-4244-882b-ff2575368b20@kernel.org>
 <he7q4mzj7u7t3c4pndu565m727e6hqpf2srrqgbdltjdffugdl@x3xrwteqpki3>
 <CAMRc=Mepx86sQmPYLq2TkvhxtwUtsQGeYTVUc585oiuvOzLc-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mepx86sQmPYLq2TkvhxtwUtsQGeYTVUc585oiuvOzLc-A@mail.gmail.com>

On Tue, Jul 02, 2024 at 01:13:09PM GMT, Bartosz Golaszewski wrote:
> On Tue, Jul 2, 2024 at 1:10 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Tue, Jul 02, 2024 at 12:42:02PM GMT, Krzysztof Kozlowski wrote:
> > > On 02/07/2024 11:16, Amit Pundir wrote:
> > > > Describe the ath12k WLAN on-board the WCN7850 module present on the
> > > > board.
> > > >
> > > > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > > > ---
> > > > Kanged verbatim from 490812872449 ("arm64: dts: qcom: sm8550-qrd: add the Wifi node").
> > > >
> > > >  arch/arm64/boot/dts/qcom/sm8550-hdk.dts | 97 +++++++++++++++++++++++++
> > > >  1 file changed, 97 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> > > > index 12d60a0ee095..c453d081a2df 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> > > > @@ -279,6 +279,68 @@ platform {
> > > >                     };
> > > >             };
> > > >     };
> > > > +
> > > > +   wcn7850-pmu {
> > > > +           compatible = "qcom,wcn7850-pmu";
> > > > +
> > > > +           pinctrl-names = "default";
> > > > +           pinctrl-0 = <&wlan_en>, <&pmk8550_sleep_clk>;
> > > > +
> > > > +           wlan-enable-gpios = <&tlmm 80 GPIO_ACTIVE_HIGH>;
> > > > +           /*
> > > > +            * TODO Add bt-enable-gpios once the Bluetooth driver is
> > > > +            * converted to using the power sequencer.
> > >
> > > I don't understand why hardware description should depend on the driver.
> > > Either you have this GPIO or not. If you have it, what does it matter if
> > > there is no driver who can play with it?
> >
> > Then there is a conflict between BT and PMU, which both will try to
> > access the gpio (or at least the pinctrl).
> 
> Ah, so this slipped through the cracks. Amit merely copied it from existing dts.
> 
> Yes, there's a conflict but Krzysztof is right - we should handle this
> in the driver, not in dts.
> 
> However for that we need a patch for the PMU pwrseq driver first. Let
> me cook something up.

Or for the BT driver, which might be more futureproof.

-- 
With best wishes
Dmitry

