Return-Path: <linux-kernel+bounces-277856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C7894A757
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35C62862C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657C11E6722;
	Wed,  7 Aug 2024 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blJDFxq/"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D201E4879
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031903; cv=none; b=IsoVJ6P82nIdFNPbkEWGAjP/CmcyJMkL4mPMqSp6yQv0TnzwpiD7DMKV3oEO5Z72PGBKqiVcalciZbd4qZFcs3xppbAmoCn+ENejiZARGa74I/35w/bhEBj+338U0igMjL8Ty3FRXurjXw2k4hoJmw7NQd0NQdWxToKCrni15l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031903; c=relaxed/simple;
	bh=OFBYbEbxE7IS+Qv7SDH4FfPtfE7Rg5E1zGlU0PewGMg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ogrYcncZtRWnvkmBebRQ9j/oHLQ7pc3ah5WTQ2kwIphYWWX8nc+5rt7SnqIaM+vFu/cQFR8rV8iKQk22mR0Zumls3pLUuzUswmjPtA84IpTt4DjISacVbKDYDqe7Zxd2Q/tDwc04wROmvW6EOvoZiKzWJIwW1BSPioeIUzY0Eas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=blJDFxq/; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso26239681fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723031899; x=1723636699; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QvuttAjkPLAVMHVOXYUgt5mVS3UMEYPJRu5N4V28dSg=;
        b=blJDFxq/ORTmJmQPqk1w9Avq2jTyUhku4gIdJJi+XXJxTE+WrkbqWk5m27q7bQa5Dt
         sqnkZyLiIHorhiCxkxlKytI8jaXyamYmpokBPlv5mefysHB3MFdD/w1sAjGl4tf3P/5m
         7jMMMP76TbGgqufgR1hkY3kmuA0HM4Fg6sF/R0i5sc8y/hNAmBBeg1NDFnFyKtbMEgBV
         DZLYtWbbX6gBsnF8V1eqxNqR22XcZm4bu2FoL7U61Ngt7sBWq6WD+TA3xNXDI3BWEpBs
         NdY+Lf8iXGRXQvQ0FMsmQvwO42bQBsRu2Tna+Y4Z2kVJGc148ngyrZzM37D/kgtK3QtQ
         maKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723031899; x=1723636699;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvuttAjkPLAVMHVOXYUgt5mVS3UMEYPJRu5N4V28dSg=;
        b=sk+gB8znwNxmkIAiFiowZaMq6I8qcmbv3eGxkwPX8/zylMQhB4VelpBKI0X3/noezp
         sML0VSGHdM5ac1mHwYYlPRMiZOUKW5yyRhtCJH+QhnnFLkx/sooI3kdvdDroI1yvkYBk
         SAS0pcquFCIXTLn+hBXPXYTc5R524EQlQGOak/Rw8CX9qumw997aYE146BxtBZelvpnG
         rZjcPPdGFFFbOY0gRmkVTtKNqmtoMhzbkAxS3MzGfzfDOAzaUVfcf2lPfL9KoAzhzKXY
         jEJCDKemu25sj3dT1ySBhsn7bNBU/GhRqEMlQUCOX+YIkYfVJ3zgtx9tHLV+1YDNZcm6
         yJQw==
X-Forwarded-Encrypted: i=1; AJvYcCVB744flyK3/uZahsMkfEOI/7hmYkHiJa8CAyZdE5hm70MP3FjYx+MSixoDnkMqWqXYfvBJD+XtXz3+RxjUs9YBKQhEyLhrTNb2bvF1
X-Gm-Message-State: AOJu0YwlbH0Q4zPi/m8kAwpheClub58hLx0NKZwOzLS2TOJYPvMDEpe5
	XT53zC5QPF1guITGcft1vmN2fYHbK/TElEvhvVWu9UYCKcl37+Jzp6i3T/7G+oE=
X-Google-Smtp-Source: AGHT+IFMahW1ZeQ+4SdbQZtKjEpytqYR6C40gi+5yPvZkfOWWpUhdF1d4i/TPsvRGYmNl8byMwOdqg==
X-Received: by 2002:a2e:b790:0:b0:2ef:2c3c:512a with SMTP id 38308e7fff4ca-2f15ab5cce3mr148444871fa.42.1723031898236;
        Wed, 07 Aug 2024 04:58:18 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d45239sm631017466b.119.2024.08.07.04.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:58:17 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/2] tty: serial: samsung_tty: simple cleanups
Date: Wed, 07 Aug 2024 12:58:17 +0100
Message-Id: <20240807-samsung-tty-cleanup-v2-0-1db5afc9d41b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFlhs2YC/32NTQqDMBBGryKz7pQk/iBd9R7iYqoTHbCJJCoV8
 e5NPUCX78H3vgMiB+EIj+yAwJtE8S6BuWXQjeQGRukTg1GmULWqMNI7rm7AZdmxm5jcOqO1xLr
 UJZm6gLScA1v5XNWmTTxKXHzYr5NN/+z/3qZRIVV1n9PL5trycxJHwd99GKA9z/ML995HELcAA
 AA=
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

While looking through the samsung tty driver, I've spotted a few things that
can be simplified by removing unused function arguments and by avoiding some
duplicated variables and casting.

There are no functional changes here.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- fix -Wdiscarded-qualifiers warnings
- collect tags
- Link to v1: https://lore.kernel.org/r/20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org

---
André Draszik (2):
      tty: serial: samsung_tty: drop unused argument to irq handlers
      tty: serial: samsung_tty: cast the interrupt's void *id just once

 drivers/tty/serial/samsung_tty.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)
---
base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
change-id: 20240806-samsung-tty-cleanup-ffae1515a284

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


