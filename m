Return-Path: <linux-kernel+bounces-535589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35C4A474CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66A616FFD3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7739231C9C;
	Thu, 27 Feb 2025 04:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFZgYNSD"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D78622FE17
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631086; cv=none; b=DFQgZvCVQ9luu3loM5uH8AC81d3JwkAgvQtRWKYf4mYIa5zXsz9sadUxt0TNgF/P2wVh1XfCmJqB+JfNhtbZg0Ztg/8VEP5nFirTtHm5Bwep7DFrrvi2V1Kpc/IAix64kEDaYFb6nQym6NXshw1irElpAJXF0lBH8tNw9ywAg6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631086; c=relaxed/simple;
	bh=YXqmUW/0eh8jEOcE7CvrKP8PjkOyelgn6yR8rLddqH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uykUJpHXvvCebWjirqui/ps90S139XsNK7fgJAqjf3JJSgw3ajkvyraX1+EKT4DQjGqFbJYOGLtFt62gGf8eQ+gu3Pi2KwOWrbUxgYzzGzYmtNBdp0TnX0hW+Pq7AfJPou7AfBV6PvcXcNEI8Pdumg8uSJcHrrzCAFBTOA4WR3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UFZgYNSD; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54943bb8006so477876e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740631083; x=1741235883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mpbDw0Fet6YkuQYRz4hIjFDxEEh0ZsoMbrqLONn3kY=;
        b=UFZgYNSDBliPgZdMXKOosm2gUhY9ItPevMX0rTLqJvHymcWAPCJt358hc6G5x2b7vc
         57y1BSsrfNLkGbY/IUhd8E0Qnc2O5c9CLC7WzxSe+q4DlOD3fwcL74Cj7Y2w+OtWGHHH
         C7q9esHTgVONxV5vTJWGTZac5FIUMRbAV9vXMSk2vxbmBEsbwUCiNHdqzEPL92YqrZ0V
         5kdT9gg+0/wJdBit21PHpZvIZJMr8yHc/TMqkbTKB1dBq2WiM1JPec9ds45X3D+MbiZY
         /hkFA40KFiX1z6v84ZXV5m2sa0BOtLeTsp4XLRXR897zhpHl4h0RA3XRA+soeQ16y7c5
         6ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631083; x=1741235883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mpbDw0Fet6YkuQYRz4hIjFDxEEh0ZsoMbrqLONn3kY=;
        b=xT+Z56PSYGKTi4IAKZQ7MEtYKt9t8puVOCLh9sLa74gi3VJmcnZ6zIMmcdxclSBjnQ
         acFqXvHb2KvhtIBhvJR4OC63v5xB4LLlJi+qjWcIkljCkayE3uorBFlpRnv5szdnAeig
         UHi8GQt0EH4zRvsFrhZPKMNoXAakI4ymDtH0o+cCgizy+tsRof7dOEi/4Y303Eai3bE+
         +5jBLYJgMHS5BNv26P+BHPa+nucnrk5J2CWAJm/dCv2OisBqtcX57J7UgbLfQlV96ri+
         W6F2DBQG/vpgcJP2zhO+LICtO8PQ7f7B6tnIf5KZhK3AcDRksxD0VrQbSODpysUkoEkw
         E1pA==
X-Forwarded-Encrypted: i=1; AJvYcCW3Z7pKTE4u1wy+KcVPmNXGXd35duDF/4PS46LnkEwd3S47vAi7jknJXBkQzOSrgRpPLX9Nw2y2J41HOSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywFBoF66kpX/e0Fwo/7UXYWixMD7WOcENVTO2ySTBm1Ure7OFz
	EbbY7wniO7f+nDzlsFISN39g2ddbwAWb3wHQ+37QM7sDCOsEOngfdcr3ymMVHO4=
X-Gm-Gg: ASbGncsXVnfbwfnLfpuzHKJftFR0nbxlPc9FJSsRdmFJjN4WLvgoeOsS7V0hEEkhOna
	ODG0Rzv4JG3y/gItjOfNnVRKO8Oj5QbmUnh3gDvBygg9Khoi5Mkrm6I9dIM5mPwF2Tyb35OsAI+
	mM7g2upV1cGSdUMDthfVwOHqx3rxykZNZ7ZN9wUoJo8LR9rxC6CNmgt8R0/B+XzzW3dgmmt0WCK
	tr5ydMYhWJ4Ku+B1+iThDdEspA7Gnp3k0osUMA1pSRpGrLSzr2Qx/HaJ8cYhww3fFWUeVDfmsZe
	mXVafPsBvYbiZstbboq1jj1m3uEx7QSIuzqL2I4y1g==
X-Google-Smtp-Source: AGHT+IFgxjAKrvkpIGrRkJYBcLkZa/TaKD/dJweGI7YYBbQ4EzNsK1UsZ/cS/Ce561pRPgFymoguLw==
X-Received: by 2002:a05:6512:3ca9:b0:546:2ff9:1539 with SMTP id 2adb3069b0e04-54851109cfcmr5718647e87.52.1740631082596;
        Wed, 26 Feb 2025 20:38:02 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443ccf45sm63485e87.229.2025.02.26.20.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:38:01 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	David Airlie <airlied@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Archit Taneja <architt@codeaurora.org>,
	Hai Li <hali@codeaurora.org>,
	Marijn Suijten <marijn.suijten@somainline.org>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jordan Crouse <jordan@cosmicpenguin.net>,
	~postmarketos/upstreaming@lists.sr.ht,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Martin Botka <martin.botka@somainline.org>,
	Jami Kettunen <jami.kettunen@somainline.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH v3 0/3] drm/msm: Initial fixes for DUALPIPE (+DSC) topology
Date: Thu, 27 Feb 2025 06:37:32 +0200
Message-Id: <174063096231.3733075.12359628764026922067.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250217-drm-msm-initial-dualpipe-dsc-fixes-v3-0-913100d6103f@somainline.org>
References: <20250217-drm-msm-initial-dualpipe-dsc-fixes-v3-0-913100d6103f@somainline.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 17 Feb 2025 12:17:40 +0100, Marijn Suijten wrote:
> This series covers a step-up towards supporting the DUALPIPE DSC
> topology, also known as 2:2:2 topology (on active-CTL hardware).  It
> involves 2 layer mixers, 2 DSC compression encoders, and 2 interfaces
> (on DSI, this is called bonded-DSI) where bandwidth constraints (e.g. 4k
> panels at 120Hz) require two interfaces to transmit pixel data.
> 
> Enabling this topology will be hard(er) than downstream as hacking a
> layout type in DTS won't be describing the hardware, but "dynamically"
> determining it at runtime may pose some of a challenge that is left to a
> future series.  Such changes will also involve the 1:1:1 topology needed
> for constrained hardware like the Fairphone 5 on SC7280 with access to
> only one DSC encoder and thus ruled out of the current 2:2:1 topology.
> 
> [...]

Applied, thanks!

[1/3] drm/msm/dsi: Use existing per-interface slice count in DSC timing
      https://gitlab.freedesktop.org/lumag/msm/-/commit/14ad809ceb66
[2/3] drm/msm/dsi: Set PHY usescase (and mode) before registering DSI host
      https://gitlab.freedesktop.org/lumag/msm/-/commit/660c396c98c0
[3/3] drm/msm/dpu: Remove arbitrary limit of 1 interface in DSC topology
      https://gitlab.freedesktop.org/lumag/msm/-/commit/d245ce568929

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

