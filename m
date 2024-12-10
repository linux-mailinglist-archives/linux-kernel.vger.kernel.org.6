Return-Path: <linux-kernel+bounces-440424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB109EBDC3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1392028ABB5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330481EE7D8;
	Tue, 10 Dec 2024 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a+1CNP7G"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF7C2451FD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869351; cv=none; b=HxdiIyJmcoVtPBO8gEGbRpAKdMSmACeiEnsURv+7IbADW9e4u7ysuc1U5IySoaEZ79FL6T8WN8SPVkd5TkMBZ171AWIWR8gJ1cHDGVdlQRSWSgBsSYqZTP1nKC19M754uio4ZynhZt9tRME2m6EQpo4YMBRKs0XhJKJzqHuArME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869351; c=relaxed/simple;
	bh=V1x08Augh0N8zS4WoYR8COXWztq7IXbX2aD821/ojaE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q9xZq+t4n84IYro4B+TEsitnhsRgfk9Anf+v8HYl48ZJVf8FjRZ7PBKhTWwlk8E9XGzjF9fB8Dx3x6qw4S5wy51bkBJKFcmwAwr3bDUemIZCY6jxntiNgbEubwgih5uOiVtiFHf+d4j1H6Pd4QiOFWVtlas3RKYHl28z2tt4mrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a+1CNP7G; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46779ae3139so10704301cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733869349; x=1734474149; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=80gtP0ngYWDT9HQaW1nB5mPOKiesHJp4rOBt26DOPw8=;
        b=a+1CNP7GOZ3E51x33aD+QU1SDuFl3/ff3PxGGCkVFvZw33n8BkoVyAi+H0O2XCMVjO
         RDLx8CkoUawf4LClqfJiIiS30YJjgmdx7VHUKBtR94NzRnvJSrwUMQovO+2/pH/WIMqf
         Py8ehtMH/l+VpdpYNPgNnh2mehIvqQ7cdQJQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733869349; x=1734474149;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80gtP0ngYWDT9HQaW1nB5mPOKiesHJp4rOBt26DOPw8=;
        b=XRgruUCa0aqTnVLzAXyWgxezblzNkRV/Lz6jnu3ALu+w6L5INp/ocht6qyzYkRX4+8
         YdX1EoQAHHijwjLjk9ARjiMODjGYmGOklLMRBKIPGGOOCbNbnPFM1AD8a7Fgpi5P5P4O
         YT1x1pdlO2vSrOVO2SeS6fqn34fkn23GVFtmLxNV2CJ9oJpG0CvyHQHJfqYM17U/kzps
         hpO6zlvEgsRLBmKJyCDxhYrUGK4VNKERLWMCP94VXNQJkm9NVzyWP7MbpnDSvBXYfao5
         QPGiCPEvowS/jj7ySfBN6v+jhhnJ14wtIZfGEWsPUQFcHIs0H3vd867vEkCmCPkehrUd
         JY/w==
X-Forwarded-Encrypted: i=1; AJvYcCXKwe/spLvc6yuwdnUrN0GvWj4j1Xe0CbI5KkXaiDjlj3MZxSYdIfHrcQMe+Xp8k6YiXF7TCo74HkfRxEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3NPxhNRO35RdDasqiGG7jPXvAFrK9tZC1VgENmCPOoH23FIqo
	NLDsoq33Vv647wQaVaGvOk0t3x28uUkGSSKIVn8Lff3QWDGgcjOWWC/lqPfx4A==
X-Gm-Gg: ASbGncutm4QNuTb4bfkLCPuMHPA4Vv6RnxLECD6Pb4nE/WMUWVXJDRZA7gxX5baHDYm
	+sv19U+Vq1gf91vMCmxPuCMLJ7xJNTOg7UPYVwMTwdeREXAQsjXbx23a6mxHYpQSdHIQNSNr/6S
	OvPdvIlYIY86md1NzkcYoCBXnxu3c8OOjjmrcVnlY/128G/NB2oi6eQh0qCSqxZHqHsufcJG4xI
	RP36idtJGPsFMBLrgvRsa9rEx5U9zV7zTTFUk3a7bmPHiS365v1NHmNPUHo4dx6fwgoa3okuoaI
	Jea1O6zSYgWFBVqf/NlKU7gAuV6a
X-Google-Smtp-Source: AGHT+IEqvKN5D2JMUTEWKfZAruKq84kszVloqMpYuEmVddRjUvOcyBbOwyWuSv0w1/0urvG+J2KSgQ==
X-Received: by 2002:a05:622a:4812:b0:467:5d5d:fabf with SMTP id d75a77b69052e-4678935fbb3mr9472851cf.25.1733869348950;
        Tue, 10 Dec 2024 14:22:28 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467776034b0sm11232441cf.74.2024.12.10.14.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:22:27 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/3] media: uvcvideo: Make sure the ctrl cache is in sync
 with the device
Date: Tue, 10 Dec 2024 22:22:21 +0000
Message-Id: <20241210-uvc-data-backup-v1-0-77141e439cc3@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB6/WGcC/x3MQQqAIBBA0avErBtQicKuEi0mHWsIKrQkiO6et
 HyL/x9IHIUT9NUDkbMk2bcCXVfgFtpmRvHFYJRptNEKr+zQ00k4kVuvA0lR1/pgidlCqY7IQe7
 /OIzv+wGrpKUWYQAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@kernel.org
X-Mailer: b4 0.13.0

Hans discovered a bug in the error handling of uvc_ctrl_commit(), lets
fix it.

It has been tested with v4l2-compliance -d /dev/video0

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (3):
      media: uvcvideo: Return the number of processed controls
      media: uvcvideo: Do not send events for not changed controls
      media: uvcvideo: Rollback non processed entities on error

 drivers/media/usb/uvc/uvc_ctrl.c | 54 +++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 12 deletions(-)
---
base-commit: 6c10d1adae82e1c8da16e7ebd2320e69f20b9d6f
change-id: 20241210-uvc-data-backup-a0a76df9aee9

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


