Return-Path: <linux-kernel+bounces-366801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1117899FA93
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959141F2288E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9282221E3B7;
	Tue, 15 Oct 2024 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="cpPfRDQp"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB1F21E3A2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029195; cv=none; b=BSGhs9kshjK/kxiA4noh44/9wg1znG0lEwy1rtYRKJR9Hho9rORb8XOUhyCuoTuGc+fLEZu+M778KWjnjKMJ16ax2nUWD1Ze7IZ46BQ6xNw7LPESoez2DJJVopwkxpz2p+a8Oegg5KWRGLO6+QLtbRr7NbdzppgnDFV83hutqBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029195; c=relaxed/simple;
	bh=33zh+FNJ8Pdz2z5fFtLbuLnDgMJRzb/PKTlMZr5vzNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FLcIo88oiEoyDW2H1BkM8Mtj4l8iBkbsYI+0w0gq7swVQqXvu/Nlt3iVn0zOFc+jv+x0vtsT48KU2h3fRTw8wE+6BwkvI+cXyF9mzUm1CD0QbPH4Z0kYvxM03jr3DU4adJ/JdCtPb7sMzxD2obnMcRbqVayPnhCTjCBCboQtOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=cpPfRDQp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so2636029b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729029193; x=1729633993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgYy6Bm6ST3WMLvvW5zbLbX+E8lzENv9uLpgUUiRQbE=;
        b=cpPfRDQpqqZQlqi+e+MG+IUq52F+XmE3XvVstNAe/P0UdxAgcISu4uoR1ey3RsXX6y
         RTgCEOzUvG2hkSRhMryD4Wewaa3YMaQcK6DvRNM+AdDvsUbUktxgxFfJhQD/c+G3C0Ah
         WrbSWndwrWDPLDOuk0HZ5uTfQNTOWfgFuZpjBxeUzM9qmhU7Q0f7/3v63BJ0hl9n17Ex
         uZPcUBv7pNgkuA2wYwVRQh6zW7mf2/WHO/fazliXcJLTG8EAh/cbG4yjyaTFoSgifqn2
         ZfzleYQtbHp+qnnv8gSkR+U/SeckMjcpFNQR8NSzu/5r+vfj90e7q5N27tsr85ZNwSlT
         TRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729029193; x=1729633993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgYy6Bm6ST3WMLvvW5zbLbX+E8lzENv9uLpgUUiRQbE=;
        b=TcP1kJhONPgsRiQuJZtrAnuX9ADu1eebT6Tatsk2rd1yKf0Uky9tcJSntkI2QF+tf5
         OU/HWL+f9j3u2tiX03K5s584v/nKGigZuOAh8HrFtGnp5jJz7XvO/cv+OnUNojPt3Q57
         ARGlIhVq/GFRWZZRs7nGMamT+Qia/TXiev5aiB7HlFcx6vxd1mS0jiIzmT+df9AV8SXu
         p1jBOtI6QeZAyjO9qbyX24QKQiIu9M4jm0nVNPE5CaiYpLF28ER9eD4CXtCvXvjlMwOo
         2pXSg/kV7+sI4YANeF/1STmzT/9HGw1cBN0qryw3kW4xsKDSPrEuukUbpbH3+pT6p/4v
         3h1A==
X-Forwarded-Encrypted: i=1; AJvYcCX3cftgh2ZVw5B+9eW/bGD1qtAkMwwJfBVlAjVjAefTahr6qlSdypPMmneAZQ6ZvTNZn59QbDkc73E8YY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSiUwJ0PeNHa8Ka7ZeO5IsZ1+Ja/0x3Mxc+Cs0FuxghoEossdI
	RQuh5T4+dAU5UOE95aXmuk0zq5cYzpDV1hJ8XXBW8H2yAE0TLi7TDud0FudG/k1YCX0S+d8AWXa
	GLBeUiFbEbgU=
X-Google-Smtp-Source: AGHT+IHKRWB3I+w3ryMfWgsL3J2DCrxRJgLiiR2QKNjK8+DYFibDfVRHnxZR4m7tvrx4sHkzUbzeUQ==
X-Received: by 2002:a05:6a00:9159:b0:71e:cf8:d6fa with SMTP id d2e1a72fcca58-71e7da61f1amr2296785b3a.15.1729029192757;
        Tue, 15 Oct 2024 14:53:12 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71e7750a74csm1789969b3a.212.2024.10.15.14.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 14:53:12 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gpib: Move free after the variable use has been completed
Date: Tue, 15 Oct 2024 15:51:55 -0600
Message-ID: <20241015215157.18571-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable `in_data` is freed, but used later in the code.
Fix it by moving the freeing the memory after it use has been
completed.

This issue was reported by Coverity Scan.
Report:
CID 1600783: (#1 of 1): Use after free (USE_AFTER_FREE)
19. pass_freed_arg: Passing freed pointer in_data as an argument to
ni_usb_dump_raw_block.

Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB driver")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 1da263676f2a..75f39e1f3ed1 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -690,12 +690,12 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 		kfree(in_data);
 		return parse_retval;
 	}
-	kfree(in_data);
 	if (actual_length != length - status.count) {
 		pr_err("%s: actual_length=%i expected=%li\n",
 		       __func__, actual_length, (long)(length - status.count));
 		ni_usb_dump_raw_block(in_data, usb_bytes_read);
 	}
+	kfree(in_data);
 	switch (status.error_code) {
 	case NIUSB_NO_ERROR:
 		retval = 0;
-- 
2.43.0


