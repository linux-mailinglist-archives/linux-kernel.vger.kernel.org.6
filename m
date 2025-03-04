Return-Path: <linux-kernel+bounces-545583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC7AA4EED6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EAB01891492
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E3265639;
	Tue,  4 Mar 2025 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sMSA5BHg"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507E1264FAF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121661; cv=none; b=BHfkQV1Is18J2oJMPJByDL3+6zpVzbzz68QBXH1yYmTL4Kqg0zMGnZWR0G0oqiU0UA8jBdvl9LT+StPSfy5D/yvcXv7WTqQdqshX11xnmfjXStw7Pfcd/jM9Le4WtXrL8DFZeXYyQku39yeKKDW0V3cAGugVqWy7VuIqiJKVuMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121661; c=relaxed/simple;
	bh=IRmRM/iqkdC6qVTybFyE3ZuVo0jNnkna+PcF+XjgpOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMZGDdHnzjKPtO2/7IWW4I8xjCGLJDn3BBYO+3goqA98udY799WFKXEBjVDiXMd6Q4dRmbfQsmJuANnaVS2KPHVEnEPRJEMpRW6AGexriDD7jYNfQ/a5/CN86jlowu6Xdj6uG75q9QKWOjFq/qCCtI8PbysoakqhKRbABhPkbRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sMSA5BHg; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30b936ffc51so40021901fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741121657; x=1741726457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zL7TK+qWnCNV5/AETFrb8jPp5cyvJYgATDrXM2qgRgo=;
        b=sMSA5BHgrCnvwYsX05tvOghXR5G5C+Aglgp7TptOi2wcbjnonD3I8Ub5RQWIwrRo0N
         W3RujL+q0Q4C6eN/iCQiSwvPcfntg34b1HMF0s0HDRfqEnQfriJvEmTAJevO11d4HOCe
         ThTm1LJ56b7kpBiGcIBRK2FdZI6JWDXCbaW9SbAnKzEfE6dyruI+SISLOmysSc9nQibN
         w5E/z9pdcv+Cx6NMwnsVpAGFylP8sjtmHku/wf2PjFSXGt/UozkCTiouphxfdp3xagw6
         Ywg2CuSGhI0wPT5gJ1EnO+5kmW/mPwV1Uam3TXt8hnAUaQXZwgyEtNvBCuJTPrjTBzTy
         q+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741121657; x=1741726457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zL7TK+qWnCNV5/AETFrb8jPp5cyvJYgATDrXM2qgRgo=;
        b=uIPCdQ3nIxCqz0OIe4zOLBno0hB4IPpz7NzQT2Yip6LpYxtK3k+SyKcaZeF8LnN+4x
         mYOmI3H9u2XvNtA8su77P+Jb7Y4V6QOlUanWv/egtmq6xhMbgYkD8rWIWFa68hWtZnzN
         mMRa6AVXYDwvzaKLDORH23OSgPd0ayTZDXVp/mklD3Jo3a17bbJXI/Kdy3lC90YsbUIE
         94Lvq7e6MRjOqxeVTsNQRkR1IzAGn7733jvN6qNsUDnRUgpJ5IwRwlmrmt6YM5tjpe51
         yzwVxcDA57Oz26Clo8Hc9v97DX5seU44Nrtip1zu7HPmQAnKCvhpoVT4uGyzlsWdJkif
         Ctpg==
X-Forwarded-Encrypted: i=1; AJvYcCV9WCLaKJKClA9PmI/6zbeynUH3tOtpxp72PieTpbZfskMBFJyCf25lbN8H2B0m+6qewH0wONCVkaNmTPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGWCBy7yWaWntT+L+SrdhxIfSur4KXOeNmnSBkWMuDMjh4vXlx
	aona8dRHeKV3jwIs6RKiIwamf+evPdQta3KMkm7FCcIDkbD1oxOQl93TCIx95cg=
X-Gm-Gg: ASbGnctOhtF5kYueLJuLwxJCnyLULDyvfeZQCdf+uNJ00Af5qi3vGz+bvVI18dzTPst
	QvmHJDU3UmFOU+K7mAjumQM1I8fzgX4/TQ8/wtSjXQcYuCXsZzCJLfku/qLjjMbgOCzd43T6Eqe
	8wbP2RwbBQlw9pT0JOMt2LDrmXYJj9Duj/7WPdNVz07sujg9l9RMBMzjcXQsGCuUlKuXwlbKKyk
	a7xAMla7zHwVT6XXRVwyQ7KAV9kuMKak0p7rGY1Wq9pUwI/Z10VwlqkbtPULHtmd6s6JfoRnBx9
	0pBe6q5/UrPsRiPZwymRo2bFMkWFPa5GDD7FiUkMcJQPioFBSo4uxKuC5ozKo5Ie22Kf2HrbLTT
	tI8oEpk7Fcms+8B0cwv/oRs3h
X-Google-Smtp-Source: AGHT+IE0DjiMQw1sLephw4rxWk7HFEElK/DPXY4ccSdGxPEFiNKQH0Zh68XsjdtSq4f6eZVQtGRvTA==
X-Received: by 2002:a2e:780f:0:b0:308:e9ae:b5b5 with SMTP id 38308e7fff4ca-30bd7b0fc11mr1647801fa.33.1741121657314;
        Tue, 04 Mar 2025 12:54:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bb9d46221sm7710481fa.54.2025.03.04.12.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:54:16 -0800 (PST)
Date: Tue, 4 Mar 2025 22:54:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 5/8] media: venus: core: Add SM8350 resource struct
Message-ID: <gwgvw5wpfnvswifeyjvcppsxplobahqrwsswikc7z2h7vbef5e@66qpvzp7hz2e>
References: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-0-279c7ea55493@linaro.org>
 <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-5-279c7ea55493@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-5-279c7ea55493@linaro.org>

On Tue, Mar 04, 2025 at 01:07:11PM +0000, Bryan O'Donoghue wrote:
> From: Konrad Dybcio <konradybcio@kernel.org>
> 
> Add SM8350 configuration data and related compatible.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Link: https://lore.kernel.org/r/20230731-topic-8280_venus-v1-5-8c8bbe1983a5@linaro.org
> [ johan: rebase on 6.9-rc1; convert vcodec_pmdomains ]
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> [ bod: added static video encoder/decoder desciptors ]
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 41 ++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 93e5b9e1f70cc..dbce635f9fa45 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -1012,6 +1012,46 @@ static const struct venus_resources sm8250_res = {
>  	.enc_nodename = "video-encoder",
>  };
>  
> +static const struct reg_val sm8350_reg_preset[] = {
> +	{ 0xb0088, 0, 0x11 },
> +};
> +
> +static const struct venus_resources sm8350_res = {
> +	.freq_tbl = sm8250_freq_table,
> +	.freq_tbl_size = ARRAY_SIZE(sm8250_freq_table),
> +	.reg_tbl = sm8350_reg_preset,
> +	.reg_tbl_size = ARRAY_SIZE(sm8350_reg_preset),
> +	.bw_tbl_enc = sm8250_bw_table_enc,
> +	.bw_tbl_enc_size = ARRAY_SIZE(sm8250_bw_table_enc),
> +	.bw_tbl_dec = sm8250_bw_table_dec,
> +	.bw_tbl_dec_size = ARRAY_SIZE(sm8250_bw_table_dec),
> +	.clks = { "core", "iface" },
> +	.clks_num = 2,
> +	.resets = { "core" },
> +	.resets_num = 1,
> +	.vcodec0_clks = { "vcodec0_core" },
> +	.vcodec_clks_num = 1,
> +	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
> +	.vcodec_pmdomains_num = 2,
> +	.opp_pmdomain = (const char *[]) { "mx", NULL },
> +	.vcodec_num = 1,
> +	.max_load = 7833600, /* 7680x4320@60fps */
> +	.hfi_version = HFI_VERSION_6XX,
> +	.vpu_version = VPU_VERSION_IRIS2,
> +	.num_vpp_pipes = 4,
> +	.vmem_id = VIDC_RESOURCE_NONE,
> +	.vmem_size = 0,
> +	.vmem_addr = 0,
> +	.dma_mask = GENMASK(31, 29) - 1,
> +	.cp_start = 0,
> +	.cp_size = 0x25800000,
> +	.cp_nonpixel_start = 0x1000000,
> +	.cp_nonpixel_size = 0x24800000,
> +	.fwname = "qcom/vpu-2.0/venus.mbn",

"qcom/vpu/vpu20_p1.mbn"

> +	.dec_nodename = "video-decoder",
> +	.enc_nodename = "video-encoder",
> +};
> +
>  static const struct freq_tbl sc7280_freq_table[] = {
>  	{ 0, 460000000 },
>  	{ 0, 424000000 },
> @@ -1086,6 +1126,7 @@ static const struct of_device_id venus_dt_match[] = {
>  	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res },
>  	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res },
>  	{ .compatible = "qcom,sm8250-venus", .data = &sm8250_res },
> +	{ .compatible = "qcom,sm8350-venus", .data = &sm8350_res },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, venus_dt_match);
> 
> -- 
> 2.47.2
> 

-- 
With best wishes
Dmitry

