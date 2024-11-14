Return-Path: <linux-kernel+bounces-409238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7EB9C8961
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD1F2847B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDAD1F9EBD;
	Thu, 14 Nov 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJno4IzC"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB671F9424
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585642; cv=none; b=pFdkiWfWqsX0sqgyonsDnNy5YlqgUqQ+/MWtjQNYhS6kDOszC+qhRAW/g2PFF5feELoCrn4QMVacOJvw8aSGPUvQzb7Ql5Kpf9w9ctDpOLjqwqMb3u4h6p91VUDamETnNo5asP1bTNmR+355JRGJdmHdFtywQDeza0vDao3jWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585642; c=relaxed/simple;
	bh=2YNeAq7nUz3EVSarszFDV4m0bo5zGG8hkdy2omllyGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctUPJa2KYEJhlh58ZfeZVqgFO3rA+1nV50vqKkNwtoNSOVaGhi+9wmzZ7j351HKmJQbRKHBT6LJsE3RK2DKR6d5U0rA5WmfrfOd9H9BS1JiemmhqLEYsdGF4jP4yByaotT1BGWVeE5Ip3N7l9Y/5WXTizMDlX9mjxeTSpUN8sMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vJno4IzC; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53da22c5863so507741e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731585639; x=1732190439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NRRBK4+PkVV0SMZdEbJR6/cXzeTbiFxvJHPZ285x0Ag=;
        b=vJno4IzCMkIISmN8G+P/IB6n9lo+yIC90AdHQ2lQ+Yenig2wXGw9a99S5GoUAAgJaC
         //kef+s+LKtU2TAlBib+T7lIzfyVOWpzdncMPni/FXs1DHL+ByV2ILVs0e+1uZGjb/bE
         IlIlHsu0bVJoB0dLptnA+PVUWd3jnYJEeKd3vDJjIdi56t3mhzoLTQbKvdPd7gv8n8OP
         YCVoeCCJnUlX9x6xwhdSM5fIocD6JUNBVyAAng6q9+9ae/3FlQXOyM0egWc0mRgYlROU
         +QHyAzDIe2jFEK+N8antkwnCyS4P6EAJ0FJZyR8d+kG00M6KJjujJ/Q8VbeHnnvcH0KL
         6Stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731585639; x=1732190439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRRBK4+PkVV0SMZdEbJR6/cXzeTbiFxvJHPZ285x0Ag=;
        b=ZjNWfHS52fIICl5zPVRdX1kx+fyoKnzOPkaLKs9UdEXqYW1fO7TTOzFyt49ZjkTbcq
         /pF2V891snfVqLu7Bd6vs2CIjsDCdFTSTqRa2wtCWJRQKZTPJ47JVqlEk3dsnZmxW6/y
         DK3G2FhWrjfR4GTgKxyvT3fWiuF8/luvbw3O/o8fAFxdNms7VEk0IG5Z4eM0YKvfWL3H
         hjdm0q+yYsRgituhuu9p+Vm1LcQHXmSMTjqttkzIUbM+AyBPG3J3EAGmzC3a2g0lO5aR
         B9BMQLTKxRSkkkLIZVuwpbakCwOQY012lsJfVHusmppYp3sahbX04nhihml8vveKjQPw
         scqw==
X-Forwarded-Encrypted: i=1; AJvYcCX+TG0Ptak+nkkxSDqSu926yL/mJfo1zagEwUf9lvCortGzgANlytfLeKLaLhf5IzcqHQWW8Z+GU5DSCwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThfJo+aruACwQiWqYjPS8tc3Kcfb46yxYFKHr5J8Z5mXxF+6N
	y42qLDbGYcwII9yd2bM3GsYav//y+FXhS2yv0lxEDGIuicQt1DTmb7SOCJyViFuIXNQKKkqoOaP
	y
X-Google-Smtp-Source: AGHT+IElKOY/CTNY+jO4gR5Mef2vnpnme0SP+LIl5s6JaZ6ueTqwXe9hXFyAINkFss5pfmDdXbo7SA==
X-Received: by 2002:a05:6512:ad6:b0:539:fb7f:6288 with SMTP id 2adb3069b0e04-53d9a42e186mr5522325e87.35.1731585638896;
        Thu, 14 Nov 2024 04:00:38 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da653e3eesm156316e87.200.2024.11.14.04.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 04:00:37 -0800 (PST)
Date: Thu, 14 Nov 2024 14:00:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	srinivas.kandagatla@linaro.org, quic_bkumar@quicinc.com, quic_chennak@quicinc.com
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Make ADSP a secure fastrpc
 domain
Message-ID: <sbkm5wvhtjoluhz7mi7f2wyc4t5znhazcxra52cd5yev5iksbi@yqielk6i7bpe>
References: <20241113050042.181028-1-quic_ekangupt@quicinc.com>
 <5oqzxppquoeppt6xnjfm2rdwm23hbui5k3caz5v5ffqzizepob@dz5ikvzgbd4x>
 <c1f0e56b-b489-4370-99e3-0973641410b8@quicinc.com>
 <CAA8EJprDTz7b4rNtR4e9A-=j9_z-aJGBg3+g5is8Bmy=cgTM1Q@mail.gmail.com>
 <b8a9a8f5-1f36-4eea-925b-84578e71838d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8a9a8f5-1f36-4eea-925b-84578e71838d@quicinc.com>

On Thu, Nov 14, 2024 at 10:49:52AM +0530, Ekansh Gupta wrote:
> 
> 
> On 11/13/2024 5:20 PM, Dmitry Baryshkov wrote:
> > On Wed, 13 Nov 2024 at 08:18, Ekansh Gupta <quic_ekangupt@quicinc.com> wrote:
> >>
> >>
> >> On 11/13/2024 11:13 AM, Dmitry Baryshkov wrote:
> >>> On Wed, Nov 13, 2024 at 10:30:42AM +0530, Ekansh Gupta wrote:
> >>>> FastRPC framework treats ADSP as a secure domain on sc7280 SoC
> >>>> which means that only secure fastrpc device node should be
> >>>> created for ADSP remoteproc. Remove the non-secure-domain
> >>>> property from ADSP fastrpc node.
> >>> If this prevents the non-secure devices from being created, isn't that a
> >>> regression from the userspace point of view?
> >> The actual intention of having secure and non-secure domains is to utilize signed(high privilege)
> >> and unsigned(low privilege) DSP processes properly.
> >>
> >> Non-secure device node is intended to be used by untrusted/generic applications which needs to
> >> offload tasks to DSP as unsignedPD. Only unsigned PD is expected to be allowed if the process is
> >> using non-secure node.
> >>
> >> Secure device is intended to be used by trusted processes like daemons or any application
> >> which needs to offload as signed PD to DSP.
> >>
> >> The ideal expectation from userspace is to first try to open secure device node and fall back to
> >> non-secure node if the secure node is not accessible or absent.
> >>
> >> I understand your concerns, can you please suggest how this can be improved/corrected?
> > Thank you for the explanation, and thanks for the description of the
> > expected behaviour, but the question is different.
> > Currently (with the property being present in DT) the driver creates a
> > non-secure fastrpc device for the ADSP.
> > Can it actually be used? Note: no mentioning of a particular userspace
> > implementation or the (un)expected usage.
> > If it could not and an attempt to use it resulted in some kind of an
> > error, then the patch is a fix and it should be decribed accordingly.
> > If it could be used and now you are removing this possibility, then it
> > is a regression. Again, this must be clearly documented, but generally
> > this is not allowed.
> Thanks for the clarification, Dmitry.
> 
> As of today, if the property is present in DT, non-secure fastrpc device will be created
> for ADSP and as there are no checks to restrict daemons to use only secure node, there
> will not be any failures observed. So there is no error if non-secure property is added
> for ADSP and your 2nd point holds here.
> 
> Problems with the current design are(you can look into below points independent of the change):
> 
> 1. This creates a security concern as any process that can open non-secure device
> can replicate daemon to attach to DSP root PD and cause troubles there which is not
> a good thing. So basically any trusted process(maybe same group) should only use secure
> device node and any process using non-secure node should only offload to unsigned PD.

Again, you are describing expected behaviour. Other userspace clients
can deviate from this.

> 
> 2. Having this property well defined also help in scaling fastrpc driver for new domains(like CDSP1
> was recently introduced) as driver can only rely on the "label" and "non-secure-domain" property
> for device creation. Say, only secure device is create if property is not defined and both device nodes
> are created if non-secure-domain is define. This way, the dependency on domain_id can be removed
> from fastrpc_rpmsg_probe[1] and create either only fastrpc-xdsp-secure or both(secure and non-secure).

Well, I don't think I follow this point. The property is already
well-defined.

> 
> This however is a regression as you have mentioned, but it it helps address multiple problems.
> 
> Should I discuss further on documentation or is any more design clarification should be done here?

At least you must explicitly specify that this causes changes to
userspace, and all the reasons to do that. So that everybody else
doesn't have to read between the lines.

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/misc/fastrpc.c#n2327
> 
> --ekansh
> >> --ekansh
> >>>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> >>>> ---
> >>>>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 -
> >>>>  1 file changed, 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>>> index 3d8410683402..c633926c0f33 100644
> >>>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>>> @@ -3852,7 +3852,6 @@ fastrpc {
> >>>>                                      compatible = "qcom,fastrpc";
> >>>>                                      qcom,glink-channels = "fastrpcglink-apps-dsp";
> >>>>                                      label = "adsp";
> >>>> -                                    qcom,non-secure-domain;

- Are there other platforms which have this flag set for ADSP?

- Granted that sc7280 was targeting ChromeOS devices, might it be that
  there is a CrOS-specific userspace for that?

> >>>>                                      #address-cells = <1>;
> >>>>                                      #size-cells = <0>;
> >>>>
> >>>> --
> >>>> 2.34.1
> >>>>
> >
> 

-- 
With best wishes
Dmitry

