Return-Path: <linux-kernel+bounces-424685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CCC9DB80A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6626AB21531
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD691154BEC;
	Thu, 28 Nov 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymP1yL15"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007A1494B0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798617; cv=none; b=PCciNIB3rS7VZa2GTlB4MTBqviWpW+9F/vtoVt2Qo/4YzUM45ZBtDvs9OF+iq877J9TaF26sgkk5uhixa93OsBSq/a6bEqrRwIyDI5k3X14RiErzCa1Xwi6vwXO0AFaGp+kG4imNxyKOk4x2ICWN0GAUEhmRzPt+8q3X6zTw44k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798617; c=relaxed/simple;
	bh=wIbCDeRCPipDEj0QLk3Kv6nua3hP/xB+LsLEnGR6CPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la0MYVmsV3AKT4KDY0jSmlEC14NKWRfcfEqrWxIF0uHCo03KRS19AsQfdwoIjx3WkG3m2teB+JhyN/jfUwv2RckSib5aOb0zYQTcxcC7RNSQr8wlh7Lj+RUNo1hHGQRhc6Q/GmjkW3YQPjmU/Vp27bz1ajCSFLK1iWZzqI37yDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ymP1yL15; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53df1e0641fso881949e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732798614; x=1733403414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1FMqL0Vo9ZTV7oQ44UmQZuGKsEmW6qDjMP/0EBigxW8=;
        b=ymP1yL15gIB03l+eI/nE9vgQYWmjOY4S+YsvbPVvO1Y3tGdbbxUlVjAqW9hHFdnDp+
         jR0hKftPrSzYGv42+UEDgkNoPAGLoj7RR31qq64aLu5KbiI2CW4gks1KrddKMdb85dPu
         hMcZ0pY0phGmHmWGaZ4Q4XACEwlXBRoqurypen/UQX5W8EsyTh73/TkuW1Y0EwiMN1sx
         KOz9F4Q5D96A/i/GAJ4a5vH0OaGwMLPNnbg+vrAhSNmpUSZDzaBEttfMjVGguV1RVLUl
         N48F5yy7sr+LN4JtbPgLhSLn1HXpk7uMtLsbe5GUd3cZEjA8uFPtWVOpq9QeODmE3rlU
         or1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732798614; x=1733403414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FMqL0Vo9ZTV7oQ44UmQZuGKsEmW6qDjMP/0EBigxW8=;
        b=vIguXpqigTizHhu15wOOoWB7CDjeV0utY2xnIy1lkhG47bfUzNdqh7YbxZs5URse0/
         ERTDTPRW35zLhsPjdIqOPRtWUIVgthsHfecyccQs8lBvvfQawDXcqwN9GOWKU1PDOAJJ
         SoAtXLA/YS5rh/C/wFYOf0kBJ3m5dAgmWt2d/5l45NuUehiK+0JX1XB4dNClw5nmwXZ4
         ilLN2BWN/mRQSzXkZwJWUcxvlS8lHIwwiU9bPIeEK5xX5FhZXDYU0kK4/0kPQWXzVEBv
         JjYzf6R7NQxASe6FehoD4Z2S7d+AEv7ND9skeYpMOlcHxjn/kR79PUYIKxZhH1ou762F
         EDfg==
X-Forwarded-Encrypted: i=1; AJvYcCVP6LyF/81Wvv7ulZMnQUtONL+pFkVHgazE2f6ddN/FBN3YuH4QqQm05mJvVQvjeZhSHMMZjLCr6RSiJjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKHSfI0mxwMgCZpQ4ZtBurr1YZNgy3iGnvadr+zo8HJHwMtvXx
	6cW3aiE9lCy+YtBx4MzK5r600uMYGp7czqt+wsOYiD/TvJVfq2UJmJ/jFmFYrVU=
X-Gm-Gg: ASbGncvDvz+kxJRFLSoDRSBOp0LrdKgLTD6rtRo2bPxx282i8lq5EsPxevARaw/iXNj
	0eiJTj3owTtA+BsPMzNOhbpVCGK2Hzb7mvHGDpxQuaj0s/Rb9L0VTBRXxGYMe7OVTLW5w2dEgz9
	mmsbGeH7Pn8aGjfYYaAAB0zGWsxQBh8PsUFSyQ1RqFHi3D5jWZLsZWvj4+QTADrHLGtx5biuZ/4
	NNp8RF5coeaSQjMRd5w4odgyDyUSjm6dwpLrWG8jSCj248s0XM5ZW3zyBKpbSw1xIBOHkwfYKLx
	XxmiaO5lycFrD6xdd3KCuvZWUsPsVQ==
X-Google-Smtp-Source: AGHT+IHd39GNyqtnusbMRvZYgSGa/NnHGVoGq9VkP7PA/yhU8e6l86ZQ3O9anzd1w4QjK9hje9fIPg==
X-Received: by 2002:a05:6512:3181:b0:53d:a4f9:6141 with SMTP id 2adb3069b0e04-53df00d1b1cmr3597761e87.14.1732798613900;
        Thu, 28 Nov 2024 04:56:53 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f27fsm170090e87.157.2024.11.28.04.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 04:56:52 -0800 (PST)
Date: Thu, 28 Nov 2024 14:56:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, 
	kernel@quicinc.com, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: qcs8300: Adds SPMI support
Message-ID: <25gvmj5evftgb4bbu3gmaxcs2hvflhrwrzsnhn7pizop7dq7oh@drbk5vvcf7zt>
References: <20241128-adds-spmi-pmic-peripherals-for-qcs8300-v2-0-001c0bed7c67@quicinc.com>
 <20241128-adds-spmi-pmic-peripherals-for-qcs8300-v2-1-001c0bed7c67@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-adds-spmi-pmic-peripherals-for-qcs8300-v2-1-001c0bed7c67@quicinc.com>

On Thu, Nov 28, 2024 at 05:40:16PM +0800, Tingguo Cheng wrote:
> Add the SPMI bus arbiter(Version:5.2.0) node for QCS8300 SoC
> which connected with PMICs on QCS8300 boards.
> 
> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

