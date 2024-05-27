Return-Path: <linux-kernel+bounces-191425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCAC8D0F01
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35601C211F6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B35715F335;
	Mon, 27 May 2024 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k97pWcsv"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96419DDC1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716844138; cv=none; b=o9yFF+rfU+K7FLFO/CUQ1hw0GXOlL88hEYf2/5hPI082Nq2oPzKi04spB3iFOhLC1k3BIt8T31Nyl894wZ9nCf2MC9LY3jp4SFhmb8hOEuPx/uAu4thrN022iBIrTPEMGzZYJjsnQlnTq34r4amYCac9IDjYrJzI92LvHsdzmvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716844138; c=relaxed/simple;
	bh=ktOool4la2K3Ch5U6qURiQDsK4zx2dK0DDAYnavRRiM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d4XSxU+fB/U46bfy/3O59DF6wyo9A0AFTNQZo77aQ/35N4QwnVbve9U8UyjyTstrWesKXoX/hEhQ5ZSAm3117Bnhg0FAxSTBl2SYhLjxgItc4NqRoqMosUMoJnXgwoBMciqmA8Y1QLwdfLe9t/nM3xVf8sULm07aVOoiYOL+XeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k97pWcsv; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b970e90ab8so71091eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716844134; x=1717448934; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WkhLLtNdQQ166JLmgy9oTgRJvGdeZaOnVieg5pXIOy4=;
        b=k97pWcsv+LtYXzggcoZ+w0S9uSUhYcB3lAvDBLWd+p/fXKTAEXG1dvFDtVWvjx7N30
         F0rwZffl48CmDr7X/pS648hZTGQIKsTnQUT5uQjmmNJZyGGc7MIqi7SDJeV/qmuHhOQG
         wlfTxAlkfMP/9+wp8n+FJA9MDlZDttxlSftno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716844134; x=1717448934;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkhLLtNdQQ166JLmgy9oTgRJvGdeZaOnVieg5pXIOy4=;
        b=GIUL7WIrVfwczPqiFtqEdVACYMYqP8x6TGx8aMtK+ivhGtuZcydVT2cLK1rR7l0kmB
         5FKPq9IAzJNfBZzbU5zvBgq6tFOEHSRjz5rZ7BdZ5w2sl3XZp4UXoLbRmM+L6sdxr0Y7
         QsMhDl+WNZ6UQlof36fMjSc6Wb+0HMzXiUXc8Li0zq3+hhb6GAWarONKsgYTqQ4t89cO
         4LAROJDofyoN4AqqNXKIRK/nbsdcmElRM3PZGp8DcFW3T5HCOu2Y6DHZq5164JLngqRF
         NyBTJP0rnjKmz0Dnr92LweQlRjPjWUMny9suIxJb7+6oIcMuGGVF+fAP1QtMyoo32Lsa
         Bbrw==
X-Forwarded-Encrypted: i=1; AJvYcCXut3DIul7JZcY+68tJ/yLtUj+5cnlD2M2BO/TBiQyCxlvEa7jj+cY7BNmfekjphKWeQMxMKEnDvdFzs8ESKp1I1i2mnpVByfs0RaiW
X-Gm-Message-State: AOJu0YwWA+uzrzmNFPYFwcObJc/WjnJRaqDEDO/LxNrN3Nx55YtZTuBQ
	CoLwsdfHmY+jYeCyLvIvF7Xv6kwfTyRjgmJi+ZW7nX8QklFONFxOuFzRmqpzig==
X-Google-Smtp-Source: AGHT+IHKBoTjiEWufz6HkJxCHl14PQW6B7FmtNjhRPgkJI6/XkalgOyG105zpAvuo6WpKcoeijZ+mg==
X-Received: by 2002:a05:6359:4287:b0:18d:8c13:b83d with SMTP id e5c5f4694b2df-197e45d86b6mr1453805755d.0.1716844134467;
        Mon, 27 May 2024 14:08:54 -0700 (PDT)
Received: from denia.c.googlers.com (125.135.86.34.bc.googleusercontent.com. [34.86.135.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad850a6dc7sm9511866d6.93.2024.05.27.14.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 14:08:53 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 00/18] media: Fix the last set of coccinelle warnings
Date: Mon, 27 May 2024 21:08:50 +0000
Message-Id: <20240527-cocci-flexarray-v3-0-cda09c535816@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGP2VGYC/4XNTQrCMBCG4auUrI1Mxv7pynuIi5BO2wHbyERDS
 +ndTbsUxOX7wTyzqEDCFNQlW5RQ5MB+THE6ZMr1duxIc5NaIWAOBVTaeedYtw+arIid9dnWUNm
 aDNSk0tVTqOVpF2/31D2Hl5d5fxDNtv62otGgc5ujcWjaBsqr68UP/B6OXjq1cRH/EJiIypLFE
 l0LZfFFrOv6AX5kqJz0AAAA
To: Michael Tretter <m.tretter@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, Andy Walls <awalls@md.metrocast.net>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

With this set we are done with all the cocci warning/errors.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3:
- Do not rename structure fields. (Thanks Bryan)
- Link to v2: https://lore.kernel.org/r/20240507-cocci-flexarray-v2-0-7aea262cf065@chromium.org

Changes in v2:
- allegro: Replace hard coded 1 with a define. (Thanks Michael)
- Link to v1: https://lore.kernel.org/r/20240507-cocci-flexarray-v1-0-4a421c21fd06@chromium.org

---
Ricardo Ribalda (18):
      media: allegro: nal-hevc: Replace array[1] with arrray[N]
      media: xilinx: Refactor struct xvip_dma
      media: dvb-frontend/mxl5xx: Refactor struct MBIN_FILE_T
      media: dvb-frontend/mxl5xx: Use flex array for MBIN_SEGMENT_T
      media: pci: cx18: Use flex arrays for struct cx18_scb
      media: siano: Refactor struct sms_msg_data
      media: siano: Remove unused structures
      media: siano: Use flex arrays for sms_firmware
      media: venus: Remove unused structs
      media: venus: Use flex array for hfi_session_release_buffer_pkt
      media: venus: Refactor struct hfi_uncompressed_plane_info
      media: venus: Refactor struct hfi_session_get_property_pkt
      media: venus: Refactor struct hfi_uncompressed_format_supported
      media: venus: Refactor hfi_session_empty_buffer_uncompressed_plane0_pkt
      media: venus: Refactor hfi_session_empty_buffer_compressed_pkt
      media: venus: Refactor hfi_sys_get_property_pkt
      media: venus: Refactor hfi_session_fill_buffer_pkt
      media: venus: Refactor hfi_buffer_alloc_mode_supported

 drivers/media/common/siano/smscoreapi.c        | 10 +++---
 drivers/media/common/siano/smscoreapi.h        | 18 ++---------
 drivers/media/common/siano/smsdvb-main.c       |  4 +--
 drivers/media/common/siano/smsendian.c         |  8 +++--
 drivers/media/dvb-frontends/mxl5xx.c           |  2 +-
 drivers/media/dvb-frontends/mxl5xx_defs.h      |  4 +--
 drivers/media/pci/cx18/cx18-scb.h              |  2 +-
 drivers/media/platform/allegro-dvt/nal-hevc.h  |  7 ++--
 drivers/media/platform/qcom/venus/hfi_cmds.c   |  8 ++---
 drivers/media/platform/qcom/venus/hfi_cmds.h   | 38 ++++------------------
 drivers/media/platform/qcom/venus/hfi_helper.h | 45 ++------------------------
 drivers/media/platform/qcom/venus/hfi_parser.c |  2 +-
 drivers/media/platform/xilinx/xilinx-dma.c     |  4 +--
 drivers/media/platform/xilinx/xilinx-dma.h     |  2 +-
 14 files changed, 39 insertions(+), 115 deletions(-)
---
base-commit: 48259b90973718d2277db27b5e510f0fe957eaa0
change-id: 20240507-cocci-flexarray-9a807a8e108e

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


