Return-Path: <linux-kernel+bounces-528713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC2A41B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2819816BBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B82B254B15;
	Mon, 24 Feb 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K7WiLPpb"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06972505CC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393298; cv=none; b=hk9foxJtb3qhxCYGW+tpRB9mAzJHMcTx+Nx7UckJzxtP9Y9svO9Y2vkVqereGmytJn6QyM6B7vu4m53yoYpob+1wi+bc1goRY126EDdirX2FvfC+JMgBad7rAup6VT9QQescYHSH0C4pgUK42XMwTXBMtD3I3M7V+wqcMje5r6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393298; c=relaxed/simple;
	bh=ifUIY51mD67INF7Ty4UagC3PivMGO5cVpDC7jcHo0ZI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lBvqrUrhG9pM+mQqvFR4mApOiICGKU9S+kkMcymN9BBgeXaGRSyonpKId+dQP6G8/qwv/51oAr8S3F3afpdXpPdjPqRE1TJFmepdCTPW0MJRf/9jsHd+tANT6okwdiklmdJR3VHCMMmOKOwqUakSq0v6MXJLxKyJyEkuEsA7mnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K7WiLPpb; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0ba9825e9so261045385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740393296; x=1740998096; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rpru3d4kK5T418MxLBJyNUhgDCiefpb3TqvSQ99StII=;
        b=K7WiLPpban+/3jcskyaCoOekweLRJ702vve3L/TaqC32asKRrv4QJ1QeyW6teSTnlq
         ZaxDpi/DxurliHCe+ZXBAPP4enO9FytrwMK4rheOrevy4U77lsZQK6yB9LWa+5jqcmgu
         XIWaGysyZJkUuILTQLTM4TfFU/ZHCSKJC65OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740393296; x=1740998096;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rpru3d4kK5T418MxLBJyNUhgDCiefpb3TqvSQ99StII=;
        b=Ey73miK4F0Jm4Zqok78RM19s/PWPT4PW2J/B+/rg6Rqaaly6JANVBAJ54fxrJtWC6r
         uyYLVWETpc+6V3IiOJkpGihBbLm7Hc+/FQZWv4AX5XG5tux3d8o9PufAOPTROAK9FXOP
         grNqEzI4343JNU48R8xB3xydgXlI3NNHm9OMwUwpPDwRVUGAHjWNqIplhMqrVzO+P0mE
         3xHvT1S2kfkr/E56gS1FeJEQUZsjru+8ZxNozszDJS3XCic/ALf5RPMe0gdp6JnoMiKo
         4xdewHXPSw1edZ1vw/Sdp56QparZKQiZF/tOeHp3BjWEughfIgXD1TqfM/9wJ9/BRs6F
         m3aw==
X-Forwarded-Encrypted: i=1; AJvYcCXKKeKF0uOib0sDNBnnOpLio8m/7hys6DghA12gVbR4zPSdhU0/Ma+IQQwS6tWXgH0Zjt8HEBehOdf2m0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiB0aiuWbKYWD0V9oneGRjD/Cbshhyt78Gdd2IaV45v3jRUaFK
	JK76sXEmxQRy+noMQydYbJ9A2sxPLYoiI7ujibdpPSLtgJuBCoqzt4xP6ZhjBg==
X-Gm-Gg: ASbGnct2H2FpfC3fw9KVzwXDFhhT7WadzrRkl/79h6Xx3PURAa+EzHZr3gq1AWqFmIg
	ipnb9mRRGIh4Sqp3/cwcXNq6CpzDPekPUST8456i45AkrVbPgB7Ew5V8TfNWuBKHbRVgHNkHgt9
	aVjhCCTkC+sBaF0n1Ch6mMOq0RmG36+1jBnf4som9KOGtTb9dpVBt78ivuqd4SAAc4md7yU7QzH
	vESvWoOLcLL3lS5kKgAGCwOLmxtV0GH9fptmiijseE0Jlm6G9Km+2fi8ytWRhGxDWMXhX5jTAVV
	ygHxohwQvJbxj1YQvN5eomS7ttnX7ArhAnXJl7Sfow1dDBZmFiCJg7zMDcAWVies2P7YKEART7C
	SaeY=
X-Google-Smtp-Source: AGHT+IEwuaTcW/NqR0O8qiW1KQMI5TU+w6SLZl+84kr+4cdqIGTyZOv63vcOE4pdfK+EPhQ2Y3R4ag==
X-Received: by 2002:a05:620a:444c:b0:7c0:7d64:6da7 with SMTP id af79cd13be357-7c0ceefd41cmr1639587285a.21.1740393295682;
        Mon, 24 Feb 2025 02:34:55 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b0b7f637sm787139985a.33.2025.02.24.02.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 02:34:54 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/3] media: uvcvideo: Make sure the ctrl cache is in
 sync with the device
Date: Mon, 24 Feb 2025 10:34:52 +0000
Message-Id: <20250224-uvc-data-backup-v2-0-de993ed9823b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAExLvGcC/3WNQQqDMBBFryKz7pQkSsWueg9xMY2jDkUjiQkt4
 t2buu/yPfjv7xDYCwe4Fzt4ThLELRnMpQA70TIySp8ZjDKVNlphTBZ72gifZF9xRVJU3/qhIeY
 G8mr1PMj7LLZd5knC5vznPEj6Z/+3kkaFda0rzVXZWFs+7OTdLHG+Oj9CdxzHF3WLwHyxAAAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@kernel.org
X-Mailer: b4 0.14.1

Hans discovered a bug in the error handling of uvc_ctrl_commit(), lets
fix it.

It has been tested with v4l2-compliance -d /dev/video0

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Fix commit message (Thanks Laurent).
- Change logic for err_ctrl. It looks nicer now.
- Link to v1: https://lore.kernel.org/r/20241210-uvc-data-backup-v1-0-77141e439cc3@chromium.org

---
Ricardo Ribalda (3):
      media: uvcvideo: Return the number of processed controls
      media: uvcvideo: Send control events for partial succeeds
      media: uvcvideo: Rollback non processed entities on error

 drivers/media/usb/uvc/uvc_ctrl.c | 53 ++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 13 deletions(-)
---
base-commit: c2b96a6818159fba8a3bcc38262da9e77f9b3ec7
change-id: 20241210-uvc-data-backup-a0a76df9aee9

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


