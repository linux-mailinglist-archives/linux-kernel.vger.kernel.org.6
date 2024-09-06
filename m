Return-Path: <linux-kernel+bounces-318541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8543296EF65
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF56AB22163
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC3D1C86F8;
	Fri,  6 Sep 2024 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TD/XxqRe"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2031F1C86F2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615395; cv=none; b=LD7tUy2AMrrYVaKMh90WNOCF+4+iFLcIFHKmnwma2Y3LtpYgxbAYI2rr31GMyTQUj3hFjs+GaQiFB7DuXCFD94WPpQlslFy8UPiytV+pzAKjJSw01QzS21NjfA02cnZo2LEL0c2WXtdxLfh2xILj12meLlMmvA+vxnSRgWrZsww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615395; c=relaxed/simple;
	bh=p8TKYd9n7gZAwbCnrosjFG2oQ1QDhkATvk+6BeIB7G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMFd8svsDpJWjvYfIdZXGmjwxnSB1hb+CpD9L6Xwo4SwvJnb/bUnZNCxIjY0TcesHuT9LORdWtzGPcFPdAnn5YYiBgAj779q+oZOAj6ggIN7wsi5i4McbRykvBTZi5P9PmgT2bY6s9Ke0uy9m9RxbOD2dJkGHYmPw7TF2kXZ01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TD/XxqRe; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6b747f2e2b7so16662417b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 02:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725615392; x=1726220192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t9RjLyHC8jLYAxkxwbHI+OlYMfMmm4fKIBxKkIZmylA=;
        b=TD/XxqRevEegPir2KTkccOWjqLlL4N4JzawlLxDwXg+o9pN9FM5tA51NZW9MGu5yGY
         pgMa5kjLAo2/3XSSgvdlGdV7qTOtrD2Y3vvpdjU/Hg6CH7B2prte0L0mOw+YChEPB7X0
         NxSoCu7r6/TCoiJN/0AOFi8wNDCNHaeQl7I685g4YjclTFj10ZR6rWsx74+nfHceeMkl
         zCU1ttY0x6T+Nxrd3ME6sLhV58QLYNzHadh/oeKihnIzEI3VWKwhPm4vvBLZ7I66f5cv
         R94JdjaE7V7+7jMMJk+po0pheWso7tZUFnQX1Hf51ErivXsFlQKLY22HNo2xAg/Xr4QD
         dXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725615392; x=1726220192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9RjLyHC8jLYAxkxwbHI+OlYMfMmm4fKIBxKkIZmylA=;
        b=KqS58er/KLuBd5zJVZ7cWm/ewHikXKZmCHzq6YtP7uc5EOeQVqCh/JRUcm9tEosrPi
         G9149if9KDr8VmzoYQqJ9Lb83EpN1INXLtI70j5r80lLsxO0cnICDtMpZflpf05GmH4g
         cA/uXGVk1DwIIOFk6hH0I75QGM9lmqUpAk1BFEHMpx/uEiTuY1Ux6ai7h7JVdzH6F+cv
         HVnDPP0pU/8vS4MpkDfIkrJhczN7uprv0Kq8LB8uWn0F+j7dHXU8sgar0qYzny8Soqq2
         WQk6i2+DQV6IjGnLeh2poEQvnrGpf/3XJPDmxgdqU0mCzlH7sdc9wqiSmFXUAGAc5JHP
         PRQA==
X-Forwarded-Encrypted: i=1; AJvYcCX696s7SmAg3FeUoqIgWMp1npZVvJ0oW4E1QOk3Wt2U6el5kAUaD+hJyrSfJ16nzKYGhVKHdzFDbrW04CI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv9Bc4dkbWY3hPgQMo44mnfU0XK8r9njLp36eQ5Cocda9QZ6Wj
	EmixdPdXb77j9mBNXQkuF/CbUVd0+taFpRngHXq6atOR8iEojftzanigWzoHXYtovWv8qTVJFTP
	ADbVh1v5DJoPd/4HDVHaez5U8zWYRwoTYKUgv9A==
X-Google-Smtp-Source: AGHT+IEAXuLLtOrs6st8U8IFlSA7Hb1+mq58uwmSQKom7Bg9TkfvbOQJ9tJHSpVM8ugPgTF4bhcibOWF88qjBAWpuH0=
X-Received: by 2002:a05:690c:ec6:b0:6db:31f6:a812 with SMTP id
 00721157ae682-6db44d6249amr27514547b3.4.1725615391941; Fri, 06 Sep 2024
 02:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
 <20240904-qcs8300_initial_dtsi-v1-17-d0ea9afdc007@quicinc.com>
 <851566fe-4802-41c7-bb35-d6d1e9cf9bdf@kernel.org> <d5b13f14-ce66-496c-8182-aad840e0d5cb@quicinc.com>
 <wzjv6xvthoz3z4fimxfc6gzm6ptepkuwlzjm6xy3klmtpr3bvf@k7yxdc7hryju> <c674b8ff-6fdb-419d-86f4-69a940eccc2f@quicinc.com>
In-Reply-To: <c674b8ff-6fdb-419d-86f4-69a940eccc2f@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 6 Sep 2024 12:36:20 +0300
Message-ID: <CAA8EJpoxEZEZD3hhfpS6MeizqDVDDBjJOGo3X2BrLiEoZHDuoQ@mail.gmail.com>
Subject: Re: [PATCH 17/19] arm64: defconfig: enable clock controller,
 interconnect and pinctrl for QCS8300
To: Jingyi Wang <quic_jingyw@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 09:15, Jingyi Wang <quic_jingyw@quicinc.com> wrote:
>
> Hi Dmitry,
>
> On 9/6/2024 11:18 AM, Dmitry Baryshkov wrote:
> > On Thu, Sep 05, 2024 at 12:54:35PM GMT, Jingyi Wang wrote:
> >>
> >>
> >> On 9/4/2024 5:39 PM, Krzysztof Kozlowski wrote:
> >>> On 04/09/2024 10:33, Jingyi Wang wrote:
> >>>> Enable clock controller, interrconnect and pinctrl for QCS8300.
> >>>
> >>> NXP QCS8300? What is QCS8300? Which products use it? That's a defconfig
> >>> for entire kernel, not your Qualcomm one.
> >>>
> >> Will describe it in more detail.
> >>>> It needs to be built-in for UART to provide a console.
> >>>>
> >>>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> >>>> ---
> >>>>  arch/arm64/configs/defconfig | 3 +++
> >>>>  1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> >>>> index 81ca46e3ab4b..a9ba6b25a0ed 100644
> >>>> --- a/arch/arm64/configs/defconfig
> >>>> +++ b/arch/arm64/configs/defconfig
> >>>> @@ -606,6 +606,7 @@ CONFIG_PINCTRL_MSM8996=y
> >>>>  CONFIG_PINCTRL_MSM8998=y
> >>>>  CONFIG_PINCTRL_QCM2290=y
> >>>>  CONFIG_PINCTRL_QCS404=y
> >>>> +CONFIG_PINCTRL_QCS8300=y
> >>>>  CONFIG_PINCTRL_QDF2XXX=y
> >>>>  CONFIG_PINCTRL_QDU1000=y
> >>>>  CONFIG_PINCTRL_SA8775P=y
> >>>> @@ -1317,6 +1318,7 @@ CONFIG_MSM_MMCC_8998=m
> >>>>  CONFIG_QCM_GCC_2290=y
> >>>>  CONFIG_QCM_DISPCC_2290=m
> >>>>  CONFIG_QCS_GCC_404=y
> >>>> +CONFIG_QCS_GCC_8300=y
> >>>>  CONFIG_QDU_GCC_1000=y
> >>>>  CONFIG_SC_CAMCC_8280XP=m
> >>>>  CONFIG_SC_DISPCC_7280=m
> >>>> @@ -1618,6 +1620,7 @@ CONFIG_INTERCONNECT_QCOM_MSM8996=y
> >>>>  CONFIG_INTERCONNECT_QCOM_OSM_L3=m
> >>>>  CONFIG_INTERCONNECT_QCOM_QCM2290=y
> >>>>  CONFIG_INTERCONNECT_QCOM_QCS404=m
> >>>> +CONFIG_INTERCONNECT_QCOM_QCS8300=y
> >>>
> >>> Why this cannot be a module?
> >>>
> >>>
> >> I think the commit-msg "It needs to be built-in for UART to provide a console." can
> >> explain that, could you please help to share your insights on that?
> >
> > Unless loading these modules from initramfs doesn't work, please use =m.
> > The drivers that are enabled here are going to be enabled for everybody
> > using arm64 defconfig, taking up memory on their platforms, etc.
> >
> We had previous discussion here about why these drivers needs to be built-in to support
> debug-uart:
> https://lore.kernel.org/linux-arm-msm/c11fd3c2-770a-4d40-8cf3-d8bc81f7c480@kernel.org/
> I will mention more details in the commit message of this patch.

Yes, please. Explicitly mention that this is required to get UART to work.

-- 
With best wishes
Dmitry

