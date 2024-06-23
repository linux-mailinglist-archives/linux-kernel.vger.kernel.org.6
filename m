Return-Path: <linux-kernel+bounces-225971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF15913890
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 09:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F9F281E8D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897C44D10A;
	Sun, 23 Jun 2024 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJyVZN+J"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E774F6EB7C
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719126856; cv=none; b=qGCXSOhgj+jl50jdd9mKmHCKf+ENihQncUuv8Q5w2ltGt/2h2TWiLWrgNElYOjxHMTCJx8iuxI0i+t1nTUbkuaBl9Ek4dcSpyRpNhWC+/Yk4lsBIhKZ7NEXKIOVwUe4HqEBZ0X1VUAG5v3Emel1TU4xg15Y1toG6s3X9EHEuCoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719126856; c=relaxed/simple;
	bh=ScNvpn6q8Btg9GUETewQRHhi5kSZsX/tFN9YxCs/Erc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVqzjCyAqMcsAJCpPT230ViMsyJoNixVuD2CFr3nH9e1hq+CU0rJg8TG896jcYaw38QezpkC8kbX8pqKRCAhD71AIV04Mt+HpsDYVJ0XaZE9LIkzsr7wXQQ/KTDfI0kV+pM8mmbUx8F1j5O1FMlsL9S8U8ZxFcZLVluR8Rn3al8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dJyVZN+J; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so37196531fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719126853; x=1719731653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdK+Z57kLe+iVSXD6oAbe65mu24X+W08m/s2wPEPRiY=;
        b=dJyVZN+JRGf20oXp08xdfG3HiA/RsT99nCo1SdogdEorSOvy/EWmhZ6TFHk36dnfwT
         1rHWr9ClbyrPLVfqPWwPqY2AGhRTk8AkwaguVhv2dghzpr+Oenz8fSXu4PEHJ1chAHAH
         RHtz4d39bMs+IcShMhWimOo/ckVdFq7Nh1DExB9h2wrOGPDS/MZk6bVvBK+rEwQb7Dz/
         u8em779APPyXbclF3ZBMDw5yTdMZyMqjdOKFafpNhDb2TdzVhv+hI12w393RNCH9eMie
         hWo5qwlTUaPg+0QbsWVHrMcbEPlO51IhmeeGSQ8qjUcdQ9xeLJ/lPrdgEsjFufxnyGZX
         S9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719126853; x=1719731653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdK+Z57kLe+iVSXD6oAbe65mu24X+W08m/s2wPEPRiY=;
        b=ISNEX+IhWxNWbuwPvajiYfNFpMdS6OwggwK+csMKvuSamK4ZIIqYJAOGvuUb1xn/UW
         srxbAMk5CFnJZwd2eap96g091Zom0tlx7wce0yHH2Eb15tTV31r2Pcf6q7ZDZMg+Kpgb
         iFokIHBrqPzy16zySnuC9rn5tKfRsjBbq7u2yMmrkRV0Lp/1K/QZDAtoqah7G5xu6cT4
         qEo6v4wdPTIIt0xAcleett7Go3pisuiRLPFNOJ0Ozxhc3uwy2ATwqa+SCGDKa0NTG5jj
         wDI1bqpk2d84lixgq1BALrAMCN3U5MXugpxN0wQNN7rW2dYUZYwKyVYPYnXfMZaHOw8J
         hm3A==
X-Forwarded-Encrypted: i=1; AJvYcCVyVVBjn/jxzGuYRlJuVm4YCFx3AihDav88zfztf8xtVp12WICi6b3k+UbRZSSv5CJy/BZTGJ3QJFOhf2GZuVApfCiRw6H1lVHRPXUg
X-Gm-Message-State: AOJu0YyEPrBG5K47x/7VtMnYH5E4zdTSA29LoOMmHsnBGjKFCviqtwWz
	SMi2jacrLcWm4dY1sI/xwWfv3wq2479tgLRBQtES8hHuIpr7un9GyZVN721dh/c=
X-Google-Smtp-Source: AGHT+IEKqxbvtWfQPSdbxyZOKoTKzOfta9UYAGWkjh4gPijepxo+y2Odys4DRzztDMFEyCfQKNkPDQ==
X-Received: by 2002:a05:651c:152:b0:2ec:5603:41a with SMTP id 38308e7fff4ca-2ec5b36b266mr7424131fa.2.1719126852954;
        Sun, 23 Jun 2024 00:14:12 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec5b031208sm1886861fa.26.2024.06.23.00.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 00:14:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: robdclark@gmail.com,
	quic_abhinavk@quicinc.com,
	sean@poorly.run,
	marijn.suijten@somainline.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quic_rmccann@quicinc.com,
	konrad.dybcio@linaro.org,
	neil.armstrong@linaro.org,
	jonathan@marek.ca,
	swboyd@chromium.org,
	quic_khsieh@quicinc.com,
	quic_jesszhan@quicinc.com,
	Danila Tikhonov <danila@jiaxyga.com>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Add MDSS and DPU support for QCOM SM7150 SoC
Date: Sun, 23 Jun 2024 10:14:04 +0300
Message-Id: <171912674297.840248.14141240302342567945.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240614215855.82093-1-danila@jiaxyga.com>
References: <20240614215855.82093-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 15 Jun 2024 00:58:51 +0300, Danila Tikhonov wrote:
> This series adds MDSS and DPU support for SM7150.
> 
> Changes in v3:
> - Swap DPU and MDSS patches (Krzysztof)
> - Add an explanation of the abbreviation DPU in patch 1 (Krzysztof)
> - Switch qseed3_1_4 on qseed3_2_4 in patch 2 (Dmitry)
> - Drop LM_4 and LM_5 in patch 2 (Dmitry)
> - Add Krzysztof's R-b tag to patch 1 and patch 3
> - Add Dmitry's R-b tag to patch 4
> - Link to v2:
> https://lore.kernel.org/all/20240612184336.11794-1-danila@jiaxyga.com/
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: display/msm: Add SM7150 DPU
      https://gitlab.freedesktop.org/lumag/msm/-/commit/64e2f4cb27e7
[2/4] drm/msm/dpu: Add SM7150 support
      https://gitlab.freedesktop.org/lumag/msm/-/commit/75079df919ef
[3/4] dt-bindings: display/msm: Add SM7150 MDSS
      https://gitlab.freedesktop.org/lumag/msm/-/commit/726eded12dd7
[4/4] drm/msm: mdss: Add SM7150 support
      https://gitlab.freedesktop.org/lumag/msm/-/commit/0f4786881281

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

