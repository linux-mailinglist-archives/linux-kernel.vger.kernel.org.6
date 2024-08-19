Return-Path: <linux-kernel+bounces-292906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7026957652
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5357D1F2206D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5231415A84D;
	Mon, 19 Aug 2024 21:02:49 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F0B2C18C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724101368; cv=none; b=A+EzlvGZNRcF4ZIZBd3DS7InF2tRdjhLw2aiTyDOwRTyPxLUr4Ou//FbgLI/pgSrM4BOuQPb4rsb1mnvuCWvOkSMYFBM/E+1nJ3F5smC4nXW25dZCc5GCEPtB4N0mSM7IuxZUx6+GeCxaUcUV/rkuG0GjYUGEuRCd0L8LEObX0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724101368; c=relaxed/simple;
	bh=FRxG+PwVNksBAOivZ7dAalfoABiyFwkhb887w+m7jZ4=;
	h=Message-ID:Date:MIME-Version:Cc:To:From:Subject:Content-Type; b=Orz+8Chw+x3KFx/cFuxjS67/JN9r7vRBQO78klCPWjZqwZ3dXGhRQpO/qcI/DlOBJCnkiBdkVYFrIEiYI/YlysnOjF07cgpbcMEBNFhi3BSDsywv91kvSs66TV9d8Db8rFq19qtsTYc4QmiispgswtcfUmB2z8hlDQlkWeENyq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af273.dynamic.kabel-deutschland.de [95.90.242.115])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8275961E5FE07;
	Mon, 19 Aug 2024 23:02:19 +0200 (CEST)
Message-ID: <3a1c9e27-6dcb-4eec-85cb-c03271c61a37@molgen.mpg.de>
Date: Mon, 19 Aug 2024 23:02:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Commit *pidfd: prevent creation of pidfds for kthreads* causes
 `Failed to remount '/' read-only: Device or resource busy`
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

#regzbot introduced: 3b5bbe798b24

Dear Christian,


Commit 3b5bbe798b24 (pidfd: prevent creation of pidfds for kthreads) 
causes a regression. On the Dell XPS 13 9360 with Debian sid/unstable 
and *systemd* 256.5-1, systemd is not able to unmount the root partition 
(LUKS encrypted) anymore.

```
[…]
Aug 19 22:45:45 abreu systemd[1]: Shutting down.
Aug 19 22:45:45 abreu systemd[1]: Using hardware watchdog 'iTCO_wdt', 
version 4, device /dev/watchdog0
Aug 19 22:45:45 abreu systemd[1]: Watchdog running with a hardware 
timeout of 10min.
Aug 19 22:45:45 abreu kernel: watchdog: watchdog0: watchdog did not stop!
Aug 19 22:45:45 abreu systemd-shutdown[1]: Using hardware watchdog 
'iTCO_wdt', version 4, device /dev/watchdog0
Aug 19 22:45:45 abreu systemd-shutdown[1]: Watchdog running with a 
hardware timeout of 10min.
Aug 19 22:45:45 abreu systemd-shutdown[1]: Syncing filesystems and block 
devices.
Aug 19 22:45:46 abreu systemd-shutdown[1]: Sending SIGTERM to remaining 
processes...
Aug 19 22:45:46 abreu systemd-shutdown[1]: Failed to enumerate /proc/: 
Invalid argument
Aug 19 22:45:46 abreu systemd-shutdown[1]: Sending SIGKILL to remaining 
processes...
Aug 19 22:45:46 abreu systemd-shutdown[1]: Failed to enumerate /proc/: 
Invalid argument
Aug 19 22:45:46 abreu systemd-shutdown[1]: Unmounting file systems.
Aug 19 22:45:46 abreu (sd-umount)[1585]: Unmounting 
'/run/credentials/systemd-journald.service'.
Aug 19 22:45:46 abreu (sd-remount)[1586]: Remounting '/' read-only with 
options 'errors=remount-ro'.
Aug 19 22:45:46 abreu (sd-remount)[1586]: Failed to remount '/' 
read-only: Device or resource busy
Aug 19 22:45:46 abreu (sd-remount)[1587]: Remounting '/' read-only with 
options 'errors=remount-ro'.
Aug 19 22:45:46 abreu (sd-remount)[1587]: Failed to remount '/' 
read-only: Device or resource busy
Aug 19 22:45:46 abreu systemd-shutdown[1]: Not all file systems 
unmounted, 1 left.
Aug 19 22:45:46 abreu systemd-shutdown[1]: Deactivating swaps.
Aug 19 22:45:46 abreu systemd-shutdown[1]: All swaps deactivated.
Aug 19 22:45:46 abreu systemd-shutdown[1]: Detaching loop devices.
Aug 19 22:45:46 abreu systemd-shutdown[1]: All loop devices detached.
Aug 19 22:45:46 abreu systemd-shutdown[1]: Stopping MD devices.
Aug 19 22:45:46 abreu systemd-shutdown[1]: All MD devices stopped.
Aug 19 22:45:46 abreu systemd-shutdown[1]: Detaching DM devices.
Aug 19 22:45:46 abreu systemd-shutdown[1]: Not all DM devices detached, 
1 left.
Aug 19 22:45:46 abreu systemd-shutdown[1]: Unmounting file systems.
Aug 19 22:45:46 abreu (sd-remount)[1588]: Remounting '/' read-only with 
options 'errors=remount-ro'.
Aug 19 22:45:46 abreu (sd-remount)[1588]: Failed to remount '/' 
read-only: Device or resource busy
Aug 19 22:45:46 abreu systemd-shutdown[1]: Not all file systems 
unmounted, 1 left.
Aug 19 22:45:46 abreu systemd-shutdown[1]: Detaching DM devices.
Aug 19 22:45:46 abreu systemd-shutdown[1]: Not all DM devices detached, 
1 left.
Aug 19 22:45:46 abreu systemd-shutdown[1]: Unmounting file systems.
Aug 19 22:45:46 abreu (sd-remount)[1589]: Remounting '/' read-only with 
options 'errors=remount-ro'.
Aug 19 22:45:46 abreu (sd-remount)[1589]: Failed to remount '/' 
read-only: Device or resource busy
Aug 19 22:45:46 abreu systemd-shutdown[1]: Not all file systems 
unmounted, 1 left.
Aug 19 22:45:46 abreu systemd-shutdown[1]: Detaching DM devices.
Aug 19 22:45:46 abreu systemd-shutdown[1]: Not all DM devices detached, 
1 left.
Aug 19 22:45:46 abreu systemd-shutdown[1]: Cannot finalize remaining 
file systems, DM devices, continuing.
Aug 19 22:45:46 abreu kernel: watchdog: watchdog0: watchdog did not stop!
```

On the next boot, the journal needs to be recovered.


Kind regards,

Paul


PS: For the record:

$ git bisect bad
3b5bbe798b2451820e74243b738268f51901e7d0 is the first bad commit
commit 3b5bbe798b2451820e74243b738268f51901e7d0 (HEAD)
Author: Christian Brauner <brauner@kernel.org>
Date:   Wed Jul 31 12:01:12 2024 +0200

     pidfd: prevent creation of pidfds for kthreads

     It's currently possible to create pidfds for kthreads but it is unclear
     what that is supposed to mean. Until we have use-cases for it and we
     figured out what behavior we want block the creation of pidfds for
     kthreads.

     Link: 
https://lore.kernel.org/r/20240731-gleis-mehreinnahmen-6bbadd128383@brauner
     Fixes: 32fcb426ec00 ("pid: add pidfd_open()")
     Cc: stable@vger.kernel.org
     Signed-off-by: Christian Brauner <brauner@kernel.org>

  kernel/fork.c | 25 ++++++++++++++++++++++---
  1 file changed, 22 insertions(+), 3 deletions(-)
$ git bisect log
git bisect start
# status: waiting for both good and bad commits
# bad: [df6cbc62cc9b3bcf593d13400dd58cd339a0f56d] Merge tag 'scsi-fixes' 
of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect bad df6cbc62cc9b3bcf593d13400dd58cd339a0f56d
# status: waiting for good commit(s), bad commit known
# good: [d74da846046aeec9333e802f5918bd3261fb5509] Merge tag 
'platform-drivers-x86-v6.11-3' of 
git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
git bisect good d74da846046aeec9333e802f5918bd3261fb5509
# bad: [d7a5aa4b3c007fae50405ca75c40258d90300e96] Merge tag 
'perf-tools-fixes-for-v6.11-2024-08-15' of 
git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools
git bisect bad d7a5aa4b3c007fae50405ca75c40258d90300e96
# good: [9c5af2d7dfe18e3a36f85fad8204cd2442ecd82b] Merge tag 
'nf-24-08-15' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
git bisect good 9c5af2d7dfe18e3a36f85fad8204cd2442ecd82b
# bad: [d07b43284ab356daf7ec5ae1858a16c1c7b6adab] Merge tag 'for-linus' 
of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect bad d07b43284ab356daf7ec5ae1858a16c1c7b6adab
# bad: [4ac0f08f44b62e59a389c7ed87c89087d9fefe29] Merge tag 
'vfs-6.11-rc4.fixes' of 
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
git bisect bad 4ac0f08f44b62e59a389c7ed87c89087d9fefe29
# bad: [e3786b29c54cdae3490b07180a54e2461f42144c] 9p: Fix DIO read 
through netfs
git bisect bad e3786b29c54cdae3490b07180a54e2461f42144c
# good: [889ced4c9388785952d78d20d338bda2df209bb5] netfs: clean up after 
renaming FSCACHE_DEBUG config
git bisect good 889ced4c9388785952d78d20d338bda2df209bb5
# bad: [8e5ced7804cb9184c4a23f8054551240562a8eda] netfs, ceph: Revert 
"netfs: Remove deprecated use of PG_private_2 as a second writeback flag"
git bisect bad 8e5ced7804cb9184c4a23f8054551240562a8eda
# skip: [86509e38a80da34d7800985fa2be183475242c8c] file: fix typo in 
take_fd() comment
git bisect skip 86509e38a80da34d7800985fa2be183475242c8c
# bad: [3b5bbe798b2451820e74243b738268f51901e7d0] pidfd: prevent 
creation of pidfds for kthreads
git bisect bad 3b5bbe798b2451820e74243b738268f51901e7d0
# first bad commit: [3b5bbe798b2451820e74243b738268f51901e7d0] pidfd: 
prevent creation of pidfds for kthreads

