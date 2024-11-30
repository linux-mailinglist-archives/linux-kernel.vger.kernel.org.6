Return-Path: <linux-kernel+bounces-426183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E92069DEFF5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECA21635DE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0891A15A86B;
	Sat, 30 Nov 2024 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAP30NXU"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD436155336
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732963353; cv=none; b=Xut99dx+oO0v2dZa/baowd637/L3Q0Ss7jk3QqW5AnpGDL0ux0TMGttomtWbfRcvZbwVkTpKiqFvTbw75KjmpQVEqALytcxHKWXMLsfj1qTtYM/qH4Lkp2WWX80cewsIBBx1ZIcWU7Or0xh75ADv/wr7OwrCLsUSzxkFzly/c+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732963353; c=relaxed/simple;
	bh=z75So5WVYPLLMNQwnxBZPmytY0lky/GENGCw2mngOtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVdLHf+3kBp8MWhzlMxBh6OHCF4U0I3SgiXFwphYLf/zpLT+3ESTgZvF0eTsFDBmYHSBsWi3hsOiV0yKu6AxZawPy1vmk1WNzep99/wvSWe27U8vdl1MiT3PIBPao11HwjpntuX7JedC80gptqcpfOgsMMvBNNDzVpyZ3JyusYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cAP30NXU; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53df1e0641fso3029113e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 02:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732963349; x=1733568149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+tgdJ0lNf5uJXDyx2na57DXS/0Gs3go1GJRqeuFoyM=;
        b=cAP30NXUuja2eK/lAeJisCkoFbARuzbLITMqdnCTWkKyE56qMldotWZCVzdT9/gIT+
         WL7eWGOzans7ILSVICxlSSjYzHYn56oYGYUQUyYiRpiG6hz4zyB1ogf6RGhoZdBL2ztq
         0A+wUaJuAc5ggKgbxsPV49tSgZ1q2KvoTX/Mn/FbsAWXeHkKoCUYwVpqklAu5LWqTrEq
         olNA3/vxVY02bMNTgS3c29I5c+vbokMpdD/8uKFzMvlbFlpfoa4u99E/u466grl9E3lt
         ySWEf19kPh9gTEhTVMOyk2+H6NHLkh7kSO7e5hBTWLSpiBcrh8M3BbE7bm0Mmv/Onf50
         qlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732963349; x=1733568149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+tgdJ0lNf5uJXDyx2na57DXS/0Gs3go1GJRqeuFoyM=;
        b=RaCZ8zSf/OgFtRtKznmqO/U/mNgVdGQQy/tytD6CAVcKUTQMzmBpIjvJwnKARRbRcO
         jfj7p6nGHzvzSr6kF31HcH2TIU9PCklSFcsHskYsPP15oAstPDcYtmNw9+0/W3IvcVZw
         /aQhuCK5PVu+a6v/fo6jjHgLrsG/WemSIS2Wv9OjLGn3E1dKAa09dtUR7D9tEXk05pe2
         jSpkwU0VWUUS4DAlkmN3HjKkIH7c0vT6hkqYdJvXUQw+f8BktxFvwAe9YEHT3RnMdnh1
         GN3OaAg+yvVbHjarcWavnXSvwTdpfJ9VjqnaXuX2nde5UyoVPWuebw9k7QN/LkjFE0lN
         gG6g==
X-Forwarded-Encrypted: i=1; AJvYcCW+MWvUueMvLs3U4MiYD84KxUAm+OInSH2Ar8X5yh82ZrSe01AI82hhgymdPzyzq4dRJvmLi4udSnY+74Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyelN5QToPVm4H8nRaXBqjj1MSlfOzmh5Y4PvK0o/qbauejv/MW
	6NKhoo7gLQiKX1yQi8MqwMNJSI+7atha9pi5Qeb+qPbaHK9wfDjfKxnGYe9/Ro4=
X-Gm-Gg: ASbGncsOPzUdzZlaVZ38TM3l4Q9/z5aA0SNFdNne8EoF6VNaDHXHr0RYNT7vGZedG6W
	fA/2hy7H5cawiIZk1Ner+MksYLhSWYJEVQQ7t+o1+LqIHIBsk8Uuv4GvjCZy1o/6mgWw/DRyUeA
	jPzyf7LfNzBeBDgMbf+iy+tBZlLsQ5Kf0/xvjKjKomv1upcSnsqpmoEc8wMj2jBYZ72lT7C9H5y
	8CWML5pWBb/D/YczroNumC6wYL9L0BSdwtwygE6dCleEYFquWG6qDMpptfaWwoLttLSvzUodbfV
	Kw3IJDdot5WT8sr2L7z0HUJY5BNrEA==
X-Google-Smtp-Source: AGHT+IFcekxgU8h/tBcXQsoWXwT31IuqmouPc8u7PTpcXd1KOJ0o5hOEknnd49Db7H6F8g76yRff0Q==
X-Received: by 2002:a05:6512:3085:b0:539:e9f8:d45d with SMTP id 2adb3069b0e04-53df01125d5mr8493039e87.52.1732963348703;
        Sat, 30 Nov 2024 02:42:28 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64311a9sm732362e87.40.2024.11.30.02.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:42:27 -0800 (PST)
Date: Sat, 30 Nov 2024 12:42:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Joseph Gates <jgates@squareup.com>, Georgi Djakov <djakov@kernel.org>, 
	Shawn Guo <shawn.guo@linaro.org>, Zac Crosby <zac@squareup.com>, 
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
	Benjamin Li <benl@squareup.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH v2 01/31] arm64: dts: qcom: msm8916: correct sleep clock
 frequency
Message-ID: <al3tckby2jg7imhieehqwemygf6y5csfg7xfjta7alawhwfqv7@6gha46tr3rhx>
References: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
 <20241130-fix-board-clocks-v2-1-b9a35858657e@linaro.org>
 <Z0rnRC_BqgkE3w1P@gerhold.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0rnRC_BqgkE3w1P@gerhold.net>

On Sat, Nov 30, 2024 at 11:21:56AM +0100, Stephan Gerhold wrote:
> On Sat, Nov 30, 2024 at 03:44:13AM +0200, Dmitry Baryshkov wrote:
> > The MSM8916 platform uses PM8916 to provide sleep clock. According to the
> > documentation, that clock has 32.7645 kHz frequency. Correct the sleep
> > clock definition.
> > 
> > Fixes: f4fb6aeafaaa ("arm64: dts: qcom: msm8916: Add fixed rate on-board oscillators")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Thanks for spotting this! This fix looks good independent of the more
> controversial "arm64: dts: qcom: move board clocks to SoC DTSI files"
> changes. Maybe move these to a separate series?
> 
> > ---
> > arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > index 5e558bcc9d87893486352e5e211f131d4a1f67e5..8f35c9af18782aa1da7089988692e6588c4b7c5d 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > @@ -125,7 +125,7 @@ xo_board: xo-board {
> > 		sleep_clk: sleep-clk {
> > 			compatible = "fixed-clock";
> > 			#clock-cells = <0>;
> > -			clock-frequency = <32768>;
> > +			clock-frequency = <32764>;
> 
> To be precise the PM8916 specification says the sleep clock is "The 19.2
> MHz XO divided by 586". Maybe we can actually describe it that way with
> a fixed-factor-clock?
> 
> 		sleep_clk: sleep-clk {
> 			compatible = "fixed-factor-clock";
> 			clocks = <&xo_board>;
> 			#clock-cells = <0>;
> 			clock-div = <586>;
> 			clock-mult = <1>;
> 		};

I thought about it, but then it's also not complete truth (at least for
some of PMICs, don't remember if that's the case for PM8916): there is
an external XO and also there is an on-PMIC RC, which is further
divided with PMIC actually selecting which source to use as a source for
sleep_clk.

> 
> If we keep the fixed-clock with the hardcoded frequency I wonder if we
> should put 32765 instead of 32764. If you calculate it exactly it's
> slightly closer to 32765 than 32764. :-)
> 
> 	19200000/586 = 32764.505119453926 = ~32765

Well, I think according to the most typical rounding rules it is 32764.

> 
> Thanks,
> Stephan

-- 
With best wishes
Dmitry

