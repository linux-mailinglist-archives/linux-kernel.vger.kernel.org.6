Return-Path: <linux-kernel+bounces-438548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54839EA286
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E5C163AB1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6912619F117;
	Mon,  9 Dec 2024 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtZQYVKl"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E187A19EEA1
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786006; cv=none; b=DhhM13oxFTr/Yp09WfcYq9qY80531C8QnBe6n8/438uYw/IRkFGP+EYh90R74ptzAnySU5iJPKCl/WQsCI3jMgj6P8QSNpxk1oWOkVN7csJmvXRpK/9G6tcIAgxuX1QnSYdT3wUohxzfGsru2wDpXLjcKhv9HKeou5KklEc6HBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786006; c=relaxed/simple;
	bh=lua3lAZ4l4B8bZAw8jb6+8ZEKV6Rbhla4NJjWekPLME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6iVifrII718BJL87JrilMQ9iLy5f2OHanJuNlDVcxrUSK+lMjsPYpj1YM4oxGCMNnn79sXeQhqhG4+Pqjdy0ehflc+JMxvN5e26zt17FAoFnSMYmeDwpbCQcA/6LkHUd8Bq7CszqJ9oBISp5ygM/QeLk+ZMRSCtxUqN73gp0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GtZQYVKl; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so2673012e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 15:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733786003; x=1734390803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kO2asNsqNAL7eluvpkUku2CKoDCb8/glpml9Aw35CM0=;
        b=GtZQYVKl5eVaqdeYHcJMmZaVlt/YqCfFMg19YU8ADpEWDo9ykEKfyV/2k9KMAmaOIi
         VIJUBKYc7tcKS1CdP6UZ8sU53QSDJ883lhc6ymcODXmT40OyZ0ih99A9/Lhgz1Hv3g6g
         W7uRg0zPFnGrmrf2cWshfKLu2c7kt3DYjWdMP83oyQGWo2t4u/ZIrSQG+qvd/k718fok
         YIt1Z1nhu1MLdFOmn8a8SjoNacS+KnEzJcVqXcrM4sJjPFssIn+14ArzVzbtfFnrFccS
         Bq5lmMXhvaz4gryTKxYOdbe7oxJr+637EpHqQElonAYRbrN66p4RDXutyfSkAAIv7LUR
         3C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733786003; x=1734390803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kO2asNsqNAL7eluvpkUku2CKoDCb8/glpml9Aw35CM0=;
        b=W6AinmjEz2Y3GcW8dHVFaat19Ns9CYVDiv5VRy6eQAYFZQpESz9pNC4uJeIsZ5jPF7
         eI37cYjaMht93VB7HciIeHfT6pX5KQrJWv09wRnTyEy8KQPrnlOCr4j9u/f/615EikHJ
         S3zf2tYDLlpxVvg2XOlgThvMlPzpdI+kBFLcObNwNID4xUSeeKeu2mGe+eUhuaEQZCP6
         Rmz7D75F+xjm6+xM9teMxJhrd35/b8Df065aHU6Gb3Siyk2aaPIsJjU9tRU+5so+E8ZC
         b5GUyOGmD1ilCoIBBwncON5r1hGQzStDV9ECQeIukb9eSwnK/3cKZADVZiIVNsZtDEZF
         7szA==
X-Forwarded-Encrypted: i=1; AJvYcCXVNOkFRAeSyJvj3S5+w9itRFYSSfX+/RTKQz8WYAcQJ742MgCp0Pv/8lnODekLMRShSgX2j7zlqWOoDEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJX8eLvOI6a9f2FIBDMLP3RHNnYq7L/12O+4/1cXMXxCO4SEq9
	+hsmBOxdQAOFAiBIxofQ1sPsNaZl5EJb/DPc7yBuz6DlMEQaf3S2RQlDAu2h7jk=
X-Gm-Gg: ASbGncucRRNzpymG1Bti9AtpOuuHMbZx0Mu4+5G9IaaNNR3ifyehjiVK5/QGzrjzhbX
	DLPc92uBetOv6HRkK4fdAs4+jTy56jlfMdxZmWV4nTgVQCjcl94fZMKYVQ4Jm+0hYwf2PCS8kM6
	WAbM4wYxtd5Rb9LRu/QHQDLqck7A6jUeSCzOG1qdrPXC2Gu3RL2+gQE0GrVK2GJ3YnKGcCYUE8R
	qFE3PRP2UZyWAiOIdT2klcL/svvFfa9UwkxLQZsBgqwWnjYbLBSLQFcE5TS3uruFyMfgSdcyJlI
	/W5nmm5SNdn2R3XCO4nGVafKkBq9809SiA==
X-Google-Smtp-Source: AGHT+IFAS1Z5WHgZqwBvaxSaopm+k8xTxDSEi+kuRvqKIcQUqZkIivnLzU/azdEntpK3zuNH1hE4yw==
X-Received: by 2002:a05:6512:ba9:b0:53f:afae:7367 with SMTP id 2adb3069b0e04-53fafae74c8mr2641232e87.38.1733786002822;
        Mon, 09 Dec 2024 15:13:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401b25b349sm687436e87.271.2024.12.09.15.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 15:13:21 -0800 (PST)
Date: Tue, 10 Dec 2024 01:13:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Julius Werner <jwerner@chromium.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
	Roxana Bradescu <roxabee@google.com>, bjorn.andersson@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, Trilok Soni <quic_tsoni@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] arm64: errata: Add QCOM_KRYO_2XX_GOLD to the
 spectre_bhb_firmware_mitigated_list
Message-ID: <wx6qbdbcrvbq34snzkxawlbpxm6vogt5ccjmdqqyazukfbjy7t@qkvax7tr27bs>
References: <20241209174430.2904353-1-dianders@chromium.org>
 <20241209094310.2.Ia3dfc0afadbfbee81bb2efb0672262470973dd08@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209094310.2.Ia3dfc0afadbfbee81bb2efb0672262470973dd08@changeid>

On Mon, Dec 09, 2024 at 09:43:12AM -0800, Douglas Anderson wrote:
> Qualcomm Kryo 200-series Gold cores appear to have a derivative of an
> ARM Cortex A73 in them. Since A73 needs Spectre mitigation then the
> Kyro 200-series Gold cores also should need Spectre mitigation.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I don't really have any good way to test this patch but it seems
> likely it's needed. If nothing else the claim is that that Qualcomm
> Kyro 280 CPU is vulnerable [1] but I don't see any mitigations in the
> kernel for it.
> 
> NOTE: presumably this patch won't actually do much on its own because
> (I believe) it requires a firmware update to go with it.

Why? is_spectre_bhb_fw_affected() returns true if (cpu in list OR fw
mitigated)

> 
> [1] https://spectreattack.com/spectre.pdf
> 
>  arch/arm64/kernel/proton-pack.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
> index e149efadff20..0437be7c83bc 100644
> --- a/arch/arm64/kernel/proton-pack.c
> +++ b/arch/arm64/kernel/proton-pack.c
> @@ -925,6 +925,7 @@ static bool is_spectre_bhb_fw_affected(int scope)
>  	static const struct midr_range spectre_bhb_firmware_mitigated_list[] = {
>  		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
>  		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
> +		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_GOLD),
>  		{},
>  	};
>  	bool cpu_in_list = is_midr_in_range_list(read_cpuid_id(),
> -- 
> 2.47.0.338.g60cca15819-goog
> 

-- 
With best wishes
Dmitry

