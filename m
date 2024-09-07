Return-Path: <linux-kernel+bounces-319784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E8197022B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 14:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E7B1C2158C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 12:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231DA15B977;
	Sat,  7 Sep 2024 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5h9AzWH"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9351B85DC;
	Sat,  7 Sep 2024 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725711953; cv=none; b=KJWVSus9PDguRCkQczoxe5JXqohV1T8PHEQzwILI/YJLIIIfcvpl+8agEaw7RLBwP3nr3s1IjDcIFUeCznGtaU5YdVCFtQaqbPA1x6OFvymPkEZTESpGLbeCA+kPc0VMi4aM4viZ+5KedHUEV5UHQU9jqFAQUT/GF6wdH8EclDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725711953; c=relaxed/simple;
	bh=IDFLMWF0sr98Nz6o04LtSrB1FRNk7wAxpS/OlCHOCHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DmbxwImVSpMqwCq/9xxaFaI6isXsti3A5Nu4CvreJZ1H+zNHbIusW0wvVR+3qSsdlH27wkq+bNCEIpTqtLkOkS4LKX5AtOGjymjYYIrJ6O5X8ZOXB8yWgCgsjIpmUG0+ham6cyj31q+clr87TVEKPdGcZzgoOOvCrl2cwdd1ULM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5h9AzWH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42bb6d3e260so23651215e9.1;
        Sat, 07 Sep 2024 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725711950; x=1726316750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mGLn13vOqyi02McjuZ5o91VC854GNRyf9UZYfl60p2U=;
        b=R5h9AzWHEXm1rJjP1+CHpKVyZTyZmtlxiQ/urLXS4IGcpWhnVKzCo5RL990kR+SU+p
         MFHsxJcpZCCe+RwGGjR0L1XneGrRQzkeX96skd5JzzDcKugd1ZMnn7w3+vObE7uMet0o
         Usq4BM/01x1+fO/5cB3oWQ74k3Bdm3ut3COcjnZoDPHvmklL8r1vPcfEG/hwbPlhJ5J7
         3Ffd81qeDmH3Gthdo8XKbhZfoNf/PWTrShPNdycky9RznQ2TuPcNHtMY+lSGw7DQrhr2
         MIzakALvTVd6wE3LQhTBqbvhtlmRKw8B+FlYoWOhA61nKfCoztkSaSH3V4dXjwqTwO6u
         /sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725711950; x=1726316750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGLn13vOqyi02McjuZ5o91VC854GNRyf9UZYfl60p2U=;
        b=JliEasM0yBItA8nAsDDr4VlbGwS9AY//R2KFu0ER36aaA8o+GDwPrxO98UOhhV1pQS
         ZCCR5WH01C0rKw3in4AKpSVTby8ujUgywlNhRIUmkYm/EVFraztDLc8lDTSfjvbn7f+U
         DUOvhGRYD7vFa4dOZqcn2DDaCeVO6+ronT0QhXxWJ8OKhWjo20dMH8IG+Tt053DxCAZ6
         DdB3Uo/8hRHrfnKUMjP5kLobeh9vHnZxAk2spPNXOJ/YI4Eg8RDEgIukZ8rN76O3jW5v
         7IScUQSI5CwTLcFmAaZxfLPLfY/kvxBuAsNMop7AHeQuD/1g7lghVfpajzPotBnxTOU8
         v2OA==
X-Forwarded-Encrypted: i=1; AJvYcCUGlEbadZYysVa4wgyPxMT2qH/4DhXE3SJavcBfKSDLT985fyvqFSgxYEqVCelToU/HP+KyLHTyCMi5@vger.kernel.org, AJvYcCUhR9Y5bFwnnE97tD8le/ydXjFZBnWiraHPvyT3NGuDNCls4OAYKgucQyM0tbPTfgOnxKVySWEojDA2L5DQ@vger.kernel.org, AJvYcCW5fklROKAnrAHHN+iuJASS8ChAMpHv2b8RydSdtQ0h9E9qXgLbHYehwnzH3189L9DEsa39p79j3+PRjdZH8uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHw8QTrmSbKYVitaRn0dgafqTdHP9/YYw+2ZHCfaAKyONv6KPE
	EuY4qUDN/2qKPM5o7CPiWU9102S1BINEWqNHjyGRUxigFVQ/lYi4
X-Google-Smtp-Source: AGHT+IEWcsjHo2WKugFYtP7kKcQJFOspfwt7F8M04DVXmlxk6PgC0zpj9mYba8M2nW76d8HrHT9vIQ==
X-Received: by 2002:a05:600c:22cf:b0:42c:a8cb:6a75 with SMTP id 5b1f17b1804b1-42ca8cb6c5amr25868885e9.17.1725711949317;
        Sat, 07 Sep 2024 05:25:49 -0700 (PDT)
Received: from void.void ([141.226.8.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca0600639sm47346445e9.37.2024.09.07.05.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 05:25:46 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH v2] docs/process: fix typos
Date: Sat,  7 Sep 2024 15:21:39 +0300
Message-ID: <20240907122534.15998-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in documentation.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
Synced with docs-next as requested.

 Documentation/process/coding-style.rst   | 2 +-
 Documentation/process/maintainer-tip.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 8e30c8f7697d..19d2ed47ff79 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -986,7 +986,7 @@ that can go into these 5 milliseconds.
 
 A reasonable rule of thumb is to not put inline at functions that have more
 than 3 lines of code in them. An exception to this rule are the cases where
-a parameter is known to be a compiletime constant, and as a result of this
+a parameter is known to be a compile time constant, and as a result of this
 constantness you *know* the compiler will be able to optimize most of your
 function away at compile time. For a good example of this later case, see
 the kmalloc() inline function.
diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index ba312345d030..349a27a53343 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -154,7 +154,7 @@ Examples for illustration:
 
     We modify the hot cpu handling to cancel the delayed work on the dying
     cpu and run the worker immediately on a different cpu in same domain. We
-    donot flush the worker because the MBM overflow worker reschedules the
+    do not flush the worker because the MBM overflow worker reschedules the
     worker on same CPU and scans the domain->cpu_mask to get the domain
     pointer.
 
-- 
2.46.0


