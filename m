Return-Path: <linux-kernel+bounces-555051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0840BA5A4E4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1ED1890FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8036E1DE2B2;
	Mon, 10 Mar 2025 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xH+OswmP"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2441F1DDA09
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638338; cv=none; b=DyTHALgZ2aMumRJO7WHOKAHoC8EOrKiJXB+i0Gx7thE5RxlIM/pmyCgagCOZ2u/KdGQ+grww1AB9fYKQXBBxdK8AlRN7xhG7uAtexkqdSUt7WUFz2PxC0UkEZBhegHNleVZ2KW2qsERopZDxPPkdBXk2kS+SWNeVo18P5uZ1tAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638338; c=relaxed/simple;
	bh=L9+uLSJLlnFoF8qnj42PdQx3Q5RYzcJ6a/f47QtrPHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xyc8zY6bF0B9o6j3HTZvPEaWryinq6TPm745DWiPzbuM/8fd6Ivy0rcKwuNJHzNLVkLq1m+0R3EvVUUXaDy8fwmgC2ooFK3D76znHJrKIxVScpoUKZdl1ZnLS2PZzB3XFWPsyMngFYS6ZeBZX0Ut26XhzHfWDi4jCqKejaG00o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xH+OswmP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bd21f887aso42518741fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741638335; x=1742243135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYNmRZYB/IDO1RurR4i6iqDD/1mktBUeW4kgdxDpZIw=;
        b=xH+OswmP/CcgSiKX7NC5EIZKpFzqTMBvQKOua8bj2RCt/4KmiTK1Kj9rW64FBMSob6
         RS382yhw5sZlzayoKWCCuOXdNJa4Gz8HJWPX1U3Pu6xDDmOAR8pp5nYOpZb2/YbZAnVs
         crPuzbjdQRFMQ0eYUBe6G9YrnF18gMUtEOg1ex7ZoEGb8FK9lNWCiz4/dLijIU4UZr4/
         xwQO7Yj/ldfq3hxzF5TiSuhtAePwdWzvWo1WnBK6RB81VbCohnmN7E7ntYZ/QZrt5nfH
         hi7v4JHreheuI/szkNYb3NlbDXa1p0pXqM1GkzEmliccRQCsl05n5PyPQDXlgIkGzHjc
         doYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741638335; x=1742243135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYNmRZYB/IDO1RurR4i6iqDD/1mktBUeW4kgdxDpZIw=;
        b=hIyU8mz1vnymrRsl/fE6SCsuDIl7EGxyUS6lEBnudtgAxZxAaTt8PyjPZrYUdZl40D
         ZWS4diH5lDGbn/HMBdpl1vtFB22zl+46UDJ1PRzv+bSNuKKNYDGb59BWLQsXQlnHKFzE
         56RzFyc8AxiuNiI2+S2UvUwGn7tWepZ8sjcV1uNoQGaRSynOzMOeqB7Pqj60VnOi202M
         iONce9bOoheU8qM/SP2rm9BkS0l+TsRR7G0JTv0mT8qKKs7GcUJ1E2fkgl9MQkx80KOh
         Qf2JDNN6kL4clVRXhPJN8nHoxFXBl3/MoI/VpG9Q0CjE/jrejrypHg/WjmXJzb6zgiRh
         tnHw==
X-Forwarded-Encrypted: i=1; AJvYcCXOgQy5jjVNhDH3bOL2kUBEPeQTUCCd5pnpUJHfCRX51vBg4ZDSTIC6+aVISkuuavsqV1BLuijufFQu3cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuKx3TfPeANPwxES/Q8SV9uKGD5VPKbcFR+JdaiUZDyBD+1cK7
	KTG7rAkcka37Qd2mDOVF9kMbUZGRj/kNbTTAflIBhn+sET71Lk8UXzAuM3jNrFU=
X-Gm-Gg: ASbGncupf8ULZlp+wwfxfgXu7c8KlEu1opDPGIiRYhSQeExyg7KcNonRAuezVgGj/W3
	fTjLt0270Lf+KInB6/fzBPDeZS4opTJ2kJg9SwqLvOmg2Rz6KbUq9EdQLW3YSSZFI8Z6WJq0m6u
	qXyrB27qP2FifFzgIL6mP5VAAXH4A4yxiHEB9wqNlQiWhx+DxbKySCjxvf7EH8+fDujpY8dbGzk
	mjnop94sHClb0e8rrdQBmuwyYSqaD7DCBEM83zrpvtMG6CQWSGwUkD3a5c4My3qsc9KCjoHSdmj
	6SL11Ykk8O355cnEMSceeldIrgSCTfOqozlkUXRb3Q2ArkQTmiyk6Zey8gG/rnb8xzwYIhnDgNW
	/T+3l08Jr1hqja3lY2vuB3PMw
X-Google-Smtp-Source: AGHT+IEPVrqhzKdG85UY4VL7q1PeHiNjtgCxYCgNnkHHR37Br6Hv/tkjnMqe/JrlEqz3SvLMcEnR1A==
X-Received: by 2002:a05:6512:b84:b0:545:f1d:6f2c with SMTP id 2adb3069b0e04-54990e5d4c2mr4659162e87.18.1741638335156;
        Mon, 10 Mar 2025 13:25:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bcf77sm1556084e87.107.2025.03.10.13.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:25:33 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:25:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, quic_qianyu@quicinc.com, 
	quic_krichai@quicinc.com, johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/8] arm64: dts: qcom: qcs8300: enable pcie0 interface
Message-ID: <mxqrssteqfzp2llhp7exj7yoduv3h26qrxnsb7tobxkk7lxyeh@ywers6elgmwy>
References: <20250310063103.3924525-1-quic_ziyuzhan@quicinc.com>
 <20250310063103.3924525-7-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310063103.3924525-7-quic_ziyuzhan@quicinc.com>

On Mon, Mar 10, 2025 at 02:31:01PM +0800, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe0, board related gpios,
> PMIC regulators, etc.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 40 +++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

NIT: patch subject mentions qcs8300 (SoC), while the patch enables PCIe
on qcs8300-ride (board).

-- 
With best wishes
Dmitry

