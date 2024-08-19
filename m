Return-Path: <linux-kernel+bounces-293048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B889578B1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69551F237A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5936B1E2122;
	Mon, 19 Aug 2024 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DgpiQ4Kd"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5891DF67B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724110592; cv=none; b=Y/uNl05L4+IWw+BoMlbV7XTSrTsbiRmE5Dbb/5t1a7lOV/AUAMKQoJ2ypB6ExQk29dZJUSly4KJcybgD6CvWnhBgR62gRxF7hFUDVN1PxHWgFBzPa3Rpo8h3eGSKmPJqW69ZLv4OW6+44kG39JeX4hPTTZc2G4xrWgi1FcRfBtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724110592; c=relaxed/simple;
	bh=bnMnLpZp/vOPSEYX30lp0wp4cH4DtZ+pQAK/e1kQwZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OkojSsTNdp/bj2yBOe460Os/O3fKVRqCPgmxFarrYMaexkmi5OkRn76KY7gQQINaD/IrJ+v2hzMHdU+Aw7bLKygfNKAk+xHI+zMxsSl6rrEnpbdlEmzkKCrgS7iYEU1ygUbXnVc7jdWjFshxF3eP5osgxOWKBIC6H+hmnQLIsdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DgpiQ4Kd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2021a99af5eso21335655ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724110590; x=1724715390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BLDC5jns3s4C83X1DcMxdP9cS3cEbuLuxiBTxLxZvgc=;
        b=DgpiQ4Kdmbp7cEjO69IK0su1y6FtOQtpPB6YH2caTXSOWmgq3rYKMjS8xKgGLIXTtT
         aIJUoes14M1KOrSXAT0/yuwKbESZDeHI7oAXZsAS6QuQs3EOuGS+DuvKkrusg/Z7eXfX
         dazz1y47M+xKy/F5hxTr22baVG4eZjqtBAQ5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724110590; x=1724715390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLDC5jns3s4C83X1DcMxdP9cS3cEbuLuxiBTxLxZvgc=;
        b=dVXF25VAbsR0XWh0nwVZH0cCx43ueYkldDHIClqbOBE7uyqF659NLwW18ZQ4dieIsl
         Z6qEWG0N8vov/tSC4mQBZcIF6lKlG6yK2kkVD59DySbCNjRIspVwovLvrdBqbBie9nkB
         pHni3VV1JFpSEiQVx+9NJMmlYRf2uomcGKX0D2kTXuaB3HwBBs9xBTlpBpxK6mrijN3r
         3tP3gEo3cjTn99OXiGVOJqWh1Xm44V0+2cRKffSfPSyDZWF9CyYY8FkPOQI5FgSFvWmn
         XjxA2Fd638PLV0fYC6Hl1l+VDj+dS1S3o/n85l/OImMa0ZPq6V/EDwaAdLquIP5Ud2Wi
         0Etg==
X-Gm-Message-State: AOJu0YxmSKNl0VzStkQ396/xKHD6R/ezyYCOqbPuI8jkEjNEQimnD3Ze
	om+HjqgBVw+p5GkMhKG0mGM4Tc+KaVi0kDKcArumw6TiImEDZoe835kCDzbeIQ==
X-Google-Smtp-Source: AGHT+IF+AD7Zm81meDhqLkHnYjIPgLHIQ0TzFtOkcrvdzaom6Dh2akLYWZlQIUgyro2on4aBmpYOMg==
X-Received: by 2002:a17:902:e883:b0:202:3dcf:8c47 with SMTP id d9443c01a7336-2023dcf8e43mr59296145ad.59.1724110590261;
        Mon, 19 Aug 2024 16:36:30 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-201f0375acasm67703585ad.161.2024.08.19.16.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 16:36:29 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	patches@lists.linux.dev,
	linux-clk@vger.kernel.org,
	Amit Pundir <amit.pundir@linaro.org>,
	Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH 0/2] clk: qcom: gcc-sm8550: Fix shared clk parking breakage
Date: Mon, 19 Aug 2024 16:36:25 -0700
Message-ID: <20240819233628.2074654-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Amit Pundir reported[1] that a recent commit 01a0a6cc8cfd ("clk: qcom:
Park shared RCGs upon registration") broke USB and audio on sm8550-hdk.
These two patches fix the issue by skipping the parking bit of the
shared RCGs for devices that can't run so slow.

[1] https://lore.kernel.org/CAMi1Hd1KQBE4kKUdAn8E5FV+BiKzuv+8FoyWQrrTHPDoYTuhgA@mail.gmail.com/

Stephen Boyd (2):
  clk: qcom: gcc-sm8550: Don't use parking clk_ops for QUPs
  clk: qcom: gcc-sm8550: Don't park the USB RCG at registration time

 drivers/clk/qcom/clk-rcg.h    |  1 +
 drivers/clk/qcom/clk-rcg2.c   | 30 +++++++++++++++++++
 drivers/clk/qcom/gcc-sm8550.c | 54 +++++++++++++++++------------------
 3 files changed, 58 insertions(+), 27 deletions(-)


base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
https://chromeos.dev


