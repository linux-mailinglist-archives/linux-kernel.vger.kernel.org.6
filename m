Return-Path: <linux-kernel+bounces-237534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA983923A88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749D328209F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A988715665B;
	Tue,  2 Jul 2024 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3ZJShD2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313C313D8BA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913687; cv=none; b=XkdXfZUtwMBD+vnc+eBe26FOEQ9MvvWjLnHWBmSdH2RwAUBuhq5wvDA/747kNSuLyQ9AERXfrnG+6lHErrULK0li06yAjj/FYg9LVr657sFgJe24lkoMH9YnlrxT/IrCCoJuxar/yeQkUpNNsANwe8L1BSPbMHq3ZyKEsZO8vVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913687; c=relaxed/simple;
	bh=S+YaA24R6oHzXsD83oDylFfmAO/RjdqxFA97Pzm30Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YDSDyaIumD6MRl1YTe/g6mIdVzTGwlk603VFsMpgXjA1LNvGGEP8KaOBKHdOeqehzMkFwdNRxKsUi5QKn005BzUXZvvmzYzP7V9YMG55KMedU3nd9w1WuJCya3RbVWVp3LIV5xp7w+fsgLpC6N4KF1QC07opip9EJrGKwcw+mtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3ZJShD2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719913683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0UGJZ50cdkXDaoYqEiKeCHdsk/Ht37HOVKxrGBw4MdY=;
	b=T3ZJShD2tBJfpmJel1Mkg2HaU/lupekGCwiwXCKCHk0j14afeV/LEs3XTryD8KVUTgAyGX
	+KvY7J8Bmi2YRnhSRXJtpn5YmUOCIN9u38niadb2+bo5ijsXk4oAIEOChFQWTt37bf5Kih
	ZfzwsmduVucSonC4GVM7DsPibEGcQqw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-ItAB6do9Pu2rG8MPKevbpw-1; Tue,
 02 Jul 2024 05:47:57 -0400
X-MC-Unique: ItAB6do9Pu2rG8MPKevbpw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 741CD1979204;
	Tue,  2 Jul 2024 09:47:55 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A347219560A3;
	Tue,  2 Jul 2024 09:47:50 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com
Cc: linux-kernel@vger.kernel.org,
	ltp@lists.linux.it,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: [RFC PATCH] landlock: fix minimal required size for landlock_ruleset_attr copying
Date: Tue,  2 Jul 2024 17:47:45 +0800
Message-ID: <20240702094745.96521-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

As kernel commit fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
introducing a new field 'handled_access_net' in the structure landlock_ruleset_attr,
but in the landlock_create_ruleset() it still uses the first field 'handled_access_fs'
to calculate minimal size, so that made decrease 1 is useless in LTP landlock01.c to
test the too-small-size.

Test code:
   rule_small_size = sizeof(struct landlock_ruleset_attr) - 1;
   tst_syscall(__NR_landlock_create_ruleset, ..., rule_small_size, 0)

Result:
  landlock01.c:49: TFAIL: Size is too small expected EINVAL: ENOMSG (42)

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Mickaël Salaün <mic@digikod.net>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>
---

Notes:
    Hi Mickael,
       I'm not quite sure if that is on purpose to use the first field or kernel
       bug, can you take a look?

 security/landlock/syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 03b470f5a85a..f3cd7def7624 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -198,7 +198,7 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	/* Copies raw user space buffer. */
 	err = copy_min_struct_from_user(&ruleset_attr, sizeof(ruleset_attr),
 					offsetofend(typeof(ruleset_attr),
-						    handled_access_fs),
+						    handled_access_net),
 					attr, size);
 	if (err)
 		return err;
-- 
2.45.2


