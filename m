Return-Path: <linux-kernel+bounces-364676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BCE99D7C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8C92842C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46521CDA1C;
	Mon, 14 Oct 2024 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIYHxkNZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37A140E34
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728935638; cv=none; b=i/wOcvCQz8MSDygw3BEJHdws3WgCac+7o7qzvQuRS79NkKHC+FF+rU2n1VKWmyVOaYcqAgQMNjFD+7f61xCWFIVZlDm1XLb3doBk5WJ9uXg2Jc77xZ7JubJ0oCsHhBaEW1TqIFIVQ1/BzFRZvC3XJbOOUsKnE4ICq+6ZPhc31cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728935638; c=relaxed/simple;
	bh=iCLaslJGa6Tstq1fT3EusaA4iF7RCLCzBUfpCCl2f4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gOQByy0aHxZiWep+vPADFJzOyCmMx4di5yZvO/6DLWLCsJS2s2UxyEGc0T7VQ65Bps/qqdJitsVaSj3VfI4sJa9GGXnK5Ur6aAHXCMbPrBCj2SBXBJJ0qz8wozYy2DtenesrhSlZtuo9p76QQgT0hekGv6o9MtO/iScnoCpOZ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIYHxkNZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728935635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AF0ptgIm/2n3+mwd8aTlvN1XmK5LMJIxSx5zsvqkD2U=;
	b=CIYHxkNZbFtVchJ1HRC8mrFWhj1uErticSry8otXQ/znOKM0RaZt11456g47PVgrT3urJs
	YIacpUOKqqnbqKN6lV1SxvP9hILYswChDCzWx+KaD3a6XXmb3Ib5hTLHiEjdz2OEPkVYS+
	SvQ03QxBxmwwMrrEkAaL80S+PonLd/o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-kq_2tKOcN0OmDLKFqVMbbg-1; Mon,
 14 Oct 2024 15:53:52 -0400
X-MC-Unique: kq_2tKOcN0OmDLKFqVMbbg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 671D919560AE;
	Mon, 14 Oct 2024 19:53:50 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.39.193.64])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A1EA41956056;
	Mon, 14 Oct 2024 19:53:46 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: williams@redhat.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Subject: [PATCH] rust: Fix build error
Date: Mon, 14 Oct 2024 21:52:53 +0200
Message-ID: <20241014195253.1704625-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When CONFIG_DEBUG_SPINLOCK=y and CONFIG_PREEMPT_RT=y the following build
error occurs:

    In file included from rust/helpers/helpers.c:22:
    rust/helpers/spinlock.c: In function ‘rust_helper___spin_lock_init’:
    rust/helpers/spinlock.c:10:30: error: implicit declaration of function ‘spinlock_check’; did you mean ‘spin_lock_bh’? [-Wimplicit-function-declaration]
       10 |         __raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
          |                              ^~~~~~~~~~~~~~
          |                              spin_lock_bh
    rust/helpers/spinlock.c:10:30: error: passing argument 1 of ‘__raw_spin_lock_init’ makes pointer from integer without a cast [-Wint-conversion]
       10 |         __raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
          |                              ^~~~~~~~~~~~~~~~~~~~
          |                              |
          |                              int
    In file included from ./include/linux/wait.h:9,
                     from ./include/linux/wait_bit.h:8,
                     from ./include/linux/fs.h:6,
                     from ./include/linux/highmem.h:5,
                     from ./include/linux/bvec.h:10,
                     from ./include/linux/blk_types.h:10,
                     from ./include/linux/blkdev.h:9,
                     from ./include/linux/blk-mq.h:5,
                     from rust/helpers/blk.c:3,
                     from rust/helpers/helpers.c:10:
    ./include/linux/spinlock.h:101:52: note: expected ‘raw_spinlock_t *’ {aka ‘struct raw_spinlock *’} but argument is of type ‘int’
      101 |   extern void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
          |                                    ~~~~~~~~~~~~~~~~^~~~
    make[2]: *** [scripts/Makefile.build:229: rust/helpers/helpers.o] Error 1

Error observed while building a rt-debug kernel for aarch64.

On a PREEMPT_RT build, spin locks have been mapped to rt_mutex types, so
avoid the raw_spinlock_init call for RT.

Suggested-by: Clark Williams <williams@redhat.com>

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 rust/helpers/spinlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index acc1376b833c..924c1a380448 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -6,7 +6,7 @@
 void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
 				  struct lock_class_key *key)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
+#if defined(CONFIG_DEBUG_SPINLOCK) && !defined(CONFIG_PREEMPT_RT)
 	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
 #else
 	spin_lock_init(lock);
-- 
2.46.2


