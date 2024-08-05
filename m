Return-Path: <linux-kernel+bounces-274258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348979475C2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6542E1C20D78
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EB41494B9;
	Mon,  5 Aug 2024 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWR6pc4W"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2504A1465A3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722841779; cv=none; b=KN3w6eHk+JnKXYzbH30nkhqyja7/zZiiC+Ioi50kYZFhLDgyhDr5bYHZpz8/qB5umTjcHlkfaYbflU5+xE23A/z4yOWFceoyJ/mJ0cyW5QgxFxVsEHeaOVpiaEOyIEDevAdnvtCBV/Op4BpFN6+YJhauQxGVXLFstZLS6eI7e6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722841779; c=relaxed/simple;
	bh=yVwcVD7Xn+Cm9X+VuSEAjO29KUBpGnrQh6fHfuhfBQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bY8ypdVRBFLgGSXONl5asmZLmgEixsXAd/baD5gkYchBNgmu2AlnG5D7GK5yQ8tJbRja8F1ldyTx2D8EZ67m1Eoxl2NDTM3r/WmKsR7ZY7Em13qUMZglTny054/7sV57nqFQpktldUeMHGNnMu7ja0qRIZc5kRSjKZhIB6b9Qj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FWR6pc4W; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef243cc250so19238051fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 00:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722841776; x=1723446576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dhjgNoYXL6CCBxOF23Z0ViDRqzy0AERmoqKNZ6NN4s0=;
        b=FWR6pc4Wda7LFQ8Ma2VtNJLdcVaIn7p7h0CoMk3J0A2Jiib/nNoOnZVXnsxdqibe0T
         1umO/HhYkVJ315/VD+VMfji06quVEYEp6tRs/aNAfJ3Jm2poD3BKZw9vH8OIjLfkcEF7
         mpzAiMxwHsBCOhBxPqGRPO2/0FLUMY9vZc3/TI4KknbfO/PohSWAlpZLxESOgpOi57XA
         rPIFS8+tkdSTWMJf+98cVE6u2n1vQn8w0z2GX0joUHrwXXoiTouFu9YPN+JcEd3eBQxn
         nmwsDVAzyULOPebH8EngDkkiQjacKJ46AxS/wmveAy/EBvb2eSbvo18U8o3pavEQd/hJ
         iRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722841776; x=1723446576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhjgNoYXL6CCBxOF23Z0ViDRqzy0AERmoqKNZ6NN4s0=;
        b=NSZRYQi9BpT/g2t7lN3N7V+1b+0M4i7KmIpPn14qHcKP6wGX6QFgsupphiiX4Jh4O1
         ZwYvUm/pMBAymltiGm3HkeBixoZ7Hd/7S6icydrjNt0oW/Ion+cjFk8R3O/HEAC9g1yH
         wpzCRJ5CjA4An3fIumwDl6H9lZoYwbiiuWpaOR2XR40LzTudlRepzE/OluGOkIN2GPoh
         LbWERYsLEFfR9H7+CK0sXTDbbpy+fnhOQyBrTvvh8wCK+9NuXDiAJq2JupaZyJMRmnPm
         aep5Qwhgp432/hSOi/NbxBo3gxLyvi1HErFBlYWZjis9OGWyuVcYS2CgoU0Lty6nLgxL
         cN+A==
X-Forwarded-Encrypted: i=1; AJvYcCW8SsJyoOXzoiwlDcwa1cf5vi3E709weDMF1Q7Tuga8Z3p26FLk+81e8L+wr6ipefEUDvYYyDLWOG4goyZfgAV18Au4tdVeSBXNZVu1
X-Gm-Message-State: AOJu0Yx54fpAdghhf+H2NEqTfRWK8/v5mUYh2Osje+kBim31W0ET8ulj
	ox8lRkhYFxTiYVcyi186nxnpAA/mcPbV/78OHq3pJMu6CI316OZjOLbcfPU6xxQ=
X-Google-Smtp-Source: AGHT+IFD9+QWaaf3rFR05ekcR9D6RVYzcShU82Qk5i/JTWIVasuFslXHM6RL1NBBFkMkpdGZ8j+uiQ==
X-Received: by 2002:a05:6512:2811:b0:52c:ce28:82bf with SMTP id 2adb3069b0e04-530bb3b0e3dmr3983699e87.5.1722841776156;
        Mon, 05 Aug 2024 00:09:36 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba1102bsm1028530e87.97.2024.08.05.00.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 00:09:35 -0700 (PDT)
Message-ID: <52cd30a1-78f8-4b12-8b33-eb33598b6812@linaro.org>
Date: Mon, 5 Aug 2024 10:09:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: camcc-sm8150: Fix the camcc probe
Content-Language: en-US
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>, kernel test robot <lkp@intel.com>
References: <20240805063049.446091-1-quic_skakitap@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240805063049.446091-1-quic_skakitap@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 09:30, Satya Priya Kakitapalli wrote:
> qcom_cc_really_probe() API's arguments are updated to use struct dev.
> Fix this function call in probe by updating the arguments to use dev
> instead of pdev.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408012234.vggzO9in-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202408020044.PEGwUAFE-lkp@intel.com/> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>

The problem has been already fixed by Bjorn on clk-for-6.12 branch, see commit
e997b400c846 ("clk: qcom: camcc-sm8150: Correct qcom_cc_really_probe() argument").

--
Best wishes,
Vladimir

