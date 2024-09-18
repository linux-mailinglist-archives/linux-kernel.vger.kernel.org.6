Return-Path: <linux-kernel+bounces-332433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A431A97B99F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520F91F213A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4138E176ACA;
	Wed, 18 Sep 2024 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="lFp9Qhxd"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486FDF6C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649649; cv=pass; b=GOSTYxxPaTI4ifRohZjYi4jmxirgG2KihtCo1PKozETXO7wHMXG+c9fJJR5z5IIfXchbSlmqqF9TaTw8UCBkh7H2Hg7mJnVyd3kG+YQ2Px0f+VTbJYRWWpV/TcbAawmLbLkON0UogyCsjlWex8aO7o4RWBUAhFszQlRATLt0ZVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649649; c=relaxed/simple;
	bh=0SawwBJlI7882xIQ7/W8p16aKacTpfmwEj4cIAQUSyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1jGG+J0V9pBQFL94lZBV87zSEejxfJDWLpkkMFQ8tk+3E7LR2wrRexB0ZYbw9YvxZx62XwNVh298qiD8ZflZbWeBV/+0fXgu9MH9HyEftBaLguh8p7mnYWQNklvOfLMjogByoVg4lpaCeQpRUPZ0hUlrSiFzF7nA3+s4e/KjG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=lFp9Qhxd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726649641; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iQSh8PfxDJSm9lj3UHXbZjd1Bcj/t+L1ARXiszmu8urR0MP0sYp/miFjIS4kDJQc3bsC2P4gCBqr6N/jMWr1yaTssnoXO+B/Gx1GxCwRpOSDgFpNRkudlBtKbkTqJ6NWshUzv+rwfUiZrv+h+o0AmWYmxnkSzTfL7PG98xKBGLo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726649641; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FXUAv8aO/iNDJnUmfdDpvAEljxvfwHBmpqsS/FErEzE=; 
	b=YVAH0oTPLUixohmdbbxAknGVgp1epSRPirQU7CUg4trORfYFjy95i2WXmwBoJ0ybs1bWc8l23nmbrHxYBYqgG8O0k1FIxsBLgNNTKI5ogrYeNpLdiaQhZpfRZLA7J4xQd3iI6l7KfLtl/c9nE5DLB5th7/OYya9+by3mtbeErL0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726649641;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FXUAv8aO/iNDJnUmfdDpvAEljxvfwHBmpqsS/FErEzE=;
	b=lFp9QhxdOC2tWXhBJQ3BeTMLGRRSjkPerl2vPpFO0ioRxTp2fk9M1yTI+4AOFbK4
	SlQo9wpoJCHLRoOoWHTOjO8sMh/yP7W1PhjpChqY5skqeNXH9EuYvgitm9UggCR7kpT
	U0BdEbJRaLERYk8yFgw7WWraC2jyzappjMexONBQ=
Received: by mx.zohomail.com with SMTPS id 1726649639948432.64678799221724;
	Wed, 18 Sep 2024 01:53:59 -0700 (PDT)
From: Mary Guillemard <mary.guillemard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christopher Healy <healych@amazon.com>,
	kernel@collabora.com,
	Mary Guillemard <mary.guillemard@collabora.com>
Subject: [PATCH 0/2] drm/panthor: Expose scheduler groups info in debugfs
Date: Wed, 18 Sep 2024 10:50:54 +0200
Message-ID: <20240918085056.24422-2-mary.guillemard@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This patch series adds a new debugfs file named "sched_groups" allowing
a user to query information about all userspace clients scheduler groups.

This patch series assumes that [1] and [2] are applied.

[1]https://lore.kernel.org/all/20240903144955.144278-2-mary.guillemard@collabora.com/
[2]https://lore.kernel.org/all/20240909064820.34982-2-mary.guillemard@collabora.com/

Mary Guillemard (2):
  drm/panthor: Add csg_priority to panthor_group
  drm/panthor: Expose scheduler groups info in debugfs

 drivers/gpu/drm/panthor/panthor_drv.c   |   1 +
 drivers/gpu/drm/panthor/panthor_sched.c | 145 +++++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_sched.h |   4 +
 3 files changed, 147 insertions(+), 3 deletions(-)

-- 
2.46.0


