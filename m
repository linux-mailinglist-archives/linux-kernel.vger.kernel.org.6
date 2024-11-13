Return-Path: <linux-kernel+bounces-407692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDEA9C712B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20241F29926
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472631EBFF1;
	Wed, 13 Nov 2024 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BrqjK3pt"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F51DEFF6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505149; cv=none; b=XPLSdVapk8kVuvjF9DppfAFsVOGgs3tt7tRVuXXXhSdpu9As6WLfJIUTpn4HUa3E01nKUv5kPhwbcTvLCLzTRthcFKXZc//t+gAtyU8beST4juaCXbw8FCotIZLg/1sraXe6i8OHrhhDcQyjrJV4QYJioQD55IOaRr/tGNzFhgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505149; c=relaxed/simple;
	bh=w4ZbBnFXX56UZ+SeqmlOGMfU+jiHqM20ymrRVbvyxug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8ZBaKN7zK9BeYBb6SxiwtNbEPCYRQwytcFycgxBi9A9Ls6wo6EU8vZp3lnxDfAsVy6lm3FeVnZhvwphnDWbSY5E7ued1rx/ITyJmJN1SCBjkZ6iWlH4a+cPT1ODimnzLk8DOgMTYgfHmLjWtjRXaFFJ0tnxulfWopppSP1XJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BrqjK3pt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e4b7409fso760230e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731505146; x=1732109946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4ZbBnFXX56UZ+SeqmlOGMfU+jiHqM20ymrRVbvyxug=;
        b=BrqjK3ptxg3X8WOuta4XBOQLh2auTF9Vs757QPD6Il78Ur2NeShKNk99gkko9H6wFJ
         Oq2OhI+SlC4q8b/ZzoNE03xtCM1wo/+0BnjSfg6BDh0ZJDwlSuDW9oeohONL3Pkkh2/V
         eFUCfGAI1Qq+P6nRMhmwwR+CvkJXaHGv66xt9yGo2nPvkle6weDKJT1GOGrFKU8H+c+Z
         eV7bxgG1xM5yUhuozt3oiNeiRZtFn2qsjdNXtW3t+N69NQ8r76Gfik9QfqreBD0RhJMe
         HVY6iXfv/cCGTceJ+b1aRtrsGhocGnkvEdfItxdKEVkZQx96vo1zzGrlrKXKm/9F2FIR
         RpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731505146; x=1732109946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4ZbBnFXX56UZ+SeqmlOGMfU+jiHqM20ymrRVbvyxug=;
        b=nwiJHEH0606TeKEGi8x/y3wDwNwJkPiSJCbCG+2smvp5r2P70jH8Qwng1Hjubt3kqW
         DdqSNoC+xtS5PZ+BxD9iMCUNSU3sfZRIkL9x1EGPi5qGpia6TIdbTaK5zjSner0Ghc16
         JcENjUD0jU1ZAVLAw+b4MbY05e6ijxyKlPE1q2/IcA5veMxGD6tbof8yN1j+Py2eBqqR
         m4AjNb3CRFj03s7JmOCKo2dyYwbaYkrqOav/Dt7Y0Lk8uOK2JkOZCVQSA3+/VOgm5Hhg
         sdVeKx4XakZBGWoNivWMS7mcPtVefN8CFmJ8HI8u8tJdXcwGS7bPBSTAqKjePnE/DZ3u
         rMOA==
X-Forwarded-Encrypted: i=1; AJvYcCUARwn6MQjE9OQ/fAjUdiSnBJuhZbQVMayfk6fjX3fT++xVSTpflNacV/+U39Rz3i2jhX4tQtlaXp4eisk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8WYu3qCaOjBWW3DJgXWZb+n7u/OfCo/ofODu9loVUfwKgTCi7
	Hyen0SexmI6I2P8tPQ4ad5DllXzAhiuflImQ2Duvi+7mx4jomUa//EKtBJGv4CWCFlfLT2+BBQu
	gQvXJmeXx9ft8qn467wQE8lGJ+OHMs1PzyG1s/w==
X-Google-Smtp-Source: AGHT+IGiDGTr90XJTWFjW26zxq3XwznkWj05rlt1ePKBKG7HZ3q5XgpkaaMpoieowD3i/4IVTS83I9wYVjrq+DBeh0A=
X-Received: by 2002:a05:6512:3e0a:b0:539:93e8:7ed8 with SMTP id
 2adb3069b0e04-53d85ef6c71mr7160108e87.15.1731505146122; Wed, 13 Nov 2024
 05:39:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com> <20241112-qps615_pwr-v3-6-29a1e98aa2b0@quicinc.com>
In-Reply-To: <20241112-qps615_pwr-v3-6-29a1e98aa2b0@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 13 Nov 2024 14:38:55 +0100
Message-ID: <CAMRc=McOaiLEfum0L1iEk8HzjXVjvjCqRq=29b_Mphdwi_cZEg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] PCI: pwrctl: Add power control driver for qps615
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, quic_vbadigan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 4:02=E2=80=AFPM Krishna chaitanya chundru
<quic_krichai@quicinc.com> wrote:
>
> QPS615 is the PCIe switch which has one upstream and three downstream
> ports. To one of the downstream ports ethernet MAC is connected as endpoi=
nt
> device. Other two downstream ports are supposed to connect to external
> device. One Host can connect to QPS615 by upstream port. QPS615 switch
> needs to be configured after powering on and before PCIe link was up.
>
> The PCIe controller driver already enables link training at the host side
> even before qps615 driver probe happens, due to this when driver enables
> power to the switch it participates in the link training and PCIe link
> may come up before configuring the switch through i2c. To prevent the
> host from participating in link training, disable link training on the
> host side to ensure the link does not come up before the switch is
> configured via I2C.
>
> Based up on dt property and type of the port, qps615 is configured
> through i2c.
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---

Krishna,

This looks really good thanks.

One nit: I'd rename qps615_pwrctl_power_on() to something else as most
of its code does configure the switch, not power it up. Maybe
qps615_pwrctl_bring_up()?

With that and the build issue fixed:

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I'll test it once it compiles.

Bart

