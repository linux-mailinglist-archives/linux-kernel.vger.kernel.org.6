Return-Path: <linux-kernel+bounces-411030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1129CF1F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D6E28F285
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2095F1D63E4;
	Fri, 15 Nov 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rM1bh9Ln"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6631D517F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688979; cv=none; b=qnrIWZqy6D0jAKjn3RGAgiYm2Xqw34abMcJPdwG+WW7QIkdbm2T6V4shCdEdfLUy7a0m4SeN2MxBmgxedfg08V0HuJ9GjaqWe/t1G7p/bSGglLs7TJWkfUI3VeqEp76mScOgxyEC+oLBkVd+u5Ogf9xEZpBXpNCmcahCOmK8qR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688979; c=relaxed/simple;
	bh=hJ9QYV2YJugwaoLfwpCLbKKK0BXWKG5tP4m5cgLWlhA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nwUAzUq+wXfguXu9ZRGiuzSxvtXLmNW6wU/fJLBDyeeAig9xJSV1gEzTxJPEXLQC4WpfVi+5pyj1nxmNQmLnEUwVfrSP6O5rnu0zvqVVDgb7DtSaAoVRevWDbvEnAiTSRzKj3lkDuYmjWqMnhjW20SstvhnvTy+32nIkUosHpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rM1bh9Ln; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731688975;
	bh=hJ9QYV2YJugwaoLfwpCLbKKK0BXWKG5tP4m5cgLWlhA=;
	h=From:Subject:Date:To:Cc:From;
	b=rM1bh9Ln18WBghK0TTRxJ1eAhC8GJFx3SSnPWlYhpzT3FvcHIx+wbwN6OhSfAjXW5
	 fmgWN+LwVgcZqGtgXPauWnNaAH2A2r+JjNt/Sr7xXVuWucEAxe9VDhiGtVZJHMOUR7
	 fH1tlqXtmKrV0tACHF3vhL/M0/Xm5ChOvtMUAJSY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] sysfs: attribute_group: allow registration of const
 bin_attribute
Date: Fri, 15 Nov 2024 17:42:47 +0100
Message-Id: <20241115-b4-sysfs-const-bin_attr-group-v1-0-2c9bb12dfc48@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAd6N2cC/23NQQ6CMBCF4auQWTtJ24xSuYohhMKA3RTsFKIh3
 N0GFm5c/m/xvg2Eo2eBqtgg8urFTyGHvhTQPdswMvo+NxhlSGtN6AjlI4NgNwVJ6Hxo2pQijnF
 aZlSutMRledVEkD/myIN/H/+P+uzIryUz6Rx/SlUchjL2P9AqZe83srpXrloN1Pv+BXF/Xia+A
 AAA
X-Change-ID: 20241114-b4-sysfs-const-bin_attr-group-0b784e775144
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731688975; l=1570;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hJ9QYV2YJugwaoLfwpCLbKKK0BXWKG5tP4m5cgLWlhA=;
 b=rmrPKcMfZioHql+AOJizVANYpStFLop7CICtfGJBxtB5oMR4kPzTUqBx8WCJKs+uZmivOZK64
 sLv+8gD6+fQBQExqO2WUuZ1JsLbDABrgDjL1+IdctAJs1OQ0r1MztiN
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

A small addition to the sysfs bin_attribute constification preparation.
While it's very late, it would be great if this could make it into 6.13
at it would speed up the tree-wide conversion process.

Based on driver-core/driver-core-next .

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      sysfs: attribute_group: allow registration of const bin_attribute
      driver core: Constify bin_attribute definitions

 drivers/base/node.c     |  8 ++++----
 drivers/base/topology.c | 36 ++++++++++++++++++------------------
 include/linux/sysfs.h   |  5 ++++-
 3 files changed, 26 insertions(+), 23 deletions(-)
---
base-commit: 369a9c046c2fdfe037f05b43b84c386bdbccc103
change-id: 20241114-b4-sysfs-const-bin_attr-group-0b784e775144
prerequisite-change-id: 20241028-sysfs-const-bin_attr-a00896481d0b:v2
prerequisite-patch-id: 3173126c01d3db719968b1dc25fbe44ec47215e5
prerequisite-patch-id: c3333053bd7fe677c526715dc6f88d5a7d863e04
prerequisite-patch-id: ae580d9ecb858d8c236a33f272708cac22a7bd9c
prerequisite-patch-id: 1f4297cf4707d54a1da28cd7dbe469590997bd53
prerequisite-patch-id: f5733e7d3f85bb2814cb803fbab68ad8cba316fd
prerequisite-patch-id: bfb9e4123f5e6e5aef82981552839b02cc2edc4a
prerequisite-patch-id: b0f61ee928efc513c42a157e4903e874d52bc57c
prerequisite-patch-id: 5e636e5921603f3c9f4855a4041442396893562e
prerequisite-patch-id: 81e7e41f68a963066675a5a5f669ded9d6485aa8
prerequisite-patch-id: 884429fbd146708c15464a007546dffafe51d060

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


