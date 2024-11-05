Return-Path: <linux-kernel+bounces-396540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFAA9BCEA9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D532826B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22CB1D935D;
	Tue,  5 Nov 2024 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JkP0BmgD"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584141D89F8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815572; cv=none; b=ogRcoLr7GmSfTBQNoTh1T1XCjpAu9ZFnWtGM0Lci5rUtuDq/fOwCPq5Pa9VaPo4EEuGQOlvYtvonVKYMgscMP7QfIV60yAwfctjt/2NqbnPSfs4q8sghuEEB3Kh+q0X7TG9vrvgfIP7XidrbSxwB7TlFZA0XqdHBccrP+iEyCcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815572; c=relaxed/simple;
	bh=RyosKProBqD7GdBDeEWWMCeaBTC4J/TV8BuDGgi07uM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X/2g/xZ8VvwrEF798LKmr+srcUTwm5l1CjwaDpkcq6IhHx/iblDs8dC0I32SZoU8uWgJC7rWbVayWvtNADtGBNh6J0NIHlG5XwvsSS+we7eyL0qCXu7CMdlOWG9UGCba6pgPU1nR/EBCFHRuHDsImcsmC+CKxllB4ZuTODoAxP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JkP0BmgD; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b154f71885so443675885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730815569; x=1731420369; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=To1pY+0ejhgy7bPxablm79ffBSWqRzm24XAQuXWVHHs=;
        b=JkP0BmgD1PZ8IMhd6Sx3CK3IsiLVFu5sksFlVh5lkTI2kzXCLwF4D3S0G9QVrawKNf
         PZ4keKMpVOpCnoA3ZZxetcotMimLp0z+7FD+fO3lW73okyHUHn4hRL+Ht49YcNFP+Adm
         mKiW3als/mgXxcy/n9ZGJTulnOHwQu/2DPDyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730815569; x=1731420369;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=To1pY+0ejhgy7bPxablm79ffBSWqRzm24XAQuXWVHHs=;
        b=tY4lApEmiTcA35392GUYfcMeUBFEiKdainHW0Sgvd5+aotQH/AM7VBchTToHYuxJbs
         VmjGPrxuIquBeALXrMTmIFYRsqKNxUNINcUou5/SHXlAOzbyPFSEaxAVN60lmWkv78lw
         jFuI8I2lE6tthJOU8I65KebbWPmcwrR0lMYa3nOQQxx9mudKGxuT/Xt8mfkW2wGM2+fx
         tp0MLgPCJG4HgXQ4pTyYkW2YA9XDMNjzfTrZr9K9oKcf8Cei3lWsO74yrXITAioQR3lw
         Q7tpxNt6bjDpoAr045sDKzptofAv+TRaOFH8poyLLlGhpS4KAI5Su5IKv9hHBNXR13sD
         WOIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLhgnCIjGZgydjjFIbT7LR6o8vPRpmugFl9jeL5cLaLykAhRo8cD99O0NTPd6R4NgzrMRT3yLDx0Q8J20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIEhrw25YaZS/m6NvITlijJZLTqzqN1EOBVAIwLG8NrOaKg2m4
	0HvS9c8Kn2XPIrffaw6kX3IG37oH3U0tuJ2HucOVkBQbG8D/2BmROVPk046eTA==
X-Google-Smtp-Source: AGHT+IGvzADAlPGIc8XPrDiCAfG0jFnnvTAwT4/O8VMAFu7gzQBezviOLrZFmd9PU3FVWJ4iwBD/fA==
X-Received: by 2002:a05:620a:190f:b0:7b1:ab32:b719 with SMTP id af79cd13be357-7b2fb98a15cmr2053691385a.38.1730815569232;
        Tue, 05 Nov 2024 06:06:09 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a816afsm520422185a.101.2024.11.05.06.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 06:06:08 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 0/2] uvc: Fix OOPs after rmmod if gpio unit is used
Date: Tue, 05 Nov 2024 14:06:05 +0000
Message-Id: <20241105-uvc-crashrmmod-v4-0-410e548f097a@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE0mKmcC/33MSw7CIBSF4a00jMVweSmO3IdxUOG2ZdBiwBJN0
 71LOzHxNfxPcr6JJIweEzlUE4mYffJhKCE3FbFdPbRIvStNOOMSmAA6ZkttrFMX+z44qrV2KBp
 rQAIpp2vExt9X8HQu3fl0C/Gx+hmW9SeVgQJlyjSojLgA6qPtYuj92G9DbMmiZf4SgKkPgRdBy
 Z1FXWujOX4RxH9BFMEyo4zdG6adeBPmeX4Cx7HdiDMBAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.13.0

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v4: Thanks Laurent.
- Remove refcounted cleaup to support devres.
- Link to v3: https://lore.kernel.org/r/20241105-uvc-crashrmmod-v3-1-c0959c8906d3@chromium.org

Changes in v3: Thanks Sakari.
- Rename variable to initialized.
- Other CodeStyle.
- Link to v2: https://lore.kernel.org/r/20241105-uvc-crashrmmod-v2-1-547ce6a6962e@chromium.org

Changes in v2: Thanks to Laurent.
- The main structure is not allocated with devres so there is a small
  period of time where we can get an irq with the structure free. Do not
  use devres for the IRQ.
- Link to v1: https://lore.kernel.org/r/20241031-uvc-crashrmmod-v1-1-059fe593b1e6@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Remove refcounted cleanup
      media: uvcvideo: Fix crash during unbind if gpio unit is in use

 drivers/media/usb/uvc/uvc_driver.c | 30 ++++++++----------------------
 drivers/media/usb/uvc/uvcvideo.h   |  1 -
 2 files changed, 8 insertions(+), 23 deletions(-)
---
base-commit: c7ccf3683ac9746b263b0502255f5ce47f64fe0a
change-id: 20241031-uvc-crashrmmod-666de3fc9141

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


