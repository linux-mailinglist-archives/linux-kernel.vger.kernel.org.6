Return-Path: <linux-kernel+bounces-189522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633C78CF12F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 22:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2922818A0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 20:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA2B12838D;
	Sat, 25 May 2024 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Terk2D39"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC986120
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 20:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716667443; cv=none; b=NQU7tkM1ktaGVz7UtkPzEY/9YD+baW5vvwcDXMbKA8VeuNZYKDDovADyqXGI0IveYT3ZB9nPF0RAvVO+TukdI9B+W1q4ZC0491R0DTMeGdJ9VdEjFzFxz+xOhhd52Bo3OssI2rZKLEZp1HV8L2nHGriTgfuv7rcU6wsJO8XIvlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716667443; c=relaxed/simple;
	bh=3H1Qh68+EVDSAFb8PydsksaGdeXzowO2wA/rKWMMvk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruxFhoMN/jEJ8uCJ2stvlENWohPn7miqbNmeb1CkbLsh7Xp+YtPRZAae1BzMjatw08owtWrbn20RtvUo2LXgc1IFCYJ3aIrhoXf9XGN6jUGlGYneJxk9oqpu/AUa3VIAoTs0R0PLh9zwnsvJQDVhLZiGS1Q2IKCt66xZuUNGQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Terk2D39; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-df4e0d8fa10so4196061276.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 13:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716667439; x=1717272239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3/avKGFNBrd+/abFgXWl2ZL/PQRH4HTWTJ4CHLYxFg=;
        b=Terk2D39OWueRpajmXEfRXrw4HSenac5qX2dtcCBHrgKZXlnBjF6q8zAV3HiPdxPwW
         mXmPKNC9WyUHMvwUqPTSbop/BCh+vYNaGqpeoFJnLh8yEck5DvL5yjXWhEdiSU69tb4d
         27XBzdxvLJrvz/ZA178bUse3Xc+XdCAQMzpdsB2QGnR6A5FXgaZS5ApgJqJoZIO5973i
         bkljIO9tMQvBGTrm7Drv6LHkSXI8kYIry8VXzE57iTVLFJfhaWG2IlekgzkKFu21kJNA
         qtcsyoNLAA5U7iTmuSeIJ8pSL2AbDn7Oujy6PC1JOhQOCSwEUVYV1HNEdL98aV35pJ4T
         6YOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716667439; x=1717272239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3/avKGFNBrd+/abFgXWl2ZL/PQRH4HTWTJ4CHLYxFg=;
        b=MlDEj8+vuSRnXueeW3rv3M1bdPifIxsEY5AqTI6xrU0W1s0g6cFHxMr5OhO2mFnpPm
         MvrXbNzJbrjwtP4lIl8wjjImz/HBbrBzU6+IMXQmd4hi6Pa6dNI2HEDt3FMP0HM2cWuN
         QHiuK5O/4k3iPMAb8Q3Ff2OjJx//tbL05m4TdDwtK3SNh/N0YRiBUjZW95FCz//M0L77
         2lbI2ZWUyG211HfomxHpGlSfU6aUpOmwfKDBMhidreRfUU659t3z8X1wqzU/1MCONjuI
         yLNSdUaVajMsCe9bkV52oo0CdEzRZ0U17SZBrhXPZ/pPxW1agxTn3itKPHVsI0BjnKKz
         +auQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtqluGWNMEhtEHOyd1UiYlcCfYJdhcLMlbArwceV2ZZWG4jxJei5CsSq4AXuvJuEmNmwnLJQhxdjGTvA4AH9OIsHsRNqYjbxRRgpcv
X-Gm-Message-State: AOJu0YylvWNR20gzPhRriVA5gHZ0cxbTh0Xd2NMZpLo5iFKs8XWStbZE
	vMZLIAjxVD4ZPGzT6jFPzG6mi3WRR1HmLwyGGSLFRo10i8Ph4s9jsOywhRKtGIo2Qlk+SvLqlDs
	DhUBPNgkwEdm2FgA3PsAYUkMylw+X7CssBFgG0g==
X-Google-Smtp-Source: AGHT+IH6aycjLexVZ8p98AVCReKJom4mXgKLjUmGuUVk1KxhzKsOHttvJD1H7gKjGJogTx4Z4N9GyH4J2geeT49eNQ8=
X-Received: by 2002:a25:e310:0:b0:de5:4b1f:7e00 with SMTP id
 3f1490d57ef6-df77215f566mr5467796276.15.1716667439433; Sat, 25 May 2024
 13:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525-mdss-reset-v1-1-c0489e8be0d0@gmail.com>
In-Reply-To: <20240525-mdss-reset-v1-1-c0489e8be0d0@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 25 May 2024 23:03:48 +0300
Message-ID: <CAA8EJpoGcXNv_tEJhNpb0n-E70ARxGRd4PHENZkTtqEKizVpCQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: msm8996: add reset for display subsystem
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 25 May 2024 at 17:09, Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmai=
l.com> wrote:
>
> Add reset for display subsystem, make sure it gets
> properly reset.
>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[No need to apply any fixes tags, it is not a bug that was present
before and is being fixed, it is an additional functionality]


--=20
With best wishes
Dmitry

