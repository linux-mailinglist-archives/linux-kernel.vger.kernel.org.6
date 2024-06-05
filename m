Return-Path: <linux-kernel+bounces-201958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C7E8FC5DE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF9C1C2116E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF5A49645;
	Wed,  5 Jun 2024 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9y4eSyS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D018D7346E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575384; cv=none; b=OUEh4tg/IGcuSyGG5ajRpQpvywQtM4pUCz6WQwM/EJoIighmZTwM3cPzaGPu3Dwx+iwOaM+BgvIQa9nexu/Zs7TTIE2y+Syo9noqbnoF/Rtlpj4YQTCu2rduVRl6jXAmP3wf2olu2ADzFjpVA1cvBBTcn1RkPVUTAq+kkWwBbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575384; c=relaxed/simple;
	bh=EOvhdiJTjcTzq9dNFX/nSWOUnWSRb6U9OQ4BdE98/BA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qW5NLezODI2nA8OS+Pyy9EzyWnLIGv/Mi3aBlmtg9Aj/gjQUxm86SJbV/ViugrNGWeJ4mc1VRu5/N8q+R4lCv5iYwoCBB9Qicny6zJRTW59gWtwIMhMt3ePakW27ggOPN/jGsXiKyNuQ05wDRkW5Lc06O7YgT07cL3ycsW9baB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z9y4eSyS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SUoXSWeoXOsbgxXSBKJ45MBRWfujZqDzQephBPI5Ke4=;
	b=Z9y4eSySAhhyVN3AG9AeWo4oNXjkJPJvqyFezimXh/TpqQ+6kfYK+thJo7txDtLd1qJ2sc
	7sBqPgbkvJJWxxeoRPcCjC7Z7LiBaeJ8sXuPXTv5NRjTBmzl79lUFL/U28e5CP5kqhbdlI
	Ba9MeUErNr+XKe0UOSGwIv61iLBZFxg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-p60tWm4wMmWTjtO3JQxTZA-1; Wed, 05 Jun 2024 04:16:18 -0400
X-MC-Unique: p60tWm4wMmWTjtO3JQxTZA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-421599b8911so75815e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575377; x=1718180177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUoXSWeoXOsbgxXSBKJ45MBRWfujZqDzQephBPI5Ke4=;
        b=aUIa3e3YjZKn9MNBtyQdVB2wMoAyYgA93krHsdYfu83laN5y3kk2VDg9r0J00df+N5
         T3jvWCf/rgALDRj4BYcOFulzKR3WoQOTIJh+rrlypQ/xCRJFpaf85Efgh/w5kFmCnMzp
         HyyXfKL84R9FVSqtjz8ZnrCoXdKvk8M3MSM6ebVN25lFzqSXItQHRJgxE4yX+5IuhYdx
         xutU74FqK4RmMIi/8ey8p/vKiEngq9nZ8cyfZK+YOF32iQu0m6eatNObsAtY9tyIfKbM
         E5yztcMh3RS5v6GxiGjyyjZTsND99FczcXORfR7Cbv2EUJSRdp0PBYAZ6BgLhCs2kCR8
         e0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUQvRujc4/eOlUh1PF/CJLv9ii7v9bkgZBaMMinYL0bKJ3DF041KLwhi8QLY8HH0G3cIEX46zAwD1Jg8n4/TRmJT3EjC7U1/XVFrdy2
X-Gm-Message-State: AOJu0Yxm7A4je5aHmLCgqvVKr09eweTyz7Nbo7pKz/7l7WO52sX2XwGW
	S5seYz2SGAcugAaYc0o9JPcxbZT3AjFUMjc32XyxacZEmGRVmTSNqURLvKNc9MNHybtjMYkEguB
	sGxoWnWlsIzFtvlW/RfE66aeQJREqun30NyMMAZDJjhCEKSTn4alDA3Iz7VCYDA==
X-Received: by 2002:a5d:49c5:0:b0:354:f768:aa00 with SMTP id ffacd0b85a97d-35e8ef8f11amr1106934f8f.4.1717575376804;
        Wed, 05 Jun 2024 01:16:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNME+MuDs5w69eiKZF/rVs+EPusz8gHZK/eFYZ4sGxhHM7f6xzEXsgalMyE21Hqjldof25wg==
X-Received: by 2002:a5d:49c5:0:b0:354:f768:aa00 with SMTP id ffacd0b85a97d-35e8ef8f11amr1106914f8f.4.1717575376336;
        Wed, 05 Jun 2024 01:16:16 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:16 -0700 (PDT)
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
Subject: [PATCH v7 00/13] Make PCI's devres API more consistent
Date: Wed,  5 Jun 2024 10:15:52 +0200
Message-ID: <20240605081605.18769-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Bjorn,

I tried to meet your requests from the last feedback round as much as
possible. Especially, I removed a lot of code, made almost all
interfaces private and cut the series into smaller chunks where
possible.

Splitting it even smaller is unfortunately not possible because of the
Linux kernel build chain's rule on dead / unused code.

See also the changelog below.

Please tell me if that's enough to move forward here.

Regards,
P.


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
  PCI: Move dev-enabled status bit to struct pci_dev
  PCI: Move pinned status bit to struct pci_dev
  PCI: Give pcim_set_mwi() its own devres callback
  PCI: Give pci(m)_intx its own devres callback
  PCI: Remove legacy pcim_release()
  PCI: Add pcim_iomap_range()
  drm/vboxvideo: fix mapping leaks

 drivers/gpu/drm/vboxvideo/vbox_main.c |  20 +-
 drivers/pci/devres.c                  | 897 +++++++++++++++++++++-----
 drivers/pci/iomap.c                   |  16 +
 drivers/pci/pci.c                     | 107 ++-
 drivers/pci/pci.h                     |  23 +-
 include/linux/pci.h                   |   6 +-
 6 files changed, 864 insertions(+), 205 deletions(-)

-- 
2.45.0


