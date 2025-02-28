Return-Path: <linux-kernel+bounces-538561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D9A49A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F663188C08B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9443626D5B0;
	Fri, 28 Feb 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YhTyNl+G"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05117256C8A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748125; cv=none; b=AQw7cO38wa2mX63WcJ2TNywe7FyPG4GGHnKT7a8xFScwnVGanBmUyunr4I9EVAgOFwu55j7lanHC+f1qPL7tbPaq8ElGzvVxDxvP7Ice78zh8ZmFukHDQVIwhr0MxnO+Oyr8bZnweEezZg8V7ab1sT20vxOdZDpP7uA3lHyQuTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748125; c=relaxed/simple;
	bh=JQjJrJS/Q6j0d3mNC8vx2up0gjpozCsC54882zD/Dhk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZcP8284RSXAnUOpLTBeopLo2THgch4D0FOTW8xEThJnxLrLAakbzXt/mBGPpzt0yIdoIHFrOA06M4hi6pt6SA6d72Mv2HcS7JcVTCs5xmmf7GCgPGlfNBi3/8kEkCEUKbTUbM94FJhRzsMKJHO/4zWQy1dWqyZDHaqPqoUznEWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YhTyNl+G; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e44fda56e3so19302886d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740748122; x=1741352922; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=THJY3/uU/63uF+brTBz1ZZWdKaiUxcBAU30d4gq849w=;
        b=YhTyNl+GzALc90pFU+QmON6/tLHT0h6IBOTuzfLRHFbBwqi8FaOKiL/kHgMu2k7ABb
         x8GzEbp2yGzhlc2wz8z6/sx4pLFlj6dfYAYiX8cmS3t0nmb+xuvIeg0CYX/t1qAym+Om
         IxJz/fpagBCBpQwzsG+s7rkyqRQVQnlGIiVpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748122; x=1741352922;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THJY3/uU/63uF+brTBz1ZZWdKaiUxcBAU30d4gq849w=;
        b=GGl+vCujN87IVZkY3AHfkUAs5oe16z2a6mPCyb/Ma5U7pyfHXVMGXJUUIr3rcJ3OCw
         YhM+UcZ/GuM6DbXW2Y8G/WxXiuEEYHMyYMi4p6iq9N/VRCUHceHfxqYDn1ycU9JKZfTz
         Y6fsIcb5u5pUmJwj8RUfvO0MJCrZMIeDk4YX7ps8cTc5y3dlIf7YsYNBMqYxwnP9aBm5
         cPR9E+zIe+bVM5PZ7/y3TGCj9SUTZvZZBuB55KoaFBzBHR+3GVdUk7GYCT21ThHu2trA
         7S/6P7zf/HTYjG89fXE7AViz1aTX7dz+uguhFDlDNm6Ux+BXrLgppTviuq2CONijuNpM
         +cag==
X-Forwarded-Encrypted: i=1; AJvYcCXoLS9RyqlAkfmHYpNShd7Oa2niW+Wk1fBw7r5RUk5sthP4RY+dbj8XsrY9X7IXO5mCk6uVXwQPKJt2mlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZCb5zqkKf+POw4ETxecX5wT+tH8tUiYTpg3zzo1MjGb0/Aqt
	gAYN+dmUt7Ui6ib6KGPrIchoDJoBAwzWK+L0qp2szg/XVFiY8nhCOl7uMSHhI2HvsOBPL+QpRj9
	LFw==
X-Gm-Gg: ASbGncvhv9sfr5x0Kan9JO5L1m3H8gk6kY8zmUqKoonqS84wmOJHqKFBo1ZNt1wQ6GM
	W3SorzIJXjem/wIx5DLycr7J6aR5cEVA8K6UFlq0sVTyiQas8I817Y86hH7Qv9udUTvl/b2k/E2
	9uNwSFqHliNlOEjfWX/SUUWFpgf68JuFC+zC+sprQ5vBFiBkJsDPqpkWtuZkIiSf4SExzWyWoqG
	HyqlHarx/LaP2nkEKZ9BzrULfcwMas59unLvF6FbP3bTCffPWpCRbU07erMSN7ebiCV+qoNP0UW
	Q1iu52ZJj0zLLtqfxPnk0rQyRW6oe4PEkyWibleN7SDPpm24WSM18FlQdffCg4M7d5222Wt2NAw
	G0Ks=
X-Google-Smtp-Source: AGHT+IHnYyYtvPPwAQzzm93PZVeNxe8lMbnsVbwonTyBY9n82YdubaVzrscIeaJpNfD+KggpA3wHEQ==
X-Received: by 2002:ad4:5cec:0:b0:6d8:b733:47c with SMTP id 6a1803df08f44-6e8a0d9ab93mr50649196d6.22.1740748121874;
        Fri, 28 Feb 2025 05:08:41 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976d9fe1sm21938046d6.102.2025.02.28.05.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:08:40 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/2] media: vivid: Make CONFIG_FB optional
Date: Fri, 28 Feb 2025 13:08:37 +0000
Message-Id: <20250228-vivid-osd-v1-0-16963a0a0ab7@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFW1wWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyML3bLMsswU3fziFF1z88REU4s0Y9MkAxMloPqCotS0zAqwWdGxtbU
 Adn2J5lsAAAA=
To: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Slawomir Rosek <srosek@google.com>, 
 Hidenori Kobayashi <hidenorik@google.com>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.1

Vivid now depends always on CONFIG_FB, but that dependency can be
optional.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (2):
      media: vivid: Move all fb_info references into vivid-osd
      media: vivid: Introduce VIDEO_VIVID_OSD

 drivers/media/test-drivers/vivid/Kconfig         | 12 ++++++++++--
 drivers/media/test-drivers/vivid/Makefile        |  5 ++++-
 drivers/media/test-drivers/vivid/vivid-core.c    | 14 ++++++--------
 drivers/media/test-drivers/vivid/vivid-core.h    |  2 ++
 drivers/media/test-drivers/vivid/vivid-osd.c     | 13 ++++++++++++-
 drivers/media/test-drivers/vivid/vivid-osd.h     | 13 ++++++++++++-
 drivers/media/test-drivers/vivid/vivid-vid-out.c |  7 ++++---
 7 files changed, 50 insertions(+), 16 deletions(-)
---
base-commit: d98e9213a768a3cc3a99f5e1abe09ad3baff2104
change-id: 20250228-vivid-osd-77aa58f35b04

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


