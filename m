Return-Path: <linux-kernel+bounces-370536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B809A2E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7B5B216C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ACA227BB7;
	Thu, 17 Oct 2024 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O4Ag2ZD7"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C681DFE11
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729195495; cv=none; b=jTkBFtcE9yGILpUE87dYytSBaWdBfvdR8+AVDLRBxyQVI8JW7d6A1gyEPrpnh2ycEPI2819LxSWJJcnotkBB4TA0DMbWq/15bjtMy/D1SKyeOtCqczHt2RMJem7+aYIkRdPadhikQaLhCZozRiPPF3FWjMo/jzK2B7Ee8C9m3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729195495; c=relaxed/simple;
	bh=Qm1GMCj9s7ZVm/rHBsoEHDxu99TWbXF0jSckjQod4qQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f6SiR9GFU+gd3GBpCJWCoLJfSsp8UwpmlQWv+uWnn/kG6zylLY4S3wsGYECjm+zbgU90rF6EdYb4nvT/GwPZ6EyYeFqK0Nwm0dDl6gONnsPRBkcCzqJ92YM5SpevbWLFvYcuU96bnzbc7b02v4LygbeJTcu5WJFIIKKNklUnsPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O4Ag2ZD7; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso982197a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729195490; x=1729800290; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eDj09dc2QEIl6UR3qLj9hDrktF4mFMWl9OGSbmf86hk=;
        b=O4Ag2ZD7D7Yf1F6Z8GOvbMde1aumRzULrbrAhWYK7rO4XoG6FXiJBpWpraXFBPYWLY
         iOtxc0q4KiLN51uN7jkqH3v9968wv8nxvJBJNFF8MVtsW9VazYXd3zZ2GSwUl4lO9+SM
         DdXTqCLHVAwvdr5w4/SYe45CUpzsLjeSNtgPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729195490; x=1729800290;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDj09dc2QEIl6UR3qLj9hDrktF4mFMWl9OGSbmf86hk=;
        b=pYHrBhSHbVXbUhp22VuowxRTDAFoQRK0mkVUoygfjU7/9ESk5PmowAsbqt8Y5AnadI
         5Jmy3Jkh0lavKHQM7R2nyNXoKlDSL1GgeJQjXWr3PyxVwpNuPbbarlI8VmdMe8WZobqY
         QR8CIp/5qPPb6WYeLX8Ob7Ut2Y82c65Ju1EucqeMd2RpBp3uiqkr5AGmiF7BD936iPO4
         RRcoyDpH7KjFl/CoarNhNN0S93NHiY3k6iYbKWj6z1+GqewFF77q0Ek+Ou/stW8IwibN
         QUlTLBDiJ1s9O3rq1rR2w0Khm5g7UAJ+qq9vf1So/n2+5e9/ZkrDERiQMIEGNwuO0sU1
         UTlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj24E4V/YlFMQtotDoBfdneMR3O58qB2ow+UlbvQsu8ubYfai+h723k/CGheuntgBx8VfwOQfLednlNYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUZfYkp5Ja6nEeU2U3StgNYtAM9DpUCKL8tdV0koQ3+iWM0DK
	jLjcBqIYPbsG/CgzjrRWR2ahp0Fj3mRdByFcWi03qsDD28xuGJpEv/UIy1mPFQ==
X-Google-Smtp-Source: AGHT+IF6lVclQ4oXNY5WbZFpvFSBm9cqx/5zVposFBtyP7/LO00BgnrvSt/oAOgZRyinmAwy13hnxA==
X-Received: by 2002:a17:90a:8d14:b0:2e2:c00c:cb79 with SMTP id 98e67ed59e1d1-2e5616db842mr175745a91.3.1729195490619;
        Thu, 17 Oct 2024 13:04:50 -0700 (PDT)
Received: from zipper.pdx.corp.google.com ([2a00:79e0:2e13:6:ab92:55d4:ae5d:528a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e56129dccesm110088a91.38.2024.10.17.13.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 13:04:50 -0700 (PDT)
From: Fritz Koenig <frkoenig@chromium.org>
Subject: [PATCH v4 0/2] media: venus: Add hierarchical h.264 controls
Date: Thu, 17 Oct 2024 13:04:29 -0700
Message-Id: <20241017-submit-v4-0-d852bc7f7fdc@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM5tEWcC/2XMQQ7CIBCF4as0sxYzFhDiynuYLmo7LbOgGGiJp
 uHuYrcu/5eXb4dEkSnBrdkhUubEYamhTg0Mrl9mEjzWhhZbhfaiRNqenleB2lrs0ShpDNTzK9L
 E7wN6dLUdpzXEz+Fm+Vv/iCwFismMqEmS1Ve8Dy4Gz5s/hzhDV0r5Apvr8FyfAAAA
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Nathan Hebert <nhebert@chromium.org>, linux-media@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Fritz Koenig <frkoenig@chromium.org>
X-Mailer: b4 0.15-dev-37811

v4:
- addressed feedback from Dikshita
- included reviewed by for patch 1
- Link to v3: https://lore.kernel.org/r/20240814-submit-v3-0-f7d05e3e8560@chromium.org

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
 drivers/media/platform/qcom/venus/venc.c       |  73 +++++++++-----
 drivers/media/platform/qcom/venus/venc_ctrls.c | 126 ++++++++++++++++++++++---
 3 files changed, 165 insertions(+), 38 deletions(-)
---
base-commit: d07b43284ab356daf7ec5ae1858a16c1c7b6adab
change-id: 20240814-submit-05880a074377

Best regards,
-- 
Fritz Koenig <frkoenig@chromium.org>


