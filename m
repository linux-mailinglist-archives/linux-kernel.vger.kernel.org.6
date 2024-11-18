Return-Path: <linux-kernel+bounces-412831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EF29D0FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00996B25B27
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235B74437A;
	Mon, 18 Nov 2024 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEIprSp1"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A3BA4A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929379; cv=none; b=RZm6NiewgEn9tXI45MUZ7yJOJIz95OG0fHGvtbLsmUWCNNZepfHNcon4PzBxTohLjeFVJzsf8khjYlAEEXc4NUxEUB/tE3c9XqVQHITIauAQGlMsPFEWiOMlsu1965mSZ8jJIJTHTRP/fziiguxmU/QrIYjhHGzYjTFX4xzduTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929379; c=relaxed/simple;
	bh=AB3fHdu900F8eU0iaSKmmUBPimL6Jhrv4LL63wkvBd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW7Ljh26BOFIbezltM/eIL184AYRWEoN9dbBhrxvjE2qwi7L3SvQU4T4cnuGEu+0h5R5ZrbLv/Wm04YJLf8vyfiKmgMFSiGYesz7gBCiCEXLJK1L9ofPx8LzZI+z5SpU0+o7rwwmQUPc9IcxEANvR9t27XO8jM8eG5Z0k3qwnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yEIprSp1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53a007743e7so3186759e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 03:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731929376; x=1732534176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+F1c07+mVwAqV5uUU9D6sA4NJCxNvjYMVVxQX72lwM=;
        b=yEIprSp1H5UBtyXcMzV6+KCJ7Yyq50UbNqp+48vWPF2f/QcYulpZAGVodFzNKgZM9F
         gTj2PJpirjaT3qLsburKxNufTd2L0nSkL/binWFN4xcfOLczYfwpe7VpOGBqXIuL1lgZ
         P6GDVWXZC58uOBSg+aN8zw5aXf+hb6VhN2qEjzr6geSARtsIcYbLAkLBR8BLSO/dK9ZK
         1gVhsedt/QA31nEd1NSEheiMft4BRBclDPe0LzJZRqbhy2OgdGH/fIEu8VTz3W36G4qu
         UdopMMr+5VW5A07yrVhPEV8CMbFek+lERhIB8UpknbHr9fMkWu7NsNGQ3oKCuwW9q6Zg
         XDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731929376; x=1732534176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+F1c07+mVwAqV5uUU9D6sA4NJCxNvjYMVVxQX72lwM=;
        b=lR51llsaz0i24j/4LH1TESUkkeICE+5uIBYGREK3jbkCHg+ErrbHjYvil3WQgX4bGB
         mnVOZ87RajXWk97AsnNxXezl+e9Wxm39o6OmLDkyrNrcCSfujA3L5nlVdWoDM02jy03f
         9rH7tS8GeJ1JGfmc7W/liKP/WMPEdcjc9Coa+XiXVsw0dFhDSZzlCMoTJNCPLFmky7Py
         2YhnmKde4oNbMjcjJ9MH2XeLer6yo/+Rz6Jxk8o9VRXwHV3QBs0JMLOhgUodNCPlW555
         ed5DfwWfRKudT5vr+ChrxB3XsPfIz2/NX7zfPQtSrFhxfaFj6cJuwgrIHlaq8z/uEdNp
         Jl3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQsin553E0N22GAMsMkcYoYSF2yFd/QDPr5UX+2SrJC/UeSGaHcJLAnx7cAnkC3yANgAWC7gYcMsaDzxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2CaLX8xLMP57M+DkGTlm9MzkusOR1spVH+dX8aIIxjUPEIutE
	z2L8daUhP5UM3mxs2jtBEdCMxajhxYWDcdiIIF/GMjVqxBJaTD8VqgR55Vrn6z8=
X-Google-Smtp-Source: AGHT+IFEZqxXgk+9U3MgdABwpoiyQ/Uhmu+oBjqI0WpVEI3t/hTC8H0NsASHj/gLT+Me6/W8C4z/KA==
X-Received: by 2002:ac2:4bc1:0:b0:539:8fcd:524 with SMTP id 2adb3069b0e04-53dab2a6af0mr4817753e87.30.1731929376123;
        Mon, 18 Nov 2024 03:29:36 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6531338sm1592768e87.134.2024.11.18.03.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:29:34 -0800 (PST)
Date: Mon, 18 Nov 2024 13:29:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org, 
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com, kw@linux.com, lpieralisi@kernel.org, 
	quic_qianyu@quicinc.com, conor+dt@kernel.org, neil.armstrong@linaro.org, 
	andersson@kernel.org, konradybcio@kernel.org, quic_shashim@quicinc.com, 
	quic_kaushalk@quicinc.com, quic_tdas@quicinc.com, quic_tingweiz@quicinc.com, 
	quic_aiquny@quicinc.com, kernel@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: qcs615: enable pcie for qcs615
Message-ID: <u6wy6w5yfchbmhyvthhibyrhdp2pmusagxyalcanxvhg7ncbfn@vq6x6iwxtn2g>
References: <20241118082619.177201-1-quic_ziyuzhan@quicinc.com>
 <20241118082619.177201-6-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118082619.177201-6-quic_ziyuzhan@quicinc.com>

On Mon, Nov 18, 2024 at 04:26:19PM +0800, Ziyue Zhang wrote:
> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> Add configurations in devicetree for PCIe0, including registers, clocks,
> interrupts and phy setting sequence.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts |  42 ++++++
>  arch/arm64/boot/dts/qcom/qcs615.dtsi     | 158 +++++++++++++++++++++++
>  2 files changed, 200 insertions(+)

Split into platform and SoC changes.


-- 
With best wishes
Dmitry

