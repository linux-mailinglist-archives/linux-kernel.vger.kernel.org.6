Return-Path: <linux-kernel+bounces-259667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D3A939B22
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458B7285B54
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF9014D28E;
	Tue, 23 Jul 2024 06:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QZmzfd7d"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757914A4E1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717384; cv=none; b=Ac/Xkh+WvFzmYGvNE8Zf/XOGdqYBP+YiaDYNAKtmSEE2r1peJgmfHXajDCkW6rkiDOx+nKvka1d02Q2vjsGoY57Y5p/7GHYohzJu5VX/+cpARpaRsi6nz8IhjQBs8Coji7OR1cSB/2lVC5zsZxK+GJwDSIxNDK0ZIlzAkp3Bs10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717384; c=relaxed/simple;
	bh=RXglqfeki+IhT0XnGlGY8olW3Nregu7ITMlr85haCz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mi87ey8FVsBhz0wPypEC4b4F2u6FEdWcvQzL2tFVLaQAGbCzDg+t5CtqsgtFxSz898cGrBNx3vPw4bhZbpXVA87Pj4S0FI3Q2obAM9iis2nOG9zBwSemb4cB0FdSK1NhY9nKg27MZfuEhwqlUnUqZBexQ3RDGbCdSYvwouGUGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=QZmzfd7d; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C06AD400E8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721717379;
	bh=SSby+veWhYFs/KPIxtuFQP9fWzklyucEzByPv4c+H1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=QZmzfd7dB0K8vSbyizDbW0rjiOZCmzKQDTD1DS/GKZn7AG4xAk4+d3g535VV4abbz
	 ar3HW4NVPjvnOz/KGsXIgKxSammVFQ/gZvAe05PrQvJarHgI7lE31GkWK0QgL/9ZP+
	 I2T57fHCzxg+GP69ZOgA8sMLSdE+c5tm6ZpFxB9tS4AZA48/hi5sg7qBwIxkDkJzmE
	 IEezJ0S+HDr+B8+aoXzEGt4obRJWKtEkyBSBlLpJigktps1XwOfO9cMDjD8QYbM3ZK
	 SicFBUn+YyQtoglb5OsICfmePMbv2tICdaqTS39pdXpUt8kFAQxt8CrSS98A0dq8t4
	 hFdhb3jlihCJw==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6fd42bf4316so377513a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721717378; x=1722322178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSby+veWhYFs/KPIxtuFQP9fWzklyucEzByPv4c+H1w=;
        b=HdbcYMV7sjzRJ1XQKwyayQ1/ozIGJetXsMouXCIjOQKRvkAx9qSYVXPqtQhJx8mwVu
         dzn/p8Q/8hEiDHRe+ocYlhE+56LJXv5Tw4ftBffDhRnmMC8gowi+92eKFIR3MDxllpMM
         +ulXrJ/PCsLV4NX7BjLXA7l8ia/J8uZVEtz7vVAh7EJpxHRzk6Acv2U0kmrLYUnSLjtD
         MztMLMh74Do3km0tvZ4cbPzF8jE3FV5Zlng5Vjq/sM7zK0pe77ia6LaLwWTHLRdc8cn7
         lpLXvvuucV2xSM6Zgd3veVVSTLRP00J+pf2snrL6OEd/Z311cAZTuqDYQcTiXpqOW/So
         ncZg==
X-Forwarded-Encrypted: i=1; AJvYcCWU09GflJS5x/vKqvFfWZed8xVRNQd6MrOE4BPVyGvwAoajh/IGH2jcxFMcbwvm4SXLzSV6obC009lQov/QO3Y9qe3i9jUtmECDFqtc
X-Gm-Message-State: AOJu0YzLSai53pNn/GPC+xahu1Y8OJsn7MeZ2Z46lLff7uvApwNxoVB7
	wT3B583oFivWaYBOZBWPQIIkgduJlF3sKmqiFB7kbQFJ3cjmK+R8pqdsZVELLA+M/XNSMo9RY0z
	gl2kSbA4riezYgXVBUsnAU2AAizK1Qo4AMrXaj2Ut5GDoVj1BX9NN0i3qIDWx7NizTy/Kz84EGs
	g50g==
X-Received: by 2002:a05:6a20:6f04:b0:1c3:ff33:277e with SMTP id adf61e73a8af0-1c44f86c92cmr2110003637.32.1721717378098;
        Mon, 22 Jul 2024 23:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDabqAEkCpkyaJ7TFPUAZCurxHz2+fpzUWqrGvdUCtX2upCViYYzhYgk3ASQ8CzhkJfiBe6w==
X-Received: by 2002:a05:6a20:6f04:b0:1c3:ff33:277e with SMTP id adf61e73a8af0-1c44f86c92cmr2109987637.32.1721717377759;
        Mon, 22 Jul 2024 23:49:37 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7c5391bsm8354749a91.24.2024.07.22.23.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 23:49:37 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Ian Kent <raven@themaw.net>,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] scripts/gdb: fix lx-mounts command error
Date: Tue, 23 Jul 2024 14:48:59 +0800
Message-Id: <20240723064902.124154-4-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723064902.124154-1-kuan-ying.lee@canonical.com>
References: <20240723064902.124154-1-kuan-ying.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(gdb) lx-mounts
      mount          super_block     devname pathname fstype options
Python Exception <class 'gdb.error'>: There is no member named list.
Error occurred in Python: There is no member named list.

We encoutner the above issue after commit 2eea9ce4310d ("mounts: keep
list of mounts in an rbtree"). The commit move a mount from list into
rbtree.

So we can instead use rbtree to iterate all mounts information.

Fixes: 2eea9ce4310d ("mounts: keep list of mounts in an rbtree")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 scripts/gdb/linux/proc.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
index 43c687e7a69d..65dd1bd12964 100644
--- a/scripts/gdb/linux/proc.py
+++ b/scripts/gdb/linux/proc.py
@@ -18,6 +18,7 @@ from linux import utils
 from linux import tasks
 from linux import lists
 from linux import vfs
+from linux import rbtree
 from struct import *
 
 
@@ -172,8 +173,7 @@ values of that process namespace"""
         gdb.write("{:^18} {:^15} {:>9} {} {} options\n".format(
                   "mount", "super_block", "devname", "pathname", "fstype"))
 
-        for mnt in lists.list_for_each_entry(namespace['list'],
-                                             mount_ptr_type, "mnt_list"):
+        for mnt in rbtree.rb_inorder_for_each_entry(namespace['mounts'], mount_ptr_type, "mnt_node"):
             devname = mnt['mnt_devname'].string()
             devname = devname if devname else "none"
 
-- 
2.34.1


