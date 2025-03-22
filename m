Return-Path: <linux-kernel+bounces-572688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E49A6CD3E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 00:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B52F1707FC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 23:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A571EE7CB;
	Sat, 22 Mar 2025 23:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoEIRZYH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69E9443
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742686146; cv=none; b=inbNxB6px8amZAbx5STM0t5d0C0VLIDHIGXC9QkN1jXsIy017iNyI11TY5qzKdNQ5tXJX0V5yuOL6G9bbbS8/ju3Izq2JraLcvJBg5m14tVo3Ehcssh7+GK4pGcP7YXb1WKlilGGXa/kSQK/kUg4lJfxpDmdGn6/4pn5xD2F8yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742686146; c=relaxed/simple;
	bh=fmgZlT3Lzf7IOz9N5aPau8b3yk/PWxJON13OuwCKBX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=RameSmmmN+/HuBc1d1HEHTPkDtDUMGSRGuzpaDnGim7Q+e/AmG2DBCazZoNN8Ns882KfM8XIjCHGnG8BXcE43sP9RX1zBuFBlMcm+9220U4iCr73wqTd14uVAjLAL9CMIw+DrLuGi6j3MN1LmIYeLWJmZIRT1HYKagDTleKZIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PoEIRZYH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742686143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w8BcOo88xyWsRWuAYK8HCKlRNkXjn8rgywJ/9mOiHUk=;
	b=PoEIRZYHYkbsL9crMnGIh3wR7pSGFnfz9Rx3iCWe96JuF9G0FgNCU/B5AOZTxH7GxedBqr
	QP2tDak/Gk3Uuvip253lC/TyzOO1WaGdEwNlusC7aAN/YIWFSLVbfBAALwDaBRnoUVLNtl
	oFRlPmHgTBLfxlfXKYqydq9brs4YkXI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-zDYPmRy9Nju3GFmKqHDPpQ-1; Sat,
 22 Mar 2025 19:29:01 -0400
X-MC-Unique: zDYPmRy9Nju3GFmKqHDPpQ-1
X-Mimecast-MFC-AGG-ID: zDYPmRy9Nju3GFmKqHDPpQ_1742686139
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D747319560AF;
	Sat, 22 Mar 2025 23:28:58 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.80.230])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62515180B488;
	Sat, 22 Mar 2025 23:28:56 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: loberman@redhat.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	bgurney@redhat.com
Subject: [PATCH v2 0/3] nvme: make core.nvme_multipath configurable   
Date: Sat, 22 Mar 2025 19:28:45 -0400
Message-ID: <20250322232848.225140-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

These patches propose an alternative to the outright removal of the nvme
core multipath module parameter. Rather than deleting this module
parameter we control its appearance with a new Kconfig option named
NVME_MULTIPATH_PARAM

Note that the default kernel config settings produce a kernel
with no change in functionality. By default both NVME_MULTIPATH
and NVME_MULTIPATH_PARAM are enabled and there are no user visable
changes.

To remove the core.nvme_multipath parameter simply compile with
CONFIG_NVME_MULTIPATH_PARAM=n.

Note: the current behavior of nvme-v6.15

  CONFIG_NVME_MULTIPATH=y and nvme_core.multipath=N

  [  182.863531] nvme nvme4: Found shared namespace 1, but multipathing not supported.
  [  182.871030] nvme nvme4: Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.

Closes: https://lore.kernel.org/linux-nvme/20241121220321.40616-1-bgurney@redhat.com/
Closes: https://lore.kernel.org/linux-nvme/20250204211158.43126-1-bgurney@redhat.com/
Closes: https://lore.kernel.org/linux-nvme/20250228032541.369804-1-jmeneghi@redhat.com/ 

Changes Since v1

Rebased patches to nvme-v6.15

  nvme: add mulitipath warning to nvme_alloc_ns

Dropped this patch because the dmesg it produced was redundant and not
needed. Testing multiport devices with CONFIG_NVME_MULTIPATH disabled
show the following console message at boot.

[167523.157284] nvme nvme5: Found shared namespace 1, but multipathing not supported.
[167523.217083] nvme nvme6: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.

  nvme-multipath: add the NVME_MULTIPATH_PARAM config option

Fixed up the Kconfig description for NVME_MULTIPATH_PARAM.
Add default y and tested the follow Kconfig options.

Tested the following:

  make mod2noconfig
  make allyesconfig
  make allmodconfig
  make olddefconfig
  make oldconfig - accept all defaults

No change in current behavior.

  nvme: update the multipath warning in nvme_init_ns_head

Tests ran with CONFIG_NVME_MULTIPATH=y and CONFIG_NVME_MULTIPATH_PARM=n

No change in current behavior except:

  [root@rhel-storage-108 ~]# cat /sys/module/nvme_core/parameters/multipath
  cat: /sys/module/nvme_core/parameters/multipath: No such file or directory
  
The following does nothing, just like it does when CONFIG_NVME_MULTIPATH=n

  [root@rhel-storage-108 ~]# grubby --update-kernel=ALL --args="nvme_core.multipath=N"
  [root@rhel-storage-108 ~]# reboot now
  .
  .
  .
  [root@rhel-storage-108 ~]# cat /proc/cmdline
  BOOT_IMAGE=(hd1,gpt2)/vmlinuz-6.14.0-rc2_config_ana4a+ ...  nvme_core.multipath=N
  [root@rhel-storage-108 ~]# cat /sys/module/nvme_core/parameters/multipath
  cat: /sys/module/nvme_core/parameters/multipath: No such file or directory

Tests ran with CONFIG_NVME_MULTIPATH=y and CONFIG_NVME_MULTIPATH_PARM=y

  There is no change in current behavior:

Tests ran with CONFIG_NVME_MULTIPATH=y, CONFIG_NVME_MULTIPATH_PARM=y
and nvme_core.multipath=N

  [  372.040105] nvme nvme4: Found shared namespace 1, but multipathing not supported.
  [  372.047606] nvme nvme4: Shared namespace support requires core_nvme.multipath=Y.
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
			                   new message
  [  372.105469] nvme nvme5: creating 2 I/O queues.
  [  372.110383] nvme nvme5: mapped 2/0/0 default/read/poll queues.
  [  372.125480] nvme nvme5: new ctrl: NQN ....
  [  372.166081] nvme nvme5: Found shared namespace 1, but multipathing not supported.
  [  372.235964] nvme nvme6: creating 2 I/O queues.
  [  372.240926] nvme nvme6: mapped 2/0/0 default/read/poll queues.
  [  372.255964] nvme nvme6: new ctrl: NQN ....
  [root@rhel-storage-108 ~]# cat /sys/module/nvme_core/parameters/multipath
  N
  [root@rhel-storage-108 ~]# grubby --remove-args="nvme_core.multipath=N" --update-kernel=ALL
  [root@rhel-storage-108 ~]# grubby --info=ALL | grep nvme_core 
  [root@rhel-storage-108 ~]# reboot now
  .
  .
  .
  [root@rhel-storage-108 ~]# cat /sys/module/nvme_core/parameters/multipath
  Y



John Meneghini (3):
  nvme-multipath: change the NVME_MULTIPATH config option
  nvme-multipath: add the NVME_MULTIPATH_PARAM config option
  nvme: update the multipath warning in nvme_init_ns_head

 drivers/nvme/host/Kconfig     | 26 ++++++++++++++++++++++----
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c |  3 ++-
 3 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.48.1


