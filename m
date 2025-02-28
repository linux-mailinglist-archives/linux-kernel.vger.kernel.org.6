Return-Path: <linux-kernel+bounces-538021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40458A493A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED3E165F63
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B2D1EFFAB;
	Fri, 28 Feb 2025 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ke0jKEpS"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E82505A4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731701; cv=none; b=pU7/R8QqHPwv3BI78cGS5ftYfCXT+yaGJ8reNcyHiO/L7UcqQwGzqZ5GWBLa0m7JKMky4xi4N8Cb3/cuhS3Z+e1pMSbk2offL2ZJhMlR29dyolqgG0Rhu025UoDsEuDrSyFz/Ztt71DYf78cBVE6UXNM1lF48btlnT6VwH+Cpdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731701; c=relaxed/simple;
	bh=DcH6u2XgobX20/XCApb6BtM0I4uBXU2xAeUfGr8Kx4A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pMVqsRiuFs59EFgC26gN9A52RbLkhQcLDfWJmJS5FGdwFPwInwqnYBWpwwZatlCjjB1lTAc0Etd1iKRTZiOc3wEh1SdzU6htWmzbWD2b0AepndmwBUBOWNRLbcKUvyVPxdAVbEJIxg2/KnfPA5EghlUrUXSgzFh0pwCDv2I2T3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ke0jKEpS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4397dff185fso16249635e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740731697; x=1741336497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORkzKEvck1HQHJSDGsDM0EnateW6ppAyaVvLCKXR2rQ=;
        b=Ke0jKEpSSttHS+KuMGVC1nw4820OGKW1fX9k229myq3JbkA34mJme29KILFPDrABYl
         zaN9iEbchFlSKZPHPAIUDjCFii8e4XQb95MWc/g4CSrd1oaNDVQsia4U3/cnm5xYbs9w
         /P3N/8xIz7TAN9VWR/UtGXiRgMuaJcRzBAPFS96r5yHykq4enlI9xrlwTNwY1lfEdlVa
         zD7GezktPmCdwrV/ydWAinIqMuGjE8Xpj/oac1vKlIEIT8S8TbIanSRIFmn0y8IuXRnz
         jQiFOBMsL76EbXPhSkD5jfhlFfSQ9C+9dQzQnIbPOSruNTfS8Tz8/QH+d3WuCuI+gMk7
         GxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731697; x=1741336497;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ORkzKEvck1HQHJSDGsDM0EnateW6ppAyaVvLCKXR2rQ=;
        b=PsEtc7UFFRCkTwm7VoDPlfr8WLcpN6ofq8yjKO5Efgi+dc9GFPUc+fA09AsIAHM9tz
         P3h6h7QJi5W/f1UHBd2im3vr2FRKtNG5rC56dCW11Mqh426wtPGgZlROCVVyxikfkWvs
         cOQnGENmejYjws1epikKh6aGpM76D92zhZfcQRZlFMhZxJQgSSDbXmtYbMOuhj6qY8GX
         RNSd9ChyJy2ivu6/N4FmKKfNdl8tvkHjAnHQ4UXRgJ5HPImXJla5BKNlhPCGE761lCWv
         6/Zh2AL3RzUl2DBECWD7mSqY7eNDeg2045wy/OaP18atWMyPTmrjB4Mg2TI+XExAH/qp
         hh7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTptOE9tfqJjbIQNrhtkABSEsWXkUQahWhnJrOvYb3Wta0meUBd/aD/MoLyv5I49fzne/dNf9uVlT8XZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3wOIS26bKDBOV82JgHML+SsEJYSfhDQSYkaXRlNJPaAghxgf6
	7FdAE4zlrIuK5aIh1dGrRwixA7LTukqD/h27wprGinmlKNyqf69HtGJKuKPptcs=
X-Gm-Gg: ASbGncvpIv2bTesKYa124jN++EDZljR4uKOqR8nlch0KkFsG+AjQlaTyS0h6uc/Eht2
	V2GCUNMbliFvE4L0KWsQ06/I+DW7sB5SXTpW1UKUtlryrYRJn2BYIXWA/DGj7AQhy5rMsro6Wg7
	iYkDVgRbm7wsDoWz2mPN6xrTicIcCggXiUCqHZHJdhtYvC9GLNvn/RT+QJj+MJuSuJsELxw5rkB
	aZfHpHhcgLeU3m2sOPfZB+s3ZyJHCwui6heu7rczKYo4QdrQtwDUjW8oPxY+J9YstEv8o1wzPhN
	FN3jloIh03QOmwZlGpK7gUJyXbHjuWdT2M4Uxz74P86yCSRfDSHXIqJZb276qcGW/9Vbixm2QeI
	TVsw=
X-Google-Smtp-Source: AGHT+IFdmFEna3crd/T/BTFxEG6Spc/EH5R3cReUqC66z3dsLR8Peke+TaeF096gTUqsxyCShEVirg==
X-Received: by 2002:a05:600c:3590:b0:439:33dd:48ea with SMTP id 5b1f17b1804b1-43ba66cf24emr17659275e9.2.1740731697410;
        Fri, 28 Feb 2025 00:34:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c728:ed22:3bb8:f351? ([2a01:e0a:982:cbb0:c728:ed22:3bb8:f351])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6d31sm4394392f8f.42.2025.02.28.00.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 00:34:57 -0800 (PST)
Message-ID: <15e62852-c896-4790-9de9-835136d30df0@linaro.org>
Date: Fri, 28 Feb 2025 09:34:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/8] drm/msm/dpu: improve CTL handling on DPU >= 5.0
 platforms
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/02/2025 05:14, Dmitry Baryshkov wrote:
> Since version 5.0 the DPU got an improved way of handling multi-output
> configurations. It is now possible to program all pending changes
> through a single CTL and flush everything at the same time.
> 
> Implement corresponding changes in the DPU driver.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v2:
> - Made CTL_MERGE_3D_ACTIVE writes unconditional (Marijn)
> - Added CTL_INTF_MASTER clearing in dpu_hw_ctl_reset_intf_cfg_v1
>    (Marijn)
> - Added a patch to drop extra rm->has_legacy_ctls condition (and an
>    explanation why it can not be folded in an earlier patch).
> - Link to v1: https://lore.kernel.org/r/20250220-dpu-active-ctl-v1-0-71ca67a564f8@linaro.org
> 
> ---
> Dmitry Baryshkov (8):
>        drm/msm/dpu: don't overwrite CTL_MERGE_3D_ACTIVE register
>        drm/msm/dpu: program master INTF value
>        drm/msm/dpu: pass master interface to CTL configuration
>        drm/msm/dpu: use single CTL if it is the only CTL returned by RM
>        drm/msm/dpu: don't select single flush for active CTL blocks
>        drm/msm/dpu: allocate single CTL for DPU >= 5.0
>        drm/msm/dpu: remove DPU_CTL_SPLIT_DISPLAY from CTL blocks on DPU >= 5.0
>        drm/msm/dpu: drop now-unused condition for has_legacy_ctls
> 
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h  |  5 ++---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h   |  5 ++---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h  |  4 ++--
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h   |  4 ++--
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h   |  5 ++---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h   |  5 ++---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h |  5 ++---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h   |  5 ++---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h  |  5 ++---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h   |  5 ++---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h |  5 ++---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c          |  6 +++++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c |  2 ++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c |  5 ++++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c           | 20 +++++++++++++++++---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h           |  2 ++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c               | 14 +++++++++++---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h               |  2 ++
>   18 files changed, 65 insertions(+), 39 deletions(-)
> ---
> base-commit: be5c7bbb3a64baf884481a1ba0c2f8fb2f93f7c3
> change-id: 20250209-dpu-active-ctl-08cca4d8b08a
> 
> Best regards,

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

