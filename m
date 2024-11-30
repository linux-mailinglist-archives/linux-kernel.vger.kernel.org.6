Return-Path: <linux-kernel+bounces-426178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FFB9DEFE9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16294B20F4E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36306155742;
	Sat, 30 Nov 2024 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1s+mfuM"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0012B93
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732962397; cv=none; b=C4oPF3z5pArTh4PJYn0hu5Fcgr43wZZT4lMigxpF+ABktzssKJWAoCgQ7Tx7FPjMqJr+/xKjSDW2ai5Dl2iPd6shso2e3hd5cLk9LkNNy+SBTdjaaaGg2sY///lFyHfhuODbfnZeC/G//kl+cdPtnEUQ1xaDL66tOy6FcJ2jr+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732962397; c=relaxed/simple;
	bh=eDJQoppfMN1lVMfa4jaHOqGoqkC2saALXH3Q4Rrsb/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtvFCblQbF37vSo5si8j0XGzwXjTWwpn+IyDg5zPJU07RaI1N5c5Zp3RhkHm9lpq69ovEw4eVc9Hq0FblgAuxa94VwjkqpwOLx6ZbFovXQvePvjL4ekFldo/An2E9x0lOpuvdm5yOWgEGe3FAM+zlaCQoRsipx6HPCb1xB/iFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p1s+mfuM; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53df1d1b6e8so2686771e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 02:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732962394; x=1733567194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MvTccSJmx0934Um7HOqo8o286KNWawV///lCSR0MDWU=;
        b=p1s+mfuM3q22fyiwRCVTeI0dMR9wnST7RgZTQiCgRlNPtpdnXbC0znudziq4yklVha
         GdhdNGHQhnVdrb0Qz6BOqjJCweOWKB4Ue52VmhvbQeiY7BK6b/W0G+8GZd/2ijsOwXV8
         dgkeXqHyi2cfdIASvriHC7gdSm93LMX21qoPgeVPpwXX4ByzioIxGUMdEZmbd1WGc3OP
         ESyNDXXY4lLxbkIuwEcb6nJoE8cjczJl7LfowDfrAACG+RbxlDJoenRNzoE01QhIqAsP
         yITz7cg4ixB70LXsRBPl/3iN9HmuoHcJHfabCranBKfCQIX6GfFnabHd01x+8XU3QvsC
         K2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732962394; x=1733567194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvTccSJmx0934Um7HOqo8o286KNWawV///lCSR0MDWU=;
        b=Qa65kRAvQX7y3X/YjyMpwORAV3JAVQkFTEVdGLdBP2TR2BSIYk00Unwqs0a5A1vD/r
         i8pIr2gB3t7RcoeuW4WHBBwn7GPQm3Zo2wLD7MkUjC64ayzXLk4ECVf/DJlOCY8EOY/i
         BTVFN7x0mehuSyCumXm2ah9nNkCBlpvhTyk6vRAyMNHiR0PnBo2F47pIwY7EB7A9d7yv
         6rly/wY92Oa139i87s0SUvax9AFA4QTytV7KznwFb6NvyFaUnI54CAC0euHOk2dxjamO
         GOjv82G77w85PleYQwhBCnoYDQyXkG36A2wykQ7bGqxLmCKwl/eaUGT8LQRGpfP7cX6r
         wxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXID6wSceoqy6AUs9QGqCZXM4sbZOEP5N65+PAD5a+OpKfMTtBbu61alBUo67j1QJEYi3qDO9R2rhTBKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQwV+FJD6rM0jtzzsVrC5MxkEQ908cHER4m9NBhSjQEzbPPTLl
	4KG+Mz72ct1giJhtu9fudo8U7ZXzj81RBoHFMZCuwa7Zp67Lo+zTi+2ThrBl9I8=
X-Gm-Gg: ASbGncuz5h5Dgetcb1aPy3SUDCMq17hm78tfaA3yohKgAahbBXHYcp6KWl64sDzphBo
	474IRpfEG21hI6+vm3ZmW48QC9g6Xox+SJRkxSB6d0OleWWGmkoiMXh/f2DpmD8ajN+VBndiG72
	4M0VorQPQaR7Hhvb6cEG9lcytew6dUxinDzFtNyJGpRjr3n/NvKjkFCa0ygQpVLlJ2kNVyI60zA
	i0pJDlD4u3VLDPDe0xPxHPShIp4cL155/SwSHJ7eetFDQQEmpj9+zsbJ+ERxuTKtpCiLHygUYA9
	NLh6aTngyJQ8NEjoFzCMqZb76fphMA==
X-Google-Smtp-Source: AGHT+IGrAqc65dTA3vAAj8VxgDEeVfx2WF/Vu2h5+M8g7PoZsRRzBflVglyba38msIXK/Y9d+/AF8Q==
X-Received: by 2002:a05:6512:3e1e:b0:52f:ca2b:1d33 with SMTP id 2adb3069b0e04-53df00d4579mr5387608e87.20.1732962393846;
        Sat, 30 Nov 2024 02:26:33 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a09e6sm739763e87.264.2024.11.30.02.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:26:32 -0800 (PST)
Date: Sat, 30 Nov 2024 12:26:30 +0200
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
Message-ID: <26lttxx7obu2oqvf4xnooqi3o7qwodhjzyjh4trjq5tlj2gzxs@uwihybmwbdid>
References: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
 <20241130-fix-board-clocks-v2-20-b9a35858657e@linaro.org>
 <83990b97-3f37-47f0-9cc6-fdaa730a8df1@linaro.org>
 <zdhevcnj6gszvaayhu2dghubwm23cdoyeik2dcnqo376gcstnz@xv46iu6l6yvu>
 <90418b49-5b19-4bef-b0cd-398bb562aa8c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90418b49-5b19-4bef-b0cd-398bb562aa8c@kernel.org>

On Sat, Nov 30, 2024 at 11:00:32AM +0100, Krzysztof Kozlowski wrote:
> On 30/11/2024 10:57, Dmitry Baryshkov wrote:
> > On Sat, Nov 30, 2024 at 10:29:38AM +0100, Krzysztof Kozlowski wrote:
> >> On 30/11/2024 02:44, Dmitry Baryshkov wrote:
> >>> IPQ5018 is one of the platforms where board-level clocks (XO, sleep)
> >>> definitions are split between the SoC dtsi file and the board file.
> >>> This is not optimal, as the clocks are a part of the SoC + PMICs design.
> >>> Frequencies are common for the whole set of devices using the same SoC.
> >>> Remove the split and move frequencies to the SoC DTSI file.
> >>>
> >>> Suggested-by: Bjorn Andersson <andersson@kernel.org>
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>
> >> This contradicts DTS coding style and all my existing review. Obviously
> >> that's a NAK from me. If you want to merge this patch, please kindly
> >> carry my formal objection for this and all following "move board clocks"
> >> patches:
> >>
> >> Nacked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > I'd kindly ask Bjorn to chime in as a platform maintainer.
> 
> 
> To change my NAK? NAK is still a NAK. We discussed it many, many times
> already. We have coding style for this explicitly mentioning this case.
> Could not be more specific... plus all my reviews for Qualcomm, NXP, TI,
> ST and other platforms. I would be quite unpredictable or unfair if I
> gave here some sort of exception while expecting different code from
> other platforms.
> 
> Please carry my NAK.

Of course. I didn't mean to drop your tag or your objection.

BTW, would it be possible for you to clarify the policy on external
references? I mean, is it fine for DTSI to reference a label which is
not defined within that file or within one of the files that it includes?

-- 
With best wishes
Dmitry

