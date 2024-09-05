Return-Path: <linux-kernel+bounces-316270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8DC96CD5B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816D81C220D8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BAE155327;
	Thu,  5 Sep 2024 03:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r32SJqdp"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83314F123
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725507227; cv=none; b=g/dFfbuScWzU6z+aLaYGCGerLEZ1TKdVa1PmDw49qsXJTW2oMhB90o3Iu6geOuyYxaOLDoiiVArfJrDIdfydkqC0+sJEW+3+rLcHFSILDUZgWvwVK37Sr5Yk1/ZrySRYGL+Bozv4vlxBgWJ8Luwr7Y0x4q1r3Cma0886RCccPbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725507227; c=relaxed/simple;
	bh=0/AvUFM2cDr1zCzRpmVc63hjqZN3fobq0XwU1MX+OaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htMHOsUncE+4K/yr9MxLAHRArDqJRMCPe8/l3noUcH2ED1BnSl76ul2I1R5NMFz1SMOehny7S1ugozmoohp6m8CMBj9S00AWwCAiWjKejQW/xv00xJfgqhNfAvLVuV3zP8D3wlRWf3pg3CmsZg7rnTwnB0J/xO0WjtG8R0fL37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r32SJqdp; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-535be093a43so267951e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 20:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725507224; x=1726112024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YlSI06JgiII+LEbljNcOEN5o3TgCGGBBtY0a6eABOo=;
        b=r32SJqdpTNfXLhP4eW4m1COtQwZi7wb2RNJXaPAzE1pDvvVFr+oNExXScbn1t9PfZQ
         9O5zJaJ+xwMSSJI4iBaWh8UTjiNnR9PIxvRFvd5dkvuCXl5nwafFaKPn7oiQ5U/MiTYr
         kItOHbYWztd8rj7xAkV+xt/knb4swnKkoYgyJq5efMnAj2irit/moQ4w/N7trVWBKvoD
         LtlwI9wVDLUInUGfC7UhYbjWEU6OWltQZSWctOjTuf52Ay4ajbpQb7/iL2SLkC81hTfa
         /H+TXKvm3guCRaBRwUbIRFYMkMwS67jnvm99Mmt4PxmOmp8Vtb5GR0Qr1kqPU50KwCgw
         Ppsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725507224; x=1726112024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YlSI06JgiII+LEbljNcOEN5o3TgCGGBBtY0a6eABOo=;
        b=UWv4nLIKPO8GBYhOkuEb+cU9tGfb2GCvr/gFDsw3zePvDdD+4wf1Kk2L4epYogA0mv
         fcGXqBereoKKa1ATnJOukQoPNZ+rHwEwpqEOUEIwWflkYI6ikT01fDZi5hStI3RzoDSs
         xwA9GKkZthw2XwrUOA7qiPnzZ9CjRm02c6I07ZG/kvGN5Q/lHjvpF8n4CeAbtL/QNBU8
         GJiW/eGczqqmHPZhBf2USAfpeYDX0HeZFynkC30mtpxGTbbPRNWdajH70rktcpxiTXEn
         T+kcv/VcrmqOcIaKOvaldtaIhS6qsHhIqwS02PbupTxUBfSB+Rc1ulDUA2ypT/DhKRTD
         Qo9A==
X-Forwarded-Encrypted: i=1; AJvYcCUYXOXfxILRww+nzw4Q8UXfQypcMYUOgyt7d24BgM9BrKloUtX5trP0xsg1Nc9c2B+llHo4fzU6RrbqgGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xAAfrV++klJPqbq1n0Ap/TVCw5WCO2rllZYyheACQ3ICu4b5
	aTosJoE20PmEww4HUUb+4kzDQH6CJ8W2I2RvJ/MXRlzDkZ7/aQYePOBxGWIfUXo=
X-Google-Smtp-Source: AGHT+IFdiNBj+ksLwxPJ0vhztLmpIcSqtIaTKRJijHo1cle9Ai37NIz5WdpQOI5G1ytBs0bwWxqFtQ==
X-Received: by 2002:a05:6512:e88:b0:536:53e3:fe9d with SMTP id 2adb3069b0e04-53653e4015emr59047e87.18.1725507223428;
        Wed, 04 Sep 2024 20:33:43 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53565f6d409sm389165e87.35.2024.09.04.20.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:33:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Abel Vesa <abel.vesa@linaro.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: dri-devel@lists.freedesktop.org,
	quic_jesszhan@quicinc.com,
	swboyd@chromium.org,
	dianders@chromium.org,
	andersson@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dp: enable widebus on all relevant chipsets
Date: Thu,  5 Sep 2024 06:33:37 +0300
Message-Id: <172550712141.3299484.16591667475186144206.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730195012.2595980-1-quic_abhinavk@quicinc.com>
References: <20240730195012.2595980-1-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 30 Jul 2024 12:50:11 -0700, Abhinav Kumar wrote:
> Hardware document indicates that widebus is recommended on DP on all
> MDSS chipsets starting version 5.x.x and above.
> 
> Follow the guideline and mark widebus support on all relevant
> chipsets for DP.
> 
> 
> [...]

Applied, thanks!

[1/1] drm/msm/dp: enable widebus on all relevant chipsets
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c7c412202623

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

