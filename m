Return-Path: <linux-kernel+bounces-251945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E87F8930C03
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 00:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A99E1F2139E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 22:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2813DDD0;
	Sun, 14 Jul 2024 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mLotulF6"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9BD25779
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720997636; cv=none; b=IYDuZ7CeQp/y5pM/8XX3LXleVtMWbm0yxlHvDIR8qJs6R7f61PstbIjO9EvU0RmQ8x27lLgMQ1DEYH1BmGoRe6RAWlWNuLV1/LaBCubJXnhIEJQ/mppjjlGMVmUunSPfxK9F+L9IfTzFPzCjVjarW6TPoCCvamNngzi1+NXDLAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720997636; c=relaxed/simple;
	bh=ys1n5+ZFESe4r0ck3NYdHAwyXgdZq/cIcFI1NLRzeJQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ve67MmgSURLuE0jFoQLuGfYly8YmfX/OQdit3Gp+nMBlyfbEojrB26H9/CrMdbD6Qx9vhj2sgjLTdCktmCehAUKFQaGf+d/nMGFyvKO1aRz3WhE35fFt2bA0vtz/r/RzN7v/E26uQFZCT848jgvx+kEPL9fSgy5/4PffUzOQKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mLotulF6; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so50166341fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 15:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720997632; x=1721602432; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSw6ICbIjXMbfWEuPsG2mS7dPjLtUBfPSwkxJ1RENbc=;
        b=mLotulF67lpJEJT8EW5r201Ea5q1LIydOTSJU9ntoCxMWK5NeYEE5pUQSzFsBtkC4m
         oRAb6ZRP2W7hC2C/xf0NXKMTQ0iHlYFW7fKfeDWlqRYtvuH/hfarNdoAF97OLDNeJt94
         0Cbw3L6lZjzzSy6KK10L/dEoOjIVDC1z1MLf1hKsNlKgHHmKG05+PpXJfGdPr+aDfeGF
         nrql0K9sHxaq4H4GUp+ALHLJt3f2IIZdgGMteZpw8Rcs+77U1nGikf7t1+kl6yQNQyjj
         iVfc49MfVI8bk9VY5RJTt9TssQcI6bxlqjC15BI528HMcPqoJtoMHCvcMDhORb+t0sIL
         G8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720997632; x=1721602432;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSw6ICbIjXMbfWEuPsG2mS7dPjLtUBfPSwkxJ1RENbc=;
        b=t0ZxUn296EE2A0aBuquAAMD1PDpRhLTPvGdwRHd0BbVKVeZ88eX5nAr17mplIluJTL
         Te7rzaAhtHHJjxnE3mZNWkgz3n+i5Eq2aykF7I6C9xUwWcroIHXWfPyqQikoQEZd2vWf
         7jP4iYaNraNxsX0Xcyp36ui5hTkSFL18a/Ng9+mkla1M8TGq5OBuUIeq4I3Jv+7Ku3o1
         umklVRCaXVEDn1ZmKKvAhiAA7yO0/1mbQnLoK6J24E1xWC7LQSXWfplzDgi4p/QreJuG
         0dvXX7odc/Se/m3x7Ta3PqdOPBZwdBEj7G0EvWrJrg5iKzq20P7HHnUPpFGU1lcMggqm
         3CSw==
X-Forwarded-Encrypted: i=1; AJvYcCXSLsfAaqU5bR0WebgIl5rU/CTxy3GTP61vnZdqwRXmqsTUbvwL/Unm2ueL4LxpeUsFi2CT1Dc3W0N2J3UOxHBzvZUUhUGqTE7Lp7Rl
X-Gm-Message-State: AOJu0YyvtslaETjhGzXlJd6RRa79bSGD0lwo/SZpoRasKWyvCVGk/72Q
	2To9cQLtrZzuNrXEidpdw88KUdLP/8fAIIwooIcjc6emciLvZoygD0QHCKe631o=
X-Google-Smtp-Source: AGHT+IFFzYXnyaWp/sJbKfs+k/FzQVbblKsLFmcyHIJF9nrUmA5AXXCdjCLKSI2LbxePqTiJWX0jzg==
X-Received: by 2002:a2e:9693:0:b0:2ec:6755:a0cf with SMTP id 38308e7fff4ca-2eeb31895b8mr109208351fa.32.1720997631587;
        Sun, 14 Jul 2024 15:53:51 -0700 (PDT)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279dae34casm40632445e9.0.2024.07.14.15.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 15:53:51 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/2] media: qcom: camss: Fix two CAMSS bugs found by
 dogfooding with SoftISP
Date: Sun, 14 Jul 2024 23:53:57 +0100
Message-Id: <20240714-linux-next-24-07-13-camss-fixes-v1-0-8f8954bc8c85@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAVXlGYC/x2MywqDMBBFf0Vm7UCMia9fKV2EONUBTUvGloD47
 w7dXDj3wDlBKDMJTNUJmX4s/E4KTV1BXENaCHlWBmusM33T4sbpWzBROdA6ND3qF8Mugi8upBv
 GIZqx88HPoJVPpr/QyON5XTc1lDBEcQAAAA==
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hansverk@cisco.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Milen Mitkov <quic_mmitkov@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-13183

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


