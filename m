Return-Path: <linux-kernel+bounces-348934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2617F98EE17
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E8F283097
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F4A1547CE;
	Thu,  3 Oct 2024 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WwYXdwJa"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C4153836
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954776; cv=none; b=iupROVTz98GDRVKGkwwmSk2hiDf7d3YXfJ0l2zFCMCoe8v6bfdVD1DDfOdW+fSj/v2UE3S7fiZIVFrs3ObkTN6kTjUjtS3IMznN5zVeBEJFEGaHKCAXheW4oKt06qEgtffqeTTbYmx1l1NMIqUeEiHH/tuf4D41+uQ/Oa+9UDc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954776; c=relaxed/simple;
	bh=NbODAL29Apvfd6D+JLLYZ5MaHuTJ5svZVOh57sb0hqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTcHEO5a77saFK0TOARgEoKXBMD3PIVvmn0Y1osFfij30Lvy65etKXXdV0oaGdBNI2qw8WU1AH6pMY2/XUNMxfzWpYokKjUsuK/V1OdLIv0uk9nN7Tw3YdNbUz6iNUN6Pmu/kRfu/bQvs5TZzscyBIn/1qlmA3h48PxTfklQNHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WwYXdwJa; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53994aadb66so791455e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 04:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727954772; x=1728559572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlLLunCl6g3gRP7KC52BE84aGo81PObxe/Q5X6ID2V0=;
        b=WwYXdwJaIlkmeWiuoKrm2W+/77BSIhaCD8dXab51z1H+dNngu816ymTjEfiog+Ej7c
         gehfcCH962joeC1Yl5jGLPCjdshs4tBqS9tt2VS7tVkTfn3vLscSS1d/7tb8ScPm8TeP
         TCIykmJfjrtDPH/HZv1cGpPoL/9kwvD20ABSVaFTE1A6azwG1UQruPJJ/TrCx5MPn81D
         CNV+TasdHwiiX1/ozE3iRA1HinCYDhxM3tnO1145ELge0+KEZ7l6tQVwTYS19v/GwW6S
         KtEKI4ycnX5kuRmfMluRo0patCV5ObgPTptyFHjzMO6mvQJIJerbSpinmFGn1GYGeB3M
         OjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727954772; x=1728559572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlLLunCl6g3gRP7KC52BE84aGo81PObxe/Q5X6ID2V0=;
        b=fDTAc83zZ8NMx+VLBiICcdy1szOGoAHYCZ3xJZneFMm4nbeiMagBU9eW24uqxqiQqd
         RiTAm7pKjRuF0BTMoU+O84lM4KjeE7ILdfZk68KiLB34zKFRex6oxisHGtPUWBSpR485
         9O8UTzCTdpBJMReytp6ifv3dbZ4kajO+3VmiykzOWkPKoiwDWDqUdC/+MWVts1kKa8fG
         x2zbhP4P3c1wyBmE1tjmurFOy9y23BGRbw6rSy29VDn/OZE7qtrvRo8X7+14/KND6UwY
         ej4oeIDbFWZxmVciYiOeR0exuBeSSWfE5mLMskJqp1LmD13+PfXN67tJkVSmDhGUsfbE
         n3Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVISYOmIMIhxKL/kHX2Y1NdY6NOMKOMjmEnvi8YlCITpS99sL0/VawkETpzkdIZGjPHHk9D4JGTUwsq1eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzEi/srOQXSW/7Bety7B10BUtzIVuiYDg2uPo1co6OBOindxYU
	mdENcdIMuH+TlZxHEpVkpiWIrLXVR9kBA+Q7IQnHExJ8tE2RFtj1dG3MGI0DxGYE5dMr5zqgdZD
	pSyzm9/3ZxmZh4ireHurHQ0VYMLKV/YuylumJ5A==
X-Google-Smtp-Source: AGHT+IH/EAovmZOtegJhqaVGARHaDU2Egf6EGNvaVpuGE/EmHaXFwEn8LjOg/kYa13GbfjvlQCAqo0kemX+JkhA3oYk=
X-Received: by 2002:a05:6512:2216:b0:539:9587:dec7 with SMTP id
 2adb3069b0e04-539a06827ebmr3801825e87.32.1727954771954; Thu, 03 Oct 2024
 04:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930103041.49229-1-brgl@bgdev.pl> <20240930103041.49229-2-brgl@bgdev.pl>
 <Zv50l7U_Rq91I1Dw@hovoldconsulting.com>
In-Reply-To: <Zv50l7U_Rq91I1Dw@hovoldconsulting.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 3 Oct 2024 13:26:00 +0200
Message-ID: <CAMRc=Mf=5H46Rn_zfQjaG_mvyJ4cx2VKOVZxtGuqnA4whSSeGA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: sc8280xp-crd: model the PMU of
 the on-board wcn6855
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 12:40=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> > +
> > +             qcom,ath11k-calibration-variant =3D "QC_8280XP_CRD";
>
> Not "SC8280XP"?
>

This was agreed with Kalle under the previous version.

Bart

