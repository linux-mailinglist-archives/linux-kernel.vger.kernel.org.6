Return-Path: <linux-kernel+bounces-561429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE87A611A2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6523188C64E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422B01FF7AD;
	Fri, 14 Mar 2025 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RCYtp0mS"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F31FF1D6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955986; cv=none; b=s44/WGtAuRKvQIO1upOs65JrqoPDKEqa5BvHyc8fPo6W9vbv+ZS7CcsJoee4bKVBO7/o+Hy08J/tM1Y7m1HsUyrBAYcYhcDLEsl4BsJA6sE5q4dotndvxHcuBu9m6icuPYkzDe+VnW6lkDSdoMhM0qOQcPg+m0a4Qa9aAKOwbTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955986; c=relaxed/simple;
	bh=qIm+gMdvupKqwS9Xu6DPAYAhkyp9bxQv0TScmBCRWAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SstJfT5wXWhIG06LlsAaEUKRhVreSb7FCBqdNLmAjrKcNZzGMKo2kiQQ6ZJZRnQMOxBWCFVboPBBQEM+vH1eplQ4LzoXo55h9efLGeXtXUk6M+9r3TksXS8ejxd2Rc1sYBLN8KROmI7R47aQKpZtVeQFJM62TdGfX0nR2+CsT4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RCYtp0mS; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8f8657f29so17138776d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741955984; x=1742560784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Au/TjH3+zjUdDPhRJAjj0/vsDAjgHCF7V+hbXHtsO9U=;
        b=RCYtp0mS9x/X7IZyj5FN7YikfQjSjJeHf6vCeZ3tA/NiMLUDE1Lo2k6XeP04ZCTugI
         X24ByXRWvlESBucoirMdqyErHwDZezhfrUFpzLDtQFZzNxe1WpQQTgzoETqgYpxPkOEj
         vYtMmlVqxOMpPTCHxFgnJ8BernwO87Ze9mIvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955984; x=1742560784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Au/TjH3+zjUdDPhRJAjj0/vsDAjgHCF7V+hbXHtsO9U=;
        b=H2O501RY+zl0kbm4AwYPXR69QgyMr6iY6m1J0N9ZLYXZvV2rqTB3J6YAwQdNzeoNtG
         LFAhfbcRIuNTvuxliMT/IBU+RQ8OqJnCwLrXanNZgNTSf0hJ87WJtLIhjiQPRtfRLGpM
         cOfLAVCoR0AaZjKhvX5xSMe3DdOt9hFD/0Q3ua+uX8/d4b7xm/fudeMzxoAq0/FkOYnm
         xY4lXPh3ZZRb8ULdOSTu5A1mD3jbvWECm5t0Rq9bRP6WZUdu+IMH7R417OxBAH1Tcp/m
         L7Ult0tUacFqhgnQ4WubF5x/vsiF/sztXh7MR1Kmq4uBfdonoviISuGlYuvnnV0pdCm1
         rWSw==
X-Forwarded-Encrypted: i=1; AJvYcCXW9oM2/wWaTcU7wTQBrsj41Kfv90sAZi671vMiCQQuPV/+EJfyh3GhFiElWhvbKg4xl5ecUVyK/HVma98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoUFgWKoNAfQjhBJ2yYNvaqZ2R12BsKu2KHDpiCRc6z7CILZjj
	KFStFwgbZ+seL9IoAiVAd0RRP3nnByw8aUijrCzMX3BgystrfsVb4Be/TEzH0A==
X-Gm-Gg: ASbGnctoqESHDYx/Xx/7flG0N2e2kaNIYA4fFD+K55Q2mVpuh9haeZGM9EHQG4Gejx0
	mitUhxWpdFaDN0m+UaEjZxoHb4L3/wTl7FPcoyrccJmm8xqUZ9o4eACjy2VdpxfFonPdtjtsDUF
	npZ9NYhmq6MyxFxLl8NbYYuykjRQzWU9ww8pCL92UrFqhUQDeb6eTQHRaDZAUFujWI9BV9Gk0Da
	wQyAJqS5z9fZRUmVqHTzBm9LMQjcbgU5Y0f24oK9UYBY86XHw5OC0aAj02NFCmpsbLBIu2wtJ0I
	RxihbqwOCLfyOpDSCuzBxQu9nZZy0QmOxIkMTxEUOT+Z4TbWv0z0GbU4kl6fcRAz7vTpKdcq3Dy
	7MZxyj/+P9+xDJKPZ15O0YQ==
X-Google-Smtp-Source: AGHT+IFZTx5jtkzAAYrXtZKetF00+L9PUx7D4uoIbbsaFALw34ZUTKZfkspj9EXg16feqafXpXJ96A==
X-Received: by 2002:a05:6214:21ed:b0:6e8:f945:ece with SMTP id 6a1803df08f44-6eaeaa07a1cmr27714776d6.11.1741955983780;
        Fri, 14 Mar 2025 05:39:43 -0700 (PDT)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24b8c2sm23031586d6.50.2025.03.14.05.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:39:43 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 14 Mar 2025 12:39:40 +0000
Subject: [PATCH v2 1/2] media: vivid: Fix requirement about
 webcam_intervals
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-vivid-fix-twice-v2-1-dcfca4053704@chromium.org>
References: <20250314-vivid-fix-twice-v2-0-dcfca4053704@chromium.org>
In-Reply-To: <20250314-vivid-fix-twice-v2-0-dcfca4053704@chromium.org>
To: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hidenori Kobayashi <hidenorik@chromium.org>, 
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


