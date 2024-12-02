Return-Path: <linux-kernel+bounces-427782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A469E0A6D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBCB0B28F7E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDEA205AD5;
	Mon,  2 Dec 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hb8RGcuY"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C5202F76
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150933; cv=none; b=nqcmtrSIz6YtlOtxLgAUOoWRKyn4byj5JNUNhIb7t66dElkL5PrGSBT0ZlB4JawDdVv/C95GVIPBRcufBVaNfdlzZW4S2oSKgn9LAT9Lu0oP7QPIDHVgc2Ez+pkdcW0TX3z/10QReOmIT1S9rtMT34hgTUsLuazy3FPk0nNQB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150933; c=relaxed/simple;
	bh=XYknei693eTxY8aq2XA9wDND4yyWPBY7zhkDQopy7l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huUgmSrxNxez2/J1IPA8snKMpHvPGENtJfgO6YxiTWXyBhvtJYFM89a8Om+lDK/z9S4MUQ4gecVYFLL9/CNhdOCgd3RZh7j4fqiDfoCP8MTXkmnx3FFab73ko4nPzaGk+oSZ6mI9G/QlSWto7CUwWJXSzqgqqFmeLMG7CTx2GZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hb8RGcuY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21578cfad81so11431775ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733150932; x=1733755732; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GpKDAl11fDGEFH2u0shHgW2aMBuMgZUzlcce2vSqOBc=;
        b=hb8RGcuYKhOi7tMJgRYG8tTJ7+Ab1PeCtAzgDmTXJ6D/Y4h3Mst9WscRTg8KST32h+
         omXakHLVSviaq8a0esaR+3lCm1fpoKXI2MVGKUeB5tsZ1X81ryefdMt1bEP7KsVNzl+G
         imr8yt+UmHPkOo4X4TSFccdPnIe/b8gK6+mLjknlrmTKKY8Y/KpjYmuIZul3xn6yTt0l
         xaUB3Z42AI/2FYZTjNy9M8dsxQXl/YA5AAyc9zerb7Q7fOHoE00uDgzPii0SN2L2p622
         JV55ClJOMxlUu9ZU2zDOCaMdlnVXLALXvKENiNyOR6gyeRVecZiBbNCBfgeRdI/qpa+7
         lT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733150932; x=1733755732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpKDAl11fDGEFH2u0shHgW2aMBuMgZUzlcce2vSqOBc=;
        b=O7XSAf2enmsaUh9K0AJCqNV+zIMODYLCbzBc658hcMSI3LdsP9iYqHQ7wChCigfUEj
         esajnItCE+SUbIQrw1gzE+al/pSfhDKxsqZLjUj++F1nRnXgWlSBUDM9hkxPJr7VV0PB
         +NI6qxgjphwJ8GS0vzkZIbwbJ9FC9e3PbMAY0xPgLDRhqHzMfNJdgJ9ilUQc8pTMUGY/
         dLxFA8bd/dqEc01yxuKQaWOj1FuMU7wnhq5VUGayrM1Y5NuMR8bF4trNXJeLil/+cuqK
         ueLV5rHWsyK0D/C7QDpoC2PEJ6tvkFVrsb+uiJ7svZDMJ9C/4Pn5ovj6HPIlaP/ZwAbf
         CNRw==
X-Forwarded-Encrypted: i=1; AJvYcCXOaFUOcS/uC8jiIA4BhgCCFPknEQpvnTsrXDw5SBh9cjpdT1HUVqrGtEbEITjyNeWvAVxQ5VwyZsupPmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4PRCH5D+A+F3YB6y2YTGBOuf0E/GbJz8UvZMwcM5VpHXI88J
	g4K/a6mHVXhtOfywcSGm+PFwi1RuphMo/M76DgVyXFVYgVZ5geXYzZg0DDf55Q==
X-Gm-Gg: ASbGncuF+4LfOVviUf17iDh70p3czAyqJE758dN6jbUAkH1f0z0qRoJZO/ZPM89WES/
	Yx7rRTTPVA6mCJKQJ9hpqA9bEvd7zzUV6irvT2M3r2QqUU1X7Ld+cc9pzP9fhulDeaa5RCA2w4q
	a6FGHGJ9PiO7Fgml8irf7VpZD7whzGo5rEyFa21HQSGURdwdug33gRU6U5IsAM09EFAs8hzNhJe
	IayNt+UsCaQAhob1OVerV/Dz5S/kkiqk+P/EHwHtrNg4kH+puPwp+qBKnZE2A==
X-Google-Smtp-Source: AGHT+IEqa+tt8+8vAVIq3UE9y4O1HQ9UBxGGwNoUbUmxwVoafsrUcqpH/ZT38yQrrxK6IssCIyvowg==
X-Received: by 2002:a17:902:f611:b0:215:3fc6:7994 with SMTP id d9443c01a7336-2153fc67ba5mr207835105ad.49.1733150931824;
        Mon, 02 Dec 2024 06:48:51 -0800 (PST)
Received: from thinkpad ([120.60.140.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2154704346asm57084655ad.18.2024.12.02.06.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:48:51 -0800 (PST)
Date: Mon, 2 Dec 2024 20:18:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Xin Liu <quic_liuxin@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	quic_jiegan@quicinc.com, quic_aiquny@quicinc.com,
	quic_tingweiz@quicinc.com, quic_sayalil@quicinc.com,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: qcs615-ride: Enable UFS node
Message-ID: <20241202144844.erqdn5ltsblyhy27@thinkpad>
References: <20241122064428.278752-1-quic_liuxin@quicinc.com>
 <20241122064428.278752-4-quic_liuxin@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122064428.278752-4-quic_liuxin@quicinc.com>

On Fri, Nov 22, 2024 at 02:44:28PM +0800, Xin Liu wrote:
> From: Sayali Lokhande <quic_sayalil@quicinc.com>
> 
> Enable UFS on the Qualcomm QCS615 Ride platform.
> 
> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Co-developed-by: Xin Liu <quic_liuxin@quicinc.com>
> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One question below.

> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> index ee6cab3924a6..79634646350b 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> @@ -214,6 +214,22 @@ &uart0 {
>  	status = "okay";
>  };
>  
> +&ufs_mem_hc {

No 'reset-gpios' to reset the UFS device?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

