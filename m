Return-Path: <linux-kernel+bounces-376737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0F69AB54A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97281F2424D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0689A1BDAA5;
	Tue, 22 Oct 2024 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CRAE6afW"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E01BDAA6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618848; cv=none; b=Bqf5x9soXZCrDqg/r+LOQzq5Je/3WH3cqEawMkeoHc6ZFJlUGOrdULHGnhBw4VV/+CxjJdnUnNqYyMBcWWc67y1Smoqts/WIAuDEmNNlX9aHLSi1stXI7WtyTeDpjzcfH23+EF3qTkzeX6dl42I/ahlhM7NfCxdoHaTUUA/Gu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618848; c=relaxed/simple;
	bh=C0yUyZ6XkQJmWA3d7HhAPX4tnErtrKNS5NnyzznqJX8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l3hWEqc4EHMuIFUfoulpKYsDF3eMrpvGWLSLSRw0EMozvdSnm1z7TZ45PxHJ1LC7Edq4TXmlrG0W01lBkVesHS/4rNEFMb7AwT8ngl0onvgIrQT+MLLrZq9yvM61V0tQv54NIcFBTHWLtS8s1KW+DcaoelhxVSO3PFUvyXxOKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CRAE6afW; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7163489149eso4511151a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729618846; x=1730223646; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oupby0dRgGN5Xj7RL7U1Svi3uhRY52g3w01e/cCB/qY=;
        b=CRAE6afWjlMf8YlQShYEkV+SoylcX5ZAifgdY1FNwbmkOIVIvbg5ovrhTf2uO+WuXX
         WRHU9/H56ApardiKy8+rUy8fJiSoMZSc2pPQ7MYhrai4sxAJ2RNV4bgnTPgLE9c4S/uO
         Ocanq+upQ927LS6Gk07INCRjxA4RgcyC3Hso4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618846; x=1730223646;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oupby0dRgGN5Xj7RL7U1Svi3uhRY52g3w01e/cCB/qY=;
        b=tVKTkGUFePHM5tMsph4KDaGjkCMKyyiup6A1OD9X3akYuATXyF5PLSi8lLfIE+HFsH
         DPWCbyQ0ncQquxwHXTy8IbvzsiJkkSBEacTYQznHeUrfrvs2mClAdyRzqs/La0ECmqWL
         c2SIn/lHBsghM27SAl8eft30zJuKwdfvjMo//s2KcjYgwnq1UrVGrd6+64UCUIlEIlaY
         ldbo6kHiRc2fOL7E7LatOHvbcozxxOAnKGEaVaAx37DJimh7gtm74+z7/R+vuWTolJyd
         /VxG5ph0Vgi7IzcC6sqG6LmPE0qyGxD00Fef2e8wB6h4lED8MSbJhXsgZrQaGlUYtkBl
         FyRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSXXti43wcJjlEBQD+LylJNpNIKliGZ/QxIkzcfDeIxJcUV7OrhRp329S0uxFul5gGt3cZ+aNmpV25y9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyqHOKJ2kJkhpHDHl0Fllmo42hAGI9qiMzIM2i9TOtMTsHTan6
	u3MZDaOBGZr5UsoXtAQLacvR8i1c8WTxBzO6wjXPH/M0Dpre3kxCbMTanxsu4Q==
X-Google-Smtp-Source: AGHT+IEWT04yh/p+RAO8GEp7u2SQSDOAW6FFU8HzqLUb7plIoEg+2ByMr21qcUeEkUAFRuS94KYlgw==
X-Received: by 2002:a05:6a20:e608:b0:1d7:7ea:2f2d with SMTP id adf61e73a8af0-1d977586525mr449373637.6.1729618846204;
        Tue, 22 Oct 2024 10:40:46 -0700 (PDT)
Received: from zipper.pdx.corp.google.com ([2a00:79e0:2e13:6:158a:d1d:c077:7770])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312d6bsm4992423b3a.29.2024.10.22.10.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 10:40:45 -0700 (PDT)
From: Fritz Koenig <frkoenig@chromium.org>
Subject: [PATCH v5 0/2] media: venus: Add hierarchical h.264 controls
Date: Tue, 22 Oct 2024 10:40:41 -0700
Message-Id: <20241022-submit-v5-0-552f0fec8cba@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJnjF2cC/2WMvQ6CMBRGX8Xc2ZoLbW3j5HsYB+gP3AFqWmg0h
 He3MDDoeL585yyQXCSX4HZaILpMicJYQJ5PYPpm7BwjWxhqrAXqSrA0twNNDKXW2KASXCko51d
 0nt576PEs3FOaQvzs3cy39S+ROUPmlUXpuNPyinfTxzDQPFxC7GCrZHGYFVbqMEUxrZZ1a5RX3
 pofc13XLw2WEgjZAAAA
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Nathan Hebert <nhebert@chromium.org>, linux-media@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Fritz Koenig <frkoenig@chromium.org>
X-Mailer: b4 0.15-dev-37811

v5:
- fixed formatting
- included reviwed by for patch 2
- Link to v4: https://lore.kernel.org/r/20241017-submit-v4-0-d852bc7f7fdc@chromium.org

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
 drivers/media/platform/qcom/venus/venc.c       |  71 +++++++++-----
 drivers/media/platform/qcom/venus/venc_ctrls.c | 126 ++++++++++++++++++++++---
 3 files changed, 164 insertions(+), 37 deletions(-)
---
base-commit: d07b43284ab356daf7ec5ae1858a16c1c7b6adab
change-id: 20240814-submit-05880a074377

Best regards,
-- 
Fritz Koenig <frkoenig@chromium.org>


