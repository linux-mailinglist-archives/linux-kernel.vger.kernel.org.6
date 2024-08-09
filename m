Return-Path: <linux-kernel+bounces-281479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DA094D75E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B631C21F81
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982A015FA6D;
	Fri,  9 Aug 2024 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tExPOYAC"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64C101E6
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232184; cv=none; b=uiY2EBuyYOaWR6vgLvfF7i8XwB9nkietVkVpRGEWNeMn4NqzsrrFiqog13ck4XcilV5R/aAo/2lEnlXH851230gMQgaaIDjhkV4JGG5K3tc2oexM6whQTZfcK3osmx9+jsefcBDZOVXWuy8ii+N5JRqDn7gJaLbNAjdr0Siiytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232184; c=relaxed/simple;
	bh=IvEM3IByNOlRptzuVxeOrxlx8kaKG7dKBCo6nb1BZEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GrKfVty/PUGzXTpXUsRFzN3yTtHZy73pc1EZ4T3aYTPdfzwj7AlGEOTj9EPhGglmSh6WLfLqNY+TkRKzGozc3245yd0i9OPS/meTuNNyFAlWGkOpUGdqSTWsBCh11z0W2j9Aphs+GwWgYfy7Qms8zH/ZCz8bcEmPwp6Yi8HiXhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tExPOYAC; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723232178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vk1e8ARA15dU1QMhgPg8BifClY0riAbfm4/wBOVvjHE=;
	b=tExPOYACOBawkQZEDsycZHtynFdqegGNMn4fZ2p4PB7TsFWLcKDzPs6uMaJzPHsHm8HFbg
	MKyEducQ3JfmjLzZiZ+6mrAL3kWfXdjyTaMQPXtUjvOGcw0GblFCHeFhCO++PKdXf1gaYZ
	mvd4aQiJz1wSzBn3nw8+06iiaxFimoU=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	David Airlie <airlied@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v6 0/8] drm: zynqmp_dp: IRQ cleanups and debugfs support
Date: Fri,  9 Aug 2024 15:35:52 -0400
Message-Id: <20240809193600.3360015-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series cleans up the zyqnmp_dp IRQ and locking situation. Once
that's done, it adds debugfs support. The intent is to enable compliance
testing or to help debug signal-integrity issues.

Previously, I discussed converting the HPD work(s) to a threaded IRQ. I
did not end up doing that for this series since the steps would be

- Add locking
- Move link retraining to a work function
- Harden the IRQ
- Merge the works into a threaded IRQ (omitted)

Which with the exception of the final step is the same as leaving those
works as-is. Conversion to a threaded IRQ can be done as a follow-up.

Changes in v6:
- Unplug DRM device before removal
- Fix hang upon driver removal
- Rebase onto drm-misc/drm-misc-next

Changes in v5:
- Rebase onto drm-misc/drm-misc-next

Changes in v4:
- Rebase onto drm/drm-next

Changes in v3:
- Convert to a hard IRQ
- Use AUX IRQs instead of polling
- Take dp->lock in zynqmp_dp_hpd_work_func

Changes in v2:
- Split off the HPD IRQ work into another commit
- Expand the commit message
- Document hpd_irq_work
- Document debugfs files
- Add ignore_aux_errors and ignore_hpd debugfs files to replace earlier
  implicit functionality
- Attempt to fix unreproducable, spurious build warning
- Drop "Optionally ignore DPCD errors" in favor of a debugfs file
  directly affecting zynqmp_dp_aux_transfer.

Sean Anderson (8):
  drm: zynqmp_kms: Unplug DRM device before removal
  drm: zynqmp_dp: Add locking
  drm: zynqmp_dp: Don't retrain the link in our IRQ
  drm: zynqmp_dp: Convert to a hard IRQ
  drm: zynqmp_dp: Use AUX IRQs instead of polling
  drm: zynqmp_dp: Split off several helper functions
  drm: zynqmp_dp: Take dp->lock in zynqmp_dp_hpd_work_func
  drm: zynqmp_dp: Add debugfs interface for compliance testing

 Documentation/gpu/drivers.rst     |   1 +
 Documentation/gpu/zynqmp.rst      | 149 ++++++
 MAINTAINERS                       |   1 +
 drivers/gpu/drm/xlnx/zynqmp_dp.c  | 846 ++++++++++++++++++++++++++++--
 drivers/gpu/drm/xlnx/zynqmp_kms.c |   2 +-
 5 files changed, 951 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/gpu/zynqmp.rst

-- 
2.35.1.1320.gc452695387.dirty


