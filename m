Return-Path: <linux-kernel+bounces-563726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49442A64747
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E5B3AB885
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01612253A1;
	Mon, 17 Mar 2025 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqzXzOEN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B92222D2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203652; cv=none; b=BTuQDn83Cjf6R1bIJFGea4ZPLH+tI7M2pOuCcZ74cWAJScXAx5RU5e+UPaDNCO2sKz8FtULhLyDqBEbeaixbS+WmznG0FeAG7rXZEawhsHEX3Nf7Nu1VSI/XIEFbZldRrJySxtDHk73iCPgyDCeaxwRjdMCpG3MxmPz9pY6TJh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203652; c=relaxed/simple;
	bh=wc8ZUJs4juXlpOzJC3dYvkAmWROYc3NkYrmr2+p4WQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ssSwtLZp+GdN/fTgmshIxvbwfPxztKapAuy60L/0uxRWPWpJA3cdtv+owm/1EkErPd1zpJMzfJ+zPrEE2RE0X0kzxB5/ah1x2LRx/Vpw0n3cjX4q3OsUyPoJOZbtcncHv8FUtQf+JP9aY+/+sBoRw5qyzTjG0CQcPU1TBUszPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqzXzOEN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742203649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ELVb8/TgPP99S2US6QOwfM5yFjDUVc6XvoMzilxTm90=;
	b=JqzXzOENl/divQG6HdzNRe7hqNPkqFSTmE9VLeCGBdu99M20gdyvVylDgV9Y/d7yOeeqB6
	+Rr3xECxp+dTFDojgqShkjhfbqEa2/0RL1dS9IA8ISBATAe7pFZjAW0BAPeIMHzkY3Iwse
	KAay0we3Mz7kJHSo91eXrzQOzyKy3ZQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-ST7NcI_nNTicxXbhppvBFg-1; Mon, 17 Mar 2025 05:27:27 -0400
X-MC-Unique: ST7NcI_nNTicxXbhppvBFg-1
X-Mimecast-MFC-AGG-ID: ST7NcI_nNTicxXbhppvBFg_1742203646
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39141ffa913so2492203f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742203646; x=1742808446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELVb8/TgPP99S2US6QOwfM5yFjDUVc6XvoMzilxTm90=;
        b=JGTNv049odFnMp/4rr58hQkmx4T4BdWDUthtLxhWHZDLO47G4srZq5TCkd2j4qYElR
         MT04P3OgrRAwug15HUwQCncdGYO/vGkmxNoL4uAWB600Hn4dvTvxVxXNFx8gtprtxa9E
         jpQng12JUPcKx6CWnfo8cRPF1a4tTi9kA40c7kbZEd/eJJZBwR76t1crVSW08ujmNjWH
         2NCZaidWWsa+ICXT/diMtUuJaw2VqwM1yTkDvGcQoFG38clNxodi1tJtuxZ5UKiRHvQh
         /y/kHM5HfHA/pkPBfPBYmkw9PFNipVppB8E1mnV9Qx2NeiI5QwkLnAfYN232FqT2kYCU
         fVKw==
X-Forwarded-Encrypted: i=1; AJvYcCWVQuxA+TPoSmUG+w/4GXiIqGhSmX7N73LC8+t+pJqyKrrTTAkA/Q31JY+I6n/3+oCCJVOJKz7V3CfPlKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU2wM7YgmVRuoc6vmlwKvimCi1QxgEoS+D4VoAeCa9Y/Myg88J
	ANLJUFJMfW9Zm1naKTIwutV51UWzvtQdxuA7KPEnKG8w/P8IMwFiI+l6ARiMtN4GwTyQmZ+qKM8
	3FruARufkc1FWwk/UjsUnnN/fPy902pOaEFBGT6gXJUWnPxvf9Mw9mHb0wRIZxA==
X-Gm-Gg: ASbGnctKKb7aKJGDYi6YtCG60dRW5vbFVFABEDi/Xg2Few86Vlx6s0lp7RuMBZ2zPZn
	1Pw4RuOaQD9AAH74K1JjWvtbaljHqRNdehwcuqOV4NnNbZ9Un+9COs86fBfLiFf5UGabdf8OPTE
	M6jikwLiK0pT7NBZbG/tBvlrbL0WfW58lna5QxIh5JzKsvpmJW+GykfpuGao/xidhiHGRgL7Sod
	syUxUIuOR7JeomwaGoQtt7wIiyODcNQ0sC+hesnvAmp2Si4eC2opS6NbnJR/YsJ12Pwk3Wcl0oj
	2LMYU2AYQY7rXMYdAXKyqAk0Nuyhrt0Orq7CnRvj08o5WRMfOggor9sTmX9Kla0=
X-Received: by 2002:a5d:5f84:0:b0:391:3fa7:bf77 with SMTP id ffacd0b85a97d-3971e3a54cbmr14547803f8f.31.1742203646494;
        Mon, 17 Mar 2025 02:27:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRgjJ/x/oVlKZKHU7TipAkeP19C9rZyh+PBBydQPPRm8QgqfVoTWGnhCYtv13jfPOOqNUncg==
X-Received: by 2002:a5d:5f84:0:b0:391:3fa7:bf77 with SMTP id ffacd0b85a97d-3971e3a54cbmr14547775f8f.31.1742203646117;
        Mon, 17 Mar 2025 02:27:26 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df3506sm14795571f8f.11.2025.03.17.02.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 02:27:25 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Chao Qin <chao.qin@intel.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH net-next] MAINTAINERS: adjust the file entry in INTEL PMC CORE DRIVER
Date: Mon, 17 Mar 2025 10:27:17 +0100
Message-ID: <20250317092717.322862-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 7e2f7e25f6ff ("arch: x86: add IPC mailbox accessor function and add
SoC register access") adds a new file entry referring to the non-existent
file linux/platform_data/x86/intel_pmc_ipc.h in section INTEL PMC CORE
DRIVER rather than referring to the file
include/linux/platform_data/x86/intel_pmc_ipc.h added with this commit.
Note that it was missing 'include' in the beginning.

Adjust the file reference to the intended file.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
I think the commit above is in net-next, this patch is to be applied
on the tree where the commit has been added.

Jakub, please pick this minor non-urgent fix. Thanks.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96ae7f628da4..9544a4e84f99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12069,7 +12069,7 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
 F:	drivers/platform/x86/intel/pmc/
-F:	linux/platform_data/x86/intel_pmc_ipc.h
+F:	include/linux/platform_data/x86/intel_pmc_ipc.h
 
 INTEL PMIC GPIO DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
-- 
2.48.1


