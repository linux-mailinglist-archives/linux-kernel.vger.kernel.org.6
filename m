Return-Path: <linux-kernel+bounces-362736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC6799B8CC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 10:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA3D1F214C9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 08:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E8D13AD03;
	Sun, 13 Oct 2024 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="g/9jpnTc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6832AE8A
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728809141; cv=none; b=gBPQzE8/feVTB7ex2eOUv/kWNpa/I9LGr5lu9LnmeEktRLlMVDKWCp+GQ/mypiTrdXQDhr7EVjr0JLMdmRKGuMDjvb7F2NWKs2q482iL+11tp8XggzP6yRJZY2lscyl0muFuZxT6HOTg6D5dqaGx3dSQ2sx2rr4/UuNzFovqNqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728809141; c=relaxed/simple;
	bh=iv2LvBNSybKevxYTDoiPQp2Auu8t0c5BbX3uggsjGAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcXjTDvZtU9zXe1IPw5lJNGN/RT5FGxikJyPaGoTcPbpC9GSZ/z45zadHTB47BJqK3eESFhX+3lmJ4aEUdmlqXuPtVpTtRDUkdvsDRiRGkxS7ReTcy9UUJjTzT3usttZJDyBxvH2UUVDC+kY/yeCFXrcNWPoww0K/Lp7LGdIuc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=g/9jpnTc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5DC774CE;
	Sun, 13 Oct 2024 10:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728809037;
	bh=iv2LvBNSybKevxYTDoiPQp2Auu8t0c5BbX3uggsjGAA=;
	h=From:To:Cc:Subject:Date:From;
	b=g/9jpnTct+Wb2+JQATCXi8L8M5r9bOYnh9/WIh5sZFBItfXK3jPdK089nB6+ZL7kG
	 1/paj3aJNhjsYhjb0y2qSAume2Hs0hacc+CYTrhUrQLIRhyHONBrFIfLg/pX7yTDHY
	 vQmS7U4EttRLm60Z73z0HlpUnEUSwYVHbPF7CbLQ=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 0/2] staging: vchiq_arm: Fix drv_mgmt leak
Date: Sun, 13 Oct 2024 14:15:27 +0530
Message-ID: <20241013084529.377488-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1/2 is a drive by fix.
2/2 uses devres resouce management helper devm_kzalloc() to auto-free
struct vchiq_drv_mgmt on error and .remove() paths.

It might be good to aware the devres issue and following talk might
give reviewers a helpful context:

- https://lpc.events/event/16/contributions/1227/
- https://archive.fosdem.org/2023/schedule/event/devm_kzalloc/

I am not totally sure if these problems, causes a blockers for these
patches. There are a couple of memory management issues I've spotted
which can be fixed? by devres (similar to this series) but probably I
will wait for initial feedback on this series.

Umang Jain (2):
  staging: vchiq_arm: Drop blank lines
  staging: vchiq_arm: Use devm_kzalloc for mgmt

 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

-- 
2.45.2


