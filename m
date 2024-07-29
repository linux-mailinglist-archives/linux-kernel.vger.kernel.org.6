Return-Path: <linux-kernel+bounces-265441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 545F693F148
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6573B2267C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1832E13D255;
	Mon, 29 Jul 2024 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJtLZ6WE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DC3770E1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245824; cv=none; b=TMbHdHKsyA/6vCX4FOH1Mdox96HSmWDCkKD4WVcHnguHMsr4igaSjgbFk6LEG+p0cOAI2Y6K5FzNJ1apioUTutvjZZTUjf4a2yhMDGIBivrm49uyDLAIg/Mff9QPCWYfmiHYSrP7tl45t7+F8VpvNNKdOJzmPyKG+Ynj7p+su2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245824; c=relaxed/simple;
	bh=HzA7AEw0WWQvtM2aMWSpL9Zx3KaolqvcZTtnjqIEIJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pvt+aHPkeQFrOVYs9cZj3vovrsDOIelsgP3EXY9s6bddRsIYWm+W+cCL2ZhNk/uE1XbS3n0dvfoNKuw/jFrbxEncXuerjtdtB1GgNuAEJ1JQAk/WzTQsVZntUAYVPiiKpIUrA1qvJLzGwfuSuQmupYzoPtXJ3rx0CyFeLKN/lb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJtLZ6WE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722245821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=emFTwdbhfJ2ShCITolW8giMz/g85BaR1blQHMfaFnpM=;
	b=fJtLZ6WEmQ0VKLALP4BILt4gaEofrkAZ//D5JySq1WOXJt75Qrmxb35zZYEj5Cp/O0rpzw
	GyGD2ST/RjWlV/SvWCdPlFDdtrpQUyVjkHoqGylkpB5NJiVqeZZMzbTkVmpmKn7QtslLYF
	qO364FvKDkR5qBKnxFENViUcpR+yPgE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-_wR9vqtJMoKnW88JyhkuWw-1; Mon, 29 Jul 2024 05:36:54 -0400
X-MC-Unique: _wR9vqtJMoKnW88JyhkuWw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b95c005dbcso6999926d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245813; x=1722850613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emFTwdbhfJ2ShCITolW8giMz/g85BaR1blQHMfaFnpM=;
        b=IcvDQh3q3xliz627Ltbf8qfq89dNk3p4zTZIemLCnUBpmn58QOzSr/ApNgIZVqlrm/
         7Bwl+YvKiHCdv+9OPQuVRSKcdt9FixSH6lRmRevR0XbFkRtzoBAMHU0j5Gqw35QtxC8B
         V5QrW5ZVhHWLrQ9pd/aYAzI/S/j9tu6oRCEaJb6h8e4gM77Iyy1Q99p6cTJ6q0EvH58y
         4621lxD6geQWSyx1lnoLYYJOU5UHuQNtslFaCP14JItTJHN1LffrD3ilbzEcPfWC5Beu
         qmyTKvBWLuOQjoNUv+6V9twnhmelbTWA/EGNHr6UHsSwz4LtzqmNX4oCH99ywqsuii60
         bGVA==
X-Forwarded-Encrypted: i=1; AJvYcCUOtN1+xIUg/+k3EZTQgt71BZwGBHvgWF4wSEpQyBubk0/iE24T/tR5g5JygC3/e9CfwhN4t2ju7uvoXFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymFawh9iJkOULolNbugpPFnSRvdX6VxNS1K3/7t0wGn6PUDACG
	GEPtq5uwzaJUGt9Jh4cWjltA3jfoakYekMJ3kM03iiiZ5fRsaso3fKMlBHjV9ejUJTVazzLBHvG
	e9/h/kBJKsMHCcWMaCD6lISDd07ZzcC/c0oY8tjUQi3fyTMwct4w94tlFbLq17g==
X-Received: by 2002:ad4:5ccd:0:b0:6b2:af3c:f710 with SMTP id 6a1803df08f44-6bb3e1a8f83mr85445056d6.2.1722245813574;
        Mon, 29 Jul 2024 02:36:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4gc3YQkLtpxEMrgaDxCfFPgN8uoswS+Zv8SfLImnsVcyFRGniiKYT5wxqKdMycWiPyBs5IQ==
X-Received: by 2002:ad4:5ccd:0:b0:6b2:af3c:f710 with SMTP id 6a1803df08f44-6bb3e1a8f83mr85444936d6.2.1722245813183;
        Mon, 29 Jul 2024 02:36:53 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94a16sm50047086d6.86.2024.07.29.02.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:36:52 -0700 (PDT)
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
Subject: [PATCH 0/2] Use pcim_request_region() in vboxvideo
Date: Mon, 29 Jul 2024 11:36:24 +0200
Message-ID: <20240729093625.17561-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

Now that we've got the simplified PCI devres API available we can slowly
start using it in drivers and step by step phase the more problematic
API out.

vboxvideo currently does not have a region request, so it is a suitable
first user.

P.

Philipp Stanner (2):
  PCI: Make pcim_request_region() a public function
  drm/vboxvideo: Add PCI region request

 drivers/gpu/drm/vboxvideo/vbox_main.c | 4 ++++
 drivers/pci/devres.c                  | 1 +
 drivers/pci/pci.h                     | 2 --
 include/linux/pci.h                   | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.45.2


