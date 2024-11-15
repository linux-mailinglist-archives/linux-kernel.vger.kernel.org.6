Return-Path: <linux-kernel+bounces-410859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8914E9CE941
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4F5288391
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D771D4613;
	Fri, 15 Nov 2024 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="rLDQ+yyi"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9A31CEEB8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683188; cv=none; b=n2ymGyR3t6IxCs7HR+f4l5jcOX31ZrcyrJFNoadRUm4ISZez2W8AMA9IhurSVYpLZBNIX8PKVTNvDQ76kDA1mE1cUAxKE1noRXIByLnYGwN/z+ZcfRPIvoijjwE4SdJzKNe1TRU/c7R9OaNqWF63rfo8Wwe40to+ownc6FZwPG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683188; c=relaxed/simple;
	bh=uPhgKsx31+w99ZN5CAn4r/SW8AcxxzhuHcuFUO+IyG0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Yum/piTRSZvDKJejS6RcvgldGOvg9lMbrT0OBTLBEFiPm3J5iV9jzyy6Zci3XZWu3TyXs6OjMbTuDxhAqTWbV6/VSlHdnjDhH1gW1gWO8zIMut4ZFwCa36d3/McfCNLWuupHFkjd3a7+WLAky2SGb8qeAFYV0oX+SjaG9hnoXQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=rLDQ+yyi; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so2392264a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1731683180; x=1732287980; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDOl7NltAXr6G8mTcGijCAhgwcSdhqInV58H0gMs9FY=;
        b=rLDQ+yyir9CMwY28CEiJhv2vdFCVNztboPr0RgUuxyvCr6PGZ00PpcCb3S18jqDuQ7
         8habij7cL9ZMlLQoBMEf/Vmi2awuWSaO9huHN5uyOKjxapSr9xzUilNHqxVd+LHYx2LT
         z8EZkbbxR7Ea7jQ9dHyOVydDwukTWfjOSBztEiIl7L6SkfWhrjOZsh+c20B/b+xNzQVh
         K58MBEYp5R5fCycgWeK4PIAaT44hWC9owA/Pq5dqtHx6Pw74oiEM3f12KwQHdV1Hm/Un
         NpvgV3VbE+s2Y4V4DvBgkxhnMcmOV+A8jVLbO53bfpBdejymoljZL0BEWORfV454XtvC
         mmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683180; x=1732287980;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uDOl7NltAXr6G8mTcGijCAhgwcSdhqInV58H0gMs9FY=;
        b=RHOP/aGJmGLIce/XmToR9TDyPz3kTPiovIHupmh93ponBhZqOaB5in5nkj5+KRwCO4
         ofR4BnGHzWhWqn8J9XKEbeWHkbyGzP5xw96za51mzqmTGaHLt729PJkAZwrcqp/XxWrj
         Gd2d5Tu1orJcLPdb+Y96+JSId5yywQV+DT6vxxUSa13wkM1+mxK6HLNdvCfcu146ZVBE
         ZO8myfmpQqwBvj8aRvoWwky8e8Tl/SYweZH6Tpmo+V8YXdnBn/QTQ1hQ755Q4syALRJP
         d/CG43+VT60lA/F2myGrj/NljCneXSJ0Hm/w/8/XaLohG+s07taoHwulTVT0+WjJdwoZ
         wixQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMv/6lVrCkpNumryglXMNxV4X7Y66kSlT0SpqW9eQz+vERffUSC1+THi2UptxWA7IjTCD/1Z9fOuxYSxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDDBObF0uuAssqzs5TSdNsPXGgcSs+QrMxBlXPJaFQZBsQcrL5
	DM5Hb08ALGXBAXGesFMPFa3IB6IMQnCV9umMZUmriZ7kHdJiZ4GVLSlxKdCtBfY=
X-Google-Smtp-Source: AGHT+IFedO/GRq2PCsSSCKMui+UkqTBIrEZvLlVfKH50GUxLxbbg1/IGmebko5wSJKNUi0L/dcOMmQ==
X-Received: by 2002:a17:907:3d86:b0:a9a:14fc:44a2 with SMTP id a640c23a62f3a-aa483488086mr263775366b.30.1731683179714;
        Fri, 15 Nov 2024 07:06:19 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e0434f6sm186743766b.139.2024.11.15.07.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 07:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Nov 2024 16:06:18 +0100
Message-Id: <D5MUGDO3V9ZE.2EQQUXKCQV3QB@fairphone.com>
Cc: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <cros-qcom-dts-watchers@chromium.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <srinivas.kandagatla@linaro.org>, <quic_bkumar@quicinc.com>,
 <quic_chennak@quicinc.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Make ADSP a secure fastrpc
 domain
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>, "Ekansh Gupta"
 <quic_ekangupt@quicinc.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241113050042.181028-1-quic_ekangupt@quicinc.com>
 <5oqzxppquoeppt6xnjfm2rdwm23hbui5k3caz5v5ffqzizepob@dz5ikvzgbd4x>
 <c1f0e56b-b489-4370-99e3-0973641410b8@quicinc.com>
 <CAA8EJprDTz7b4rNtR4e9A-=j9_z-aJGBg3+g5is8Bmy=cgTM1Q@mail.gmail.com>
 <b8a9a8f5-1f36-4eea-925b-84578e71838d@quicinc.com>
 <sbkm5wvhtjoluhz7mi7f2wyc4t5znhazcxra52cd5yev5iksbi@yqielk6i7bpe>
 <9b16f4d8-56ea-4ef6-9cb5-35750af871e9@quicinc.com>
 <7grzazq7tfv3kixnevia2fkebe6o352372g3gpdinqeihmuavl@6qxd6vvwcwgt>
In-Reply-To: <7grzazq7tfv3kixnevia2fkebe6o352372g3gpdinqeihmuavl@6qxd6vvwcwgt>

Hi Dmitry,

On Fri Nov 15, 2024 at 3:45 PM CET, Dmitry Baryshkov wrote:
> On Fri, Nov 15, 2024 at 05:40:23PM +0530, Ekansh Gupta wrote:
> >=20
> >=20
> > On 11/14/2024 5:30 PM, Dmitry Baryshkov wrote:
> > > On Thu, Nov 14, 2024 at 10:49:52AM +0530, Ekansh Gupta wrote:
> > >>
> > >> On 11/13/2024 5:20 PM, Dmitry Baryshkov wrote:
> > >>> On Wed, 13 Nov 2024 at 08:18, Ekansh Gupta <quic_ekangupt@quicinc.c=
om> wrote:
> > >>>>
> > >>>> On 11/13/2024 11:13 AM, Dmitry Baryshkov wrote:
> > >>>>> On Wed, Nov 13, 2024 at 10:30:42AM +0530, Ekansh Gupta wrote:
>
> [...]
>
> > >>>>>>
> > >>>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/b=
oot/dts/qcom/sc7280.dtsi
> > >>>>>> index 3d8410683402..c633926c0f33 100644
> > >>>>>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > >>>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > >>>>>> @@ -3852,7 +3852,6 @@ fastrpc {
> > >>>>>>                                      compatible =3D "qcom,fastrp=
c";
> > >>>>>>                                      qcom,glink-channels =3D "fa=
strpcglink-apps-dsp";
> > >>>>>>                                      label =3D "adsp";
> > >>>>>> -                                    qcom,non-secure-domain;
> > > - Are there other platforms which have this flag set for ADSP?
> > Yes, there are a few platforms where this property is added for ADSP.
>
> Please clean up all of them to reduce a possible chance of different beha=
viour or further c&p errors.
>
> > > - Granted that sc7280 was targeting ChromeOS devices, might it be tha=
t
> > >   there is a CrOS-specific userspace for that?
> > FastRPC nodes were recently added to this devicetree recently. Looks li=
ke this property is just getting copied.
> > It might be that fastrpc was recently tried on ChromeOS device or it mi=
ght be added to support some other devices
> > that uses fastrpc(qcm6490-idp etc.).
>
> Indeed.
>
> Luca, could you possibly comment, as you've added ADSP / FastRPC nodes?

I've just followed other platforms, I have little clue about FastRPC
myself apart from it being used for hexagonrpcd for interfacing with
sensors. There's not much (any?) docs out there.

Regards
Luca

