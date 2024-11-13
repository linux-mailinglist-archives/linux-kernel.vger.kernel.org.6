Return-Path: <linux-kernel+bounces-407212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4964E9C6A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C24B23771
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F0E189917;
	Wed, 13 Nov 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="5mQfxZnW"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280D112C484
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731484991; cv=none; b=FGpsIQ5kCW+Lo1m0p/YwQA9DxqnM6d6LQECM3v/sBGoGlj5M9KrqSq3OwdDbbgtNebes7cQb0wGVGGkWtW1RrcywLFPPfx+H1ih7I6nWUmnlmd4iWtzbYEzt0hlxFmNMVRaH5B6soEHk3BtUPloA6x7O21zhh/RzP/jhz0VyuF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731484991; c=relaxed/simple;
	bh=JtfJ/M8Fde3sq0t/X0kZEogyBD+h5DUxk1EyzuQfIiQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=orv4g5H9DgiG03CHXovyAsmSx0kF4auFV0m1WUZC009wynD9x8yAF0dE/Wlaulhgo6DT930pmsTOFCHzPedppuzQnJPhbnx2ylfjhlHIJntSFfSUYYtLFp/V24khOzUt002SVYltQOVRxCaYWw30Oz1l6clZLirtYmWK2GmsrvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=5mQfxZnW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-382026ba43eso1862708f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1731484988; x=1732089788; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKyYktRQuJ/QeBC58+VEnoyS7t9UdeFDO97IPToRn1c=;
        b=5mQfxZnWHR/zupZge//HJjN9lGSuo9Zau6+Dm1sAiKsUlpnk5fyvD79V1fUJ3mk85M
         qFv02UpglU0aAjHWLp8tJQE54wpqxT+ny3q8TMl7MV5VUDQCIMs4AsnqBtieuADmlONN
         7IP7ihPjPxvpJshQwck/36tvUiYp8oyMkXqdTm9FaHendhoDu2yLXxmeYKPwrbEK/rHX
         E4UxKOyVzQZKO9jbxzfXsjR9CsnZ0O8GZ5ADXKJOqtEV9PGnCpwQuittgOdgytQ7jIgt
         QAjwFkMGeRv6meR1ymtRBagZeVYfT8Jtd9RlJeaVVL+/6Qwvr2dMw1AQputrV2hrViv/
         L4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731484988; x=1732089788;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jKyYktRQuJ/QeBC58+VEnoyS7t9UdeFDO97IPToRn1c=;
        b=d06VqBut8PpDd790qW7gfcG6UnQO2nExgpbV+s0BGh078FqeOhggL0zjlXI+QzvpDI
         zAlTAPdnR12koaitA0gaLrlMnac2jRpAiIjAoY/VLsjV9NixJy7RhGV4TONm575cujsq
         evEPDkj2fS0kBuTjrx1AP0jKkp8tm3f9EE1FhYOq/X8c+4wSpi/wV0AtmG8l5psYyrXw
         2NusmORrFZV4SrCQJOgzJtgT2/Xe4zhcFmHKZfo/Nsyu0qbj3y2S0VZ/AVpmVy53+mu4
         8ACm/soamr/DJUmOdDy2f5mJdT9mBaPlKCb9SQ6/+/ndIR4J463TuzNayvdacqNrkdy5
         vDpw==
X-Forwarded-Encrypted: i=1; AJvYcCX6KVHj72Pw88+9Odu5DVdqTiG2M5LM3wEzVoLpJXkQTaLv7U/9VfvfbygozZK9ETGmLVqxAuZLUC+nuLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGuTJEVaYETHKq92vZnYv6VQybYUkeK+Ljehc0Z6JiEyHxxaPw
	DEk3rpzoaoEFyFLYGbesP1EbAZ4tTn0kwttMZ1Il3HAub0RseoMR9BqPKavRoU4=
X-Google-Smtp-Source: AGHT+IFOEcn5QjxpPu724zso7ULSYt3uZMMHchhIsaHCQRGB1Ui88bJ4YmB3X+sf4mSWdm4RywdtVA==
X-Received: by 2002:a5d:6daa:0:b0:37d:377d:c7b0 with SMTP id ffacd0b85a97d-38208110ab8mr4231577f8f.18.1731484988382;
        Wed, 13 Nov 2024 00:03:08 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda03e8asm17571508f8f.90.2024.11.13.00.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 00:03:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Nov 2024 09:03:07 +0100
Message-Id: <D5KW7A8BZG6K.2L7FEV6SWRZ2D@fairphone.com>
To: "Vedang Nagar" <quic_vnagar@quicinc.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@linaro.org>
Cc: <cros-qcom-dts-watchers@chromium.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konrad.dybcio@linaro.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vikash
 Garodia (QUIC)" <quic_vgarodia@quicinc.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: enable venus node
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241004-venus_sc7280-v1-1-4d7d8fd7e95b@quicinc.com>
 <kezh3lmysij56g2tjwwuas5r26ro5i777yxxitsdcjeg7zp67v@oknrdbkzison>
 <78e6ff6b-efe1-496c-a1fb-c9a0a4aba2d2@quicinc.com>
 <CAA8EJpqqZL7xybcbJMsbTQB+ht5-A+ocNs+Sq30j=v1zM3JL9g@mail.gmail.com>
 <fbba794a-ba04-4790-b5e9-b4df3cba35b2@quicinc.com>
 <D5KAUZHYJHFS.1NXF5SVWYL03G@fairphone.com>
 <39206687-6fb3-434f-b2ba-a028cf6f8ed3@quicinc.com>
In-Reply-To: <39206687-6fb3-434f-b2ba-a028cf6f8ed3@quicinc.com>

Hi Vedang,

On Wed Nov 13, 2024 at 8:01 AM CET, Vedang Nagar wrote:
> Hi Luca,
> On 11/12/2024 8:49 PM, Luca Weiss wrote:
> > Hi Vedang,
> >=20
> > On Tue Nov 12, 2024 at 3:39 PM CET, Vedang Nagar wrote:
> >>
> >>
> >> On 11/12/2024 6:43 PM, Dmitry Baryshkov wrote:
> >>> On Tue, 12 Nov 2024 at 08:17, Vedang Nagar <quic_vnagar@quicinc.com> =
wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 10/7/2024 1:20 AM, Dmitry Baryshkov wrote:
> >>>>> On Fri, Oct 04, 2024 at 04:22:31PM GMT, Vedang Nagar wrote:
> >>>>>> Enable the venus node on Qualcomm sc7280. It was made disabled
> >>>>>> earlier to avoid bootup crash, which is fixed now with [1].
> >>>>>
> >>>>> NAK, there might be other reasons to keep venus disabled, like the =
lack
> >>>>> of the vendor-signed firmware for the particular device.
> >>>> Can you pls elaborate more on this? Any device with sc7280 SOC can u=
se
> >>>> venus.mbn which is already present in linux-firmware git.
> >>>
> >>> Can it though if the device is fused to use vendor keys and to check
> >>> the trust chain?
> >> Yes, infact the existing ones are signed and works with trustzone auth=
entication.
> >=20
> > No, the venus firmware from linux-firmware does not work on a device
> > with secure boot on, like the (QCM6490) Fairphone 5 smartphone.
> Are you saying even after applying this [1] you are seeing the same ?
>
> [1]
> https://patchwork.kernel.org/project/linux-media/patch/20231201-sc7280-ve=
nus-pas-v3-2-bc132dc5fc30@fairphone.com/

That patch has been in mainline since v6.9 and my tree is newer, so yes.

See e.g. Qualcomm doc KBA-161204232438 for some details.

Regards
Luca

> >=20
> > $ rm /lib/firmware/qcom/qcm6490/fairphone5/venus.mbn
> > $ cp /lib/firmware/qcom/vpu-2.0/venus.mbn.zst /lib/firmware/qcom/qcm649=
0/fairphone5/venus.mbn.zst
> >=20
> > leads to
> >=20
> > [   10.848191] qcom-venus aa00000.video-codec: Adding to iommu group 13
> > [   10.863062] qcom-venus aa00000.video-codec: non legacy binding
> > [   10.909555] qcom-venus aa00000.video-codec: error -22 initializing f=
irmware qcom/qcm6490/fairphone5/venus.mbn
> > [   10.910099] qcom-venus aa00000.video-codec: fail to load video firmw=
are
> > [   10.910849] qcom-venus aa00000.video-codec: probe with driver qcom-v=
enus failed with error -22
> >=20
> > It's the same with e.g. adsp firmware, modem firmware, etc.
> >=20
> > With secure boot off, yes, the hardware will load any firmware
> > regardless of the signature.
> >=20
> > Regards
> > Luca
> >=20
> >>>
> >>>>
> >>>> Regards,
> >>>> Vedang Nagar
> >>>>>
> >>>>>>
> >>>>>> [1]
> >>>>>> https://lore.kernel.org/linux-media/20231201-sc7280-venus-pas-v3-2=
-bc132dc5fc30@fairphone.com/
> >>>>>>
> >>>>>> Signed-off-by: Vedang Nagar <quic_vnagar@quicinc.com>
> >>>>>> ---
> >>>>>>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 --
> >>>>>>  1 file changed, 2 deletions(-)
> >>>>>
> >>>
> >>>
> >>>
> >=20


