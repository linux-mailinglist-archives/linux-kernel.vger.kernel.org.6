Return-Path: <linux-kernel+bounces-191389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FF38D0E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDCC1F22221
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BC116078F;
	Mon, 27 May 2024 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR+Nw2a1"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8826B208D1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716841818; cv=none; b=PoBmC8tfQpSCLJeeQ/arTGmMF0L/u0/dr3D2aeCwGQ3bqg1T4QdvFVgYZahGWFBQu/ugEONTI34gk2jRx3WHtWCX8HzarX2fy+6Uki9iVGbjeyLJ99EI1l+TyRKlSmKLIAy7/cGEbJiYbaLjElEy9Mp7ljBgZEYtz0PdWgM3FyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716841818; c=relaxed/simple;
	bh=3OmrorevJpcg2XwjqTWzUYiNQKYSougMWPmDXdlriTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TaHlsKAnEJsu4JyGUHoWU7XBbGpnXMRa54kTGtGwwlh3XWMu01RsD8hQyyyQUpiRIUMjZUr1p9SYKqRYnIb160ct3iqDXH7o1fXN6ZF4of3fLu4rEyMBduU+I8tUzYdT7jHWmR1TjpZLxEfG65WZC1rE3jandk7pXup+phBIN6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MR+Nw2a1; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3737b3c6411so96585ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716841816; x=1717446616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D601ChQsTU17iMmGHgaVIi72Ruxr/9qmn076K/NhIOM=;
        b=MR+Nw2a1GA45hcPfIMfhQZlXT9+bhlsNRTahZwVep+fC1vrZpM0svrpvgyyLX7631Y
         w0Qu1rGG2gT63F20xgal7oAf9jjpiEQ+/mlkymEOhPbBstOQZNVv+7EJRvufZ+/WUV79
         qzx7SoJKCGo54X+a99+CywmajYKiHXhReQmo6RZc0C+mzik8P5lm60RVBTP0oPfadOf/
         /vpVOr3t2MkKNdqfMvpGgfFahardYdkqWYiv+iKGsbCIU9Fkd8Hv0JxgAwpu1HxAU53P
         AHwDixnDBMAhOkYGh2BRLyLb3dwpAXtPkjlNZvsSyj0FRjo2lDstDM1CVVNWxylynrql
         eLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716841816; x=1717446616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D601ChQsTU17iMmGHgaVIi72Ruxr/9qmn076K/NhIOM=;
        b=BOhqAMMQHfqtCmv/RQiSKHHeSUoOvDSu3Vwwj+VvDEBY1064nSYRoK/w/NNiTbIJNk
         w+vhK81SEYb6bUDLb0IFmCrKQ6I0LEkkoP775S5Uqa9R9wDjV31xaSB/nZG0OH7OAL9y
         5AKsCM6b2F6vAEqzj2cUitLMcb0if+j05bOht8tPaYndh7npuxKuJ1c4vaVOG0udnTZk
         4pdBL5iWv5DuXaI4lkFFp6EptiKmWrvCoRRZYQLaXR0bJ/BbosBpTyiUICVCOFtPdTaS
         dFHh4O3YddOaIsCVQCYG3BzAMWxUQxmpQxgboqfCITqsfaq4bDeWLg82xLkHZ4sCD++w
         1YRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNmrTIYPZQVZ+NmoVr4hsXZDwG22eqqiAgi/cvvm9nGBRROl5yz8HQEmCjwqdTFO2w+ZOr+donSkg2vMoaXPBFnMZJoIs4DJPZET2l
X-Gm-Message-State: AOJu0Yywc+gnso8U+qiNofICVLcfP/IaFnKNKr1KqJlLMFe1QoEsfeLu
	iJQJy7xkgjEzvq40lwdgJksxhO4CmUh54/b3FAojgmkYFONqBzdY
X-Google-Smtp-Source: AGHT+IG7+t1tPNdon6ZDZxy7l6R9rkwzUX8YWeZLvD4kqZy3tNeDwvBmpb9zjmSMFPMCO0HHriJdyQ==
X-Received: by 2002:a05:6e02:78c:b0:374:5c40:57e with SMTP id e9e14a558f8ab-3745c401203mr23368225ab.0.1716841816544;
        Mon, 27 May 2024 13:30:16 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822092a678sm5324279a12.11.2024.05.27.13.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 13:30:15 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/4] lib/sort: Optimizations and cleanups
Date: Tue, 28 May 2024 04:30:07 +0800
Message-Id: <20240527203011.1644280-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

This patch series optimizes the handling of the last 2 or 3 elements in
lib/sort and adds a testcase in lib/test_sort to maintain 100% code
coverage reflecting this change. Additionally, it corrects outdated
descriptions regarding glibc qsort() and removes the unused pr_fmt
macro.

Regards,
Kuna-Wei

Kuan-Wei Chiu (4):
  lib/sort: Remove unused pr_fmt macro
  lib/sort: Fix outdated comment regarding glibc qsort()
  lib/sort: Optimize heapsort for handling final 2 or 3 elements
  lib/test_sort: Add a testcase to ensure code coverage

 lib/sort.c      | 14 +++++++-------
 lib/test_sort.c | 14 +++++++++++++-
 2 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.34.1


