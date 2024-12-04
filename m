Return-Path: <linux-kernel+bounces-430681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C039E3463
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD4E1684DD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E007018E750;
	Wed,  4 Dec 2024 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/xgjTZg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3C18F2D8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298450; cv=none; b=fxrP43RGh3xfRuQ58aX18U2thWI4ypWSkvUD/Yz883RG1Ra4L2+gWPzqw6PEyD/Ioi4nulX8a0/4olX1eb+ifRrDpA/0BABa6zzLec9s4/iZcUtjz7rzgg0xVZIygmo2pQYgfvSWADnUrVNQewMIFtli7i5jeYWIFwUtInxJL9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298450; c=relaxed/simple;
	bh=xPmCsKpMpyS+IEf8Bve9mFZNuarXhCK8VeBON/LWLlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIWJhbiygg48YwMWKexVgeEFWjFr0SQnirrJmDrt3SwsJWW4JnHDeRMKBzr1NsIXQWUbOtkUIoGtH6wMApt1fyLGwxQn0KEiVkHlF7imfjlNpSgn6emd59QbW9D1csOxuM2waRzYjakZz1f+nXtTkeelGmNpUZ9qkWdaHNlQa8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/xgjTZg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9ysnB8wbhWhwEUuu4La2Q5hcuWjOlDcwGDAFBtqHkY=;
	b=h/xgjTZgx6v28tsW9zsF051+S9dXUk03VRmdWfvYgW9U4+7BBzH34di+EvJfPvMaSUvn/i
	C2ROHwG6MkEbFxU7vG0wqq+oW0w6DYySQfurh8+YjVEUjcVQ+agi07Hbi++soOoJ+VEJtT
	dzunfljQMw/nM+ZseVaYJ0IRonwKJpw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-hl0F6zMpMsmkZEde4NIExg-1; Wed,
 04 Dec 2024 02:47:23 -0500
X-MC-Unique: hl0F6zMpMsmkZEde4NIExg-1
X-Mimecast-MFC-AGG-ID: hl0F6zMpMsmkZEde4NIExg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B12EF1955F3C;
	Wed,  4 Dec 2024 07:47:21 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 542371956048;
	Wed,  4 Dec 2024 07:47:18 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH net-next v2 01/39] ktime: Add us_to_ktime()
Date: Wed,  4 Dec 2024 07:46:29 +0000
Message-ID: <20241204074710.990092-2-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add a us_to_ktime() helper to go with ms_to_ktime() and ns_to_ktime().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Thomas Gleixner <tglx@linutronix.de>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/linux/ktime.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index 3a4e723eae0f..383ed9985802 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -222,6 +222,11 @@ static inline ktime_t ns_to_ktime(u64 ns)
 	return ns;
 }
 
+static inline ktime_t us_to_ktime(u64 us)
+{
+	return us * NSEC_PER_USEC;
+}
+
 static inline ktime_t ms_to_ktime(u64 ms)
 {
 	return ms * NSEC_PER_MSEC;


