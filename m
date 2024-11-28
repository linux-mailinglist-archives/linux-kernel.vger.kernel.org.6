Return-Path: <linux-kernel+bounces-424258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1749DB229
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 05:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7111A167C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83B513B780;
	Thu, 28 Nov 2024 04:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CKJNNjGo"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A263D82C7E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732768000; cv=none; b=T+fTydHIyL7T+hhkM7S5avHCPcgfOxshflzAKqlw23IkkAAYGe8opPvOV8QyQKsJr01ufGqctUWAxAeE61rHw8f0GWJAx3AvlJnhcqV7uEOqyEl4QUqvIwe2IqebXtUubxOuByUExuZ3UNhYVBD1CcrRzB0EnW1UHihu12K3lEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732768000; c=relaxed/simple;
	bh=SQ5HTme1SLECGbVCaGoPHfecPrbsN1EOEWv6CHUAVP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sAfQUGD/ENYpWvLLAhDGU+2o86HH4L21WCi9r+uu+TsWoxny4KKMPp30CV3beCU9BZC6SdzFpoGGoCD5Uj9PucTx1OJHxGOqWccWmFETlawfSuhuIeUs7lXiBSAPu3TLFIFAnwlb+9D9zo4WSIgV79r9IPHY9hG0We5sar+d9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CKJNNjGo; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-724e113c821so448508b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732767998; x=1733372798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyk7Iou25uRg3TCJZa+tSFUnZozoGmQKQzSvVwcJ1m4=;
        b=CKJNNjGoB9nwkV51z6xz+dTyhdEk8nnBvfC4B0VL+W608Iqw9i0VUSAj9R1JYjCwBm
         BWyhJK189hq3Sg+DDo46Q/IkkxmhhUOLHGK/W+IfUNCjUDKqGSiFuo4riaROENZRoKo4
         EGmNhP1t1xLCk/OAp5JHt8kILqThOL5Ee1noQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732767998; x=1733372798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyk7Iou25uRg3TCJZa+tSFUnZozoGmQKQzSvVwcJ1m4=;
        b=tPliCbTXkPTXhKee0una7XBaNHs/GQ6+zcRQxi7+Z9HO0zX8bhlRLpBu9vP9G42gZG
         mkkaoj4EZ1vKir6ni3RKKimuxbmaf26H5WG76wlEIAd4hzuLJK5pEX3Porh6xfGW48rk
         9npDMmEDmMIi1rTMmGX0Lg1irnwcjPIWZ+wrpbhdl8fOpn/+055KxJEkcwyoOwwf6AV5
         uKKqcl25WAztCXZff36ejfMWHlrv+sujWbqJhf7bwY6IN1g7r6rONNaASL+utFI7zRxS
         +hdDt6KqZ/B+2RcJFecWNrhlSoNh8k4HOJAZZ9oQQUqU9+2Q8wkzVxb8BqPHcTVsVfrZ
         4nxA==
X-Forwarded-Encrypted: i=1; AJvYcCW9QYlWFOjiKft0mIzbzU+0ZDoyAW/ExbGImaTXSvVBbBKMThCQteDqtvCRmN79sxKlkfdDTNJnsK0j9z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3klWJaSXUlWuX79gmzxNhJ7YihJr8Xc7FawuJXRrj09aSpwYz
	SfpVV6DxidV+9hlsYLZ3gEadgdJLb6SslQZGrMwuq4dua+SaJb+eYe9kjfDc3Q==
X-Gm-Gg: ASbGncs6KWEPXPm+4ORFe9ltJLx2MP4XR51hCGrAwqWZ3GQvpwHWsM0qFvHkodUu5N7
	8jrgYmb+Hyb7xWS/qUT8xBQRZ2tIdIHKhDPF7zg92PG7MRXjphJltG9aXOFs/hCMnSSxLuahN1s
	2pJSKbD78kQbvR02Akbr2dobeb7lP/tmN3rJxf9VXSq7e7oiO+MhGTP7e7hUZJ6cpTO1ni6Nc3c
	PzXKgbbYimK4C+IgY0o+kyBVwE60vMbNZLEyCIiYclFjhHXPAjOaGC5yQJi/zJ++OZO
X-Google-Smtp-Source: AGHT+IHeZNuSWgVtWvTDokMDlIw4ArRKKjwJZ33jbZfsR02Ur3asny/Ji3uLw2rlY2Y0R8BhHPJDpA==
X-Received: by 2002:a05:6a00:3d0e:b0:725:14fd:f62c with SMTP id d2e1a72fcca58-72530078935mr6645836b3a.15.1732767997932;
        Wed, 27 Nov 2024 20:26:37 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2db5:507b:eafb:b616])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541849509sm439133b3a.197.2024.11.27.20.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 20:26:37 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Wolfram Sang <wsa@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] of: base: Document prefix argument for of_get_next_child_with_prefix()
Date: Thu, 28 Nov 2024 12:26:30 +0800
Message-ID: <20241128042632.231308-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When of_get_next_child_with_prefix() was added, the prefix argument was
left undocumented. This caused a new warning to be generated during the
kerneldoc build process:

 drivers/of/base.c:661: warning: Function parameter or struct member 'prefix'
 	not described in 'of_get_next_child_with_prefix'

Properly document the argument to fix this.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411280010.KGSDBOUE-lkp@intel.com/
Fixes: 1fcc67e3a354 ("of: base: Add for_each_child_of_node_with_prefix()")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
As requested. I assume Rob would give an ack for this to go through the
I2C tree since the offending commit is there as well.

I also put this patch on git.kernel.org hoping that it gets some bot
coverage soon:

    http://git.kernel.org/wens/h/of_get_next_child_with_prefix-kdoc-fix

I guess I should have put the original patches on a separate branch on
git.kernel.org for bots to run earlier. I'm sorry for not catching this
sooner.

 drivers/of/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 4cba021c89d3..7dc394255a0a 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -648,6 +648,7 @@ EXPORT_SYMBOL(of_get_next_child);
  * of_get_next_child_with_prefix - Find the next child node with prefix
  * @node:	parent node
  * @prev:	previous child of the parent node, or NULL to get first
+ * @prefix:	prefix that the node name should have
  *
  * This function is like of_get_next_child(), except that it automatically
  * skips any nodes whose name doesn't have the given prefix.
-- 
2.47.0.338.g60cca15819-goog


