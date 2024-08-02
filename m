Return-Path: <linux-kernel+bounces-272514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C08945D60
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF701C21A06
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006A81E213C;
	Fri,  2 Aug 2024 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Os6qi6rz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD41DF66A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599127; cv=none; b=NxfU68jf9jB1PPOJrC/PeOVeobKSPcjSuOf887H+HyHbDXWYBuC9sIr/wAKkgnbOox2VhKDH6C8YpxrPKgYwsURu9ald1iI90W6Qyq8uu1FZg/z0hJZ/Q7l+r+0YFOUHDGzFdOYpH/Z1rrOyh3BRjfRynY77CYMUrlp8MY+yzXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599127; c=relaxed/simple;
	bh=zE9CsqstwIvrTW+Pnj2JDpbN3pmUvNqt9sZzdPCCrf4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J4wO+eDwusm9o+dp66OPhq8u3qkzJjW5NhUpuZHKU1bZz0gSQNvCUhXOHZE4fXPsQPAr+Jxgv9nhegjTM8Zt4XL1eLZvRqC5y4jVFvi3rMZk/Od5iLb588W0mNkdXYirpYY8T9MZyNH0IkSy2T39/B3eUHw+Dm1FjWP3y6+SwbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Os6qi6rz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722599124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=e3jFKx+J4qbpIFrMU8QDvInYRswJfgrwwpocyD1haoU=;
	b=Os6qi6rzBNQMOppWBm/RAKYTOSzL+Jv4gXEFfV412M3ZelNp2pjSoksx7scdPGPbCeG5sW
	DV2WcBRwyW3tYDgFQKG8mADE3mzHAvnm5SIg3GeikQl5brU22GUGjV39oZ4tm8UmZf+4p2
	3EzTbYFyZRS4U5EiFkrPgmmLCgxqkpU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-XMmalJrXNUS-1rNuVuOqMQ-1; Fri,
 02 Aug 2024 07:45:23 -0400
X-MC-Unique: XMmalJrXNUS-1rNuVuOqMQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 118531956095;
	Fri,  2 Aug 2024 11:45:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.207])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B5ADC19560AE;
	Fri,  2 Aug 2024 11:45:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  2 Aug 2024 13:45:20 +0200 (CEST)
Date: Fri, 2 Aug 2024 13:45:18 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: build failure caused by RUNTIME_CONST()
Message-ID: <20240802114518.GA20924@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

make bzImage results in

	undefined reference to `__start_runtime_shift_d_hash_shift'
	undefined reference to `__stop_runtime_shift_d_hash_shift'
	undefined reference to `__start_runtime_ptr_dentry_hashtable'
	undefined reference to `__stop_runtime_ptr_dentry_hashtable'

The patch below seems to fix the problem, but I didn't find any report on lkml,
so perhaps I am the only one which hits this problem? And perhaps this is because
my gcc 5.3.1 is quite old?

OTOH, I know nothing about lds magic, so I fail to understand where these
__start/stop_runtime_xxx can come from without something like the change below...

Oleg.
---

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ad6afc5c4918..6846fa6bdd81 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -913,10 +913,12 @@
 
 #define RUNTIME_NAME(t,x) runtime_##t##_##x
 
-#define RUNTIME_CONST(t,x)						\
+#define RUNTIME_CONST(t,x) _RUNTIME_CONST(RUNTIME_NAME(t,x))
+
+#define _RUNTIME_CONST(name)						\
 	. = ALIGN(8);							\
-	RUNTIME_NAME(t,x) : AT(ADDR(RUNTIME_NAME(t,x)) - LOAD_OFFSET) {	\
-		*(RUNTIME_NAME(t,x));					\
+	name : AT(ADDR(name) - LOAD_OFFSET) {	\
+		BOUNDED_SECTION_PRE_LABEL(name, name, __start_, __stop_) \
 	}
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */


