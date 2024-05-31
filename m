Return-Path: <linux-kernel+bounces-197277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF728D6894
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9878028462A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E5217C7DE;
	Fri, 31 May 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnTgN4kC"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DEB17C7CD
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178096; cv=none; b=Zql8hWtArdI2nU4x75SLKZBdbSDyZ6oVKyqq233mreG06Qe2DCFcL+GI8VhHGQvBVDb3CYzDbFXj1gvZ1lsk/ZvAa/RgvfhGHJzMj5b3xMORnQpAtymcnoL7r8WM93L5xPzcqBvo1ryvGBlKpJLrVbOOtddq0PufS+t28/+VTwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178096; c=relaxed/simple;
	bh=VAkNyWRZdToGVNMv8LLoI7PHsQbU36bsxMMTQlDuPBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dPHSRuIQY2hVmvC0qEsXLzDuCzcUFIB4aO/PJGA3ULQUIm68pyQ+mTDXISs5KlF35uThBFgrarzgUwePUSI2nsqXrHXCBXojektxJWfy7VxIWmTAGe5tyQNXBZXoRS6eSj68hGQQTFvyiDzvl1ecz44F8ZRwsTBLshpCBtV0dDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnTgN4kC; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-681ad081695so1604985a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717178094; x=1717782894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxjx9mIfYCUJdb5DqDlSbLqVC31x4VhpSFJITcolujQ=;
        b=WnTgN4kCPfT40nw0ln1fzNBgzLBA+w5NRD0SkS3r/iwAiXZCLDdi6p/r2+ISnG9nj9
         DATV583NmlACQ2NL5j1mIz79AHZ9BAK7m8/CMqqM4KExCC1kNSaz09kVsX279NEzMylC
         ZahtYnJyhYaX3nAei5A+UsGBXZAvMSTUqWDABbi9v6ik0GcOycMkLJNd9tO+lPVBnpM9
         PvOPCcqoveU/VhBTYhTXyHQb+bk7Sn3PFQylhTJooV280Vg/tYTvCHORz75E/BKy9VDh
         3GwsQSFiUT8cNpJ89UWchVOPxniLu5SrT2rQpKC8sR3xyr3y2NfR0eN8pHrQGC2ibg+G
         8bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717178094; x=1717782894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxjx9mIfYCUJdb5DqDlSbLqVC31x4VhpSFJITcolujQ=;
        b=LU63Bp1Ig0/ht5/Dqa75D0V8tDJWs4Pyc9fZx2eSvnmp6mOeSz65su75ovMfmWgd4v
         oO9hCB6uM7QC8LILXyPpkG6IT8XvegWb+UlXNGeI66Fn6SpIfLm7nZw4Z2qr0ZlxsK4W
         JQ0MtYfZ+N7CiMMFkShb0jUEEcAOte2fjZWKaud78G0Y/aFLXhVwgK0rBwblkVNYr2dn
         IUixsuER7G0KEQR4sFE+GyY92Yh9dfzeK1dMfaPr6sU+NYkaadZ98LpxHo16KWmx82kv
         5MQwdN8QtVtu7Lkb7UctYE8CrFzCclCntLvUKsovByfEWB2IU0sgn/u1J5RmGGfE3Ctx
         wAog==
X-Gm-Message-State: AOJu0YwRvqeC7FL03CC+GSBk6NFP2bFBgSV4IWEXTrBZzpCZn3M1V8No
	7pxe9Af3j+XMs8N4yo5Csb7jT191Tt68MTTskx+3VwPX3Pilwk08scPaYvef
X-Google-Smtp-Source: AGHT+IHxKZ1seGtudO6q+ne5auz9TcwO+mM2j1clbIy1cKQp6h66Qi5P4JHkDMFzMOKo2fRZFg82qA==
X-Received: by 2002:a17:90a:bd92:b0:2bd:d42a:e199 with SMTP id 98e67ed59e1d1-2c1dc56dc9bmr2705923a91.9.1717178094298;
        Fri, 31 May 2024 10:54:54 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e755-6440-c1e9-dbfb-9e38-1ea4.emome-ip6.hinet.net. [2001:b400:e755:6440:c1e9:dbfb:9e38:1ea4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c284250asm1891792a91.50.2024.05.31.10.54.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 May 2024 10:54:53 -0700 (PDT)
From: Huaxin <hs139211@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jserv.tw@gmail.com,
	p96114175@gs.ncku.edu.tw,
	Huaxin <hs139211@gmail.com>
Subject: [PATCH] Fix typo in linux/kernel/acct.c
Date: Sat,  1 Jun 2024 01:54:48 +0800
Message-Id: <20240531175448.51389-1-hs139211@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct 'suspeneded' to 'suspended'

Signed-off-by: Huaxin <hs139211@gmail.com>
---
 kernel/acct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 179848ad3..522b74b6a 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -26,7 +26,7 @@
  *  XTerms and EMACS are manifestations of pure evil. 21/10/98, AV.
  *
  *  Fixed a nasty interaction with sys_umount(). If the accounting
- *  was suspeneded we failed to stop it on umount(). Messy.
+ *  was suspended we failed to stop it on umount(). Messy.
  *  Another one: remount to readonly didn't stop accounting.
  *	Question: what should we do if we have CAP_SYS_ADMIN but not
  *  CAP_SYS_PACCT? Current code does the following: umount returns -EBUSY
-- 
2.39.3 (Apple Git-146)


