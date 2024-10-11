Return-Path: <linux-kernel+bounces-361786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFFE99ACFF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B631F21CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3D91D0DF5;
	Fri, 11 Oct 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MzDSImMX"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321AC1D0DF2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675832; cv=none; b=SS5XK4jwxclhS8OX9fdHfo50PB9d0vBBrKVLaA6QJ7qX2fMgAo59hfvFa6vIsRp/1btq0YtdeTrN+BPsOBkSuNBJxTIq+aSY5EUKochSU2DXw8PeYAeRG++kd/Q2noEehoUkYamoUTcc6rcbqG3yWMbThhcQhMptk4uszmKiSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675832; c=relaxed/simple;
	bh=HiP2jOYwlaN68o8fGVOSlLIUh0g94c1H626IWPYeMaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Oggpya0HwjIITYp+9ErW72MjWf9Ag0Ha3965OxmSMAav0W7VrUvjRn18MXi14S37MBwVS0YOPi3pVZBbumFAsVk+AdhIVWQ+VuPElYGldXsoFCBBgnxd4ST3MolK7u54nye3Led9cYgAQcC+1AbBXCfT64nxMUZpUbF2jHEFQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MzDSImMX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d533b5412so829873f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728675828; x=1729280628; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=snxiN7FRdAtoQFX+9wj1Js2TBnmcNUFNjqb40Wms3JA=;
        b=MzDSImMXLs6LaRdCpvtEeqnd735C5Go/xkpg+mTtaUjmqjMFMPugGnq2YKPerU2pRb
         buVoZD+42JuYLgbIbHvJ3XQixjS2z+DPmtWC3ZbNSR813efLU3eLdeT/ckwgXOJePJe7
         IKZ0KozpYIN2iYH3C8rRaQTxN2lRXkInYKbh+ibc8bKliCm6FFfRh16+1Q9r58F2rsMI
         FaOBimBwPp+ELhBOsQyQuf3gyFTAh5vpBY2Zv4EP7tzrDZjCreTrGr/gQp4KCyg2C4Sk
         mWj2Jj/BQhsWynTgRV3lglYQUtxTVTMxkIL2h5gm4CRsGcsxy3EkRVtYsgm80ORJTmcr
         bu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675828; x=1729280628;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snxiN7FRdAtoQFX+9wj1Js2TBnmcNUFNjqb40Wms3JA=;
        b=UC1vvV2TU0zbpy1g9vtrF5FoTMlsED7cHbhDLfR+/pfgNeik4ET6NaUqeCON5I+jwa
         mb4OGtHsaPM78qtmnyrGlWbDXfn6xs8UVzGL0Y06nsBWNyDJcEFrrJDOaPp1k48fugVZ
         a0mrRKfJaont7z3WupFpeun1EbcNUxOEIb/3JW71HsLQZ6RFXplzPlbLoTurFl1qXJt4
         ZaznZxItCe0Mwumx0jRE6P2nap5fElNyBRnwAEFWYGFr1yrCXihOJvCvFIfiCPnGwjNG
         jm49BSsvgHdvSXTmLMozkEbviigRZrP4Eg6rsHzgtCimrZ8P+xYnzXyZidLO6bSHTEil
         wRvw==
X-Forwarded-Encrypted: i=1; AJvYcCXzQSgu22dpDY2OUcVnrlMrK8VDf/VjiUF+6KbzfVZ+4GpWJoFU+oIbRgz5pp5a2i0xlGH8UqGJgM3OHuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymNS9FUSbO+9001Js3/DcK6HDayyzS8g2spp2xxPLcGO80QKQK
	LkenE7ZUBhnyuMtMpZ/4v0FU2+BbofWTP2O4/TXPec6XPkRUMXbW5mcGDlN03Uc=
X-Google-Smtp-Source: AGHT+IGqnlRZZDSw4G70Cr1FwcKYeBF9aBQnwl7GGMEcvuGtDm0ChmM83BRDyWQouKHv719pFKBvZg==
X-Received: by 2002:a05:6000:18a7:b0:374:c92e:f6b1 with SMTP id ffacd0b85a97d-37d551b9788mr3103211f8f.23.1728675828472;
        Fri, 11 Oct 2024 12:43:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748d885sm83769715e9.46.2024.10.11.12.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:43:47 -0700 (PDT)
Date: Fri, 11 Oct 2024 22:43:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Theodore Ts'o <tytso@mit.edu>, Ritesh Harjani <riteshh@linux.ibm.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ext4: cleanup variable name in ext4_fc_del()
Message-ID: <96008557-8ff4-44cc-b5e3-ce242212f1a3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The variables "&EXT4_SB(inode->i_sb)->s_fc_lock" and "&sbi->s_fc_lock"
are the same lock.  This function uses a mix of both, which is a bit
unsightly and confuses Smatch.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/ext4/fast_commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index b33664f6ce2a..e4cb1356e9b6 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -291,9 +291,9 @@ void ext4_fc_del(struct inode *inode)
 		return;
 
 restart:
-	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+	spin_lock(&sbi->s_fc_lock);
 	if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
-		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+		spin_unlock(&sbi->s_fc_lock);
 		return;
 	}
 
-- 
2.45.2


