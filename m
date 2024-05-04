Return-Path: <linux-kernel+bounces-168699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E488BBC58
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 16:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7751C20F82
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCF03AC0C;
	Sat,  4 May 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im9dCCqL"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6677523763;
	Sat,  4 May 2024 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714832082; cv=none; b=ggeMsLqEe8Cy+ZtBLJF9xZ4IECauVnjHzynLXxWV9tD27Dn94HbHLM48IrikTH7SKqJMQSDRlLb+OjHq672ggK8ZSAgb9g/wCa2Pb3fiy4sZMXee1tCCh4DWmArFTM6LCawIXU2FCK+ECLa9vt/ut1YZNP5GNngqzoVEaQ2o1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714832082; c=relaxed/simple;
	bh=OJnVS/NtFJbYm1maNW1dH8kYU19xbaLLvnyUffiEgnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZDiimB+mPz72JYe8+4qR+m8c+sxWk/zWUUANJQbEi/kpOVrKjKYSJmhK4R/b4EuvDQfM5vaE/tb2nnAKkNTIs65m+Ac0jW7XZbDsJwoWCW52InSMnZzb0u7dZIKF58ETl5Hb6mOKsFfHBRdvqKmtWspsC6xmEUUjVKltJ9NpPJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im9dCCqL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so548639b3a.2;
        Sat, 04 May 2024 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714832079; x=1715436879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=z92u8CiyGAKG3cIL0Enz9SQJzNtbEGb8aQGYpev0YAg=;
        b=im9dCCqLsLkm2TbM58QKLboZB/VSnf0Te4GyBv/Cl2N7B5AL+8JMoQK0NYY55R0Drd
         khMK0MxkaznhXLr8NHfqmhBwPi7eDCJP78dZ+KlajbYoaEsXcavzevU2hXuVdAWabNZg
         I43nc+xy3W+DYAZb+V7WYA0c452DS4nnPd81Z2N+OUDDH6X0SY9gQkNhULlCNrTjfj5e
         RCcjW4+JFPlAAxrP/GeR11EacpGqN5dsBps973wT0sNYP1NZgx9QJlxLEfLpzSQSEZvu
         CA78KOGxVfijXvQTmTuj2UbFEPMV80yhkt21XQJXJk0rIZyYsgUq5vgGgWL7mCmSBLLr
         eNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714832079; x=1715436879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z92u8CiyGAKG3cIL0Enz9SQJzNtbEGb8aQGYpev0YAg=;
        b=ITt3obgRDmP7Tfm5R8ZCHEPhDmc77GRRI8dCJThWAlIHYvT8Yn5gG3VlctV809XS4f
         4cE5Iwv6pn4Z0e8qH3WmCbyOAuokjO5bbbCViTaJGCDBSnx5c1FlN979QsNL0RFieMGo
         f4v9dQSzrg53l17vqqVHSvVHLnqWk9NkwRnqRno5bBfoOott4CxcPnTqUNTPf5ZW3Ovq
         hNm8zqiVlFtO4L01Y4QPDwBPe/uQTR3WCJaLAIz92IU+imkBqJiGMSDkjnYSUni744hX
         zKURRrsjIe7J8oCHxB0o6zgHBA8ES9MLMZAVk5j9Ot4lvI8jnvcsJshVnrr4aaq5mygN
         +RiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPHnw+Vqzdu7zMQqI0hUdEq+RpRDHm1EOTUF8wRuYDRh9tVAr1QNX8goJoHOQumSAf0jrVVGMnMyC+qugy7eG/WL7+lB1h3fUmQMiU
X-Gm-Message-State: AOJu0YwNhKjr8sYEPtZbqIV2PSRHSOcPiXg5bwyRKaGlcRgpVBUdQL0B
	yesojsEv3QKxtfP66i/9L0Hm81xt9mEBr8HsuEAEK182YN80TX2E
X-Google-Smtp-Source: AGHT+IH56yTsJEv3YJNgnPDk/+mavE1hJ6ZNIbPKjHfl6oQR0WJgK6h1puW6GCW6lEFg1oy7IC+arQ==
X-Received: by 2002:a05:6a00:ac8:b0:6ec:f097:1987 with SMTP id c8-20020a056a000ac800b006ecf0971987mr6285026pfl.31.1714832079522;
        Sat, 04 May 2024 07:14:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h3-20020a635303000000b0061c3373e01fsm3465432pgb.48.2024.05.04.07.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 07:14:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] MAINTAINERS: Remove {ehci,uhci}-platform.c from ARM/VT8500 entry
Date: Sat,  4 May 2024 07:14:36 -0700
Message-Id: <20240504141436.647782-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARM/VT8500 is marked as Orphan. It includes ehci-platform.c and
uhci-platform.c in its file list, even though uhci-platform.c is included
from uhci-hcd.c and ehci-platform.c is used by several platforms.
Listing those files as part of an orphan platform does not add value,
even more so since they are marked as supported as part of generic ehci
and uhci support. Drop the files from the ARM/VT8500 entry.

Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec0284125e8f..5374fdfce8c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3022,8 +3022,6 @@ F:	drivers/mmc/host/wmt-sdmmc.c
 F:	drivers/pwm/pwm-vt8500.c
 F:	drivers/rtc/rtc-vt8500.c
 F:	drivers/tty/serial/vt8500_serial.c
-F:	drivers/usb/host/ehci-platform.c
-F:	drivers/usb/host/uhci-platform.c
 F:	drivers/video/fbdev/vt8500lcdfb.*
 F:	drivers/video/fbdev/wm8505fb*
 F:	drivers/video/fbdev/wmt_ge_rops.*
-- 
2.39.2


