Return-Path: <linux-kernel+bounces-446414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F00A49F2415
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FC7165265
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0469418D63C;
	Sun, 15 Dec 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1zmE0AF"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D7A18871A
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734268249; cv=none; b=Z16Slo3WG3Q+m9hGLuSUcqYdL/ZSiN+KVKfkLOHd9E9+RFG+9lb6JzTKVUcSTEFzvxsKPeK3acOTywG5AlsR9s/jfrcpWGv30sDOMa9rAIrNtWogYp19K1EsUaUpWIOg7gFAfMzgYE+zj/bIcn54CeK/ERZr+xrhqGytcwOsk1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734268249; c=relaxed/simple;
	bh=PAo7FhFxwzMLaxoUpdFn/FjW4BmpWBiuIFDN3uQ1XY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeWBqLoFUCa2NnLL1WCGLJcL1Rq2p61hAnVmsBGGNZ1idOd2jfDAtHYaeupeprTi22U2FRFRO4xJA/HTA2EN7HY2RGywH5MPT69/BhStH7F/7ZLiEGpnipCZP717+LTtXVc27MAmZK1I/dAcK5LD+1g2CxZUAUdLsHJTjiKDpGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H1zmE0AF; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e3778bffdso3470358e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 05:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734268246; x=1734873046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ju05ziYlwbIpCgtx0Bb9FPQKa5IBD6RMSsDPSFRI4ws=;
        b=H1zmE0AF6xWaMrftLi1sRWBIyFxzWFB35T6q4f78ham0tjMVAIwEQvsyIEUY1YhBDQ
         pYg/4OWKsTw1n96UVmDtyJsnS9bLfbHzt9CE91wIbjs0AXLofYtSqPsvlrlMUWXsn45c
         QachHyGpbf2hoO/de2VtltTzYCeqxRfYxOSFU0Tx61yX7ZFEOHqYrzF5a/i//XuKTjKZ
         FLNE4/ld4GV4A3Q6CxCzZky3YPecqOIPlhesVUR6fiL021vDNIG9Zoq9SAS/a4ZCjrwE
         giztJnx7yNcqa5/hjtKaxsWuEvCrYDZPhMXgL6/2VJh83/GiyQmnVvcig3pjoAJiD9GZ
         ssnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734268246; x=1734873046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ju05ziYlwbIpCgtx0Bb9FPQKa5IBD6RMSsDPSFRI4ws=;
        b=CrTQqkemjD7BiwynCmVsMFwTfi8ulL3DoP8SaCfQIYg+zPmsRcxvHB9weF/gB3ceJR
         7OJMtEZWNhb7M9AGo2ANh9W9NiU8KwOeZ5eF1mkYhxb5C9aUFVC91fFIkqj/hbTtfycw
         qxceGWcSjdVmtxg29zm30v/2lumYayOqZZMqp652di4zMpBOKXbv2+8jcDzd/4yR+f1M
         ZqY9D/rOmwCcC4X/tCp2yLEnJh8zIWGL5mjKi9v9BF3fr8kYtx4AaSXeBv8dW1DMWE/P
         48jqbz+mjPHnW5IpuhSW/7tRtMzIaykTIa2a12xF41250+9J7/0Niw51aS3RPTpAidRZ
         pVQA==
X-Gm-Message-State: AOJu0Yyo3KE7Y3An0lCyqiip6S+gIHbXiXbZRdFzW5sPrgg8Pb1mwMIj
	nB/qOV1NfruryqPqCE29sfj8N4nOSOxpA5NVWtzd5h/CvHR82N3q00GPR9Cn+68=
X-Gm-Gg: ASbGncvJKFEfL6/xftUyJYblCg5MZ5YS4PYfsr34PUBZU47ZP/fF5u0fvih7MGK2ZUe
	AxKHAOtWrcfcwyzoA0lXy939IvS6lTWRRuAM8NBmZgo93ANmL6rmQgkxyD7JY71+W+cQDOgXjDa
	9LzhPcfBTg1z9W/i3uR0Isz2kSQbGzqb6EVxKxaoCX2+pGR1lOXmL15d74ylGupRk3NCh6GgxRp
	cZBqly3PgDa/y29IiMFaIrlPznZnAoaKJGO4rveZScyG3Vfp0JLAsBpxyDlvQRMJg/EyC+G
X-Google-Smtp-Source: AGHT+IFk9r/owQGni/IpvIbzf9xRA6qONzpZz70R2mTsMxoKxfWh5BJOntsOsl8hiRXd0joBI6OGdQ==
X-Received: by 2002:a05:6512:1287:b0:540:1ca7:4fe9 with SMTP id 2adb3069b0e04-5409054e4b0mr2641383e87.22.1734268245751;
        Sun, 15 Dec 2024 05:10:45 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c00262sm496316e87.138.2024.12.15.05.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 05:10:44 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Connor Abbott <cwabbott0@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 0/3] drm/msm/mdss: rework UBWC registers programming
Date: Sun, 15 Dec 2024 15:10:39 +0200
Message-Id: <173426667308.2196979.1702626124443847535.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241127-msm-mdss-ubwc-v3-0-9782a7c2b023@linaro.org>
References: <20241127-msm-mdss-ubwc-v3-0-9782a7c2b023@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 27 Nov 2024 16:04:31 +0200, Dmitry Baryshkov wrote:
> Current way of programming of the UBWC-related registers has been
> inherited from vendor's drivers. The ubwc_static was supposed to contain
> raw data to be programmed to the hardware, but was later repurposed to
> define of the bits. As it can be seen by the commit 3e30296b374a
> ("drm/msm: fix the highest_bank_bit for sc7180") sometimes this data
> gets out of sync.
> 
> [...]

Applied, thanks!

[1/3] drm/msm/mdss: define bitfields for the UBWC_STATIC register
      https://gitlab.freedesktop.org/lumag/msm/-/commit/43eb9a8a372b
[2/3] drm/msm/mdss: reuse defined bitfields for UBWC 2.0
      https://gitlab.freedesktop.org/lumag/msm/-/commit/2cb62d9f9cf1
[3/3] drm/msm/mdss: use boolean values for macrotile_mode
      https://gitlab.freedesktop.org/lumag/msm/-/commit/dc7b16a4f055

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

