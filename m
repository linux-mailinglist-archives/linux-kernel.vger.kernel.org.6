Return-Path: <linux-kernel+bounces-287248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32359952556
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24F11F22BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE367149E17;
	Wed, 14 Aug 2024 22:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lzy5PnsV"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633E31494DA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723673659; cv=none; b=u8tlDfkWE0kIBo6Vq/BcZKkgCN9tOcep3ua0U+cAdqfVLu++FcC48OvwLpxt2EmOoTHgOISnhQBGwHyeSSaCH9t21k0J9OOY+Dvpj3Hg9xEEwV4rzhxQegoexEbpYvWkTsjd0mjCcT6UAzSS8V/VC7PslX+jSpQTPAm+eXFoyME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723673659; c=relaxed/simple;
	bh=SNRkXhDmCbbOK8av0t3Uel7gPdjevNHKKfFt/NX9R7w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mUGgqdm//lXkh3HVhN2E0SvsaVsqhU1Q/hIbTthNBW0fP+z6VuapG7qufWr/y+GzWihgDH9LNmnPz+JQOm8cDzL6H5JFh1VgTkVTA2Y7zYxVjK8VwDDZnN6CoW2XQuBldkmpABdWJk9tT30hE2lD0Qvw86xKJkz6BGjcTd8J4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lzy5PnsV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc6ee64512so3472805ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723673654; x=1724278454; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9dZakyOosNQEb8ThSHDuM5A07F0pWfsm3wFIDax/xIA=;
        b=lzy5PnsV22gqWFae0DcyKokPGhdFwt12GnOAr1Rrxb4Y9gDAdyAe5smfHTNCQ+md4q
         upEZuvfBiOD2HzbS7rbAXCzwjKwP5wqAZ/4O9NEAZwZRijQZHjxK7DN9ABfLCnodD8jE
         8CdjFbPY+5178V5o8Z8/f/BokCjRL/K2dNbgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723673654; x=1724278454;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dZakyOosNQEb8ThSHDuM5A07F0pWfsm3wFIDax/xIA=;
        b=G1nCrHlth8JpC9FjuMfFSGbxftJqEs5lylKtgw1PcYUB7dOmskz7GITxDkmYwImNOS
         ojlKDX6KS5YkqgqWfcYE8FTpzXdBWf28nbPkQcmLn4KemkrMtnISbH+7l5bbgj+JGB/9
         nUm31jEIqcoD/XPspYYBLM4f96Ww5RlisJU/BSFYqAhdglMMWpxhUnU8eae7a8Wvmkdz
         un0af7HdeLtgdzcwIjU0zjDf2LciTk7bUtLxWRqZhC0j7KNEIRhfcDYbJHBj+BQKwFZN
         uTQvyecN5vIvfCo+jkEyf3xWl5TCK4tjlLR/mNXhY/RKUnym7fy5n8OMXWkKtfjgUQV5
         SOGA==
X-Forwarded-Encrypted: i=1; AJvYcCV6Yq/FOSEkLV2VMxjkKlUzxxxHXUMd0a/ypz79ciKiCtVClD1iADt7JNsCZejSagXLXJwqpnsCLf6wuSI6dw8FJIqqaxOkKVfPhi+E
X-Gm-Message-State: AOJu0YzXq/2yLI/Y6OA9HolE+zjyJRewSe3h7ahl5A5ijrKCpTpLhhY5
	JUGzyPR6RXv84ROKnUdSp0c0ASHRLCdGclpn80/mlOHHtawtJQxRIp68n6LJOg==
X-Google-Smtp-Source: AGHT+IHVQcqP4dstKT0IkJfBwrz7BgpmEzWgQOguFtF6ilWFMEfyEMuHWGaFU1rJVz0Q2BKXR6oqnQ==
X-Received: by 2002:a17:902:db07:b0:1fb:8c35:602f with SMTP id d9443c01a7336-201d639c9c4mr57253855ad.6.1723673654526;
        Wed, 14 Aug 2024 15:14:14 -0700 (PDT)
Received: from zipper.pdx.corp.google.com ([2a00:79e0:2e13:6:aab8:3da7:4601:820d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375725sm1046595ad.132.2024.08.14.15.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 15:14:12 -0700 (PDT)
From: Fritz Koenig <frkoenig@chromium.org>
Subject: [PATCH v3 0/2] media: venus: Add hierarchical h.264 controls
Date: Wed, 14 Aug 2024 15:14:03 -0700
Message-Id: <20240814-submit-v3-0-f7d05e3e8560@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACssvWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0MT3eLSpNzMEl0DUwsLg0QDcxNjc3MloOKCotS0zAqwQdGxtbUA3pp
 I/FgAAAA=
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Nathan Hebert <nhebert@chromium.org>, linux-media@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Fritz Koenig <frkoenig@chromium.org>
X-Mailer: b4 0.13.0

v3:
- dropped reordering patch
- updated cover letter

v2:
- cover letter
- testing methodology
- Signed-off-by

V4L2 has support for encoding with hierarchical frames using the
V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING* controls. This allows for
specifing frame references needed for temporal scalability. Encoding a
single stream with a single layer allows for the layer to be dropped and
the stream to be decoded without artifacts.

ChromeOS is planning to use this feature for the L1T2 web standard[1].
This allows video conferencing apps to encode once for a clients with
different performance/bandwidth capabilities. As the application is a
real time encoder only P frame support is added.

The ChromeOS test framework ("tast") was used to verify that no
regressions are present. This was done on SC7180 ("trogdor"). These
patches were also run on SC7280, but not with as an extensive test set.

Verification of the added controls was done with a bitstream analyser to
make sure that reference frame management is correct.

[1]: https://www.w3.org/TR/webrtc-svc/#L1T2*

Signed-off-by: Fritz Koenig <frkoenig@chromium.org>
---
Fritz Koenig (2):
      media: venus: Helper function for dynamically updating bitrate
      media: venus: Enable h.264 hierarchical coding

 drivers/media/platform/qcom/venus/core.h       |   4 +
 drivers/media/platform/qcom/venus/venc.c       |  85 +++++++++++------
 drivers/media/platform/qcom/venus/venc_ctrls.c | 126 ++++++++++++++++++++++---
 3 files changed, 171 insertions(+), 44 deletions(-)
---
base-commit: d07b43284ab356daf7ec5ae1858a16c1c7b6adab
change-id: 20240814-submit-05880a074377

Best regards,
-- 
Fritz Koenig <frkoenig@chromium.org>


