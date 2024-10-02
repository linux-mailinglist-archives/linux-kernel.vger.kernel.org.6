Return-Path: <linux-kernel+bounces-347309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BB798D0D1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663D41C21520
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4851E5018;
	Wed,  2 Oct 2024 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeZvOE0g"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB9D1E2033;
	Wed,  2 Oct 2024 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863681; cv=none; b=oupwLkG5XI0dJxJFKUEJg2zEpF0fIyYkGB3aIFxcxSf0nKIVh2pg2AUIcFDcSN+t1EDQxAzFKRvUjUzU2gOaQN2k0Pl72NwCSkaGUa4VbwCmqV23oxZjNrdU3ip3044ATCXdlJiBIIAvLMDNn0z627O8p2GI940jZUpu9jC5TjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863681; c=relaxed/simple;
	bh=TO7/NutLSsI65V9enOm4GUYVHO36xIMAiuKNoj4iglg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ybwn5W8mRKzg906xCIiVUT+oHOzsuOmNkbq6wirrgUBH/+fo/tXdEd5PYD0zZsE1ZuhSMis/7sEY59dhbfXhqxqpGOV5bVlPvCiL9axRjz2vv62P2nhdvXp/vrScIhgGmDIEQS5JKKmq1SZwcVW2MOvtRdZxG8QCausiW5NaEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeZvOE0g; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20aff65aa37so51658875ad.1;
        Wed, 02 Oct 2024 03:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727863679; x=1728468479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=14Q+51lEtCMWPbPTU2z+ynVN1U+8L9MuSncBS1QlX9I=;
        b=QeZvOE0gn5pAPpYmFDn0nfp26CLYM08Xgr1heIo9rkCJVitA0C/gHqrQjmmdf+S7LP
         ypoxenEwyswAzYq8NiqvP6Vz4ndECqWlSD8aUJ1fIW9MyTuCdmCmPF7CGErx7D6pGZ6M
         igXPDEZkn5PY9Tup7OCbjeU09h4LdF8PWO66YfkEmaNLCXOBgPHafLrJwDfxp1o0zfNM
         o17fpSyRe5gR1gspVQ6TrmECMhZWmuXeTeO7cFfsWXM2cY16zZo1NZK3lNoyiq9nBG7+
         lCFjbOEK+Os7WopTo4f78FU2q/hi24va9J0rX68sYaIaaUbBZD1Uqc3vxhQzpYuOotIG
         CruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727863679; x=1728468479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14Q+51lEtCMWPbPTU2z+ynVN1U+8L9MuSncBS1QlX9I=;
        b=cfx5kC3E1CAsBkeKxqJC0f/06xUX+21fMYhy1x1fRlB21eWp8J35tkjlQElkMEBihh
         NncClJJ+aqQ0PbrliCwy7UxD5OHNKC3i1Kl5vAgyJXrH0J0voyIL4iNyveIILleM0sng
         j2p4qVa8LXRiU4/mQhz0TfmwcdS2i/CvXv+XhA/TPqaNEk9glUiTTpcbmIPLdB89Eh2R
         IEaLJgLC2jfu8OwjlrR3RzfvZduQECaHwB0JOb2l9FviqEOvIjvf6MmhusqZ0szeLsSF
         q3uC3Q8f1oCby3t71p93x2H12iL6KRX7U9IZkpVXuUcc8DkYFb6qCq4M+4WPyrpmfyW5
         PgxA==
X-Forwarded-Encrypted: i=1; AJvYcCVPRFgX5Gm/WbwxJu4h52aQxg2LeAIJwCghTCwkYEN6FDmVyrZ33Sl/1/3e8+EMxYppVMAutn3hx80=@vger.kernel.org, AJvYcCWwtgdLAx+pTY6u36g8K8UOsbDLW+yy3MMHhgUztKWHojxgqd12XMH2QfhwpLC/rwdmqg5RuGMOkit3Mpc8@vger.kernel.org, AJvYcCX5DfI2TmfPw8qL5mx1G/yKhGD1dh1f9cslcsjtVqMzbX4tQ1vf1qMXJ1W1HuJNcRZSk0NNC3Td/RZM7zet5F9azZbebw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDKRU0nuRxYQCw+cSmld2ry57Fqt9/Gn5APPBiS4vt49jX3dzz
	pOajPXddFGoFhUdlu04iRdVY1wFc3gfUD0DurVzO4fPo4UUNyMwf
X-Google-Smtp-Source: AGHT+IGQtiFLmEAMAssuq7f48Fg1bmraT3yPSxBoe/38vyWEV7PGlD6DLNCQ8tJP6+4GlTkklo61gA==
X-Received: by 2002:a17:903:2451:b0:20b:b75d:e8c1 with SMTP id d9443c01a7336-20bc59f0750mr36585365ad.4.1727863678652;
        Wed, 02 Oct 2024 03:07:58 -0700 (PDT)
Received: from Tua.. ([2409:40f3:8:b90a:de56:8399:2f69:ff5e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da22basm81561045ad.100.2024.10.02.03.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 03:07:58 -0700 (PDT)
From: Anaswara T Rajan <anaswaratrajan@gmail.com>
To: W_Armin@gmx.de
Cc: corbet@lwn.net,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anaswara T Rajan <anaswaratrajan@gmail.com>
Subject: [PATCH] fix typo in Documentation/wmi/devices/dell-wmi-ddv.rst
Date: Wed,  2 Oct 2024 15:37:48 +0530
Message-Id: <20241002100748.309707-1-anaswaratrajan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

typo in word 'diagnostics'

Signed-off-by: Anaswara T Rajan <anaswaratrajan@gmail.com>
---
 Documentation/wmi/devices/dell-wmi-ddv.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/wmi/devices/dell-wmi-ddv.rst b/Documentation/wmi/devices/dell-wmi-ddv.rst
index 2fcdfcf03327..e0c20af30948 100644
--- a/Documentation/wmi/devices/dell-wmi-ddv.rst
+++ b/Documentation/wmi/devices/dell-wmi-ddv.rst
@@ -8,7 +8,7 @@ Introduction
 ============
 
 Many Dell notebooks made after ~2020 support a WMI-based interface for
-retrieving various system data like battery temperature, ePPID, diagostic data
+retrieving various system data like battery temperature, ePPID, diagnostic data
 and fan/thermal sensor data.
 
 This interface is likely used by the `Dell Data Vault` software on Windows,
@@ -277,7 +277,7 @@ Reverse-Engineering the DDV WMI interface
 4. Try to deduce the meaning of a certain WMI method by comparing the control
    flow with other ACPI methods (_BIX or _BIF for battery related methods
    for example).
-5. Use the built-in UEFI diagostics to view sensor types/values for fan/thermal
+5. Use the built-in UEFI diagnostics to view sensor types/values for fan/thermal
    related methods (sometimes overwriting static ACPI data fields can be used
    to test different sensor type values, since on some machines this data is
    not reinitialized upon a warm reset).
-- 
2.34.1


