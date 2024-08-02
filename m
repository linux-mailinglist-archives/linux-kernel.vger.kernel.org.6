Return-Path: <linux-kernel+bounces-272625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C1F945F18
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A5428142F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2241E4EEE;
	Fri,  2 Aug 2024 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCJo1NZ6"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3C1E2126
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607476; cv=none; b=eTn+QDCyHXWYsN34m1h6Y58XNRhJ77OX+c/YaY5Bhb6n2XgTORybn6gNMKVKq8W8YW5orNb9ZKBBRv56d7SozV/p2qbtZlOW1P81U+27RnwmfcShOl3ONlDwRQFUyAtWZzxMK/L4yZ7gjIgAQg09NV/WcEw0LVKuQP0WUMZe/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607476; c=relaxed/simple;
	bh=v77cwNShmFezFzT8d+JgAmIoTeBjLxB9xrt+JbBBHdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mp1DM5ms769BzJ/d9qdNzd6pDL9PMoh9+9SI8LHw0gw5jkKtD0ucTabKHa550rWv73qY4OXH2yYHDRr0ePcS0p62IIUYT7DjfGAL9UBmjP/A1bij3e3EAdMM2m02Gzak5Kayy3rMd8eAxIasexmE4YniWpQ5Rl0DfoZ9UaWlUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mCJo1NZ6; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso92290411fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722607473; x=1723212273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XQ76l4w8z6i3u82NvR2TWsAYmCysbThtfoyuYrQrSE=;
        b=mCJo1NZ6cOOBCL+Xhb1jSFBSJ8yS6cjj8VBWqCZuk4cOiG+jVnu2fI2FJ1FnuUazqj
         0RePUVLS0CSonoIyfqhQLj7iZrgFMXED6TbKkQ7zMCbB2AP5u18+zAIUa+pbO+qwfFHK
         02dc/vMyyq4AKB4WrrBYeK80hC49VagyXrhvI/ZdlY7YQdzh6fWi+Hb3ihDI1StUW3GX
         7L6Z82OD/mLJbqwwzsBTPWnlz6kE67ryJJSDpyh+HPDsBYcBS7kBrS7urA5b1GONsTiY
         3EXdm9r/lrUd/g4RfYu8bi/tQoVNT1UT9QM/QknBDSw36tUw9Nr+G3ng5UeZij9ZlaGn
         9y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722607473; x=1723212273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XQ76l4w8z6i3u82NvR2TWsAYmCysbThtfoyuYrQrSE=;
        b=OKqDzNrl2XV5WWtcN2oNa5GcVXtlcWZtMxULPyK8iCkY2N/09vv4ZXoPEqYxjNbsf9
         pApBWiWu4wVXqITXNiCWtJUBOG7pp8PD8K/ZoXQ0m+vhRmEeuPch0YSfhKetr78Nk2xq
         u1xtzvwCMSgJmjmmJtnw34miW5w++LAEBzpzBpHeASWtauZuMZKOcARsqPb4yFPlX4Xs
         dz/FVihX4xc2VJvUS+xkcjri8QHjPSGXNaeZWtWsZw6jrLSGv5oI80Rbdf79HLdIK2Sd
         JATbmYc2CfW9csnZWgKm0T6y6KoXYfFc0sC/anddwb4gBqrfna14x9lkjZulSuUFlmCQ
         feGg==
X-Forwarded-Encrypted: i=1; AJvYcCVRsMpk2iz6qfiBCuHWX4Q+EO/eTdCU/P2PC74ROHApCwCcmtP8b+hMPz2LYKWQYkUifTml2Sbhu6RMti6hD2gLUSiH6mRelx8iF+z8
X-Gm-Message-State: AOJu0YzcFUjlXduUDd2BXH0kCTZ/PuZ4t7CezPuhe4lJMKojIEIibjoY
	N2zYPha5ZfR9dz3BRyGA4iIGmoNXFVIRZrwBUzjTsWrru+n1PdnCLwkuXGlODAs=
X-Google-Smtp-Source: AGHT+IFa3dsyb7nxqpf1mqHDl7C1Vn3R6zk9W4lxxLNyWJqvaF7FyQNPg6M7aONLQ6hrmVIQdw0Sxg==
X-Received: by 2002:a05:651c:20a:b0:2ef:24e0:633b with SMTP id 38308e7fff4ca-2f15aaacbedmr27464241fa.19.1722607472528;
        Fri, 02 Aug 2024 07:04:32 -0700 (PDT)
Received: from ta2.c.googlers.com.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e8d6555fsm29041605e9.26.2024.08.02.07.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 07:04:31 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: gregkh@linuxfoundation.org,
	hgajjar@de.adit-jv.com,
	willmcvicker@google.com
Cc: paul@crapouillou.net,
	brauner@kernel.org,
	christian.koenig@amd.com,
	jlayton@kernel.org,
	kees@kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 1/2] usb: gadget: f_fs: restore ffs_func_disable() functionality
Date: Fri,  2 Aug 2024 14:04:27 +0000
Message-ID: <20240802140428.2000312-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240802140428.2000312-1-tudor.ambarus@linaro.org>
References: <20240802140428.2000312-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blamed commit made ffs_func_disable() always return -EINVAL as the
method calls ffs_func_set_alt() with the ``alt`` argument being
``(unsigned)-1``, which is always greater than MAX_ALT_SETTINGS.
Use the MAX_ALT_SETTINGS check just in the f->set_alt() code path,
f->disable() doesn't care about the ``alt`` parameter.

Make a surgical fix, but really the f->disable() code shall be pulled
out from ffs_func_set_alt(), the code will become clearer. A patch will
follow.

Note that ffs_func_disable() always returning -EINVAL made pixel6 crash
on USB disconnect.

Fixes: 2f550553e23c ("usb: gadget: f_fs: Add the missing get_alt callback")
Reported-by: William McVicker <willmcvicker@google.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/usb/gadget/function/f_fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index d8b096859337..0bfed1741b3e 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3731,10 +3731,10 @@ static int ffs_func_set_alt(struct usb_function *f,
 	struct ffs_data *ffs = func->ffs;
 	int ret = 0, intf;
 
-	if (alt > MAX_ALT_SETTINGS)
-		return -EINVAL;
-
 	if (alt != (unsigned)-1) {
+		if (alt > MAX_ALT_SETTINGS)
+			return -EINVAL;
+
 		intf = ffs_func_revmap_intf(func, interface);
 		if (intf < 0)
 			return intf;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


