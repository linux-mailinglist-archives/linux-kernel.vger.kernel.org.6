Return-Path: <linux-kernel+bounces-520520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648DAA3AAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E293A96EF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8351D5CF8;
	Tue, 18 Feb 2025 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoKqdWFi"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316681CCB4A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914282; cv=none; b=CQMv9wDx2VYyyQIuvO4REMPoPRBX7CS2GDOfh6qQq98w5p9zvXfqfSjsgKsK5bAj0JJFTtcQ5iFjuHFM6q3up0JLBRpo8qv93XVIu/2DJaiT90TLkcz+tFxUBjMtPaAcCbBHKsdSbBlLJC6vLP0THiR2DG4nDA++kKZoOsPmL6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914282; c=relaxed/simple;
	bh=Yud/s6ORIg/J/giXovwRTeCSvY4JVN67geWGps1KYVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sWpE3z6p+YEZQjrKbX9FTq5bxLQs5aSkyQhtdhowr912NbH5tmc0+Hoejwk7bkItos6vdRKgjFOI8s9EwQ1gEnS73qjfpOmal1iPRmIB/vwCaPhYN7wuY5wdWQ+5O7ky6+qp4Ug0CE0ORyHAbzVF+6VVk3oJ1CVjfiDjm9M4cpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoKqdWFi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220d601886fso80381045ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739914280; x=1740519080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rP+96HuaKMpCU/L7D9t3sUZu/nD4Dx+ijfnfPQ8f6ug=;
        b=eoKqdWFi2caEslaiOTzzmDIEM9+mTieRlooylZIy3j3nKVpYNGxq72FqCozK9OxGNz
         tHc498B4SuXzdn8Mq6XMLwgVhaNNn3Rbl8juipd2c1+wTVKdiiCoWB7HjFhXEkusbwgv
         OLlp3dGRjSXdbCvKolTqv3lzHfIyPS3mKrCl3dI9HNbQzJQcxtKoQpCZbnvWX+Yhv7MC
         JV5VaQJxvbTHDV3fidImeaSZGxMiskkyyatnzz9n14oGsS5T3rr1v+Hi6ZUtO5m9JNRf
         di4W8RFS69aV7nf4zqoL0VuQrjsO8WlWm8o8VqfR879cJGhwpdES95xOZZHkX+wvZ5+Z
         AxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739914280; x=1740519080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rP+96HuaKMpCU/L7D9t3sUZu/nD4Dx+ijfnfPQ8f6ug=;
        b=I82dYstsU2tmVE8fE9aTVN8GZ+rQTEa3O4/4b+VtVbhC+wSExk8MSAYhRkeVNm5K2M
         TxQiatejF2ARJ6fEUvCXljwhropgyCyUfAriGUxhazxqiBkJ/WRwCxjIx68jZVHh5xNP
         ycSKYcn4VkoOEx/OIk2r8wg77FCRoTv2Izr6LaKqmXglJP9/BSLkpJQhVwpNq3up8Goo
         K02EGfTr7Tez8PLK1WUqlJu1w2HTT3DP+qxPAjdIWUtGkSgxOq6k5fSKuGwxrt/18G3N
         Qz13dNSzvoP0ZyfL5J2TpCAwhGGzLhJpC+bv2AMjezUT+41FWWIp5qvrlBHLXW5ZSW+Q
         w6jw==
X-Forwarded-Encrypted: i=1; AJvYcCXKR6nV5BKZ4E28Ra+2C8HuKEW1Ogcr3I74djPEgo2chegILGwr0H1jBdzqKTU8xpvIerztIZgzmbbbfxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdttEFa9LYcjKwRG3rnWLfpj8TM8rWPYjdVftTjyTVx91MNdKe
	yOH6FUvwze7tuIenwl91yrppCtjNvd317FTQdqXzojgbpwKZeRTp
X-Gm-Gg: ASbGncslrR8pj+2C4Iq5REi3qT4uYPxAVJVeBI5jIOzA64eaFB9b2B9ARj68gJsKLIF
	NRxr0TkIQvrVx/QQ9ZYLI+9e8850JjzzePU6OJL85WDZh4dq2jirZQo3UgZ0YH17U+zRLTQM4Uc
	PK4uuSj2yJF5vL3dGCz2buGuEEvhiBtnJoFd7eH/ap1ThHIxVdgFTSlBDOXGVT7462JJ+fpG7p7
	deTvLJsCinxEyQ8tC8jRtVK1x1mJNwKqBSrib8r2/Z/DXMtUWH+K7UDaVXvmzhAGQ/pimYOXpcV
	ath4S5eyyMeaiaHSD+3+cV7FKM6f4dk6Xp/WFf75tBbIAGvEFPU4GLT//diZyEuwwVH9LhGhoQ=
	=
X-Google-Smtp-Source: AGHT+IFCSXyrADrgyHdUmI8KsbcmXkcneofMLx2Nu1Z95lFa8KGKNOu6LCrP+RxhPWTUvcli17JHnA==
X-Received: by 2002:a17:902:e5d0:b0:220:c94b:83a7 with SMTP id d9443c01a7336-2210405cc72mr207634765ad.29.1739914280248;
        Tue, 18 Feb 2025 13:31:20 -0800 (PST)
Received: from node0.suho-242436.threadtune-pg0.utah.cloudlab.us ([128.110.217.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366b24sm93845095ad.97.2025.02.18.13.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:31:19 -0800 (PST)
From: Sumya Hoque <sumyahoque2012@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sumya Hoque <sumyahoque2012@gmail.com>
Subject: [PATCH] Documentation:FS:Fix minor typos in filesystems/f2fs.rst
Date: Tue, 18 Feb 2025 21:30:56 +0000
Message-Id: <20250218213057.557707-1-sumyahoque2012@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
Here is a minor fix in Kernel Documents:
filesystems/f2fs.rst : comp_extention --> comp_extension

Signed-off-by: Sumya Hoque <sumyahoque2012@gmail.com>
---
 Documentation/filesystems/f2fs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index fb7d2ee022bc..412b0949143b 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -310,7 +310,7 @@ nocompress_extension=%s	 Support adding specified extension, so that f2fs can di
 			 nocompress extension will be treated as special cases and will not be compressed.
 			 Don't allow use '*' to specifie all file in nocompress extension.
 			 After add nocompress_extension, the priority should be:
-			 dir_flag < comp_extention,nocompress_extension < comp_file_flag,no_comp_file_flag.
+			 dir_flag < comp_extension,nocompress_extension < comp_file_flag,no_comp_file_flag.
 			 See more in compression sections.
 
 compress_chksum		 Support verifying chksum of raw data in compressed cluster.
-- 
2.34.1


