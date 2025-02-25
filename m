Return-Path: <linux-kernel+bounces-530519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75358A434B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609CA3B8EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F9F190664;
	Tue, 25 Feb 2025 05:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzOEXfVN"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711F22571A3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740461856; cv=none; b=kt3UOaRMe0b4Y6eBw+rscoZwiZF4hHvyXvyhf6OgSErvvCFcNU0ZcEOTQ8dv/8nulZS/lZLEhm+UJNLbC1bhy0tJsBzh4Mj5IUAv0oWTRUQNgwrrqycDhz5ZgDbt9ee4ul3/B3mv+mV2Jbt5GnyZWYaMLM6pVr1kUqK4Y8BSsrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740461856; c=relaxed/simple;
	bh=vyUqcwwIg5Y82xzgBzAkI6JQS3z5os9oHEp3GHXe+ms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pKRxoHZZzSPHKtuRcRzQKpu3vefzgT7laawMXAsByeJpWWJX09yMHFr4DfAEF2TEIIz3LZfN5b//NMkGHq/obcLY/QSOCrgggV+jaLP8PzQ9SSLecBCs/XtK4BmdL1E0FTmw1+GONCjjJ7jWYrAc/iPnSYCWA3WNhINOBFtwo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzOEXfVN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22104c4de96so89075065ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740461855; x=1741066655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hE5PZVuk0wrSzeGNfnjhqA90r0l39ISXASLMdfDYwXg=;
        b=gzOEXfVNNsjENyoJjD2bjzWx0hgRv1xzdoPLAZ/bcevFhKOC2AeDR5DZs7Vray5kuG
         Sl5HEqdHIu7QII+Gm0TEQby7TL/ll0vVZMyszyj+cHXykMP6gJPQOMzitYcFiZ95QhDn
         mlXcwhWj/j70ghMmPWR8yGzLLd1+2qgPT/hgZK2Wh5QMtOLk5NibfNcHxWaSWnZ/83bV
         CIb5X95wKUTiPYLGJslu4XlDWVrCc+2JtudQNCX1E/lreIfFUEpmah3CryB9SUpFOElH
         yf2V0kiYJDWS5USkKvIY7fGJKvAUsowQwQP3gKBvJPWNDzna82JkM6Q0iwpxDce2rpFx
         HCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740461855; x=1741066655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hE5PZVuk0wrSzeGNfnjhqA90r0l39ISXASLMdfDYwXg=;
        b=omhJaDRXnjcn7lbwYfECYy45NlaM01mTObUFsrqZwaiNueOG+EBTfVNK3cxQYrepyq
         7FJUg4dpgZMEvWjjHb/xUY60WxI+ygTvDNOxaz50cfs36XhWHkGPiFNUpn3a3TCgHB00
         e8oXsPvKGoQWt7xc2tJFpjug7lnWeF32b85qs+a5hjtvlDTLbD/82mi6SgHWxBwZGQFl
         iMkI7ZvFY82T7VXI/BsqzuiQTtN1bTSAikMrlKCG+I7nSR/whMH5IebKWqiV6jEwE9ON
         zEm2vUbc+Hd5DSlDPZd0iHWFl11yD+ta7O65Ctdf40m8hBUNGpgTfrPTKZvh9iJvxS1E
         fMmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHYb1JhBPr4b+/nxCxBf2mWa7az/AhqBzQsYiknqkxLEnS3kk5JIoZvPbLm32qakEj1x6zKTj91YHKXnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYpj8GWDj02d8J5QUVHD2Ez61h735Ymm0jf8E2juZNe8kiIXW
	u6EKxcVoOzp8F+pwpMUd9m5zgf4LvCXTsbM5PEEGWVY9i7GTVb+ttmcmYAfj
X-Gm-Gg: ASbGncvPZFDsh+ZhlUqWmIeZAUoJkuj2f94m2PJQ1XM52UJrJrHRsd7cpgU/yitL/v0
	fm2eLEFhWER3NHN8b51qgdBxOcFsSSDk0rXhCCu8iaDkbRiJ0R02FoGW225Sdva7vj2LVbHdPgY
	qTLkaGkcGK2SutfQMbMt3L0sHLNAyLvTdD9xXfKhorJeoqSbfKaqpr6je0IE6xtHkHqGXMYonSr
	TC+o0IfvHDBqUl70XsFEs1SzRbOCXaZ+Lo6Crz+ZOyaVzCnuz8Dg35MePtoBUgh8B0pEK7tdziV
	/AshmY2d1i1TxQownC4OA/bXYoVt7Q==
X-Google-Smtp-Source: AGHT+IFOGrHRf+xj0pnbjLU+419G+1nBm0D3cL8y2cdwAhwnO4CuIQQjJJY3z3sZCXEz11jig97ZwQ==
X-Received: by 2002:a17:902:dad0:b0:220:fe51:1aab with SMTP id d9443c01a7336-22307e675camr33877865ad.38.1740461854658;
        Mon, 24 Feb 2025 21:37:34 -0800 (PST)
Received: from HOME-PC ([223.185.135.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a09d831sm5499245ad.162.2025.02.24.21.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 21:37:34 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: rostedt@goodmis.org
Cc: catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH scripts] scripts/sorttable: Fix resource leak in parse_symbols()
Date: Tue, 25 Feb 2025 11:07:24 +0530
Message-Id: <20250225053724.74582-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a resource leak in parse_symbols() where the file pointer fp
was not closed if add_field() returned an error. This caused an
open file descriptor to remain unclosed. Ensure that fp is properly
closed before returning an error.

Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 scripts/sorttable.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 23c7e0e6c024..b9b066c1afee 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -662,8 +662,10 @@ static int parse_symbols(const char *fname)
 
 		addr = strtoull(addr_str, NULL, 16);
 		size = strtoull(size_str, NULL, 16);
-		if (add_field(addr, size) < 0)
+		if (add_field(addr, size) < 0) {
+			fclose(fp);
 			return -1;
+		}
 	}
 	fclose(fp);
 
-- 
2.34.1


