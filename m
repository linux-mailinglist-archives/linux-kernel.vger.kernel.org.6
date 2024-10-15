Return-Path: <linux-kernel+bounces-364979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2367F99DBDA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C420F1F23859
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41419156243;
	Tue, 15 Oct 2024 01:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig1h637U"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6F54738
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956868; cv=none; b=D8FPUyVGdzxOZL0bdtDshSi35ICdk6tmPzIbq5PUPTYMVQvzC0Pn4EBgJI/37MzjIVlvjxsqPZnFvFyWdUjIo2nYrVqvFfRtZHP1EweSU/A5gW5Ub6KRxUUe5cq9ye9Mbhe/CE5LP4watXw+bE6ggIfCS3uabiPOefkKTtjdxVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956868; c=relaxed/simple;
	bh=Nleey2H6mpjLNRUgj8eAZtflmLtxNMDUuYpvN4avZ+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f+2NH65RPGiH3uZvGKN+oKPj5J8xvTzoRGEF/smz9aPM1B2QocRzCFTqv553JY/Llz3Uxyjr6uNslKQqiq2yrNGOhlXicGwlHs5o5vuVKFNuXj2KLoRhcUmm+lq0biDracz63YhV+bvysQNOQ51kDSYTsJmnt+0adVcAM2mDy5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig1h637U; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cb47387ceso24075675ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956865; x=1729561665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Od9PPiJWSfzSS2iYi922gDR8xeqfA8wbKIX9K4tpGbk=;
        b=ig1h637U5l+TNcczM0hMMYhiK5g5eNDYb/K48co7JxyIM1U2BAdQ+1470G2r9iRRmB
         IuA5RCa208/26F8FURe6COrpTs/oGB72194XxU4B2MX9sfdeNVmn+WffhuOdPr5hotkb
         20a9QYywi2Vjp49H7m2q5jx8I3O/hEQgLyY4PuhIR5JqrLzwxlxJ+eoP6qv/ube5b3LT
         imoRtl8wbOayctEejnDx0lnA0ZyJ1J/lW1bALQ2SKscpfLO6UEFTmGKmKunqmZdUTTQM
         6VLOBlTUdQqvF4Q+s2pIrZNRat6n8UbvqSy8dmJI1rZNGitchQqpiU6q59ePvYDkwIu1
         jGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956865; x=1729561665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Od9PPiJWSfzSS2iYi922gDR8xeqfA8wbKIX9K4tpGbk=;
        b=B+hEZqDhCAJngI5hqLSObBz9aXCMveYW4eA8dzzpmZV6SoCD6w/6W5yTSAOOxvQ/QM
         F1FJHB2vHor/mNCQDrB5+V5OF8UWczUluK9kLYS8k65SHG+OkcBz+95vhaW7quou3ARO
         2J/umDXzyeqeYujZucroavVZ7iU0nZfmwAOdf9AtihTcFC5MLJSN4SqOXZTgO37m0fQY
         3jGJWAR7N2wQGpXUvdxJR5Wqkcv8JAJtvznaciTqdiFQwRrJQydv0m2KsLWRUbEjrQjO
         J7PnJRbQdlUleWESBKsloMW1HfyUw9BC8MA0VGJdtVI1wbq5FqxVTUF6TZ6sxJG2IQbD
         qhhg==
X-Forwarded-Encrypted: i=1; AJvYcCVkFBCbKDdHYL4eZCe8cIHEpZtV1s+unobZkBz6geofc6uIwFRk5WLtzTF6wylxxgRd1hLTPL8MKQNM064=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYz98U6WPt5ngYJx3SAudYsqesaWip5ZegVzfXsmeX6T1mg9RD
	MyAhQ5Dk5NN/pA1U1qDAm3Jku72ROYDM/zC5jClVQOTBN1J5qMaF
X-Google-Smtp-Source: AGHT+IHmLfukJ81rh9Cyrtb7n1QpMwoWASLTTRibUWM/QLDeXu8Mku5SQfH4k/iQGyt80c9xdY2PTA==
X-Received: by 2002:a17:902:d4cf:b0:20c:f39e:4c15 with SMTP id d9443c01a7336-20cf39e4eb3mr70058815ad.22.1728956865495;
        Mon, 14 Oct 2024 18:47:45 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:4e84:7ad0:3bea:5c55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d18036251sm1863615ad.172.2024.10.14.18.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:47:44 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: rtl8723bs: change remaining printk to proper api and remove commented code
Date: Mon, 14 Oct 2024 22:47:36 -0300
Message-Id: <20241015014738.41685-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed that recently some debug sources were removed at [1],
but some commented code were left inside some files, which I think 
was used at development stage. 

[1] https://lore.kernel.org/all/ab3d501e2ef0bb3980d8d271fb667ce20ed8dca5.1725826273.git.philipp.g.hortmann@gmail.com/

The change to pr_debug over hal/hal_com.c, function rtw_dump_raw_rssi_info(),
doesn't impact the user since is reported as 'debug only' on
the original caller: _linked_info_dump()

I don't have the hw, just loaded the module inside qemu after those changes.
Also, I'm suggesting in the series to remove the commented statements rather 
than changing them to pr_xxx() but I would like to ask an opinion about this.
Tks and regards.

Rodrigo Gobbi (2):
  staging: rtl8723bs: change remaining printk to proper api
  staging: rtl8723bs: remove unused debug statements

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c   |  6 +++---
 drivers/staging/rtl8723bs/hal/hal_com.c         |  8 ++++----
 drivers/staging/rtl8723bs/hal/odm.c             |  4 ----
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c   | 12 ++++++------
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c   | 12 +-----------
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c  | 17 ++---------------
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c    |  2 +-
 7 files changed, 17 insertions(+), 44 deletions(-)

-- 
2.34.1


