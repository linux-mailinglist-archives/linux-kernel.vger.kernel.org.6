Return-Path: <linux-kernel+bounces-441779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 239219ED40B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDEB188918B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C273F20127E;
	Wed, 11 Dec 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Bzwgq3wp"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7201FF1DF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939430; cv=none; b=tzGGXNpOIKQ/pmEy+cw01aPqOqmy5y5NyNvVgdj65UB/WR2B7iAl1n7uNK/fmoEEs7p+NItXXC+ycZN6zw82iXheQtRXvKL8Cmwp+sDX3bA9g/AyTOchjtuDlHs9kpuvBDHMch51HnnWiJhdsri/08vZDcHwoF7/9uPxr1q4lq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939430; c=relaxed/simple;
	bh=gCshOuex8SJliOrh0urL/aCjLNb9s/VRtjJS067278c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Kuh9P0TS2YJNI+d6kbCiiSJIot28yIeBpvVJVK+DTMCCdYXp44svqk93KMCx8OcqR9HFD0QbS9doDpT5E32kmzmO78cY1IW0kGhiAjc5I6VQfk0V3OB0J+xokrtznJDwfM5Z1ZxNjbsV9K+2wq0XQPUpaNbf0T5ekFZiWqGq7AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Bzwgq3wp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939418;
	bh=gCshOuex8SJliOrh0urL/aCjLNb9s/VRtjJS067278c=;
	h=From:Subject:Date:To:Cc:From;
	b=Bzwgq3wpywRKBzS6zE7Kj0ven7PP/oVZsVr50vrb88EgwD3coRgfSB46zEvbPwbHH
	 DEF5r68RcPMklsSYUhBF208JdoKqoxxL+vHipSx2nqKAABE7C3IUwgvbN0R3l0nFfj
	 MS/TCmUFZzXIJggx/JI622VH6X8HrU7giFkLPyXc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 00/12] w1: Constify 'struct bin_attribute'
Date: Wed, 11 Dec 2024 18:50:15 +0100
Message-Id: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANfQWWcC/x3MQQqEMAxA0atI1hMwrSB6FZGh1VSzqdIUZ0S8u
 8XlW/x/gXISVuirCxIforLFAvpUMK0uLowyF4OpTUOGCPXUoDhtUTN6iV+Xc8IfYWtbN3sbbMc
 1lHpPHOT/nofxvh+EBZ1zaQAAAA==
X-Change-ID: 20241211-sysfs-const-bin_attr-w1-737adb3f39e0
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939417; l=1782;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=gCshOuex8SJliOrh0urL/aCjLNb9s/VRtjJS067278c=;
 b=q2OoCiInTHQJ6h/NT1J0wWC8o8Q2sovGle8VfQ8PhWnUNleel0/6ZYevONTer3PjD5yxK5U7I
 mZZ/jv38RICBrcGz9emOZpfRxCwXQCa5ggqeOUqSVRuxXf4/JJda3pj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (12):
      w1: Constify 'struct bin_attribute'
      w1: ds2406: Constify 'struct bin_attribute'
      w1: ds2408: Constify 'struct bin_attribute'
      w1: ds2413: Constify 'struct bin_attribute'
      w1: ds2430: Constify 'struct bin_attribute'
      w1: ds2431: Constify 'struct bin_attribute'
      w1: ds2433: Constify 'struct bin_attribute'
      w1: ds2438: Constify 'struct bin_attribute'
      w1: ds2780: Constify 'struct bin_attribute'
      w1: ds2781: Constify 'struct bin_attribute'
      w1: ds2805: Constify 'struct bin_attribute'
      w1: ds28e04: Constify 'struct bin_attribute'

 drivers/w1/slaves/w1_ds2406.c  | 10 +++++-----
 drivers/w1/slaves/w1_ds2408.c  | 42 +++++++++++++++++++++---------------------
 drivers/w1/slaves/w1_ds2413.c  | 14 +++++++-------
 drivers/w1/slaves/w1_ds2430.c  | 10 +++++-----
 drivers/w1/slaves/w1_ds2431.c  | 10 +++++-----
 drivers/w1/slaves/w1_ds2433.c  | 24 ++++++++++++------------
 drivers/w1/slaves/w1_ds2438.c  | 34 +++++++++++++++++-----------------
 drivers/w1/slaves/w1_ds2780.c  |  8 ++++----
 drivers/w1/slaves/w1_ds2781.c  |  8 ++++----
 drivers/w1/slaves/w1_ds2805.c  | 10 +++++-----
 drivers/w1/slaves/w1_ds28e04.c | 18 +++++++++---------
 drivers/w1/w1.c                | 12 ++++++------
 12 files changed, 100 insertions(+), 100 deletions(-)
---
base-commit: f92f4749861b06fed908d336b4dee1326003291b
change-id: 20241211-sysfs-const-bin_attr-w1-737adb3f39e0

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


