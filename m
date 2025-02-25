Return-Path: <linux-kernel+bounces-531747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C137EA44465
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21853175495
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EFE26BDAF;
	Tue, 25 Feb 2025 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLNIzzc4"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657126BD8A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497338; cv=none; b=DGQZUngfX+rW+o0tIjcB2CBiHgHG9Sfklk4Se4EYVSEQjus5ByFNdsc6b/mDUfp9UJyWHUjcKsVEXKaN2E0sd5Jvz4A/M89nrWHmexzO0xenJktJRiMF2f9shnJOnWqzhbsF5eLTTViIQ7wEcbKT/PLJ+UjsWvLVfUkMkcO7oE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497338; c=relaxed/simple;
	bh=ymU4Q4V4l8CtxCLaS6y7/QU30Qeo8lyZjvxMHRi+AeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANSZ/eWYVN0kftaTvNIhHcOshGYps7xuX+WkBPIrgkh9dCThukGPAAjT9EaJ2790PFQ22UTestU/tPhgQtmm/HR+wUCj/J4JTKDtQ4DAbrROiTx+td/UtmkIeK7I6PnF3jgbA2H4dspFiKElbOEswMxo7JPwo/XSR86eTtowVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XLNIzzc4; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30738a717ffso44854901fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740497335; x=1741102135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymU4Q4V4l8CtxCLaS6y7/QU30Qeo8lyZjvxMHRi+AeI=;
        b=XLNIzzc4dZATR8dK4h7o4yGSIZATI09cLfguFtMel5IWGkv/ufP4phDMSgU0u4QK1j
         /TDd5GtPCsJIa4Lrk7+7J+iKkUq0Nt+5AFK5gWuV+QKBWz44hpTq3sHwftr0rIC1d89X
         TBHvtyfI03LH1USTw3x9ile5uy2Rxd+YxBXa5sBkdLVBpbD9adzzAgNcv43YrjwTg6eG
         2kbXbVSSkJES/la0yga5Vp13GnBATKdIeDACm9i1+HfgsN/dJcVc/GVHZGuMmiJejG5O
         1O9CEU5f5BGcp/SEjQThbI93iN2WEAhYdicE4TURUypTMaInqm2oxo6o+d35ChXH+OST
         Z00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497335; x=1741102135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymU4Q4V4l8CtxCLaS6y7/QU30Qeo8lyZjvxMHRi+AeI=;
        b=OySuS+vDw9ENi72PchcvszBnpRwERRbSkIlJ5fidHKsmiEcG9IQt0BwLVFzMBUPf5c
         nts8lzI9O63Hh79/kLl8rWv66OG/3f0ZQw0Q2vH65xvlncEiFLGVlpZCqtePHDV/ITu6
         IwkWbmFJPEH9XWr3nQsk6sam6ig6M2FAdecIutFta34qfrBQKAhro4tk6lNtVWn/c4xD
         /qyK16e3eMNeXo7+h52mQBov3H6RVswTiQVVoB9eoqLLCtNDkH8EelqBsGNVC04bxp95
         o9Ay5uvHlcoNF5HAztdJ22xYwm5ffwl9I2/3MMq02EpV7PMPWds75wwIOW7xr2eYySLT
         qnPA==
X-Forwarded-Encrypted: i=1; AJvYcCXnUlQ4zu5h47Fbl+yuipcPPpzsYHotUrN4VAo56qJRr8UQI8JEqGBpdBHbV/Z3oTCjqjyleAbF9feo7GI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/qWqRT8xP2VkWSDrcbYYcK9q3yh3xCgT7yKKeNEZdAXWpl44y
	uxV0Gojuv/JYRksZTTSGI5+W1deQzZrj3T22KvqHZdr7RYP6fha2w6PvVm0X2K3hq0tN/8EWgCF
	ndM4l2bfn/JEQiWYnsvoQ8+vOSRvhZLAE7+AKmw==
X-Gm-Gg: ASbGncvUhGkqcww/Si2WLlKSqC7Fovs5XiTUw5AnYD2tRAy08WKzML/pUAc2ESF2cBb
	HcxxslxLqTlDdzsJOHxiYhqg2kHH0Iab+LUeSWtN5kX+/QbJp//gFfhkRReUXhxwXwkM65FrLN5
	OPJlX8FmQ=
X-Google-Smtp-Source: AGHT+IGvQGYbThJryHx4S9X0G/hQwdXky4NGM+IG412kF+Oob4gqd5qSVYxirN603Nc55xdy612DJLqmzEaxlENgSHw=
X-Received: by 2002:a05:6512:3e0d:b0:545:25c6:d6f5 with SMTP id
 2adb3069b0e04-54838f5c9ebmr6533494e87.53.1740497335376; Tue, 25 Feb 2025
 07:28:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220180427.3382482-1-vincenzo.frascino@arm.com> <20250220180427.3382482-7-vincenzo.frascino@arm.com>
In-Reply-To: <20250220180427.3382482-7-vincenzo.frascino@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 16:28:44 +0100
X-Gm-Features: AWEUYZmYCPdOL-kTocm-qdrcGGN2FaHnyCLLC1DBvOuBsbs6HM0zSb7Of9lav7c
Message-ID: <CACRpkdZorvRd26+BPXpz0U26b0AUD4Z0PQ4RyoPi0OPyR1KWGQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] perf: arm_pmuv3: Add support for ARM Rainier PMU
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jessica Clarke <jrtc27@jrtc27.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:04=E2=80=AFPM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> Add support for the ARM Rainier CPU core PMU.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

