Return-Path: <linux-kernel+bounces-267480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 266FB9411FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53412838EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1CC19EEC8;
	Tue, 30 Jul 2024 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bS3WAzNj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00461990DA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342900; cv=none; b=j2OJd4zfxNU/M3fxtaE16sLGQuAMsPv9vxF5NuccSWn2OkzlVP5RLMVO6CLJY7pT8Hk12Z3cEo+USfF3zpO6u07nSK2THHZXzSaGshCpthNQjAf+U3MhvxP2tUaHxTURIlg5bIATgD4eVt61yx6iCvmoWdLYg3NmQM+D2ChEdSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342900; c=relaxed/simple;
	bh=BBXJ5D2usMmLkVDgx+EehBNNTQyFT4oHfRgegUnHgB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KguBKS53l8rde5bCwzrBXh4rkucYHI36FNatfpWbaDI08kEWPfcNXqoZJmFe8LGMW0tNt5Sr3rxlAJMmzwa8Ua/5Dk6iXxYJLawWUTWWbTovKnDRvhFEu7/ssU/xvZQOdnpC76G91Dp+R4OuvFASnBRmTIfIEhKEGn7Jt6Blwks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bS3WAzNj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722342897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=mMsMX+s+FCwFLj8IxmPfp89JXcAN1I51Q1VOGUdFT2I=;
	b=bS3WAzNjpe5W4BqojjpGieJwzOJ0s3rO4VIbl3MMMMcd2MGzZ4LtflSkGSUwc05RJ0f/1G
	AolHKQo2ZFkBV/wjG6rBYOL30JkMGz37cN8Ed4lzK6XAQ23R4ARlZW5Uzvf+D1GOelVaSD
	cWFzeSTX5jqItWCe/PTJ38WidGiq0eA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-w5TsqMK3Px-C3aFUE0ebfg-1; Tue,
 30 Jul 2024 08:34:53 -0400
X-MC-Unique: w5TsqMK3Px-C3aFUE0ebfg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35FE61955F2D;
	Tue, 30 Jul 2024 12:34:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 475CE19560AA;
	Tue, 30 Jul 2024 12:34:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 30 Jul 2024 14:34:51 +0200 (CEST)
Date: Tue, 30 Jul 2024 14:34:47 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/3] uprobes: change uprobe_register() to use
 uprobe_unregister() instead of __uprobe_unregister()
Message-ID: <20240730123447.GA9099@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730123421.GA9085@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

If register_for_each_vma() fails uprobe_register() can safely drop
uprobe->register_rwsem and use uprobe_unregister(). There is no worry
about the races with another register/unregister, consumer_add() was
already called so this case doesn't differ from _unregister() right
after the successful _register().

Yes this means the extra up_write() + down_write(), but this is the
slow and unlikely case anyway.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 974474680820..5ea0aabe8774 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1174,16 +1174,18 @@ struct uprobe *uprobe_register(struct inode *inode,
 	if (likely(uprobe_is_active(uprobe))) {
 		consumer_add(uprobe, uc);
 		ret = register_for_each_vma(uprobe, uc);
-		if (ret)
-			__uprobe_unregister(uprobe, uc);
 	}
 	up_write(&uprobe->register_rwsem);
 	put_uprobe(uprobe);
 
-	if (unlikely(ret == -EAGAIN))
-		goto retry;
+	if (ret) {
+		if (unlikely(ret == -EAGAIN))
+			goto retry;
+		uprobe_unregister(uprobe, uc);
+		return ERR_PTR(ret);
+	}
 
-	return ret ? ERR_PTR(ret) : uprobe;
+	return uprobe;
 }
 EXPORT_SYMBOL_GPL(uprobe_register);
 
-- 
2.25.1.362.g51ebf55


