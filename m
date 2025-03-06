Return-Path: <linux-kernel+bounces-549294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F7EA5506E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1857A2C5B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FAF211294;
	Thu,  6 Mar 2025 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M59Msc71"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8B83D6F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278108; cv=none; b=mTHKvcqXmxZBFPv4h1Oe1cNIL0HPfnQwJXLBbjvijpRA0sOzd8qVAS7nNcrUGhmF66Y1bENwQzYtaBq1Ywu2YJ/M2dj/MBnCiuRbJb0flRBvF+UQ30Vv00kBzARmOSyk7Gb1YfWDwKoUX82UYLVw565Fan6xwJqZ0IzMaNCFNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278108; c=relaxed/simple;
	bh=NnwwiFX0fgN9MDN62lMjnICri18W7lMtlk90+146rbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9/2ZSmbO9zc9rvo2fO2LVkGyzTIIuKxYtGzgUGp/nuh+P/8fgOaq7y/j7ITkhr5Kgg/X2Tem+6VBm3BC9gwylTvDD+5vAQ0bqGX2HkVtqiWjpz9n2GLrxJ2rYroX/B6LYXcmvZWgqXrt/n9k+KRH/hU30O5nG2jtRfAcUTBtPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M59Msc71; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bcad638efso5574545e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741278104; x=1741882904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wW8fv/c/SOuj1ifoxIC+BzegNrFlqpqBNUShKNP4Jmc=;
        b=M59Msc71zCvXZCg7C9fT4ifu+PMb8YVhFgYWQziMFfeclU4iTDry0AAwufibJ3313z
         czgu+Yr257c0oqd8sMBAkIB5DEgdMmuJNyA4RFKlB822ckqYD6VQbUUP30rS/r6s/XK6
         FC5sxI1Z+t7Q26ukswAkO44hmaAIFlnNj/CJMSBZUbzWDZ2aASFAE5r4FMHPCoV1cV0x
         PW5gL6DHJ1vONuKoyG3gQyRqbeTffbDibT1anI/jJiAQ0pNwXeLIfR2j8p/22ymyVxjQ
         nSvEZ+i+JpOk11TIATOx69Ot7swrXwDr35nYeNyZuclT47A6AnpHYv8WRmM9u2q0LzMV
         O/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278104; x=1741882904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wW8fv/c/SOuj1ifoxIC+BzegNrFlqpqBNUShKNP4Jmc=;
        b=NSyuMY3CRb5/h87g6dlq2Os90GpFPibhDNcJR8ii6w8cM4svggifzlYqFuISYj+tGZ
         FFa31S95xfaTTpKkYYhk7klfNyjVriUKjtPUCP+6ERCLo/xAS+UUTXZLO4eer2IDIE2z
         C2gqB/D1/RBaeqyOtwnDS+oNqZF4nGdM0+Hb8O0kVjUmwTsfGsEcWW44kDuGXIb8HaF6
         BsISPdjyy4ldZYbIzm0FfKaJY6hFNe+unmkNVHr44X02VvnsIk7kSegM5eMTh7m2WF7t
         pp9tYMznhmtdPrFGC7DqnzGF8Dss2Owt2kStXzsbELng4gbkS9XSAQbSCCBiSe8QiIBb
         32Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVmLyM6ESNIlrCs1/c+lb2UqHEpTiFbJa7z4bLQQqFwrrwxrYjUxMTQGG2cTMPl3JMba2vdcIq9nJ+mOrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwybR6N36eiLbHeB91jLv9pL2rX4hgMYkHzKjCVsKZsCXzJVqlJ
	Dijnhfnt4RZn6HrT/DQORWkPPFyTrWvIoPPyyEVyI+UMAA4iThKsnqtGOVBmIXY=
X-Gm-Gg: ASbGncsoWrOlh5kSU+JxFNYZrO2Mx0hYPnkGGFtdLvyTbj+GkMx0Bp0NKbb+DQltZ/9
	IqWpnUX/X+wcFWWaMPOC7/CNo7tiAXfBLKBGyuByDTqZ1noKnoGY5Wu7fEAxfzFjBMjSCxiBEtY
	SSjQSV1elz8n3sJAL9tAZa+NHP5YCbUPBCbt7Ygcr+Rxt9Ko4oFsHnZPdf7j1xs4yZ6OYt0VzCV
	8ZGYxhJL88RZ5ib1XBu6v99iCmZxH2m63qUmIwg3Fy3Z3h3zK9wmna5S98U2mFarI+VPbotUC9o
	7TI/XdNQk4h0esA6UdF8nmuQhm2P+FucZmy1YRkaC6m4Z5LN
X-Google-Smtp-Source: AGHT+IFHQXHU03Zs/hnxG2LMsd+FqGQL18YfZKdZoNQgvKHJ+pNPDgffKMalooCg9O9MuolKgzLHnQ==
X-Received: by 2002:a5d:5f84:0:b0:390:f55b:ba94 with SMTP id ffacd0b85a97d-3911f73fa74mr7220020f8f.13.1741278104005;
        Thu, 06 Mar 2025 08:21:44 -0800 (PST)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0193bfsm2507741f8f.55.2025.03.06.08.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:21:43 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update the MODULE SUPPORT section
Date: Thu,  6 Mar 2025 17:20:59 +0100
Message-ID: <20250306162117.18876-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change my role for MODULE SUPPORT from a reviewer to a maintainer. We
started to rotate its maintainership and I currently look after the modules
tree. This not being reflected in MAINTAINERS proved to confuse folks.

Add lib/tests/module/ and tools/testing/selftests/module/ to maintained
files. They were introduced previously by commit 84b4a51fce4c ("selftests:
add new kallsyms selftests").

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..0c8a00b0b49b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15982,7 +15982,7 @@ F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
 
 MODULE SUPPORT
 M:	Luis Chamberlain <mcgrof@kernel.org>
-R:	Petr Pavlu <petr.pavlu@suse.com>
+M:	Petr Pavlu <petr.pavlu@suse.com>
 R:	Sami Tolvanen <samitolvanen@google.com>
 R:	Daniel Gomez <da.gomez@samsung.com>
 L:	linux-modules@vger.kernel.org
@@ -15993,8 +15993,10 @@ F:	include/linux/kmod.h
 F:	include/linux/module*.h
 F:	kernel/module/
 F:	lib/test_kmod.c
+F:	lib/tests/module/
 F:	scripts/module*
 F:	tools/testing/selftests/kmod/
+F:	tools/testing/selftests/module/
 
 MONOLITHIC POWER SYSTEM PMIC DRIVER
 M:	Saravanan Sekar <sravanhome@gmail.com>

base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
-- 
2.43.0


