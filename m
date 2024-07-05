Return-Path: <linux-kernel+bounces-242029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E845F9282ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F901B2386A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DCD144D28;
	Fri,  5 Jul 2024 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWOl5Mlh"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC5D27452
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165274; cv=none; b=DTLh2zJo70yflxvSwvRloXa3j6HolU4bOHg8VQA7Zp+x3F+TUxH1YF61SXD4n1TGMXLQ6esV1O5F0R3R5/z1/PuGZwkdJIFy8ckw3ZQnbVfnNguqit7RKbWkTEIpH5bC+P+OE2MhLgzdA7mujR80U6qRGm3NmTw7dzvUQqIS+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165274; c=relaxed/simple;
	bh=jbQ5q5LhSciLyKtL+1AOsfF4CeCytQVPMW90/H9uvko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mikERWFvCS4W7WpK/RKSUMUY+I47UED4yB3YXDvQeFTMxHi/MxsT3tcdRd/Z7YNc4uwnQ2iG8sphWAutd7bPn+eTp66G4qynwA8aSnKEtUmjBDhewl04B67Fe4RjUUfEQwxD1wH5Mw0OxjZxXw0NpLgOs97fAHmxmCr4MArv4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sWOl5Mlh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4264a3847b6so9020435e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165271; x=1720770071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6KJhsXFvG3jfI/zxwbibWU1Z/26v1UQR19eucx9gBRw=;
        b=sWOl5MlhK9felBAd5l46pabZn3a3zPaUoWAwz80y8lU1EP4/shqElH+XLMGm6s+jr8
         uDnMeb1c6sbFg4fxg0jn5ozJRjlKjkHYmpr3k+ljO7iEcnjFRC8QyBSR70TkEQrCLni3
         wWc6DBgIF7o0dB2s/XhSnEVGCFTWmfKo9zvQwLTTMRHk43kupyAMTrljHGPTP5Ive9U9
         68Prhziru0r8D0SDg26uq+yFTmPoC2uq+DJQbpfxyfQGhfAlAb+8uKkycIFnxYmliWf6
         XYPv3X+k3wHboITKgnBJ25ycgIUxcomeL8jJg15SCl+q913sfYVLM2DIiH1e8rWlKvy7
         +N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165271; x=1720770071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KJhsXFvG3jfI/zxwbibWU1Z/26v1UQR19eucx9gBRw=;
        b=C7yKWRaAx8kslxujVKyH74+NK+bDRTHnAvcPhjNkcDlo6LOeXXxmOfK7PjlMs4U9RX
         VKPZ5Bjl3gMVIoXclVLhrD45oG2NdJOxhxv7wnszp3485I4pfhsM88sIPr20TD5YtcGV
         sy/oRH1W2i6tEOvajgfTGeZBwN/+Lx3WhuQlTkVZ5jC90GsOx4wk/i2sfLgYZ/u/wMod
         2iuccFGvQ+I+VxgVDwS1ctbqwnPSJCSZ5VvsWK4x6OhCDvPjBFleI1X2ZF459/6V7AS9
         AnXmqAk+t/H8xJkXReqTIZf8cdIoMAVbS98EyM+JmjtIuWD97wRXv41BQWhIwi8WsZ/a
         PvGw==
X-Gm-Message-State: AOJu0YwuiBt96kTouRinJZh/tKNf6rxxhHoZE/EXfTtyWkDmYxu+iJ4Z
	V7cxbyoJzumt8dBLA8Zb/MzYtfzFHM2OJX1ZNpED2NldV0kszZyA5BOwbiTyOd4=
X-Google-Smtp-Source: AGHT+IH/fk17ap0mKcvCjBHYsKARKsFnHGk2OBr9a/KU0sQeKDBtotN1RlHV0vVPB4uOqqAV4bJ1Tg==
X-Received: by 2002:a05:600c:4608:b0:426:5269:9827 with SMTP id 5b1f17b1804b1-4265269994amr5762685e9.0.1720165271393;
        Fri, 05 Jul 2024 00:41:11 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm50837455e9.10.2024.07.05.00.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:41:10 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/6] misc: fastrpc: patches for v6.11
Date: Fri,  5 Jul 2024 08:40:38 +0100
Message-Id: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=sEcf4atXVt+mIDFdV6LfYUBsjzR7AqCvwS3JEYbvW3s=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6N5jI+5/3nAOaVXvYH8smgEHW5aglYbSUEyN 2b63YyWb7GJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoejeQAKCRB6of1ZxzRV N597B/4juli5NePg8pB2dokVrVgn1bt2J+s/jZI487j0fO/CRtN+8yI8zvggmNYLB4uehCv3EWv NNeapsbN9iioLSBklx/wfcsQfBZElgahuBp2kJja0W0LBK5QChx/V75qjqamHEBBSI9+tsU9dsX z5F20PKm6h2al2CfdT3n2nAkWmGxLY/7c4wlBcYoB8oSibrFYERuUudUW45S4dxWYpwNWKbjgib lUzC74BRXpNgul2a7/1S4WbtAE2icmLcwNvLbZDNg9NisI4QwLtyagF0LyeR74z98A2XqQnGYyB P5tGAHwU7giwdAsn36BCinU1rLZ/RIbHSsAPcmc6PdWQsnqV
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are few patches in fastrpc for 6.11 that includes
- support for sensors on SDM845
- update maintainers to cc dr-devel for dmabuf related discussions
- use MODULE_DESCRIPTION
- use memdup_user

Can you please queue them up for 6.11.

Thanks,
Srini

Dmitry Baryshkov (1):
  MAINTAINERS: CC dri-devel list on Qualcomm FastRPC patches

Dylan Van Assche (2):
  misc: fastrpc: support complete DMA pool access to the DSP
  misc: fastrpc: use coherent pool for untranslated Compute Banks

Ekansh Gupta (1):
  misc: fastrpc: Add missing dev_err newlines

Jeff Johnson (1):
  misc: fastrpc: add missing MODULE_DESCRIPTION() macro

Thorsten Blum (1):
  misc: fastrpc: Use memdup_user()

 MAINTAINERS            |  1 +
 drivers/misc/fastrpc.c | 46 +++++++++++++++++++++++++++++-------------
 2 files changed, 33 insertions(+), 14 deletions(-)

-- 
2.25.1


