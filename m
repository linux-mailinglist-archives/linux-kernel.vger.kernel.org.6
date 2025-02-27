Return-Path: <linux-kernel+bounces-536895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD20A485A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E5B188B6CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1E51B4155;
	Thu, 27 Feb 2025 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtBMBfv3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B7D1B0403
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674667; cv=none; b=TBB2FVL4bzRYlXQ6kzJY5VG3xRIa5LafSCnxHNRWMCI0q50ZPE3RvATHSGzrVqHEzyOPqjkrf+t9AtQn7+vl4RURu78Sd8oPlE9UwxozZo3mzwds3LvVFpN7bOTgnbkMpvM+34U+wf61/Ae2mztdbWvku9hbYG/s/H0QsOGBp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674667; c=relaxed/simple;
	bh=hmyQaeKmnnsXKA2VXmb9UgMVCzOmInMaa1NPKpReBz8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=mSbQ/NX/mWzUgvGeIDEg2k9/plHsQHCGtH5XBU0SyxyjTFm3szWCS5mV0afV56TPLiCcDzATK9nowCpFd6YDtVgnNit+pU6CCUVFaxyHF0uezsssW4t7sOQjxY+JHDJ7fuj42pVuCdm4t6BaSoS/OaUxh8vgaXYw6J2sf79M+/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtBMBfv3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740674664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IUdF4ub+smt39/sp8f8Ah9cfhplUBJhL8poFqAdzGmA=;
	b=QtBMBfv3cONJV5bXi9ebjpz1HdTqnYUa+A/JlnNatNhEpVKQEyZO1iI2Aowjsy9jSgoXwR
	j5DbkXqDX+uVHYxJUbh/EOycrfBLz/Q6PAhnXYOGm2K7Vxu+r16w+Fr+eQWjfTILJRzmtn
	9HVsH15yO9kFyznMD5b7k8n3YDsVsIo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-OZzYu2LiMLGr_GjhIg-IQQ-1; Thu,
 27 Feb 2025 11:44:17 -0500
X-MC-Unique: OZzYu2LiMLGr_GjhIg-IQQ-1
X-Mimecast-MFC-AGG-ID: OZzYu2LiMLGr_GjhIg-IQQ_1740674656
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD12C18D9592;
	Thu, 27 Feb 2025 16:44:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36BB71800DBC;
	Thu, 27 Feb 2025 16:44:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
References: <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com> <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, pinskia@gmail.com,
    Neal Gompa <neal@gompa.dev>
Subject: Convert the kernel to C++: Lock-holding class
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3160104.1740674650.1@warthog.procyon.org.uk>
Date: Thu, 27 Feb 2025 16:44:12 +0000
Message-ID: <3160105.1740674652@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Peter,

I played with the code a bit and implemented a generic template class to hold
a lock:

	template<typename LOCK>
	struct Lock {
		LOCK &m;
		bool is_locked;
		Lock(LOCK &mutex) : m(mutex) {
			m.lock();
			is_locked = true;
		}
		~Lock() {
			if (is_locked)
				m.unlock();
		}
		void drop() {
			if (is_locked)
				m.unlock();
			is_locked = false;
		}
		void reget() {
			m.lock();
			is_locked = true;
		}
		operator bool() {
			return is_locked;
		}
	};

used something like with the Mutex, Semaphore and Inode classes below:

	int bar(Inode *inode, int x)
	{
		Lock m_lock = inode->m;

		for (int i = 0; i < 10; i++) {
			Lock m_sem(inode->s);
			do_something(inode);
			m_lock.drop();
			do_something_else(inode);
			m_lock.reget();
		}
	}

It seems that the storage for objects of this lock-holding class entirely
optimise away under reasonable conditions.  The compiler can keep track of
both the lock pointer/ref *and* the is_locked member without having to
actually store them - even when exception handling is thrown into the mix.

A further thing I've noticed is that zero-size classes can be passed in the
argument list without the consumption of register/stack space.  I wonder if it
might be possible to use an argument to indicate the possession of a lock?
E.g.:

	class Have_lock {};
	class Pass_lock {};
	template<typename LOCK>
	struct Lock {
		...
		operator Have_lock() {
			__builtin_compile_time_assert(is_locked);
			BUG_ON(!is_locked);
			return Have_lock();
		}
		operator Pass_lock() {
			__builtin_compile_time_assert(is_locked);
			BUG_ON(!is_locked);
			is_locked = false;
			return Have_lock();
		}
	};

	int do_something(Inode *i, Have_lock l);
	int do_something_and_unlock(Inode *i, Pass_lock l);

David
---

Silly, non-functional implementation of a mutex and a semaphore class so that
I could see it trivially in the .o file:

	struct Mutex {
		int counter;
		void lock() {
			__atomic_fetch_sub(&counter, 1, __ATOMIC_RELEASE);
		}
		void unlock() {
			__atomic_fetch_add(&counter, 1, __ATOMIC_ACQUIRE);
		}
	};

	struct Semaphore {
		int counter;
		void lock() {
			__atomic_fetch_sub(&counter, 1, __ATOMIC_RELEASE);
		}
		void unlock() {
			__atomic_fetch_add(&counter, 1, __ATOMIC_ACQUIRE);
		}
	};

	struct Inode {
		int ref;
		Mutex m;
		Semaphore s;
	};


