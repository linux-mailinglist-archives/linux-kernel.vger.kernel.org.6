Return-Path: <linux-kernel+bounces-196112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 638928D5779
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD58B23E04
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E003613D;
	Fri, 31 May 2024 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAv4bVuh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60780211C;
	Fri, 31 May 2024 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117415; cv=none; b=MLxOteBT3HsRgS8Pm8wlFG/9h84STIbKVDUZlMQmCPHguMZvbO79REfLCPtY3GBxhrUsVZPla9hzZ3vZUCSFQkqWtZ3r7Uat7i3mXmztQBwYeSqrZGVlVQFDzxxCLG0WPM54ZneGXoxOBGmhJWsURmvxxrqZzL5mxcCmEddUSGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117415; c=relaxed/simple;
	bh=4FFFXn5HEKWNE6TaKsVsrPpXEqZHIilUtoahZLs5uK0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LiSpEr9dImm/rc3vCcFLVdXPqbq4L6ofPBJCN/RKiHj0+6z15bVmYzTc7Z8eRZGX8ldCtukqPzAE3eVNsHV/e+1EdgH78sECmAIWeitrkL/KPmJW4Vh4AeNf/OQQPAH/d1hB6bQR43O9WXOrTWb2onnwisNc3KOcTGzdZGNPprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAv4bVuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1854C2BBFC;
	Fri, 31 May 2024 01:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717117415;
	bh=4FFFXn5HEKWNE6TaKsVsrPpXEqZHIilUtoahZLs5uK0=;
	h=From:Subject:Date:To:Cc:From;
	b=FAv4bVuhU7S04E8JTAuJfZnM+i5aDj9+l0q2AKCIIEHUn7dAMtHZAsc22JKIyVs86
	 dlxHA4a5l7XOEx3HaDr4QwFCf9TicanP0ZZOj0bntdP7eV+U3lDC3wklFyjZEqaX1/
	 Q28IviXJRongsWF1xB2k4B/Hbiu7gmKgc3wPrW1LryFrG/rwXMFOou7O87neEhA7lX
	 z4pxurF30Zb/wS/bT5x4c+jewwxNMHuVE/xVrwyYPDW2gzZr9YME5JTnncD8sIoTqW
	 GGDyviHaQaeenu3Y0EVGVbJZjwSiFvDpqIuQPddGLVLSuEIws+R4gVi6ROJ4yBjFvp
	 Ypat0rwPeCZKA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 0/3] of: Reimplement of_(bus_)?n_(size|addr)_cells()
Date: Thu, 30 May 2024 20:03:26 -0500
Message-Id: <20240530-dt-interrupt-map-fix-v1-0-2331d8732f08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN4hWWYC/x2MSQqAMAwAvyI5G2jcQL8iHqpGzcFa0iqC+HeLx
 xmYeSCwCgfosgeULwlyuASUZzBt1q2MMieGwhSVqUuDc0RxkVVPH3G3Hhe5sWmrhgyNVLYEKfX
 KSf/bfnjfD+WLifBmAAAA
To: Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14-dev

This series reworks the of_(bus_)?n_(size|addr)_cells() functions. They 
fail to hold the DT spinlock while accessing 'parent' pointer and don't 
hold a reference to the parent node. Neither is likely a real issue as 
most nodes are static.

With these issues fixed, we can then replace the open coded version in 
of_irq_parse_raw().

This series depends on the fixes from this series[1].

Rob

[1] https://lore.kernel.org/lkml/20240529-dt-interrupt-map-fix-v2-0-ef86dc5bcd2a@kernel.org/

---
Rob Herring (Arm) (3):
      of: Add an iterator to walk up parent nodes
      of: Add missing locking to of_(bus_)?n_(size|addr)_cells()
      of/irq: Use of_bus_n_addr_cells() to retrieve "#address-cells"

 drivers/of/base.c  | 18 ++++++++----------
 drivers/of/irq.c   | 15 +++------------
 include/linux/of.h |  5 +++++
 3 files changed, 16 insertions(+), 22 deletions(-)
---
base-commit: e7985f43609c782132f8f5794ee6cc4cdb66ca75
change-id: 20240530-dt-interrupt-map-fix-6946101b1391

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>


