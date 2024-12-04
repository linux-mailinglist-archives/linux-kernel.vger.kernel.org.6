Return-Path: <linux-kernel+bounces-431449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CAC9E3D75
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7A8163328
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1F120B80C;
	Wed,  4 Dec 2024 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QopB0dZg"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B885320B213
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324279; cv=none; b=PfcfKXN8R9vDBVoVW1ZH+bKD4+w3MUG4Eg0l2ka9myfgUrZFf1QlwYPKpcIxWpn2uFvLSQfUVehCirco1Y6i2IlcikLwaNtDT30954OluEeW3L8wL/SnTGhup4oNGzF+mW7ctjuWUwPyTFqg+C2Unw5zvGBUAOrtOWLu4Qoz8EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324279; c=relaxed/simple;
	bh=P1ZNFv8s5M0+3Slh4vQI0NzHee3PzeVzJleQKQUH1BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgGvryF7FpF26bECmDH+xdGOmLLUKQkzz43P4SD2+UOQhdE/r67CDtNYUxgl1dJwnEiL+JUnM6hrl+mQkKAuiIYZDHsvlZw4TZWTrlLzYRYXGtvD/vdgL3qKdOBbz+nkN6hh3KTyYUPXZE1/RYXlerRow2EX98JyjS1zyt3ssM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QopB0dZg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434ab114753so58515275e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733324275; x=1733929075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uvfwi+j1KyAse/3M7FYZc6SKkpOZJr29bzDI2D3zaDw=;
        b=QopB0dZgn7V5RpmIV9hbRJvcY6elwlKiX3yS3xIG1GnPoN86LqIEgCNJjpitub0xNB
         L2JuWcW3ND7XSTp/5znW3EAMZeBJaO7uxMPiPRXJJNeWdkGcLDgBkojrm0p3K+aZ2yTg
         Y/fGjbwYwdzoTD9E1/oYtaDvIBL7jZoj1XNLzT1sEbyIAARzZqTDVW6B7oJcHNeY21Ql
         r3XpmXtJcsxfBdINZRVdR/ePsyTOhqfTqUyo8CjobU0F032MPU/V0PwZ+Ov3SmL53PXQ
         fpp7lQPEWYclmhCtbreJRHux6Owqa87cRoWtddS3oCVhEH9DUn55Otv5DBhc64XEvjVJ
         xc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733324275; x=1733929075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uvfwi+j1KyAse/3M7FYZc6SKkpOZJr29bzDI2D3zaDw=;
        b=fFBswoICV50zoPp9ZBq48hsU/YL1Xfto1XXMl0qLEudcX2BvT7YO2PFqlW8hf9xq5e
         haB8d6m879bcwQ1G6FLk+MUNX0ayQLIFyKxN32caXeUd3mB6gi9LxOAoLtpZR8LZUXxM
         GbJClBpjF0Sp6NPOKQJwvS8gTK9efv0RiMP7p247vKsTacpl8GK6anjJ1CaXHtIqgYVn
         8h99rsnQzGxF+IK8GhhFoUJHRCgtB6SBXf46SARQ0sXlE00iIs+6anY50sGVovJM8q0s
         o8TSu/iNrz/ZqzNe036r6+gh6tuW1qcr4dRdeU0h5NrefffwHm55tJUTWfMfqFInzoaG
         4H6g==
X-Forwarded-Encrypted: i=1; AJvYcCUWoqw9cbEI9oZwUc+e4Kyxg0VOj6+WWseXLr+zh46ztyxc2Ouek3vXCzr9sRkQtA95kUn9Dk/RIHk2gzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQKSjvWOn7Kn+prEeYIWlb5mOihk39PA3NVv5r4ExJ0Mku0YU
	aNJ0R66b5Om5YfJB7QfZgpTtNWjfiRSIyANZpp5JKa6Br4orFkyr
X-Gm-Gg: ASbGncvWudihnrTd8wAerfSTTwu6mPVuDxTvWKpCH0p4rNjPuSSb+f9/PfJ2/XAPIPn
	s4ehUHMm5wdwOiVkVSgMlfc7Q1pebyDJ5ViexsynfkJ2BsvN+gJ/LZ9XlWYOP5FgRqvHVIBRGYP
	+aIyj4afmko4KT4X08iU4xegG28y/noXfBUnZHbiHAu8AZOS597Dt7ni7be5hYEIGZSpz6kJ9YG
	yIn327PmCWOvCw0y0bIupIFkCQFBFAY8wUUEtbhxLGBgZsOopVpbeuSbhyF9ytwCLCJDejafnF4
	KC8ShjDTeA==
X-Google-Smtp-Source: AGHT+IHg9axXITfuSoX19A6v0clv2maNj8PY+pUPxJwY9VwMSX/zDP20IFsKU8QO2ZSwkk07B/E0QA==
X-Received: by 2002:a05:600c:1c07:b0:434:942c:145f with SMTP id 5b1f17b1804b1-434d0a1cdb5mr55667205e9.29.1733324274947;
        Wed, 04 Dec 2024 06:57:54 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527e8besm26678955e9.13.2024.12.04.06.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:57:54 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>,
	Kees Bakker <kees@ijzerbout.nl>
Subject: [PATCH 4/4] staging: gpib: Fix faulty workaround for assignment in if
Date: Wed,  4 Dec 2024 15:57:13 +0100
Message-ID: <20241204145713.11889-5-dpenkler@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204145713.11889-1-dpenkler@gmail.com>
References: <20241204145713.11889-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was detected by Coverity.

Add the missing assignment in the else branch of the if

Reported-by: Kees Bakker <kees@ijzerbout.nl>
Fixes: fce79512a96a ("staging: gpib: Add LPVO DIY USB GPIB driver")
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index c30db3615f49..5114f6c519e5 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -899,7 +899,7 @@ static int usb_gpib_read(gpib_board_t *board,
 
 		} else {
 			/* we are in the closing <DLE><ETX> sequence */
-
+			c = nc;
 			if (c == ETX) {
 				c = one_char(board, &b);
 				if (c == ACK) {
-- 
2.47.1


