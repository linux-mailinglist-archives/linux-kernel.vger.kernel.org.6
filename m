Return-Path: <linux-kernel+bounces-381730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748649B0375
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393E5286751
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5411632E7;
	Fri, 25 Oct 2024 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZOYInIud"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8B1632F7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861929; cv=none; b=gjfQEdA6g7nlMqlIT5Pnlt5kqMLNvRFLhzWliY1ibi7lCg31fCo8KcJfz9YeJEsYp8p8OnJZ3rFMsZnipMdgjzi0YWXtptzbJ7U4XM2aMMkrdNzro30/oEH6KhMptCZ7COLrrLvjnJaTAScCGAUnBkIBp+JZjuhnx+OJMywRyto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861929; c=relaxed/simple;
	bh=W7friAtVQRffiLbA+GCXrUMmE0PLT/AOO5U7Kwjd/Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xx0QnCSBRQQWrb5YddRpZh43DOI0XtqyYefi0jJsEK82UYcMZcz/lWbMV/THWktnJ1FyoGWNRWBBBqrHwepvK1jyIo3ah9fVQIvqVPu7+vsdBSWoplg0FpJyzbzx1hKSz+tXa/dnzoiDUWMAeYgLc0fEMJYLKfHc3jF0a+KvX5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZOYInIud; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so1989950a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729861926; x=1730466726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRMnXvsHsbg1WtETmmqGXSobfWzOVAe6LmlCeFE9Ce8=;
        b=ZOYInIud4I4ffMLGb+envW7ak13Ga+t18iIziEbnoPLzIhXPnbztaAlU+tfEkECBMX
         WYDZnqlniAMPXjRZrscQwa78OcDKubCwTKl8MM9Kuza1qKIJdGl9i0KbqrCUz/T25yIl
         HR8hz2Tr7NIScu55qdsGdqgcDSAQXLHotHvKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729861926; x=1730466726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRMnXvsHsbg1WtETmmqGXSobfWzOVAe6LmlCeFE9Ce8=;
        b=wUoT49ix8iYpYhXUWn0FsrIJefDcq8Wxg1qZ3VYbX5ITHpu0HHB+s0tbyna3iEMwYu
         RUQ8NRjD0ywq7lImbSZeuKD5AY8aA+YeEanLe80l5AHjA+CR+CAy1pChS3pWoWKCcC1W
         2lBAl7BktDvN+X2U6aTwvXUn8DBld1zmzX0kwJYInznPD21Y4nm4CL5nWH7ESOkvgYa+
         Bw+6iUOjIfOkuvSHTkk+ZQ0BnXQDs+KhHWvVJOozOhZ5px6L7gg+QVpb4TqEqRnhRqQB
         2uIo65KVYxi1Mzb9ZRgk+Q3rhFxNt2KdS9zfMPZtuGwoBMYr8pRQwZO8dV3ndse44JMB
         ev4g==
X-Forwarded-Encrypted: i=1; AJvYcCV/Z3gXRoUINML0k4ZvCpp6nfN2SsDSBgp1uJUwogLYWvgStZSRlwe0FqDK3fhmJqdfOFkhX0rhLl4eQsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4zUBx+B9kZA5qd79Of12clNATB7urjNxQYAJ26wvfRYikIl2D
	X90BgqQZvUTdBKWPmtafd33b5GlljK4vxcssYhmH6j4JqdVlQ39i0bl0+Kz21g==
X-Google-Smtp-Source: AGHT+IH6fGLpM4dLLrV3AYDO24lReXJjLEFiphcBXr5XktHSLdQkl0iv0BpZ6miTQucP1s00qgHQNQ==
X-Received: by 2002:a17:90a:604f:b0:2e2:b94c:d6a2 with SMTP id 98e67ed59e1d1-2e77e45ef43mr9071317a91.0.1729861926408;
        Fri, 25 Oct 2024 06:12:06 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:bd37:bccf:f3e:a9ef])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3556517sm1364203a91.8.2024.10.25.06.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 06:12:06 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 0/3] media: venus: close() fixes
Date: Fri, 25 Oct 2024 22:11:48 +0900
Message-ID: <20241025131200.747889-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of fixes for venus driver close() handling
(both enc and dec).

v4->v5:
-- also drop venc_ctrl_deinit() (Bryan, Dikshita)

Sergey Senozhatsky (3):
  media: venus: fix enc/dec destruction order
  media: venus: sync with threaded IRQ during inst destruction
  media: venus: factor out inst destruction routine

 drivers/media/platform/qcom/venus/core.c      | 25 +++++++++++++++++++
 drivers/media/platform/qcom/venus/core.h      |  2 ++
 drivers/media/platform/qcom/venus/vdec.c      | 13 ++--------
 drivers/media/platform/qcom/venus/vdec.h      |  1 -
 .../media/platform/qcom/venus/vdec_ctrls.c    |  5 ----
 drivers/media/platform/qcom/venus/venc.c      | 14 ++---------
 drivers/media/platform/qcom/venus/venc.h      |  1 -
 .../media/platform/qcom/venus/venc_ctrls.c    |  5 ----
 8 files changed, 31 insertions(+), 35 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


