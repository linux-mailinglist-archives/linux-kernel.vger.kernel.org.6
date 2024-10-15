Return-Path: <linux-kernel+bounces-365501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D57B499E345
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F66E2841CB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E738618BC13;
	Tue, 15 Oct 2024 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Y+YKha1k"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B34C9F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986473; cv=none; b=eG4GEzyUGZWyokT5JGIdE2XZpoN7lH49Si7BKbC4aTP4tOVFj3hcSOwoWAtY/UkDuIcqkcnA8IVQzNYpFCorUgS6ggDAIfnUIdkq3dPh4ZZM39mUOcdhGzVXFpQUmY5AF3YFtMDzGUt6F4Efu7L+Jeu0WiRvt/uzGqVUdtMzdAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986473; c=relaxed/simple;
	bh=HBQ8/R38FZbLbQyw2tVE+Kug39hYMjPCBqpXzL0EqXc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=APYjSLimTUAGfeDP4m+HpI6efjBAUMsUk6QJeHjywbKADgL5iQd6OwfJ4NN3YSTexNwSoorP2IijL1BzImIKV2E3kX25oat1WN3vM+6hXQbHmpTiI9itC1z294sksLpk3oGy2YIp+Kpket3v9XJGKlt2GegdTBSIqqjTHSWUdWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Y+YKha1k; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728986159; bh=Qfm035CUv6u3+Iage0Fc5SV3oRLcTJVz+X/Ox2dL2r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+YKha1kRjnWpHphh3j3BTtZ8TiuBc3M+VgWqpMfI5jxQNhm2gitQMe7tMS/jpLyK
	 h2p7beBd2bYore8vIoafPQ/Sa805/7RbobYHVeYYaXIMDxWHqWdhjVC6JrUsF3Lf0J
	 tAJqlmDhawe4eNVBmmWOZfnVHUIa+arKeXu/Oog0=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id DF996A93; Tue, 15 Oct 2024 17:55:57 +0800
X-QQ-mid: xmsmtpt1728986157tk7qm8x6l
Message-ID: <tencent_D3FEC641C9842EEB2EE2CC8E67DB86DD9206@qq.com>
X-QQ-XMAILINFO: NhpLzBn2I3XwFo6Ze/aEY4Mx6UY5tBRkdNpv7gbO+Gu0m6liPrHkvlaeQcovjn
	 4TzUh2D06mBf/xquiI8doyTrGEO94m+cB9/TBHd5LHdXoYV9G5fv+gDfetyZHtxDNDvb1l1ASbJr
	 umzU3CjZXcZP4OKERx7P4XTVJ6BuLY5k9QVmS7D+fa/4GJFIvaSmSOSbKrFx+PSPBKl4gjblkFVk
	 BpNe/P0Nu+GFwQe1VgPZ7tJ1lS4UNciW36lNkL/BHn5wzrCh73V+eO2tYsVcSt5sIW5D9EJE8Hyj
	 41UB3gLANVfN7xvvk3NdqpFAxR4Fq1n82fqtV0JImGQIyBaJm7X2VmZXh90T3QCsyIXZKF/QyVyY
	 pyQ3jqUN1qZMMY3zKPCk3VhJZyQ2aYyq237ge3qJ2d6TeGZlI1E/ehBRK19Mb1/sqSJSib5zFqR9
	 g3udyXosqMU8a5OJfd6siHdDm3mCtDnVjM8vvYdgLbnSxA4x1LvbHg2Q3fdUTbbgX5ScKtm6a0f6
	 pwLZ4Yl/cgQpSUZ1acLjZZpfrFwfQfuBv8rIb2xEdUfM89le9rsFEuM7v1F3IOX0NXYsoxkILmU+
	 e7EdYoOKllnF7STCrRonQANGOy1rkZmEZD/RikhnGX/DeR2HKu+4qFKKZvsBb4/FhjGwtClCWt4X
	 xTkt53qdakQwAJE6iJIBJbQP9GDaluL2ScBQIsGPtk1LhAx11zxgmGZAyBFhhi4c8lWyHqMfLb5D
	 7unZW4uZOsszHtZw7xwefcVa2cnKRZKNoLgFLbm2KddvvwjXeUIWhRVF4mSsqTV2GxBZOU4iC9lc
	 RsKiItksigzfCq7jqgqdjMgQ7xssekyYlI/MEwweECAtJTzerwRhzq3UJYUcUpnHAEQW/KZhfubz
	 jkwvCvRnqSAn0wF5gEb+OcMFtVUK79+kXkckTd9k8X3DyPI7MkUySJK1NRQHG8cw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [btrfs?] KASAN: slab-use-after-free Read in add_delayed_ref
Date: Tue, 15 Oct 2024 17:55:58 +0800
X-OQ-MSGID: <20241015095557.4193286-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <670d3f2c.050a0220.3e960.0066.GAE@google.com>
References: <670d3f2c.050a0220.3e960.0066.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

using delayed_refs->lock to sync btrfs_work_helper and add_delayed_ref

#syz test

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 13c2e00d1270..cb57e65c9872 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1058,7 +1058,6 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 	head_ref = new_head_ref;
 
 	merged = insert_delayed_ref(trans, head_ref, node);
-	spin_unlock(&delayed_refs->lock);
 
 	/*
 	 * Need to update the delayed_refs_rsv with any changes we may have
@@ -1073,8 +1072,12 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 	if (merged)
 		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
 
-	if (qrecord_inserted)
-		return btrfs_qgroup_trace_extent_post(trans, record, head_ref->bytenr);
+	if (qrecord_inserted) {
+		ret = btrfs_qgroup_trace_extent_post(trans, record, head_ref->bytenr);
+		spin_unlock(&delayed_refs->lock);
+		return ret;
+	}
+	spin_unlock(&delayed_refs->lock);
 	return 0;
 
 free_record:


