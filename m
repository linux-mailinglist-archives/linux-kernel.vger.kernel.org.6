Return-Path: <linux-kernel+bounces-571183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3FEA6BA32
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2D53B0B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095A6224B0D;
	Fri, 21 Mar 2025 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHz2ZLlh"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7AA7494
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558158; cv=none; b=Mx2A0PSnBvFW7lm1mksJ1iIwAUgyS4613Z0wvVMsn0DSTeHEFgfCBxmEM34sk1ugfd9FEEusVZbkpkYxIQJ/9D7n10d673BJXKmpOWPd7f2lGvGImBDMQ5UH5+lQw0S3q7giK843CV5wrMv96CMPK5aCWhoWuknvF8VfwJxpvKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558158; c=relaxed/simple;
	bh=tPboUf0Zr+l78s8Qk+IxHCsImOBRnA97c2p4L+E040k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PyiGCQOxxLjiHJQxJKmi2tsqkMPS1v/s0MnSd6szPQfra8SkvZmYP/dN4z70ixq11WdbxmMa8Q5JJsanJ5eIZz+1fK+KQa9C/mHRrGPKSNwQZeSpWCGTVnZLy04erNWt/qN9fcqrzEUnOH1/jX93TdunheuT+VH56+stQi1OoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHz2ZLlh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39149bccb69so1753473f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742558155; x=1743162955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c4sDOHOmH2F/18zOsLI6QpBEwsBgeSty8cc2NNHzyKU=;
        b=XHz2ZLlhGNOAu967APk+ptuLGGWrc61dAM2sa+7Ciy5lDj23gDkVZeoQGu6REG+XHR
         Be0J08c5iuWVN071WxX8flOESYEjKQz6HeaT2wHVkRK7/An7H9G/yJRTNuBix3K2pCDQ
         Q1ovR8gYf/CFEgyV+8J13ZJ6EhCtiQLaW03K+JmYtr52dhq9E6dd60YuQ3x2X+1D6ehg
         0dxZbHk79aR+0zzNK47DazRuhMWIZzZb0+B++tdVJx4wnEsr6sXXlOKXMhNEUXMHywsG
         ROgIVy+dkIKVAXz07aXdVjm5yvrJpnMK9Lf4yW6VoKxx71jucf9r9E7Lm/RtYRCyaGze
         pWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742558155; x=1743162955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4sDOHOmH2F/18zOsLI6QpBEwsBgeSty8cc2NNHzyKU=;
        b=thMRx+Yp8+497QqL4TRVsNoYpHu+kxA7mul/Y5NOFp4YblfalsAJAtqEfFQsRhlbbA
         ovjnNGoclT7/yKYo3+4+xp1uUwrevBEi8TSB0nJlIHmb/dGtzMe1opR9ij5Xq/O/KbMn
         vvj/uQ+RSne/iIlGX3mvqSTaZob/EFw9tdAqW2DXyWXa7BXJbtBTYRG0FbZC3mqsCqDQ
         EPaArYLm6rinmj/T5uYchkTlsxLSNJPCYl6znVD5DpQj3hZR1rVnYtIyb64Hip+9uEi1
         oexipdmnGKWXpVhpl6w213OBr7RhZJCi66/kFeYrlHonpwXJCELk9zDkXGCBxByIZyK2
         nQRA==
X-Forwarded-Encrypted: i=1; AJvYcCWrbB2d7i3nPyfYkDJuZobxOWqpW71XOHh1tjkQ1pl8XZ0g8VBcA9ALR0zlCcMGz9pr9a8NWFr/p4zyLX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0SNmKYwjP2HTQJiZ2apVzb0GZeTkJdss00g97D+lUKJSMCzP
	K52HFnjNkhtXhod8eo/k132rEO5FjzELQ4yyCUGgp274T2c2XQuV
X-Gm-Gg: ASbGncuYC57/gazXRDt6xlpopTWxvb/iLno5YrPJf99QuRTC2Z6mD7yyCcSFuQBleu7
	KCKXrgcRJDSKOnUzuQZEtVPDuPERh4urzRARscaPzyK4l/lMWvNLrfPt8KcStLuXSG4aiFu6LUp
	pZawsYUpp+qQOw2+cGtrlxCgax6CC9TexWKuRoTbamaBTgj7pjoemeAxMugldaoiGhqxSu4eZBq
	M1thGN+ft/MLrDc26svfU0nvznE3zIZfiAyQoUtBqUJP9ESCrFytJXFvtRxF3oqmwy4bkurFyZJ
	X1UGOKGaW0uBCq2LqrRK4XJg09v2wLWVWqlTj3ktWA==
X-Google-Smtp-Source: AGHT+IEGpQVJLgp09GpEuzAgmZJOX2/jxZFFMYn1wXHIxrgy8GYpeYc/67utxdndf3QlfJj/lUeemg==
X-Received: by 2002:a5d:5f85:0:b0:399:6ad6:34 with SMTP id ffacd0b85a97d-3997f9390bemr3262333f8f.35.1742558154743;
        Fri, 21 Mar 2025 04:55:54 -0700 (PDT)
Received: from pc.. ([197.155.71.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef23esm2148164f8f.81.2025.03.21.04.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 04:55:54 -0700 (PDT)
From: ErickKaranja <karanja99erick@gmail.com>
To: hvaibhav.linux@gmail.com,
	johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org,
	outreachy@lists.linux.dev
Cc: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ErickKaranja <karanja99erick@gmail.com>
Subject: [PATCH] staging: greybus: fix line length issue
Date: Fri, 21 Mar 2025 14:55:45 +0300
Message-ID: <20250321115545.24468-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix line length exceeding 100 columns in arche-platform.c. The code now
follows Linux kernel coding style guidelines by keeping lines under the
maximum allowed length of 100 characters.

Reported by checkpatch:

CHECK: line length of 101 exceeds 100 columns

Signed-off-by: ErickKaranja <karanja99erick@gmail.com>
---
 drivers/staging/greybus/arche-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index d48464390f58..1a82a7a3991c 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -179,8 +179,8 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
 				 */
 				if (arche_pdata->wake_detect_state !=
 						WD_STATE_COLDBOOT_START) {
-					arche_platform_set_wake_detect_state(arche_pdata,
-									     WD_STATE_COLDBOOT_TRIG);
+					arche_platform_set_wake_detect_state
+						(arche_pdata, WD_STATE_COLDBOOT_TRIG);
 					spin_unlock_irqrestore(&arche_pdata->wake_lock,
 							       flags);
 					return IRQ_WAKE_THREAD;
-- 
2.43.0


