Return-Path: <linux-kernel+bounces-289646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31909548BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036C01C231F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AC71B3F3D;
	Fri, 16 Aug 2024 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MjjucQrj"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462BB191F84
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811433; cv=none; b=X7BmXbET+xHPiubas3zhUbwKJG7uN2CMxPAUxllpnLug/cGt1vdoafbEUq5atKVoBcLmMOLCwVdk5jY4HMynDE7yPkfl3fhmdJXO0EwPlXLHumK23UnMfIgVYX4ftW/2Z5QXth/MmjMVxnr3V7bChCCmZSYlRxf/JNB33ckQy5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811433; c=relaxed/simple;
	bh=bF96qGjIJuqOSQx7yGP35NRVXw3p0C9h2o1ZVPMOJqQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WCoi9Rf5BoqNOHE1yFh093ysRPrC09GqPJZ2K4aqtAUDUrAVqOJ9oI44/JjpOysg/o6usMuo1W9PM7hBbySGbwvVBqw5GKdZCS8ArZuiTXq2bepWR/91nb0cAMsvdpg3OkrScWtuwKkqVJnqCuIbsbYfWXZwDMoSaZ0Ualpl+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MjjucQrj; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44ff398cefcso10304491cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723811431; x=1724416231; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QdqnwV/8My7ZsXaxiPdrFJraj6n50cGY77+beyONLnk=;
        b=MjjucQrjVL3er+kWyZBFf3gklBkC9HGhjqnl6ISGjglRi6MmPqVTYpUYUmHTYNwKbq
         ZHGiPG23w7f9U7zRAh94CgCbfLsBMwR+03DW3TgBsNguyfaW/dUqHGWYKILS9VVUoUwk
         iqe/i+PbBHurNkXQHX2U+jUW9tjJv2KS9WzdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723811431; x=1724416231;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdqnwV/8My7ZsXaxiPdrFJraj6n50cGY77+beyONLnk=;
        b=SP/vJrUlw06rHzHmwrquYG8EF2QBSzohURQF5eamzJDlBigHaiO74XgNt3/hV4rp7i
         fR1Bod1AFkl7IvVel5oSH48n+3YV5+u7rtFpYVix1PgL6mSDEFkY7gyH4wwtqmz0yZ7G
         7m0bJnfTkTd06W2/6OFlvykkdo9U9zRe87gJPmYougQuzjast9u9SaT0ZLelPROow3tM
         o2AvV/yRUbY8bzFJCQnGiIy6gGaJfE1Pwq/+WbpAHAOWR6xjp0kSYy1TTarfp90d+dmB
         c1mUy/+KF7/E7Gnnhlz4PUdAZ6J9KXihILX/cFrsyIuAvNK8we7lPtSgNXDmQTYim3Yq
         qtyA==
X-Forwarded-Encrypted: i=1; AJvYcCWKwjfOdpzRmfEyUZzx70LWF4FhVuB+uZMGA9EJ2rVdE/ya8taRKtqxzEHfH9j4camB3B4SQwd0LDS2wDlIO4thy/nCzdmSHot6yH1Z
X-Gm-Message-State: AOJu0Yx4P/oEsqKRI0aopFDiwJtn/8AsLjoZZBaY2IiRTq1sBGPJBAuq
	ebnZxNneASzWM9Ug85K4t3sYzh2nBmbHBA4+VfzsUja9MxJ98uHJcJGRKk23TkKXQKa52LzQ2EH
	lUA==
X-Google-Smtp-Source: AGHT+IFWrKEu60boV0BdGCD6oBwBxN+OQd3EHJdrhPE3nqpCWT/zZBK79/jfy1poGwlZ8oDMDxrgIw==
X-Received: by 2002:a05:622a:5507:b0:447:e769:76fc with SMTP id d75a77b69052e-45374268a00mr28612061cf.34.1723811431035;
        Fri, 16 Aug 2024 05:30:31 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd9e39sm15853051cf.2.2024.08.16.05.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:30:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/3] media: Follow-up for coccinelle lock fixes patchset
Date: Fri, 16 Aug 2024 12:30:28 +0000
Message-Id: <20240816-coccinelle-followup-v3-0-79fbc2742fa8@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGRGv2YC/33NTQ6CMBCG4auYrq1ph5+AK+9hXJQyhUkKJa1UD
 eHuFjYmxrh8v2SeWVhATxjY+bAwj5ECuTFFdjww3auxQ05tagYCclFKybXTmka0Frlx1rrHPHF
 TqBIaURcGBEuXk0dDz1293lL3FO7Ov/YnUW7rfy9KLnhroMVag8lAXHTv3UDzcHK+YxsZ4cNUM
 v/NQGKqqskxV7UyRfnFrOv6Br60ouoAAQAA
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Hans requested some changes for this patch:
https://patchwork.linuxtv.org/project/linux-media/patch/20240506-cocci-locks-v1-5-a67952fe5d19@chromium.org/

Refactor the patch and try again :).

The changes have not been tested in real hardware, and Mauro expect that
it is properly tested.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3:
- Add missing (dvbdev->users == -1 && fe->ops.ts_bus_ctrl) in __dvb_frontend_open()
- Make explicit that the patchset has not been tested in real hardware.
- Link to v2: https://lore.kernel.org/r/20240814-coccinelle-followup-v2-0-88b4e4a9af56@chromium.org

Changes in v2:
- Checkpatch fixes.
- Link to v1: https://lore.kernel.org/r/20240611-coccinelle-followup-v1-0-df2de9c2f320@chromium.org

---
Ricardo Ribalda (3):
      media: drivers/media/dvb-core: Split dvb_frontend_open()
      media: drivers/media/dvb-core: Refactor dvb_frontend_open locking
      media: drivers/media/dvb-core: CodoStyle for dvb_frontend_open()

 drivers/media/dvb-core/dvb_frontend.c | 159 +++++++++++++++++++---------------
 1 file changed, 91 insertions(+), 68 deletions(-)
---
base-commit: 03a979b74dc1ad5aeed8026a84d8771842cb1631
change-id: 20240611-coccinelle-followup-f5a62b095f20

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


