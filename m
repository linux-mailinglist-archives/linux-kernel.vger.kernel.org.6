Return-Path: <linux-kernel+bounces-252032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B54930D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A292814B5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FD8139D05;
	Mon, 15 Jul 2024 04:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AF1zSPba"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36DA2D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 04:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721018584; cv=none; b=YaWP9Uor2XV80EHGwDfeJAjk+I/Ik16bQeaaxo6LhrCWBhBULgmLP1KhrEXipUb/gOeNYLK8hyHSi0WHhZGS15MCW7x3jDN1zrMBeyDgEZbXEMu5hYNSSY5BcAPJjqq6oGcattMBcjHdL+XvOGe+mrU69nrfcWxgPgvEMzs5QA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721018584; c=relaxed/simple;
	bh=8LqHvNCykZ2mFB5Pj5IoCERriGsVyLQspoF7k3022XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iscHCG+j2snFZO111i5x0KnHqV8RaWo/VMZsgtxalp99koKuObkGedpJwlF+z6N+ZBaAGL087/pXVVXPmzOW6Vcx1nm97lQnaLB6sWFO3/BjLVQ4H+2Yt61PMvq2Bv4WhOfdTIvAFReCCT5ciKBpRmNuQr0MlUhl87EG3sHPxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AF1zSPba; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-765590154b4so2144354a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 21:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721018582; x=1721623382; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IADZmxzTLI+EAKHAEcSnDNcbUXTg8SpvBSHXGznf7GY=;
        b=AF1zSPbaWV8PO9YgPW1mCo6F/Zhd4GfyqhkRzFbZFA3FazoFytIe3KZw/NYYtbf2CX
         mldBD46Joka9L/P9mKudGh6jG46sDtWXIUAQdazBxCGfcbROeRuyGD5DHSperr5dAPUj
         zJQlfTzDFRUCk28GmnDYaryXRAaEPZdo6dSkHYmFiYcSBbY82d+rt+uRFCvPogY+VdIm
         rYsaUyOyewZRdlnUJsI4uSR7munXoaIZ6ryxHIZ1NG6tn68fHAKWGMx4WN57GoQlvSlD
         QFJzeiBFmVwjcih+EhVamiQsf6lMp7MNkNV9D9IlI++sT/+FYtWMpFJE3CTOUVlVXLum
         fnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721018582; x=1721623382;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IADZmxzTLI+EAKHAEcSnDNcbUXTg8SpvBSHXGznf7GY=;
        b=eGTC6CbE6ju/bZIwN6NkY0ey1FQpkHRxNKk+bpzhAA75c5kAq54FeWc/72ChBYoOBJ
         jLxe55UNBp5McQL9kr5RMB4vEmxTAzG5PtXj0Im/7gIAKbbBZjw2jvxJ9tV9KEb7dVPw
         jcjslZkKu8yXu7yIfmuVRgkyIWxS+wcQ0rpVMiCPyiHxCyAZn61IjQQxJ6KKihCKDZts
         m5Auch0Sr9PZbHm067lprQz9vdRvXGQx1apW6RzCDd9AXOBhPb+aoCwt04PmJkdALkyh
         FLJ0yh9QvLnOI7SeI+uDsOiv+ayDNdkEvVmm6B8uz7YzNUarAsYElIzKhUq9ZUJOdvWP
         ls+w==
X-Gm-Message-State: AOJu0YzkDn421I41FHAIdKh/KIiynIpZPqgqsh0oFKeVQlenWRGnahwX
	VN1vE+V4jGwNL69klSrlag3W6fEZHQyN7Z8MdP2Gr6S0MYj/czMp
X-Google-Smtp-Source: AGHT+IHP9SUFPzoA9pvE+Jv595aOyVJOGKHk97LEBAr2xW57kssk18C+7q1TzTEEij7yvM8SO/VFbw==
X-Received: by 2002:a05:6a20:6a0a:b0:1c2:8c32:1392 with SMTP id adf61e73a8af0-1c29821acd8mr20382990637.22.1721018581664;
        Sun, 14 Jul 2024 21:43:01 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bbc4dc8sm30836435ad.113.2024.07.14.21.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 21:43:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 14 Jul 2024 18:42:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue: Changes for v6.11
Message-ID: <ZpSo08Nd3QXNFK30@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8a92980606e3585d72d510a03b59906e96755b8a:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2024-06-06 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.11

for you to fetch changes up to 58629d4871e8eb2c385b16a73a8451669db59f39:

  workqueue: Always queue work items to the newest PWQ for order workqueues (2024-07-14 18:20:19 -1000)

----------------------------------------------------------------
workqueue: Changes for v6.11

- Lai fixed a bug where CPU hotplug and workqueue attribute changes race
  leaving some workqueues not fully updated. This involved refactoring and
  changing how online CPUs are tracked. The resulting code is cleaner.

- Workqueue watchdog touch operation was causing too much cacheline
  contention on very large machines. Nicholas improved scalabililty by
  avoiding unnecessary global updates.

- Code cleanups and minor rescuer behavior improvement.

- The last commit 58629d4871e8 ("workqueue: Always queue work items to the
  newest PWQ for order workqueues") is a cherry-picked straggler commit from
  for-6.10-fixes, a fix for a bug which may not actually trigger.
  Unfortunately, maybe because for-6.10-fixes was branched off at a
  different point from for-6.11, I couldn't persuade git request-pull to
  generate clean diffstat if pulled into for-6.11.

----------------------------------------------------------------
Julia Lawall (1):
      workqueue: replace call_rcu by kfree_rcu for simple kmem_cache_free callback

Lai Jiangshan (20):
      workqueue: Avoid nr_active manipulation in grabbing inactive items
      workqueue: Reap workers via kthread_stop() and remove detach_completion
      workqueue: Don't bind the rescuer in the last working cpu
      workqueue: Detach workers directly in idle_cull_fn()
      workqueue: Remove useless pool->dying_workers
      workqueue: Update cpumasks after only applying it successfully
      workqueue: Simplify goto statement
      workqueue: Register sysfs after the whole creation of the new wq
      workqueue: Make rescuer initialization as the last step of the creation of a new wq
      workqueue: Move kthread_flush_worker() out of alloc_and_link_pwqs()
      workqueue: Put PWQ allocation and WQ enlistment in the same lock C.S.
      workqueue: Init rescuer's affinities as the wq's effective cpumask
      workqueue: Add wq_online_cpumask
      workqueue: Simplify wq_calc_pod_cpumask() with wq_online_cpumask
      workqueue: Remove cpus_read_lock() from apply_wqattrs_lock()
      workqueue: Remove the unneeded cpumask empty check in wq_calc_pod_cpumask()
      workqueue: Remove the argument @cpu_going_down from wq_calc_pod_cpumask()
      workqueue: Remove the arguments @hotplug_cpu and @online from wq_update_pod()
      workqueue: Rename wq_update_pod() to unbound_wq_update_pwq()
      workqueue: Always queue work items to the newest PWQ for order workqueues

Nicholas Piggin (2):
      workqueue: wq_watchdog_touch is always called with valid CPU
      workqueue: Improve scalability of workqueue watchdog touch

Wenchao Hao (1):
      workqueue: Clean code in alloc_and_link_pwqs()

 kernel/workqueue.c | 346 ++++++++++++++++++++++++-----------------------------
 1 file changed, 157 insertions(+), 189 deletions(-)

