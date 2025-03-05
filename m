Return-Path: <linux-kernel+bounces-547795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3884EA50DB2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC1A175BBF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9B41FF1BC;
	Wed,  5 Mar 2025 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5CEoAPW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862E204583
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210554; cv=none; b=bbvXzIeAqgA++KHFp5uegSI1f64jVMvWGhdos7brZR/Cm+314AxYqBpg1QnBoA+mL3YvFrK7PE2YTTEHck0mnWlLEDph1gKGqI1hRgsMuyQol+Ad7UhqGyWDrLwWUzgdIPj7cz/qPpNiHi6sx2d9Lq8iCtwp6FG8jNptkHhCiQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210554; c=relaxed/simple;
	bh=SflZSNxyKqwjQwi6drHuYZoUmeT0qxe50tPNwOzBgE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=sf+qvr19aGGbiWsPH7+Hx1zo1/5ElPFyRhJ+KPqRXmUAV3b0ju/nJVAae373z+wpBEgPnCbAH5JBXCeVnl6pjHVaoSFGZ8gMp2YjM50IL/Xg+Q+R5jOQKvJwVpRAr4TVSiT9/W5ZacygY2Yqelss5ILrZG2Qo90SDE+0nqdiCV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5CEoAPW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741210551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WVP1rCTer6eijl5cxS3xeMFf/yShnPi0yCI1aksLWSE=;
	b=g5CEoAPWqGovBBkU0O92MmKLbHC6sLksTb8sMDevFb8vfuz8E2sxgKrBTLPDpQKX1zlVz5
	2u7kpCfY08/qkYxJhvEPDGD5MfpVC7PTTgowtAeTm9lCQ8ug5kO7lnGkxqh8UDcVqk9G30
	k91n87jcxHIZ65F8YHKfrSYxgYxSavo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-KOXsgrFtORipS_8F9f4k0A-1; Wed,
 05 Mar 2025 16:35:49 -0500
X-MC-Unique: KOXsgrFtORipS_8F9f4k0A-1
X-Mimecast-MFC-AGG-ID: KOXsgrFtORipS_8F9f4k0A_1741210547
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6714D1955D7A;
	Wed,  5 Mar 2025 21:35:47 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.76.19])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED8161955DCE;
	Wed,  5 Mar 2025 21:35:44 +0000 (UTC)
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@parisplace.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v1 2/2] audit: record AUDIT_ANOM_* events regardless of presence of rules
Date: Wed,  5 Mar 2025 16:33:20 -0500
Message-ID: <0b569667efde7c91992bf3ea35b40c3a8f10e384.1741210251.git.rgb@redhat.com>
In-Reply-To: <cover.1741210251.git.rgb@redhat.com>
References: <cover.1741210251.git.rgb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

When no audit rules are in place, AUDIT_ANOM_{LINK,CREAT} events
reported in audit_log_path_denied() are unconditionally dropped due to
an explicit check for the existence of any audit rules.  Given this is a
report of a security violation, allow it to be recorded regardless of
the existence of any audit rules.

To test,
	mkdir -p /root/tmp
	chmod 1777 /root/tmp
	touch /root/tmp/test.txt
	useradd test
	chown test /root/tmp/test.txt
	{echo C0644 12 test.txt; printf 'hello\ntest1\n'; printf \\000;} | \
		scp -t /root/tmp
Check with
	ausearch -m ANOM_CREAT -ts recent

Link: https://issues.redhat.com/browse/RHEL-9065
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 53e3bddcc327..0cf2827882fc 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2285,7 +2285,7 @@ void audit_log_path_denied(int type, const char *operation)
 {
 	struct audit_buffer *ab;
 
-	if (!audit_enabled || audit_dummy_context())
+	if (!audit_enabled)
 		return;
 
 	/* Generate log with subject, operation, outcome. */
-- 
2.43.5


