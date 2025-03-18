Return-Path: <linux-kernel+bounces-565484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA24EA66968
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26D8188D631
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439201DC05F;
	Tue, 18 Mar 2025 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4x5QfnQ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE851BD9C1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742275869; cv=none; b=J9SyyrlXgly0RDjPlzMjpcD4WyZ9VXu4oaFXM6RxafKPF9W94o+i+Ct7gPU0aj1TUtFDYOwtBm7obLHExkwyagnwXmWaHZgPWMyUjaESF7fZB1MIQQvQRyy9Ydk/5KSjTBEG49A/Es9CmfndxzEFb6Z5o3CdHop5xtEQ+s1PtaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742275869; c=relaxed/simple;
	bh=uc0nqUy8n6Lwy/VSv9TAgXJgTNY7busrfcgDDejJjrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKVkvJO54tQq5RPMJGM0S2Ix8wvQ3gKyydG9dKxlfHD0yihXMJGaRXi+JjeOY5z4blLLzwNB8JRNgCLiGlw1tvkyCn+gV1JMY485wfcTlmY1GLNw+AJPIRb2fXdGzJmbKSL4B6xwAV2VrqQxSxqo4xi+1ZkJpSow1RJrS9uTcEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C4x5QfnQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225b5448519so96457655ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742275866; x=1742880666; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WZOO6fXLUM5QQ6l+FSRSueHWGfAmK/qcP1DtlCjY8Js=;
        b=C4x5QfnQHvohKSaOJtlIvFHlPp/GGUhkytSkRerthYH9tDzm4NUFRTiSqZxngKOMTs
         ErT/dlUGXy2fuZbBQh+EFlC/2myqdIgNRQ/Mea7o7VzBdgFzxSXUMU4K9xTUO6RSb6BY
         PfBFJFpjSbtoYEeyD0o5cIzuSOfLbWpTZotxRAvkBhBhemdZu38Fn6jk3v5Q5ftMumwg
         i+kf/xcy6LRJ/VgPtYIAdKy1hZil6Omr1JXsHbb4CqW79jT+BWZc6gqAiZd5EtF7PDD0
         /qoJ9UJMJ3LIAKUQWzpnOja5b+MeFtC/9NpfSrAmMBLVD7pEVpULirTViEehTHMtkYxs
         heFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742275866; x=1742880666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZOO6fXLUM5QQ6l+FSRSueHWGfAmK/qcP1DtlCjY8Js=;
        b=k8rCmv3h6hDq8mTWDVqvnCxSlv7fsxtUvjxguFNRP0H0vHOXRPD6VvmJ4iQ+wJrtax
         h99N63C4Shi4zZyWC8Zp6GCbRhDxha2SRCntQJI69XRwXIQnr+XvHkghYMSaua3qVT4H
         +peN2RmNMufg0Sezt75bEz60O9ikct8e2ndWqMwcVWPqrlyU5pprH0YRA+Jnsf8fLR0j
         YjZPifcnzt/Hac5Fz7hTVo777M5V5NZblZc8T6lpCk7PietcdExBv8b/Ebq83ZiLxlxg
         2w3AiwTCtHLr7Wb4E/phvnmGXo6GXl5GcXPXhx9qNnjhRWBRDbPN2bD9d7Vp6E4CD7wl
         6UCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr9Zm/j8j+e1/O42DtA/yKGD18yxPsyJYmsWVZkIPQzVy+avR3H5qDydI3WX7i1u7RPW3fMT2qbQBcoxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD+9MqfX1qGkNjopFJ2P9KjpGYvcO13zAstikvtnK6rIBq0P/Y
	Iuv84ch/2g+uDBP+PoIoCZaVRKW8reO95ONh4zHE+V7hi6sqQDeaj2xRW7ptAg==
X-Gm-Gg: ASbGncueai6l3zsFrZQAyEHyxBks23F+YxTA4To6cmKYMJQKiMYi+ev2N0Y+ZTVz8C+
	ExDpfeive/vB/X57bwpepdjcWveJ2OQESg1V8a+3bNadVIXIfqmwEhz1NoXTERnCZFx4zXGWyWO
	Y/Q4s5u9o4MjWFLRZ8tT9FV7CWeslkPNu0U4iCTNPCcDRao8ysbJ852EuX9P3HJudQXjTMnwDKi
	Z9Ey5esYNXwsE0SjmNxdinA9YoAVzEljmF+dwPzGIQxPT4mphLunF6OuOb+YmRCWJnmPm1797t2
	F6R4BzHadRqGce6V0q+i30F7b+zNG3KqhkKvd+UltABWTugDDZn9riyL
X-Google-Smtp-Source: AGHT+IHLYD5fTKzDENoVI+mnh+1/mTxdSkdiF0on8Wov7vEkkGeSNfMXP1QSWphdwBuAx/8LoGtLHg==
X-Received: by 2002:a17:902:ce84:b0:220:ca08:8986 with SMTP id d9443c01a7336-225e0a6c2ddmr176694025ad.22.1742275866087;
        Mon, 17 Mar 2025 22:31:06 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe5a2sm85314025ad.196.2025.03.17.22.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 22:31:05 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:00:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Manish Pandey <quic_mapa@quicinc.com>
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: sm8750: Add UFS nodes for
 SM8750 QRD board
Message-ID: <20250318053058.ddhzbilbtenglfy4@thinkpad>
References: <20250310-sm8750_ufs_master-v2-0-0dfdd6823161@quicinc.com>
 <20250310-sm8750_ufs_master-v2-6-0dfdd6823161@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310-sm8750_ufs_master-v2-6-0dfdd6823161@quicinc.com>

On Mon, Mar 10, 2025 at 02:12:34PM -0700, Melody Olvera wrote:
> From: Nitin Rawat <quic_nitirawa@quicinc.com>
> 
> Add UFS host controller and PHY nodes for SM8750 QRD board.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
> index f77efab0aef9bab751a947173bcdcc27df7295a8..8dd82494ba5aea6e6b5ddafc9299ec68dfb84bcd 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
> @@ -790,3 +790,21 @@ &tlmm {
>  &uart7 {
>  	status = "okay";
>  };
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l1j_0p91>;
> +	vdda-pll-supply = <&vreg_l3g_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 215 GPIO_ACTIVE_LOW>;
> +
> +	vcc-supply = <&vreg_l17b_2p5>;
> +	vcc-max-microamp = <1300000>;
> +	vccq-supply = <&vreg_l1d_1p2>;
> +	vccq-max-microamp = <1200000>;
> +
> +	status = "okay";
> +};
> 
> -- 
> 2.46.1
> 

-- 
மணிவண்ணன் சதாசிவம்

