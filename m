Return-Path: <linux-kernel+bounces-369887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F5C9A2410
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBC928C443
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6991DE2DE;
	Thu, 17 Oct 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MSKdg10T"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ABF1DE2DC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172214; cv=none; b=HibxylIRjnhLxTAut+dq73ll299ZAL+D0nSkf9HkHNY6G9ElE6E2B9iWX0X6NnkIKqrLSkQjfK4+BfgjXR7lYJSI9OTwnOctIVhKJbSnr1O0N3X8K8WljAMuVVQgrsuRl/QFg2aRQujoiyx23lHAVuF3FTk/poEfR/b9TCafMSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172214; c=relaxed/simple;
	bh=SVNNeOOOE6kU3kap2hv3+VtkDF0BM5c8lDJmBS++fM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4vJJI5Te5XCWshKtb8ypM08kGI+vZaKvntsmWb+XinL2POnI6rqi7LYfmbXpv4ZRI1gLYJY23NplU4lS/L8rl71YgOKxi2pTrnW98A0CKxbvHI2FLwe6ipx52STe6z3GKZGOrxDQGsA2nJ7KGnjn3lkoRnnGy0ZpVUSTmZzC0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MSKdg10T; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F5BE669;
	Thu, 17 Oct 2024 15:34:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729172100;
	bh=SVNNeOOOE6kU3kap2hv3+VtkDF0BM5c8lDJmBS++fM8=;
	h=From:To:Cc:Subject:Date:From;
	b=MSKdg10TcYx64RDHpow2kcNdvSgP8JIBXnzCSwsSDBz9LnJV3f8zf/jiwVvZ4uFcK
	 7HxIulJ2PJjIpNApNdIj5LtrcF4owC0l5MO+B+Tto8Pps51LKQWfq4Oto6JZKQud+w
	 PhsiQC7ieHXCUL8KwJDD0QZZSKFSZOxiDq/4u/YQ=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	kernel-list@raspberrypi.com,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 0/6] staging: vchiq: Further simplify bulk transfer
Date: Thu, 17 Oct 2024 19:06:23 +0530
Message-ID: <20241017133629.216672-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims at further simplifying the bulk transfer code paths.
For each of the bulk transfer modes (blocking, nocallback, callback)
this series tends to reduce the function parameters that are open-coded
in the respective function signatures - helping with easy readability
for the various bulk transfer code paths.

Umang Jain (6):
  staging: vchiq_core: Subsume 'offset' in struct vchiq_bulk
  staging: vchiq_core: Simplify bulk data preparatory functions
  staging: vc04_services: Simplify block bulk transfer code paths
  staging: vc04_services: Simplify (no)callback bulk transfer code paths
  staging: vchiq_core: Simplify bulk transfer queue message function
  staging: vchiq_dev: Drop userdata local pointer

 .../interface/vchiq_arm/vchiq_arm.c           | 55 +++++++++----
 .../interface/vchiq_arm/vchiq_core.c          | 81 +++++++++----------
 .../interface/vchiq_arm/vchiq_core.h          |  9 +--
 .../interface/vchiq_arm/vchiq_dev.c           | 30 ++++---
 4 files changed, 97 insertions(+), 78 deletions(-)

-- 
2.45.2


