Return-Path: <linux-kernel+bounces-207939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF088901E35
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AB3282CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D9F74C04;
	Mon, 10 Jun 2024 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBYZDtt0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ED61DFD0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011925; cv=none; b=c2yhCRyMjN1hY5OT/+fmWIZJ/Rqj/eBtKNYIh67Q66oE9JkJt8EafhjheuyTwYXqr/lw76eJKRplGVp6UCJJ/gQSOH+ejqxwF8z+227FsJMsE60hB8Iwff/aSrhJ2a7iASA+4bY4iutUEDNeCuATpubzlXVC2mLoKZL1KiIbtko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011925; c=relaxed/simple;
	bh=rxHVyu5ZsAyyi3Nyf3yiDcRXe7b8QkcJkWh+np+a5Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jy3WOM4qB+yYka+fOAkeM2ye1bmBt0k5W5i19W2NBAwSyTMDrbUTWeE4+h0jyHEeYl/6zS8og15tkvjUkwBkb+qL2/m3B4JV41JGvaImJHWLxqH8nNiHtaYG1EZM/KAR5oinjtfA4XIeK9MmuIevHirgWhhMnuzLFkgRJ+HZ4vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBYZDtt0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lajbw/vzAdJUafpqdzbQDZAoX9AC7ByPINbDnGjyGDY=;
	b=jBYZDtt0PPD2Ap2hoywxcgr584AYYmTRVrwAJ1jT6tVMtO7U+iWqLO4738TrEw4D7YF/Wm
	UcbXRcneeR/h7n7P+w9HKiBP7x4/UfcAgmDARp1T60yH2vGqBrjWiiG3KL0qfAD0G/eymo
	DMcf0nAO/Su115hXwmis9a1sNGoVQXQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-elxXKzoJO_m98DQvxVwV_g-1; Mon, 10 Jun 2024 05:32:01 -0400
X-MC-Unique: elxXKzoJO_m98DQvxVwV_g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4212974c99eso3872455e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011920; x=1718616720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lajbw/vzAdJUafpqdzbQDZAoX9AC7ByPINbDnGjyGDY=;
        b=DU81ewtQogi594fmnmjtmSRq5mXd3s37RmmFtIzPnOXYkq3ZAojeQicekPJspqbVkU
         6bsb/MS5jQE3qexmwmqWxxvFA1/JMbsFAz2LTDBLKTVLPh5oJ+y2DlZ9FlvBIZZDMbfs
         jSPiRv7LR90FRYhpkx3F0dB1VTjipFbm2ezHV+IaDBnm2lA+P7CYLq0qEExwyHxYbQxS
         LE+ORn6hPY2kSyQP1TBjmWQeiBrJ6aENIjk4LWdpSZ+7O0u4tIBz39tLP06ve9ABRlC8
         mHpVKvdxnwLS5h4wmIO3gijCoSsjKtHz/CTZ1ryOaDklE4a6+bWfwO3WvnRl1f36sIWS
         9aeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoZfN+0CRR249RyzolYzn2BvyXWXY+mCzVwl3LQFizbpqFsW+N7/It/mPg/DOABzn8vkIjl9w9MaTuitD1NjZEIsBeJLdgzCly1ANx
X-Gm-Message-State: AOJu0YxwlJGnO1263lGMUNQu1fq8ijf0HJzv6GM/dCPOEokvFBSJo1h9
	oP7C0bpbWzr4NizR/lSa2Vu+1jP3+E+bMPvmJgzW1+7FY4NHdi2PWqD1fpNYXUCY7Uec/x5pZ02
	u2KAfEUW9uGaxpPIBCJDKQ5qkGcESdfKOtOCWvQMkaDMTngy5b9Z8Y59ekZ6qDp0cIINd+w==
X-Received: by 2002:a5d:6c65:0:b0:354:fa7d:dcf5 with SMTP id ffacd0b85a97d-35efea7e189mr6468702f8f.0.1718011920064;
        Mon, 10 Jun 2024 02:32:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr55V3YegSgdbDEaiIB1+mPSFWDBgzwdPX522GSdF0ZrhM8sPMzvXzbmou/3pnLQkC4ZA53Q==
X-Received: by 2002:a5d:6c65:0:b0:354:fa7d:dcf5 with SMTP id ffacd0b85a97d-35efea7e189mr6468668f8f.0.1718011919629;
        Mon, 10 Jun 2024 02:31:59 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:31:59 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v8 00/13] Make PCI's devres API more consistent
Date: Mon, 10 Jun 2024 11:31:22 +0200
Message-ID: <20240610093149.20640-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This v8 is based on [1]. It contains the already applied patches in
unchanged form; just for readability and consistency.

Thx for taking the first set of patches! This series provides the
enabled_cnt rework and some other minor fixes. See below.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=devres

P.


Changes in v8:
  - Rebase the series on the already merged patches which were slightly
    modified by Bjorn Helgaas.
  - Reword the pci_intx() commit message so it clearly states it's about
    reworking pci_intx().
  - Move the removal of find_pci_dr() from patch "Remove legacy
    pcim_release()" to patch "Give pci_intx() its own devres callback"
    since this later patch already removed all calls to that function.
  - In patch "Give pci_intx() its own devres callback": use
    pci_is_enabled() (and, thus, the enabled_cnt in struct pci_dev)
    instead of a separate enabled field. (Bjorn)

Changes in v7:
  - Split the entire series in smaller, more atomic chunks / patches
    (Bjorn)
  - Remove functions (such as pcim_iomap_region_range()) that do not yet
    have a user (Bjorn)
  - Don't export interfaces publicly anymore, except for
    pcim_iomap_range(), needed by vboxvideo (Bjorn)
  - Mention the actual (vboxvideo) bug in "PCI: Warn users..." commit
    (Bjorn)
  - Drop docstring warnings on PCI-internal functions (Bjorn)
  - Rework docstring warnings
  - Fix spelling in a few places. Rewrapp paragraphs (Bjorn)

Changes in v6:
  - Restructure the cleanup in pcim_iomap_regions_request_all() so that
    it doesn't trigger a (false positive) test robot warning. No
    behavior change intended. (Dan Carpenter)

Changes in v5:
  - Add Hans's Reviewed-by to vboxvideo patch (Hans de Goede)
  - Remove stable-kernel from CC in vboxvideo patch (Hans de Goede)

Changes in v4:
  - Rebase against linux-next

Changes in v3:
  - Use the term "PCI devres API" at some forgotten places.
  - Fix more grammar errors in patch #3.
  - Remove the comment advising to call (the outdated) pcim_intx() in pci.c
  - Rename __pcim_request_region_range() flags-field "exclusive" to
    "req_flags", since this is what the int actually represents.
  - Remove the call to pcim_region_request() from patch #10. (Hans)

Changes in v2:
  - Make commit head lines congruent with PCI's style (Bjorn)
  - Add missing error checks for devm_add_action(). (Andy)
  - Repair the "Returns: " marks for docu generation (Andy)
  - Initialize the addr_devres struct with memset(). (Andy)
  - Make pcim_intx() a PCI-internal function so that new drivers won't
    be encouraged to use the outdated pci_intx() mechanism.
    (Andy / Philipp)
  - Fix grammar and spelling (Bjorn)
  - Be more precise on why pcim_iomap_table() is problematic (Bjorn)
  - Provide the actual structs' and functions' names in the commit
    messages (Bjorn)
  - Remove redundant variable initializers (Andy)
  - Regroup PM bitfield members in struct pci_dev (Andy)
  - Make pcim_intx() visible only for the PCI subsystem so that new    
    drivers won't use this outdated API (Andy, Myself)
  - Add a NOTE to pcim_iomap() to warn about this function being the    onee
    xception that does just return NULL.
  - Consistently use the term "PCI devres API"; also in Patch #10 (Bjorn)


¡Hola!

PCI's devres API suffers several weaknesses:

1. There are functions prefixed with pcim_. Those are always managed
   counterparts to never-managed functions prefixed with pci_ – or so one
   would like to think. There are some apparently unmanaged functions
   (all region-request / release functions, and pci_intx()) which
   suddenly become managed once the user has initialized the device with
   pcim_enable_device() instead of pci_enable_device(). This "sometimes
   yes, sometimes no" nature of those functions is confusing and
   therefore bug-provoking. In fact, it has already caused a bug in DRM.
   The last patch in this series fixes that bug.
2. iomappings: Instead of giving each mapping its own callback, the
   existing API uses a statically allocated struct tracking one mapping
   per bar. This is not extensible. Especially, you can't create
   _ranged_ managed mappings that way, which many drivers want.
3. Managed request functions only exist as "plural versions" with a
   bit-mask as a parameter. That's quite over-engineered considering
   that each user only ever mapps one, maybe two bars.

This series:
- add a set of new "singular" devres functions that use devres the way
  its intended, with one callback per resource.
- deprecates the existing iomap-table mechanism.
- deprecates the hybrid nature of pci_ functions.
- preserves backwards compatibility so that drivers using the existing
  API won't notice any changes.
- adds documentation, especially some warning users about the
  complicated nature of PCI's devres.


Note that this series is based on my "unify pci_iounmap"-series from a
few weeks ago. [1]

I tested this on a x86 VM with a simple pci test-device with two
regions. Operates and reserves resources as intended on my system.
Kasan and kmemleak didn't find any problems.

I believe this series cleans the API up as much as possible without
having to port all existing drivers to the new API. Especially, I think
that this implementation is easy to extend if the need for new managed
functions arises :)

Greetings,
P.

Philipp Stanner (13):
  PCI: Add and use devres helper for bit masks
  PCI: Add devres helpers for iomap table
  PCI: Reimplement plural devres functions
  PCI: Deprecate two surplus devres functions
  PCI: Make devres region requests consistent
  PCI: Warn users about complicated devres nature
  PCI: Remove enabled status bit from pci_devres
  PCI: Move pinned status bit to struct pci_dev
  PCI: Give pcim_set_mwi() its own devres callback
  PCI: Give pci_intx() its own devres callback
  PCI: Remove legacy pcim_release()
  PCI: Add pcim_iomap_range()
  drm/vboxvideo: fix mapping leaks

 drivers/gpu/drm/vboxvideo/vbox_main.c |  20 +-
 drivers/pci/devres.c                  | 903 +++++++++++++++++++++-----
 drivers/pci/iomap.c                   |  16 +
 drivers/pci/pci.c                     |  94 ++-
 drivers/pci/pci.h                     |  23 +-
 include/linux/pci.h                   |   6 +-
 6 files changed, 859 insertions(+), 203 deletions(-)

-- 
2.45.0


