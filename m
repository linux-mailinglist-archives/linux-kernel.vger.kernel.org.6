Return-Path: <linux-kernel+bounces-572731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D569EA6CDDE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 05:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C323B5A61
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 04:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22141FE46E;
	Sun, 23 Mar 2025 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN3GJYw/"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59449172BD5
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742705675; cv=none; b=Ya2xHrnBWjVTSWlq2T4Mfyvhj63FB8n7s3K8ErYhhKFYcdpa6lMQM3OXz9GGi3g0pGvuVzVJx+wahA9ZxA08tgnLp84/DwYITHesgdyX9UXHYBfgA70T9qh2ZK2XtLsoPD7USE44n/wT8xFx7CiVKt4YLfZ77NRnDeu9LhAMHYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742705675; c=relaxed/simple;
	bh=TxVXmGJ4FYiPcJSeFT5Gw+I7+O7tv9abHQfpVhqdlqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SUYBqqFQCbzqN2JXqmc5nnS8uzc9ENvH5ymvTn8r+IbwvcuxQQjBzPZRZ6XgwvqACRqkKpMnaKt/tK7lyB6LCcWwuD8WI8PYSCgJyD3nbOWwHotFNuvfgJRldCWU2PMBg0Ke+j1z7MOv7sJSnIONF4v5NyNjkQfEWtemXp72gBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jN3GJYw/; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c55500d08cso330828185a.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 21:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742705672; x=1743310472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXfZA4RHAgigGTJFUT/FFGnM3v99exKAO5s9lIr42cs=;
        b=jN3GJYw/awKvfd78ZDijEXv92nFkLR6gTq/omyd3JlU2ZSC8LyWzJcunoVovacF4gS
         DkilKwgDdFOqzResgnrj5SF9Q6q6PLC5bBEbgUSGpMYVxbMl5VWRPP7NtykN9Bfvd5PT
         l2ePxjZVHnPEJl3cDCxeeS2muhLRIjI0pfqhrY/CwegoTvVg9ITs0ZjlqtjsCcu8hdJO
         hEMZu7NegOh89/nLH95HaIktYnlJsDnZb41bfPFqDjB8sbn+f+stcVifFiJJeE+XxCXu
         MAzrvB+OaiOScpJ1fgWzTU325MdJFn+Lo8sefvs1GuUi7LIP40e5nx3/6WxOzuoYWpnF
         lvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742705672; x=1743310472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXfZA4RHAgigGTJFUT/FFGnM3v99exKAO5s9lIr42cs=;
        b=YSSFKaJ10oO6MNx3nLfdAW4tXU5+wgIxa02UD3aqhPyydJuZp7IHHiWOI4eNolVfiA
         uXcS4A0SteAGxqKb3Uf2k9O1bvYLCG62NYgnaE/OeCj1GMTR3Qk2QQ0PlpeXentLdIqU
         H28VKt/ZWd8ChtfNRzoVX3c4kWTHJ0Il7rRM8iiRA16V1/SKZ1jNOdqS71g9drF7Q/95
         8WtCEhqpBJrx0RAxO4sXzjEpBK+mF5u2OQHRBF4q8MxqbaVXYjpT5eQCn4iWxj49+uAB
         GgsZIyacXBoifLsj8G6QcrK5kigXjx8usxgXwDtYuisxjqfqC3r8U10Id7db9Vyjb3HF
         d1Gg==
X-Gm-Message-State: AOJu0YyKTN5i3E2dKTZYgI28BNdY/RdhrQLzQNC+b/9rm4lbZODACt2L
	syRGVfp7D6Bq6C1XJoPpjLyn25417erhH0kQLO+T1GoNPVzXoql/BNRO+w==
X-Gm-Gg: ASbGncudq2OqLurfvms9IKckY4N4KDbw8q0NLb1AVRd2F0SthCeVRgx0HYlnSv5bJ9q
	5+PLZyaysnsaqDDyjQSsy/ClK0mzQ3Ar6HNmR07Raex1uuLC3pYiU9WM+xUv+dNzPgYF7RsVAKT
	OG0fDI37axMBM3O0h3QRwSNx60c7Q6nZjZCzyentpel3AQEhVngwgbeW75PyQhDu14/zro6ntEp
	fSWhycm0aEVEUfzYCQl7GOdmTbxoWidt58KLAhUqxjOnUJbccUNDhzJeh/BjUTcl9IDQ16vda+S
	pNo0YH7bYedJ68eRmi9xHm4P1z8qIvU1IfMkifMBLv1M4/Lf+iZKkKFyFHRIPWlVxfNKM4yvl4R
	+ZOIRTiSIraZ0YiReUI3p2SkfuYn3whYdMA==
X-Google-Smtp-Source: AGHT+IFJ4Z84t6N+IyqSt5Zi/B0F5I8WTCGF1xMZeSHK7YOxgx+lyDLPp/OX0YWPht7TRMkMqzDStA==
X-Received: by 2002:a05:620a:2890:b0:7c5:4673:a224 with SMTP id af79cd13be357-7c5ba202dd7mr1191911285a.50.1742705671913;
        Sat, 22 Mar 2025 21:54:31 -0700 (PDT)
Received: from nickserv.taila7d40.ts.net (pool-173-52-224-122.nycmny.fios.verizon.net. [173.52.224.122])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b93485f7sm329639285a.74.2025.03.22.21.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 21:54:31 -0700 (PDT)
From: Nick Terrell <nickrterrell@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Terrell <terrelln@fb.com>,
	Nick Terrell <nickrterrell@gmail.com>,
	Kernel Team <Kernel-team@fb.com>,
	David Sterba <dsterba@suse.com>,
	Nick Terrell <terrelln@meta.com>,
	Ingo Molnar <mingo@redhat.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] zstd: Work around gcc segfault on versions older than 11.4
Date: Sat, 22 Mar 2025 22:07:49 -0700
Message-ID: <20250323050749.165863-1-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nick Terrell <terrelln@meta.com>

Older gcc version segfault in zstd code as of 9d7de2aa8b41 on x86. This seems
to be triggered by some other compilation changes. But it can be worked
around by disabling DYNAMIC_BMI2 for older gcc compilers.

The original suggested patch in the thread suggested gating on gcc >= 11,
but there is only positive confirmation that gcc 11.4 and later succeed,
so I'm being slightly more conservative.

This will reduce performance of Zstandard decoding by ~10% if using a
gcc version older than 11.4, and the binary is not compiled with BMI2
support at compile time.

I've compiled & run basic tests for gcc-9 and gcc-14.2. I've reproed the
gcc segfault before the fix, and it compiles after.

Link: https://lore.kernel.org/lkml/SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com/
CC: Ingo Molnar <mingo@redhat.com>
CC: Michael Kelley <mhklinux@outlook.com>
CC: Borislav Petkov <bp@alien8.de>
Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 lib/zstd/common/portability_macros.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/zstd/common/portability_macros.h b/lib/zstd/common/portability_macros.h
index 05286af72683..efae9465d57d 100644
--- a/lib/zstd/common/portability_macros.h
+++ b/lib/zstd/common/portability_macros.h
@@ -56,12 +56,14 @@
 
 
 /* Enable runtime BMI2 dispatch based on the CPU.
- * Enabled for clang & gcc >=4.8 on x86 when BMI2 isn't enabled by default.
+ * Enabled for clang & gcc >= 11.4 on x86 when BMI2 isn't enabled by default.
+ * Disabled for gcc < 11.4 because of a segfault while compiling
+ * HUF_compress1X_usingCTable_internal_body().
  */
 #ifndef DYNAMIC_BMI2
 #  if ((defined(__clang__) && __has_attribute(__target__)) \
       || (defined(__GNUC__) \
-          && (__GNUC__ >= 5 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 8)))) \
+          && (__GNUC__ >= 12 || (__GNUC__ == 11 && __GNUC_MINOR__ >= 4)))) \
       && (defined(__i386__) || defined(__x86_64__) || defined(_M_IX86) || defined(_M_X64)) \
       && !defined(__BMI2__)
 #    define DYNAMIC_BMI2 1
-- 
2.48.1


