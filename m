Return-Path: <linux-kernel+bounces-181160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7873E8C7850
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E28D1F22FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC49149DFB;
	Thu, 16 May 2024 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcWuseYu"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8321474D1
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868870; cv=none; b=l1jEG8AnLQOt0WgxvF29Ur15Ro49rjoG7GJDy4Plpal3WYG4mcxjkKAjfp7BXbobJOhG79RMVG8JlhjgnGxeSnIvERkqR0EkQ81NrL0zvOfNEEp63OWziESF7nGO9DlLmLCegIhFVdwX1Qo9ekThHP91hOk5jVuh+XrpKw0aEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868870; c=relaxed/simple;
	bh=UmKIrSg4ynhZVpemxfEfIZRxQvu+Crio/QC+XAqfZQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KkSSAQLjPTYsy9yhnPAtiASOKGq25YxqV7ffU8roUcgyC9LUt+mwXt9MjRNU64XlV1HLLqCQwUwJrT1HsYbCtt08rzQYqlkwiio0xKZYe6N78/ZyDeYcvaF5g2ZC/2BXjXxy+steNr6Fm9om9Q/50WxaV8aUUchprTcab6mUF+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcWuseYu; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7e1b936987fso41788939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715868868; x=1716473668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/2FOoA91NkUeK0C95CT3vcLU7VJcFennlVEdV0K/sw=;
        b=QcWuseYuQiQopGQHhI9J0kPtK37qxbgePrU7mSbasfCdDgsrdLOmQZzLyu/iQgYFeK
         0G8q/fWljy8nb9YJEeJMm7S08pZKWNj4yS6WZG2cGrw97QLyjxqi8kfw8Crkg/filZ9h
         NyFk2Ll/lVACxfI0UaE40HrDOAPpHT1NQzd3eP8FaMBm0fFQrOKEOwlnLW0Xqw69dAVb
         hER5blHvbitPo4xIDWkw1E2aQtIBn2fpO2nxhzxBoJRt88CvxNZCTBs/jOYmFAtQL5ci
         ViFpnVwjaD9WL8ulJ6G9KSQdwh2iHP92QdWOoH+GFKk+jnQZVYSABAqpbgJqEAqekxWH
         BHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715868868; x=1716473668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/2FOoA91NkUeK0C95CT3vcLU7VJcFennlVEdV0K/sw=;
        b=uM6X79M8D/SK5DtuF4eO7z0v+MNPKtQ0WpDt/rEZKqYgOVb4hWEFQIC/6fiIfgge1n
         8fuIrh8yYIrc5fIZKRteYLdzzYTunFyh5XCCMReXXgHbM0q1uLLQO+uv5EzMnhYlSjym
         tuahfCAmWz/AtX13Yowrd72+8nvrriE+Ie6341JCwtjPcX08Jkr9SUk65f6e3q5PXOKe
         R3lZU/DKUTvW6mjIpmhzdbQD7x9ll3ARhOTwAKVcfe0urnM+ZK5vMDIl7GjLkJUc7ehZ
         JWe4wxAaUi/RlyozTH67WVnC5G3QTs0ZoKggGtpyRNlZQtMIJ+NdYLJavoF8gw6vI2nV
         X9NQ==
X-Gm-Message-State: AOJu0YxGVwI+OU+9ZVTYffN1DfMNva7GpeadDYgiNZdFGfwu7uVw0DOR
	2JujJsYGGhIA4xT9H3MgXxOUQ574z+Q77wVZymN4lRy6TZoILGYYRTPI0w==
X-Google-Smtp-Source: AGHT+IEaZvDJfqtyJqKpX6aGSYkoLHiHEzguYTGxerURTWW8CMN/2adPbenTYofd+axgskL45GBRbQ==
X-Received: by 2002:a05:6602:14d:b0:7e1:b3fa:6470 with SMTP id ca18e2360f4ac-7e1b52205abmr1898022839f.19.1715868868381;
        Thu, 16 May 2024 07:14:28 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7e207673a0asm99332939f.11.2024.05.16.07.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 07:14:27 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/1] checkpatch: allow multi-statement declarative macros.
Date: Thu, 16 May 2024 08:14:18 -0600
Message-ID: <20240516141418.25345-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declarative macros, which declare/define storage (at either file or
function scope), cannot be wrapped in do-while statements.  So
checkpatch advice is incorrect here.

The code has an $exceptions regex which allows multiple statements
based on the macro name, etc; /DECLARE_PER_CPU|DEFINE_PER_CPU/ are
currently accepted, widen those to accept /DECLARE|DEFINE/.

cc: Andy Whitcroft <apw@canonical.com>		# (maintainer:CHECKPATCH)
cc: Joe Perches <joe@perches.com>		# (maintainer:CHECKPATCH)
cc: Dwaipayan Ray <dwaipayanray1@gmail.com>	# (reviewer:CHECKPATCH)
cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>	# (reviewer:CHECKPATCH)
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..cddf4c416523 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5901,6 +5901,7 @@ sub process {
 			}
 		}
 
+# except for declarative macros (whether file or function scope),
 # multi-statement macros should be enclosed in a do while loop, grab the
 # first statement and ensure its the whole macro if its not enclosed
 # in a known good container
@@ -5958,8 +5959,8 @@ sub process {
 				$Declare|
 				module_param_named|
 				MODULE_PARM_DESC|
-				DECLARE_PER_CPU|
-				DEFINE_PER_CPU|
+				DECLARE|
+				DEFINE|
 				__typeof__\(|
 				union|
 				struct|
-- 
2.45.0


