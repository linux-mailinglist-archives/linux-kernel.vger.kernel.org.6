Return-Path: <linux-kernel+bounces-355475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246649952C9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5674B1C248A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98D21E102F;
	Tue,  8 Oct 2024 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K0UpnBBZ"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27ED1E0DDE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399613; cv=none; b=Car9y0r58XpLXEr7BI+4WvzQTNdOqrhbfWPzOOiwXIGREA1iC/h6yaZf+oxFkPpeLhdlgzVVD2BI4uqueQLYWD7eMUT9GLAjm5/3kEoXjt6yIQAGXtA2XdAQ3B3Bgk0bTii9PowxKXz829JCX2TtNnaxxECquhn3sTKvnrKZRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399613; c=relaxed/simple;
	bh=fB8wPdyHy0ruFXLPdPg1YMrsIEXSnFE6R8nK/u6IlDU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kf2sT+xgSPRVLmhBzum9Fr6lZmQoS4dpd/BTJ6IE+c5FGDpQ3hKsBtDCmOT7fVVz2hSP1utPd0qORhj3fjTugJJkhGXTOuYOjNklhHX54U3o+12V1xwpM8LrfPLpXs1dUurGgeb8l8pxkE5kIIw/0aRkBjmGFPP4o9e3KQK0Jgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K0UpnBBZ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9b72749bcso488554585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 08:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728399609; x=1729004409; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8e25TBg3r/kV0lKd0SznJNEmKH9RSBCdHNOg8ma+Ik=;
        b=K0UpnBBZQWEQpfVEDBQEqC+94GQrHO0iVY14rIKVEzATU6/q3BOnUitznNefC3nBeS
         0XiC07TVzo/3n3TZQyZTAv75Jc/GVAOeJJ1cLyzK8TL//2oZRwDMAhYu5U3TF711gMWe
         bOkQ8bUPgVryxzsWJxDENVMjr01ICifej4atM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399609; x=1729004409;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8e25TBg3r/kV0lKd0SznJNEmKH9RSBCdHNOg8ma+Ik=;
        b=t6KblhTigJ2B4IVyaqUSTQkjVL12AMR8Fn38RP8DOH7PzyA0gfP5BkGP+9oJb9Fp+F
         Kzu1Pf9vf/xQl5GlkSIW2bqO3CK/CQYAPCmrF9JGbDKS2fkfbX/T8hMJimXQ3j2woflG
         6+zMYVuEe9jZ8UvisbGsNnoGs/6GP7oSE0t+7UKWb+OjZCqSBqzfopUMTUwZve9A+8G+
         d5AofKfFHIagh0LiG2ElAtemZblRXpmhUznqfdOWf4lafu9YrtfYKBQhOk1M57mGYhGJ
         OnW38tQx+jJwVKTlcYGi20HHadZtG3RGKq7npQKKY1dWx742fFXxkn+o8CBgE2vMViGU
         UzpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlpAvRkp33OFQ7GS9YR2GP6lI3wPe7WhgrYDwi3P87fKk9Bn/Wo5sgZBegsbV2yPahSO/kgpi1LJ00XW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwncUDzgeyOVYHFTeM3PxIj02tYotOMT6gXnlfkO0/MAkmbCH2y
	gWo1Vd2Ynau5tCsJwKS2APtudDmtrB3mgOma3qGNngcK82g777m5axmRl8kM+A==
X-Google-Smtp-Source: AGHT+IHXENak+TMDoF00Og9xFSrFvlDH1rXWX5ywyh1MscQhuH3y3sDASJnCumrz7mMpx1Y76cc7Mw==
X-Received: by 2002:a05:620a:2494:b0:792:f429:9e9 with SMTP id af79cd13be357-7ae6f43a81dmr2449319585a.22.1728399609268;
        Tue, 08 Oct 2024 08:00:09 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75762a36sm360886085a.124.2024.10.08.08.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:00:08 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/2] media: uvcvideo: Support partial control reads and
 minor changes
Date: Tue, 08 Oct 2024 15:00:06 +0000
Message-Id: <20241008-uvc-readless-v2-0-04d9d51aee56@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPZIBWcC/3XMQQ7CIBCF4as0sxYDFBN05T2aLiidlklsMYMlm
 oa7i927/F/yvh0SMmGCW7MDY6ZEca2hTw344NYZBY21QUttlJRWbNkLRjc+MCWh2+k6WO9GObR
 QL0/Gid4H1/W1A6VX5M+hZ/Vb/0BZCSmk0c6bi1WTMXcfOC60LefIM/SllC/pl/3hqwAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

Some cameras do not return all the bytes requested from a control
if it can fit in less bytes. Eg: returning 0xab instead of 0x00ab.
Support these devices.

Also, now that we are at it, improve uvc_query_ctrl() logging.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Rewrite error handling (Thanks Sakari)
- Discard 2/3. It is not needed after rewriting the error handling.
- Link to v1: https://lore.kernel.org/r/20241008-uvc-readless-v1-0-042ac4581f44@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Support partial control reads
      media: uvcvideo: Add more logging to uvc_query_ctrl()

 drivers/media/usb/uvc/uvc_video.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241008-uvc-readless-23f9b8cad0b3

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


