Return-Path: <linux-kernel+bounces-576790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFFCA7147B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64665188E36F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F371B3940;
	Wed, 26 Mar 2025 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kt1TsZrP"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB16C1B5EA4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983906; cv=none; b=ewJufPrhgqwky6zJL+sqitepgXOTPAf6IIZI9m7aWJcrFq9gYmcQOvgL6EEicsXYqZRgF+XZrN7KhLbXhKFIZW+HxxRptY9oO5+wE9aHa0mgSFDAB1T6V5vEp36viP5INkjYcai5vQgZrnkcfohlFuhdccdqGfA2MYEp2ZrAg7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983906; c=relaxed/simple;
	bh=o1OW7eMPI7BT9Kuja4q/FC0vO0bwCYy1NuCvSDE5Qag=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=iolj+z9BDnj/2zan0UaKKFE4brAq+0/HrDOApn6hXZmNm0563QAVOGkhnIkuzggH2NGwpOXpvEqrte0COsXKB3rz8MR/54CLj2u9w4vUIV9JN/5WWv8zg+AKZLCykTuNoEmYz/oQ4j/ZS0zMUZXCUgA/ot6FHz/MDFqMBB/WvS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kt1TsZrP; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742983598; bh=11V6Ppzqx37uke9W1v3EMjT5frvAqdD1NpkPS7WBiS8=;
	h=From:To:Cc:Subject:Date;
	b=kt1TsZrPEDQyg5p7UhwVmm95Po8cT+Ti6uCtmbvW5X5Nhn7zuaJuKlEZlL82T2BwD
	 6eMs0w3KMczW+1k5rCAPvMy7JDSuIahCgcsyKigJOoxRgfuh6vDGKyesmQ2K6/wxyO
	 h63bXiBBPj6OhMkVH7mBsH6+KqO5+RpdeHVSYMQQ=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 1A40FA8D; Wed, 26 Mar 2025 18:06:36 +0800
X-QQ-mid: xmsmtpt1742983596t640hwne1
Message-ID: <tencent_08386388426E23693951B6B09D78BF0E2508@qq.com>
X-QQ-XMAILINFO: MKQst53PCfggzNBQsZ5bQi6ShZPnoKO5qX6Ouz5NkULKXT45QLP4IxOVxq2LsD
	 iauNHEUlYuFx4YynfKf1RxBfe74ZLYIgwojAy4GTpEQ+UHrnqw/b5v2jgGq0tNOKyGqa4Y2lyU2U
	 CaiZvlK+0tvUGPnJGVV6HLDvjTtAW8UHLHMPClxfEa5bj6zTDGnaZx7nu4EFgOo16n89XUykUWsx
	 oLZQkG2bG3dl4x1ecNjmWNTsCj8eCaSGfJCQ+Lkzu2x7JqNV5c2LZpiul8Yfu0aavwN1Yh5JqW/u
	 hGH3NpuPOQWIZMN+Q29Oeif5Krv+iNgBn2pw0KkaYD/zaBpP0KEfVKsuTm/WPfmVCIcElbYGKk1w
	 dS0AXTXX+KusbXeIbclk7tYPDrP2UNQs8WMf5jecUmhiY0NPUCJjwJ7Cz1VwzOTEzf+fBpbtBP/B
	 2Dn8/Bizjl18+dwCa1PJeZhK66gqVAK/T7enFW0mW7CSPopHrZqwCWulGF54KCJngE3jYBSHXHjF
	 R/akBSYQgKFYy3wbFJ3790WeTjFI+MxvxL33Tk5Zdv6aLs8i0o26ae3FSe+74hof8rK6xsEOZCsh
	 +gtqXriEPVCvozXpBr/tmoO5xeyWuW1qPho8Nl+QMVY5C9MZTxNE8xMi/f3kJ1MdIqD4e56JCmAG
	 onvAjVvezGcEajpvcK0IFhPdMXcu0fHiixz3S0I1LRVH253rKeFk2uBld+ka4uOt3eFoNP93E29K
	 nJreqAX7juwhMxPMu6VyjD5Zw+UtumuKe4OfIwqD14FNvBFx+Y1tjupCxUgEYxS9rmt+B7i2Fm2v
	 spR3AocO/j185/xYGPlvbe9YBEYiU/PcVtyA+hnaNl28C7k8VYIss1Ndp7RGfWfNpklbNjZob/Ru
	 9OyJ0PoVMHtA0OMqKY1uwuOaqnYTGLkugJYDJExpvY7Se4hkGZn2qzMROr/YKxSaPOzeH+fLVk9C
	 CWmY05CPEHgPa0ZeCyVYURjrzILtGRtCyEK5CwTSt9EjMmZzhih1FVdJlOVRgmrZcURwJsz1TaWu
	 5oLo1mNA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 0/3] nvme: Add sysfs interface for APST configuration management
Date: Wed, 26 Mar 2025 18:06:31 +0800
X-OQ-MSGID: <20250326100634.1319638-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

This series enhances NVMe APST (Autonomous Power State Transition) support by:
1. Adding warnings for PST table allocation failures
2. Exposing APST tables via sysfs for runtime inspection
3. Providing per-controller sysfs interface for APST configuration

The changes allow better visibility and control of power management settings
through userspace tools while maintaining the existing functionality.

Yaxiong Tian (3):
  nvme: Add warning for PST table memory allocation failure in
    nvme_configure_apst
  nvme: add sysfs interface for APST table updates
  nvme: add per-controller sysfs interface for APST configuration

 drivers/nvme/host/core.c  | 24 ++++++++++------
 drivers/nvme/host/nvme.h  |  6 ++++
 drivers/nvme/host/sysfs.c | 59 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 8 deletions(-)

-- 
2.25.1


