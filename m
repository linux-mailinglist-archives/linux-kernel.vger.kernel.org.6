Return-Path: <linux-kernel+bounces-190948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585DF8D04C9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9D31F2163E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D7D15FA68;
	Mon, 27 May 2024 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmyBspOA"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B1D15EFAE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819807; cv=none; b=SMglDl1ZU8HJLa8U5Z73k4RqplRHoMI8a86l7H7Q7/6ADGvD6jExwD71r+MHl51pDHsbp7nASbULlZuT6VLht8MkoEJKThT1Ksl0JtzGtEY7XEPCEuzVvpNityZ9zBRbb+Qz2lxPCUFd2Zv+wKNC3GHvoJ53+1D6MTEti8tx3QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819807; c=relaxed/simple;
	bh=sm44pjviolYcXIDxzIPWqNX7LR3G6mUIs56YucRNwwM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tA8gyn08QcOgeDoWXH2dx8s1O3hMWbAGL6Ko7nMXvA2XWsD6SZT0Vqy/9SDBEBoK9b9YoTSuSI3cLwJNOoIF+tdHdUoCFF3XvpzTejDM03iEnOCRYazWx1O9ijjWggYjJE4hJk22dCR6QC8uX3fgl227TLtxsI466cbf7w3lOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mmyBspOA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f8e9878514so2531692b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819804; x=1717424604; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iAFaFyYmOhcqz6/0CsRDcA375GrElz4k011ZY6EWfEo=;
        b=mmyBspOA3eSuBiQJxF5b21ZBhhr8dxl895/L2D5nwSVyIn9VFHJBCLUvZGhRGYgWi2
         IUeP/67inFCTMas9k/MFQ75kLcn2QabBmV7OKQKN7NPx8MPg/GdzepTsTqU1+A+AVVZC
         3zPSSvKZjTlpH6wqxmBJp8Gtvam0SWd684KytEqjAzRW/Z9L0vUQ8S66NYhlB1krc6FO
         SXf2iCy/ZqcXGk63bDc5lX365djnvLcNoGVbBn5MJLTRJ2sYnY8MJuFGrKkO5xQ4GmvJ
         HXV62SEhDE0b0HVAUDSA8LcuzcA5vVSbd6c/EtFTSxQLSHTj3tmfMLRorqXgwS6hLUq6
         sxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819804; x=1717424604;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAFaFyYmOhcqz6/0CsRDcA375GrElz4k011ZY6EWfEo=;
        b=RQYCHc4iCZevpVSBSEmHBeJoBUb7Wc96d00vxRNMx6PpdmzUdaHyVWp8V/m0gtunZQ
         Ncp/Y2iJjkxQwo3xwBMKTFrFpNP8TTaHax3Tsjv+KsYkKkf3IuW+3hmu4g8bU5ILinoX
         eUAfKmESEVcwKA1UUoryUz7UdyaMUjkD0xGDRHGomR4cfCiIFrQrWPhO0MFJNhSQFAu2
         csi8+Zo1VwDPZ/J4MKgw9XSakHFYfBNtOYihrOvEE/qnh3FCsaARNkC6bfcSZB0AnMG/
         Ou9rh/JuM3CVzkYWI0q2LBx+0Xkmoz0J7KMWumdLyCYGrVLuvt8JuhkcAlyQsPSaHN5o
         1fgw==
X-Forwarded-Encrypted: i=1; AJvYcCWf/+tysIcKSbdyTfYYJ3Nsnh0z25R0PGy8+Av2FDDeePwpANHN9X9Qjkbjj2Mmh3pMtlkucpecndMsoyUF8zQzjcSRM/UP9hurjvcE
X-Gm-Message-State: AOJu0YwCSce1L844bO7I+T3Tliko+4bmFF+iOia057ubdB3TI+Srjgcr
	KBdZlhZAsMSHeQitv37dk3MZBqr2Ll0OoQIlLpfli77GW0gulrOHWJoKCW3Fox8=
X-Google-Smtp-Source: AGHT+IFc1iZS9wh9Is7k3xcIqgtRRQ9HCmO7nnfXJHnANhfsUFqEtGfj2zZjpZvOYRWLoYWyCsnRkg==
X-Received: by 2002:a05:6a21:788c:b0:1ad:746:b15a with SMTP id adf61e73a8af0-1b212dfe3c0mr10634192637.47.1716819804334;
        Mon, 27 May 2024 07:23:24 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3eb67sm5109895b3a.19.2024.05.27.07.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:23:23 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v5 0/6] Add DSC support to DSI video panel
Date: Mon, 27 May 2024 22:21:46 +0800
Message-Id: <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-0-f797ffba4682@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPqWVGYC/5WNQQ6CMBBFr0K6dkwdC1FX3sOwADrAJELJDDYa0
 rtbuYGLv3h/8d5mlIRJza3YjFBk5TBnKA+F6cZmHgjYZzZo0dkSHUw6gZc87fIYInsK8Fp0FWo
 mcIBIiFXVt3S5mqxZhHp+74lHnXlkXYN89mJ0v/cPeXRggapTZ8vW2bPv70+eGwnHIIOpU0pf3
 zrF6tEAAAA=
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>, Jonathan Marek <jonathan@marek.ca>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716819804; l=1945;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=sm44pjviolYcXIDxzIPWqNX7LR3G6mUIs56YucRNwwM=;
 b=Y7rs1ciLUI2OTmqboUiW7dxJf9Q6pb/KA0uo6G1fDAJQXyvhmaXXXIms5PqaUjuLCg25CbPC2
 EME/sYC6vdvANroYFAd+6OSoTIRc5PdTNpMDjVmlpTO0yp1OBddakzz
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

This is follow up update to Jonathan's patch set.

Changes vs V4:
- Polish width calculation with helper function
- Split cfg2 compression bit into another patch

Changes vs V3:
- Rebase to latest msm-next-lumag branch.
- Drop the slice_per_pkt change as it does impact basic DSC feature.
- Remove change in generated dsi header
- update DSC compressed width calculation with bpp and bpc
- split wide bus impact on width into another patch
- rename patch tile of VIDEO_COMPRESSION_MODE_CTRL_WC change
- Polish warning usage
- Add tags from reviewers

Changes vs V2:
- Drop the INTF_CFG2_DATA_HCTL_EN change as it is handled in
latest mainline code.
- Drop the bonded DSI patch as I do not have device to test it.
- Address comments from version 2.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
Changes in v5:
- Link to v4: https://lore.kernel.org/r/20240524-msm-drm-dsc-dsi-video-upstream-4-v4-0-e61c05b403df@linaro.org

---
Jonathan Marek (4):
      drm/msm/dpu: fix video mode DSC for DSI
      drm/msm/dsi: set video mode widebus enable bit when widebus is enabled
      drm/msm/dsi: set VIDEO_COMPRESSION_MODE_CTRL_WC
      drm/msm/dsi: add a comment to explain pkt_per_line encoding

Jun Nie (2):
      drm/msm/dpu: adjust data width for widen bus case
      drm/msm/dpu: enable compression bit in cfg2 for DSC

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c          |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h     |  8 ++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 18 ++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          | 13 +++++++++++++
 drivers/gpu/drm/msm/dsi/dsi_host.c                   | 10 +++++++++-
 5 files changed, 49 insertions(+), 2 deletions(-)
---
base-commit: e6428bcb611f6c164856a41fc5a1ae8471a9b5a9
change-id: 20240524-msm-drm-dsc-dsi-video-upstream-4-22e2266fbe89

Best regards,
-- 
Jun Nie <jun.nie@linaro.org>


