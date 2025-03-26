Return-Path: <linux-kernel+bounces-576712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A487A7136E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7B93B70F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E9D1A707A;
	Wed, 26 Mar 2025 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWlrXe6O"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541F8185B48;
	Wed, 26 Mar 2025 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742980614; cv=none; b=EQ1Yn48ynPfb0OG6X3lXHh5lU+KJg1UblrtNs6lOGF5GAUMlYsNH/QHO6l/hwmoApqq3QyDr2+2hzL0okIj2V5CwmB8nizfR1j+RC7wom4w+WPu0pBkjze9faCIAZ7aB4JLbnRZHbH7kwQbE/lUVcbSwHx9ySUzV0P/XGoo4Gpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742980614; c=relaxed/simple;
	bh=7cnEvx/xcv4MfjwUe53La3fEG2ac5DI5Cr/KL7NMh4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bBHbg8Js6iu2UF386Enca6Ipg9xG7FWXdftC2H13MwqD3SYmspr/VAzchyyo8ciukYgDWs+vVRSshlpWPsgPX1EpX43yPBFg52HXjoiHtgvrYpU8yrHA0dpbrW/7bvWsXPh5truqbjM0MOcPraa2gFNJE/ZQ47uan7CKXUUtWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWlrXe6O; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913d129c1aso432777f8f.0;
        Wed, 26 Mar 2025 02:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742980610; x=1743585410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=puPbg5Dq97TEcUdgQnQJgNniQsmYGYfjfqYK6CgRyAs=;
        b=eWlrXe6OfeZK5oJklBAe8vHBsaEx4r+qj87MYAKdCpQoqn9+85j5t9NNV53WU2+jCJ
         gncUepZ030c2j8YO/NcLmjxwl//9HISTIl/l1+59/lv/uHZ3bS70AFhWhLaFAMSC91rW
         nLjEd/kHih33BpI0rZlooRFdIdLtfKEOYUXnTN3aNvynbwifpRR8y/mWjI6M636AuS81
         Gmv3VE/T7DIGcPI3WNAQTS/Gi+R78jVGTW22xRMIIjskifnUlsW0zVZlOsFW8LUJ59k4
         WuPFHb7KCb7PYqtbY6MS8oKY2BoLSyCkXPsdnCAEh8Vd0zZ8WiYom5oVuO1Iptwvrjlq
         AZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742980610; x=1743585410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puPbg5Dq97TEcUdgQnQJgNniQsmYGYfjfqYK6CgRyAs=;
        b=Gbgibw5iPchoHgQshu0y+k2ioRVHJpQUFoYEhH+XVxXXoCK5Pfy4F0vidyMAI6AslN
         hm7+C47ejGt4Xr8Camzbeht9nld+riNN8uxaUkdubdydXRegCQ/Tio/b1y0Nri+MN4Qw
         KjltXeA3bOkYq4evW9MZ6ZEY4HNmaaHyMgfJZ+cZV3xqmQKSUXbrf1U9vAv05rDp0+0x
         ZTH4U2u2PotTl1ZHGasV3N/oH3gH/+oqFSTVqDimx5qTmtqN273rfVzQg2cvmgEYuL2J
         Rs16Ab9oWwWbApv37bqf2G1u75noE595kjCDrCOAW3YhlGCFIA2faF8ArSuwYN6r8uRe
         WorA==
X-Forwarded-Encrypted: i=1; AJvYcCVwvCsj+UBmoVL8HDYVDL8RY0UDpNhgxTrP97OUwCTag9CI0hcu9zLr6wOedXgamD+NYAo78mZ4RsjLrg8=@vger.kernel.org, AJvYcCWLPAQGrugADnV1UmGwfDYAO1HAqN0fGRGfBVj3S6jVmbzA6FxoZ1UoryWFyYKP0QM8MBFG1DChwI4zvtzKhdI5kYzM4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5xLfAAXpyJYHHAu/0F1+4NbaXWSLLViZa+jckOlljkIxIij2o
	r9ToUqm4FYfPLwMHHdV4KkNxuSG5cdtj8gef5gnvsVJRaU9sQtGC
X-Gm-Gg: ASbGnctiz16YrmEaemnZPYEIgSSMcjisX4rPFOkZFOlXhkjXA90r7SDUf/2G9MLMa5w
	XnB0iNDOXHB9q82pFQ27FrM9oNFlSRfoUNThzUdVeDmzzYEfVXg1vnnQP3BN4rMwTC1UYPeoqTR
	guVN0LBgMYH8L9A8tncpQ6scMluYK+DazY5ih0w96jNCQE590FONg/isrOQwKu3l0Cr3DR2lhRa
	QskP55WuT5qFbR3GAzl8xkbzUi9ihMnMakv7N35mk25Y7yN+VSEFyTw1qzdrRowd2E80R8t7gma
	FjvT/h/swthaR2eWgaTMnKjxgnVit8CKPNwaMQuTznIJJLwg6bR4vjo08BEcK68btv1qh6gG41L
	gsQ==
X-Google-Smtp-Source: AGHT+IGXSy1/GZadfrmQiT5AMctxkUHMUA5aPo77GsmXvbFlJUl4JHzq0qyvbqETyn0RZS7RJiNQLw==
X-Received: by 2002:a5d:64ef:0:b0:391:22e2:ccd2 with SMTP id ffacd0b85a97d-39acc444a29mr2300336f8f.3.1742980610305;
        Wed, 26 Mar 2025 02:16:50 -0700 (PDT)
Received: from pop-os.fri1.uni-lj.si ([2001:1470:fffd:32ff:d336:30ad:7934:8ffb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b3dd5sm16153992f8f.45.2025.03.26.02.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 02:16:49 -0700 (PDT)
From: =?UTF-8?q?Ga=C5=A1per=20Nemgar?= <gasper.nemgar@gmail.com>
To: ikepanhc@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	=?UTF-8?q?Ga=C5=A1per=20Nemgar?= <gasper.nemgar@gmail.com>
Subject: [PATCH] Added support for a some new buttons in ideapad-laptop driver
Date: Wed, 26 Mar 2025 10:16:32 +0100
Message-Id: <20250326091632.23644-1-gasper.nemgar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Added entries to unsuported wmi codes in ideapad_keymap[]
and one check in wmi_nofify() in order to get wmi code 0x13d to trigger platform_profile_cycle() but only if dytc exists.

Signed-off-by: Gašper Nemgar <gasper.nemgar@gmail.com>"
---
 drivers/platform/x86/ideapad-laptop.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 30bd366d7..cd8c38dc8 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1308,6 +1308,16 @@ static const struct key_entry ideapad_keymap[] = {
 	/* Specific to some newer models */
 	{ KE_KEY,	0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
 	{ KE_KEY,	0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
+	/* Star- (User Asignable Key) */
+	{ KE_KEY,	0x44 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
+	/* Eye */
+	{ KE_KEY,	0x45 | IDEAPAD_WMI_KEY, { KEY_PROG3 } },
+	/* Performance toggle also Fn+Q */
+	{ KE_KEY,	0x3d | IDEAPAD_WMI_KEY, { KEY_PROG4 } },
+	/* shift + prtsc */
+	{ KE_KEY,   0x2d | IDEAPAD_WMI_KEY, { KEY_CUT } },
+	{ KE_KEY,   0x29 | IDEAPAD_WMI_KEY, { KEY_TOUCHPAD_TOGGLE } },
+	{ KE_KEY,   0x2a | IDEAPAD_WMI_KEY, { KEY_ROOT_MENU } },
 
 	{ KE_END },
 };
@@ -2094,6 +2104,14 @@ static void ideapad_wmi_notify(struct wmi_device *wdev, union acpi_object *data)
 		dev_dbg(&wdev->dev, "WMI fn-key event: 0x%llx\n",
 			data->integer.value);
 
+		/* performance button triggered by  ...  */
+		if (data->integer.value == 0x3d) {
+			if (priv->dytc) {
+				platform_profile_cycle();
+				break;
+			}
+		}
+
 		/* 0x02 FnLock, 0x03 Esc */
 		if (data->integer.value == 0x02 || data->integer.value == 0x03)
 			ideapad_fn_lock_led_notify(priv, data->integer.value == 0x02);
-- 
2.34.1


