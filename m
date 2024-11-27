Return-Path: <linux-kernel+bounces-423478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B532F9DA81D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A15D281FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219E318DF86;
	Wed, 27 Nov 2024 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VFjp4YnR"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E21FCCE9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732712087; cv=none; b=H00tYa/CmtFSgStg0psMs3a5vsUPPpcNT2RnhKL4EHDIi7VbkTh9Ir+rBsClbuulOfJfVdpVtYQu7l4dfh8CEVmtsQl/bZTLF/JGyJTOPKIqd2mIzNDEyLenbk/R/4w6DfAZIyQecjC12KLx7suRxGkJjZH8Fm8da8VHL/sKkL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732712087; c=relaxed/simple;
	bh=Lh+K93JZ+oSO4iAA1pLiUmBkVGI7gz64mN0R2XehEKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcpX9sbFnXPVn5yCOfN5fsNFcn17hGoD3G0eVfz2TmXNPw/Z/ZSdPF10/WhT5wgfdgYTI0lo9K0Pzep9uwu+k6wO8TuS2aKDlXxz+g5mBop2zDI6VQvUN59ilfKciZFim91Lq5a1BRIR9BMkQxowx7iIJVSCvI5V4OTIrKYL6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VFjp4YnR; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53da353eb2eso10431163e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1732712084; x=1733316884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMlguYsXBaHTG8IIPiymhg5zN1IoRUyw9vVeQdmNnoE=;
        b=VFjp4YnR2BMoy20IxOEMJ6AK3Ujrzz3qmqIca2qOFLtkK55WJsWT28V1CueF2zG9oA
         obvV4ErO6bOWG4IoF9wTGVCsRzKyKxGlc1aUqRrTHzjWb0AFe1QVeXte1QXSQNi/Fy9h
         ZDqJZrq9ZY5pdpybQD0+pDTk/X/IyN4E+fD7GMadGmvERoPh9zQijAE4j1em4simzM0z
         RNVJzhnGtNKpW4usO8p2lPDZdkI7/cOnkHbnKpAPZtECWpT8mKCGuIGuEhHIW2WP4UFP
         oWvuf8iJR9xR47rt3XMM0mFg/L2TVpUfUHKFj9SPPKxO4RMU4k68P0JHutPQYPkSRbV+
         wJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732712084; x=1733316884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMlguYsXBaHTG8IIPiymhg5zN1IoRUyw9vVeQdmNnoE=;
        b=JFvEveqHYXTgXzJ9tTuaQNmHn+ygJd3ljS2a0fwdD/Rs6s5iq6FwkJEPgXNMrs0/iq
         Ng7bYRkPfufbhHKMYLN8FM5pdaYRLPxqZ/dfJizLoMPLgnHfoM+/qnb32HH+XuHl4lnS
         aISaiKEAl/g+PKblqT+OtDU5lMmgSsckDfwgOujFfCzTekG+elW2lc9mA/gmPeMZu7bN
         8/9ze/yqJD6yqUFSA9gt/AP3ieg++xciBgCLpmgWevQwqMsCWUp+yf7ORH5d9VBHOUKI
         TYHPavfvnGuBPYHuiWOnAU6Ouq54q3RKL8/SsNK1Y9gj6whCvxHP3mm/Bu3S/iNik4yM
         RqnA==
X-Forwarded-Encrypted: i=1; AJvYcCWYmiVPrfuHPsrpL3kg1yQynsw7pVOy4x2iY9y3Vq7+HHvpW+ozrjkv6TKadDvqWjKuSgnhcwQsG3t5Eoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNgjsvivrzPk5KOs8eLLWbTEBmG/dPP/TKPOzgsc6p81DfJge8
	3X0V7S3HnwLMLzNy1OaC8fsJ4OF8qJU/RCGtao4hh6CfK7QxC5N7V4Y7Hh90ys3NpD5vG5ioW+j
	Zl8acsujES1KHz5bd9C1dxBTzSl/XSX6DK3DRTQ==
X-Gm-Gg: ASbGnctWjk9dclnI85KBiPksHtczMPkmBwHwWIwBWSFJnNLvhzXiPorZddJJcBv18kR
	8I89KHE51q5q1xlyu1obxIF0lcSIFDFfMFCRVNoS8OkFaVS+fAM94rrjXuPVdRjE=
X-Google-Smtp-Source: AGHT+IHx709SaQ1FKdkFFszRfWrjL9xRjWY5udSKu4C3NKATAFjJLfJrvyExi7rrNp0NGOcrVq8wkyZ207HqatYcYLA=
X-Received: by 2002:a05:6512:b26:b0:53d:efc7:70c6 with SMTP id
 2adb3069b0e04-53df00d9d1fmr2573513e87.30.1732712083923; Wed, 27 Nov 2024
 04:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127115107.11549-1-quic_janathot@quicinc.com>
In-Reply-To: <20241127115107.11549-1-quic_janathot@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Nov 2024 13:54:32 +0100
Message-ID: <CAMRc=McvKvHy8sxhHE2-5LO7-MAjtPMLks6x9bufTjmpG4cT6Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Enable Bluetooth on qcs6490-rb3gen2 board
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 12:51=E2=80=AFPM Janaki Ramaiah Thota
<quic_janathot@quicinc.com> wrote:
>
> - Patch 1/2 enable WCN6750 Bluetooth node for qcs6490-rb3gen2 board
>   along with onchip PMU.
> - Patch 2/2 add qcom,wcn6750-pmu bindings.
>
> Janaki Ramaiah Thota (2):
>   arm64: dts: qcom: qcs6490-rb3gen2: enable Bluetooth
>   regulator: dt-bindings: qcom,qca6390-pmu: document WCN6750
>
>  .../bindings/regulator/qcom,qca6390-pmu.yaml  |  27 +++
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  | 174 +++++++++++++++++-
>  drivers/bluetooth/hci_qca.c                   |   2 +-
>  drivers/power/sequencing/pwrseq-qcom-wcn.c    |  22 +++
>  4 files changed, 223 insertions(+), 2 deletions(-)
>
> --

Is there no associated change to the pwrseq-qcom-wcn driver?

Bart

