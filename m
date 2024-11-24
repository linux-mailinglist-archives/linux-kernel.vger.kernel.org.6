Return-Path: <linux-kernel+bounces-419893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1329D7346
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 15:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AD4165E4C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BFA19D8AD;
	Sun, 24 Nov 2024 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtx3U4h8"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBC1227BAA;
	Sun, 24 Nov 2024 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456020; cv=none; b=Xu2y+OJl/z7nJ8HfW7p6/lfJwj/jiUZdQJ5eGu0wDEGe4XF6whewf3tFEutSvY0pu0KINaKp1tplZHkaAtnHHVFFZzRU98YHGvIv/pj3DhvUSnWfmS7ynC1ABMWi40jMjm5Zh2F2HWVMNETxF+VpjTE8pqBgqyQj5whzk3njJXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456020; c=relaxed/simple;
	bh=UQhQa+Yg/KYAh3eKhISv+/YlBTMTOqZ6aaA1ihQ7TcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nBshi7NKlXi2grJ+XNfA3Cl1CrCMHJhkVCL3WdnrWXup8u8RiqBBz7PAo9G1Ij9Nh2b/OlMIXwztqiQO+qYD86dHwHzQnm7BqO5DEaHxwLD8UMToCkXi5fTWxLr2MA4vliGIBvriUbIkD9CW7400+UoMeen+8AlH9IHjMhj/p8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtx3U4h8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21145812538so28573805ad.0;
        Sun, 24 Nov 2024 05:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732456018; x=1733060818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmISgBoq2URn/hDyR4q7MEAA7ngEur9IZlkoC4zkGCQ=;
        b=gtx3U4h8AEP7BKrJW1wfnCow+pM+kUp3kwkUKndsXgL3uRsQ+ubQFGfDkSSRS0SH18
         SzXLrESBp/LynHc9vLC+ZaL+CgQ+2VjoShWpQzyfEK9YMvqeoI5ZfYtv0MiwEq+WUsWV
         Xritu0IafGQqFNhuzJpCIcdVgubGrKzew9e/76cs0gEK2CZ/DOLaB+nNLXjeyrlkJ0x1
         V215fE+wZisQoaFITIZ/gHb3CFMu1il8DQ2jOqmr2k2sNMKTQ862nMtNwyZVlRrZ06cn
         cpZRRK5J61vAkn3z+MVRSZQZTJEwZi1OT1rSrfsEZeFG2cq1TggN4BRLnMyvbV7Id9CZ
         eeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732456018; x=1733060818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmISgBoq2URn/hDyR4q7MEAA7ngEur9IZlkoC4zkGCQ=;
        b=aBMdhBwv8psc+K7qFJ8GiiX94UX5kTv7qQicHjwe9WKkCLRQxDXiTSIa4+/gZT3JE6
         c4+LCxluX9S4O0Q7a95/nilPMuB64JDMtv7m2XD8bpoWek0Cr6UaD02mfRy/cYd7aPLt
         mgD893+4UnKDAnpwX07koYmw0FKtHj+k4aqdqrss6BntNTTW5zdfUOIh3CaGrmzv/BWw
         6Cimq9Dd/+bYUOyTCQJlAIxxWdE6EYiN6DMpf4Syfh6MCa3PsvebZQ7mzZ+xfUZe/Pte
         GjkVQPC0KmTPVLFnpL8dqka/uuY3bQIFEhZpzFAc3RgBM8+y5C41xZR5iM9GEhrNMWhF
         3FwA==
X-Forwarded-Encrypted: i=1; AJvYcCWPaGBvxs17sHy3zfco/3YG1B04QjDKgBH0y6pG5Y1w28bjr5rxJWjFqvLi8trcS+xXQIrwpODgET7Pkf7X@vger.kernel.org, AJvYcCXLeG3auBRZWigk+OMRqVL+5xHQ9IcEGDv+P5XGv6xEyF8aM7fGVJlKwlBR2pamlbMGjCkqPdEZF98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyznJALfz24lfEDQDht6rKIXF3O36+LHUlhixKHXtNc4HqYCuMs
	m3dC+0bN6kKyLnfr2L3IcQyDIOOeeesd8CgGfmDZG9GfpVXIDBQ5
X-Gm-Gg: ASbGnctYJhfmiOagHiKZcfkZGrUefzJjVagi4oNcyLBVsxQAlsdr0gOXuZeJY0qRLad
	RbW3Jacu+xYMNxLmrHU7z2c80O714+h9WzErBalDS8I0+sLCWQCk06tYil5VFKTj4pEj/EHxd/f
	RtDraUG5DOXQYPw9KZoFcDUjDZYzB0rGYEdcPdhGTZBU8ojUb/xTY0ohh+oMZhvOvqpwzbtxX/K
	ZQCxxhqEMiJbw+/7QaT0MlJbtSiM/dn3AgWySsBIfPrEaWVKeNtaAeU9HGNbRovtw==
X-Google-Smtp-Source: AGHT+IEeTHJwNLsbC33Xz4h5tJ2xj1ax/aWAICGlsuNXeujZin4eKHBeBYybX8UBaIWL39fJsXyxvA==
X-Received: by 2002:a17:902:ccc8:b0:212:5d53:d02c with SMTP id d9443c01a7336-2129fd74093mr130141755ad.50.1732456018455;
        Sun, 24 Nov 2024 05:46:58 -0800 (PST)
Received: from localhost.localdomain ([49.206.113.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8c864sm46937225ad.37.2024.11.24.05.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 05:46:57 -0800 (PST)
From: Saru2003 <sarvesh20123@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org
Cc: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	corbet@lwn.net,
	terrelln@fb.com,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-doc@vger.kernel.org,
	Saru2003 <sarvesh20123@gmail.com>
Subject: [PATCH] Corrected the spelling of dictionary in the example usage of 'algorithm_params' in the ZRAM documentation.
Date: Sun, 24 Nov 2024 19:15:50 +0530
Message-Id: <20241124134550.69112-1-sarvesh20123@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Saru2003 <sarvesh20123@gmail.com>
---
 Documentation/admin-guide/blockdev/zram.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 678d70d6e1c3..dbf2b4f47ec3 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -119,14 +119,14 @@ compression algorithm to use external pre-trained dictionary, pass full
 path to the `dict` along with other parameters::
 
 	#pass path to pre-trained zstd dictionary
-	echo "algo=zstd dict=/etc/dictioary" > /sys/block/zram0/algorithm_params
+	echo "algo=zstd dict=/etc/dictionary" > /sys/block/zram0/algorithm_params
 
 	#same, but using algorithm priority
-	echo "priority=1 dict=/etc/dictioary" > \
+	echo "priority=1 dict=/etc/dictionary" > \
 		/sys/block/zram0/algorithm_params
 
 	#pass path to pre-trained zstd dictionary and compression level
-	echo "algo=zstd level=8 dict=/etc/dictioary" > \
+	echo "algo=zstd level=8 dict=/etc/dictionary" > \
 		/sys/block/zram0/algorithm_params
 
 Parameters are algorithm specific: not all algorithms support pre-trained
-- 
2.34.1


