Return-Path: <linux-kernel+bounces-428010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CBD9E090C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F80C163BE7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD8D19D074;
	Mon,  2 Dec 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZ2Pbyda"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E2112E7F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157317; cv=none; b=HfdSJ09s1yoSrFHgO08KC8AH3fL4lRVheYs2g4dzoqCIq1lrqXhDcwedqvLAflrXmseIDV4HRfMdF8C0UK8u+wim2GR7ftKRYeq/BZV1ulsyKdUjrykajzlpRgkACMciejNhEQhnC/+P/5IUlr1FF6di56EO9WtiChgJsvwty6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157317; c=relaxed/simple;
	bh=wjXi75OxEmvLMJLvr7CocnJs5U5qMSHOUA25s+kPxCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jag8oqG10h8NlZxivLWChjoyBNAnanbdFK47rtEZoJkXW18s3RQ/rz0ERHmDGxFlwWkgQza5iRX51A24/m6BrsQKcFVwKWfTxRFlcfuROa8OaIZ2lTgfBdUFLZfr+vrXa56XDkb8Hg94HRlPzW7mYEf2563Av8hBsVmV6OvOzYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZ2Pbyda; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733157314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=reQGB9t8Ky0+GI+05SdFmqZ6ltGzM+n1dXPGKq6qH0s=;
	b=VZ2Pbydai6PC020zd24vJM4WJm0WvqaCxPRnJMe/rJPfi8t912uQ/4o0W9tIpZz7P9sOrO
	/TE/xoJyP8gJmdJ/XK2NtqaCCmOv42R+IJN8J3Z9Zl6RVcDhld1CfeqVbXh1LkGz49K0LG
	HdVsx44yeTjjP2u9OJaZRb48XjCWj3A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-F06N2UHdPoia8NreZXNtzg-1; Mon,
 02 Dec 2024 11:35:07 -0500
X-MC-Unique: F06N2UHdPoia8NreZXNtzg-1
X-Mimecast-MFC-AGG-ID: F06N2UHdPoia8NreZXNtzg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D0911964CC6;
	Mon,  2 Dec 2024 16:35:05 +0000 (UTC)
Received: from rhel-developer-toolbox-2.redhat.com (unknown [10.45.225.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5529F1956089;
	Mon,  2 Dec 2024 16:35:00 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ma Ke <make24@iscas.ac.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	George Spelvin <linux@horizon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] pps: fix a UAF and clean up code
Date: Mon,  2 Dec 2024 17:34:45 +0100
Message-ID: <20241202163451.1442566-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The 1st patch fixes a UAF bug. The fix is quite minimal, although a bit
ugly. The rest of the series are cleanups in the area.

Michal Schmidt (6):
  pps: fix cdev use-after-free
  pps: simplify pps_idr_lock locking
  pps: use scoped_guard for pps_idr_lock
  pps: print error in both cdev and dev error paths in
    pps_register_cdev()
  pps: embed "dev" in the pps_device
  pps: use cdev_device_add()

 drivers/pps/clients/pps-gpio.c    |  2 +-
 drivers/pps/clients/pps-ldisc.c   |  6 +-
 drivers/pps/clients/pps_parport.c |  4 +-
 drivers/pps/kapi.c                | 10 ++--
 drivers/pps/pps.c                 | 94 +++++++++++++------------------
 include/linux/pps_kernel.h        |  2 +-
 6 files changed, 50 insertions(+), 68 deletions(-)


base-commit: 7af08b57bcb9ebf78675c50069c54125c0a8b795
-- 
2.47.0


