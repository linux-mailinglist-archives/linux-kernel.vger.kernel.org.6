Return-Path: <linux-kernel+bounces-447617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F25E69F34F6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7352A162017
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8B7149C57;
	Mon, 16 Dec 2024 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JRXNxHiD"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB914830A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364292; cv=none; b=MkXomBXQIW7iQkLMXYeu9Q1lwQBx3GZih10Ja7ygSCfKkusxcFYqqfzLj9W/xzO2wsTVHA3ZCmT+xV80at1vYpDjbhWZhdIWR8dalQaCLTdObh3QMf5wC/JJWfYhwlclYgejPv9ED6C0XAIt4iqD2igLEY+Q1HTHADFNXQSQmqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364292; c=relaxed/simple;
	bh=3g8DC1mNg7XB6KkhfdDAW5YL9wzGPK7RETSbnA7JMhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oH+cNMXfu+/JPH7mX9TcGQyBJz3DtlUMDOc9Z+3xfZoTdUTCj1LO8LXtz3UEFy5WazOT60WotjLpTa/Yo/B0jExumWnHSnufA7FSZ2PNvSJUQd20c9ZGgIx6Szz59oaRNnLs+vdK3g1lDiWxc9SgVBgYPy2Avjz27cJqppVLpWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JRXNxHiD; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dcc42b5e30so43008316d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734364289; x=1734969089; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANGVT/6vrWuj/lKkD9RrqomD0lbQDWrUQKUnTL+w+JM=;
        b=JRXNxHiDuLJqMYFS7vt9aF28bsg+TyjrvHmSe5I0XCmbIzdkyxJhroCk4vs3L2LqZI
         doHp+znXX5HPEM6A2x3CGbOZhTULm+KUWDNhQTPNKoueGNJPKSfRkFWQAGqT63R5d3Ui
         gJVjECNPE64wFsIgdx4W9kjdnu3aZkTwtujio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734364289; x=1734969089;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANGVT/6vrWuj/lKkD9RrqomD0lbQDWrUQKUnTL+w+JM=;
        b=J+BfV+RLHR1bnAG0VJLaGduxifuzjqKZ9mu5t9AWaHrNqqvIenrK2oEBS/Eax/wdQn
         V8Ty9e4anCSq4HNgTqMumdyPunga+evEdLkTIitWKq3g5Egr7V4QtWEHlQfA/zrT21iK
         6cbDp06v3XvoT4oc2bRjrXbP3ReNVh0NTzBzClPdvgT6DLec+lJH7Q1Mzssg+4KtvYvI
         WRAzFjOvy0bVuRjL/gSBa0H1CCG0SlfECwEeJdHY/JUhJ+KhqfAipU3fzJIOPERfB0dR
         8gNItbSu7nwXJixNQXnkHlX9JtFmzGgx7NgiGyPGdZHh/xRfRyXIjfDkMjep8gMbHO9z
         /VgA==
X-Forwarded-Encrypted: i=1; AJvYcCXR8SHKdUHxMOTY7L2ro7LGONKX6dtcVZbovn7iTGMur2LQsyBuH85QU0QhslDow0bZO0U5K5U1H3zP+zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM7wo46A6tSJHl982uinkZ88qM85XXy1A0Zl5T5KvR4mCYu0Ii
	O8Rc1Hb5lgrM5nZQ8Y4Que328eNthv6HLnNErrpazp9BrxP7H3dsIPJwwfCdvg==
X-Gm-Gg: ASbGncusIvpf1DGoQ+YxKsZ8kqnuHF+f3v1i2dql+QZaQyhdTitx9OFXXR7oAYmlaKN
	CCnv9vC5WwJOGMijUVU0U2imRkGOMGe8nWwSG9Dxbs3yXPMj9+248nh2LRBXKqg9LuStJ91gznG
	F6JkrRfvN7eihWdczZsPhqDLx3Hh9tRLtR4O2Wq3m5U0WtWpfPPZXwr6L3QvNAjGK5FnUNb4Cwi
	wWbzCG6L24kXCWNspMpml0Bl89wgICkz2i7d4Uvi32NcY0Z2xrq+MAzRsg/ggLauiU0h/qd9LPo
	Hp8Mv2OZ2N7Yf0mIca0FQ/j8TwXOmKQ=
X-Google-Smtp-Source: AGHT+IEryXgjRGebrTAf3XDOlliT3FU618LhayFyfvmpOnzp9l+uOYDGOFR/H+wX94jhcNDHFdBzoQ==
X-Received: by 2002:ad4:5d67:0:b0:6d8:d79c:1cbd with SMTP id 6a1803df08f44-6dc8ca55737mr247992346d6.15.1734364289688;
        Mon, 16 Dec 2024 07:51:29 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd38abd0sm28416446d6.123.2024.12.16.07.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 07:51:29 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 15:51:28 +0000
Subject: [PATCH] media: Documentation: ipu3: Remove unused footnotes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-ipu-doc-v1-1-e07f0b4f9065@chromium.org>
X-B4-Tracking: v=1; b=H4sIAH9MYGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0Mz3cyCUt2U/GRdizRTS8tUg5RkS0MjJaDqgqLUtMwKsEnRsbW1AOv
 wD8FZAAAA
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

These footnotes are not used, or they are used in a codeblock:
Documentation/media/admin-guide/ipu3.rst:592: WARNING: Footnote [#] is not referenced. [ref.footnote]
Documentation/media/admin-guide/ipu3.rst:598: WARNING: Footnote [#] is not referenced. [ref.footnote]

Remove them for now.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/admin-guide/media/ipu3.rst | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/media/ipu3.rst b/Documentation/admin-guide/media/ipu3.rst
index 83b3cd03b35c..9c190942932e 100644
--- a/Documentation/admin-guide/media/ipu3.rst
+++ b/Documentation/admin-guide/media/ipu3.rst
@@ -98,7 +98,7 @@ frames in packed raw Bayer format to IPU3 CSI2 receiver.
     # and that ov5670 sensor is connected to i2c bus 10 with address 0x36
     export SDEV=$(media-ctl -d $MDEV -e "ov5670 10-0036")
 
-    # Establish the link for the media devices using media-ctl [#f3]_
+    # Establish the link for the media devices using media-ctl
     media-ctl -d $MDEV -l "ov5670:0 -> ipu3-csi2 0:0[1]"
 
     # Set the format for the media devices
@@ -589,12 +589,8 @@ preserved.
 References
 ==========
 
-.. [#f5] drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
-
 .. [#f1] https://github.com/intel/nvt
 
 .. [#f2] http://git.ideasonboard.org/yavta.git
 
-.. [#f3] http://git.ideasonboard.org/?p=media-ctl.git;a=summary
-
 .. [#f4] ImgU limitation requires an additional 16x16 for all input resolutions

---
base-commit: d216d9cb4dd854ef0a2ec1701f403facb298af51
change-id: 20241216-ipu-doc-8f599e0dc912

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


