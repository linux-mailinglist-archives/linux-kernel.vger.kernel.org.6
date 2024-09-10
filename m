Return-Path: <linux-kernel+bounces-322947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095D997357D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3682A1C25053
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B1D17C220;
	Tue, 10 Sep 2024 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="gUnACpx1"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9594F14B06C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965422; cv=none; b=bO/ThUI9G1rjDRkwkMTLF0c6w/B9zRrtUvhsWCat+U6/WuJKjx0/nh/usg5j2NLQOzH3fuNM6+g01TjPRg9k/y9Xlfwe0awALY/DQA73Kh862ddMqlKRpj+RsjY6oleYzooVxykgkK2r3taOn1Sfz7QA3row2dE795CPXpYTB2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965422; c=relaxed/simple;
	bh=j660FIt2LkNBUOlAD8fG6i3s65RXTVA5vEPHfgPW6AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pYC7V9lYw6+unl+Zzka0g1XhEL/QTPAD5KLrZxjlk4KD94lGIIzv1eGSDVIuBJiUyETuhVeEqhkXKhlWMPY7Eph3iVV5N8rlFkLjKX8sG5PL/oW+F6p9NlYGcjVkalvBHHCGrGSWMuR0R3b0ICyrTjWM1qRU+6SUl47snX2JP+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=gUnACpx1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb3c6c353so3634575e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 03:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1725965419; x=1726570219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kTCp9nY7FQEM3AmaK7gIs2eZ38YLpBmTnUOj1/n38Xo=;
        b=gUnACpx1upy7ki8K8G0dcz8z5s3wfzO/u5YA+s+0rF0xjiVa3KmGC6tiNIsKsCjrpe
         V98AVVp1r9mmdCX7fP3RqhUGcJBKZ0wZ8tchVWJd+Q/2glcBqRGpxqBVRsc9t6gsdSdC
         2aHPNHnY4OBdJU/u67gbDrs5VijJcuAXP7fc2m6z/yoROhTFJwYNNTAmPpYOXQ5mkJ1s
         edwMpnayapQa3d9B7zrWxAgRmCWSKMeKmwLf6LcUI1CIfroCfDLZf7rCEBkeF1R/QbM4
         06qvpK4SX4Hh5k2cy81ObcgfYrUukMNpVBpNwXxUDZ3e7aIZNM9b3d5bWWlzU4PgHemq
         uvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725965419; x=1726570219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTCp9nY7FQEM3AmaK7gIs2eZ38YLpBmTnUOj1/n38Xo=;
        b=s2bYMChSxls+io52FNGfBklgqgb+NGFYlnHrP6AiA9iRIWKulNhOVHfByP67AkDxzB
         bZUv5yFBWFTA1r1I7aau2h+R8OYxnN0xvV4MPC2c5jPM9Vi4XKUboWOMvKD1u9f9Hv4w
         QtYGAvkZ0mMgkL0jzvPuKqctXB2Cv+PRDPUR2TiztbTTCqDIl4NBTS/PV0+Zw41xQMcg
         nTd6zGG5B4Cc1xHJdBUfvHUnSQRYBKn4MufWIJ6mL3r7CDu09l5Oc0N7xxKSfnPDl59X
         MvyR+J3FtLoZ6jRyNDqh5LyqwuoZxU2taRsR3Zc2SK3Sagqb4jDfclaOZIFd2SeNFLPr
         8rmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw4TsHKtk9yayDGhNVOlEVfYer4A3HUoIXwBSQ2wufYD18a0buSqXj1EZwvmvcwDQq2l0PndAa8ggL2fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfShKvQc9rbV8Srs78KYTPOFWhztOZ1bjWcp4nHJVmZ3Kzz5CN
	ycJYeMZ43PRZDiTEONolNYNXKOtChWuA0zmIBA32B/xXRGkiqEBTN94zsw/dnvU=
X-Google-Smtp-Source: AGHT+IEWUdW0zk8adQ4t2k43BCT3ytMYT82ahbXEVJ7Mir9v+q7r+D14fxbNeEjwHcI8FM7pRrG09Q==
X-Received: by 2002:a5d:5f87:0:b0:376:8378:2a60 with SMTP id ffacd0b85a97d-378895c5ab1mr4746018f8f.1.1725965418704;
        Tue, 10 Sep 2024 03:50:18 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-91.dynamic.mnet-online.de. [62.216.208.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895676117sm8509673f8f.60.2024.09.10.03.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:50:18 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: kent.overstreet@linux.dev
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: [RESEND PATCH] bcachefs: Remove duplicate included headers
Date: Tue, 10 Sep 2024 12:50:08 +0200
Message-ID: <20240910105007.4882-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files dirent_format.h and disk_groups_format.h are included
twice. Remove the redundant includes and the following warnings reported
by make includecheck:

  disk_groups_format.h is included more than once
  dirent_format.h is included more than once

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/bcachefs/bcachefs_format.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
index 14ce726bf5a3..b97fd0f75831 100644
--- a/fs/bcachefs/bcachefs_format.h
+++ b/fs/bcachefs/bcachefs_format.h
@@ -499,8 +499,6 @@ struct bch_sb_field {
 #include "disk_groups_format.h"
 #include "extents_format.h"
 #include "ec_format.h"
-#include "dirent_format.h"
-#include "disk_groups_format.h"
 #include "inode_format.h"
 #include "journal_seq_blacklist_format.h"
 #include "logged_ops_format.h"
-- 
2.46.0


