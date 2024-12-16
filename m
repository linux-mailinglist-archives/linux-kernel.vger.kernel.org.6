Return-Path: <linux-kernel+bounces-447021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2519F2C23
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1761883FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B031FFC6D;
	Mon, 16 Dec 2024 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tV8LoLne"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5921C3318
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338584; cv=none; b=gUHUWOiVKBbDUbnTjUySqXFkJdnGeZsvve3zwvtUnfrOsAPBKmNyVv0PfJpXe6fH3NsQXd1sL4EB0cDSVfkkwITtYA9wkjdJ33vbrHvrQN034RgUWycLBAXGVVmPA5259PhUh0OilbH6dz0BuXfiqUjydGu1AW0PMpdcwrGF8F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338584; c=relaxed/simple;
	bh=6AhQFzxXrbWEhDNEdghzKF89RHERU3ypIVR6AiCVvJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDN7O7DQ1RHJ3R+x/gYxENqCLI3Bska1tNKeRrNoWTGAREiI3/O/tfLk14f14Ez53Ql9JOJ8Eu5tNZbIvyAJ+xoyxuZEYwwFD7NT+meA9C/wbHVzhg35SuIBG9jNT2o02IXbRMiYcx9UgTOka6+tyDDIB77R14G5ocqkKyfMH3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tV8LoLne; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53df6322ea7so5357303e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1734338581; x=1734943381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ESVbK/QGYyy+mXv8GIEzCsLxto0hs5j5kMmDAMrMjQ=;
        b=tV8LoLne/pjHt8QELU7Ac6awsUwFz9Ji3qKB5QebU7Pol7c6NHN/qvY/s7ZuNkYsx9
         kXsJZrSqsKtkDYpFe33X3WPqtWSbzhPezJZrYlTYWKAlcwJG4d3RJtQXG6hCyoQHMGei
         Ln3buwQWVektLqts7l7AIbUdSFK0EAhFU8rgX83PfLUb7iU78HD0eo742xsz7doF1Zhh
         rmNviVLGxObJlsiLLkXIK50+UFktwB6nclX0UJM/GzAHiXXMZdquaiL1X0GyIml+a3tL
         A9SEKNsxywe/sH7lvQyAbs/ZO4bpEzNsENbVxaRWl6WUY3O2DTC7lNrirHLj0wmVLM0G
         fHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734338581; x=1734943381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ESVbK/QGYyy+mXv8GIEzCsLxto0hs5j5kMmDAMrMjQ=;
        b=gjTzpcUJ/biqotSqfkw4AFX4GtJ+SKGqDQSVXWF0LYge9rxlN4RLU/PJtffPyXYN4A
         OMn0IkGiO442pmIssaj+6bbbY0RTPcDJnBMC5nd5ObWw+MCE6XfGsaMyW0B6h2eiLCYJ
         QG8wZNHmdikYZQraMue6X0JS1wuKmdFUeIKaiC02Bv/LS2AOURkERRiSv+LN7cEwJElF
         NaJaMln90oKCghD+9cssTY5QPGAHoDuf9WoslCNqAiCawcu9Api1ks825xeGJnd+L+Ng
         iyEQn88DroWs15foif34fHB5CBPQARerCOMiAa9KHUXPwmNYnYbP1B7ZNa6H7dFDQcQe
         h85Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLSOByj6+SQt/52VdTXfHNfKcRKMjXb8Xj4HnaqnXrXYwQ+vG5VTo+0kyvMwY+TeAbpnpP81q9dP6jJUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyyUxbVPtsGoGCMBKeKg6CT51d/mz5Y+b15n0UH/hhmeKRtBVF
	22x4jYta6Ya5DTeO81HS6LVA91IESEMU0xlgr50J2HmC37ginTZa4H0JFZgWfAmiXCGweSeQpPP
	Rz9STa6ziS+3mn/xIXxezQ+anm7Tl3ET7jOThyg==
X-Gm-Gg: ASbGncvSKjFpsV7ksl7OQ6qGjIeZVOdmrP22djma645Xe7QHFvaETD4ZuW8K2Yd+8a8
	X87ecmw5ZO+ttf0PkgaKf2OonYbyXiLoWRYs0nROc5Eg5tVpB1vsNMF+kT/qhtNOyyT+lXQ==
X-Google-Smtp-Source: AGHT+IGn4xA40nF8STOCkYbc5tmOp9UWOQNm06xrEtaIXFJmc7D+X5p16HTNyzUm5pQIidN72lQxmYOEHOyZCkLFBZQ=
X-Received: by 2002:a05:6512:1296:b0:540:3566:5b37 with SMTP id
 2adb3069b0e04-54099b6a827mr3801067e87.57.1734338581092; Mon, 16 Dec 2024
 00:43:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202094903.18388-1-brgl@bgdev.pl>
In-Reply-To: <20241202094903.18388-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 16 Dec 2024 09:42:50 +0100
Message-ID: <CAMRc=MeEQT2aB_taL2FYUx3czA=a22mPYDgFyKt2W7jfKg6zBQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] soc: qcom: rmtfs: allow building the module
 with COMPILE_TEST=y
To: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 10:49=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Make it possible to build the module when COMPILE_TEST is enabled for
> better build coverage.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 74b9121240f89..58e63cf0036ba 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -139,7 +139,7 @@ config QCOM_RAMP_CTRL
>
>  config QCOM_RMTFS_MEM
>         tristate "Qualcomm Remote Filesystem memory driver"
> -       depends on ARCH_QCOM
> +       depends on ARCH_QCOM || COMPILE_TEST
>         select QCOM_SCM
>         help
>           The Qualcomm remote filesystem memory driver is used for alloca=
ting
> --
> 2.45.2
>

Gentle ping.

Bart

