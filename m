Return-Path: <linux-kernel+bounces-447162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C309F2E31
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D919C1886BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7472036FD;
	Mon, 16 Dec 2024 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dpHF1bso"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5017A2036FA
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345225; cv=none; b=a2Fit9YYpeXBPFiAwwYrdIQLYNaNNbOotdKlRHaldadbHzaomm4eymTyTPT2+ichGRR35y3zS49ftkO4Oit1qYM9j0JwFgaPbQjXEjpQyX/34nZd61sPUSvp9wF5Qx4nrVStb9yODdcOft9IwedQJsejMniMmwwQ+rRnIA9bNvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345225; c=relaxed/simple;
	bh=PYwh9Ejzktqnk/4b3X6HTET4UjWYpwtQYwse3ElACjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADn9VgnXBnKS8rGheJlp5lqpkrAVc9d9qM2V+RO3QjNUPnThzHXiir0/BRJQXgxh0XJ0bhYLFkDB0Vrwh1Cw8IRc6MN8s7BaMXJrhOPRz8kfJ8+9WGDbOS+5PuLrEzdnMpgmpamOPFJ5fL/1JG0LccPyR5NXhidnzsmP3rErcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dpHF1bso; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53ffaaeeb76so4235881e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 02:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734345221; x=1734950021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81rR1eTM9HElymQ2hIkXvkfh84mtbQHR8oN+z/vprns=;
        b=dpHF1bsoXY5M3b7MlnEpOGGHghGom+pSsXU1kbrqQrbtRIs8cx1uhnSzks/KNBTRHJ
         DDh91QvjfyewUjLrjskEBJ1MnZb4EWytNTwFvF4ODS+gBeWYtv5f6ftxVKezxH8bfUxr
         YwSSlNMwi+ALqQRPr5fvgsaZqy/faIRKD0R7AXaJrYOii8bd2oIPpIsA57IDTmvJjAV6
         X2Edqs0XGJwYI9T137tVGg+7dXjgn0dccJ+iscBzpZHBVLieHIvhQ1uxRb7jEvLX4xQ9
         bXpsY8++GJ/vOCrO8STHTESfFnmuiZYksPnnwJz6E0lyh9iKp6Lh2y3MC2ArjmDHftQ2
         oZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734345221; x=1734950021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81rR1eTM9HElymQ2hIkXvkfh84mtbQHR8oN+z/vprns=;
        b=urGhEaTKmCzt76lQPEynwBpRPns8/OcpcVH2qO4PW05twyIyZYO4xgbW9u0/2eoB0U
         diOOpUNy8SbHiblBgVBBpON3oMqd0soVNHIR/QFA3I4B8v/lhMqaUxAfJNOo3/H3WbGz
         PD87c+F/knQO3B6YcX1gJif0TVrD1Auly+0hNqN8/bIjFjM+P0qw3Iyeh0XXUQV2qjo0
         xbtr6Lcvlym8ckQc0DOeyaiLZsN56OxvPeKkNFQD0SoXAC4+y0O1YnP43a3Tl+DhOFD2
         eTHO3E7Zza5oQ53h+vxy+02+2ppAJP7BiPPpt0ScqhcmTkZk3BId4MaBi+IGKA11kuwX
         5HnA==
X-Forwarded-Encrypted: i=1; AJvYcCUaoXsKQtHdr/sXkaQ3fZIt/gLdEvw6evjGVi9uk5u9Iv3bVU9o3ZsPqH7VJYAtQ5S9TbH94Ujx3I4cg/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFbevjVOPJGVAhQeMCj9tkmu588HP8Mwb64plMVuBW3dEY0Jt
	12jDMjdDQ7jqbN11/4f5xIWLagXLuIMBCPvB2vKFY0lDf0KMxwW0x1XxPw2z78I+BhdVJxJnQmW
	r+V7xi3bRLAEcvPxcU2KRq506UKpDnhCLMqgSqA==
X-Gm-Gg: ASbGncs65SY2NlCeUTbN+XNT94mgEqfdl+daRfHykgYx/Ovzw3Ocv8nbFSaisROq/an
	IUCn0yNViNQo9+BakSjaZlZaBYl8FbKMPOknA
X-Google-Smtp-Source: AGHT+IEUf3iLQlaHwj+huKVEu7Rf6ZfMRHEmd0RkbAiajFtXRNVDdgnZzJS2Enw8KLsa6+/B9ivQKuoEjmBWCEUg1Qo=
X-Received: by 2002:a05:6512:230b:b0:540:3561:969d with SMTP id
 2adb3069b0e04-54099b7188fmr3706580e87.49.1734345221514; Mon, 16 Dec 2024
 02:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
In-Reply-To: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Dec 2024 11:33:30 +0100
Message-ID: <CACRpkdZ-ZEiGMUPObHU=kw=OUADrRGtxgMc-QC3EaBevp-Shng@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] Add MSM8917/PM8937/Redmi 5A
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	Dang Huynh <danct12@riseup.net>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 12:15=E2=80=AFPM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> This patch series add support for MSM8917 soc with PM8937 and
> Xiaomi Redmi 5A (riva).
>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>
(...)
>       dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl
(...)
>       pinctrl: qcom: Add MSM8917 tlmm pinctrl driver

Is it possible for me to apply these two patches in isolation?

I want to make sure the patches get moving.

Yours,
Linus Walleij

