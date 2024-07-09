Return-Path: <linux-kernel+bounces-246185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C2292BEA5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5795B1C21B9B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CC919D88A;
	Tue,  9 Jul 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRwfLKXE"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46819D07E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539746; cv=none; b=lDkvfMuhOKwASsNeiDKZNx/aBzew/qwrGlYZ6Q4aBLM47E223IjbhDppng0354JgXbN8oWSAsBSkaq9WL1NmOjFE9lIgCTsdrpN0opCm4KkpFYANjfpJJiq5kMWvm5g/XsreMeQ4s9IIlFvqJdOE/0Ixj850ybLYx2WcfqK8XYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539746; c=relaxed/simple;
	bh=IDnYi5w2LkIAtpFV1WzjyImHgQ9ZfZokiHY6+eIhub8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofqHBVT4EBYZGhv052+omNyIukgVnUJkgGdOCuCp+sJP5GkJvWjwugEuO24JLBBgWIB7peaIALmbSisz/hzjCXRUU06lG+TzwLDvAEMJUpY49gYx18JtiXe8e2sVs9gx0zje2kELXO32M3xpkpDAG/KBvH4yiCJJ7MfL1+JmM6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TRwfLKXE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-64b3655297aso51531887b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720539744; x=1721144544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X9g3Ubfmw+SgcZ7Yd9+hBldZBcIN14Yh7a3NFHtWpvs=;
        b=TRwfLKXEL5VsoP2+wvhJXYKLx0+GP0bscFNxmDzFMtHqVyXMpRxe4+ETLBts5pxdZp
         RQxhweRlezpmT65My52hb2NawsIlTA5wrTv0d2MnKkXLVGSLODYd4OzhqyfAKp6b5aDv
         wD9DCsIeS0gxlAWSBzp6GOCXbgxUTvCIrqq+QSRKytbqXmdGsNv8EBQRWZBGQloS2NAr
         TItvKu8dMe8W3I2KAQ9p2IZ+9vgiF3aSVk/TvdZqvon24zz76zETQqr/Uc98s+XX/R44
         bwQ1DQeEKIQ1E1z3jPRqD+hYjOfsm7W9olxBZ6hnLIK2wsBisqYQgOgb7fKVpH303C0k
         rkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720539744; x=1721144544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9g3Ubfmw+SgcZ7Yd9+hBldZBcIN14Yh7a3NFHtWpvs=;
        b=gdxjKMp5akd/q1hkZH4Fl6gFHvraDSOws6QsYOEwo7hOE0qE3FFLePehqK+QOaBuoI
         eXp7rDdOq3rc0xs7XZCTaL38xwlfc+2bs9+0H8ddMfBLmB8+nQDYAFL7ghFmrGPC361o
         IcWb8si1sXgJO/kfbDusa/mYNtxgphnVIrvS/Z6W1OWMgplxNDCtPFgfZrL4095jptYY
         xiioDIYp3YwvdDbjqRJTYGgC8du04oWHKIux3iRLYUP2n/r7RNnm3ydapjDTu/am2CTV
         0sGJYOS6JSQTMXSy+386fnwfh3JsPJnHYgImUJUUkPe67td6nhYYHik9C9Ba5EmBQroN
         BajQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYovpLV54eWedJYpbqoM3B12p0ioZ+ZAKsTRP+Pe3STj5ka0sQD1FG5A1IRJEEHxuSeSjgl9xWuM3xJq27VPJnD07hnWFda/SYf2+E
X-Gm-Message-State: AOJu0Yyx4f4R8CINMVsVY6VgKex+xN28cgUKHxvUzhypZX5TyjWIuUgg
	qxOH1H3OqY7y8A0P3HXzbdgIDaGnLM2uDjI+FF7vU/yPB9AfE5gkw0Ky1/lW01e8wlgFNbt5TKT
	3AIQE0RGmjZfU6Z36gWEoF3i9LH8FBHAFWUziWA==
X-Google-Smtp-Source: AGHT+IGIeAAB+Zbo9F+WEJ2ntehsPTH0AozBaKItZWisLbiKVixjbm/yHkzfeSzldmE/b2T8w3/wYkXX1FUE8aCOXZ8=
X-Received: by 2002:a0d:e809:0:b0:648:c8ca:f2d4 with SMTP id
 00721157ae682-658ef24b2ddmr30424457b3.27.1720539743849; Tue, 09 Jul 2024
 08:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709-add_qcs9100_dwmac_sgmii_hpy_compatible-v2-0-5ffeb16252db@quicinc.com>
 <20240709-add_qcs9100_dwmac_sgmii_hpy_compatible-v2-2-5ffeb16252db@quicinc.com>
In-Reply-To: <20240709-add_qcs9100_dwmac_sgmii_hpy_compatible-v2-2-5ffeb16252db@quicinc.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 9 Jul 2024 17:42:12 +0200
Message-ID: <CACMJSet_FX85rwa2JNBCSfVKUQbZrNdi-ya4KnJjNOumrJaOfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] phy: qcom: add the SGMII SerDes PHY driver support
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, kernel@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 17:16, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>
> Add the SGMII SerDes PHY driver support for QCS9100 platform.
> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
> platform use non-SCMI resource. In the future, the SA8775p platform will
> move to use SCMI resources and it will have new sa8775p-related device
> tree. Consequently, introduce "qcom,qcs9100-dwmac-sgmii-phy" to the
> SGMII SerDes PHY device match table.
>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-sgmii-eth.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c b/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
> index 5b1c82459c12..0ea7140564a9 100644
> --- a/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
> +++ b/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
> @@ -353,6 +353,7 @@ static int qcom_dwmac_sgmii_phy_probe(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id qcom_dwmac_sgmii_phy_of_match[] = {
> +       { .compatible = "qcom,qcs9100-dwmac-sgmii-phy" },
>         { .compatible = "qcom,sa8775p-dwmac-sgmii-phy" },
>         { },
>  };
>
> --
> 2.25.1
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org

