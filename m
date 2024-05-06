Return-Path: <linux-kernel+bounces-170422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AFB8BD6A2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3DC4B22B32
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FBB15B997;
	Mon,  6 May 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ti5kdVUC"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF496EBB
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715029831; cv=none; b=NGtmOgg71O7ereEMkBqMH8hDZ8+IOuTpstGGpGsNJjWck9lC94aRXhpEp1vmP6vrFklt7GJoOqwmiAaDVsXvthS4T2EyaUx+Et0Rjbq4t77hJWkGTVAD/r4uDJ017xSRZSbN5tU2R2livD6jiL/gNMzDuK2sVObUlh449JLwSrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715029831; c=relaxed/simple;
	bh=hlKSh3+fVOYGLqDRFhNN2z7IDlVFYJiY/t1NMzneb+s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m8t5ibQZ628bhLyxZn8F/hlzWgpHk/dw01BZ5KBy97ZmbTkCOc8C/JfBtyLjwaIKNqhZtEsvnTyHkMQ8t7OOQoxkc2cojFZB6lksgCHdAfvi6Q5A0Qqr5qn/yMNFANqu6Wton4kLmW0568VpkN8FUYhQftMBHP/vqrhQ9lM6ZE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ti5kdVUC; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7929363c7a3so185114285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 14:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715029828; x=1715634628; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJlz3tHuOCtShrTLnbsBX1r1HOOY5sBoGqISo2aDg5g=;
        b=Ti5kdVUC9xXZOHSyp/F0NmfrWMF67MVVgdwsipcX2pKQCF6HdqoQPMVZ1FeCJjjboX
         U9ulxGej8qLL1Qc3Eel96jO2KEtTm8RBd7ZHpvrFUorGvU07dnKqIZmZFxZvAO7osooi
         r9eWruWdg0uyFNHZ3oTWS1L8QvZEokS9bFMiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715029828; x=1715634628;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJlz3tHuOCtShrTLnbsBX1r1HOOY5sBoGqISo2aDg5g=;
        b=jbAH2omRUCyXRnbV8vAnsY9QblcRKsqYmrHORGlBxTfAGUFjHHx8FR941xo35KrB0l
         Cq7LNsz+fRJgN0TsE2QsmOR1v72LJcPm0qtmGfbTcGXtmBvGnPJkt+iGE6bfrb9IHNbj
         sPqm2wwPHQJPd+zeTkRVZKKdnOrdq6q64f+z26MnNSlDmrzQQWz2ayIPKn6LM6MNhVHD
         7RSKIsxSO1yig5Tpjkx98Dg8qkiJ8Pa57ry9RG/52tH183XsOu/1HSIC8XCuYEXEHOHO
         idzfmd2xNorq5ueJV7Dez3bG4uJUg8ezjVKvQ9DMEFmaJbPh3BhH8L1q5f2odbqN2gnB
         Kdsg==
X-Forwarded-Encrypted: i=1; AJvYcCV0cvymMU51M9fRHMyM1YfBTx7qpEUg+2UFOzPBwJRZBUtp+mqXjVoi7HUetd36jEy8RLRAFiORLqwaeTxGSfZMhy/p+VT65p1mL2zJ
X-Gm-Message-State: AOJu0Ywxuk/2l3pssygQFSLrGRHKYRwINgkzoEghYtWZKk9sRF/2PThp
	ezVRynYbw7qSOpkfywZ1dU0aKvaEQkM1kwrpb3chovUQUiOhWJEamQ3KI3AJsEUQfYO8hxZOCIU
	=
X-Google-Smtp-Source: AGHT+IFqXcvbB+ZXiX7sQ5ikGKKxOv5UTqaRx5oADWm5KdYHjiCmw8tdCy4Ec0oH5QsjMbZl9k8Kkw==
X-Received: by 2002:ae9:c316:0:b0:790:ed33:5b91 with SMTP id n22-20020ae9c316000000b00790ed335b91mr12288745qkg.56.1715029828406;
        Mon, 06 May 2024 14:10:28 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id pa20-20020a05620a831400b0078f13e59dc9sm4224921qkn.102.2024.05.06.14.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:10:27 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/5] media: Fix some cocci locks warnings
Date: Mon, 06 May 2024 21:10:25 +0000
Message-Id: <20240506-cocci-locks-v1-0-a67952fe5d19@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEJHOWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwMz3eT85ORM3Zz85Oxi3dQ0oyTzxGQzS2PDVCWgjoKi1LTMCrBp0bG
 1tQA7SIPqXQAAAA==
To: Andy Walls <awalls@md.metrocast.net>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Young <sean@mess.org>, 
 Jarod Wilson <jarod@redhat.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

After this set is merged, there are no preceding lock warnings.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (5):
      media: ivtv: Factor out schedule functions
      media: imon: Fix race getting ictx->lock
      media: dvb-frontends/stv090x: Refactor tuner_i2c_lock
      media: go7007: Refactor Adlink PCI-MPG24 i2c mutex
      media: drivers/media/dvb-core: Refactor dvb_frontend_open

 drivers/media/dvb-core/dvb_frontend.c | 116 ++++++++++++++++++++--------------
 drivers/media/dvb-frontends/stv090x.c |  37 ++++++-----
 drivers/media/pci/ivtv/ivtv-fileops.c |  66 +++++++++++--------
 drivers/media/rc/imon.c               |   5 +-
 drivers/media/usb/go7007/go7007-i2c.c |  30 +++++----
 5 files changed, 149 insertions(+), 105 deletions(-)
---
base-commit: e695668af8523b059127dfa8b261c76e7c9cde10
change-id: 20240506-cocci-locks-ef2b7ac6931e

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


