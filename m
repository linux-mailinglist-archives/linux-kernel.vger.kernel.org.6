Return-Path: <linux-kernel+bounces-265443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E113F93F14D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB621C2199C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6C13E032;
	Mon, 29 Jul 2024 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdF/klzG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10601422C8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245832; cv=none; b=G5Yj7k5etKAy/W9VJ3uCHHDh4nV81P9DyeVw/2N90BLRmxoEnY2raTK8Y2734eFkg1tx95/3Od2mOu3E/QBo21aEImD/2Du2iQQAddEyikKGEG8aLymwzVlIHlLhCQs0K1QDeQDoib2KTyzhUyV6obF5bruNPnMHcji3sH5BXbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245832; c=relaxed/simple;
	bh=q+R0BpDAfe+tAd0rPJpsXFT4k1DLRypi7UxROY3RFFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahRLLAAtTjhI7iWcMSJM50X1i1jIkeXnaIeWdQx8b/X9Br8DnwAgD7lNONOY2oGNSBLNnnzisZ0uqkRSFHHC1Fydjy2k8O6TGNaaIKQ3ASIHnaoKptbP7Gwu9aH5ohWGBx/ZVZeqa5byebbEvEMo/xq30+7s8so4AUdEMC3/KEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdF/klzG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722245829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yzHolj0LBWvvfbf6+tRyOWfIn+0w0Jej2YhRYKH2Gc=;
	b=FdF/klzG8gkcV5jGIcHRoe7YlFKjVg9s/BZZNjKMJbYFyqYWdTsfhgvRpDFJ3zuAL872kK
	T+qHoHE576gnBD560Q+fFEbDvlDLyjqt4Rndt73mAcBLumg/+CAJ5QJipCKxUCfGrls8gg
	pYP6+eMxB4Cfvq2C0yPO9d1xpX33+mA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-iDO04e4uN76b5u1lK26bTw-1; Mon, 29 Jul 2024 05:37:04 -0400
X-MC-Unique: iDO04e4uN76b5u1lK26bTw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b7b1d79bacso6528106d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245824; x=1722850624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yzHolj0LBWvvfbf6+tRyOWfIn+0w0Jej2YhRYKH2Gc=;
        b=JyOMoUzrZ0gJcEFlIaadJumxxbrqcwu1FBE3tq4uUk9+FwQyXrGctUeXQgCYbssZ1v
         xZhXNGLv5bA30RcrIMdWZOVcFBICpQfWpFJQyxZ9XDXGLl2Wmvza1xWRmDtHzYe0YDe7
         DaTB0badmmVtfqVQQu5VMExl0mz9U4bepBwtjCKcN3k/Dc2T+dzNRKL5UpATzXGCaRXU
         Tfa5QPtbTDsj4gvYzjc3/40ssiuyqZibb6+fYx6o1o1XLGPxYGSMchl0W5OcUkIV7cK8
         swh9YiMsA8b+yLOijO69dSkOxqdMITLpSQbpMuV5Y19ooCfSNjzSKZwNQXFhjtp7TqE6
         jK1A==
X-Forwarded-Encrypted: i=1; AJvYcCXBVnE/Hnh/HNN5oyDnsv5V/BuBo89wLYsVgqEH9er4Bbvvgl0MzhhnSwiLtD45Eb0m0d2JLeuuC1oX3ajMx4XiMxV+4nnGf9RxjOb2
X-Gm-Message-State: AOJu0YzKL3XnQUPtUrAPJEjfK9NjlTRkWaO6nrioOs+yUmcM0OqcsXqQ
	r0PtRdF8i1+AK4khSIGqFS1fXyhjPyfMkvUySRESC0BRC/g5r2CifcMNFW8gJZh+PF01a0p6NoD
	HX7EpjEe6oGldaVyewSmZOrzkY0FwpJCDzBSeEYATBivV+dwCLgMkFIhR9PPUqQ==
X-Received: by 2002:a05:6214:2b0a:b0:6b7:7832:2211 with SMTP id 6a1803df08f44-6bb3e2043dbmr102004176d6.3.1722245824094;
        Mon, 29 Jul 2024 02:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFajgcbMizSfez+xFTta1vgiY+ZYkosQdlpq9GU2h/rROwHquJE6I29rQYeZi0foyo1YN47NA==
X-Received: by 2002:a05:6214:2b0a:b0:6b7:7832:2211 with SMTP id 6a1803df08f44-6bb3e2043dbmr102003986d6.3.1722245823659;
        Mon, 29 Jul 2024 02:37:03 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94a16sm50047086d6.86.2024.07.29.02.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:37:03 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 2/2] drm/vboxvideo: Add PCI region request
Date: Mon, 29 Jul 2024 11:36:27 +0200
Message-ID: <20240729093625.17561-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729093625.17561-2-pstanner@redhat.com>
References: <20240729093625.17561-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vboxvideo currently does not reserve its PCI BAR through a region
request.

Implement the request through the managed function
pcim_request_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/vboxvideo/vbox_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vboxvideo/vbox_main.c
index d4ade9325401..7f686a0190e6 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_main.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
@@ -114,6 +114,10 @@ int vbox_hw_init(struct vbox_private *vbox)
 
 	DRM_INFO("VRAM %08x\n", vbox->full_vram_size);
 
+	ret = pcim_request_region(pdev, 0, "vboxvideo");
+	if (ret)
+		return ret;
+
 	/* Map guest-heap at end of vram */
 	vbox->guest_heap = pcim_iomap_range(pdev, 0,
 			GUEST_HEAP_OFFSET(vbox), GUEST_HEAP_SIZE);
-- 
2.45.2


