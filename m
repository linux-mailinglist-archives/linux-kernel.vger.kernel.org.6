Return-Path: <linux-kernel+bounces-426187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5809DF008
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 12:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CB62B215F2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F49D15B99E;
	Sat, 30 Nov 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnvVy9lb"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7661531E6
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732964909; cv=none; b=F2tKXlm2v6p+v/j4GL77ExOpeXOIqp7yKSUrPsmqfZeA528vLQ/KAUCJwa8wQnu8XKan4CCANsw2ozDVEdHKO3wJMlHbvZqhfMYYl7IkhNoqV1tNnbb22F9Acz9rl8a386nOnAKqEK8CLgWfSwQb7T4NprrAWLoNicwsbJyw2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732964909; c=relaxed/simple;
	bh=NSEA1SSDSL084X4JuRKIRhUhOQDaB/BENf8Zl0fCm94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LL04da3EyN2qEjDjOclU+N0X64EE+ToME6YQV56pXMhDZdZqrkQHHmH70rsa9QofSEpH9Nii6f9bcSkkjq/gkUW9AaqetBxZNcAM0qz7aj2eUgaW9rYxYXbukwxJjS1+GtsKy8miDa1vKvWjoOR98ottuQiIQM5tobEBU3G3RRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tnvVy9lb; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53de8ecb39bso3089064e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 03:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732964905; x=1733569705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VyBDDQ9RN1xVnr3Ge/Kd+7GiNG8p1vU/7DTAOuAlE7I=;
        b=tnvVy9lbXN/RaEfZp08h2oBdrZo1vL/DbbV/igFbwRHTJehpIt15Iel9/kvPgABa2m
         +l4LFIXe7YmkUMyi7s7gEvi/zek7RjHqSIRrkhEIVHhxcMl1wIxaN+seTpvLUOcFcg4U
         S7BFohp6lO1HNVtkR+xFtT+eKyomqz+HvTG69WVR0ewMRy3huC3gvCWJtT//DTTlPC2g
         tVgabiAjOzFhcNIB1hBSpuCknhtNOqoLOJEJWKKMmSLSU74Anhda2XGJ+gNAIIOjkxCU
         sMEKz441kDJmIRmAAQcha2BRbrgRl0tfIaGk0IwZzFZk2zhCaa/JIfBYo++lFW0As77W
         ZjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732964905; x=1733569705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyBDDQ9RN1xVnr3Ge/Kd+7GiNG8p1vU/7DTAOuAlE7I=;
        b=LmJUT3PTOWeKHxLPVPGVdM8D0cCxtvdTS7FQBtZpjqGUXrRGdYvu+J7Xg2U8ntSFla
         y+GS9TtfBosRXunft9IOAuECnd2OrAoFudbIjBW51+mpgl96s6F6aPr6/eTAioyh0xLD
         yhfYRBhOzdWf9W6eW7AHRVbSvza5OqlUrLiagegN+rVvg9pz9XvyyNq7Di3R0EsGhLIM
         BxlqtpE8C0/SGfQZ33iPKAklDScTspfH0QMHHA1ZHQZKrjbWTi4lMkrAszaLjHBepDRP
         uOaDDkbqUYWqQSuaimbheARPsNvNuvceVi543+2WQ69+Vrdmu4/MNipsUiybYW4PBDZb
         C3jw==
X-Forwarded-Encrypted: i=1; AJvYcCVnlzjIJl926m6YJGfI0bux/sCP2mAcMQrROZHnIhup3/s8F5j4BGS0U6MqoWQVhsBb7R5Yv9BIceoDA1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMXrigul64+Ll+7ptSOnrgi0vU1GsbZZ75ZjzWTWDoXnZY2SH7
	JRdCJNeZaHGK2CgB6ptrXuzYLUT5+AIPAQ5nypavHcbHo6WDt0OUn847ytAh0us=
X-Gm-Gg: ASbGncszYmqMDBhBbT1FxSRGrteaqa7eI5MP2ymIdIsVimI9tPrAqjQg9MA7LcSI6OT
	HKWwiy92Qircs6Rsv0W7MJkSXgDVbykaPLdzWVSFg6AGgo3TnM2ZxTka6OynsDqK4VqfWkXmva1
	9HQXkjkmq+7AFm5Oz4tI1GMBhBmsbw1eGIslvrA9kpxpwCHjriTqbeMwNl9a+SexqXpEJF1LoON
	EO7tiSQJQMMHYCLJy5goWdGKwivahzoQIIpjYlrxhn3iLopZEgBMkOuBqlkqwj9gJvlG+PoublI
	eTsQlQNnOadQ36UbLgD/jPVagHS6Sg==
X-Google-Smtp-Source: AGHT+IGLsmBOtgxyMFI4fiUTJseDYY5c3VGf49SiTbcFYm56bV9Q7A9gzamHW6K2Byi57Jf8ndDGvg==
X-Received: by 2002:a05:6512:3d02:b0:53d:cef7:d88d with SMTP id 2adb3069b0e04-53df00dce40mr8808221e87.31.1732964905112;
        Sat, 30 Nov 2024 03:08:25 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df643121esm734460e87.56.2024.11.30.03.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 03:08:23 -0800 (PST)
Date: Sat, 30 Nov 2024 13:08:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Leo Yan <leo.yan@linux.dev>, Joseph Gates <jgates@squareup.com>, 
	Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, 
	Stephan Gerhold <stephan@gerhold.net>, Zac Crosby <zac@squareup.com>, 
	Bastian =?utf-8?Q?K=C3=B6cher?= <git@kchr.de>, Andy Gross <andy.gross@linaro.org>, 
	Jeremy McNicoll <jeremymc@redhat.com>, Rohit Agarwal <quic_rohiagar@quicinc.com>, 
	Melody Olvera <quic_molvera@quicinc.com>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, 
	cros-qcom-dts-watchers@chromium.org, Stephen Boyd <swboyd@chromium.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Martin Botka <martin.botka@somainline.org>, 
	Jonathan Marek <jonathan@marek.ca>, Vinod Koul <vkoul@kernel.org>, 
	Tengfei Fan <quic_tengfan@quicinc.com>, Fenglin Wu <quic_fenglinw@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Jun Nie <jun.nie@linaro.org>, James Willcox <jwillcox@squareup.com>, 
	Max Chen <mchen@squareup.com>, Vincent Knecht <vincent.knecht@mailoo.org>, 
	Benjamin Li <benl@squareup.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 20/31] arm64: dts: qcom: ipq5018: move board clocks to
 ipq5018.dtsi file
Message-ID: <wvrelorcsajlux73jfqysgsox5dge7udfvhktt2sto2yg2xb3a@t7cpherrt6z7>
References: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
 <20241130-fix-board-clocks-v2-20-b9a35858657e@linaro.org>
 <83990b97-3f37-47f0-9cc6-fdaa730a8df1@linaro.org>
 <zdhevcnj6gszvaayhu2dghubwm23cdoyeik2dcnqo376gcstnz@xv46iu6l6yvu>
 <90418b49-5b19-4bef-b0cd-398bb562aa8c@kernel.org>
 <26lttxx7obu2oqvf4xnooqi3o7qwodhjzyjh4trjq5tlj2gzxs@uwihybmwbdid>
 <7778fea9-c127-428d-9653-e66e84f23c98@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7778fea9-c127-428d-9653-e66e84f23c98@kernel.org>

On Sat, Nov 30, 2024 at 11:43:34AM +0100, Krzysztof Kozlowski wrote:
> On 30/11/2024 11:26, Dmitry Baryshkov wrote:
> > On Sat, Nov 30, 2024 at 11:00:32AM +0100, Krzysztof Kozlowski wrote:
> >> On 30/11/2024 10:57, Dmitry Baryshkov wrote:
> >>> On Sat, Nov 30, 2024 at 10:29:38AM +0100, Krzysztof Kozlowski wrote:
> >>>> On 30/11/2024 02:44, Dmitry Baryshkov wrote:
> >>>>> IPQ5018 is one of the platforms where board-level clocks (XO, sleep)
> >>>>> definitions are split between the SoC dtsi file and the board file.
> >>>>> This is not optimal, as the clocks are a part of the SoC + PMICs design.
> >>>>> Frequencies are common for the whole set of devices using the same SoC.
> >>>>> Remove the split and move frequencies to the SoC DTSI file.
> >>>>>
> >>>>> Suggested-by: Bjorn Andersson <andersson@kernel.org>
> >>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>
> >>>> This contradicts DTS coding style and all my existing review. Obviously
> >>>> that's a NAK from me. If you want to merge this patch, please kindly
> >>>> carry my formal objection for this and all following "move board clocks"
> >>>> patches:
> >>>>
> >>>> Nacked-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>>
> >>> I'd kindly ask Bjorn to chime in as a platform maintainer.
> >>
> >>
> >> To change my NAK? NAK is still a NAK. We discussed it many, many times
> >> already. We have coding style for this explicitly mentioning this case.
> >> Could not be more specific... plus all my reviews for Qualcomm, NXP, TI,
> >> ST and other platforms. I would be quite unpredictable or unfair if I
> >> gave here some sort of exception while expecting different code from
> >> other platforms.
> >>
> >> Please carry my NAK.
> > 
> > Of course. I didn't mean to drop your tag or your objection.
> > 
> > BTW, would it be possible for you to clarify the policy on external
> > references? I mean, is it fine for DTSI to reference a label which is
> > not defined within that file or within one of the files that it includes?
> 
> 
> It is fine, you have plenty of such examples of shared components like
> some audio blocks or PMICs.
> 
> All Qualcomm PMICs DTSI (e.g. arch/arm64/boot/dts/qcom/pmi632.dtsi )
> reference them. Chromebooks are even "worse" here:
> arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> Nothing gets included there but hundred of phandles!
> 
> Are you planning to "fix" these as well?

No.

> 
> These are just Qualcomm, but same cases are everywhere else.
> 
> But *that's not even important* because I do not suggest to move clocks
> to DTSI. I suggest - and was almost always suggesting as best compromise
> - to follow DTS coding style by doing opposite of what this patch is
> doing. That's why I NAKed this and following patches, except last two
> which are different.

If you remmember my first attempt was implemented other way around. But
I think it still better to have both frequencies in the SoC dtsi, it
points out that it is tightly coupled with the RPM CC (and can not be
easily changed), it saves us from 32 kHz / 32.768 kHz / 32.764 kHz
typos, etc.

-- 
With best wishes
Dmitry

