Return-Path: <linux-kernel+bounces-209554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0379037A8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15939B21605
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA8D176ABA;
	Tue, 11 Jun 2024 09:18:30 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1BD18EAB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097510; cv=none; b=J3EnmE7VXEcRJ6fDnX866jjiCmK2CibCKPconUoIeIN55pZffLaj0hVhQQh55bAAwZbe0wpS1wUleu5mXQMjODTvF/2tqL0vjMPrO77UdSQDeTKLCxLzbZWqlgioRam1oEr5rMPNMs5XTPaC8rconcaZJQf5PyUXVENlnJ8r6TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097510; c=relaxed/simple;
	bh=KPwuqfSpNK86sOvToMTffnmdTe84nUBsS/zRgbmUI+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oKbXPXQY9CkxljlnkJDbQtMh4trfZ92CHn5WoIs9YITENPN5OFc+lUJCCxJG1G0trlld8wXPMugOkXBP1kR3T9LvIPeTk6sEBwX1DqKV8iaCh9l1STC43FdcS9zaAqgNaXc898V34OA+YWMfQiBcXoje3SUYx9ZCuLxXYJ1v74M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so1095310a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718097507; x=1718702307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unNW1YfnsaX8elroU8v0R2WEg0yWYBLeS91QyqdcBnc=;
        b=NrRAoXaybEEIAFwZIaha2Y0HbqkoTexRcf4koVNlS7MUsCsaSUMDtdR7kipCKbkfTE
         UrDRFlJxHI2F6u6x2aiZqD3cuCABSF4+pkQw9NUFepYS6QyiCH0z7/YusFyt7vc6GLmQ
         VTZFP1pPF4/+OGLbMHypVjLTSrNKFYApWgF72g/8Ep4xTSRuOu8Tfw3LzjV0cjcd3cz6
         fsiR8iMpxX4mAAsc/cdPzXbnJwZC7M/VYYeovmcl4WXBNyLLuycJktvHD7YPUK21m/kU
         MUc3Zd8/xaaa1dqkA6W1gYU8aBMdUo0skbNOP1ZKCu0EUVDW7CsPW1kw8aIqrYp+nrxv
         spiA==
X-Forwarded-Encrypted: i=1; AJvYcCWgT3qddBJ6oA2XfD7YFU0OqDOyY4FYPSKmyZ0KPz5/zSDl8pyJasyEnLY+HtAx3spAdUeN0qJ8nlO55pVZDkgHAsu8a2TXi+Po0Fy+
X-Gm-Message-State: AOJu0YyyTB8DEbkfEEsygwzhncTgpygbZiCtzRfkiFRCADFTk9rzzBKw
	94WeZ+SHjEmSZs4Bd5ANgwHbczlQaDi0tHarT9H9iwotv+U8Y9c59JCHmg==
X-Google-Smtp-Source: AGHT+IHC2a+81FeMVtEzNeh1GlQggyJJiY8PrAxmPpj/WGJ/r+Nl/m6oMo3eCgMEEsFVQVbZylUyug==
X-Received: by 2002:a50:f614:0:b0:57c:713c:cdbf with SMTP id 4fb4d7f45d1cf-57c713ccff3mr4926811a12.38.1718097506767;
        Tue, 11 Jun 2024 02:18:26 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7650b371sm4502356a12.76.2024.06.11.02.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:18:26 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: paulmck@kernel.org,
	linux-kernel@vger.kernel.org (open list:DEBUGOBJECTS:)
Subject: [PATCH v2] [PATCH] debugobjects: Annotate racy debug variables
Date: Tue, 11 Jun 2024 02:18:12 -0700
Message-ID: <20240611091813.1189860-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCSAN has identified a potential data race in debugobjects, where the
global variable debug_objects_maxchain is accessed for both reading and
writing simultaneously in separate and parallel data paths. This results
in the following splat printed by KCSAN:

       	BUG: KCSAN: data-race in debug_check_no_obj_freed / debug_object_activate

       	write to 0xffffffff847ccfc8 of 4 bytes by task 734 on cpu 41:
       	debug_object_activate (lib/debugobjects.c:199
                               lib/debugobjects.c:564 lib/debugobjects.c:710)
       	call_rcu (kernel/rcu/rcu.h:227
                  kernel/rcu/tree.c:2719 kernel/rcu/tree.c:2838)
       	security_inode_free (security/security.c:1626)
       	__destroy_inode (./include/linux/fsnotify.h:222 fs/inode.c:287)
<snip>

       	read to 0xffffffff847ccfc8 of 4 bytes by task 384 on cpu 31:
       	debug_check_no_obj_freed (lib/debugobjects.c:1000
				  lib/debugobjects.c:1019)
       	kfree (mm/slub.c:2081 mm/slub.c:4280 mm/slub.c:4390)
       	percpu_ref_exit (lib/percpu-refcount.c:147)
       	css_free_rwork_fn (kernel/cgroup/cgroup.c:5357)
<snip>
       	value changed: 0x00000070 -> 0x00000071

The data race is actually harmless as this is just used for debugfs
statistics, as all other debug variables.

Annotate the debug variables as racy explicitly, since these variables
are known to be racy and harmless.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:

v2:
	* Annotate all the debug variables instead of only
	  debug_objects_maxchain, as suggested by Thomas Gleixner
v1:
	* https://lore.kernel.org/all/20240509110612.768196-1-leitao@debian.org/
---
 lib/debugobjects.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index fb12a9bacd2f..7cea91e193a8 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -78,16 +78,17 @@ static bool			obj_freeing;
 /* The number of objs on the global free list */
 static int			obj_nr_tofree;
 
-static int			debug_objects_maxchain __read_mostly;
-static int __maybe_unused	debug_objects_maxchecked __read_mostly;
-static int			debug_objects_fixups __read_mostly;
-static int			debug_objects_warnings __read_mostly;
-static int			debug_objects_enabled __read_mostly
-				= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
-static int			debug_objects_pool_size __read_mostly
-				= ODEBUG_POOL_SIZE;
-static int			debug_objects_pool_min_level __read_mostly
-				= ODEBUG_POOL_MIN_LEVEL;
+static int __data_racy			debug_objects_maxchain __read_mostly;
+static int __data_racy __maybe_unused	debug_objects_maxchecked __read_mostly;
+static int __data_racy			debug_objects_fixups __read_mostly;
+static int __data_racy			debug_objects_warnings __read_mostly;
+static int __data_racy			debug_objects_enabled __read_mostly
+					= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
+static int __data_racy			debug_objects_pool_size __read_mostly
+					= ODEBUG_POOL_SIZE;
+static int __data_racy			debug_objects_pool_min_level __read_mostly
+					= ODEBUG_POOL_MIN_LEVEL;
+
 static const struct debug_obj_descr *descr_test  __read_mostly;
 static struct kmem_cache	*obj_cache __ro_after_init;
 
-- 
2.43.0


