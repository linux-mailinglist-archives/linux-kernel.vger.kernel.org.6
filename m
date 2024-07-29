Return-Path: <linux-kernel+bounces-265766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A54C93F5AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7801F22BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2262D14A61A;
	Mon, 29 Jul 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPyH3Z9n"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC70148FFF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256939; cv=none; b=J71H0LyVczqqCJZOuzZXEcsCZZWu7uxAYNlJqI5ANphP+h+w2q1wgm3MaA40nZGgpgOQIUG7PS6MRg3hriaatRmR3rwbbeGg9sJ4IJrxjLnOPmUg2ZbEydshOS4FLdYkQ6JAUe5vt3Xgkr7YRiNjfNJd5dHmMduOiL9P8pA0y84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256939; c=relaxed/simple;
	bh=RYzzjJz5prGd3ejqUdhZWnFpTvpjktmzCWoGFDU6NgQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P5JmeqI5UACCSLcFI8OTlxqTq34wTcAS5wqKpmBQukZ5O+JQ0z9eiqi0R03n9Qo65JHmODpMogO5hu3feQ/GClmTjcYTVPITu/arGriKvTpOJ0QqW2MISkMsXwwLFLRyNJAUUoSjqedcaRCBA1Iu8YjsEHhw74iXNOM4jenNRLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SPyH3Z9n; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so15752985e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722256935; x=1722861735; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FPb05zxTMe2gnwm5BKRFygHzXK2icK+E4h74wEJLW4g=;
        b=SPyH3Z9nrL1KDs06wxR+0t2pO9jU4QN7DskCrnJuBiOQejJqHZIL1sx6kAOITxYTLq
         xnl0A4Sr4PXsffct+m5rcrkDgnOcHVvhOEBjr+xGgLMfSZm1t7zsevBP/zmrGDVTZkyD
         6jW7wAwdwzEzy6dQoPKbCfCOcI8OWXIqvq536CQ5k/U/fR6EFsT/Wd3V70oxdC6D2HJN
         8tT005a1JDv5vWicn+k2i2xNSr13D0B3XS+sHE3LE0Ehhc8lVd+AlJfCqZMk8v5LgVqw
         hYH4znYna6P9NfTLOZ/Wr27hnsOyP8vhbjytbf+2k6gv//MRlxGpgsZhpPqqz/U+1sHo
         +ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722256935; x=1722861735;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPb05zxTMe2gnwm5BKRFygHzXK2icK+E4h74wEJLW4g=;
        b=p1j+2NcRcUzKwRQfnySYR9bvFahFAV9oDKaVht3cXjP+GL/diAjeX3rMU9A31xk2li
         HsmnZGXjk6xmfxgrhQ4cgW1OAa85QuSUppZkzTzsU0OqHjsLMsoQANYuwpvFsQdmzWRu
         h86zS33CwyN2FRv4DoH8wJDhcjL1tVC9lOsSdn4ksIQIoXWrhMWAWUZl9AJm6R0XJfUz
         LCXLLHrMJI1glRRmzdvM6ikxiwycQtadNGIV3kPG/YvAAcv6+BCcRM2E7vQoe9AsrvDW
         pVcpCd80LhSI8MRY5+uYKOJzrZaR52f6qODZKE8HYFI7yPKyCiNOhtYKVh/gtUDCMElL
         4QPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWwlZ1WBNgLXwsEdOUmN/Mc1VOyV4Leccn+47k4rwaARux8vcYeUjKAPp20dRA6xMqJTWp2/EEUAo0MD4JH1kPtNoiroT93lClkY1n
X-Gm-Message-State: AOJu0Yyppd1UWumQ18tqbh0s+kF9VyURqmcYe5hNBf0qCqovWz7ePGOm
	tM+olXw9pmC/bkPz+slK4BDrB3elOvQ8Ht3YZsR92omPxHuqQs16KL8DvxboQ3o=
X-Google-Smtp-Source: AGHT+IFCPeByOJeTAi0+ljH2ZZVPmMsgCbFxLiDS7EiauYHmtB3LsGyZ4a45Zcu5haF0ODLghRY2uA==
X-Received: by 2002:a5d:4392:0:b0:368:75:2702 with SMTP id ffacd0b85a97d-36b5d0b0472mr4241650f8f.13.1722256934589;
        Mon, 29 Jul 2024 05:42:14 -0700 (PDT)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c092esm12106275f8f.13.2024.07.29.05.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:42:14 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v3 0/2] media: qcom: camss: Fix two CAMSS bugs found by
 dogfooding with SoftISP
Date: Mon, 29 Jul 2024 13:42:01 +0100
Message-Id: <20240729-linux-next-24-07-13-camss-fixes-v3-0-38235dc782c7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABmOp2YC/4XNwQqDMAwG4FeRnpdRa611p73H2KGrUQubHa0rD
 vHdF4XBdvIS+P+QLzOLGBxGdspmFjC56PxAoThkzPZm6BBcQ5kJLiSv8gLubnhNMOA0gpDAK6D
 OmkeM0LoJaZpaW16r0pQNI+UZcFsQcrlS7l0cfXhvD1O+tl9b7topBw661XUpb1ZbXZ7pwgR/9
 KFjK57EL6j2QUEgKm7rVlVStOIPXJblA3NLUKcgAQAA
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hansverk@cisco.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Milen Mitkov <quic_mmitkov@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-13183

v3:
- Amends the commit log for patch #1 per Johan's suggestion.
- Link to v2: https://lore.kernel.org/r/20240716-linux-next-24-07-13-camss-fixes-v2-0-e60c9f6742f2@linaro.org

v2:
- Updates commits with Johan's Review/Reported tags
- Adds Closes: https://lore.kernel.org/lkml/ZoVNHOTI0PKMNt4_@hovoldconsulting.com
- Cc's stable
- Adds in suggested kernel log to allow others to more easily match kernel
  log to fixes
- Link to v1: https://lore.kernel.org/r/20240714-linux-next-24-07-13-camss-fixes-v1-0-8f8954bc8c85@linaro.org

V1:
Dogfooding with SoftISP has uncovered two bugs in this series which I'm
posting fixes for.

- The first error:
  A simple race condition which to be honest I'm surprised I haven't found
  earlier nor has anybody else. Simply stated the order we typically
  end up loading CAMSS on boot has masked out the pm_runtime_enable() race
  condition that has been present in CAMSS for a long time.

  If you blacklist qcom-camss in modules.d and then modprobe after boot,
  the race condition shows up easily.

  Moving the pm_runtime_enable prior to subdevice registration fixes the
  problem.

The second error:
  Nomenclature:
    - CSIPHY: CSI Physical layer analogue to digital domain serialiser
    - CSID: CSI Decoder
    - VFE: Video Front End
    - RDI: Raw Data Interface
    - VC: Virtual Channel

  In order to support streaming multiple virtual-channels on the same RDI a
  V4L2 provided use_count variable is used to decide whether or not to actually
  terminate streaming and release buffers for 'msm_vfe_rdiX'.

  Unfortunately use_count indicates the number of times msm_vfe_rdiX has
  been opened by user-space not the number of concurrent streams on
  msm_vfe_rdiX.

  Simply stated use_count and stream_count are two different things.

  The silicon enabling code to select between VCs is valid but, a different
  solution needs to be found to support _concurrent_ VC streams.

  Right now the upstream use_count as-is is breaking the non concurrent VC
  case and I don't believe there are upstream users of concurrent VCs on
  CAMSS.

  This series implements a revert for the invalid use_count check,
  retaining the ability to select which VC is active on the RDI.

  Dogfooding with libcamera's SoftISP in Hangouts, Zoom and multiple runs
  of libcamera's "qcam" application is a very different test-case to the
  simple capture of frames we previously did when validating the
  'use_count' change.

  A partial revert in expectation of a renewed push to fixup that
  concurrent VC issue is included.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Bryan O'Donoghue (2):
      media: qcom: camss: Remove use_count guard in stop_streaming
      media: qcom: camss: Fix ordering of pm_runtime_enable

 drivers/media/platform/qcom/camss/camss-video.c | 6 ------
 drivers/media/platform/qcom/camss/camss.c       | 5 +++--
 2 files changed, 3 insertions(+), 8 deletions(-)
---
base-commit: c6ce8f9ab92edc9726996a0130bfc1c408132d47
change-id: 20240713-linux-next-24-07-13-camss-fixes-fa98c0965a5d

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


