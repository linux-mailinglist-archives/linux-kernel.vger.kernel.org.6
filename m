Return-Path: <linux-kernel+bounces-347376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9D898D1D7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C081D1C20A39
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896A6200119;
	Wed,  2 Oct 2024 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlrCgeZP"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45619D07D;
	Wed,  2 Oct 2024 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866744; cv=none; b=unBT6HzRG/NnxnIpCI70qleTJRSFM87f8n0ozOkyqwwTd/CCY3H1qYoNItCmvoz8FftGq1aXijhQrArFO5VepY7GWzYDgnbVxBdsf55JKASuwrZjc4QLXdbVP1lpK1O8SGMiDwySVQhiNngJ7VoJ+TZgpgQyezUZNwb00faq0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866744; c=relaxed/simple;
	bh=bf1amEPVAnQM4N/N9CM0ybR5tOJb4KYgGCNZJQPldiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mXbzC67Ra08oM5tDxPzH4l0h13rZyKJSjzGV5gH8/xpbe7lOQDTx+kALIPO2ZrEgmlEAqLTZAwAADKMZWlN2D+Znw2GWxWpxebNjsLppaJ/Dd7Hbnyy4a91c9zkyxI054lsMV5yJe+HMSJx7NrXCY3BF4/0mmRiGZYFRHUvwvtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlrCgeZP; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-717934728adso5109444b3a.2;
        Wed, 02 Oct 2024 03:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727866742; x=1728471542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CmxahYmbXjzmcugqxfdm9sGQFimaHOUIwMPIG8sDJ8I=;
        b=jlrCgeZPBWhFZeYjlYR3UUnb/8RN+xiSXi3dDQQ6vIVZp//RE9H7qLsO0m/gxxdaLd
         IGwwdT8//iiFZlGy4dPqHVx8Cw7NrjQDc+aoSieGbHiLrUOXqIE/qB0AGhWYjt8WxYVx
         UTdmeKli4txhTm9PrmvlVluWqMHVIYO4Y7k190qqYjKkjGkr80JPJAYg2AqEHghgijae
         699jl3WSEn4T4qgyERHAf0Hoz4HzmYzAD9uRpK+V8QX72y2smNoRfJitJ0IlX3rJNj9y
         ms065dD/0tvf1Iga53EALa/DbG286B2+HZRAqyv1muu9rbFQOT4+q5h4rdY70lq1D24+
         8Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727866742; x=1728471542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmxahYmbXjzmcugqxfdm9sGQFimaHOUIwMPIG8sDJ8I=;
        b=in/Udr2Bg3IlYXE0UiVcA0dpoedDmkq/GXdINpL8tWSdgHOivZltMBnXWf7Lt7/Yt9
         DQEA7J+jiKv2YA5BL+tajXajsR2GuxBMIRgJdSg7VOMPC1vTCWKxlWfvgnjqbjtq94es
         QTiDjipUN6RA4o8xVUsOJfyeE1SMU060p2lgBLm8/EcawPLyatTReQfqbGOB68utySn2
         7BjOh19lSO1MFFpS2AlaxpJuOwPFSQA172XT48Rh0Ph+/ICkqPpWRSd8mMH1W2tuoMyO
         Mc3iuaMfMnq7ERmUaN0PJhKHmxjNrBfejEri0OKysTtZW5BuPi1Sv+8TQ2NLz0EAz0KQ
         Nd4g==
X-Forwarded-Encrypted: i=1; AJvYcCW0Vuqp8lCkZWA9TN/Stm5a/UE7BAK6ubBaYLXMnhP8HyI0FqoikWLJfWuaAxeVs0gyHHQYLHAycu9XOQwo@vger.kernel.org, AJvYcCWJ+vCtWVvZXfWBmfKP2QD5sd/EhDyHjygvLQqKNwgC61VwRV7jn/3Bk2G8SVf2Kh5uE41kbm/BOSSO06o=@vger.kernel.org, AJvYcCX7tJy2yOrbW/OYmx2iK7wEFY2aaVV/FGQol6irHVYYixQ/FlOX8d7/kBNAS6TCuaaKe/jML7zTZJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRBd2l9DgcR6SALdFduuYEkWKFsa9RAZ6LxJK4IcEsPVDQxSY
	ni+sNoXBDeFK8IKRLX9snTJKyMhwCrmid7vXNxiOcZp6dBdcgzDP
X-Google-Smtp-Source: AGHT+IHy7qDJbi+EUW4yCHRON4a53xdqt7OcpHOxnJLswyd+3OD9q/vbP7u9kK0AS5qJJHn6Tt4Nxw==
X-Received: by 2002:a05:6a00:2e95:b0:718:a3c1:60f6 with SMTP id d2e1a72fcca58-71dc5d6a1d3mr4308947b3a.18.1727866741889;
        Wed, 02 Oct 2024 03:59:01 -0700 (PDT)
Received: from Archie.mec.ac.in ([14.139.184.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264d73f3sm9805935b3a.90.2024.10.02.03.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 03:59:01 -0700 (PDT)
From: KK Surendran <kksurendran95@gmail.com>
To: jdelvare@suse.com
Cc: linux@roeck-us.net,
	corbet@lwn.net,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	KK Surendran <kksurendran95@gmail.com>
Subject: [PATCH] docs: Fix typo
Date: Wed,  2 Oct 2024 16:28:45 +0530
Message-ID: <20241002105845.172101-1-kksurendran95@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo in Documentation/hwmon/max31827.rst -
"respresents" to "represents"

Signed-off-by: KK Surendran <kksurendran95@gmail.com>
---
 Documentation/hwmon/max31827.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
index 9c11a9518..4a7d12934 100644
--- a/Documentation/hwmon/max31827.rst
+++ b/Documentation/hwmon/max31827.rst
@@ -136,7 +136,7 @@ PEC Support
 
 When reading a register value, the PEC byte is computed and sent by the chip.
 
-PEC on word data transaction respresents a signifcant increase in bandwitdh
+PEC on word data transaction represents a signifcant increase in bandwitdh
 usage (+33% for both write and reads) in normal conditions.
 
 Since this operation implies there will be an extra delay to each
-- 
2.46.2


