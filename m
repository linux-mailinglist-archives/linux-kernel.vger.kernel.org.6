Return-Path: <linux-kernel+bounces-406175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22B9C5BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF22284F18
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8883E2003D2;
	Tue, 12 Nov 2024 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="r880ZjN1"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CAE2003AE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424785; cv=none; b=TSymPQo8RaCPfj8BUAhmuRRLzxSMO95+goKcQeWIGETRW+Zf9bFCrdHQBzzd8g1P5umeDkMbxMSx7ornUm6oC3Z7khNh8/I3KpjuyZFZSqT5GJTCEci5G/mqoCac+BIo46JtMYe9rqNchB4p27GjXOM3xd22Vl17/DZolo3KrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424785; c=relaxed/simple;
	bh=VcST2DUlRpkwQVHrrTYbdpK9dzUETeVrbngBLMBL+yk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=lGoZl4K93YjcoRfdH2vSDuBbngxCYxggoV8QH85o++n+FdFsxqwajk53fwCThb54xhDAL7DQMkWFBC+pFzAUC8j0ow/VVqiGU6qjkSCz/ixf1j1Xyk1PSs9xV/8j+LuXnUEF59kW1ee5N1xNqYgpS0saHSWoDtQn7+/lIM2vPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=r880ZjN1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d5689eea8so3417002f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1731424781; x=1732029581; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVQ8k1+GJHVS0OPZNtSMzBKEyDSg8j47tQMzgymLCow=;
        b=r880ZjN1vVgsjG4doC37tDg7m8yT/362tcO+drf3LMAGtU+W4Zw4XuLTPqe+30iT8y
         rkprgGMXMhjVJqm+ifrMmo3W1fHcC26cDmk048ZUCUthCAKZilzuFiVd+jFCMPZqa5d4
         opPATqnd1NVq/OdFOtUKn4nNcg4nqc4DoOJtG0EoJZ21uXhCVf9OqGJG/NPZw4oZoz3W
         qyTvPDnZHXhbHsU3gZxrLpnOGidJvErwnURij7oQW6xFfzYpxm60wu79Hvmm9jzBW7wj
         QSGmrw+rrebi5zrA+7GWhsp8RtE2GPVHhTGvA/178oqI9tjPFv+98cuUGbAd0j+6tt6V
         HwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731424781; x=1732029581;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MVQ8k1+GJHVS0OPZNtSMzBKEyDSg8j47tQMzgymLCow=;
        b=K8qGxwH1+Q31z6RG2uxdYL+LbjVFGBBDnduDpiJHKbs/4EGFaRUsZkL/adyiCOY668
         4KAcQ7NwW14uIRw/XsNLhThQuCyoPnL1xy82AMRQvr7TSmKHH6BJsTcNUjFEcYcUGXcG
         2k/NYJR8ySKnSo/STYzAmCIye0fNPPAb39k5l9mxX5pngmQFoAvxRXUG/TGfQvO83Ffu
         lQqI5zSmaNHJMNRnwyZwbdjOQ+7PKK/SR7QZ+EXxK9jLJ86f81j4GlzLNtqnmTFGRkV2
         0dPEagBieXem8hC/XEHzMylJKOJt4x7PRpwi7jvkAgtr4iRCb8Q1DcPaVp7KdH86iq8f
         hW+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBE9jywWg/mX9zzWUk1Ju73heGYILMJMi9LAEI/ljVu5BnmkgfiDcePjqhEoHyKQIFoycDOsXWGqZ7IvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wFWf7YHZJfKROc8nX4jJjMU/4ZLjf2P6n3uVkL/lpxvdwDXf
	zfDjV5r84VFNgpGtjye1jkG1Szj+pQ7B3kTIs4a9bx1hRQLv4hwuUTJ362o7Q5s=
X-Google-Smtp-Source: AGHT+IHMf24WTrO4WpyXzvZV8UKgh3y3VTD5Esq4U79Ud4jGOPxTux5xkh61tHoiAx1XCvZY9wi66Q==
X-Received: by 2002:a05:6000:1ac9:b0:374:c640:8596 with SMTP id ffacd0b85a97d-381f186fc60mr14314412f8f.32.1731424781413;
        Tue, 12 Nov 2024 07:19:41 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381fbf416c6sm7330352f8f.54.2024.11.12.07.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 07:19:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Nov 2024 16:19:40 +0100
Message-Id: <D5KAUZHYJHFS.1NXF5SVWYL03G@fairphone.com>
To: "Vedang Nagar" <quic_vnagar@quicinc.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@linaro.org>
Cc: <cros-qcom-dts-watchers@chromium.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konrad.dybcio@linaro.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: enable venus node
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241004-venus_sc7280-v1-1-4d7d8fd7e95b@quicinc.com>
 <kezh3lmysij56g2tjwwuas5r26ro5i777yxxitsdcjeg7zp67v@oknrdbkzison>
 <78e6ff6b-efe1-496c-a1fb-c9a0a4aba2d2@quicinc.com>
 <CAA8EJpqqZL7xybcbJMsbTQB+ht5-A+ocNs+Sq30j=v1zM3JL9g@mail.gmail.com>
 <fbba794a-ba04-4790-b5e9-b4df3cba35b2@quicinc.com>
In-Reply-To: <fbba794a-ba04-4790-b5e9-b4df3cba35b2@quicinc.com>

Hi Vedang,

On Tue Nov 12, 2024 at 3:39 PM CET, Vedang Nagar wrote:
>
>
> On 11/12/2024 6:43 PM, Dmitry Baryshkov wrote:
> > On Tue, 12 Nov 2024 at 08:17, Vedang Nagar <quic_vnagar@quicinc.com> wr=
ote:
> >>
> >>
> >>
> >> On 10/7/2024 1:20 AM, Dmitry Baryshkov wrote:
> >>> On Fri, Oct 04, 2024 at 04:22:31PM GMT, Vedang Nagar wrote:
> >>>> Enable the venus node on Qualcomm sc7280. It was made disabled
> >>>> earlier to avoid bootup crash, which is fixed now with [1].
> >>>
> >>> NAK, there might be other reasons to keep venus disabled, like the la=
ck
> >>> of the vendor-signed firmware for the particular device.
> >> Can you pls elaborate more on this? Any device with sc7280 SOC can use
> >> venus.mbn which is already present in linux-firmware git.
> >=20
> > Can it though if the device is fused to use vendor keys and to check
> > the trust chain?
> Yes, infact the existing ones are signed and works with trustzone authent=
ication.

No, the venus firmware from linux-firmware does not work on a device
with secure boot on, like the (QCM6490) Fairphone 5 smartphone.

$ rm /lib/firmware/qcom/qcm6490/fairphone5/venus.mbn
$ cp /lib/firmware/qcom/vpu-2.0/venus.mbn.zst /lib/firmware/qcom/qcm6490/fa=
irphone5/venus.mbn.zst

leads to

[   10.848191] qcom-venus aa00000.video-codec: Adding to iommu group 13
[   10.863062] qcom-venus aa00000.video-codec: non legacy binding
[   10.909555] qcom-venus aa00000.video-codec: error -22 initializing firmw=
are qcom/qcm6490/fairphone5/venus.mbn
[   10.910099] qcom-venus aa00000.video-codec: fail to load video firmware
[   10.910849] qcom-venus aa00000.video-codec: probe with driver qcom-venus=
 failed with error -22

It's the same with e.g. adsp firmware, modem firmware, etc.

With secure boot off, yes, the hardware will load any firmware
regardless of the signature.

Regards
Luca

> >=20
> >>
> >> Regards,
> >> Vedang Nagar
> >>>
> >>>>
> >>>> [1]
> >>>> https://lore.kernel.org/linux-media/20231201-sc7280-venus-pas-v3-2-b=
c132dc5fc30@fairphone.com/
> >>>>
> >>>> Signed-off-by: Vedang Nagar <quic_vnagar@quicinc.com>
> >>>> ---
> >>>>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 --
> >>>>  1 file changed, 2 deletions(-)
> >>>
> >=20
> >=20
> >=20


