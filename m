Return-Path: <linux-kernel+bounces-334375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2644197D66E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24911F25F08
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962F017BB01;
	Fri, 20 Sep 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dx6zclKJ"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E2F14EC64
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839913; cv=none; b=YNAGR1/52jIl75PiXdDfr7jFvDiyjTPYbcDE/7F8Y1JkbvtA8YXPX+sp1Ani8NmuYI21XVHT6fpXCaU1wlgYgnpDN8oL5vLFBZluS+okHmFg6VXpq573//9ytx3gYTOg6Bi24KvbaopGwvTcYSmc5GYKW5TEM0xoTFln1P11Ykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839913; c=relaxed/simple;
	bh=gDN/sgBuhIM3JVUFXVcLakscRVbrc1kau7V11AQd7YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+RdkWoAgJ0X5SOISX4YJuFyOl/Tku2ANnqXyiogpi1Wp3kmEVfYYXp3GwZ+WQFP7y66pDixbohXMD9KkHyPtwBsr2/ZTnvbraaqj7HYegKCHO26PX6S8p2aLkHU3EgUY4NB+RGNncnbJdPDmM2IxPJ4WLECnWvWjAMdPXHBZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Dx6zclKJ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e1ce8a675f7so1830911276.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726839907; x=1727444707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdvJ+kr1RTk5qIQIrIC2yclK5Px3xgR1ScHS8srLiXw=;
        b=Dx6zclKJ3rT3xDoek6YfZ7qdF4/D3AD7RrFuwZRU3e+5IZH1BGasPwFVlJILH3uRKV
         cPZDAwjDKxaK2jkrDJOr7Bdy/pi09qjt3dZz954N6VtvvMRTgLk7EBxyOuXNIKMXroVl
         NPwUCRdWUw7y4aJ1pIhtHQ5pCK07i4cjDAAiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726839907; x=1727444707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdvJ+kr1RTk5qIQIrIC2yclK5Px3xgR1ScHS8srLiXw=;
        b=uL3ez3cfzJg6F4BBe/fkBUVfHmKInFXwr7WCtCz+BNd8xAKTRTvUQRzmvLbQ/Q2n6i
         gTfrTz5Mz71BydII0xi5MeDOdUT6o8vQQmLxneuOnBSebji2H+d+eRE/bx21mpKM39mw
         sppo4CFrCWixOao2OPwFnhoPqU7QO7v0CZ7cZgTV2vz5pLMhFcQBM7Uerkt590Wdf4Su
         nLxYfEbDHpnaXTvYYnQtjgQKoiLSFNeWvGQS9WlBMBZT6+ZDAALt8A975j0RyTyrza6B
         zJkUieCeQY/tbtF86Z7Ry3KpiR5mI63SePO+D3JxDC5phMGDXf6Ag03n9TkkvvFM8Fri
         Eiyg==
X-Forwarded-Encrypted: i=1; AJvYcCXEKYe7WQsTX40H5+gZPKnRlRO6L5a2fGEolHtWDdQ2xDdgZV7zdLqlCAH1zRvnBkD+NTTanYAU2keAh3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKJD3ctiY7pymHBpk39SjwCl8D6ucisSGOZCkYRb4BGFV2ioPy
	pKGo3iq6LGBPKYzACAS5VYfmUmbVnZKdQb8O864haPPqV/JF5CJagByPzVmZlPD4zEf/t52sDlp
	xJQ==
X-Google-Smtp-Source: AGHT+IFoXTzSyLBvx5C3sQMTKBb+nglHmeeo/auiHW3xoqR71PVwo2YoFR25oXqjh3EzyBgg2E/stQ==
X-Received: by 2002:a05:6902:1791:b0:e1a:829e:c59c with SMTP id 3f1490d57ef6-e2252f3ee2dmr1697392276.24.1726839907222;
        Fri, 20 Sep 2024 06:45:07 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2021d1f70bsm930449276.44.2024.09.20.06.45.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 06:45:06 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1da3677ca7so1895629276.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 06:45:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvVzk8O8xwRczIoF36PPpXPEK26K35az0JrQ74xfsyEFnuY3ydHkh+ij7uvFGoImV+pxq86/UXDQp6jdo=@vger.kernel.org
X-Received: by 2002:a05:6902:2b05:b0:e20:2245:6fa2 with SMTP id
 3f1490d57ef6-e2252f54996mr1772372276.29.1726839904812; Fri, 20 Sep 2024
 06:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919-topic-apps_smmu_coherent-v1-0-5b3a8662403d@quicinc.com> <20240919-topic-apps_smmu_coherent-v1-2-5b3a8662403d@quicinc.com>
In-Reply-To: <20240919-topic-apps_smmu_coherent-v1-2-5b3a8662403d@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 20 Sep 2024 06:44:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xrbe1NO+trk1SJ30gHm5jLFjd0bAeG3H46gD+vNFZa1w@mail.gmail.com>
Message-ID: <CAD=FV=Xrbe1NO+trk1SJ30gHm5jLFjd0bAeG3H46gD+vNFZa1w@mail.gmail.com>
Subject: Re: [PATCH RFC 02/11] arm64: dts: qcom: sc7180: Affirm IDR0.CCTW on apps_smmu
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <quic_kdybcio@quicinc.com>, Rob Clark <robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 18, 2024 at 3:58=E2=80=AFPM 'Konrad Dybcio' via
cros-qcom-dts-watchers <cros-qcom-dts-watchers@chromium.org> wrote:
>
> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
>
> On RPMh-based SoCs, the APPS SMMU advertizes support for cache-coherent

FWIW, the "RPMh-based" confused me a bit. This isn't really related to
RPMh, right? I think you're just using "RPMh-based" to establish a
point in time and that Qualcomm added RPMh in the same generation of
SoCs that they added cache-coherent pagetable walk?


> pagetable walk via the IDR0 register. This however is not respected by
> the arm-smmu driver unless dma-coherent is set.
>
> Mark the node as dma-coherent to ensure this (and other) implementations
> take this coherency into account.
>
> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
>  1 file changed, 1 insertion(+)

I remotely booted this on sc7180-trogdor-lazor. Since I'm working
remotely at the moment I can't check the screen, but I can at least
confirm that nothing seemed to go boom. I can also confirm that
without your patch I see:

[    1.580607] arm-smmu 15000000.iommu:         non-coherent table walk
[    1.580612] arm-smmu 15000000.iommu:         (IDR0.CTTW overridden
by FW configuration)

...and after your patch I see:

[    1.569350] arm-smmu 15000000.iommu:         coherent table walk

Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>

I'm curious: can this also be turned on for the Adreno SMMU also?
dmesg still has this after your patch (which makes sense since your
patch didn't touch the Adreno SMMU):

[    2.423521] arm-smmu 5040000.iommu:  non-coherent table walk
[    2.423526] arm-smmu 5040000.iommu:  (IDR0.CTTW overridden by FW
configuration)

-Doug

