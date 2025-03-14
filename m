Return-Path: <linux-kernel+bounces-561421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F99A6117F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B032F461867
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272901FECD8;
	Fri, 14 Mar 2025 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fa8iduWn"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF081FCF44
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955878; cv=none; b=K4V14tofUqftPvYF+L2Spjeif0Sm0KSpvO8OFjaE0ocuc9NGNtkCI0ywRIlFb3X/vFMAQ8z+MGn9MCtix3gwmdEReWcpo2xMpmrjFUdccv70Kkmoteji9WSFfd7N0IMPk2e8Mo1bpcxneDkkqBS+qLtv/2K1OrxAYONNrroKzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955878; c=relaxed/simple;
	bh=qIm+gMdvupKqwS9Xu6DPAYAhkyp9bxQv0TScmBCRWAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VvngP1/viqe1LnRS6koxsqgg4vA4WkyfaIltMoKIyoFnD4no1P9XYXBjRH74vvZ5SsR9Pcu6itpWrb0VWvUyLyHNdgsd7GrmQkE93Ya4hVztzv2oGgBHR5vL8mB36LH1zrBtiI7omFQmp/JhrtJwp+uOUBA1XoTsoVOxKpLthRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fa8iduWn; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e904f53151so17790716d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741955876; x=1742560676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Au/TjH3+zjUdDPhRJAjj0/vsDAjgHCF7V+hbXHtsO9U=;
        b=fa8iduWndcsK9L7/pmbrHFddq+M2vwWCH13NcPwywJnpfUGxW+Us8VutCZ+kkF4U1X
         WGlx0/31lK9yihFLuqPEBgPMB8C0ev1T45ANHHaEvPg3I554zttVC81M4wZMml4ByNcE
         tJKc6/W9bwzIdqFyZ4/RAIaKs3prEYJROZlu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955876; x=1742560676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Au/TjH3+zjUdDPhRJAjj0/vsDAjgHCF7V+hbXHtsO9U=;
        b=llENzrh9zrEjbMU29Y7bXgKqY2+Kz9RzMevot75xILMwUIpqGdjq93F2uMBf7IJ8uB
         gzk3N5kuxOnLmXN2iAowXyx+We3rZYDHAiesPDYTS7BurVaAFXYteVxm2PTMtIPEEoCp
         Bp9Wvc6mbmtYMetB3nnjg/J9CbfKFz3GLJADCCnqNEd9X7pwuSjTNoXzAuPSpNz3li5/
         oOxoL1zMpIskVElQJ7BSyZLsN3AZcj1C01MgN7ZV0kTqto22KrqBL14xlEbtR+Tudbtr
         MFfNHsm7vMVmyosyVFjBJoNj5+sW2ItsNHdU7UWs8LdpxnSEJtzLVFHQNqYZzLZUk23E
         w+Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUAQgtX3Fg9FflTfHtUGCpw+lt6sBmxYxvOzkQqe6QQSuWIA9fCL0qkpsHgIcBBvfG7sNW2potPGanYwVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxucZi3aSvqELH5UFi85v2DuzUcsDZNJrzdQG2OitWkg6KgRMTc
	ZLV2OAMA4OpYBTuSiWqbNQ79i01oK49UYj+loKaH3Ot/ZSdC59BnXNO0UmNrHg==
X-Gm-Gg: ASbGncuBqiyg+htPLjbRSJUkOWRg0Eh8p17CfuKhfKZ/3p5qOVhlc+o69OqwYQLnAP8
	wwypvw67gQcTKZeXJOSVFYDDZZP+uyb/jDwRJYPUUgqpzqUwg2k+mzo7dAleZN9WhixrPt7MfaK
	oZzwVVcNtLhX/9MTiBFcLf3eMFM4nigwDI4ePfHscIc+YJjF/aGeUskRZcYzTTZbDX6FAON+aHJ
	tNMIOICvZ63+fCqycL0eUDZdMSDRpqX4UCVcWsDcMxBzMdO6VaV6AoUmq/nsx9qPrL79G/CucJ7
	wnrTa59IiK2GHND1lppbL5J//YMiPtsM0ZPjUnZwdScXT+ppLyCp8WajQrfj5tQmM27zMWmufJy
	2sb00+4ybnspAFuwlniZ+6w==
X-Google-Smtp-Source: AGHT+IG1soI/f8SA1zxak+RF/DcH11J2/WsE7iepmItBe5lAxghxQPzlLhQXGTbEnZnAJSzvs34p/Q==
X-Received: by 2002:a05:6214:2483:b0:6e8:eabf:fd55 with SMTP id 6a1803df08f44-6eaeaae0998mr29795736d6.39.1741955875895;
        Fri, 14 Mar 2025 05:37:55 -0700 (PDT)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24dda0sm23168706d6.58.2025.03.14.05.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:37:55 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 14 Mar 2025 12:37:51 +0000
Subject: [PATCH 1/2] media: vivid: Fix requirement about webcam_intervals
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-vivid-fix-twice-v1-1-7463c2b0ba63@chromium.org>
References: <20250314-vivid-fix-twice-v1-0-7463c2b0ba63@chromium.org>
In-Reply-To: <20250314-vivid-fix-twice-v1-0-7463c2b0ba63@chromium.org>
To: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hidenori Kobayashi <hidenorik@chromium.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

Since commit f0b4a2c037c0 ("media: vivid: Extend FPS rates offered by
simulated webcam") we do not require twice as many intervals as sizes. In
fact, now we have 13 intervals and 6 sizes.

Fix the comment.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/test-drivers/vivid/vivid-vid-cap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index b166d90177c641eed8116e791daeec8822973ff0..623ba1e5e54791c0ac62aa2f0fcc3dcd444c873a 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -33,8 +33,7 @@ static const struct v4l2_frmsize_discrete webcam_sizes[] = {
 };
 
 /*
- * Intervals must be in increasing order and there must be twice as many
- * elements in this array as there are in webcam_sizes.
+ * Intervals must be in increasing order.
  */
 static const struct v4l2_fract webcam_intervals[] = {
 	{  1, 1 },

-- 
2.49.0.rc1.451.g8f38331e32-goog


