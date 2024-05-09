Return-Path: <linux-kernel+bounces-174601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EBB8C116A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155231F22B6C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324AD3BBE3;
	Thu,  9 May 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TBiMl9Yl"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518E3D3BC
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265787; cv=none; b=cJghpR69EFshCPIg8OmgSbx4PQZOyxufjrlzGgQdxErz9zBWzeFniLooIfRCieshzcpL7MTp4YIGya4w9YIIFMyYid/Ma4Ck2y/X/XFQVO0s1VNuRvipp9wig74cyjr1TKurv0S6N3px43ksAtkQDHPhWJizGVUHPIewbXFf5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265787; c=relaxed/simple;
	bh=XXNeAXs1/0E/v5cpuViagymbuRPW3c13h3Y4ZuzL9+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wi2llmIrFpEIC6mMta2k6fX1BAXkgFfQlDzQQN1IUNka9x76p6uH9dliNOxBY1m1Sqxj+DPtCZU/1J6Fcpv8KX1V/ea9Kc4U58Ys4gdqpj71nlLPq4VRKQz9Q3Jcl42jw33K/YR9lpcnArlpxAY/GB8nQ0TVAWiE0ycRldNOnLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TBiMl9Yl; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 449EgRbW018928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 10:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715265750; bh=fkdzl60fbughxPMzy/BbDTa04AllduxheOH6TVjDfsc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=TBiMl9YlEzuXK6Aeab7sNLzLTn/rKGV5rs4aUSzQWj6JfVfbTjsi59CP4tY2wW32E
	 S+1lD2pNMC5LrDsU9SdFJPyOl79Bv1B0sWxrxvSe4wWfnIQxEz/Spn6SXswji6aKXL
	 9zwDU++XFLWj/9iCdBlmUzV6TU3ZXT+YGZfcxH//QRMOOye2/PAVEeTw7RvGHok4fB
	 pf693ONhVEK2NB4qmAew3uqUudk1pkCq29pOXoPX2wL7NMcwS584tGwxZnkEgWJ8pQ
	 esy2spijYQUoJ49C3eb7gSdm5YMLSTv6aG9+m1inwkPe3HOYb/vFwPxalRNYvm+n/z
	 cVf7IhUyv21cg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3FBD715C026D; Thu, 09 May 2024 10:42:27 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: fix uninitialized ratelimit_state->lock access in __ext4_fill_super()
Date: Thu,  9 May 2024 10:42:24 -0400
Message-ID: <171526573768.3650256.17101375351397123628.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102133730.1098120-1-libaokun1@huawei.com>
References: <20240102133730.1098120-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Jan 2024 21:37:30 +0800, Baokun Li wrote:
> In the following concurrency we will access the uninitialized rs->lock:
> 
> ext4_fill_super
>   ext4_register_sysfs
>    // sysfs registered msg_ratelimit_interval_ms
>                              // Other processes modify rs->interval to
>                              // non-zero via msg_ratelimit_interval_ms
>   ext4_orphan_cleanup
>     ext4_msg(sb, KERN_INFO, "Errors on filesystem, "
>       __ext4_msg
>         ___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state)
>           if (!rs->interval)  // do nothing if interval is 0
>             return 1;
>           raw_spin_trylock_irqsave(&rs->lock, flags)
>             raw_spin_trylock(lock)
>               _raw_spin_trylock
>                 __raw_spin_trylock
>                   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_)
>                     lock_acquire
>                       __lock_acquire
>                         register_lock_class
>                           assign_lock_key
>                             dump_stack();
>   ratelimit_state_init(&sbi->s_msg_ratelimit_state, 5 * HZ, 10);
>     raw_spin_lock_init(&rs->lock);
>     // init rs->lock here
> 
> [...]

Applied, thanks!

[1/1] ext4: fix uninitialized ratelimit_state->lock access in __ext4_fill_super()
      commit: b4b4fda34e535756f9e774fb2d09c4537b7dfd1c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

