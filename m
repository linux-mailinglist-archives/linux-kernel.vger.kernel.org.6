Return-Path: <linux-kernel+bounces-548597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1B4A546D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95549173412
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0B020C005;
	Thu,  6 Mar 2025 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyV81C9d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB520B7EB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254497; cv=none; b=bTCWIC/2foY3MBkhS3RVVk7RlotRHKBB4ydM627iXb+mcRgxGG44E80oVxJnVyLg1gBLTdFQHiDI+Avh7DdUzQiYQ5RfTE6LYO2LHBAIwZT7ntrbUxhfkxARrzBhlvOS7yPt241R2lAUREJlbWNyA0DFNeTkvXhTnU/+yOCzmvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254497; c=relaxed/simple;
	bh=3ho3qGo1lVmXuX2dMlnltG2fGWa3E3AUvtUOA6OLNpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7vaviS9bm4imNk68CMiYzRYsVLhDAISRMZdYAzUNv89gSnIR91U35gUEXeb/vWdQ+BcJRYd79VnK4y/NegERtELBNBq/Qsko+put4EuNlPQYeelhdN70b6zLYb98oQ+6WBvsN04I3y2ZcxpDkgcroDEndE4PAzHIIk0+DgnRAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UyV81C9d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741254494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qhoIeIC0J8+KZetLEFZda/wAPxtts5eJjpdjM7DSGkg=;
	b=UyV81C9dvG7nv+zEu55kJkQD+/9vxN6I7TyEGdnzR48dbL85WMalQdNlCe7/V6KE80ZEAD
	1sMTCsvwcVb1gzK4FQKH0vLs6FTRggaSTD9Hgg6X59IN1UGgRwd2cNj9hKQvPXV3+Q1hgB
	Fd1Hwo2s9rF/SJy2AXEtODyQeF4vkDc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-rWx8FyLEMPGlhpifgBu7Pg-1; Thu, 06 Mar 2025 04:48:02 -0500
X-MC-Unique: rWx8FyLEMPGlhpifgBu7Pg-1
X-Mimecast-MFC-AGG-ID: rWx8FyLEMPGlhpifgBu7Pg_1741254481
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390fd681712so215773f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254481; x=1741859281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhoIeIC0J8+KZetLEFZda/wAPxtts5eJjpdjM7DSGkg=;
        b=sBpX7ZJUbhnlZ1IbYtD2zWJ9lkyw79r/sRowIPn50a4BCU4vqXH+trwQct5uZ0e4K5
         2xMCqDJz3uZ/Ekp5Q4w2h1tAEEJ+CAn/61FDa+rJNUvQiZkTxL/QuQLoM9m5vuF9DEKH
         KZXqw0A/lr0jVMYhFLUrahVnAOLlSqMl4mum9Wlzv13zc2N1GnPFjJg938oucfMQDXi+
         8TQs+1tSWbdmtxAimc2QsCWltdcYQI5pjXR264FPOu0pJBDZP4sZVpkrYXPe5j7m3FfM
         BHJUApAALsdiEDpCxVi1T/cBmkX1EFURhWkmV2/otXhFnkL2vJUIxFSFEx6WLSbIlpmU
         LT8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNupGqCSMMnquDbYnX4YK50T0VF75OpdcMjhkL36oDFJQkEKIMc/AEjd3YQflCyxCw9AjIqPwVMAXPwHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU49LqPB0tEhHrPEjJQfYLcX5LdKFt1aUMQkSSkV3A1Gftmn7X
	KuwBl3dSmBcwOgcLyPMLbUzkp3B7hRb93QqHv+ghfY0SbmgPqn6kA1ZG0sJCvc+aD4k777fxOa7
	iQxcqfTSQDUZ6liSkHrGcFpxSuKZEp2SGc1o4ui9H6l+6pLP8x6yG65r8Udo+70KvPV9itfW4
X-Gm-Gg: ASbGncs4ywBbLxZLfm+fTW24TNboavg6owbleopUGeNLsd8gzZH5UoPTdbTYvlp1vWO
	YwVnn6PtVXLQ/X3rocYQBnKz/WbDxAxwFp31+kBU+pb52wuZ3SYUa+vBK2AZZ18zDU9BSpLcVjy
	wz9dITf579Sh80fY5GUTvD6vF+FLWnjKdIO/T0ucRCCy3y/vGYESzGuu0V+eODqNuu+hR3sUE2J
	tb5rZD5j5fSuPg6KDsHcjfHqjF8CGRmx0Qh08fNyOae8ZV1j7Z/HNj0aQbZOyL23fQPwy7aeWDR
	cOaVKHOQ0H8HK92uHcJ//u55UviQIeym6V/7x+4j/GUyzlNhajVHNTxW73AyAiM=
X-Received: by 2002:a5d:5850:0:b0:391:4f9:a039 with SMTP id ffacd0b85a97d-3911f7400aamr6723544f8f.16.1741254480848;
        Thu, 06 Mar 2025 01:48:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaiIHXbccL0gmNV8J9au35MPia1hghbbM07U8lOSRBfu151n9eSAZV97mDiHYuec/YepoOoQ==
X-Received: by 2002:a5d:5850:0:b0:391:4f9:a039 with SMTP id ffacd0b85a97d-3911f7400aamr6723518f8f.16.1741254480467;
        Thu, 06 Mar 2025 01:48:00 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm1507462f8f.99.2025.03.06.01.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:47:59 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] net: ethernet: Remove accidental duplication in Kconfig file
Date: Thu,  6 Mar 2025 10:47:53 +0100
Message-ID: <20250306094753.63806-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit fb3dda82fd38 ("net: airoha: Move airoha_eth driver in a dedicated
folder") accidentally added the line:

  source "drivers/net/ethernet/mellanox/Kconfig"

in drivers/net/ethernet/Kconfig, so that this line is duplicated in that
file.

Remove this accidental duplication.

Fixes: fb3dda82fd38 ("net: airoha: Move airoha_eth driver in a dedicated folder")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 drivers/net/ethernet/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 7941983d21e9..f86d4557d8d7 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -21,7 +21,6 @@ source "drivers/net/ethernet/adaptec/Kconfig"
 source "drivers/net/ethernet/aeroflex/Kconfig"
 source "drivers/net/ethernet/agere/Kconfig"
 source "drivers/net/ethernet/airoha/Kconfig"
-source "drivers/net/ethernet/mellanox/Kconfig"
 source "drivers/net/ethernet/alacritech/Kconfig"
 source "drivers/net/ethernet/allwinner/Kconfig"
 source "drivers/net/ethernet/alteon/Kconfig"
-- 
2.48.1


