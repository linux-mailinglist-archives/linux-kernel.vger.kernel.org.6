Return-Path: <linux-kernel+bounces-206744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0DB900D3C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB571F25032
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05253154BF7;
	Fri,  7 Jun 2024 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/e4QyA+"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC990154429
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793593; cv=none; b=JDaFcaQTyWSUVuxecr6dZv6TmWNYj07yE+8rx+Ye9AZg7s6xZ7L7BRO4VMFCNcIUbFq4lTXx1/+iIoG4FvsBcHiyipBRqBLAoQpgWb2OPAAcDbdTagZUZo0SaQJQWgCFZ1D5kh+ZD1OTv/xo/Li/KXbHr4eMTorS8en/yEZ1uDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793593; c=relaxed/simple;
	bh=P4GqccFemYCv3Ph3Tj4HFzTepeQOmwXMVKjFNfsdrHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQ0Q9gUCX2FlgBcqNPp05KfjubPlrSw8bTd1g1fMwOL+2C9H8YpPZgr/f7fOkzXc0gCitFrJkltDabU/Tbod76I2hr0gu+YHK1lT0gTPHBQ9B67Cz2OxwYvWoOzMSS87o0bgHhD94QkUVpujOHW2gOAA+I5z3cw2HRfzpr0Mn9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h/e4QyA+; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52bc274f438so1114077e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 13:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717793590; x=1718398390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALL6wLm/pEiklAzdrlD0fFMMB40OeFD3F6hHrSjlWrg=;
        b=h/e4QyA+1ti/beho16Kp4vdAb0lDLmCZV4QKM3S0hk9uEttg2m+h5TFNkenQo0oPJD
         V5XWLpcycgDrm+5UlxBQN4FU/VzBLWGk27Lzo+4r1OilY9k6fdtuHaf4/4R4wbzb6h4J
         6MWtQZKGhpie5sPDVhLErJaRfErYl4R56FDZ2FbJUYmYqRT3JC9PDFA51kR1cpXOv56Q
         i65WBgD7XumtJOlgrTaN/knWx/mFInRK8jCwGDFdRzZkflyQuFVJp1odCh5QBPAyTTzV
         n3rK7foI+BzQVrzePFa29iIqFAlKgPck+oDfBxXhGuQIFeQlUlgjxsSQF0IC3XwXAxU2
         jziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717793590; x=1718398390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALL6wLm/pEiklAzdrlD0fFMMB40OeFD3F6hHrSjlWrg=;
        b=Xdk7tS9baIny3LSTI4zCrWat2uT+/m6b+3YcyTQBb3hIbBSLaNhj/cukY5Mesr8Ug/
         2fV+t3+MUbIKb8mH7MQRrVmKSgs3TjTHYH/l0uxf6ziuk6y6VUR7ytTyIhkYGsy+/RsP
         ZxvqwXSE5yw37Nlz7jyrxjrcRR6vq4XNJFPBuKSs7Z0vaVTM40P2LflEknJPMZx90kKa
         wP1PVYH83r3Ml/qSg6dFwXHEcmt3KLl75SP/yekFZuyjKi+aFKd7sL99/ngMQJoT7wx+
         kAoU9UM19Vwnhmxu1G/kqunj2nQl4U5qdxUdB8qk1nTg5rt5fEJBbriHR3BpJrETRqNB
         zSIA==
X-Forwarded-Encrypted: i=1; AJvYcCWP5YJn0MUcMItCb/GKXhzV+wystZDtc5eDWnHO2J5GKgVdAPuDB2nVhQEyVhB7kIHvAO2N1mnJHB6J42tPLtlalFBnWsTAfFoxUipc
X-Gm-Message-State: AOJu0Yzd63rdR/glutKJkmsv3XATL6nRPy1X8rBOiozxAMHOxn9IKFsz
	9jdOILbWPbtHLS68fgbgo+05l/bnjEAx9Ykt9jXbxr+km8OZfYgfjwy1GAWPfjsiEdfZ1Ia2Twa
	QHRr/qJH7ou+d0b6s0OkWMDIB3NWgh9jnLxuNQw==
X-Google-Smtp-Source: AGHT+IGhGBYgYkG9ZA8FAwO0qaapJnnGVds+RrxgL96B4r78rFR4O2xGdaFmnclK8Gfv5k8zd5MDW6bRfsiVqyeC1S0=
X-Received: by 2002:a19:7502:0:b0:52c:50ff:6567 with SMTP id
 2adb3069b0e04-52c50ff65b2mr228916e87.22.1717793589914; Fri, 07 Jun 2024
 13:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529162958.18081-1-johan+linaro@kernel.org> <20240529162958.18081-9-johan+linaro@kernel.org>
In-Reply-To: <20240529162958.18081-9-johan+linaro@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 7 Jun 2024 22:52:59 +0200
Message-ID: <CACRpkdavOBqVe2gON=5Zk6JVWJfjy3E80YFEsyo0-94d1bX8FQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] pinctrl: qcom: spmi-gpio: drop broken pm8008 support
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, Stephen Boyd <swboyd@chromium.org>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 6:30=E2=80=AFPM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:

> The SPMI GPIO driver assumes that the parent device is an SPMI device
> and accesses random data when backcasting the parent struct device
> pointer for non-SPMI devices.
>
> Fortunately this does not seem to cause any issues currently when the
> parent device is an I2C client like the PM8008, but this could change if
> the structures are reorganised (e.g. using structure randomisation).
>
> Notably the interrupt implementation is also broken for non-SPMI devices.
>
> Also note that the two GPIO pins on PM8008 are used for interrupts and
> reset so their practical use should be limited.
>
> Drop the broken GPIO support for PM8008 for now.
>
> Fixes: ea119e5a482a ("pinctrl: qcom-pmic-gpio: Add support for pm8008")
> Cc: stable@vger.kernel.org      # 5.13
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

This patch applied to pinctrl fixes.

Yours,
Linus Walleij

