Return-Path: <linux-kernel+bounces-424306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4929DB2D3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0119E16351B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D36145A19;
	Thu, 28 Nov 2024 06:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/Q/5J2E"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9667B41C94;
	Thu, 28 Nov 2024 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732775969; cv=none; b=uhYkGg8tHjuCp5jse1+SCxTpBjmLtzfVCrbhsQpa8JUepBa6idHim4lOIdNI3Asp/idFSC398OpN4VBHSIhisz1f70+6x+SuDvxZNBrJ7rNd0+FXIxES74ijaoafuYdmVXW1G1p151ooCa5atwMhd5TQ9Izk3tsUDghl3QKcgys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732775969; c=relaxed/simple;
	bh=qLCiZnEouRsFth6Uf2kQGBslsCb+JqNpQQwhDpLIyA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mD0K2Tz+OjONWtkXfjcF/EWZ4GDQP1bKa4r/yRN1tSxcgiilVRC2TAOcK1hNG7IVNXHbKQpGuhvdTNQQTcOaMExsHu4G3L/zthNl4OIUWMrgnYOTPt7lZqWfNox3SrtZKyyUMTuEELejvxfAAmzQlXtIk/dZigZLc4k4UKE38IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/Q/5J2E; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21262a191a5so4163835ad.0;
        Wed, 27 Nov 2024 22:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732775964; x=1733380764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JbLdkAOQCxenw8yI9+EWMK8lRQF1ebGSP0oQfGasbLU=;
        b=Q/Q/5J2EI6UvTEC/uNtcWbSMkbZRnyhzKkEOeW/DuD9/b3A9mt1aSU9aJlcwj9oPud
         S2Vr6AzsOexvY5CCzQBNSagUnc+666eFwc2PShhnRXPZN9M567E30MUrvvFG/TkfRt4h
         uHPPXigg93mo8eRKYoIBphfsjeRTVBaPYoAqcM7EZ/8MWZdphfow+6J1CAM0B4724Abc
         rd1/wTrXHAIqNpr9FORdrS6+YPPF0E+Gj7ZBHvxbLz0XyCZ9fMW/DDL1KUuAdgVeS+mX
         k9vSwDX2FVQ9Cv79nBHHU/8ufM5R/f0c+3xrPpn8NsLmTuKgyprCx+u6F3EeUo90TZA7
         i9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732775964; x=1733380764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbLdkAOQCxenw8yI9+EWMK8lRQF1ebGSP0oQfGasbLU=;
        b=qzS4fu/Hbk/4OTTDbNqiftT1txf41TUgWS3CaIawRa9WA3rhS9dqsrsCfHiVg0Y5r8
         XlJgD20vQeTIVNyhrMckHM0Tr0pZXti1yVtp46bnMLEqtkoC/NkJ9fwCiWCZOaqT7SPh
         INEpjChtW0UlhQFytLCWQzjVkeqnwXl7XFtxs3rgpORNNAnyzCpAGrWbdXHXb8jucZ94
         0udyitTT2DD6+19as7FS1jhsGnVYU13tlUVwBCiReQhMqwqrJ7XVlqX1gZFi0b2d6HR7
         52QqLKQHHgDQXV3SF4g8Dt4vgUDsY4z/+73YLjouDOh1W8j8N6r8jre5rnvjiJgqUzFU
         Tfuw==
X-Forwarded-Encrypted: i=1; AJvYcCX5SlRX80Tl/578pXKZu8crtDwMXmOwH96eOsllw5HzHMUnmej0pXcFDSEl1YJkMYIUKL9XYkPc08U+ILE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjzFTwtOXQtmO4ysCV8D4XKD0JxXv0UFaelrvH6r5g0j5pLyh8
	KTPowDxgwjckUpJkEdDiOCH83M+KMiU7Pxd30MdesnWlWFXOgOPd
X-Gm-Gg: ASbGncvYTJLWm2gUs7UqkIEsJwNUiWpDaJ5Lqluj45u22/WnicKnh1bAyil12Fah0P9
	3/VCEgspvjtiX6+KQg2NkfvbgVHoq8br9zxTnk2CEDBWnLxKJakMTVeu+iuMcTBLDs7zfGTSGRP
	49twqwsEmkM0fWXRnoL8vOuEV7aM56rwG1tmRaotPdtzEmk6U8xcP2tCT1amQ1DWPerPl173B6J
	baPWnbDPhPSsef+5ipAmP5fOsmjdCRCvboNcNhJwl1LNvJg/5DJGvp2w4Yy0t8Nvg==
X-Google-Smtp-Source: AGHT+IGJKGp8KW53bYdyUvkeTvw0XG2tTj1XIqJtwXG18KSAshTARZJGCkC+72+jglSeMmstHALKXA==
X-Received: by 2002:a17:902:d512:b0:211:ce94:866a with SMTP id d9443c01a7336-21501d58b11mr79120605ad.40.1732775963621;
        Wed, 27 Nov 2024 22:39:23 -0800 (PST)
Received: from localhost.localdomain ([49.206.118.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521967714sm6131575ad.140.2024.11.27.22.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 22:39:23 -0800 (PST)
From: Saru2003 <sarvesh20123@gmail.com>
To: bsingharora@gmail.com,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saru2003 <sarvesh20123@gmail.com>
Subject: [PATCH] Documentation: Fix typo in 'taskstats-struct.rst'
Date: Thu, 28 Nov 2024 12:08:57 +0530
Message-Id: <20241128063857.7377-1-sarvesh20123@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected a typo in the 'taskstats-struct.rst' documentation. The macro name 'TAKSTATS_VERSION' was mistakenly mentioned instead of the correct 'TASKSTATS_VERSION'. The corrected line now accurately references the macro 'TASKSTATS_VERSION', which is defined in '<linux/taskstats.h>'.

Signed-off-by: Sarveshwaar SS <sarvesh20123@gmail.com>
Signed-off-by: Saru2003 <sarvesh20123@gmail.com>
---
 Documentation/accounting/taskstats-struct.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/accounting/taskstats-struct.rst b/Documentation/accounting/taskstats-struct.rst
index ca90fd489c9a..acca51c34157 100644
--- a/Documentation/accounting/taskstats-struct.rst
+++ b/Documentation/accounting/taskstats-struct.rst
@@ -47,7 +47,7 @@ should not change the relative position of each field within the struct.
 1) Common and basic accounting fields::
 
 	/* The version number of this struct. This field is always set to
-	 * TAKSTATS_VERSION, which is defined in <linux/taskstats.h>.
+	 * TASKSTATS_VERSION, which is defined in <linux/taskstats.h>.
 	 * Each time the struct is changed, the value should be incremented.
 	 */
 	__u16	version;
-- 
2.34.1


