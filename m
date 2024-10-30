Return-Path: <linux-kernel+bounces-388576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 214B69B616C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14A21F245CE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE2B1E571D;
	Wed, 30 Oct 2024 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSg/orIa"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8431E3DD8
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287554; cv=none; b=D6DvmjkRPaRT0rYTNNJ9JSfAAk+RL71u0H2oDBkQWTcqW1U1RdiKXrSlGLOUlMfdEVzkJ5GCoFJNr1BufNDXGuaBtBUCdv+ixjpWzF3/rGuzs4rAP7ShVv1bzYH2ZPV6dF3nHgDEgnoEk7iTi9e0FHFCpjRVFmWdyLfClno0HAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287554; c=relaxed/simple;
	bh=i/1lFAiCUmr8MozzsQANkNXi63EHwNpndZyFrvfM+q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFo+uI/3vVEi/gOk1zyZm2kQabLZo+J00XzjudWlr/wNINMh2m5ytfcmcsG3uNE24ItA7pgKXNAeRTets1yuEfbF2q1j4Xc2hQheGuxomgTD3jVhlFRdLE7PvSSnIQBM8COuJ1Rit5yVz4lsjeGxGcE7YSK7uy1/Kwia88J9djs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nSg/orIa; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso50614071fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730287550; x=1730892350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMES1QAhfgu7bIQDYk1EUlu+RGSHNt1/K65I4mR80e4=;
        b=nSg/orIadb2AFsxHM/8a2bnuVpIJtpt1I/jLdUgXg0ikJ2Zb0/6vlOCt6wm3RwxvBd
         qp6Y8NKmPvGa3Ecd2LaIsO+9hiuVcCvgyreLqivSq0BASgz1nhVgR+DTxNyGp+fLDCGE
         oBWSaimrzi4dY04qOAjL91JsC6l79yiVc2g8sDy0VBDzcHCxp1H0krMx+++MW2zcT2Kw
         F7RNKOle20XqbBP8YeZHblRDncG6VgqgjSjTlN3kEPMAwFXHkySUjA0Aftj1nFiqJYp9
         NONH3uUgLzsXeJpm2Pf/hGsBwu770BsavmjDpF0L/9ecMmfwqZ8NiDRMXeTwYdwC6NUU
         2D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287550; x=1730892350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMES1QAhfgu7bIQDYk1EUlu+RGSHNt1/K65I4mR80e4=;
        b=nkWdes3/v/Cys3fY5ZGC+ExThNdgA+gL+EMSLb2EOqFrc9AQ3zILr+UAfefA6JGaMK
         Uh9O3zP/zF8LZyREjQR/JB8gHCaRCe9Zy+/f+Mj0ZeF/KFjhKoGQVLI23WJcR+nEC8IO
         Fyk6uJU+3CKkiq7edMUBQDR4628BAvuSyGrbOWI+1CpdMBw0UTXntjVcnkUZZTvBtGq6
         aQqB00H23Ij/V/FIM+PzwpylV8hqg73TCuRlQqGiy4owza7bZoUutkZ5G5LR3OnfpV/A
         mn8c8mynXIUWagOyTpldItOO0VtvUvC+s5ncbiLt80pRJgFPPNIIn2U86Fuvr02vNrKX
         IG3w==
X-Forwarded-Encrypted: i=1; AJvYcCVdv93KFGwSI0qtykzd3xD+Tvra3nq2Zuz3zX2B7U+4o6aHJU5B/XiyuYIthWz6FRtg/nP7U09n8UcNsSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXAkkiGHSYc7KYit/z0slVgGIN7CRTl+39V+UmgPXu09/fqNLq
	cgwxE0M42410lrymCby83yegyJFzAyHbWGy/PPHxooVYkEGGwacU0Ln/lK+Jamc=
X-Google-Smtp-Source: AGHT+IGY4OdrV2g1gR/OZMrvjE/lAI6jJHYq/NY61VEtXYCuq6a/kfZIDfbwe86CLVK3+WjNbtSP5w==
X-Received: by 2002:a05:651c:1508:b0:2fb:6465:3198 with SMTP id 38308e7fff4ca-2fcbdf60348mr75079871fa.5.1730287550241;
        Wed, 30 Oct 2024 04:25:50 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9207d4sm18412585e9.20.2024.10.30.04.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 04:25:49 -0700 (PDT)
Message-ID: <436b02c6-a262-4015-92e3-454d444e877f@linaro.org>
Date: Wed, 30 Oct 2024 11:25:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] scsi: ufs: exynos: enable write line unique
 transactions on gs101
To: Peter Griffin <peter.griffin@linaro.org>, alim.akhtar@samsung.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 avri.altman@wdc.com, bvanassche@acm.org, krzk@kernel.org
Cc: andre.draszik@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ebiggers@kernel.org
References: <20241025131442.112862-1-peter.griffin@linaro.org>
 <20241025131442.112862-9-peter.griffin@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025131442.112862-9-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 2:14 PM, Peter Griffin wrote:
> Previously just AXIDMA_RWDATA_BURST_LEN[3:0] field was set to 8.

where was this set?

> 
> To enable WLU transaction additionally we need to set Write Line
> Unique enable [31], Write Line Unique Burst Length [30:27] and
> AXIDMA_RWDATA_BURST_LEN[3:0].
> 
> To support WLU transaction, both burth length fields need to be 0x3.
> 

typo, s/burth/burst

