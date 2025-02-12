Return-Path: <linux-kernel+bounces-510953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C06A3240E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64020162076
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6600F209F44;
	Wed, 12 Feb 2025 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0iYJc4T"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B77206F2C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357817; cv=none; b=QBdkSew4tlfH5kglEeBgOWVSpUUC89zUbQS3M/Hv17yyz4nD9oyrrvfA0YsJohB27mgI1a67CBCDa26zAyJE4wjItbVEMf+gY57KT1J5ICsL3FZ5xpkqyo3zjD5K2vAtMFt4lFM7ZQoKJRnoXxjA+amz8CeD4CUFyxFuwDsQUmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357817; c=relaxed/simple;
	bh=A5pC5dDJnqRwMtrMiOZEAqDqHk310SV88vnXHb2NFww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+l91VNv0cTmVLqvX7keZbwiPuwt/jV2t9JJG7z3wp94aX/B7ngVTzyB9heuijID/qcwoEzDX/1WvV8DyYbHFonbcPzVu2AWFdFk+psreC1AndKkmog5e86spU6deDirj5dcygE790oSP/uIaipNTf6us5EwObkmTRoG2+XGWJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g0iYJc4T; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-543cc81ddebso7301660e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739357813; x=1739962613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Sh3RbFHEBFXy8Gx0UkHY8V+uObJHLtwHJzqWdL8vuU=;
        b=g0iYJc4TGdfz/0FuMMKJLMApO/ihjgLRFABSRlTIUIspUEyiwhUJjzZgsysmIY44Rn
         LeLFYlWvsddgJhrTVgmu//9a5fCkS9+nswfgHrFxfOa8mGxouT++tU5HJjqRHlhg0f5N
         y7+Uf/gvn2C+8ooEQxhMZJH5lV9/9B0Sq9okFG5KkkDWkh1U6wEnxTv7kIfaLub9JXjs
         8qtaLbjC7oNdOUtXlVC0VeN2gje4hFs75nTYZd63RUDXsORaJ/711hh3pKOWgQqdrV/r
         qzUN5S1tPitDqu1GU/GsHTzEdNUkS6vWr6C9SJivnHmUZ7+NwJWA2khXkJ3vQe42xC/6
         SDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739357813; x=1739962613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Sh3RbFHEBFXy8Gx0UkHY8V+uObJHLtwHJzqWdL8vuU=;
        b=OxI/3+xULzZbxa/fruF7jCjdPrr6LyXJvwHlpaJRP68RZsGjAU9RSaulbJme8YNVkn
         QwpM05K/0Kxe5EbHD+8MXJ81uS43IyoKVDYBReujudRPziR1WYOGpHgRVGFnY0J3XDKt
         XZR/5xDjvK/aCe+iATfoYE3nNW8XVyMZ5HoupRd5v9RwaMRiste1vkjfs4Ktcudv+2VQ
         8yLHoKKd+AmL8ItK2h/AFIZo3UXjc193ZGuuxsMLYCbeOGvRa/4kg4O/O+i1BSyDxayZ
         YhoYYngLw2w8V0bd0JqGZwjjrrklf+/6IfCdPsn8wTMFkin28a0VTnwJrWkcN7mJQ3GJ
         vTQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSpedX+8tDXlDHU4XBC4zDMrb/+xxKUjlcuTgRuEGRVZfH0+nWE0kp/8Hf/u0VSq6p1arZriowPZU1DGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdGBcluApjjwDx3KLpeYigU6ZGrYGFOSuGSPp/sUUUvlUD3KYu
	4t5EG5taUmA9i/AQErJR8+J8IRXI1Zb+Kzt23y6zGLcoNj0sH8zvBD3/iQ4okno=
X-Gm-Gg: ASbGncunxImVBsnb0CdILiqwNWusim3S072DZQJLZSqFocQ1116F3sA4BPcs8l4dVY2
	7RJAkHKXgoN6g5GmBrfvxagWJqy23YIXZn6e7JI/FYHfgGTB/WWFTR+xKduY5OBeI1hLNo24uCl
	EGPGJ/zfc9W06dBXY+6o6PAnxbWEcZvvSyEIoe+4IwD9/+m8082651IIHUSKNcjx1KZ5JrpupZC
	tg21rkb7Dw6KnNrxn3EhGMBU5UfonSHgHZsh0guHTi/7kazvva0epkOE7Z5eGX3NW7AJNIvKen8
	hvBrddZhdDvXMdHM1gj1dRWI8OEYcf0xdB0QPHPThxAWwgzEuAdSjBR7tZ3mZJRnkzDHxXU=
X-Google-Smtp-Source: AGHT+IHZQXx3v7w680Qx+ZSGx5WSzNY1jlx0QqT9maGbSAp/UsmN348CsHz3deqPCtQuvMdlKI3eAQ==
X-Received: by 2002:a05:6512:4026:b0:545:6a2:e56 with SMTP id 2adb3069b0e04-5451818b3bbmr785437e87.37.1739357813106;
        Wed, 12 Feb 2025 02:56:53 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5450e83820asm788032e87.100.2025.02.12.02.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:56:51 -0800 (PST)
Date: Wed, 12 Feb 2025 12:56:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sa8775p-ride: Enable Adreno 663
 GPU
Message-ID: <fixmfluomzrdnoyztkd57gjpoqzutlv3m4es5jc7fclhpbauby@7u3ddi6dz4f7>
References: <20241030-a663-gpu-support-v3-0-bdf1d9ce6021@quicinc.com>
 <20241030-a663-gpu-support-v3-2-bdf1d9ce6021@quicinc.com>
 <4cfd1ebc-1a95-43d4-b36a-8b183c6dfd16@quicinc.com>
 <ah6nusoouth7ziu3iscxmafm6cxuwwebxt44ixsjmesp5adwc4@e5lnbztds2xd>
 <271e7b4f-454c-426e-a3f6-dcb55389374e@quicinc.com>
 <iymxe2hmjobctdimupp656xeyhctwd4yswbp2wobaneuzgxedu@cyhjb5ibkqmj>
 <c80ef960-7dc6-42bf-89a1-79e43be2bce0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c80ef960-7dc6-42bf-89a1-79e43be2bce0@quicinc.com>

On Wed, Feb 12, 2025 at 12:48:01PM +0530, Akhil P Oommen wrote:
> On 2/12/2025 5:30 AM, Dmitry Baryshkov wrote:
> > On Tue, Feb 11, 2025 at 06:41:39PM +0530, Akhil P Oommen wrote:
> >> On 2/9/2025 9:59 PM, Dmitry Baryshkov wrote:
> >>> On Wed, Nov 13, 2024 at 02:18:43AM +0530, Akhil P Oommen wrote:
> >>>> On 10/30/2024 12:32 PM, Akhil P Oommen wrote:
> >>>>> From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> >>>>>
> >>>>> Enable GPU for sa8775p-ride platform and provide path for zap
> >>>>> shader.
> >>>>>
> >>>>> Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> >>>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> >>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>> ---
> >>>>>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 8 ++++++++
> >>>>>  1 file changed, 8 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> >>>>> index 0c1b21def4b6..4901163df8f3 100644
> >>>>> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> >>>>> @@ -407,6 +407,14 @@ queue3 {
> >>>>>  	};
> >>>>>  };
> >>>>>  
> >>>>> +&gpu {
> >>>>> +	status = "okay";
> >>>>> +};
> >>>>> +
> >>>>> +&gpu_zap_shader {
> >>>>> +	firmware-name = "qcom/sa8775p/a663_zap.mbn";
> >>>>> +};
> >>>>> +
> >>>>>  &i2c11 {
> >>>>>  	clock-frequency = <400000>;
> >>>>>  	pinctrl-0 = <&qup_i2c11_default>;
> >>>>>
> >>>>
> >>>> Bjorn,
> >>>>
> >>>> Please ignore this patch for now. This is probably not the right
> >>>> platform dtsi file where gpu should be enabled. I am discussing about
> >>>> this internally. Will send a revision or a new patch based on the
> >>>> conclusion.
> >>>
> >>> Akhil, any updates on this?
> >>>
> >>
> >> I am still waiting for the discussion about QCS9075 board dts files [1]
> >> to conclude.
> >>
> >> [1]
> >> https://lore.kernel.org/lkml/Z3eMxl1Af8TOAQW%2F@hu-wasimn-hyd.qualcomm.com/T/
> > 
> > Why? We currently have several boards supported. We can enable GPU on
> > those as your patches are pretty fine. Then we can land Wasim's patches.
> > Not to mention that the discussion seems to be dead, last message was
> > sent almost a month ago.
> > 
> 
> sa8775p is an automotive-grade chipset which has a pretty different
> non-HLOS firmware. One of the major difference is that it has a SAFETY
> monitoring system (using SAIL IP block) which monitors different
> parameters like GPU frequency for eg and it takes control of the entire
> system when it detects an anomaly. That means we cannot use GPU DCVS,
> passive thermal mitigation etc there.
> 
> QCS9075 uses the same SoC but has different NHLOS firmwares that has
> SAIL disabled to make it behave like our regular chipsets. I am aware of
> only QCS9075 boards' GPU spec at the moment. I don't know the complete
> details of the impact of SAIL/SAFE features on GPU and other specs yet,
> so I can't disturb sa8775p-ride/qcs9100-ride boards.

Ack, thanks for the explanation. Indeed, it would be interesting to
understand how that's working together. Do SA8775P / QCS9100 use a
different GMU firmware?

> I can see that Wazim is still discussing about board DTS internally.
> Hopefully he will send out another revision of his series soon.

The discussion stopped a month ago. 

-- 
With best wishes
Dmitry

