Return-Path: <linux-kernel+bounces-511099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9B2A325D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6713A82C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D8020B801;
	Wed, 12 Feb 2025 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGQIzx0W"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E32080E6;
	Wed, 12 Feb 2025 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363209; cv=none; b=T8qF7X6FbF/Fe7TmanDEpJ3C6Uz6gcuEGoSnZ0GxkTGSqln7PKwTD9rT8r1Bpr0uCNryaqSgSLsPTPHpPyaoLj6Wc9sw+kWF5RN3W7WJc+oQVZ+fm8dLgeE44qLZBF7jJI7CJXTVOMjs03EZvQYdcCRKBeE5IvFajs7VPt+kDhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363209; c=relaxed/simple;
	bh=/5vDf73OeCA0N4T/7EoMUxHAuvnWQcA5e32GrqPx1nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ofaWWxvIxGpiSH5AawjKczZjoEybu+pECUWN9iAd0uzJ7rAo28ug88mlZKMLfeuBoNo24fgx5u557ZmSq2tjBVf2RW1iYOY7zVNG8riEAuof/N+9cKfwjy48ul62TIOY9EV86JVVHBegyFk5uixPyK0WGwOXV1+3D52UTDGJjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGQIzx0W; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so66509935e9.1;
        Wed, 12 Feb 2025 04:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739363206; x=1739968006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sCu6b3woM+c5soUL+CL/3/8vzh19NcMbxFpr4cPyY0w=;
        b=bGQIzx0WyT/RlXS21s7AcGhRr/Z1Zc77StHWOl2MBDclEwB9c1mVjSxANyRfGZAhgB
         jhR5nKPWpF4zyWrHzr6XRxW/x7jJpJKrWzwBvGur46YSO+elfP6dtUzOEdh7fSIFUF/D
         aSptQmzNDa7jxReezzUZGVS3950qrBdR2luqEzhQVk97+cnc7Lh3Mj7E3F5cRVkqEMb7
         hYqLjAyc+E7r+jSIaHwMzhEtSO2Shbng5eO+z5Fyb08OUZ8+rOprlbebYkLsuRdEr4Fs
         pQK1ZI5LHML/ptZt95N72w/GeOGJHvHdtwdcjS8qJav/R+tTOhBJnUPjqO1c9750l+UI
         HoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739363206; x=1739968006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCu6b3woM+c5soUL+CL/3/8vzh19NcMbxFpr4cPyY0w=;
        b=nqEjEqXDiPFeU6/BaPsabgjN3KNHum188VFzDfSayfo9A3JRrKkCdAqarZwAecIGAK
         xETRkzy4o+XdJ+xwfkN1DzOKl0EdMJt9uLmTE9Uwq7szb/+rR2CoWPMrVmQ9xOLR3Cw0
         hmz7NjzojiKo8PKU/s20Ec1UmaAEqInJWGiW7wA3RcAyG0EXB56ZWjCZXPE4eZs1C5w7
         P6dWsbjyBrznMjWnNpA4t97iyfXcAgeCCYu001EJ/bB1D98GadHj43tFfkJAFVGJShMi
         Y7c733XD/cl0CxMUsD9P3lF60e0UHuwDo6mmOSE/teFxORQQWru/OMSk/Mj6CsyOaxEx
         SNEA==
X-Forwarded-Encrypted: i=1; AJvYcCXgKo177ecMZiP2NL2D5INer1Tp8/bjH+bjnrsEx/mP4smxCn37XZ8XhdTJVu5Xo911koQbFtEI8C6xTfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7QEJXuotkL6M+SKUqn680UQ/V9IE1bHXCLW7UOsjgaDeD7sLm
	A9vVNXYm7ob8BG8eAhgj0brR3y8Bnr8rBqIyP33ZaA7EMw4F+nTu
X-Gm-Gg: ASbGncvfOjZo3rVj0Lu8XH0rQ2007HCysZXut3SKFHq5muMRoYRY3TrL2ZPXfzyUPEq
	Dl4nyx9Zl3V4CJTTf6iy18rQ5wDtW48Guq1kic3hxFUHgk4lzEs9ScTNOpu2/o2kHxyepuDZkGA
	xdsBM0smHhgO+3FXhm0dGg7wo+Uc60D5W7pE0dQTfJJC6tD+7YZIO9E+HGvGvrtUhETPHghO/uO
	4Li6fzS2GJZl0xvPX7c6szSOh8d2xMi1hHsH1mbrndy7zSp+1UhZwUPF8Bv5rCryyG+ZNg5MYuk
	ZPd1aE1oYdGX8+9o
X-Google-Smtp-Source: AGHT+IGmFNu24b1qS0VJTdN4xDOY35KObKCCcjvjGWIaPEwKxZczxmHjIMyVZoSknTa53QLxoZt9IQ==
X-Received: by 2002:a05:600c:8706:b0:439:55a8:c61f with SMTP id 5b1f17b1804b1-439581ca4f1mr32824285e9.30.1739363206063;
        Wed, 12 Feb 2025 04:26:46 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4395a06d22csm18674495e9.22.2025.02.12.04.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 04:26:45 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: gpib: Fix spelling mistake "sucesfully" -> "successfully"
Date: Wed, 12 Feb 2025 12:26:18 +0000
Message-ID: <20250212122618.495963-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a TTY_LOG message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 85322af62c23..1c3e5dfcc9ec 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -542,7 +542,7 @@ static int usb_gpib_attach(gpib_board_t *board, const gpib_board_config_t *confi
 		return -EIO;
 
 	SHOW_STATUS(board);
-	TTY_LOG("Module '%s' has been sucesfully configured\n", NAME);
+	TTY_LOG("Module '%s' has been successfully configured\n", NAME);
 	return 0;
 }
 
-- 
2.47.2


