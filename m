Return-Path: <linux-kernel+bounces-407548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6466C9C6EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16CBC1F27C84
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA80E202634;
	Wed, 13 Nov 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCraBZWb"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56D2022F1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499796; cv=none; b=pE9oXwhRI3JamwC04StiJUbgeRpDO+nir4mWPIw/soRml5ya3UnCNVGvU/MassJtidQbl02Jl4ZDxBCSdrM2CKZg6K0sS0ekBzIxMBqTlqa9qJGSs4UchMyTJupRDvPgb8lLgOvfzxQj/iOthrek/xx/GYkBIQdj9arDG/MHF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499796; c=relaxed/simple;
	bh=EVceD0P31VXbz4vdd8jXRlHujz6kNJFtT82WAlOy4pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foc2Yw2Sze2safnkca0T3r5wATDVHlTcaCLENLESkpVlHKFlEvZbotQFiHKNB/upjXxN2PnggUw0Q9ovlUwX+n5Jf8LNCzc8swqG3fuyRi6266h7TKy5WjiJV6LhLzrMy7pLZclnNqUnbbzV4qBOV9eezqfC8Xxky+DT6U1932o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WCraBZWb; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e2e2baf1087so6389558276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731499794; x=1732104594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vurz8Z4ymLq0OAC/znWews1WaS5VvMmTAw7TGG6DFzQ=;
        b=WCraBZWbKWYS/usQf/yRGlW4d3f2mqb0GlVaN/gOGJ/aOp7U8DqDgx/NQ26D2sFcQd
         zX2V/+O0sByNj9opKLk1TDOX2hR7qcRKzAJGsU1gaIWbe91PnAyq+6QjN6rEXuwWY4Of
         GUUJCAkXoexQO9GgSPZ9fAzxxsiN+ov7LZG7sG/E3OKmzPYK7iL0tsbKs3FA6qmSHUU3
         PtNh0uBFc/n9iyjvlDtFYWO044ZZXpfUGKPMh+mNHXeLmcDKWAmbPUoeQ+xHfCdnXIfV
         LZv8vfi5PJiB07PqtUiA0ZmU6Sh8ooJluHnvi29Uoy91RlJN5U7YmltfUX+TgOCjidoG
         2F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731499794; x=1732104594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vurz8Z4ymLq0OAC/znWews1WaS5VvMmTAw7TGG6DFzQ=;
        b=fLFtFTrUuYd9I54rWXIOfvEE4kceEhOA1kQm9K0ZKmG6IfNfvg0+5PcJ9UOP/nyGgq
         73U/ItRs2beeQnVdiN0n9MhXKXT9bwQlvCDE4CE4sekjou+R/6+BW/F6bp7zFv3cZTQx
         o6mt1PLWoAGk7G5t9smVvCt5MKL+Dyfln5479OOtYxRdbpV3RWMPDT9fsaLWAed7wGMP
         UWWsIeEi3WJAurmY0lNcd1O8yOFycu7I9kG8PcaoKhT4ltqH0msWA8rnKV8ruvW6Uamj
         MRp348xf166ElgEswE5Z5nveDvqiiHRaG3s10sKy0BTTTbqHo859PL8h1gDd58DloUQ4
         aPKg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+ZgRrT2dJCL0KdwYeFt8FNGnPnifWVHmkm4VCc7akRaq6n9pxRroLWf2DK48ZkuuqfF6RrVD+siVNL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylu55LbGxwW5HJOTWABLAxwQ0qfqZrCQMbbjJd0miIPcN04Flz
	+14s5Nb3RUx1zCTaBRb73l6gwB1nQNSIVIuD3+VsRsI+P7YckY9cyw/NoFTnn11ItPdIfngsKLE
	we7vpEXZxQ/5xbq/k4Sa6ylXDMgoI57jVXGqkfg==
X-Google-Smtp-Source: AGHT+IEbVbENHDimLrclLq81k2K+eV3PjRDffS3YjYrYwNAjJe5acWC3fJAW8eAeTcDDEGpWp1iOm9mjfIL5BjU6U0s=
X-Received: by 2002:a05:6902:848:b0:e30:d4e4:b9ea with SMTP id
 3f1490d57ef6-e33a1f73693mr11483612276.28.1731499793667; Wed, 13 Nov 2024
 04:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-add-display-support-for-qcs615-platform-v2-0-2873eb6fb869@quicinc.com>
 <20241113-add-display-support-for-qcs615-platform-v2-4-2873eb6fb869@quicinc.com>
In-Reply-To: <20241113-add-display-support-for-qcs615-platform-v2-4-2873eb6fb869@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 13 Nov 2024 14:09:42 +0200
Message-ID: <CAA8EJpp2MyXZ28GQV3GDgQp9uCbr4devi++nzkeHA1fk6UZXxw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] drm/msm/dpu: Add QCS615 support
To: Fange Zhang <quic_fangez@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Li Liu <quic_lliu6@quicinc.com>, 
	Xiangxu Yin <quic_xiangxuy@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 13:53, Fange Zhang <quic_fangez@quicinc.com> wrote:
>
> From: Li Liu <quic_lliu6@quicinc.com>
>
> Add definitions for the display hardware
> used on the Qualcomm QCS615 platform.
>
> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
> Signed-off-by: Fange Zhang <quic_fangez@quicinc.com>
> ---
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_qcs615.h | 263 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>  4 files changed, 266 insertions(+)
>

This patch completely ignored some bits of the review done for v1.
Please take a step back, check what you have missed, respond to those
comments, etc.

-- 
With best wishes
Dmitry

