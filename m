Return-Path: <linux-kernel+bounces-567212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 108FAA6834F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659FE423033
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C37124E4A6;
	Wed, 19 Mar 2025 02:47:13 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAAD24EAAF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742352433; cv=none; b=PTQYjK38MfCNJ1IoGGxpfaqqkntBjmAb0kgw3ihnJx4wfF1ah3Wo4c5uQSiP9ykWoZss4Oy7SqwP6LHVtNgVJzR6XkmELx1v58pRqhy0iQHTQTI0wgwgvQEmeUAria4+sX5xjX7hF65m32l546V5dlvop10SQv0hUv79H/M/fMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742352433; c=relaxed/simple;
	bh=tp5l/qxAOW54WOzfc8zqIMtXSGZGCIdnzn81dTtHyn4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bmMX7CJ0Fu+TpXlubEpIf1WOFDr2UIBdp/tazQW0jZ+66zOWgSb7K+VITRtVLE9veyevSIumuQ6trcHHE37qPkh1SnC9XCZ7fnukBHB6t7e9O7Hz0iz5STl+Y4ntLrYVJm1leN9nfSucHXBItobhlHtFcEdv2+pJN+HTRsrTN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZHY3K5H2Yz1R7Cv;
	Wed, 19 Mar 2025 10:45:17 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D06C71A016C;
	Wed, 19 Mar 2025 10:47:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 19 Mar
 2025 10:47:01 +0800
From: Wang Zhaolong <wangzhaolong1@huawei.com>
To: <dwmw2@infradead.org>, <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<wangzhaolong1@huawei.com>, <yi.zhang@huawei.com>
Subject: [RFC 0/1] fs/jffs2: Deadlock in write buffer recovery path
Date: Wed, 19 Mar 2025 10:46:59 +0800
Message-ID: <20250319024700.10364-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500010.china.huawei.com (7.202.181.71)

## Introduction

I discovered a potential deadlock in the JFFS2 file system when an error
occurs during the write buffer flush. The issue is an AA-deadlock where
the same lock (c->wbuf_sem) is acquired twice in a nested manner by the
same thread. The attached patch attempts to fix this issue, but I'm
concerned about a potential recursive stack overflow problem that could be
introduced by the fix.

## Problem Analysis

The deadlock occurs in the following execution path:

```
jffs2_write_end
  jffs2_write_inode_range
    jffs2_write_dnode
      jffs2_flash_writev
        down_write(&c->wbuf_sem)            # first hold lock
        __jffs2_flush_wbuf
          mtd_write()                       # return error
          jffs2_wbuf_recover
            jffs2_reserve_space_gc
              jffs2_do_reserve_space
                jffs2_flush_wbuf_pad
                  down_write(&c->wbuf_sem)  # AA deadlock
```

When an error occurs during mtd_write() in __jffs2_flush_wbuf, the error
handling code calls jffs2_wbuf_recover to attempt recovery. This function
eventually calls jffs2_reserve_space_gc and jffs2_do_reserve_space. If the
write buffer is dirty, jffs2_do_reserve_space will call jffs2_flush_wbuf_pad,
which tries to acquire the wbuf_sem again, resulting in a deadlock since
the thread already holds this lock.

## Problem Reproduce

### kernel config:

```
CONFIG_MTD=m
CONFIG_MTD_PARTITIONED_MASTER=y
CONFIG_MTD_NAND_CORE=m
CONFIG_MTD_NAND_ECC_SW_HAMMING=m
CONFIG_MTD_RAW_NAND=m
CONFIG_MTD_NAND_NANDSIM=m

CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
CONFIG_JFFS2_SUMMARY=y
CONFIG_JFFS2_FS_XATTR=y
CONFIG_JFFS2_FS_POSIX_ACL=y

CONFIG_FAULT_INJECTION=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAIL_FUNCTION=y
CONFIG_FAIL_MAKE_REQUEST=y
```

### Reproduce step

```shell
ID="0xec,0xa1,0x00,0x15" # 128M 128KB 2KB
modprobe nandsim id_bytes=$ID parts=200
flash_erase /dev/mtd1 0 0
modprobe jffs2
mount -t jffs2 mtd1 /mnt
dd if=/dev/urandom of=/mnt/testfile bs=1M count=1


# Injecting function failure
mountpoint -q /sys/kernel/debug || mount -t debugfs nodev /sys/kernel/debug
FAILTYPE=fail_function
FAILFUNC=mtd_write
echo $FAILFUNC > /sys/kernel/debug/$FAILTYPE/inject
printf %#x -5 > /sys/kernel/debug/$FAILTYPE/$FAILFUNC/retval
# There is a 90% probability that triggering fails.
echo 90 > /sys/kernel/debug/$FAILTYPE/probability
echo 1 > /sys/kernel/debug/$FAILTYPE/verbose
echo -1 > /sys/kernel/debug/$FAILTYPE/times
echo 0 > /sys/kernel/debug/$FAILTYPE/space
echo 1 > /sys/kernel/debug/$FAILTYPE/verbose

#  Overwrite the file until the process stops responding.
while true; do dd if=/dev/urandom of=/mnt/testfile bs=1M count=1; done

## The solution I can think of

The approach in the attached patch is to add a new parameter (wbuf_sem_held)
to jffs2_reserve_space_gc and jffs2_do_reserve_space functions, indicating
whether the calling context already holds the wbuf_sem lock. When jffs2_wbuf_recover
calls jffs2_reserve_space_gc, it passes wbuf_sem_held=1 to indicate the
lock is already held.

Then in jffs2_do_reserve_space, when the buffer is dirty and wbuf_sem_held is set,
we call __jffs2_flush_wbuf directly instead of jffs2_flush_wbuf_pad to avoid trying
to acquire the lock again.

## Alternative Solutions Considered

1. Lock-free recovery path: Completely redesigning the recovery path to not
   require locks. This would be a major change with high risk.

2. Using trylock: Replace down_write() with down_write_trylock() in
   jffs2_flush_wbuf_pad, and handle the case where it returns 0. This approach
   is problematic because we can't tell if the lock is held by our thread or
   another thread.

3. Release and reacquire lock: Release wbuf_sem before calling jffs2_wbuf_recover
   and reacquire it after. This could lead to consistency problems because another
   thread might modify the write buffer state in between.

4. Introduce an additional global state:

## Potential Issue: Recursive Stack Overflow

While the patch fixes the deadlock, it introduces a potential recursive stack
overflow problem. If mtd_write() consistently fails, we could have this recursive
path:

```
__jffs2_flush_wbuf
  mtd_write()                       # return error
  jffs2_wbuf_recover
    jffs2_reserve_space_gc
      jffs2_do_reserve_space
        __jffs2_flush_wbuf          # with wbuf_sem_held=1
          mtd_write()               # return error again
          jffs2_wbuf_recover
            ...  # and so on
```

Each failure and recovery attempt adds another level to the call stack. If the
errors persist, this could lead to a stack overflow. Unfortunately, this is the
original trigger for the problem, because there is some unknown hardware exception
that returns -EIO for any write request,

## Request for Guidance

I'm seeking feedback on how to address both the deadlock.

1. Is my analysis of the deadlock correct?
2. Is the current patch approach sensible, or would a different solution be better?
3. How should we prevent the recursive stack overflow problem?
   - One possibility is to clear c->wbuf_len in error paths in jffs2_wbuf_recover
   - Another option is to detect recursion in jffs2_do_reserve_space and avoid
     calling __jffs2_flush_wbuf when already in an error recovery path

I'd appreciate any feedback or suggestions on how to best address these issues while
maintaining the reliability of the JFFS2 file system.

Wang Zhaolong (1):
  fs/jffs2: Avoid a possible deadlock in jffs2_wbuf_recover

 fs/jffs2/gc.c       | 12 ++++++------
 fs/jffs2/nodelist.h | 12 +++++++++++-
 fs/jffs2/nodemgmt.c | 16 ++++++++++------
 fs/jffs2/os-linux.h |  1 +
 fs/jffs2/wbuf.c     | 13 ++-----------
 fs/jffs2/write.c    |  4 ++--
 fs/jffs2/xattr.c    |  4 ++--
 7 files changed, 34 insertions(+), 28 deletions(-)

-- 
2.34.3


