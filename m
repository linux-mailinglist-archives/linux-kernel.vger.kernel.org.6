Return-Path: <linux-kernel+bounces-404492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BFA9C444A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0706A289CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8371A9B53;
	Mon, 11 Nov 2024 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iG/1OZvZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBEC1A726F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347929; cv=none; b=iwYktnn8NcLYz7oLE2UOM7u/dwrlxmkLdPdFqUcvBs/Fp3jothTV5joTx9s9Tg3znpo1sZMAtwHx+Wp6Zt/q484jT6BAPy/z/IGjaQ70wO8hT+5QCS9lGTfQXnqSwCKHFW5DUply8IdpED0VnnCyIj8Gh9ifKDkJ5fQq1wn5j1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347929; c=relaxed/simple;
	bh=G2CzNKw6IB0uWUmylYCUp50o0lF48oVmPI3HkWGnCUA=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=DvGAWkUYdoDy2rsGdCnodfxfFP+WXFjwx0GmtVUw1rpYLnDTF1qlbruWXfteTQPNlHqphwympgnTY8aBokfOSVtfPDTsyDI2wH4mnvqd3JYxsCDZHJd64BSgK3aYYGsM0rZEW9fbVA3rSxh8upLJi+8YGOas9JQqlFSImCTtrTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iG/1OZvZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731347926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9LO3gUkdi2cVbws/ZpX8HNi/5QrwjDJiLQjVkMGx38w=;
	b=iG/1OZvZHW/lxwB+Mdt29oFxIIfFxZb916+gMh3NndWrxcNUq9gGJTxPU/jzL5kfDUJeVL
	7ixaUcGeW6UJfSFd5B8L2MimywtHUB50hWpvt8fC8PQ8UXU1CafVY+9OZ9gd+5s7mYboZu
	d0OFVrL8qadYOzzVMscFAjv8fPDxQDU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-FJ45nKW1NYKf-HDB8lsIjg-1; Mon, 11 Nov 2024 12:58:45 -0500
X-MC-Unique: FJ45nKW1NYKf-HDB8lsIjg-1
X-Mimecast-MFC-AGG-ID: FJ45nKW1NYKf-HDB8lsIjg
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-460dd08f4d0so86268051cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731347925; x=1731952725;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LO3gUkdi2cVbws/ZpX8HNi/5QrwjDJiLQjVkMGx38w=;
        b=ROKhm161jtsvrFHojjIN9RAavp4+nGPEXAYHPjLixfc1QQR3KQmktI4Mpp14/KF2hP
         HkFwoXhja4FSUkact1UFNdyfBm99urLmxfYpRzTeWtK3NIvlWqt6nO9hFr7yqSdjXNDv
         Jo4FhWS/EW74TK0HgGNJ3k89wfN6WDSa1RC82N+GUQk3ntRc1yT1ukDp0KWn3k1ibIls
         8j73QDm0Iio6wxepJeH2sd9cFQP7L9rbinL6EDQeNgjmzGs07Tn917tyqP0aqF0UOWRx
         FvauJFov7WhqKEexQLgMdCf275CnNXwIjMWNIGcCEqj097lsrgO5I6+MS2TzMabSJNU1
         8P3A==
X-Forwarded-Encrypted: i=1; AJvYcCXwFWwDcNo+IPviy3vKtOAtRVM/Iv5cLX8FjaTM6WGO+apaAAQWtj2ckRDSke4qLZpppjdRXOiDvy5nhVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxFT1LMUUCUskstzofkT7PCtVjbONTmHvq/s2kDw1fJhhxYAgv
	xQf2oR0diIizkq+2iStFy90/oJQUGSexvmoMSu9P7KckMNEZvDoAbvQ6NbE/48oycPNMVNGcxdS
	+jmBBhN6aV6KIGYNrRc0yCxCR7V2Rkz11GWFDYRR4lLFp8wD8W0r0ovDIa+GyEQ==
X-Received: by 2002:a05:6214:3b88:b0:6cd:f90a:bb1b with SMTP id 6a1803df08f44-6d39e0f7539mr177908566d6.4.1731347924838;
        Mon, 11 Nov 2024 09:58:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZaMayYl+Cj0woN+jDm6+WjwbJTfxalN8mosySOvkzy2Oki/xb1u92W1m/BiWWeaQOnkaZhQ==
X-Received: by 2002:a05:6214:3b88:b0:6cd:f90a:bb1b with SMTP id 6a1803df08f44-6d39e0f7539mr177908376d6.4.1731347924494;
        Mon, 11 Nov 2024 09:58:44 -0800 (PST)
Received: from rh (p200300f6af368f00f7bae606b15f3bdb.dip0.t-ipconnect.de. [2003:f6:af36:8f00:f7ba:e606:b15f:3bdb])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df2desm62531236d6.21.2024.11.11.09.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 09:58:44 -0800 (PST)
Date: Mon, 11 Nov 2024 18:58:40 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: lockdep warning in pciehp
Message-ID: <f9f13728-ade8-c5b9-0cc3-2fb23db2f051@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Hej,

I stumbled over this lockdep splat during pci hotplug:
[   26.016648] ======================================================
[   26.019646] WARNING: possible circular locking dependency detected
[   26.022785] 6.12.0-rc6+ #176 Not tainted
[   26.024776] ------------------------------------------------------
[   26.027909] irq/50-pciehp/57 is trying to acquire lock:
[   26.030559] ffff0000c02ad700 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_configure_device+0xe4/0x1a0
[   26.035423] 
[   26.035423] but task is already holding lock:
[   26.038505] ffff800082f819f8 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pci_lock_rescan_remove+0x24/0x38
[   26.043512] 
[   26.043512] which lock already depends on the new lock.
[   26.043512] 
[   26.047863] 
[   26.047863] the existing dependency chain (in reverse order) is:
[   26.051823] 
[   26.051823] -> #1 (pci_rescan_remove_lock){+.+.}-{3:3}:
[   26.056209]        __mutex_lock+0x90/0x3a0
[   26.057946]        mutex_lock_nested+0x2c/0x40
[   26.059848]        pci_lock_rescan_remove+0x24/0x38
[   26.062560]        pciehp_configure_device+0x48/0x1a0
[   26.065592]        pciehp_handle_presence_or_link_change+0x1e0/0x4a0
[   26.069044]        pciehp_ist+0x21c/0x268
[   26.071186]        irq_thread_fn+0x34/0xb8
[   26.073368]        irq_thread+0x154/0x2d0
[   26.075503]        kthread+0x108/0x120
[   26.077504]        ret_from_fork+0x10/0x20
[   26.079695] 
[   26.079695] -> #0 (&ctrl->reset_lock){.+.+}-{3:3}:
[   26.083164]        __lock_acquire+0x12bc/0x1eb8
[   26.085592]        lock_acquire+0x1e0/0x358
[   26.087831]        down_read_nested+0x54/0x160
[   26.090198]        pciehp_configure_device+0xe4/0x1a0
[   26.092895]        pciehp_handle_presence_or_link_change+0x1e0/0x4a0
[   26.096225]        pciehp_ist+0x21c/0x268
[   26.098337]        irq_thread_fn+0x34/0xb8
[   26.100509]        irq_thread+0x154/0x2d0
[   26.102668]        kthread+0x108/0x120
[   26.104660]        ret_from_fork+0x10/0x20
[   26.106790] 
[   26.106790] other info that might help us debug this:
[   26.106790] 
[   26.111033]  Possible unsafe locking scenario:
[   26.111033] 
[   26.114184]        CPU0                    CPU1
[   26.116607]        ----                    ----
[   26.119023]   lock(pci_rescan_remove_lock);
[   26.121776]                                lock(&ctrl->reset_lock);
[   26.123924]                                lock(pci_rescan_remove_lock);
[   26.126098]   rlock(&ctrl->reset_lock);
[   26.127349] 
[   26.127349]  *** DEADLOCK ***
[   26.127349] 
[   26.129274] 1 lock held by irq/50-pciehp/57:
[   26.130664]  #0: ffff800082f819f8 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pci_lock_rescan_remove+0x24/0x38
[   26.135941] 
[   26.135941] stack backtrace:
[   26.138240] CPU: 0 UID: 0 PID: 57 Comm: irq/50-pciehp Not tainted 6.12.0-rc6+ #176
[   26.142223] Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20230524-3.fc37 05/24/2023
[   26.146514] Call trace:
[   26.147795]  dump_backtrace+0xa4/0x130
[   26.149759]  show_stack+0x20/0x38
[   26.151504]  dump_stack_lvl+0x90/0xd0
[   26.153429]  dump_stack+0x18/0x28
[   26.155209]  print_circular_bug+0x28c/0x370
[   26.157601]  check_noncircular+0x140/0x150
[   26.159830]  __lock_acquire+0x12bc/0x1eb8
[   26.161949]  lock_acquire+0x1e0/0x358
[   26.163990]  down_read_nested+0x54/0x160
[   26.166172]  pciehp_configure_device+0xe4/0x1a0
[   26.168586]  pciehp_handle_presence_or_link_change+0x1e0/0x4a0
[   26.171755]  pciehp_ist+0x21c/0x268
[   26.173672]  irq_thread_fn+0x34/0xb8
[   26.175523]  irq_thread+0x154/0x2d0
[   26.177336]  kthread+0x108/0x120
[   26.179000]  ret_from_fork+0x10/0x20

I don't think that this could actually happen since this is only called by a
single irq thread but this splat is kinda annoying and pciehp_configure_device()
doesn't seem to do much that needs the reset_lock. How about this?

---->8
[PATCH] pciehp: fix lockdep warning

Call pciehp_configure_device() without reset_lock being held to
fix the following lockdep warning. The only action that seems to
require the reset_lock is writing to ctrl->dsn, so move that to
the caller that holds the lock.

[   26.019646] WARNING: possible circular locking dependency detected
[   26.022785] 6.12.0-rc6+ #176 Not tainted
[   26.024776] ------------------------------------------------------
[   26.027909] irq/50-pciehp/57 is trying to acquire lock:
[   26.030559] ffff0000c02ad700 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_configure_device+0xe4/0x1a0
[   26.035423]
[   26.035423] but task is already holding lock:
[   26.038505] ffff800082f819f8 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pci_lock_rescan_remove+0x24/0x38
[   26.043512]
[   26.043512] which lock already depends on the new lock.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
  drivers/pci/hotplug/pciehp.h      |  2 +-
  drivers/pci/hotplug/pciehp_ctrl.c | 11 ++++++++++-
  drivers/pci/hotplug/pciehp_pci.c  | 12 ++++--------
  3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 273dd8c66f4e..ff7651d9b49e 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -165,7 +165,7 @@ void pciehp_request(struct controller *ctrl, int action);
  void pciehp_handle_button_press(struct controller *ctrl);
  void pciehp_handle_disable_request(struct controller *ctrl);
  void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events);
-int pciehp_configure_device(struct controller *ctrl);
+int pciehp_configure_device(struct controller *ctrl, u64 *dsn);
  void pciehp_unconfigure_device(struct controller *ctrl, bool presence);
  void pciehp_queue_pushbutton_work(struct work_struct *work);
  struct controller *pcie_init(struct pcie_device *dev);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index dcdbfcf404dd..ed0526bed16e 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -59,6 +59,7 @@ static void set_slot_off(struct controller *ctrl)
  static int board_added(struct controller *ctrl)
  {
  	int retval = 0;
+	u64 dsn = 0;
  	struct pci_bus *parent = ctrl->pcie->port->subordinate;

  	if (POWER_CTRL(ctrl)) {
@@ -83,13 +84,21 @@ static int board_added(struct controller *ctrl)
  		goto err_exit;
  	}

-	retval = pciehp_configure_device(ctrl);
+	/*
+	 * Release reset_lock during driver binding
+	 * to avoid AB-BA deadlock with device_lock.
+	 */
+	up_read(&ctrl->reset_lock);
+	retval = pciehp_configure_device(ctrl, &dsn);
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
  	if (retval) {
  		if (retval != -EEXIST) {
  			ctrl_err(ctrl, "Cannot add device at %04x:%02x:00\n",
  				 pci_domain_nr(parent), parent->number);
  			goto err_exit;
  		}
+	} else {
+		ctrl->dsn = dsn;
  	}

  	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 65e50bee1a8c..9ef28c841c36 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -24,12 +24,14 @@
  /**
   * pciehp_configure_device() - enumerate PCI devices below a hotplug bridge
   * @ctrl: PCIe hotplug controller
+ * @dsn: Device Serial Number of Function 0 in the hotplug slot
   *
   * Enumerate PCI devices below a hotplug bridge and add them to the system.
+ * On success store the Device Serial Number of Function 0 in @dsn.
   * Return 0 on success, %-EEXIST if the devices are already enumerated or
   * %-ENODEV if enumeration failed.
   */
-int pciehp_configure_device(struct controller *ctrl)
+int pciehp_configure_device(struct controller *ctrl, u64 *dsn)
  {
  	struct pci_dev *dev;
  	struct pci_dev *bridge = ctrl->pcie->port;
@@ -64,16 +66,10 @@ int pciehp_configure_device(struct controller *ctrl)
  	pci_assign_unassigned_bridge_resources(bridge);
  	pcie_bus_configure_settings(parent);

-	/*
-	 * Release reset_lock during driver binding
-	 * to avoid AB-BA deadlock with device_lock.
-	 */
-	up_read(&ctrl->reset_lock);
  	pci_bus_add_devices(parent);
-	down_read_nested(&ctrl->reset_lock, ctrl->depth);

  	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
-	ctrl->dsn = pci_get_dsn(dev);
+	*dsn = pci_get_dsn(dev);
  	pci_dev_put(dev);

   out:
-- 
2.42.0


